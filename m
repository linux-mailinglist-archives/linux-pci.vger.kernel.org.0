Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18FE697B19
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjBOLtH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 06:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjBOLtG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 06:49:06 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4123659;
        Wed, 15 Feb 2023 03:49:04 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2613A300291F4;
        Wed, 15 Feb 2023 12:49:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 19B2D263F6; Wed, 15 Feb 2023 12:49:01 +0100 (CET)
Date:   Wed, 15 Feb 2023 12:49:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 15/16] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230215114901.GA19157@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <fdb52e091b62b34c2036a61ae9ab8087dba4e4db.1676043318.git.lukas@wunner.de>
 <d3806f93-9d75-5431-142d-1601eb2a1bab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3806f93-9d75-5431-142d-1601eb2a1bab@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 01:05:20PM +0800, Li, Ming wrote:
> On 2/11/2023 4:25 AM, Lukas Wunner wrote:
> > An upcoming user of DOE is CMA (Component Measurement and Authentication,
> > PCIe r6.0 sec 6.31).
> > 
> > It builds on SPDM (Security Protocol and Data Model):
> > https://www.dmtf.org/dsp/DSP0274
> > 
> > SPDM message sizes are not always a multiple of dwords.  To transport
> > them over DOE without using bounce buffers, allow sending requests and
> > receiving responses whose final dword is only partially populated.
[...]
> > +	if (payload_length) {
> > +		/* Read all payload dwords except the last */
> > +		for (; i < payload_length - 1; i++) {
> > +			pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > +					      &val);
> > +			task->response_pl[i] = cpu_to_le32(val);
> > +			pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +		}
> > +
> > +		/* Read last payload dword */
> >  		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > -		task->response_pl[i] = cpu_to_le32(val);
> > +		cpu_to_le32s(&val);
> > +		memcpy(&task->response_pl[i], &val, remainder);
> 
> This "Read last payload dword" seems like making sense only when remainder != sizeof(u32).
> If remainder == sizeof(u32), it should be read in above reading loops.
> But this implementation also looks good to me.

The last payload dword requires special handling anyway because of
the Data Object Ready check (see quoted remainder of the function
below).

Up until now that special handling is done with an if-clause that
checks if the last loop iteration has been reached.

The support for non-dword responses adds more special handling
of the last payload dword, which is why I decided to go the full
distance and move handling of the last dword out of the loop.

Thanks,

Lukas

> >  		/* Prior to the last ack, ensure Data Object Ready */
> > -		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
> > +		if (!pci_doe_data_obj_ready(doe_mb))
> >  			return -EIO;
> >  		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +		i++;
> >  	}
> >  
> >  	/* Flush excess length */
