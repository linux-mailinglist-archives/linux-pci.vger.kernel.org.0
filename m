Return-Path: <linux-pci+bounces-10758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BA93BBE5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376FA2815C8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7118C3B;
	Thu, 25 Jul 2024 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmsV83T6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C771799D
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883499; cv=none; b=pbJ6A3NVpZSwnz7YBFYsvbxQZ2RVbjT9J84LVrQWltiWG8YCf4MncMnqKzCBXIhZrd/WpRQt3QW5ErHuOx6t/irJQw5sFAJL0PABi5UgamndFo2VKzPxu+LrdyT4dtuM2cRI5SsK4mIaMsmEw2LaqGlAlJJpqehEgtQA8UlNrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883499; c=relaxed/simple;
	bh=GHF2Tqg8a3gXo6ehVVkGkJrM8YfpGJNDSASFEUYnw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H39oB7je163Bs6LRN+8Z4JNsr122ME5Jr2LDMeYZvT8MLcQt0zSVBptNJdrVorgPH9OmZtUS7t+kuzg9qna2pOKusemHxHnuak2zkxOJK0XqqUHy0OQDj9k/6Vgz4f7EMBNPzk58CRFGCrDYRoJyrZZWOyPvgpl6mIzVUuAXBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmsV83T6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d18112b60so389330b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721883497; x=1722488297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHJ+bXZgbj37wVLktHgPMsj4okXfb1wUE1MffwGWsEY=;
        b=NmsV83T6XeQVTkE7ER3iWOrcHaD+z5UK00TLHgv+pP6IJoKhBO1ujKDH1/z3lR9Ktc
         lTGdP2ZgUV9sae1NhLEGYkP4QZf4JyWGjGMTxqEXpmZhcPqNC99U3ec4DAfLlB1XIHWL
         0+WcK51ah1jHih/dupByTXynu2doqR2cuqxgoq3TJLn/pZfEMK++iOu8btCcWsp6P1aW
         Bb8w6HEg4HgC6i7o9+5rXfLECJYY85b9D57WeFJS/kVuwoR63ArY2fElyWMBVaBwDB3m
         GkdvIQMQFnKy56Jw/kmU9RCKYZ4mvvzx78VMgz5BPWO23GNUQ7tfEbqxDzxTjHyAzFPd
         yBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883497; x=1722488297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHJ+bXZgbj37wVLktHgPMsj4okXfb1wUE1MffwGWsEY=;
        b=wv2rhST3kayf/SxUgSpD6qRCeieIBAd4xZI5ADYspJI6FoDDxJzclME/nOk+CaBaXK
         kPz0RIhhwTq2ZMLy5XBXsxUET0FICJfdw8Lww648IamWLi9d01wCy78KxQV7ZQ244242
         Dj3pHQ5QwWX4rFEWD0HlWMaqcDfFZAS/ZwNYfOU1yznfl22fC0dBleW4siUzfDYPaIeI
         eCfmkZ5cNxxCvXQOgQfBI1Rr3tL8dXe/I1TFBuBe8RxjisqtA5ifWCZfJ/wGyE5sk6ff
         HZ1mQVyRARQWBEsIwgizrF2FMURZe/duX7QnHi0nR57r7FDUPou1aRhCs2pvcFGqn5K1
         eeyA==
X-Gm-Message-State: AOJu0YyQUkokwmxv96psiElhbq959hxz3ff3rEHF0Xy7wAwlip0oFrSU
	vVJ4lnTE2Rrmy4Ghp8d/m7CFH93KiJA8aI5X24oPpNcK3W7iSIDxyVnmRZDXlTtl7sq9wcZd71A
	=
X-Google-Smtp-Source: AGHT+IGERFSKOQsg47XBdDbVBiuDeQyNQcDZbrb8qoee9949yCfDn4IW3b1n3MSW1JYc8N574h2NMA==
X-Received: by 2002:a05:6a00:9193:b0:70d:2b95:e3c4 with SMTP id d2e1a72fcca58-70e9ee291ddmr6265342b3a.5.1721883496792;
        Wed, 24 Jul 2024 21:58:16 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874c62sm374101b3a.157.2024.07.24.21.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:58:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:28:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] PCI: brcmstb: Change field name from 'type' to
 'model'
Message-ID: <20240725045810.GK2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-12-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-12-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:26PM -0400, Jim Quinlan wrote:
> The 'type' field used in the driver to discern SoC differences is confusing
> so change it to the more apt 'model'.  We considered using 'family' but
> this conflicts with Broadcom's conception of a family; for example, 7216a0
> and 7216b0 chips are both considered separate families as each has multiple
> derivative product chips based on the original design.
> 

TBH, 'model' is also confusing :) Why can't you just use 'soc' as you are
referrring to the SoC name.

- Mani

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++--------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 2fe1f2a26697..fa5616a56383 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -211,7 +211,7 @@ enum {
>  	PCIE_INTR2_CPU_BASE,
>  };
>  
> -enum pcie_type {
> +enum pcie_model {
>  	GENERIC,
>  	BCM7425,
>  	BCM7435,
> @@ -229,7 +229,7 @@ struct rc_bar {
>  
>  struct pcie_cfg_data {
>  	const int *offsets;
> -	const enum pcie_type type;
> +	const enum pcie_model model;
>  	const bool has_phy;
>  	unsigned int num_inbound;
>  	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> @@ -270,7 +270,7 @@ struct brcm_pcie {
>  	u64			msi_target_addr;
>  	struct brcm_msi		*msi;
>  	const int		*reg_offsets;
> -	enum pcie_type		type;
> +	enum pcie_model		model;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge;
> @@ -288,7 +288,7 @@ struct brcm_pcie {
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
>  {
> -	return pcie->type == BCM7435 || pcie->type == BCM7425;
> +	return pcie->model == BCM7435 || pcie->model == BCM7425;
>  }
>  
>  /*
> @@ -852,7 +852,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	 * security considerations, and is not implemented in our modern
>  	 * SoCs.
>  	 */
> -	if (pcie->type != BCM7712)
> +	if (pcie->model != BCM7712)
>  		set_bar(b++, &n, 0, 0, 0);
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> @@ -869,7 +869,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  		 * That being said, each BARs size must still be a power of
>  		 * two.
>  		 */
> -		if (pcie->type == BCM7712)
> +		if (pcie->model == BCM7712)
>  			set_bar(b++, &n, size, cpu_beg, pcie_beg);
>  
>  		if (n > pcie->num_inbound)
> @@ -886,7 +886,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	 * that enables multiple memory controllers.  As such, it can return
>  	 * now w/o doing special configuration.
>  	 */
> -	if (pcie->type == BCM7712)
> +	if (pcie->model == BCM7712)
>  		return n;
>  
>  	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> @@ -1008,7 +1008,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie, const struct rc_ba
>  		 * 7712:
>  		 *     All of their BARs need to be set.
>  		 */
> -		if (pcie->type == BCM7712) {
> +		if (pcie->model == BCM7712) {
>  			/* BUS remap register settings */
>  			reg_offset = brcm_ubus_reg_offset(i);
>  			tmp = lower_32_bits(cpu_addr) & ~0xfff;
> @@ -1036,7 +1036,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		return ret;
>  
>  	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
> -	if (pcie->type == BCM2711) {
> +	if (pcie->model == BCM2711) {
>  		ret = pcie->perst_set(pcie, 1);
>  		if (ret) {
>  			pcie->bridge_sw_init_set(pcie, 0);
> @@ -1067,9 +1067,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	 */
>  	if (is_bmips(pcie))
>  		burst = 0x1; /* 256 bytes */
> -	else if (pcie->type == BCM2711)
> +	else if (pcie->model == BCM2711)
>  		burst = 0x0; /* 128 bytes */
> -	else if (pcie->type == BCM7278)
> +	else if (pcie->model == BCM7278)
>  		burst = 0x3; /* 512 bytes */
>  	else
>  		burst = 0x2; /* 512 bytes */
> @@ -1666,7 +1666,7 @@ static const int pcie_offsets_bmips_7425[] = {
>  
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= GENERIC,
> +	.model		= GENERIC,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound	= 3,
> @@ -1674,7 +1674,7 @@ static const struct pcie_cfg_data generic_cfg = {
>  
>  static const struct pcie_cfg_data bcm7425_cfg = {
>  	.offsets	= pcie_offsets_bmips_7425,
> -	.type		= BCM7425,
> +	.model		= BCM7425,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound	= 3,
> @@ -1682,7 +1682,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
>  
>  static const struct pcie_cfg_data bcm7435_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= BCM7435,
> +	.model		= BCM7435,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound	= 3,
> @@ -1690,7 +1690,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
>  
>  static const struct pcie_cfg_data bcm4908_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= BCM4908,
> +	.model		= BCM4908,
>  	.perst_set	= brcm_pcie_perst_set_4908,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound	= 3,
> @@ -1706,7 +1706,7 @@ static const int pcie_offset_bcm7278[] = {
>  
>  static const struct pcie_cfg_data bcm7278_cfg = {
>  	.offsets	= pcie_offset_bcm7278,
> -	.type		= BCM7278,
> +	.model		= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.num_inbound	= 3,
> @@ -1714,7 +1714,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
>  
>  static const struct pcie_cfg_data bcm2711_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= BCM2711,
> +	.model		= BCM2711,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound	= 3,
> @@ -1722,7 +1722,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  
>  static const struct pcie_cfg_data bcm7216_cfg = {
>  	.offsets	= pcie_offset_bcm7278,
> -	.type		= BCM7278,
> +	.model		= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.has_phy	= true,
> @@ -1779,7 +1779,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->dev = &pdev->dev;
>  	pcie->np = np;
>  	pcie->reg_offsets = data->offsets;
> -	pcie->type = data->type;
> +	pcie->model = data->model;
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
>  	pcie->has_phy = data->has_phy;
> @@ -1848,7 +1848,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		goto fail;
>  
>  	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> -	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> +	if (pcie->model == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
>  		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
>  		ret = -ENODEV;
>  		goto fail;
> @@ -1863,7 +1863,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
> +	bridge->ops = pcie->model == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
>  	bridge->sysdata = pcie;
>  
>  	platform_set_drvdata(pdev, pcie);
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்

