Return-Path: <linux-pci+bounces-38968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C0BFAFDF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EF9189E07C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE630E83E;
	Wed, 22 Oct 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4vS6xCu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B130DD0B
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123192; cv=none; b=J8JUpy2i2HnztCt1xEeSxvM6RjqNHgQKEZ8QSezjKCiGgdyEyZ6kD0GAp6WLb2KOnwww8X66BGXDhBkrQyrcxLiPrDAviwEMSQV2E+gCtKfGcOjt2aOp2Diy5eLoJwY82iTiIqbfUWlYFD2RRC3qICZyMdL0PTju4lwpiTE1fDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123192; c=relaxed/simple;
	bh=AlKCgkSnSSPFD9Skbx2D0rMe1wy7Q92Jl+BlrTjwwZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTJPorfpLnVEZkYdlfeOmN0Ojz2umvB88Cd3udEiopEgeLvXx/qpNy8WjUGDQFz740Lw0R+vR6St0JTBULDsFsibfbkz1M6MxaTvuHaxsC9xNwtEQAPWQpQ/BGDAGhLORdMg9y7hpVwgB5UDN9QNDQnab2PoL/tHNpGd9XkMzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4vS6xCu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47118259fd8so40973625e9.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761123185; x=1761727985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VMT8mKYgwMl8yULjLBpYiH70IVjoTMUBL7pjvnp2wU=;
        b=G4vS6xCumFze4PR247HPqJYnkGR9llZ6rtlALjCnSKX74MYDu2f4Ot6NQrJXdNlH/5
         sZ9c8lEqjTnBf0H0cooxsz/5q74PKFm+WolFbi8VmJOwz70X3h5bJ7w4088mK+gqX8HM
         ff3he7k/0PQcLGI1FU7ZJtqQaYqHHrp9YA2vWKC8WYAh9wXfqjLvvXnt1EWgGZFSavKF
         Kj34zx9lpF9r8pF/21lmKCU9J1KZqDy8uJ7A0+Qsj508CJLTkCUgQGc7B0Zk1HIZf+yv
         CfizMTFh/1py0kB4O6J3q30+LpjjbiYaMN9zQbIILr+K8pJqV7g/uMKycFjPcCKudplp
         Ixww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123185; x=1761727985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VMT8mKYgwMl8yULjLBpYiH70IVjoTMUBL7pjvnp2wU=;
        b=dTce/H2qFm4pthOifsnF2H3GDyk2/X0nDukGGXNApt/KqBrNEoEmFZizz7LY2PbHyS
         1Ndl2/4dBSD3teFq0lrT+zk0CrQO5nvCB+nWCGQKZZ4oTKYyiETsCLHI7YPBkNXqYHAC
         at8FDxl/GrnJiMd1HNoDGkiH2U27Ob21kDBRVro7BMAl0e8HAyzQM4LthpFUQpvfB/1T
         gc5rPsJt+i6fuI32PbE3pmdKkoyNhRM5bwfM0dnxp6ZIsXlYz1nP28rpaUYoB8kQT0Q0
         mkCrdKudPVyRM8AdDSaoFkPtqLIOMHuf+r6WH1w7sZqCXmxpjjWBnU5AWerm2HT3woYI
         0Z4A==
X-Forwarded-Encrypted: i=1; AJvYcCXMoOMvOopPb7hoCIN0wBP/tkGzJF0DWyKLW5htTWGHa8dFtov50JcqsKOUrbO4IbdxavkMQKEAhjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOP6vNNMrlU4Ag/wcSQAWKpDxq4RE6BxbycCmcv+ih1mIKgjy
	+itHiKjlewYo0lWAdSQIrzFjmsR4w5rp71Bo3vXewuDOo3kXRNmzTn1OUmW5T+Agndc=
X-Gm-Gg: ASbGncs0+PirJn28DaYYsc7nW6Uf6kVbDRyTXdK4CcsOi91HVxXwn4nzgWYwVSC0T4+
	yfzKMrDwpn51kSAG+FTpym0MZdiFi/vdrolOT/7ac89Au8GcKKb8MHWbtKZl0WoOw5PM5AFOP1c
	jz1l52gq9EuTKc5flOzNnkQEs5t3owbg4fBiEONpHeW/w5vGRhi4xJYa43fXc3qSzIzs180n/Uq
	7v7jiTneVdM7ef1ENTOByiBZI/LC/LWra82bAuEQ2NY4a2+zH5vt9zOs2NM57GUUqMhqlBByrW5
	wnnnklFRJ6Z/c786eNnf7e0VZ+TmfDjpIJ2iWtKXvuhqU5cW4s+CoYGdPCDRvItrg2ZpUs0X2Oi
	LNra7cWhbKBlTQ+IIRuXvz6la7Ik6Gl5fnBwDq1fXb0NWXlD3jffGS7NbPw9jNkGmcsw/lH7pdr
	hgSxTkjFI=
X-Google-Smtp-Source: AGHT+IHwyfFfA2sTV/MUe2VyGQQg2MXtrnaRyMgy8UiRtfTE0dePiGALEoLXmNajHTlU4ohhAIWQFg==
X-Received: by 2002:a05:600c:3513:b0:471:1415:b545 with SMTP id 5b1f17b1804b1-4711786d625mr156424065e9.7.1761123184620;
        Wed, 22 Oct 2025 01:53:04 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm34692415e9.8.2025.10.22.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:53:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:53:01 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v5 6/6] phy: qcom: qmp-pcie: Add support for glymur PCIe
 Gen4 x2 PHY
Message-ID: <rxju35izazp7zrzs6vyy2cxuynzc6k4i4iot5pjahwl2bfoka5@cutpfodvixmp>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
 <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>

On 25-10-17 18:33:43, Qiang Yu wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Add support for Gen4 x2 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Since this is something I already sent upstream here and it is more correct:

https://lore.kernel.org/all/20251015-phy-qcom-pcie-add-glymur-v1-2-1af8fd14f033@linaro.org/

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..2747e71bf865907f139422a9ed33709c4a7ae7ea 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -3363,6 +3363,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
>  	.ln_shrd	= 0x8000,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
> +	.serdes     = 0x1000,
> +	.pcs        = 0x1400,
> +	.pcs_misc	= 0x1800,
> +	.tx		= 0x0000,
> +	.rx		= 0x0200,
> +	.tx2		= 0x0800,
> +	.rx2		= 0x0a00,
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
>  	.serdes     = 0x8000,
>  	.pcs        = 0x9000,
> @@ -4441,6 +4451,21 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
>  	.phy_status		= PHYSTATUS_4_20,
>  };
>  
> +static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
> +	.lanes = 2,
> +
> +	.offsets		= &qmp_pcie_offsets_v8,
> +
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= pciephy_v6_regs_layout,

Definitely not v6 regs here. Needs to be v8.

NAK.

