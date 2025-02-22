Return-Path: <linux-pci+bounces-22109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA377A40A54
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760823A8975
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A661FF7B0;
	Sat, 22 Feb 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwQxLk1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B661EA7EA
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243046; cv=none; b=UJt4++rqB7WHfUNwjYsOzoLCjbj3fvC8EMWrBZ0LSYYcM7A+gGPh9ZXSAi6lwgYX10eDt5iU1DNB3p2uZbsHW9zOhH1td2xRMnsBjLcCYLN2xuEC5Lo4ViWhjKedVXISvhxJP5J/WgwD9sYuGiKlxocleGeJOVvABnMGMw8Y+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243046; c=relaxed/simple;
	bh=/OChm8Qzq++h2Z0XzJa9A1Q8OC0xJGEjGJZCAa2C5lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfnsou+yZVKeKwVYWQRWHvhpJdzQ4ZxDtlNU2YeOuBeXUA+tMl8vhkT5kp4DmPXsxe4w3x1U+yadyXHzbJcP8iIpmMXqWYZXJoyQS7Qd6IfCpktv+OpmlL7AzoNLpwwcPz4zZzWha0xV024KRUd0EUP5x6qldkye2qSydmzy8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwQxLk1w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f4dd756eso62331145ad.3
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740243044; x=1740847844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nh3uPvkc34gfmbS9x9Jf9cyF6fwE3/AJhfsNKJ7Ug5s=;
        b=zwQxLk1wHPc+FGHKgpyd9Mqngre4hZA3l5IC6WkbMOzm7rqF6cegvD57PfKf8k1L/T
         4t7bZoVUKaeFLZQfsepgj0Fe5rVDtLOv2lzIQXsuNvaoSDAiv201gTdcAHgITHw5rkj9
         ypqa2UAHKo6B92bCG0nuCjD2nQ5HgfCvbkYdJ+cahdmys/9LbBGGl26AZsx1wjGxKHjN
         goEnh1Rajslt7LwQXA6OLXS/DUWtEkJR6MBlh/2voNStEyHRK2LQ0OTXPdYHTMOyFxag
         SIiyhWtBPtJPEni9kr5/NTimAl6mc54jLfPUZFPwa9aBm7nir8sQBeiYgTZdGuT0/iLn
         r38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243044; x=1740847844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh3uPvkc34gfmbS9x9Jf9cyF6fwE3/AJhfsNKJ7Ug5s=;
        b=YBiwUQAXTvO1tucxsYR8A2vS1JJnaNXpbihhezzRDj8SNpIdJjc+iK5Gw3bKiRmECs
         ZUz56ASrWj6ybj40qmtyMkUlHP+6JaPgLwlxGaJLC3gzrSxfkCiGwN9kcY0t+2eFdq5Y
         Ro9GXz8zc1SUrzjhhTsZ/Mrfp1+IdAu5I62M2v0hreGl2J4w7tIbbZBPhPG7pVpBdusc
         Ab7Af8qNSpi0++VeMZSTNn90XEubX+yEussVX8BZYHZp4d8QeMcMKMAJI2QiEBBhmgsn
         1IrThx986/pLIpH+SSvrQk8NJEFylZ92pDdX/x4AU8kp+/KtWssZWqLUNHreDytKGg7l
         dNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY++7aNwV9NWlZLbpxBEOiFhdvbH720yD5dRN+FzLK5i3CbECM8UiRrJ6SQxLrzzSDdquXaB1W7+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrfEyAKDS07fqmRk2bqgMALrvDjUASppM2XJCo2HGj+6MDtvh
	maEvSvCpE4bQVu1AdN0TmnYpVm3PYQJQx46KzCChDvEh2cLuGkji3/8ABoNCnw==
X-Gm-Gg: ASbGncs7JmDY/mfaFZh7e7UzV5E4WtVoOM3sru1DdDNeMPLVFF6LobY1n8BMS/xXm+U
	RvGJkeQLAL/B5BrBAqnOk4Qhx56cpRPo6KumUm4xHq2xG/TWsaHR3r3P4QPH43IWbTRzh/hFLBY
	Q3zevIrwMiGOAxeFRvx4Z9BPi3xS4g6bbKlpv4Pesf2GuEDqgfcV8LLB8Vp/dbxOQVUPiNcxvf3
	jb9KmUS08prbS2tIFe5BnbhOqQJ0Y7E5Oco2kLzYXmw77IT396RxNGi79VgwGpZbPxLYBLhNq2A
	/v1m04QUBOi1zeUmWn+XWf24Mz21iajuGO83xQ==
X-Google-Smtp-Source: AGHT+IE+8VM4q3PcS+7asdjIzH29CbmnLh7RVggUoKvA5I0EZzfah7IwjW111tGxF+X6VyOekWmPqA==
X-Received: by 2002:a17:902:ea08:b0:21f:988d:5756 with SMTP id d9443c01a7336-2219ffa35c2mr127317725ad.42.1740243044225;
        Sat, 22 Feb 2025 08:50:44 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53494cbsm153853295ad.43.2025.02.22.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:50:43 -0800 (PST)
Date: Sat, 22 Feb 2025 22:20:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Message-ID: <20250222165038.eyausqiccrivkv5t@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-6-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-6-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:04PM +0200, Dmitry Baryshkov wrote:
> Enable PCIe endpoint support for the Qualcomm SAR2130P platform. It is
> impossible to use fallback compatible to any other platform since
> SAR2130P uses slightly different set of clocks.
> 

Still, why do you want the compatible to be added to the driver? It shall be
defined in the binding with the respective clock difference. Driver should just
work with the fallback compatible.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

