Return-Path: <linux-pci+bounces-9107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93449131D1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD251C21BE8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 03:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED89473;
	Sat, 22 Jun 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7SiIvOI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D48BFA
	for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2024 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028495; cv=none; b=NcLWDY85ClObYEpgRVEqpxjZRJcGSggO/qHO4Q19fAtlBFamFyDlp75whVS0/qXfxu6uqIuzRzM84IUfTLvZtsRfdGWwzRrnllqcn4b5lgfk3eJAGbaD8+EBbk4AA46vfDvftaPskLIiRj9iQ45QXvnS4pou3YpxcXhP0hG8aiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028495; c=relaxed/simple;
	bh=/RrUKDL+vW/8zRMMtlS/A1VrV0Bhny/iSxYfghZhlaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR00PQCsa8Hi7dFkWdsMTybiQPbx5qRPwl6zsu/+ZbdCjl5lQEYkExrSmRu96cpZqHO2ZEE8gIq8mCD8beY6EXaBTzhir+fcZ3J45JGC/zMM4AgFSp2lHw77VAXMR3AqQDZEsz2z0qC0bEeXYxjhMM+4Kadb+oDZfeyVKK8bkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7SiIvOI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d22802674cso1430235b6e.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2024 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719028492; x=1719633292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSffjO/WBtMMLGh1Lm5rhFUdKcIwSNJwS+J6sxe4xzs=;
        b=f7SiIvOIb7/WzUEt5oBMqE0uzNZtuluYQCJPglsXbfp9Oc0QdYFQZEVtS5ImRbYuFn
         83Q9xOIJaxxSvy740Ip4OnZ9xnqPBKI3i5WSFkP3Wer5pkdFhPI5gP4s9q2gsMYfqcaT
         oO6JBU5MzAdW8gS7DK7jpOKsayAm2jLOCvNaPWKVHT56/tHJQIKUMREr3OASVns/8a2b
         iwH4+aifcAw+laYWVnXaB0Ai/QoxXRK/y82Fl8lq5UNExNZFySMsYQkB2Zimv0d5PY1l
         lYtUrzMUphb3e3PT+uxj4+sHtieMlQMZEoMFHx57JsKFadvw13Ctx8FCkXXyA6ICVL5j
         sVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028492; x=1719633292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSffjO/WBtMMLGh1Lm5rhFUdKcIwSNJwS+J6sxe4xzs=;
        b=qYAv8cnCiapZsAjyjS7bompzrrRszgRDgCbvuE9W4HKQTru9Kx7xNCtmBH03mgL0Q7
         e/JVnN1vpLCAgLzo5v6vT3JXy7EYo0w5pgC9m3m4il+cSZ23dwPajm8UkWiLGbDMSdTB
         iErbvfOLz/P+CWBkDiYPGwhgQ/xB3F2GtPXcSYPMJPffB3jGqVTORCfcu7XaCZg7+ipM
         SBgqDQHKAjU17MfR/ZGxI0iuoFqdc78fmrrIRHHnGGTicaUjvXMa/csVs3hK2FJskT2q
         kv5enGP9sJsVMnek8pXCLvVUAPaK1gTgA86+bwN213CAmGjl5hYaLHXGBbH3pRboNg6f
         xygA==
X-Forwarded-Encrypted: i=1; AJvYcCWqlIDNIXUd1OPgkiaPYyuLnhc68MCIYKRFcHt5+kX7HyoVh832PA8Zh4p4Yc7UIP7SkHATKHWZX55iH6ZRyvPQc5BDQNC6RV9Z
X-Gm-Message-State: AOJu0Yw1Gk1Gz1P0SbVDkl/bRIr/6nn73H+Dc8Zs9w1t1InoK7FUS8Up
	P+OOGqFG5yf7Yjxcgt7JBK/zy7YOexIHDmld4O9/YYZ7Ui35H8ioB4/+WrM3sA==
X-Google-Smtp-Source: AGHT+IG0cHxivOc0gEpJePUthy7iVVOraPA9vUyWTNoK4WEkmPbaZWONEOU+ohHweTatkWVTWfi8qg==
X-Received: by 2002:a05:6808:3006:b0:3d4:74f3:ebac with SMTP id 5614622812f47-3d51bafb1c2mr11873997b6e.49.1719028491799;
        Fri, 21 Jun 2024 20:54:51 -0700 (PDT)
Received: from thinkpad ([120.60.57.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651301cbesm2165091b3a.203.2024.06.21.20.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:54:51 -0700 (PDT)
Date: Sat, 22 Jun 2024 09:24:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
Message-ID: <20240622035444.GA2922@thinkpad>
References: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>

On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
> PARF hardware block which is a wrapper on top of DWC PCIe controller
> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> register to get the size of the memory block to be mirrored and uses
> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> address of DBI and ATU space inside the memory block that is being
> mirrored.
> 

This PARF_SLV_ADDR_SPACE register is a mystery to me. I tried getting to the
bottom of it, but nobody could explain it to me clearly. Looks like you know
more about it...

From your description, it seems like this register specifies the size of the
mirroring region (ATU + DBI), but the response from your colleague indicates
something different [1].

[1] https://lore.kernel.org/linux-pci/f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com/

> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> boundary is used for BAR region then there could be an overlap of DBI and
> ATU address space that is getting mirrored and the BAR region. This
> results in DBI and ATU address space contents getting updated when a PCIe
> function driver tries updating the BAR/MMIO memory region. Reference
> memory map of the PCIe memory region with DBI and ATU address space
> overlapping BAR region is as below.
> 
> 			|---------------|
> 			|		|
> 			|		|
> 	-------	--------|---------------|
> 	   |	   |	|---------------|
> 	   |	   |	|	DBI	|
> 	   |	   |	|---------------|---->DBI_BASE_ADDR
> 	   |	   |	|		|
> 	   |	   |	|		|
> 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
> 	   |	BAR/MMIO|---------------|
> 	   |	Region	|	ATU	|
> 	   |	   |	|---------------|---->ATU_BASE_ADDR
> 	   |	   |	|		|
> 	PCIe	   |	|---------------|
> 	Memory	   |	|	DBI	|
> 	Region	   |	|---------------|---->DBI_BASE_ADDR
> 	   |	   |	|		|
> 	   |	--------|		|
> 	   |		|		|---->SLV_ADDR_SPACE_SIZE
> 	   |		|---------------|
> 	   |		|	ATU	|
> 	   |		|---------------|---->ATU_BASE_ADDR
> 	   |		|		|
> 	   |		|---------------|
> 	   |		|	DBI	|
> 	   |		|---------------|---->DBI_BASE_ADDR
> 	   |		|		|
> 	   |		|		|
> 	----------------|---------------|
> 			|		|
> 			|		|
> 			|		|
> 			|---------------|
> 
> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> used for BAR region which is why the above mentioned issue is not
> encountered. This issue is discovered as part of internal testing when we
> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> we are trying to fix this.
> 

I don't quite understand this. PoR value of SLV_ADDR_SPACE_SIZE is 16MB and most
of the platforms have the size of whole PCIe region defined in DT as 512MB
(registers + I/O + MEM). So the range is already crossing the
SLV_ADDR_SPACE_SIZE boundary.

Ironically, the patch I pointed out above changes the value of this register as
128MB, and the PCIe region size of that platform is also 128MB. The author of
that patch pointed out that if the SLV_ADDR_SPACE_SIZE is set to 256MB, then
they are seeing enumeration failures. If we go by your description of that
register, the SLV_ADDR_SPACE_SIZE of 256MB should be > PCIe region size of
128MB. So they should not see any issues, right?

> As PARF hardware block mirrors DBI and ATU register space after every
> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
> ATU to BAR/MMIO region.

Looks like you are trying to avoid this mirroring on a whole. First of all, what
is the reasoning behind this mirroring?

> Write the physical base address of DBI and ATU
> register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
> (default 0x1000) respectively to make sure DBI and ATU blocks are at
> expected memory locations.
> 

Why is this needed? Some configs in this driver writes 0 to PARF_DBI_BASE_ADDR.
Does the hardware doesn't know where the registers are located?

> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 40 ++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> Tested:
> - Validated NVME functionality with PCIe6a on x1e80100 platform.
> - Validated WiFi functionality with PCIe4 on x1e80100 platform.
> - Validated NVME functionality with PCIe0 and PCIe1 on SA8775p platform.
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5f9f0ff19baa..864548657551 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -49,7 +49,12 @@
>  #define PARF_LTSSM				0x1b0
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
> +#define PARF_DBI_BASE_ADDR_V2			0x350
> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35C
> +#define PARF_ATU_BASE_ADDR			0x634
> +#define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
> @@ -319,6 +324,33 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> +static void qcom_pcie_avoid_dbi_atu_mirroring(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct platform_device *pdev;
> +	struct resource *atu_res;
> +	struct resource *dbi_res;
> +
> +	pdev = to_platform_device(pci->dev);
> +	if (!pdev)
> +		return;
> +
> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (dbi_res) {
> +		writel(lower_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2);
> +		writel(upper_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2_HI);
> +	}
> +
> +	atu_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> +	if (atu_res) {
> +		writel(lower_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR);
> +		writel(upper_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR_HI);
> +	}
> +

Above 2 resources are already fetched by dw_pcie_get_resources(). So we should
just store the phys addresses in 'struct dw_pcie' and make use of them here.

- Mani

> +	writel(lower_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +	writel(upper_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_HI);
> +}
> +
>  static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -623,8 +655,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>  
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
>  
>  	/* MAC PHY_POWERDOWN MUX DISABLE  */
>  	val = readl(pcie->parf + PARF_SYS_CTRL);
> @@ -900,6 +931,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	/* Wait for reset to complete, required on SM8450 */
>  	usleep_range(1000, 1500);
>  
> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
> +
>  	/* configure PCIe to RC mode */
>  	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
>  
> @@ -908,9 +941,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>  
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> -
>  	/* MAC PHY_POWERDOWN MUX DISABLE  */
>  	val = readl(pcie->parf + PARF_SYS_CTRL);
>  	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

