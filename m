Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8A4ECC6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUQD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 12:03:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:57892 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 12:03:27 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1heM0c-0006zu-2F; Fri, 21 Jun 2019 10:03:26 -0600
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
 <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
 <20190620134712.GI143205@google.com>
 <SL2P216MB018710C0513F97989DCD3A4880E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <7d008368-d358-ede9-215b-1971cbdc2d77@deltatee.com>
 <SL2P216MB018735338F997285B486E28180E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <202a76d1-e90a-954d-9288-92f81b95a521@deltatee.com>
Date:   Fri, 21 Jun 2019 10:03:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <SL2P216MB018735338F997285B486E28180E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, benh@kernel.crashing.org, helgaas@kernel.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-21 12:01 a.m., Nicholas Johnson wrote:
> Thanks for advice. I do believe you are correct. I guess it is my 
> inexperience - I have trouble telling what is normal and what to expect 
> from the process. But I am not feeling like this is any closer to 
> submission than on day one - no sense of progress. It is not reassuring 
> and I do wonder if I will ever manage to get it right.
> 
> None of this is technically Thunderbolt-specific, but that is the use 
> case, and if a single one of these patches does not make it in then the 
> use case of Thunderbolt without firmware support will remain broken. The 
> only benefit of a partial acception is patch #1 which fixes a bug report 
> by Mika Westerberg on its own, so I guess that would be a win. If it has 
> to wait another cycle then I will live with it, but this is the cause of 
> my anxiety.
> 
> I can look at this patch again, but my concerns are the following:
> 
> - If we avoid depreciation, then that implies this patch is ideal - we 
> are not breaking anything for existing users. We can set MMIO on its own 
> with pci=hpmemsize and by setting pci=hpmemprefsize to the default size of 
> 2M (so it remains unchanged).

I disagree. The semantics are weird and the changes to the documentation
show that. When you have to describe things based on what other
parameters are doing, it's weird.

> - If we have two sets of parameters, then we have to support having two 
> sets for eternity, and the loss of minimalism and the potential for 
> confusion. The description in kernel-parameters.txt will become 
> confusing with a lot of "if this" and "if that".

Yes, but they're simple and clear parameters that are easy to support.
There would be no "ifs" at all. One parameter sets one value, another a
parameter sets another, and the original parameter sets both.

> - How do we deal with order if both are specified? It will become 
> unclean.

If a user mixes the "both" with the "single" parameters, the winner goes
to the last that's specified. This is common and predictable. It's not
dissimilar to when a user specifies the same parameter twice.

> - If we make two new ones, then what should they be called? I propose 
> hp_mmio_size and hp_mmio_pref_size from my original submission. Then 
> should hpiosize be aliased to hp_io_size to keep the consistency?

Good question. I'd probably go something along the lines of
'hpmemsize_pref' and 'hpmemsize_nonpref'. Though, it might be good to
get others opinions on this.

> - I am quite surprised that when 64-bit window support was added to the 
> kernel, that this was not done then, although I am not good enough at 
> navigating the mailing list to see what actually happened.

Generally, things won't get done until people have a use case for them
and motivation to make the change. I don't think there's a lot of users
of hpmemsize to begin with.

> Should I perhaps forward my original submission for this patch again and 
> you can see if there is anything to salvage from that that?

Not if you haven't changed anything.

Logan
