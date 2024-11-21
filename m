Return-Path: <linux-pci+bounces-17188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57F9D559B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 23:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDD1B21533
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0E1DDC39;
	Thu, 21 Nov 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3rBFSj+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFE1D0E20
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229062; cv=none; b=dN6wqZIrR6QTNje58F/EefCqctybs+Mf/P4esl08792Nz45vx0CfpdanatQvbxuQ5wIPM+fC82AKbzFFkCUVbzGmVQ4syzgLameuMxeoHyU0Q19iGhDpEAywFJM8hx9zKdi5dc+CNtlHbBs/BsV4M6cAWmNFrpkcgVal9bvLg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229062; c=relaxed/simple;
	bh=UvqKl313UbCoQrV81fFTtqVbmffHswlTT+HQtjKyoJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3WaT/+eDDuCPIkAixrHRA/qe432yLQnRUxwhfG5xFhpTvf5roYiz4XoiTp/CMG3I/BlSM5jqcqAzdkfFgSlP9gN5+hiy2OkF/8zEL6vACPgNLDf84KuV7B+Rzmh2uFuq8MeuEh+d2/Sp26qpk9CMZVFRD+6k45zwczgJYEaYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3rBFSj+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso17108401fa.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732229058; x=1732833858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/Nja2Bb51yLaelcKPmFVLsubQx3+cZP82+7JwtW4Xk=;
        b=g3rBFSj+cdb2AX+iX48C7PMjjZFTT9h1MTUkIcCOyk7kbfnHV0RQ98W6nG+aM+CHQi
         3+9kVmMUWjQ2G8aecV0N1XMwYRQPZklcZ9ygPLE2/Fl3j0MUK3MZB4f36NMCdzX0EnNT
         URfeh+mcVCEb8RdKF7Zl4xRAZUgDA6UTt5ateX3z3rmudcKaahZCy7GrUcODVke95y3h
         O5MkiBqtIvIdfqR86hk433wRxWZxPAVkcr7YoPzkd5et3/aG4YuvCzZYRpW+StKni7NL
         0RlVXsdrwTzq2P9UI6g3jzblCafTbRdWHLGlKTjheJjl5pcgfPyedBBD7CkWvSPCFQ2Q
         OZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229058; x=1732833858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/Nja2Bb51yLaelcKPmFVLsubQx3+cZP82+7JwtW4Xk=;
        b=mRxl1nJ41+WeuqWfIeg18fIBd6XdORnVaXNviNZoBje8RzWP1OeygepNckSZF6htrP
         fRRpNQrLEo5TrVVtAC8ya70pXaRtkX7TcsM4VDlCR64jMtV6V+ngmwnFjAz7Td6LlHTy
         wmvw0OZzDJ7X4jhsaxLfm813wdwJJQpupQvYQjfqM4IKx6O91U0J1WWAtYic2hOs/qSm
         7yGKRu6L13MHUuOhJmsyMMUKqFPlXCd4E0PsqXkTn8KoeicWBPLT0pEspRt+W/E/C/Lh
         tPqOskcndkXuBC/L/UhFn8zyDTaTIcE+8GD+TFSrt+SxqzMa1nkGOudqnju5jk/QJtdn
         4xxg==
X-Forwarded-Encrypted: i=1; AJvYcCXSdJHLzOqddP47LBIyy9DSoa9GSfq/AjQemmrEjZ56BZqvqR5s78xViThGheKZmVNMtP/jkSmifjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8y3KQBM1two+wEAQ2P9sJPmwlSiKbXapF9Pui1Jlzn4aos0Gm
	w1GuttpWNIvnELo87PAywyKCd0NJ/7rRTP6uO0NA5Jb9qfAXr15JqVv5SLZBhP8=
X-Gm-Gg: ASbGnctS/woSYuLmu2GbW6tMuufoo/o+UqFnCaU+vmbRSHwbROxOqRETc98hFDuINuc
	9ZCNzQmlCfFFVnGCx7ATwLRH+bNmh41Yl9CDwpepo5JtkydilRg7RzXwcvdeHP3IuKnRT3QhrOv
	EtbRUsNiELEKjFYqlKQLFHzQvlrG/Lks1FkCUYv9R827WhO7EKAuTgX0/yMDzeLcUyEzl3Wotpm
	w7JuPFBPfI3/v9RhSTkEb4udDXi09QGnnS0G8x7zEo4z4whR25Mz6+IQfekviCt1q0ri1rCdqel
	ILmxBIC0cpWChlIOdtzeJv+HegyxpA==
X-Google-Smtp-Source: AGHT+IGbReTR075Ouxz1EQlRJI//zuSXefAabMn1r5zxrv9eXDCoMRD5JejlOdypknkykXEjg8Eg3g==
X-Received: by 2002:a05:651c:221b:b0:2fb:5723:c9ea with SMTP id 38308e7fff4ca-2ffa716ce5fmr1747681fa.30.1732229057836;
        Thu, 21 Nov 2024 14:44:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa53769f2sm665281fa.77.2024.11.21.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:44:16 -0800 (PST)
Date: Fri, 22 Nov 2024 00:44:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add node for
 qps615
Message-ID: <berrvurtuyujkgy7q7hn3flx5lfusrskxh5bo7xvp374zojcro@v5mkoea2xkds>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-2-29a1e98aa2b0@quicinc.com>
 <ngjwfsymvo2sucvzyoanhezjisjqgfgnlixrzjgxjzlfchni7y@lvgrfslpnqmo>
 <yjwk3gnxkxmhnw36mawwvnpsckm3eier2smishlo2bdqa23jzu@mexrtjul2qlk>
 <a4146b5a-a229-4441-b123-d13e72ab4472@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4146b5a-a229-4441-b123-d13e72ab4472@kernel.org>

On Wed, Nov 20, 2024 at 02:28:29PM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2024 12:03, Dmitry Baryshkov wrote:
> >>>  
> >>>  &apps_rsc {
> >>> @@ -684,6 +708,75 @@ &mdss_edp_phy {
> >>>  	status = "okay";
> >>>  };
> >>>  
> >>> +&pcie1_port {
> >>> +	pcie@0,0 {
> >>> +		compatible = "pci1179,0623";
> >>
> >> The switch is part of SoC or board? This is confusing, I thought QPS615
> >> is the SoC.
> > 
> > QCS615 is the SoC, QPS615 is a switch.
> OK, thanks for confirming. Just to be clear, I understand above as: it
> is only the switch, nothing else.

PCIe switch, networking interface, but not the SoC (and not a part of
the SoC).

> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

