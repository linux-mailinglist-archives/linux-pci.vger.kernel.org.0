Return-Path: <linux-pci+bounces-9162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAEA9140F2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 06:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CBE1F22260
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 04:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383ADF43;
	Mon, 24 Jun 2024 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v40UpQD9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385679EA
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202209; cv=none; b=odLNhFLCLfZAmA/MYGiWK7gY4h/3DAQ/ynmodcRNlmv/+36hDfOZGoC3CDZTgA5IJCQDuwY0YRaBwWw5wvTNIAljdsgfylHTc0V1VzRDVYeRFGPylmYKwMP4hL3UegCv1nZ3m/CGOGhtHkDt0GQWSnRgMCkr72DZf0ULch0LNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202209; c=relaxed/simple;
	bh=uDqnT9AuIre5WH/MZArBa58KKA5h3mVWXf5q3RXwpKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbN0TE0906v1DYFTFxUFOJY9oSAlwd6w8mPbJUnhfDnh2kANeIKDhONJnTcfR+L6AQupgy5LXgNhtrvTDMrek64Hdn3WSghYhduVnB7z4pjxSMPGqVw0Zx2Iu7GM4wi6mujzDQ/8p2uQ2jA25pqSSQdBZExQoQvoQBzyLB7lFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v40UpQD9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso3186463a12.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Jun 2024 21:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719202206; x=1719807006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KggaQh+GnmflbHOPUhgs44+0y5+HKtzgKlCgA14TaLA=;
        b=v40UpQD9b2u02G1c6BKpUP9TesVU0bDueSQJd/UGmEps0AAXbN0v9fk2IG2AhHLPIv
         0RDCrrkmNSu0FiQKRFAWyY9kiMmx/HMDupVqWXquNZu0HQJ1PWEWxnrW0XrNZAHuAk3l
         2SGot7VlSA968FY2k7VidqmdY8NQU9xpN9xwBJCwDUi7mbu+IXrW/JzvZIbJAxC86iB+
         CiO8iL/4e7EJ8z/oYQp4R9Zy5TEwnzx2x2KVdxiZPoY43KX2mGneiPcrkr7uzWkex2Px
         TNILiC3A9T4bKIxRc7FeSb+LJrO5Ghp3uxHs2d/ICtzHabqAMiW21jNrFyTOyl9zKiB9
         7onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719202206; x=1719807006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KggaQh+GnmflbHOPUhgs44+0y5+HKtzgKlCgA14TaLA=;
        b=ThVNk3FXvs0uoUyWtNanyvDdRq0zAk7tjIKh4FQ9vPX1HpDJRFJXSRh4tn4TMvF8S2
         DSlNxIGl50Fo3u+kfy2745bs/gEG67b+j1HNbKPeF8VoUJuVI6lmUqa0IyOpKj1WmADU
         XmD+vZH7qa+JKS9nfuyzQ3+JUYq4rL0xapEoP4D+AuHRMZxjRcQ+iXD/Xr5R7TZiX9U5
         Ag7cP1JolMlipbi8SaFKxJQ2msGsgp/EPT4T6T53HT+DhxvoUzTyQrNtXO8afeJgBQdZ
         yFw4zagAoyLM75sx4L5O/zwP+D0SNQFE+35xzNl0nwf8p8nIaI38BGrqdDk2s9bpdskE
         1wtg==
X-Forwarded-Encrypted: i=1; AJvYcCUOr98Y0OQpfXOdQADklwLo97d7NMT4y3Hjib5dgijA58hVFBX0R2YmnM4OePJgAQP5Rqh1cUU6eHPFQ9rP5LOiYl7zUjkc/80M
X-Gm-Message-State: AOJu0YwFjqdamZ97ykdNugW8W/fq5i6FRVH7iyiF72TlujAZivhYBIYd
	cXlk517MoNpx9pFTLht/okPGM0v4FjRGtvRNogknBAGi6IYGCgk1ngjd1RJzuA==
X-Google-Smtp-Source: AGHT+IG2xHy9povS1eoGJuLvvX4zF5xz5cPZv+KkDQgK4M9fud1LMDXZTFyb5CHEBOYJE/sAnh9RWw==
X-Received: by 2002:a17:90a:6d02:b0:2c7:2fdf:57b7 with SMTP id 98e67ed59e1d1-2c858297598mr3491892a91.46.1719202205931;
        Sun, 23 Jun 2024 21:10:05 -0700 (PDT)
Received: from thinkpad ([220.158.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9b5dsm7647526a91.43.2024.06.23.21.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 21:10:05 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:39:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, quic_kathirav@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/8] PCI: qcom: Switch to devm_clk_bulk_get_all() API
 to get the clocks from Devicetree
Message-ID: <20240624040959.GA10250@thinkpad>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
 <20240501040800.1542805-5-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501040800.1542805-5-mr.nuke.me@gmail.com>

On Tue, Apr 30, 2024 at 11:07:46PM -0500, Alexandru Gagniuc wrote:
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

This is now part of pci/next, hence can be dropped once you rebase on top of
linux-next.

- Mani

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> [moved clks to struct qcom_pcie to reduce code duplication]
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

