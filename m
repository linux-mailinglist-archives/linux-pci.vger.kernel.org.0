Return-Path: <linux-pci+bounces-20655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E5A25CDB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 15:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5913AD43A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BD211475;
	Mon,  3 Feb 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+tecW68"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81D21129F
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592773; cv=none; b=aJBa6bfBTsyUiTzMzaOg0lhthQfzBmkLx7RKKVEChyexZQKpiiiff1WwlErXI9QNOo5jf/BnMkwkCXbZ/5LE9itdS7ogPikExv7XUUC+sRiw97OQoBySuCsXwskyKK7VG2NZS93bBpwapLR/RLl4X+92XanjbeqHHqUWh+JCZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592773; c=relaxed/simple;
	bh=eQmN+wSYqNfPSq7/lGm2FRWILAta40UWxadBXdb2dCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5yzMXHAAOKxHF0aWQ572JfCE/2i61knhLwYkwr+Fcb00kYQJZ91K3UhyiGfd9f1PqgMvKH7c90vyo9tTDOkBnczBdixCC3KrLYKYbII20Gc6Hled5YQN8wEUNaji7U5VY4+HHwsxic2nHR0qNlJWIzv/CPnh/cJOGUXwdg8wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+tecW68; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21631789fcdso71100015ad.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738592770; x=1739197570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qwfs5ZTiLlNTPpq6GVEveYLjOMUtMGx1iY3Hoyz/gnI=;
        b=s+tecW689LgIGw0VrSgiByP4ICnBQSld2ZzeFry37wwwBqAKo/17W4SETTGHjCVk2Q
         i5C2T/NddpZG0wN14JcWW7m8ihJZ4jLvg2icw61leP3VuNqEijc69e/o8tYKqTRHuuV8
         8b8emQYOnrtBFCaM1T588AjDUPAX58sPapZS1mrJlV7pQuTSgBLU5/6cEWeEMxogjprc
         Q0bNXnGeHVNZpjVO4bIWUzdWnZHC9jQZcsgL9i2eD/mg2emzKEVVX8+G4imbr5FCfLq8
         LqGapAPASv3xut9E0NRfyT7fo7OC11RFw4frkNlXDqzDCuWIKphqJKQzJbg1WeJPs19D
         J/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592770; x=1739197570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwfs5ZTiLlNTPpq6GVEveYLjOMUtMGx1iY3Hoyz/gnI=;
        b=bSPPudYtWXMQhL9RK4MLUZWMZA0zSDKDMOWX3T5cJ0G13jHRom4rgTrKw5BTCkVUMM
         5bEFpeAIYb5Y8Y9PFqxN+5OpEFAdiJa1zITYFKs3xabAXiX6HU2I1lk/61UvXROnzpPT
         eC8BOLvsJ5mtSbAfTZqWK122EbALXesoKv66WiZU09S2AMgDXVaPRNAmqh7oiwgKP8zM
         72L8A59ZDQOyBs/X4Mvdj/H8DxoYiG3bFF4NVcq46oL1bPhJD900qAH3rS+EyKxQHube
         YUKW2GV8Tk5HD4AWDXpmfosQ1Ab8r3XKNdJylhnheqIOaUfECJIy16tvEtAkE8Um8s3H
         +i7A==
X-Forwarded-Encrypted: i=1; AJvYcCVHcQtk8GziNrohW/3sGkygy3gAGTSQoUjqbr3D2aNN5jmMtfNAwPOhiwEvDZ9RwstQnQDQz4Y4nh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGslChSwDJ0hC99emCvb5mjC9tWDYyltyO4bOzskCVcBESCg6
	CcRd2nbqqkIsm5Or1QcgOWMmHJAnnYEL9J0FQf4lNWalXS1l5LgJQIwlPgtU6Q==
X-Gm-Gg: ASbGncvEAHXZ5jcotUD7URPtiS4b0kBhP4MKcJG3CkIEljO79riCqvZtfg0OfSALuDb
	WGdpmjBhwNzRr3Kk5DxDuzYmn9YSI4oIeE6A3xhUDCGwTSeoY0co6VAu/DqAI+uSBwGIGKJds6Q
	8DHPJJln403zAu2aJf1Yh/6jKhIMnzXX2eRCQ4hqskhELMpoBrM4SuMb9IUq9yvoPZHSQ8rwy1M
	RJzFrduFyEyQoYoglqFYzX7HXVw9Wv+NG/bN7PQ6xWLGpx95Z3QZoDNqXJ9X9lSZVaGpc5t72lo
	A84oVIji+s5F1TYFaJ4YDb8gkw==
X-Google-Smtp-Source: AGHT+IG8vvs+euO/ez1FxBukXMJbsbYt2P49CFmVm6CSf7uQjAXZ4KTRY4SvUqVfvG4OF84t8Yabqg==
X-Received: by 2002:a17:902:cecc:b0:215:3998:189f with SMTP id d9443c01a7336-21de19566bemr244795305ad.6.1738592770645;
        Mon, 03 Feb 2025 06:26:10 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eb995sm75748215ad.148.2025.02.03.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:26:10 -0800 (PST)
Date: Mon, 3 Feb 2025 19:56:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Message-ID: <20250203142604.mh3vx2fzrut5wc3z@thinkpad>
References: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
 <20250124-preset_v2-v4-1-0b512cad08e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124-preset_v2-v4-1-0b512cad08e1@oss.qualcomm.com>

On Fri, Jan 24, 2025 at 04:52:47PM +0530, Krishna Chaitanya Chundru wrote:
> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> rates used in lane equalization procedure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> This patch depends on the this dt binding pull request which got recently
> merged: https://github.com/devicetree-org/dt-schema/pull/146
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a36076e3c56b..6a2074297030 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -2993,6 +2993,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			phys = <&pcie6a_phy>;
>  			phy-names = "pciephy";
>  
> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;

Why only 2 entries? Isn't the property supposed to define the preset for all
lanes?

Same below also.

> +

remove newline here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

