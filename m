Return-Path: <linux-pci+bounces-4708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02C8777E6
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33705280FD4
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D70A39AC7;
	Sun, 10 Mar 2024 18:13:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49D39863;
	Sun, 10 Mar 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094388; cv=none; b=KBhaA5QTQC9BhxeQr5DSqRDyIhpVi2PenEysXbnDj0HC5nNgQpY591pJ2X8vt43QzIaEUEOa1Jm4Eikev+iTWVvEGeFaJzl0LvPbMWS9iZZ7HUbO/HjutfoRurf88mX6BJvgbNMbBboVy6M7VLOPhHknfaaurPOcCntSZB6r6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094388; c=relaxed/simple;
	bh=31NKrnRH5dFaplJw4DbeWRwaNfoKl8qEijx7BroJy5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8DJwYPSfRbpS90TY31jQEWR4+MkbYHzQA59vG1XqTjLbLN/mkBKdi5up9tF40s7+mNzO+700uJZDj20s6Ye88vpYXKht54bEPNX3H+Y9jkrm8MDd61lAa8YZoI74YS8s68hKtO+AWQLV9D/vOg7haUPw8FQC3CjNupjKcMCeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1ea5f29a6so1748029b6e.0;
        Sun, 10 Mar 2024 11:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710094386; x=1710699186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBvlVGpVqyqJ+GndspiX4vT90fBq7w+3KkP7LKnDchY=;
        b=WklrimB6SWA6zTvhh7LlqtmqH8hk84WfTotECaKdg1fNKtooRGKWxdmOhP/FBZiPZ7
         0HhgvDLWkeGrmvKzgX7mjvAP1WckLVsxbaj7bhT9W4FepoMU1uKbF90kcR98s02oSNrp
         Vpzf8kZTyRMzjbHlptAsy7zW6EnclMO0eg30TcR+zEE3/deNimKe8psgPyu972ESRVHX
         ZCb4uHHwU99r0jBPYmoEHG2bycMhd1pQdrfhZLg3ChYTfUGAVC+Ip6IdCBukI2ttnMrD
         rdzBvyCbCrlBIRelx/RlhasLkYZAPsmtqBnqzAGo5yISGN4918aIcsZXUYDZ2Ys7ikhV
         NEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKc4M8xX8Fj1xU6g4qJKSTHmzCfDiA3kXPr3nLnLMC8+dvVZkkT9fKQr13FVwK/hxX7PffuhW22Ro5UhW6yJxiUzEWrZuKtd0UzJzpFkWtMvs8TfMYRpXG+L6yAqGxWciB0Lq6wFazr7k4jQix+c/xmFbJmY1Ixrn8rZNXtoT8jZvTi2Ob93txTHvB3vzUSjeEN71nLgG5RPBCB8orLMKuhdI=
X-Gm-Message-State: AOJu0YweUDa8PvszS4pNaXzl+WayGRIMUd/eAzECv0XxPFQ1UCKaXCah
	Q9xAyO1wYfsCBb72+qBhsoP/wR3DIesaGPgQyUCtGV2wAaimEY7nvElv9TkkR7Pn6Q==
X-Google-Smtp-Source: AGHT+IGVAimsnWCDIkv4L5Ym9UHwsmJpuLZx9Xz5cUuDoUCwpDRHYKB+yoIwoIMMuPrE6+aE+XU/3w==
X-Received: by 2002:a05:6830:d0:b0:6e4:ddb2:29fd with SMTP id x16-20020a05683000d000b006e4ddb229fdmr5341989oto.4.1710094385930;
        Sun, 10 Mar 2024 11:13:05 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id p1-20020a63c141000000b005dc389409c1sm2740768pgi.93.2024.03.10.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:13:05 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:13:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/2] PCI: qcom: Add PCIe support for X1E80100
Message-ID: <20240310181303.GB2765217@rocinante>
References: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>

Hello,

> Add support for PCIe controllers found on X1E80100 platform.

Applied to controller/qcom, thank you!

[01/02] dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller
        https://git.kernel.org/pci/pci/c/692eadd51698
[02/02] PCI: qcom: Add X1E80100 PCIe support
        https://git.kernel.org/pci/pci/c/6d0c39324c5f

	Krzysztof

