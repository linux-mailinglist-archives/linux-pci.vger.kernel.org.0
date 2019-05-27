Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6079F2B58A
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE0MlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 08:41:00 -0400
Received: from ns.iliad.fr ([212.27.33.1]:44488 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfE0MlA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 May 2019 08:41:00 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 50FCE20A52;
        Mon, 27 May 2019 14:40:58 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 41D8D1FF3E;
        Mon, 27 May 2019 14:40:58 +0200 (CEST)
Subject: Re: [PATCH] drivers/pci/controller: fix warning PTR_ERR_OR_ZERO can
 be used
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20190525085748.GA10926@hari-Inspiron-1545>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <085da143-9d13-8741-9f6c-489754fef9f6@free.fr>
Date:   Mon, 27 May 2019 14:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525085748.GA10926@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 27 14:40:58 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/05/2019 10:57, Hariprasad Kelam wrote:

> fix below warnings reported by coccichek
> 
> /drivers/pci/controller/pci-tegra.c:1132:1-3: WARNING: PTR_ERR_OR_ZERO
> can be used
> ./drivers/pci/controller/dwc/pcie-qcom.c:703:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pci-meson.c:185:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pci-meson.c:262:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pcie-kirin.c:141:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pcie-kirin.c:177:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pci-exynos.c:95:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 4 +---
>  drivers/pci/controller/dwc/pci-meson.c  | 8 ++------
>  drivers/pci/controller/dwc/pcie-kirin.c | 8 ++------
>  drivers/pci/controller/dwc/pcie-qcom.c  | 4 +---
>  drivers/pci/controller/pci-tegra.c      | 4 +---
>  5 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0ed235d..6c421e6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -700,10 +700,8 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  		return PTR_ERR(res->ahb_reset);
>  
>  	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
> -	if (IS_ERR(res->phy_ahb_reset))
> -		return PTR_ERR(res->phy_ahb_reset);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(res->phy_ahb_reset);
>  }
>  
>  static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)

My opinion doesn't carry any weight, but IMO using PTR_ERR_OR_ZERO instead
of PTR_ERR breaks the symmetry of the previous operations.

It seems to give the last operation more importance than the previous ones,
which I don't find desirable.

Regards.
