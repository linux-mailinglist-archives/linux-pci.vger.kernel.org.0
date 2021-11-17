Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31784454C46
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 18:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhKQRot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 12:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbhKQRos (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 12:44:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B4C061570;
        Wed, 17 Nov 2021 09:41:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso5447766wms.3;
        Wed, 17 Nov 2021 09:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BCfxE88dMmtTmPlUzg3IUvh5ugr7FFULc+8pak8LPb0=;
        b=BCm14ce8Vs0eMVI2gdWtYiQECnj71bGwZWcZJpS9BGKFv5+AxNXFXsOR2bs/s2zdKe
         tvuCl5X694tuo9H4oux1UvAseKDkQf0KcVDRROimIHDNAn/ycPxHLm2Vui7/487H4gWc
         sHUdKDk6Lknnr6BENrDbJzTjllK1Swc0RtQW88FEji6BLfBad/9SbRDImkuO/yxjP5gh
         8OEwDYstnbfQ5dX86MISHfO2bXi1ip4OuplO0DHS8AOQ+Rxr0qsbfXfTE5AjW0uh12jj
         bB1Hp3h6jbYJ2G3ilFvHJohUBWmhDPEWy436si26Zx3W4pqjb4BQlR/j6fUb3Wp6fHM2
         3toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BCfxE88dMmtTmPlUzg3IUvh5ugr7FFULc+8pak8LPb0=;
        b=BZBgmbALGkJuXSHnvH2KmfDisdDJdklyBnrM71Vg1HAC0WnAQdSeIhdpPTimFlLHeY
         ohd/4yIYYo5fqgWOm0OglKXxVm2EPsm4/yq24Sl3NkKBBhIz/qIt5cKXaP7djX0lswxw
         PwlShrMF/tXYC1jn1oev5sdutq0cz2icNTC6mSxK0n0Q1/hMsU2ET07kGFo+92f5dNDo
         h/sKkx7IePUMNZEYBVYAAeO1Lf7J/Mv950LsZZ6xQHz0O3hb2ErOlBc3HFE6xGRiUVmG
         4srpYGMMRtO3L2Ivl98Spb96UyRuhPcm7HCSenosk7zTpnnrPCGu1D49M5HYN/p3/HXj
         3CfQ==
X-Gm-Message-State: AOAM532qzRs1v/yHmf7lnRuYPBxSLr6ZHl+1mZ7Bnmr/JqQ/tV/i7UuY
        TqKB+FfT34KUZ/zykLs3S1Q=
X-Google-Smtp-Source: ABdhPJyAsGQK5QkuZFkT7fxQC65+3O/kbaaiGA/+ggsHKzLUwmDhpHaIPb1hpBjY9lHUv2mU/mTPLw==
X-Received: by 2002:a1c:5414:: with SMTP id i20mr1676633wmb.88.1637170907592;
        Wed, 17 Nov 2021 09:41:47 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id p12sm724836wrr.10.2021.11.17.09.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:41:47 -0800 (PST)
Message-ID: <c3630f7f-fb3d-6018-c12a-535e891d535a@gmail.com>
Date:   Wed, 17 Nov 2021 18:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Disable DVFSRC voltage request
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        qizhong.cheng@mediatek.com, Ryan-JH.Yu@mediatek.com,
        Tzung-Bi Shih <tzungbi@google.com>
References: <20211015063602.29058-1-jianjun.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211015063602.29058-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15/10/2021 08:36, Jianjun Wang wrote:
> When the DVFSRC (dynamic voltage and frequency scaling resource collector)
> feature is not implemented, the PCIe hardware will assert a voltage request
> signal when exit from the L1 PM Substates to request a specific Vcore
> voltage, but cannot receive the voltage ready signal, which will cause
> the link to fail to exit the L1 PM Substates.
> 
> Disable DVFSRC voltage request by default, we need to find a common way to
> enable it in the future.
> 
> Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Tested-by: Qizhong Cheng <qizhong.cheng@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index f3aeb8d4eaca..79fb12fca6a9 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -79,6 +79,9 @@
>   #define PCIE_ICMD_PM_REG		0x198
>   #define PCIE_TURN_OFF_LINK		BIT(4)
>   
> +#define PCIE_MISC_CTRL_REG		0x348
> +#define PCIE_DISABLE_DVFSRC_VLT_REQ	BIT(1)
> +
>   #define PCIE_TRANS_TABLE_BASE_REG	0x800
>   #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
>   #define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
> @@ -297,6 +300,11 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>   	val &= ~PCIE_INTX_ENABLE;
>   	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
>   
> +	/* Disable DVFSRC voltage request */
> +	val = readl_relaxed(port->base + PCIE_MISC_CTRL_REG);
> +	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> +	writel_relaxed(val, port->base + PCIE_MISC_CTRL_REG);
> +
>   	/* Assert all reset signals */
>   	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
>   	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> 
