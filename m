Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715164379B5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhJVPSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 11:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59239 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhJVPSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 11:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9912B6108D;
        Fri, 22 Oct 2021 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634915787;
        bh=wiFgHiCNaao6QFu/SoYWylfW1z6dGUvm+kPNCPTK+Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoG4peCgxBNKKVHu6yRve/7/A9RVPtqvdQ7jNytlJIe3k8yspk1JcKo7vQlOgfKAm
         uYmbsL168tKdSq1pyrkLcJhMkceVQfMWg0Q1E9vtB9AkaYo0wEj4deNlsTQ229kqH1
         xuBgqsHCZpmdLJnJN6GYnd45Xd6henGoaSLK3xzZXRj8RvdZ5g+10Ofcw76RRefC3l
         Pa6gCzAcCrNrxL8x5lyGm2QYAQ/Vfgd9I3ZFFqYRCw0dFEg0TB5hE+p6CR+80sUWN/
         8ATNOI6ZRersknQG50dhteVW7tjBjLXM4xc6yRz8YmOhrIvRmG2k9Yi/UiKrmxxr44
         BIdDtmgYCTz7Q==
Received: by pali.im (Postfix)
        id D84F37F6; Fri, 22 Oct 2021 17:16:24 +0200 (CEST)
Date:   Fri, 22 Oct 2021 17:16:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset to
 finish
Message-ID: <20211022151624.mgsgobjsjgyevnyt@pali>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
 <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 19 October 2021 07:06:42 Mauro Carvalho Chehab wrote:
> Before code refactor, the PERST# signals were sent at the
> end of the power_on logic. Then, the PCI core would probe for
> the buses and add them.
> 
> The new logic changed it to send PERST# signals during
> add_bus operation. That altered the timings.
> 
> Also, HiKey 970 require a little more waiting time for
> the PCI bridge - which is outside the SoC - to finish
> the PERST# reset, and then initialize the eye diagram.

Hello! Which PCIe port do you mean by PCI bridge device? Do you mean
PCIe Root Port? Or upstream port on some external PCIe switch connected
via PCIe bus to the PCIe Root Port? Because all of these (virtual) PCIe
devices are presented as PCI bridge devices, so it is not clear to which
device it refers.

Normally PERST# signal is used to reset endpoint card, other end of PCIe
link and so PERST# signal should not affect PCIe Root Port at all.

> So, increase the waiting time for the PERST# signals to
> what's required for it to also work with HiKey 970.

Because PERST# signal resets endpoint card, this reset timeout should
not be driver or controller specific.

Mauro, if you understand this issue more deeply, could you look at my
email? https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/

I think that kernel PCI subsystem does not properly handle PCIe Warm
Reset and correct initialization of endpoint cards. Because similar
"random PERST# timeout patches" were applied to lot of native controller
drivers.

PS: I'm not opposing this patch, I'm just trying to understand what is
happening here and why particular number "21000" was chosen. It is
defined in some standard? Or was it just randomly chosen and measures
that with this number is initialization working fine?

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index de375795a3b8..bc329673632a 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -113,7 +113,7 @@ struct kirin_pcie {
>  #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
>  
>  /* Time for delay */
> -#define REF_2_PERST_MIN		20000
> +#define REF_2_PERST_MIN		21000
>  #define REF_2_PERST_MAX		25000
>  #define PERST_2_ACCESS_MIN	10000
>  #define PERST_2_ACCESS_MAX	12000
> -- 
> 2.31.1
> 
