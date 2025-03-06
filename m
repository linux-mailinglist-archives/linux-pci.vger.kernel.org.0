Return-Path: <linux-pci+bounces-23028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5451A54112
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 04:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2313ADA45
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80FF19415E;
	Thu,  6 Mar 2025 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al+nf66H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BB192D7C
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230815; cv=none; b=HosbzejNt9HANWBrY7VYjn0Vu/hrbVE87MCMqDGTEJtg4eyGyJWapQebUkGMkqaUdCUEG7jpR+fJKbBf+PReh9nVq0AdjAD36D6125W1OBtSRkoYuM9wqUqzTm+qPVCHmJmduGQJFgmsv5ZzPwZ7Tw52Rul/NPxAPHdHsjAePac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230815; c=relaxed/simple;
	bh=Tveglffe8ZqIwGSYe2WrroPWZ6zSCid8BKA2Rrxbctc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPLgTFnXhPjR342cjluZ/RxnBN2avIXUVJgZmDdCnAeIrqTkV9qZwBs71QWXqf9udqhZ2pw1xBbzIR7viruoJsoObiNyNZseOiWAH0RfHZ2BT8l6aY9g1ziUXqj8USSEOeaGwc9xhu1CGBgR3vr+IWMKNR9GlFVpBukd79dWkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Al+nf66H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso3616795ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 19:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741230813; x=1741835613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xC4B23ZVUrI+v0nWKIC4hRtohRTbUpDYv0ldFM8Y84=;
        b=Al+nf66HEEs5M50XPaD9As54O3i83iWFQYo4pHJWvRRdBLiBuORBNTX1rjz1znKazc
         6PzI2oBstzsNXgN0tAnx5zMYiRhxVu1cora1nThZu0mGDN6qeGl29I5d51ly+T01NG7y
         fMRZ2SnQGqDqGAFgmuXiZoL2AnhVP3mCZqtToEbQRvNcdD/7rr9/U9WmwnECaEmdwu8C
         pWs8MSWfd3R7RwwaWRjYMHDX1zbBl6QttyeXDQ6pmg8wgOqK0XEz1Yr+vcf8ULWNajd7
         W3ej8KnWlUYbZ2AX1ieRESyQPK/iakPnJtr8i1nLONAtxlyeLgD5V7+PGCi8aJ7pBCXe
         zsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230813; x=1741835613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xC4B23ZVUrI+v0nWKIC4hRtohRTbUpDYv0ldFM8Y84=;
        b=DOpCEwk3Tcq0Y8N7km/yMx75T18qAL+nxIcMNpjiYTEuejnx1pUMpyBz9Xmzyya2yr
         f+6aZlLBZXMXC6TG36FpnLAPgRqLIoNO2nr8b4zowTAG2A+UJNLRvbO63XeXR5AhdWje
         auXfIRqE5/ePA8B9nccd0D+0iEp6fOiRUUc8st3sgpJMt45ih+vFHsqJiYUuAhZLYc7n
         my0WDQsgniA24UFdSrKRJT71axOb2r//swYBmDgD+Vsi58bpWAxmYWXvboKqnKa1stAN
         ZyiMwKMIFqhKC1odGnvudbDOc78ne0xe5GpRjD5TFNU0ydTqdKVrjFmQaf48LHQ/N6Xu
         rfMw==
X-Forwarded-Encrypted: i=1; AJvYcCW8uVQgVJ1vDC+d5QP4V9JhmFZWTCl+uHVsB9J2ZHqO84evtBS+zIjXWBnkFog8827GnMQCyLW5mOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyjYIUaEA8+gX8FSiQzhagvRKqWrtJ3HsVlW/S0pWIvyg6tnd
	MC+xUeCR9XN3oUbAEJhCd4ZCxbwPcDzhUGWDbvb5YtGWnRhC8XIlvOK0xl0Rng==
X-Gm-Gg: ASbGncsTi7kHYz7hPmSVcM2EQ6vTY2nq7akv0D1dlH7rPzh+Kv19YdNDzLZiULfzVn0
	i5grmO/kLddQIn2np4cKnG0gixo+McI3NUp/xSllQ+c0/ylW8UZjyima4ff1NKyDWcRnF2I9g9m
	PvAbT9iClb85wCzHlVa6TZgfWPx7Y+2TD7rtqMfpcA+2Nbk7aPJHZsnVahjnyWjbq+cA3x++3bq
	klLCP5ii/VdbpZLck6rx0vcyZPPy5BBnpvxtAADJIZItqeHWZK3nvksHWf2N83aeMmvCpl/rSeW
	QwdK5yu/SKOz86O6VMyMzFsP99An4o7aPKwlJMlHk1UMN5NmU6pCbVU=
X-Google-Smtp-Source: AGHT+IFy40lU01QwIDD6NgP1MWN6uVEbwb2emHO+b5oCOTPTFjpkYhW+N4OcEkblRt9yRpkBHJpIww==
X-Received: by 2002:a17:902:e5ca:b0:223:517a:d4ed with SMTP id d9443c01a7336-22409457e5dmr21605625ad.15.1741230812657;
        Wed, 05 Mar 2025 19:13:32 -0800 (PST)
Received: from thinkpad ([120.56.193.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91c43sm1613815ad.183.2025.03.05.19.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:13:32 -0800 (PST)
Date: Thu, 6 Mar 2025 08:43:25 +0530
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
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Message-ID: <20250306031325.bmx3p6htwtb6l6ji@thinkpad>
References: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
 <20250225-preset_v6-v7-1-a593f3ef3951@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-preset_v6-v7-1-a593f3ef3951@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 05:15:04PM +0530, Krishna Chaitanya Chundru wrote:
> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> rates used in lane equalization procedure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One minor nit below.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> This patch depends on the this dt binding pull request which got recently
> merged: https://github.com/devicetree-org/dt-schema/pull/146
> ---
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 4936fa5b98ff..9a18b8f90145 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			phys = <&pcie3_phy>;
>  			phy-names = "pciephy";
>  
> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
> +						     0x5555 0x5555 0x5555 0x5555>;
> +

Get rid of the newline between eq-presets-8gts and eq-presets-16gts.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

