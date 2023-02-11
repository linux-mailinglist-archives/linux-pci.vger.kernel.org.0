Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BD693020
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 11:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBKK4e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Feb 2023 05:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBKK4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Feb 2023 05:56:34 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE322004;
        Sat, 11 Feb 2023 02:56:32 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1C1B3102E6622;
        Sat, 11 Feb 2023 11:56:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D459F275D54; Sat, 11 Feb 2023 11:56:30 +0100 (CET)
Date:   Sat, 11 Feb 2023 11:56:30 +0100
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
Subject: Re: [PATCH v3 03/16] cxl/pci: Handle truncated CDAT entries
Message-ID: <20230211105630.GA28226@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <5b4e23f256b3705360d84eccb9652e4b558a77b5.1676043318.git.lukas@wunner.de>
 <63e6e65e5e1f3_1e494329496@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e6e65e5e1f3_1e494329496@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 04:50:38PM -0800, Dan Williams wrote:
> Lukas Wunner wrote:
> > If truncated CDAT entries are received from a device, the concatenation
> > of those entries constitutes a corrupt CDAT, yet is happily exposed to
> > user space.
> > 
> > Avoid by verifying response lengths and erroring out if truncation is
> > detected.
[...]
> > @@ -557,14 +557,19 @@ static int cxl_cdat_read_table(struct device *dev,
> >  			return rc;
> >  		}
> >  		wait_for_completion(&t.c);
> > -		/* 1 DW header + 1 DW data min */
> > -		if (t.task.rv < (2 * sizeof(u32)))
> 
> Ah, I guess that's why the previous check can not be pushed down
> further, its obviated by this more comprehensive check.

The check in the previous patch ("cxl/pci: Handle truncated CDAT header")
fixes response size verification for cxl_cdat_get_length().

The check here however is in a different function, cxl_cdat_read_table().
Previously the function only checked whether the DOE response contained
two dwords.  That's one dword for the Table Access Response header
(CXL r3.0 sec 8.1.11.1) plus one dword for the common header shared
by all CDAT structures.

What can happen is we receive a truncated entry with, say, just
two dwords, and we copy that to the cached CDAT exposed in sysfs.
Obviously that's a corrupt CDAT.  The consumer of the CDAT doesn't
know that the data was truncated and will try to parse the entry
even though the data may actually be a portion of the next entry.

The improved verification here ensures that the received amount of
data corresponds to the length in the entry header.

It is up to the parsing function of each entry to verify whether
that length is correct for that specific entry.  E.g. a DSMAS entry
should contain 24 bytes, so the parsing function needs to verify
that the length in the entry header is actually 24.  (See the e-mail
I sent to Dave a few minutes ago.)

Thanks,

Lukas

> > +		/* 1 DW Table Access Response Header + CDAT entry */
> > +		entry = (struct cdat_entry_header *)(t.response_pl + 1);
> > +		if ((entry_handle == 0 &&
> > +		     t.task.rv != sizeof(u32) + sizeof(struct cdat_header)) ||
> > +		    (entry_handle > 0 &&
> > +		     (t.task.rv < sizeof(u32) + sizeof(struct cdat_entry_header) ||
> > +		      t.task.rv != sizeof(u32) + le16_to_cpu(entry->length))))
> >  			return -EIO;
