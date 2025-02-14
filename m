Return-Path: <linux-pci+bounces-21433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198AA3593C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E8F3AED7E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95333227BAF;
	Fri, 14 Feb 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKHT8AUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A3227B98
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522678; cv=none; b=rYFCQwZLCy2b97f2+ikosBkACmsMZ4ODJGYO7H6A0Xxq2ECimKdgvIMMN231jDME5Se1DIaAMqMgxf0w/x3PhdqGobUqJ4GE2oJLUwZzXUklaEs3e+UcysklaMcNBJOtBrdK9b+nb0x2nSvrMuH2y1RDnx9vqahWPLCrd8O7l3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522678; c=relaxed/simple;
	bh=fjEHbbRs5nHg4MXcaxjuv+AzQnmbn/LO1Vj4x5e+g9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/HCS9ehC+ecNVsSkQHS1l7s3Dvcm0/8N0gJ00K0SkiKdIUEeBcO3CPTebUSPdK54qQew0Z2g12AwXMhpyq/FR6yGzHZe/lpWAp7DU8eddTkezvj+VOMVmFg+NnGncPmK9HB0MQP3ISVfg28tnFeBMr7qv53SqsunfTDbv5omGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKHT8AUr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8eb195aso34450315ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739522675; x=1740127475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ceqbqK+CUw72OCIX9AcVUP6vB2bb9Jm70S/zYtdneEg=;
        b=MKHT8AUrKJj5+NGFgdpVnBtQV7Qr9FhouA7dQTEm7h9eTo2AW+kPSuiO2Y5ai1sKCO
         a5d6RTYvfrjVsaE3M7HlaQ7yMWNTtqbUOSVLatewLxVBQxcuK3AoSZsnD7kLnfYeCVrd
         oauM6Rg3Ww7bFR+/wlnvusIgUtFH62FbZebphbP8W0TjfthwrzNb9mp6b01+IWpIDocS
         OG2poG/JMhq9syw/a4oE7KTMxhY8Uv3pcv7GxNKcvCOAdZKwBH3Ai2kxMsMym+qrTT7u
         fhNt3wmI2oI//opfS6E8zUBAsCvdNDb7a+krtgFcIFSZBoNnvUHy0nkyoC+WEToDL+Lu
         gG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739522675; x=1740127475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceqbqK+CUw72OCIX9AcVUP6vB2bb9Jm70S/zYtdneEg=;
        b=CDPlZH7H5GnMT1XQtecubEURH8YPZykFHwVjY/0Q8EJuxdzuicf0Qi1jkawoJZa5N4
         bgz9cAGkrLW42l9OzAphSc50riN8v9QHrp4tG8I87quPFXoOYQkYOpCUQ00BOy0kgPB1
         IvtydetMqVXPOIMO0wgy+3TXAs6JamLh6LMID0c//H6js31cnT1oZT4uT2styrxxerWR
         1wik7u4fEpHhxBqx6h/Yn+7iSkYkLYV4gOiYC3KFxBk/rk/UlVMY2hm5BXK3tTYriKwl
         XGH1FMSRkVLvGGHtjlKfYelxTsYbLjdc0jhUAKjgctJ7eKnx5lzYRjlnQLImYSXmsgKf
         xyNg==
X-Forwarded-Encrypted: i=1; AJvYcCWpNA784O/6/k6nF1n8QLpcQzOYqSJmN+/nvZ5jQvqzcua/W+847S+6J/8cBaI27tJQId3sv53Poa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOf+8lRisyRoPxhcUAinfZtlxPDqG9p3Jm9ozlMJm5S3z0TETt
	lNsa0bsdMKxd6EuiGMtyuHsvgK2VKFoH+sSqqUns9+znENKwuWof1inYbOJ9lg==
X-Gm-Gg: ASbGncuuXJKQP6hsnIL8BjyDilrthJZ6Y5vtjzRXyYoWa4CL5rioBVwB6u5FPG+VjO3
	FuSOpBXLE5tEoDHvP8Q9m1R6iMY9sQ3XO8mOga6aJWPhoG8z9omV+LBNDxLmZAk4B7oV4z791tt
	ieE0pgfM77nuKgJ2i3fFgfZV9cPxrEj515r5LRCKjZH6MSSGuB0KGsSAxi1bDyKoAEZqN1vyc7Q
	sdRoPZqzeLNFBXon41L9hDdg29gZP6gfSoXSbuuEqWF1C0OKA1fKLvRmYGHZDlmnCZsHrLSCRdK
	BA1rkHvOJ1cq7qiWt8ZQe0EayExrx1g=
X-Google-Smtp-Source: AGHT+IEN8kvNLK7tPERMpY3Zx8RkLW09NICOccWPZzuvH4t8jd8F+7P8elAc+5o7ai9jS7oByn15dw==
X-Received: by 2002:a05:6a00:1c8d:b0:730:9860:1240 with SMTP id d2e1a72fcca58-7322c39c33bmr15562042b3a.13.1739522675029;
        Fri, 14 Feb 2025 00:44:35 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:a164:8397:3a17:bb49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324254681asm2614182b3a.25.2025.02.14.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 00:44:34 -0800 (PST)
Date: Fri, 14 Feb 2025 14:14:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Message-ID: <20250214084427.5ciy5ks6oypr3dvg@thinkpad>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>

On Mon, Feb 10, 2025 at 01:00:00PM +0530, Krishna Chaitanya Chundru wrote:
> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> rates used in lane equalization procedure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> This patch depends on the this dt binding pull request which got recently
> merged: https://github.com/devicetree-org/dt-schema/pull/146
> ---
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 4936fa5b98ff..1b815d4eed5c 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			phys = <&pcie3_phy>;
>  			phy-names = "pciephy";
>  
> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>,
> +					  /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;

Why 2 16bit arrays?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

