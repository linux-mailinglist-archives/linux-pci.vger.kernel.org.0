Return-Path: <linux-pci+bounces-4385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15F86F9D6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 07:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AFD1F212F1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 06:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04135BE5A;
	Mon,  4 Mar 2024 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmWvIpHY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF02BA33
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532432; cv=none; b=d8VuSQ9kXqzFQ5Y7M5GCh18NGeY5VRzZeJH2mGxCTv2+P+HbFG12loCOx7VlVPJH6eQPsr9W2ZGFlwO1eyHTl3y0QKSSv+BmSPaxbM9s4B+2xeSFXkaZAxP7FN7KC/i2PRTnfdjg/PjkjKF8RR3KahlVdOntwjcdR+FFB1sgI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532432; c=relaxed/simple;
	bh=0WP8Ltd4+HZ7yFqiob65ZX8Kr15q2vLC5UlPnNe9mBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KThoYOjnQLpzXfyH+V77WMIevPWN4UYOgw6x8dr/GKSw020xZmpw3wbINJ3Na7QoxfUln5PzZJKS6bnKmcjx2Bx/zpoaOZvbFAMnrnwOwb9ayTqyjnVJYafeMedkbu+tf2d5rFOOUxYvUQeBbj4U2/nKMGSa7LXs6emhuNoTl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RmWvIpHY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd10a37d68so4852005ad.2
        for <linux-pci@vger.kernel.org>; Sun, 03 Mar 2024 22:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709532431; x=1710137231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhEJRlvCaCR4wDqO5rRMM6OSqb/H9Os2oUv3uFwDX/g=;
        b=RmWvIpHYTx6naKUeUfRcZ6vzg82p7PDDyf25ongV74N3RNh0ebYiSQdA3IL2kczw9L
         NJ7PrJK8JDUJp2Lq9pPIt55zhEh8mO6gvuS9WdvawohLIz0tzlbqVIwSz/J88joDmp1V
         euWGgpjH4pRLtqruPI8TTIi6UtJ/AX2jJx/I0zh76jgOovvyUfrkHZSk2yi23vlb+BxM
         Fexso6In3kxtxNl2Aujxyopo1LkPp+kC0GgDrBOyyoLmgGRz6NM9EF1IxclZHrA1dnc1
         PbLLiLT0TwLw2EwfIPPmnVkgF3MNPvlDy04bCLttJ+PAFDFU6hUvgklhqxisH9LCQ1pX
         b2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709532431; x=1710137231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhEJRlvCaCR4wDqO5rRMM6OSqb/H9Os2oUv3uFwDX/g=;
        b=UFYt83nF3N/H3ev0Ew4a9cDNywvtaevXeXRG2dZ/5sGUWPIZsUv1uBP1uzcqWVB4CA
         7h3fA0ydPK8VOEcmyzq3tMWRJtqD5Sd0wo5oyRhCwycfU9pSDGkvxHHeDTfcMaVr/sh6
         X87gauNIW0VFs7PvaGnIuWmKb/RzklMkrQRMbOkjrTcsfz1Qttym07tD9koE9Eft/GU+
         VUseG/T2ma6iwdB1VsFlxWlQRUfNbR5bOywcOXezcjRA6fvfl83vQzqRLGzqZoWFTo7X
         iEZyYOFoYTw6Ac53ZsJ/MI+R+NU5hfUmit6PNNHA1qKiegyZ+u+UO4L4p7uDT39PhVLj
         6F4A==
X-Forwarded-Encrypted: i=1; AJvYcCVIN+iIxfltfH3VhaACjCF4gPb8k0DPteYM00ZeHTshfmrZyN0pug+R1zKH7oB1vWpXHlLSnJ5NjEW7u5wJ0JFIHuGkdo0+HccU
X-Gm-Message-State: AOJu0Yx0waFWL4WjyHG7KQTwviLh38TKUKmpNrLOf5N5yoW3zZKyRhha
	VjkmnRKfKP0oFf/zhU0czL4lEHBeGau3SSIWiLNz48W7TyoDpPfjw/9ReQsf4w==
X-Google-Smtp-Source: AGHT+IH2zrIOPzr3AI4ZasZTAXun5czB2o+PuFfZI1017C8l5WdYVlq8oSSCVAQTv+1lcEPhiCemaA==
X-Received: by 2002:a17:902:9a07:b0:1dc:7890:cb27 with SMTP id v7-20020a1709029a0700b001dc7890cb27mr7278937plp.48.1709532430393;
        Sun, 03 Mar 2024 22:07:10 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b001dd1029db99sm1395975ple.4.2024.03.03.22.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:07:10 -0800 (PST)
Date: Mon, 4 Mar 2024 11:37:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20240304060700.GD2647@thinkpad>
References: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
 <1708697021-16877-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1708697021-16877-2-git-send-email-quic_msarkar@quicinc.com>

On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:

Subject should be:

"PCI: qcom: Override NO_SNOOP attribute for SA8775P"

> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that there no cache coherency issues exit
> for the addressed memory on the host i.e., memory is not cached. But

s/host/endpoint

> in reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.
> 

s/host/endpoint

> And worst case, if the memory is cached on the host, it may lead to

s/host/endpoint

> memory corruption issues. It should be noted that the caching of memory
> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> 

s/host/endpoint

> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> platform. Assign enable_cache_snoop flag into struct qcom_pcie_cfg and
> set it true in cfg_1_34_0 and enable cache snooping if this particular
> flag is true.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ce2a3bd932b..872be7f7d7b3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -51,6 +51,7 @@
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_NO_SNOOP_OVERIDE			0x3d4
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>  
> @@ -117,6 +118,10 @@
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN				BIT(8)
>  
> +/* PARF_NO_SNOOP_OVERIDE register fields */
> +#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> +#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define DEVICE_TYPE_RC				0x4
>  
> @@ -229,6 +234,7 @@ struct qcom_pcie_ops {
>  

Please add Kdoc comments for this struct. And describe the "override_no_snoop"
member as below:

"Override NO_SNOOP attribute in TLP to enable cache snooping"

>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	bool enable_cache_snoop;

Rename this to "override_no_snoop"

>  };
>  
>  struct qcom_pcie {
> @@ -961,6 +967,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
> +
> +	/* Enable cache snooping for SA8775P */

Remove this comment in favor of Kdoc mentioned above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

