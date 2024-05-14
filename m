Return-Path: <linux-pci+bounces-7440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D048C4D49
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EB2836EC
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A217999;
	Tue, 14 May 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+02EKDX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A514A8F
	for <linux-pci@vger.kernel.org>; Tue, 14 May 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673070; cv=none; b=pxNOdJT57HTBl3xQX60TwlHlVYikZopkD44Fiwu5wKsnZ+dB6GMz5WIIvgiyYDJ9rL1eb0V+cp9oLg3l0KiNv4Pxoy46DIxZORH8//xDJ9CSgSUXLnBGZ/JCvpXafhpteTF8JfgNc2+vFykW9K/NH2VwFXcp6fznQoCxnJFHa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673070; c=relaxed/simple;
	bh=krG1zVaK3l/29Cmol8z1CCc8GFVbvQaFOBN40o6k7w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9vIe1tHt7GCIb1MdGbHnF3SJWMwEskWTU9tnwbbnjFL1V8VeyNxOCpJZOnZPKvOyV93L3r4Rt1FbBJZfN6NJ1SDkwN0QrAUEPXlBLwHY6Trm8eU6crCHRNlj7PGgm59FNkgrBjYyILjedR6dc1Q8Qg9kkJl7+xpqLLxNJTrWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+02EKDX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a89787ea4so42075566b.2
        for <linux-pci@vger.kernel.org>; Tue, 14 May 2024 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715673066; x=1716277866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8BO15yDmXpBmEarxhd2q42jHVox3qmbWZ3jkNFDgX8g=;
        b=n+02EKDX4aYaz2vVM7OUNUQ+1V7r/lcX/XwTeiBbBKfnCzZE+iA18MGFbt3X3+YGV2
         Ywa9AYXw0TUmiQ00NH3nOdM7GiPIzJLf4/uCjUM5OwQ3Oj3WcDVB4Eis62AmX15/oTGy
         5DtCfvEcSn+eDxLxxfVHke1yfsbVCe2vFmQkevx7uI0hOd2qDdBKbRTIBhsP3EhZaFnq
         5V71v6GI9oZv48tiaHV1918k7LQ8WPLmhKd4rzVjkou7E8ypbhFEbTIfhkJl51Fv5ctA
         r1BzZ0qLvDEXOBnwfL1KiCLetTIALWIwDHIUdSjevkZJA6GgAhge+iGC1DmQi6gYwNqA
         +bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715673066; x=1716277866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BO15yDmXpBmEarxhd2q42jHVox3qmbWZ3jkNFDgX8g=;
        b=KFn+/XOu8rM9EwtqX65ySKjyIKHTsqBTsXXbl5MmlmJJ4GsgmEdu+Csc4lbxLoEIT2
         7vprczPeHAsHPgvVUroPt+dQOIWyStg3MKpNZy7yIwTgoPCcL46H/Aui4NjCdMSZoBlZ
         1HA5PkAvP2B2zliunj5K45c6xtYMZl4Mm0sMQMB9Mymgw1DzZ2X3Fi4r5BuMLvpliNcH
         WfoIaOQI5gUnxiJhDVzQAoIgfkHc6tcJ8et9tVA45R8K/z7uBDRkGh5cqNQdDYihmhhP
         XGl+XCx5LEQcCz832hdViVqKw8TVpvNLwj7M6HgR4a6E2APcYTFfwYHvUAA54ZTZSZR5
         VOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo6z5h62Z7szk8xsh+ssHTYD9Dz6wBW4mrHvBYzdODx0v9N+JVSsJbuah6eE3qwiGzzdbGD3ZSsn8gGCgxIvV8JtbMkeRuC28f
X-Gm-Message-State: AOJu0Yz2hMiovOHJBw+ffHpvpe2/CR+YmlpJijjQgMGNyuDUcTSvowIs
	hD8zmiS1giMR4M4gQcBcLpYsTXo1zxLVF7Vy4aw/SbC2J4oA79D+3Ap3zdFgPg==
X-Google-Smtp-Source: AGHT+IHUaJLFnIiuyoFrpGYTc0NWLuj5PD6zueiu7Svp/b7aCdLGs7X2LzBVH8yZwX48aFr540/JLA==
X-Received: by 2002:a50:d516:0:b0:56f:e75b:83aa with SMTP id 4fb4d7f45d1cf-5734d5c17b7mr8876915a12.6.1715673065886;
        Tue, 14 May 2024 00:51:05 -0700 (PDT)
Received: from thinkpad ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed000esm7215529a12.54.2024.05.14.00.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:51:05 -0700 (PDT)
Date: Tue, 14 May 2024 09:51:04 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 4/8] PCI: qcom: Switch to
 devm_clk_bulk_get_all() API to get the clocks from Devicetree
Message-ID: <20240514075104.GC2463@thinkpad>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <20240501042847.1545145-5-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501042847.1545145-5-mr.nuke.me@gmail.com>

On Tue, Apr 30, 2024 at 11:28:43PM -0500, Alexandru Gagniuc wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> There is no need for the device drivers to validate the clocks defined in
> Devicetree. The validation should be performed by the DT schema and the
> drivers should just get all the clocks from DT. Right now the driver
> hardcodes the clock info and validates them against DT which is redundant.
> 
> So use devm_clk_bulk_get_all() that just gets all the clocks defined in DT
> and get rid of all static clocks info from the driver. This simplifies the
> driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> [moved clks to struct qcom_pcie to reduce code duplication]

This patch is already applied to pci tree. So hopefully you can just rebase it
on top of pci/next for next version (it should get updated soon).

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 163 ++++---------------------
>  1 file changed, 25 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..ea81ff68d433 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -154,58 +154,42 @@
>  #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
>  		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
>  
> -#define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
>  struct qcom_pcie_resources_1_0_0 {
> -	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
>  	struct reset_control *core;
>  	struct regulator *vdda;
>  };
>  
> -#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
>  #define QCOM_PCIE_2_1_0_MAX_RESETS		6
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
>  struct qcom_pcie_resources_2_1_0 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
>  	struct reset_control_bulk_data resets[QCOM_PCIE_2_1_0_MAX_RESETS];
>  	int num_resets;
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
>  };
>  
> -#define QCOM_PCIE_2_3_2_MAX_CLOCKS		4
>  #define QCOM_PCIE_2_3_2_MAX_SUPPLY		2
>  struct qcom_pcie_resources_2_3_2 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
>  };
>  
> -#define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
>  #define QCOM_PCIE_2_3_3_MAX_RESETS		7
>  struct qcom_pcie_resources_2_3_3 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
>  	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
>  };
>  
> -#define QCOM_PCIE_2_4_0_MAX_CLOCKS		4
>  #define QCOM_PCIE_2_4_0_MAX_RESETS		12
>  struct qcom_pcie_resources_2_4_0 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
> -	int num_clks;
>  	struct reset_control_bulk_data resets[QCOM_PCIE_2_4_0_MAX_RESETS];
>  	int num_resets;
>  };
>  
> -#define QCOM_PCIE_2_7_0_MAX_CLOCKS		15
>  #define QCOM_PCIE_2_7_0_MAX_SUPPLIES		2
>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
> -	int num_clks;
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_7_0_MAX_SUPPLIES];
>  	struct reset_control *rst;
>  };
>  
> -#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
>  struct qcom_pcie_resources_2_9_0 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
>  	struct reset_control *rst;
>  };
>  
> @@ -247,6 +231,8 @@ struct qcom_pcie {
>  	struct icc_path *icc_mem;
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
>  	bool suspended;
>  };
>  
> @@ -337,22 +323,6 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	if (ret)
>  		return ret;
>  
> -	res->clks[0].id = "iface";
> -	res->clks[1].id = "core";
> -	res->clks[2].id = "phy";
> -	res->clks[3].id = "aux";
> -	res->clks[4].id = "ref";
> -
> -	/* iface, core, phy are required */
> -	ret = devm_clk_bulk_get(dev, 3, res->clks);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* aux, ref are optional */
> -	ret = devm_clk_bulk_get_optional(dev, 2, res->clks + 3);
> -	if (ret < 0)
> -		return ret;
> -
>  	res->resets[0].id = "pci";
>  	res->resets[1].id = "axi";
>  	res->resets[2].id = "ahb";
> @@ -373,7 +343,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
>  
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  	reset_control_bulk_assert(res->num_resets, res->resets);
>  
>  	writel(1, pcie->parf + PARF_PHY_CTRL);
> @@ -413,7 +383,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
>  {
> -	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
>  	struct device_node *node = dev->of_node;
> @@ -425,7 +394,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>  
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (ret)
>  		return ret;
>  
> @@ -476,21 +445,11 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	int ret;
>  
>  	res->vdda = devm_regulator_get(dev, "vdda");
>  	if (IS_ERR(res->vdda))
>  		return PTR_ERR(res->vdda);
>  
> -	res->clks[0].id = "iface";
> -	res->clks[1].id = "aux";
> -	res->clks[2].id = "master_bus";
> -	res->clks[3].id = "slave_bus";
> -
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> -	if (ret < 0)
> -		return ret;
> -
>  	res->core = devm_reset_control_get_exclusive(dev, "core");
>  	return PTR_ERR_OR_ZERO(res->core);
>  }
> @@ -500,7 +459,7 @@ static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
>  
>  	reset_control_assert(res->core);
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  	regulator_disable(res->vdda);
>  }
>  
> @@ -517,7 +476,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
>  		return ret;
>  	}
>  
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable clocks\n");
>  		goto err_assert_reset;
> @@ -532,7 +491,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
>  	return 0;
>  
>  err_disable_clks:
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  err_assert_reset:
>  	reset_control_assert(res->core);
>  
> @@ -580,15 +539,6 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
>  	if (ret)
>  		return ret;
>  
> -	res->clks[0].id = "aux";
> -	res->clks[1].id = "cfg";
> -	res->clks[2].id = "bus_master";
> -	res->clks[3].id = "bus_slave";
> -
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> -	if (ret < 0)
> -		return ret;
> -
>  	return 0;
>  }
>  
> @@ -596,7 +546,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>  
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
> @@ -613,7 +563,7 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  		return ret;
>  	}
>  
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable clocks\n");
>  		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> @@ -661,18 +611,6 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");
>  	int ret;
>  
> -	res->clks[0].id = "aux";
> -	res->clks[1].id = "master_bus";
> -	res->clks[2].id = "slave_bus";
> -	res->clks[3].id = "iface";
> -
> -	/* qcom,pcie-ipq4019 is defined without "iface" */
> -	res->num_clks = is_ipq ? 3 : 4;
> -
> -	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
> -	if (ret < 0)
> -		return ret;
> -
>  	res->resets[0].id = "axi_m";
>  	res->resets[1].id = "axi_s";
>  	res->resets[2].id = "axi_m_sticky";
> @@ -700,7 +638,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
>  
>  	reset_control_bulk_assert(res->num_resets, res->resets);
> -	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  }
>  
>  static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> @@ -726,7 +664,7 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  
>  	usleep_range(10000, 12000);
>  
> -	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (ret) {
>  		reset_control_bulk_assert(res->num_resets, res->resets);
>  		return ret;
> @@ -742,16 +680,6 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
>  	struct device *dev = pci->dev;
>  	int ret;
>  
> -	res->clks[0].id = "iface";
> -	res->clks[1].id = "axi_m";
> -	res->clks[2].id = "axi_s";
> -	res->clks[3].id = "ahb";
> -	res->clks[4].id = "aux";
> -
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> -	if (ret < 0)
> -		return ret;
> -
>  	res->rst[0].id = "axi_m";
>  	res->rst[1].id = "axi_s";
>  	res->rst[2].id = "pipe";
> @@ -769,9 +697,7 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
>  
>  static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
>  {
> -	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> -
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  }
>  
>  static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> @@ -801,7 +727,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  	 */
>  	usleep_range(2000, 2500);
>  
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable clocks\n");
>  		goto err_assert_resets;
> @@ -862,8 +788,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	unsigned int num_clks, num_opt_clks;
> -	unsigned int idx;
>  	int ret;
>  
>  	res->rst = devm_reset_control_array_get_exclusive(dev);
> @@ -877,37 +801,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret)
>  		return ret;
>  
> -	idx = 0;
> -	res->clks[idx++].id = "aux";
> -	res->clks[idx++].id = "cfg";
> -	res->clks[idx++].id = "bus_master";
> -	res->clks[idx++].id = "bus_slave";
> -	res->clks[idx++].id = "slave_q2a";
> -
> -	num_clks = idx;
> -
> -	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
> -	if (ret < 0)
> -		return ret;
> -
> -	res->clks[idx++].id = "tbu";
> -	res->clks[idx++].id = "ddrss_sf_tbu";
> -	res->clks[idx++].id = "aggre0";
> -	res->clks[idx++].id = "aggre1";
> -	res->clks[idx++].id = "noc_aggr";
> -	res->clks[idx++].id = "noc_aggr_4";
> -	res->clks[idx++].id = "noc_aggr_south_sf";
> -	res->clks[idx++].id = "cnoc_qx";
> -	res->clks[idx++].id = "sleep";
> -	res->clks[idx++].id = "cnoc_sf_axi";
> -
> -	num_opt_clks = idx - num_clks;
> -	res->num_clks = idx;
> -
> -	ret = devm_clk_bulk_get_optional(dev, num_opt_clks, res->clks + num_clks);
> -	if (ret < 0)
> -		return ret;
> -
>  	return 0;
>  }
>  
> @@ -925,7 +818,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		return ret;
>  	}
>  
> -	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (ret < 0)
>  		goto err_disable_regulators;
>  
> @@ -977,7 +870,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  	return 0;
>  err_disable_clocks:
> -	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  err_disable_regulators:
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  
> @@ -1015,7 +908,7 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
> -	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
> @@ -1101,17 +994,6 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	int ret;
> -
> -	res->clks[0].id = "iface";
> -	res->clks[1].id = "axi_m";
> -	res->clks[2].id = "axi_s";
> -	res->clks[3].id = "axi_bridge";
> -	res->clks[4].id = "rchng";
> -
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> -	if (ret < 0)
> -		return ret;
>  
>  	res->rst = devm_reset_control_array_get_exclusive(dev);
>  	if (IS_ERR(res->rst))
> @@ -1122,9 +1004,7 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>  
>  static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
>  {
> -	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> -
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  }
>  
>  static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> @@ -1153,7 +1033,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>  
>  	usleep_range(2000, 2500);
>  
> -	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	return clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  }
>  
>  static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> @@ -1561,6 +1441,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
> +	if (pcie->num_clks < 0) {
> +		ret = pcie->num_clks;
> +		dev_err(dev, "Failed to get clocks\n");
> +		goto err_pm_runtime_put;
> +	}
> +
>  	ret = qcom_pcie_icc_init(pcie);
>  	if (ret)
>  		goto err_pm_runtime_put;
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

