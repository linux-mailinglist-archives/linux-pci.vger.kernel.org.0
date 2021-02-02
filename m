Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4730C530
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 17:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhBBQP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 11:15:27 -0500
Received: from mx.socionext.com ([202.248.49.38]:24641 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236073AbhBBQOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 11:14:00 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Feb 2021 01:13:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id A61A32059027;
        Wed,  3 Feb 2021 01:13:17 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 3 Feb 2021 01:13:17 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 00C77B1D40;
        Wed,  3 Feb 2021 01:13:17 +0900 (JST)
Received: from [10.212.20.246] (unknown [10.212.20.246])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 511FE120148;
        Wed,  3 Feb 2021 01:13:16 +0900 (JST)
Subject: Re: [PATCH v2 3/3] PCI: uniphier-ep: Add EPC restart management
 support
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1611500977-24816-4-git-send-email-hayashi.kunihiko@socionext.com>
 <c5e89789-2dd3-3247-ec85-d54652987e2a@ti.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <b2227106-6f95-bfe6-5ee4-28ec21175a8b@socionext.com>
Date:   Wed, 3 Feb 2021 01:13:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c5e89789-2dd3-3247-ec85-d54652987e2a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,
Thank you for your comment.

On 2021/01/28 23:29, Kishon Vijay Abraham I wrote:
> Hi Kunihiko,
> 
> On 24/01/21 8:39 pm, Kunihiko Hayashi wrote:
>> Set the polling function and call the init function to enable EPC restart
>> management. The polling function detects that the bus-reset signal is a
>> rising edge.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig            |  1 +
>>   drivers/pci/controller/dwc/pcie-uniphier-ep.c | 44 ++++++++++++++++++++++++++-
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 22c5529..90d400a 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -302,6 +302,7 @@ config PCIE_UNIPHIER_EP
>>   	depends on OF && HAS_IOMEM
>>   	depends on PCI_ENDPOINT
>>   	select PCIE_DW_EP
>> +	select PCI_ENDPOINT_RESTART
>>   	help
>>   	  Say Y here if you want PCIe endpoint controller support on
>>   	  UniPhier SoCs. This driver supports Pro5 SoC.
>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
>> index 69810c6..9d83850 100644
>> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
>> @@ -26,6 +26,7 @@
>>   #define PCL_RSTCTRL_PIPE3		BIT(0)
>>   
>>   #define PCL_RSTCTRL1			0x0020
>> +#define PCL_RSTCTRL_PERST_MON		BIT(16)
>>   #define PCL_RSTCTRL_PERST		BIT(0)
>>   
>>   #define PCL_RSTCTRL2			0x0024
>> @@ -60,6 +61,7 @@ struct uniphier_pcie_ep_priv {
>>   	struct clk *clk, *clk_gio;
>>   	struct reset_control *rst, *rst_gio;
>>   	struct phy *phy;
>> +	bool bus_reset_status;
>>   	const struct pci_epc_features *features;
>>   };
>>   
>> @@ -212,6 +214,41 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
>>   	return priv->features;
>>   }
>>   
>> +static bool uniphier_pcie_ep_poll_reset(void *data)
>> +{
>> +	struct uniphier_pcie_ep_priv *priv = data;
>> +	bool ret, status;
>> +
>> +	if (!priv)
>> +		return false;
>> +
>> +	status = !(readl(priv->base + PCL_RSTCTRL1) & PCL_RSTCTRL_PERST_MON);
>> +
>> +	/* return true if the rising edge of bus reset is detected */
>> +	ret = !!(status == false && priv->bus_reset_status == true);
>> +	priv->bus_reset_status = status;
> 
> I'm still not convinced about having a separate library for restart
> management but shouldn't we reset the function driver on falling edge?

I understand your opnion well.
There might not be enough way to give controller-specific features
to handle "restart" as a common function.

> After the rising edge the host expects the endpoint to be ready.

I see. I didn't consider that restart was completed just after
the rising edge.

> Why not use the CORE_INIT (core_init_notifier) infrastructure?

I don't follow the CORE_INIT yet, so I'll try to introduce it
into the driver. However, our current controller doesn't have
an interrupt that detects PERST like pcie-tegra194.
I think the driver needs a thread for polling PERST like patch 2/3.

Thank you,

---
Best Regards
Kunihiko Hayashi
