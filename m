Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A124EE2F8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiCaU71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiCaU70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 16:59:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8A231AD2;
        Thu, 31 Mar 2022 13:57:38 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 05CD61F472C9;
        Thu, 31 Mar 2022 21:57:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648760257;
        bh=qu8uGfxvsqyjsB+qjvj/7fnnsJDoC3wsC1SGICrkIeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LREPsEu7Jj9430edqjtffP36AoLMA0S20yXP7KcLc9/DaibMLiQkSBESYK7kFQiM4
         FhS2t0mxdxq/joRhmM6gxfNTmuEtlheuHjwHd7fDsMEsupBGVtm1VS08jUeyP3h7Dw
         21OORuhqynHk6ymXJK9y9Tn4ykl8Ye6BJoTy3IZbkE8HFB8iPgzflFfsjiqDkfxXCW
         3ULZPRnlw8XPW5rg2OEMFejDvS35GwMz092TNbmLcUmf3nx/1zIWXllj3XgN31xV96
         1W1xt2xvupY1hZyfUQrnn4lejBWXPwhiVim4MIqqfMf5w/DOOW3OBcsviC1aiGWW0Y
         wZlHwOxpRClKQ==
Message-ID: <34c64163-d1c8-22b5-1766-3e7493ad306b@collabora.com>
Date:   Thu, 31 Mar 2022 23:57:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/5] x86/PCI: Add $IRT PIRQ routing table support
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Nikolai Zhubr <zhubr.2@gmail.com>,
        Michal Necasek <mnecasek@yahoo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
 <alpine.DEB.2.21.2203302228410.9038@angie.orcam.me.uk>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <alpine.DEB.2.21.2203302228410.9038@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/31/22 10:11, Maciej W. Rozycki wrote:
> Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP 
> (BIOS Configuration Program) external tool meant for tweaking BIOS 
> structures without the need to rebuild it from sources[1].
> 
> The $IRT format has been invented by AMI before Microsoft has come up 
> with its $PIR format and a $IRT table is therefore there in some systems 
> that lack a $PIR table, such as the DataExpert EXP8449 mainboard based 
> on the ALi FinALi 486 chipset (M1489/M1487), which predates DMI 2.0 and 
> cannot therefore be easily identified at run time.
> 
> Unlike with the $PIR format there is no alignment guarantee as to the 
> placement of the $IRT table, so scan the whole BIOS area bytewise.
> 
> Credit to Michal Necasek for helping me chase documentation for the 
> format.
> 
> References:
> 
> [1] "What is BCP? - AMI", <https://www.ami.com/what-is-bcp/>
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: Michal Necasek <mnecasek@yahoo.com>
> ---
> Changes from v3:
> 
> - Correct the BIOS memory scan such as to verify that the PCI IRQ Routing
>   Table header as well as individual slot entries are all wholly contained 
>   within the BIOS memory area.
> 
> - Following commit 5224f7909617 ("treewide: Replace zero-length arrays 
>   with flexible-array members") also make `slots' in `irt_routing_table' a 
>   flexible-array member.
> 
> New change in v3.
> ---
>  arch/x86/include/asm/pci_x86.h |    9 ++++
>  arch/x86/pci/irq.c             |   76 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # crosvm
