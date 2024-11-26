Return-Path: <linux-pci+bounces-17338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A829D968A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5189B28BBA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D31CEEB8;
	Tue, 26 Nov 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKBV0blt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5941CDA15
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621774; cv=none; b=H6UXKJjh3QOQuKBWdauYQEKvcrdhT0dtrKacMuLFC9KGJ+xhSbd/v2Xgr8Jz9taT5IUZHLenjpyjMjUQfa4kAYBD6zrlCrbAV6B44e9ol/tSS20EbNToX6J9zisqUKeAS73ba4PcfoDyXym9RJqRbpoO5X7dIcRBaXBgQFqeCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621774; c=relaxed/simple;
	bh=DWw67zE2lJp2DCEzhU+vtzbe6cSTq0sENaYdnpP0uZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jup7kbP7m3uucWD2BZQDmUox1FjY0oAYnnzk3w87tocK4+7CtnLeY/OzhjvRGFFcgiVRR2VA2RF+dzqSiteXgDIDRG4hfzD1C9hftU2rCcTLDrLwPwBd1JkGi6ICuFertjqGFCVJMysUFEn1UpdGO9g2k7KA01DtiDIuuguK8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKBV0blt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so59650041fa.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732621769; x=1733226569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0808uU3LOgHtR0xR0Opk5zAIVpmbB5OAomrT6pxSII=;
        b=TKBV0bltDmspAG7iSS+w1kD5wxJgo/T5eqP1+o0DirQ4d+PtiBVJ23fu5RT6+Q+ZtK
         qob4kY8VWuAPkFvSBL7Xmbfj4mBN+amw+IturHQgPDbp2keJzN8LQazsucF5DOsAo3Jh
         3OnzuSoISo/USTyrnXfz/TR7m10c7y/zXPht4nx4ZT6bICj3xOJ7hDF0fOlmbjedh9X0
         YXhkhjBpvzpqnmOL+DPk9LI9g9WP1yJBuU0wEsvO6HBX4TPtbF2tTu4td1tV0IAtYZNZ
         7yDKrL1nNiqjdbyBh8NvvRTAtkhB7YQrSwzXYrplOz7fOcvCB8VFIpAqwy7KdZPq7LGm
         1Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732621769; x=1733226569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0808uU3LOgHtR0xR0Opk5zAIVpmbB5OAomrT6pxSII=;
        b=dq5zDmBzB3AXbkIjQ6xunBVfbMq7BuyFHztMYgmT52eqOCAI/YF3R53DL22Wit/i4X
         Qzz2H5wIMmywoGseodzk+fj68nLhjkam1JkkafObPu4UXlo+QJc/c9opM8xPV8WVpF5Y
         S3poMF135dh3CJTuGDg5EVmkuk4lmmN9DnHenKlrNUUgkA+xV0hIuHg670bbztgRRL+4
         2l6dTFfery7CzSXZKBVuHMADVuxWuIQ99wU5gs3iKk/+qxHsUrTVFr4gAlzXwVoF2T+V
         1qIZ47w3rVi5AvFq16UBLJHjhFi74ml6NWsvBnkn21l6Ju5OQHx8a9it8H3ZZjkHWDdq
         4VRg==
X-Forwarded-Encrypted: i=1; AJvYcCUNW2rj85+D/HDlPUyS+wq+q4Vj+5qS7viqyVTadJissXw3IacFViOxya7+7+UzA/NPxbIpRUqmtaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2BRqMF1Jmp+2rMVh5yQ09wj36VY/tTSbLewbHP2awjPoT670
	5l9Kuylb5dxdYerCaIiwuT4jT3XtoZ6y5j+iscPouBcxFil4omruCN+GsoU1+qo=
X-Gm-Gg: ASbGncsa0struOe9p9tpOmJmLAgFBptiG+fOMxgJDoU9XLmwXINqwBmCr5UsDu/b96S
	8DQRS9yehD1b8ZNJUI903JG+wOETkpekHqY8uPA3NziSpsPGUy4M8JW/cGLQ4MqcnN2BrGMTqSn
	AZg+yvI/Nm0FcevNKg9sZ5o6xiSGL5wV3DSTrmU7ey/if/qUEM+KbtntA4dr8aMIy3ghnop/EEt
	BfNiqOKbGYG+jq7w3+eedt4RzqQK9a68bliOAlIwNz8YaRn2LINYODSue7A/YQnyLB+Eb1auP/L
	/L9AHUtOAoSRehYQN3+SK2esS/YZ9A==
X-Google-Smtp-Source: AGHT+IEU7idZYH7tdB8+JrK/IxXdtauSD0OGplAdnzOdck3dh+fzMnfl7OJHmYrF/am6b8KRWcNcwg==
X-Received: by 2002:a05:651c:984:b0:2ff:c6cb:60ba with SMTP id 38308e7fff4ca-2ffc6cb62c8mr38677691fa.34.1732621769421;
        Tue, 26 Nov 2024 03:49:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d16f9bsm19527931fa.19.2024.11.26.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:49:28 -0800 (PST)
Date: Tue, 26 Nov 2024 13:49:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8550: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <f2tmdxywunlvyzr22f4uxh7yzha4i7azls6ssw6s3x32w37svl@f6pxwi55y7tt>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:50AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

