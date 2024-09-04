Return-Path: <linux-pci+bounces-12760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD996C1E7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594E51F22264
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C861DCB06;
	Wed,  4 Sep 2024 15:13:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CB441D;
	Wed,  4 Sep 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462792; cv=none; b=Bww3kYWxQyWTScnhhPFiFSFwd0AlvDNDQEDk8HuukydC6XNFG0mOcdybI9W6Rj0G/wjqGFuFyf7Yeie0LtaCnqvx1uf3gDxP9+p86ZUhKrNg6WsProzCEdWVP3hH9wycV3+neXXDcIjAJvHjNXRR7OI+aH6tvjlzRd7/6Wcnu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462792; c=relaxed/simple;
	bh=/DGBtlFYKDZRWKf2/ba5/BFuB5/JsdkV9f2pxRoQSXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5hEZ4SnmXXGAd2msQdZmikE1jfSt1m94DUAPDveRoyZFi3gKR1K3h42d4QvtB3A9RcA1AOecvaR806rTgx7ICiP1JClHKw2GCTD7pQXu6uiiztRe2grLqMMvPIXetfleeQKGuZwOpYJjTgSI0gH5yZQT97Rq20yAmgqkqJ4TrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso4468257a12.1;
        Wed, 04 Sep 2024 08:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462790; x=1726067590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivjOCtwL1MuquUZhXGOmvJyQVtsvYBgAgA3Ekxt6MGw=;
        b=uQKTg8rSyE8c6bFdpBg7bYip42KwAzH7PufHcd3SsQTB7LFRsgR2GLe84bWSl2Djnl
         KCCsTM1gB/33gLQp3cAEu39xCohCFi4GiLBAB/Q172Qr6dMrpF65/kxvenCCqyiIdx2J
         fJRWVr48phrVmA92GObAVvQMFCJZnxoP/tS2ugrgxnbt75K6UScKQ9ZDqjCltYSyLQfu
         DE4wOjFgv1B3ejfX1V23bFhSRsPZ8NSD+lznpceu9rva+jt9oofwT73vTWfs1aOorRlJ
         O10zaPTEG3UgNYbkogOSWwSJkabEXRaDFhNrKBmY0wF7m6XWhn/WxQsLjSJOdJZW3j9+
         2sKg==
X-Forwarded-Encrypted: i=1; AJvYcCUUGqO63QbecSdHXLSTeMIG4w2EGOwBhnApfPZWvFEsUE2CmXlHOwr6LwolWpYAcFiFGkOUdOnhjbJKPGsO@vger.kernel.org, AJvYcCVjVIy6ib4o3F76rDRiVOtVIlY/5CTQCl/YMVXFCy0fHS4AISkQhE9VE1gwhMa5m6/edrn8gHPGwGUx@vger.kernel.org, AJvYcCVo7/u3H+0XB8d/LNZSW4BBQ9Ij4Ut7HuYZbHxJ+ADgirP0S4/fotsgH3jNkzFKKSVQUWp70DyFe79B9LdxOw==@vger.kernel.org, AJvYcCXFtRoRmfK2pgoxT88li/mm/pq2ZzI5oGax8wS+EWTpPo6Z0ItwZ5Cd72CUtqWrfm4GbCqirc40O4Xn@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbQztnvFkTmIiIADw9KVJaBxuQ65IYa2cjvWyifuJS/mQ9AJh
	5AnMe4e/7pCtXsaONPSixvcMHnDZlsOKf4RT+6MO9bZaQJBGKPyN
X-Google-Smtp-Source: AGHT+IF+R8Eqkjry8ETzXav8GDTWNMAATESLwxHOr/QIbCJ4LRTUppFimrA3sg1E+zHwd1dNSBIR2w==
X-Received: by 2002:a17:90b:3602:b0:2d8:8d62:a0c with SMTP id 98e67ed59e1d1-2d8904c0c69mr12959213a91.3.1725462790339;
        Wed, 04 Sep 2024 08:13:10 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8c1692767sm7435559a91.41.2024.09.04.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:13:09 -0700 (PDT)
Date: Thu, 5 Sep 2024 00:13:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom,pcie-sc7280: specify eight
 interrupts
Message-ID: <20240904151308.GE3032973@rocinante>
References: <20240722-sc7280-pcie-interrupts-v2-1-a5414d3dbc64@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-sc7280-pcie-interrupts-v2-1-a5414d3dbc64@linaro.org>

Hello,

> In the previous commit to this binding,
> commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema"),
> the binding was changed to specify one interrupt, as the device tree at
> that moment in time did not describe the hardware fully.
> 
> The device tree for sc7280 now specifies eight interrupts, due to
> commit b8ba66b40da3 ("arm64: dts: qcom: sc7280: Add additional MSI interrupts").
> 
> As a result, change the bindings to reflect this.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: qcom,pcie-sc7280: Update bindings adding eight interrupts
      https://git.kernel.org/pci/pci/c/364cfd8a56c0

	Krzysztof

