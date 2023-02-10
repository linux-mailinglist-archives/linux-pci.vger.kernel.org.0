Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF186929ED
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjBJWRq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjBJWRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:17:45 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172B4FC20;
        Fri, 10 Feb 2023 14:17:43 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5A9532808FCC2;
        Fri, 10 Feb 2023 23:17:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 41C43CC5C9; Fri, 10 Feb 2023 23:17:42 +0100 (CET)
Date:   Fri, 10 Feb 2023 23:17:42 +0100
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
Subject: Re: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
Message-ID: <20230210221742.GA15075@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
 <20230124110127.00001de0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124110127.00001de0@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 24, 2023 at 11:01:27AM +0000, Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 11:14:00 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > A synchronous API for DOE has just been introduced.  Convert CXL CDAT
> > retrieval over to it.
> 
> The clean up here gives opportunities for 'right sizing' at least
> the response to reading the header. The others are harder was we
> don't know what each one is going to be.
> May make more sense as a follow on patch though. 

Thy will be done:

https://lore.kernel.org/linux-pci/49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de/


> > -		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
> > +		u32 request = CDAT_DOE_REQ(entry_handle);
> > +		u32 response[32];
> 
> As above, this is still a bit random.
> Things we might be reading.
> DSMAS: 6 dword
> DSLBIS: 6 dword
> DSIS: 2 dword
> DSEMTS: 6 dword
> SSLBIS: 4 dword + 2 * entires dwords.  This can get huge - as
> can include p2p as well as the smaller usp / dsp set.
> 
> Right now we aren't reading from switches though so we can fix
> that later (I posted an RFC for switches ages ago, but haven't
> gotten back to it since then)
> 
> So for now probably leave this one at the 32 dwords.

I found a way to avoid a response buffer altogether.

Thanks,

Lukas
