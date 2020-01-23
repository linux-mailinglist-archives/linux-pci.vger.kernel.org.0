Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8414653E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 11:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAWKAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 05:00:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45196 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWKAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 05:00:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so2316642wrj.12
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 02:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUTGePi6fmOsoikQGLJ68cW6uDsj3EuYoq51wPIcKds=;
        b=W1p5Sq5h1vM+0PWfcEhbKFHEY5QUnY0Ktj4oSYHZAGsrwY3lrSvnbPHm20cTedMblz
         /HaAXQfLarN6sF9FTPP2KCZ6X/NX7MFj0t8EyZDQt3kJ7J7wtS8gqwavTuA46eeBjwZX
         9Z6r/XHngQWnGQ+zI8OYgFfx9XIGegYbzRTRm9SD6MpUc8SiULQCXuBQHXmWabF3KSus
         aJR+O8wYw7MNcq+KjUE4n+tLm5haSbhAgkJLaScOyhjJRosio+HUa0wNrztiYbSUN0IB
         M5nDpcPztOVcy7mt2x3yuewGgTvEIfvlrz/N6YgZnsTBPaYbxIq/vmz/YWDJL3KONgjK
         yLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TUTGePi6fmOsoikQGLJ68cW6uDsj3EuYoq51wPIcKds=;
        b=LuojefD2VZKWZPXfiumz0i3DVNWoHhWDO2JBZHQcfcjCPiLMhhekRIv+iCWcakEj+8
         kWJymRoevTZ2TXDvc52qVWUS3WseDheubR2Cy9yKddb1H995Et5fZ16N2lchmlaiwYJG
         jzPsgrft87SPFuCFQ3k21LtpmuIXsHnZV7GooFtUBAZ7B89jMqIhYudpf6cIuqTVqSzG
         1WwMJA+0bHjVW9r7dOomvHP8bzdLs6RuA8iS/5qaou81v/4gQzDnRcTsLuHZ4PRyYji7
         R/GhAX9c6wLLu9OmtbN0nCdQ7hLvqmSbgU0FZT/R5jGB3KzLfIHe0g1PaQkDiEVDkxvj
         GApw==
X-Gm-Message-State: APjAAAXzYlfE4dcdSAT9N5fGcG4TpaWyaprVggP8/LXSExOJQe08x9kx
        VJCzO5p7LrX4EZPKYWy7/rc2YFA7lED1tw==
X-Google-Smtp-Source: APXvYqyW/C1QwScDuSd8uqsgOH1IJ+PbQTcWAq7lVVVdYt+IAzTJSQo6toxFUFUQsXA1hozvTuEfIw==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr17553305wrc.175.1579773616314;
        Thu, 23 Jan 2020 02:00:16 -0800 (PST)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t1sm2066724wma.43.2020.01.23.02.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 02:00:15 -0800 (PST)
Subject: Re: [PATCH v5 7/7] PCI: amlogic: Use AXG PCIE
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
References: <20200116201303.GA187897@google.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <256555bf-7aa5-6232-fd7d-0f3b0b2b0e67@baylibre.com>
Date:   Thu, 23 Jan 2020 11:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116201303.GA187897@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/01/2020 21:13, Bjorn Helgaas wrote:
> [+cc linux-pci, series at https://lore.kernel.org/r/20200116111850.23690-1-repk@triplefau.lt]
> 
> On Thu, Jan 16, 2020 at 12:18:50PM +0100, Remi Pommarel wrote:
>> Now that PCIE PHY has been introduced for AXG, the whole has_shared_phy
>> logic can be mutualized between AXG and G12A platforms.
>>
>> This new PHY makes use of the optional shared MIPI/PCIE analog PHY
>> found on AXG platforms, which need to be used in order to have reliable
>> PCIE communications.
>>
>> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>> ---
>>  drivers/pci/controller/dwc/pci-meson.c | 116 +++++--------------------
>>  1 file changed, 22 insertions(+), 94 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index 3772b02a5c55..3715dceca1bf 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -66,7 +66,6 @@
>>  #define PORT_CLK_RATE			100000000UL
>>  #define MAX_PAYLOAD_SIZE		256
>>  #define MAX_READ_REQ_SIZE		256
>> -#define MESON_PCIE_PHY_POWERUP		0x1c
>>  #define PCIE_RESET_DELAY		500
>>  #define PCIE_SHARED_RESET		1
>>  #define PCIE_NORMAL_RESET		0
>> @@ -81,26 +80,19 @@ enum pcie_data_rate {
>>  struct meson_pcie_mem_res {
>>  	void __iomem *elbi_base;
>>  	void __iomem *cfg_base;
>> -	void __iomem *phy_base;
>>  };
>>  
>>  struct meson_pcie_clk_res {
>>  	struct clk *clk;
>> -	struct clk *mipi_gate;
>>  	struct clk *port_clk;
>>  	struct clk *general_clk;
>>  };
>>  
>>  struct meson_pcie_rc_reset {
>> -	struct reset_control *phy;
>>  	struct reset_control *port;
>>  	struct reset_control *apb;
>>  };
>>  
>> -struct meson_pcie_param {
>> -	bool has_shared_phy;
>> -};
>> -
>>  struct meson_pcie {
>>  	struct dw_pcie pci;
>>  	struct meson_pcie_mem_res mem_res;
>> @@ -108,7 +100,6 @@ struct meson_pcie {
>>  	struct meson_pcie_rc_reset mrst;
>>  	struct gpio_desc *reset_gpio;
>>  	struct phy *phy;
>> -	const struct meson_pcie_param *param;
>>  };
>>  
>>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
>> @@ -130,13 +121,6 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
>>  {
>>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>>  
>> -	if (!mp->param->has_shared_phy) {
>> -		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
>> -		if (IS_ERR(mrst->phy))
>> -			return PTR_ERR(mrst->phy);
>> -		reset_control_deassert(mrst->phy);
>> -	}
>> -
>>  	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
>>  	if (IS_ERR(mrst->port))
>>  		return PTR_ERR(mrst->port);
>> @@ -162,22 +146,6 @@ static void __iomem *meson_pcie_get_mem(struct platform_device *pdev,
>>  	return devm_ioremap_resource(dev, res);
>>  }
>>  
>> -static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
>> -					       struct meson_pcie *mp,
>> -					       const char *id)
>> -{
>> -	struct device *dev = mp->pci.dev;
>> -	struct resource *res;
>> -
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
>> -	if (!res) {
>> -		dev_err(dev, "No REG resource %s\n", id);
>> -		return ERR_PTR(-ENXIO);
>> -	}
>> -
>> -	return devm_ioremap(dev, res->start, resource_size(res));
>> -}
>> -
>>  static int meson_pcie_get_mems(struct platform_device *pdev,
>>  			       struct meson_pcie *mp)
>>  {
>> @@ -189,14 +157,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>>  	if (IS_ERR(mp->mem_res.cfg_base))
>>  		return PTR_ERR(mp->mem_res.cfg_base);
>>  
>> -	/* Meson AXG SoC has two PCI controllers use same phy register */
>> -	if (!mp->param->has_shared_phy) {
>> -		mp->mem_res.phy_base =
>> -			meson_pcie_get_mem_shared(pdev, mp, "phy");
>> -		if (IS_ERR(mp->mem_res.phy_base))
>> -			return PTR_ERR(mp->mem_res.phy_base);
>> -	}
>> -
>>  	return 0;
>>  }
>>  
>> @@ -204,37 +164,33 @@ static int meson_pcie_power_on(struct meson_pcie *mp)
>>  {
>>  	int ret = 0;
>>  
>> -	if (mp->param->has_shared_phy) {
>> -		ret = phy_init(mp->phy);
>> -		if (ret)
>> -			return ret;
>> +	ret = phy_init(mp->phy);
>> +	if (ret)
>> +		return ret;
>>  
>> -		ret = phy_power_on(mp->phy);
>> -		if (ret) {
>> -			phy_exit(mp->phy);
>> -			return ret;
>> -		}
>> -	} else
>> -		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
>> +	ret = phy_power_on(mp->phy);
>> +	if (ret) {
>> +		phy_exit(mp->phy);
>> +		return ret;
>> +	}
>>  
>>  	return 0;
>>  }
>>  
>> +static void meson_pcie_power_off(struct meson_pcie *mp)
>> +{
>> +	phy_power_off(mp->phy);
>> +	phy_exit(mp->phy);
>> +}
>> +
>>  static int meson_pcie_reset(struct meson_pcie *mp)
>>  {
>>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>>  	int ret = 0;
>>  
>> -	if (mp->param->has_shared_phy) {
>> -		ret = phy_reset(mp->phy);
>> -		if (ret)
>> -			return ret;
>> -	} else {
>> -		reset_control_assert(mrst->phy);
>> -		udelay(PCIE_RESET_DELAY);
>> -		reset_control_deassert(mrst->phy);
>> -		udelay(PCIE_RESET_DELAY);
>> -	}
>> +	ret = phy_reset(mp->phy);
>> +	if (ret)
>> +		return ret;
>>  
>>  	reset_control_assert(mrst->port);
>>  	reset_control_assert(mrst->apb);
>> @@ -286,12 +242,6 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>>  	if (IS_ERR(res->port_clk))
>>  		return PTR_ERR(res->port_clk);
>>  
>> -	if (!mp->param->has_shared_phy) {
>> -		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
>> -		if (IS_ERR(res->mipi_gate))
>> -			return PTR_ERR(res->mipi_gate);
>> -	}
>> -
>>  	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
>>  	if (IS_ERR(res->general_clk))
>>  		return PTR_ERR(res->general_clk);
>> @@ -562,7 +512,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>>  
>>  static int meson_pcie_probe(struct platform_device *pdev)
>>  {
>> -	const struct meson_pcie_param *match_data;
>>  	struct device *dev = &pdev->dev;
>>  	struct dw_pcie *pci;
>>  	struct meson_pcie *mp;
>> @@ -576,17 +525,10 @@ static int meson_pcie_probe(struct platform_device *pdev)
>>  	pci->dev = dev;
>>  	pci->ops = &dw_pcie_ops;
>>  
>> -	match_data = of_device_get_match_data(dev);
>> -	if (!match_data) {
>> -		dev_err(dev, "failed to get match data\n");
>> -		return -ENODEV;
>> -	}
>> -	mp->param = match_data;
>> -
>> -	if (mp->param->has_shared_phy) {
>> -		mp->phy = devm_phy_get(dev, "pcie");
>> -		if (IS_ERR(mp->phy))
>> -			return PTR_ERR(mp->phy);
>> +	mp->phy = devm_phy_get(dev, "pcie");
>> +	if (IS_ERR(mp->phy)) {
>> +		dev_err(dev, "get phy failed, %ld\n", PTR_ERR(mp->phy));
>> +		return PTR_ERR(mp->phy);
>>  	}
>>  
>>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> @@ -636,30 +578,16 @@ static int meson_pcie_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  err_phy:
>> -	if (mp->param->has_shared_phy) {
>> -		phy_power_off(mp->phy);
>> -		phy_exit(mp->phy);
>> -	}
>> -
>> +	meson_pcie_power_off(mp);
>>  	return ret;
>>  }
>>  
>> -static struct meson_pcie_param meson_pcie_axg_param = {
>> -	.has_shared_phy = false,
>> -};
>> -
>> -static struct meson_pcie_param meson_pcie_g12a_param = {
>> -	.has_shared_phy = true,
>> -};
>> -
>>  static const struct of_device_id meson_pcie_of_match[] = {
>>  	{
>>  		.compatible = "amlogic,axg-pcie",
>> -		.data = &meson_pcie_axg_param,
>>  	},
>>  	{
>>  		.compatible = "amlogic,g12a-pcie",
>> -		.data = &meson_pcie_g12a_param,
>>  	},
>>  	{},
>>  };
>> -- 
>> 2.24.1
>>

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
