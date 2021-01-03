Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DBE2E8B35
	for <lists+linux-pci@lfdr.de>; Sun,  3 Jan 2021 07:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbhACGs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Jan 2021 01:48:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19846 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbhACGsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jan 2021 01:48:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff168910000>; Sat, 02 Jan 2021 22:47:45 -0800
Received: from [10.25.98.34] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 3 Jan
 2021 06:47:26 +0000
Subject: Re: [PATCH] PCI:tegra:Correct typo for PCIe endpoint mode in Tegra194
To:     Wesley Sheng <wesley.sheng@amd.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <andriy.shevchenko@intel.com>,
        <treding@nvidia.com>, <eswara.kota@linux.intel.com>,
        <hayashi.kunihiko@socionext.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <wesley.sheng@microsemi.com>
References: <20201231032539.22322-1-wesley.sheng@amd.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4902626c-0ea4-4fba-4b37-70481ef61bbf@nvidia.com>
Date:   Sun, 3 Jan 2021 12:17:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201231032539.22322-1-wesley.sheng@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609656465; bh=WfV8lKNcP8RsbSU6029xxYIm5NbHIuXoGoEQ5XB/OXY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ajqJ8A+oB5onl+gslHiHFncrt28jJTpsICHbeTuysZQdjpLMervgi2aeul2AohL9X
         MowKXiIS54mbp4bqkt2rik0qy0BUyNR0cr459WM+0/GOd5ggwCj5VvtdOoFXJYYSrL
         mxUp33GDGf3zA4iSat3jRXPBs16rZuiFo/vXR/WfKZMh82vZCA9ZDjNEGN0eaucrEV
         cDbChyO5tYuLBkGr5jCdLPyLPm8flVQVRtjMnavO8RUKqOlKWKfCb+ZlKQ4q9aKf8F
         Zpz6+n2dNQzuvcgNo7kQRr0Y4yYHiXA8no+1R9LZ6oHacp6Uvv+a+GkuhR1lKSPTjW
         C0YF5T22O0opw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the patch.

Acked-by: Vidya Sagar <vidyas@nvidia.com>

On 12/31/2020 8:55 AM, Wesley Sheng wrote:
> External email: Use caution opening links or attachments
> 
> 
> In config PCIE_TEGRA194_EP the mode incorrectly referred to
> host mode.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
> ---
>   drivers/pci/controller/dwc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a3761c44f..6960babe6161 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -273,7 +273,7 @@ config PCIE_TEGRA194_EP
>          select PCIE_TEGRA194
>          help
>            Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> -         work in host mode. There are two instances of PCIe controllers in
> +         work in endpoint mode. There are two instances of PCIe controllers in
>            Tegra194. This controller can work either as EP or RC. In order to
>            enable host-specific features PCIE_TEGRA194_HOST must be selected and
>            in order to enable device-specific features PCIE_TEGRA194_EP must be
> --
> 2.16.2
> 
