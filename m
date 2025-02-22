Return-Path: <linux-pci+bounces-22112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4183FA40A7C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7F47ABF45
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA533207A14;
	Sat, 22 Feb 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBqqc6EL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C11CDA3F
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243792; cv=none; b=UGNWkflVuUtq4Ls9OfOwhNMDeIcBqPwvHx8aKRZ51Ez3bT6C1UEObFkZcKGoAMjSwkZC6DqH2ueG+v1NZBTFmC3Abo72jObTMPAg3RDOn6m613pMav3jYYvz5iPy5J296vyS9XdksrBduS6ani+lFYnm0HAAvIGCoQb+0SJ2fKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243792; c=relaxed/simple;
	bh=FUJp/WAnAiLgR9eo+hD/VF28hg6dM78u44VF9c0HmJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHK0MHD/KLDPkAocJZuqjytWSOgBXg91Y6AMQN+3rWR16pSI7wIkVn9WwJP0or/DUjYkqYjGlKkQpOpyn1A4uzcRfN41cSm/TaVKyBYBtjS8/WZIdaNJTO6zxuxz0ZgXsadFSN0wCu9AGJt5bHHs9XiN/Wqktrsza1lEBrELjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBqqc6EL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211acda7f6so68614635ad.3
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740243790; x=1740848590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F8/d8NAnbtUAywCEyPXFM332P09aVBVi8dqiBukY1kc=;
        b=OBqqc6ELo7o+So0KQ6LGuNGmJNSVYDUhpGH7diuzWaWTHD/RxbnzHF9pb6clRTBh1k
         MBtKrobPM7ddzR49F3HaAwkZHeosMcZIUXMtyR5GiJU+YMzYEgSabPm5XX9DfaYbX8wi
         jkUZo4eqTbY7PrRYA1hrRCnEgxW3+Qti1xiBWGaj1N6+bBRG7gKXCUbWBXkjCJuxN+yj
         aQOIMBzFrKjdBja3sTD7Ds/YD/SxPFS6aJsLOGSoY87CBf/uZka0pDlkO6h+OM4rcI5r
         rP8w7nMQI6BAu/7t+/SlVrGmheOV7bKLoqxCvwB6pz4CtDCwf6JLXVkaIRjAFH83NPZg
         Vf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243790; x=1740848590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8/d8NAnbtUAywCEyPXFM332P09aVBVi8dqiBukY1kc=;
        b=FFn2SeF3DXhfam/7QDtYekIuWaGEMNHmnwqgUiwvQ2oiaXjPpyQAR+JiKj/MAqkTMz
         Wrzrz0uNIIF90QQiOYZHeHVOlXI7wY4CUgKhowgOhFRnp6+8h2Y/yE3sOENAO65RmRRc
         TbwIauM6h9BZQdbOcXkJlCNDicFr9lzluu5oqsWkCYASCwrYx1HL3tmqBlQHsrqeAN0Z
         Y8FPXtX5YuegcWWBefIeCbJpxfe3TQ5ti5aQG4reGvSlNURd6YhR3lJjcNs95sJ6xlj3
         GhGzSixWujLrcChdH44ySZQLUrsylmBbWu4F8T95oFwjEKUV+7/ntKCbEUKxc8eet2mk
         sP7A==
X-Forwarded-Encrypted: i=1; AJvYcCXdnow7UEtPfyex0XfPb7723DePszLj2xg4xC0IWH91dBxI+Jo322/6pN+rk2WgOyc0Eux+thWxob0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHV/nYPvMJgYEn6dbgjPDTU4/M+q/Lhi7BOBbBbLyJBvjoprw
	Mhpm1/a1UbAYlpsigWGOG48Xkmy0uDxbUncuzx1gJzvj1YQwNa83PR37vOCgZQ==
X-Gm-Gg: ASbGncv9FGX635elnxHapFP9Jv/MEyHv/24gzdglMUyMUSydlOYOIXgoKWJeEUdQaFj
	7koTfzH8vniRfb9vMw/wSjyIRmrkGe1rnyiqfk9Cgb2fsVdRcxpqkFb5Y/q3fAlyx4YsJUXO/9/
	lClaefGymu73q4iaJPFklkNqy0I+bT7PcVdupd0+y6/aVt3Dd4OUetQMKz8IL17kEtF8m9iinGB
	bk8j3E8Zv6j0z7snm8YhioEYORH40k3ay+Xc0fEhmpylWBm3b4wT+BdvFwOTCuImdvnP1Dswkyc
	k2QXgMsIO/USV6GRAtjIAOai/G2RgzKbxfsC5A==
X-Google-Smtp-Source: AGHT+IH/uHf1ov30Slxv4c/9kj5MHdTkDqkZgdS5Yptqo8wLkHd6UMxT1CC8C6DAZx5yQsrqPu5wrw==
X-Received: by 2002:a17:903:3a8d:b0:221:7e04:d791 with SMTP id d9443c01a7336-2219ff65654mr122353055ad.31.1740243790339;
        Sat, 22 Feb 2025 09:03:10 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d62dsm151809115ad.149.2025.02.22.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 09:03:09 -0800 (PST)
Date: Sat, 22 Feb 2025 22:33:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Slark Xiao <slark_xiao@163.com>, Qiang Yu <quic_qianyu@quicinc.com>,
	Mank Wang <mank.wang@netprisma.us>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] bus: mhi: host: pci_generic: Add supoprt for
 SA8775P target
Message-ID: <20250222170301.eflilypd4uaqbtrq@thinkpad>
References: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
 <20241205065422.2515086-2-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205065422.2515086-2-quic_msarkar@quicinc.com>

On Thu, Dec 05, 2024 at 12:24:19PM +0530, Mrinmay Sarkar wrote:
> Add generic info for SA8775P target. SA8775P supports IP_SW
> usecase only. Hence use separate configuration to enable IP_SW
> channel.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One comment below. But I'll fix it up while applying.

> ---
>  drivers/bus/mhi/host/pci_generic.c | 34 ++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 56ba4192c89c..b62a05e854e9 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -245,6 +245,19 @@ struct mhi_pci_dev_info {
>  		.channel = ch_num,		\
>  	}
>  
> +static const struct mhi_channel_config modem_qcom_v2_mhi_channels[] = {

I wouldn't call sa8775p as 'modem'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

