Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9629B692FC9
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBKJfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Feb 2023 04:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKJe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Feb 2023 04:34:59 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE534F76;
        Sat, 11 Feb 2023 01:34:57 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C87B93000D91A;
        Sat, 11 Feb 2023 10:34:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA64825EDA6; Sat, 11 Feb 2023 10:34:55 +0100 (CET)
Date:   Sat, 11 Feb 2023 10:34:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 02/16] cxl/pci: Handle truncated CDAT header
Message-ID: <20230211093455.GA28981@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
 <63e6e3ef4d84e_1e4943294e6@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e6e3ef4d84e_1e4943294e6@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 04:40:15PM -0800, Dan Williams wrote:
> Lukas Wunner wrote:
> > cxl_cdat_get_length() only checks whether the DOE response size is
> > sufficient for the Table Access response header (1 dword), but not the
> > succeeding CDAT header (1 dword length plus other fields).
> > 
> > It thus returns whatever uninitialized memory happens to be on the stack
> > if a truncated DOE response with only 1 dword was received.  Fix it.
[...]
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -528,7 +528,7 @@ static int cxl_cdat_get_length(struct device *dev,
> >  		return rc;
> >  	}
> >  	wait_for_completion(&t.c);
> > -	if (t.task.rv < sizeof(u32))
> > +	if (t.task.rv < 2 * sizeof(u32))
> >  		return -EIO;
> 
> Looks good, I wonder since this is standard for all data objects whether
> the check should be pushed into the core?

No, "t.task.rv" contains the payload length in bytes of the response
received via DOE.  It doesn't include the DOE header.

I think it is legal to receive an empty response via DOE, so I cannot
push a length check down into the core.

In this case, the payload contains one dword for the Table Access Response
header (CXL r3.0 sec 8.1.11.1), followed by 3 dwords for the CDAT header:

https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf

The CDAT header contains the length of the entire CDAT in the first
dword, hence the above-quoted check only verifies that at least two
dwords were received.  It's harmless if the remainder of the CDAT
header is truncated.

Thanks,

Lukas
