Return-Path: <linux-pci+bounces-12503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D853965A8A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3911C22567
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A77153BF9;
	Fri, 30 Aug 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4f+cYvs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AD16726E
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007143; cv=none; b=PUSybxFcLzKfpOhrTAbqGgSxCJz3C1ts+d243x1fauZN1YDaIAOy10BjARp/O8mVDWQDZjv4++d9T6VyH/IJUmaem9CRQGbLJ/cEaEw1Ysf9PAdOmlPK0gIygzpUDqytgogIid98kycmI6esIrJ2Igm8dB8MpM/vwFb1xanToMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007143; c=relaxed/simple;
	bh=QgGIBFmGJcu8oS0bxChlbmIIRpq/P3PoDC6EkqBKtAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFTXcCO4qeCZmX6QN1Eze+nwgJ9a4LIpa+PQO0fhdibudgxeJade4ac/Ts4eiETH6tNpz99hTiAmgByGZ7e66kKOFMbz4jmErPtjborgy6i8NG3eJBhjQwsxZoS5+MBHwU4m5D+wNXiXjKLvLOHf33aGcEtTyJNRj4Z5jdGzZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4f+cYvs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021537a8e6so12883595ad.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725007141; x=1725611941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cCl06/mkbTdzDoh26+WSUkUO8N6VKXw4ZrIDH+64Ass=;
        b=x4f+cYvsKMDypSfQgzqTj09Vpw11SkwBZenDy5wh9xjTzsplAW5SZZUU80GQfFdZ4w
         MrhHUz7yF9rkm5DWU4hKaO/mmxSpFsi2FP8m0qPm9Isk4a1/YlOQKYooX7dcGP5No90o
         uOrvoZHA1PrGU8YA4bzt2PxYAZjzwoFXQlQ2PRfGwRJ4KDTbQpjM6cIEc6aqQVTRG+Nc
         vWrlRRhYlAu6vs63KgjlIC0h4hItGiwZuvrXspLWzVfOs/J20VCxQFQJJrhoEQQgpnnP
         ilfhHCIyhrQE9Ekyvn4IQlEV0/3ZIpR9OpYyg/7vv14lBiPqikwiJI9XV5r9HAs+LOJk
         TyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007141; x=1725611941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCl06/mkbTdzDoh26+WSUkUO8N6VKXw4ZrIDH+64Ass=;
        b=tTrfdaCSgJNgrWjWtG8qWhTZBUdRCKEXX8HuN4U6Aj8304tWxWvfivCrL/MpbZ/3bG
         wVxxEvyTsQBWiB8gOtu9YSd8BvIJf2NM4j2G6G0srHVYzSnETWWB/dBn5gW4k8WNYzoh
         V5c/5m7toYkmWRkierk7U/yq0KVhzaq7oNvoFzdEe58agaMKNnejP7NeKhXatPejxFTD
         I3XierKPXmYMRudGJS9eZozfQ+vgdhXvqmopjlNrSeZNGVhDH3iTLpE9QsgDpfXSjSBu
         g17u+XAlbUNUoREhODr5r+8+KSlK49UH1VtYkdfhsQ+5BsnUrbf5d3X/c1btWxeU5LzB
         jZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG+MhWGm43d9+84eM6XxnhPKdgyKVPrjiWeyAcbk6TeFFTYzETfdnfOO7px6FbiitzH1+9LuBBhjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwV/jN+CAIcPMuKIb612zhiqahG3rTk+Z3QlRyqjCTvktxq3dm
	jUOZupBv0PvUrR3Dus7J5+Nd2fP5K8uc51giRCEvfa/Vp7Ci74RUw7tmrWvx5K/6okD7YKrq/UU
	=
X-Google-Smtp-Source: AGHT+IHrr8qxwqPpMj/6fjnsb+IBk8CE2csKZT9RjyfDiOO3cnN33KW/WbjOQS6JZ6qagTLq0paL1g==
X-Received: by 2002:a17:903:32d2:b0:203:a0c6:91e7 with SMTP id d9443c01a7336-2050c354a61mr46560005ad.16.1725007141481;
        Fri, 30 Aug 2024 01:39:01 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b129dsm22701905ad.42.2024.08.30.01.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:39:01 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:08:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 4/6] PCI: qcom: Add support for IPQ5018
Message-ID: <20240830083852.cwjc6skgypva6u6u@thinkpad>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-5-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827045757.1101194-5-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:55AM +0530, Sricharan R wrote:
> Introduce a new compatible and re-use 2_9_0 ops.
> 

While adding a new SoC, please add more info about the controller. Like the
hardware revision (internal/synopsys), max number of lanes supported, max link
speed, is it a derivative etc...

- Mani

> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> ---
>  [v2] Rebased on top of latest tip and only compatiable addition is required
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6f953e32d990..e814d6cc062d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1722,6 +1722,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

