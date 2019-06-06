Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3837984
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfFFQaP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 12:30:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44765 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfFFQaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 12:30:15 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so664587iob.11;
        Thu, 06 Jun 2019 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7LytwrxXouA0Zs6R/AiX1+NNXroNALfB+EP9vrU3ak=;
        b=CqDzhS28zOoXKqAmwZIGxqbShXAuwtqOzzqhggdfQVmXEfeJln82iHfrubi8vmVLfS
         yjJMYT3JBT/pMQKyZwotP9cvg2CPLI8iawIC3LlhyybNGEuMJPBZA+O+H2877aBFuMbL
         fowQ67ZuQZWNM0tESPs5I+ZMat9YSqOm1ldfdSI2UKOfdg6wUiV0O33De7/PxsH5+wSq
         l81xAi7PWhySQ6y27rt+nSwNwEM6scBeWf8/0MdhaHXNE2CqjVBMUTROQtLn9CxfCemq
         GhHxb/tduVEt73Elpc5FUhkGrzq0IKIOwLOF30IDZE9W7sPzQDwCvl53nvNTchjYHmPg
         EScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7LytwrxXouA0Zs6R/AiX1+NNXroNALfB+EP9vrU3ak=;
        b=oZjtX10MbGsBMCbVvrwui4jl2zt3dsNfGaOeozmkNqKShGuk+4ph3bwFZexI/vk2mc
         gL+hp6ykj1UhkBjcdGbPnmvdJA4tRSA8Y7VAH97hQEtEmdy+glFJVM1UD6n30dxBE6M4
         kZixBdK7F9dW3Dov8WTG5mt7lfyd3a6CgxbwD67/0hGRNuqpzGr9EOtUhPQzNBQ91ayD
         8pfK1rNKfxFpEJjEOe84Rjep7IpxqR65bBWVPQBykl7CwJsTGX4b8HbTc8hPU5BgKFAZ
         /pn12b3A5DRUKpd8vM5lq+vWl0/MT7uD9pNnw9fstf/2u25b4VZgOJV3p1bFIJYr+58m
         fxag==
X-Gm-Message-State: APjAAAX174f9/toB1jjcRHvewBTABUqGMBnLyLIp9vHsX3ulynf+2+eD
        6fRAnTcwXx9ulXmVFmjrh/Q=
X-Google-Smtp-Source: APXvYqx6Y2P7X9DmDW6zWXGbATaWZwdPGt54+mRbNR9V0Z0IbrAHa9vJLSmEXZTPLGvVlVq2Z9SkCg==
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr33147282iod.46.1559838614878;
        Thu, 06 Jun 2019 09:30:14 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id c100sm1217734itd.0.2019.06.06.09.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:30:14 -0700 (PDT)
Subject: Re: [PATCH V8 13/15] phy: tegra: Add PCIe PIPE2UPHY support
To:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-14-vidyas@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c81c5d42-4292-ba6d-b5ab-afe1a604115f@gmail.com>
Date:   Thu, 6 Jun 2019 19:30:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526043751.12729-14-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

26.05.2019 7:37, Vidya Sagar пишет:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v7]:
> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-p2u.c
> 
> Changes since [v6]:
> * None
> 
> Changes since [v5]:
> * Addressed review comments from Thierry
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * Rebased on top of linux-next top of the tree
> 
> Changes since [v2]:
> * Replaced spaces with tabs in Kconfig file
> * Sorted header file inclusion alphabetically
> 
> Changes since [v1]:
> * Added COMPILE_TEST in Kconfig
> * Removed empty phy_ops implementations
> * Modified code according to DT documentation file modifications
> 
>  drivers/phy/tegra/Kconfig            |   7 ++
>  drivers/phy/tegra/Makefile           |   1 +
>  drivers/phy/tegra/phy-tegra194-p2u.c | 109 +++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
> 
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index a3b1de953fb7..c56fc8452e03 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
>  
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called phy-tegra-xusb.
> +
> +config PHY_TEGRA194_P2U
> +	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
> +	depends on ARCH_TEGRA || COMPILE_TEST

ARCH_TEGRA is a bit too much, ARCH_TEGRA_194_SOC should fit better here.

-- 
Dmitry
