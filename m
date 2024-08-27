Return-Path: <linux-pci+bounces-12263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5A960732
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C181C22937
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F31A0711;
	Tue, 27 Aug 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGnW70Wy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3F1758B;
	Tue, 27 Aug 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753611; cv=none; b=oCont+uuNAENgXR/5LYa3TtofqRpt/2wVDu9g/pBHTeNb1h1qqw7lapn+F9QxKGeNVQljxy4Mu5QmBrkaNotNfsH+J8HIbKqUz61DAbY9RLPN/dGsptGlBJNziCW+JJxHsjbZCfZXOafCa78cPqe/OdrtluCDkDY++CUdFh6aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753611; c=relaxed/simple;
	bh=ViaDqzwpYnvS/bHWsMjQGqwKYxil9jck0BPMVINQhRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWoq6cUZSGjsGmn7N3oAgYaPjgvnZgne6jBlEqAAAWIk/AKGi6xSSEZuIltgBHFSWu+GNW4fDKxgSjghSbweHlc9cEe8YhmCWGdgvKVyBDyZ4OtKkBGqcKDqFhGMXj8kSbgf/0+8ZUzAzWOKlGre5gSBQ0Qo+Lkt9sU3zDUL98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGnW70Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9938C8B7AA;
	Tue, 27 Aug 2024 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724753611;
	bh=ViaDqzwpYnvS/bHWsMjQGqwKYxil9jck0BPMVINQhRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nGnW70Wy5l1GPvGwf6j0XLOnZugSDqYyDrtIhlTTmNZjGSpSiPVjBDJzL4XgNXOMS
	 QOQF6eZiXBaDzgmnLto7XoCBPsp35WnouB569nfca19j9fki4xfRLseD18xbRkoebE
	 Vl8up2lmG2pfZ75ap3/rbb77e/rekOrh/lfUq4jLat8wQns5a4y8XshHAoUgdzOLm+
	 At3THsWikTSGe1455twvEjvE9RB+DCZb2C9KnzAUoAdd06pcYyqVq64T1Lg6mry+CB
	 MM1zl2+Y5LBnMy/p87y/ijhNT+9DrZ7WOmUrIqjPw9clI/TGEnHs0SaCh0C5HvjSXw
	 9aNr0SV2kmp6w==
Message-ID: <a16b2ae5-43bf-41a5-9a6c-9acbddde36e2@kernel.org>
Date: Tue, 27 Aug 2024 12:13:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: qcom-qmp: pcs: Add v6.30 register offsets
To: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-3-quic_qianyu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240827063631.3932971-3-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.08.2024 8:36 AM, Qiang Yu wrote:
> x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8. Add the new
> PCS offsets in a dedicated header file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> new file mode 100644
> index 000000000000..9aa6d3622c24
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_V6_30_H_
> +#define QCOM_PHY_QMP_PCS_V6_30_H_
> +
> +/* Only for QMP V6_30 PHY - PCIe PCS registers */
> +#define	QPHY_V6_30_PCS_LOCK_DETECT_CONFIG2		0x0cc
> +#define	QPHY_V6_30_PCS_G3S2_PRE_GAIN			0x17c
> +#define	QPHY_V6_30_PCS_RX_SIGDET_LVL			0x194
> +#define	QPHY_V6_30_PCS_ALIGN_DETECT_CONFIG7		0x1dc
> +#define	QPHY_V6_30_PCS_TX_RX_CONFIG			0x1e0
> +#define	QPHY_V6_30_PCS_TX_RX_CONFIG2			0x1e4
> +#define	QPHY_V6_30_PCS_EQ_CONFIG4			0x1fc
> +#define	QPHY_V6_30_PCS_EQ_CONFIG5			0x200

Squash with the previous one and the next one, and please make the
indentation consistent

Konrad

