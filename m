Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF269911D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBPK0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPK0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:26:20 -0500
X-Greylist: delayed 81436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 02:26:18 PST
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AAC10A9F;
        Thu, 16 Feb 2023 02:26:18 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D17D03000A0BD;
        Thu, 16 Feb 2023 11:26:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BBEFD290CC; Thu, 16 Feb 2023 11:26:16 +0100 (CET)
Date:   Thu, 16 Feb 2023 11:26:16 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 04/16] cxl/pci: Handle excessive CDAT length
Message-ID: <20230216102616.GA13347@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
 <20230214113311.00000825@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214113311.00000825@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 11:33:11AM +0000, Jonathan Cameron wrote:
> On Fri, 10 Feb 2023 21:25:04 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > If the length in the CDAT header is larger than the concatenation of the
> > header and all table entries, then the CDAT exposed to user space
> > contains trailing null bytes.
> > 
> > Not every consumer may be able to handle that.  Per Postel's robustness
> > principle, "be liberal in what you accept" and silently reduce the
> > cached length to avoid exposing those null bytes.
[...]
> Fair enough. I'd argue that we are papering over broken hardware if
> we hit these conditions, so given we aren't aware of any (I hope)
> not sure this is stable material.  Argument in favor of stable being
> that if we do get broken hardware we don't want an ABI change when
> we paper over the garbage... hmm.

Type 0 is assigned for DSMAS structures.  So user space might believe
there's an additional DSMAS in the CDAT.  It *could* detect that the
length is bogus (it is 0 but should be 24), but what if it doesn't
check that?  It seems way too dangerous to leave this loophole open,
hence the stable designation.

Thanks,

Lukas

> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -582,6 +582,9 @@ static int cxl_cdat_read_table(struct device *dev,
> >  		}
> >  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> >  
> > +	/* Length in CDAT header may exceed concatenation of CDAT entries */
> > +	cdat->length -= length;
> > +
> >  	return 0;
> >  }
> >  
