Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56A68946C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBCJy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBCJyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:54:25 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12E70D56;
        Fri,  3 Feb 2023 01:54:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DF6DC300034F1;
        Fri,  3 Feb 2023 10:54:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C60BF2EE13E; Fri,  3 Feb 2023 10:54:18 +0100 (CET)
Date:   Fri, 3 Feb 2023 10:54:18 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
Message-ID: <20230203095418.GA18459@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
 <63cf2bc3cf76_521a294a1@iweiny-mobl.notmuch>
 <c9923e59-176c-2e52-9ebf-58bb25750083@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9923e59-176c-2e52-9ebf-58bb25750083@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 04:53:34PM +0800, Li, Ming wrote:
> On 1/24/2023 8:52 AM, Ira Weiny wrote:
> > Lukas Wunner wrote:
> > >  static int cxl_cdat_get_length(struct device *dev,
> > >  			       struct pci_doe_mb *cdat_doe,
> > >  			       size_t *length)
> > >  {
> > > -	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> > > +	u32 request = CDAT_DOE_REQ(0);
> > > +	u32 response[32];
> > >  	int rc;
> > >  
> > > -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> > > +	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> > > +		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > > +		     &request, sizeof(request),
> > > +		     &response, sizeof(response));
> > >  	if (rc < 0) {
> > > -		dev_err(dev, "DOE submit failed: %d", rc);
> > > +		dev_err(dev, "DOE failed: %d", rc);
> > >  		return rc;
> > >  	}
> > > -	wait_for_completion(&t.c);
> > > -	if (t.task.rv < sizeof(u32))
> > > +	if (rc < sizeof(u32))
> > >  		return -EIO;
> > >  
> 
> Sorry, I didn't find the original patchset email, only can reply here.
> Should this "if (rc < sizeof(u32))" be "if (rc < 2 * sizeof(u32))"?
> Because below code used response[1] directly, that means we need unless
> two u32 in response payload.

Yes I spotted that as well, there's already a fixup on my
development branch:

  https://github.com/l1k/linux/commits/doe

It's in commit "cxl/pci: Handle truncated CDAT header" which is:

  https://github.com/l1k/linux/commit/208f256b319b

...but that URL may stop working as soon as I rebase the next time.

Actually there's a lot more broken here, there are 3 other new fixup
patches at the beginning of that development branch.

Thanks,

Lukas
