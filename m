Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA157D2C0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiGURux (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGURuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 13:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F52820CF
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 10:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0890261F4C
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 17:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD90C3411E;
        Thu, 21 Jul 2022 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658425850;
        bh=HephI6OWy0S/ktm7sOm+OWAXZsto5uNW3Zm7dLyxOIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rK/vN/2xKTqIjdIZC6eLw6yrGvsM9uh6prUURzdTBNt4/8UKvxQ/J3dKr4e75DcYm
         4U/ezJnj8oleeEpwFS6X6wmcyS8TDPcZEfTv4V5XMbf8wWUXHmdUZKtWsu3CYqktw/
         p9gK0CsibbzLlHnBaBelxafWfGCRtXpYn4STtmHBkZMxElWq0qyOpZpFXijqLeXvso
         36GJkbKDvqgCZi9BsHzVHNYUTFVN4u+tAREAeSEN9Mqa/GdX1AsUmHpQujYCAGF7GC
         CmjjuCSSw63vGUcN3u6OlHq97qXPvJYXfZWHnaTlJaSgKd0oKlvHlQ8YRkv7mhTV/F
         DPCkaI6+03keg==
Date:   Thu, 21 Jul 2022 12:50:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20220721175048.GA1738677@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H40_o+9KS1t67O98GusM38pDaiB4bssxd3KQZpAByfnLg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 12:47:18PM +0800, Huacai Chen wrote:

> Unfortunately, this patch only lists devices in LS7A1000, but some of
> LS7A2000 (GNET and HDMI) also need to quirk, can they be squashed in
> this patch? If not, we will add them in a new patch.
> 
>  #define DEV_LS7A_CONF  0x7a10
>  #define DEV_LS7A_LPC   0x7a0c
>  #define DEV_LS7A_GMAC  0x7a03
> +#define DEV_LS7A_GNET  0x7a13
>  #define DEV_LS7A_DC1   0x7a06
>  #define DEV_LS7A_DC2   0x7a36
>  #define DEV_LS7A_GPU   0x7a15
>  #define DEV_LS7A_AHCI  0x7a08
>  #define DEV_LS7A_EHCI  0x7a14
>  #define DEV_LS7A_OHCI  0x7a24
> +#define DEV_LS7A_HDMI  0x7a37

I squashed these in.  Let me know if I did anything wrong:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=930c6074d7dd
