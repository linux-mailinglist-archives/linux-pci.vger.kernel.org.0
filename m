Return-Path: <linux-pci+bounces-9535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998AC91E987
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D31F21D50
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8F16F908;
	Mon,  1 Jul 2024 20:24:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF452AD0C
	for <linux-pci@vger.kernel.org>; Mon,  1 Jul 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865476; cv=none; b=Rreq03UBLa6goOqy+kV8KH5WMLSNbajCTdf6srovU06/s0iurSHZ7r27j6Y43wFHlJD0eS7yJ2dIVlLzj3xAICJby1Hn0XX4j1erCWeT+oC50wvLCNCroe7YOfbP5ZnKfOrfAP2inVTLkJJtcjADhTz0ZN8VLz2Zp41bRVDFJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865476; c=relaxed/simple;
	bh=0AOIpUtm6JSKIi6p0MIfhBPcIw1qYn6K5ZBaXO0FNQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuxEpI5SZA/xbhMBw3itqQQPjhgD1b/j3tSrAIR1wKZcBeylgjK1doNZKiTIvzdGF00bODGlfduwM6RWM/VHD5+LXy57jT4B/yz6X1G/ZYub027OdszgBYlfwk+kHbysU/kndqmBnmu+6IQzLG+e5Jus9GHhMNLDwDkGDc5acPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f892aeaso1667676fac.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jul 2024 13:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865474; x=1720470274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvCSfgDjwJsERT9WvOy2clhXblF5iIWvl/HRBD7DUyU=;
        b=l6gGJejoChMXGhQ/EVb5vOZhWl04FgVMQoyp/jI4gMLWyfagn6tUwanpUTxcAQHZF3
         O4RL8zxOiuwDHSvZ7jdCIa0CdhiFbsoSqOMsd6XUnZdojEWQ6tAncr3R/yXou4GqaAJu
         kZvZlapPsy6g7l5jcXESHgHLUqTE+ViwFLtnmrMWE42ke4Y3niI90I9zX6+RBwYfwNjz
         eTXOr73zBS02Sm6Qpq0o8tr1vlxlWTdVWKE6PLA9B6XCFkzRNuHffx1rtLVcZ6JcGqV0
         HTtflkf1WnQQvtVBD5eNVeKZ3SpSGMFIKC28NJaEDKSYNGCJgh6V1aw95voR48A+U/n6
         v4sg==
X-Forwarded-Encrypted: i=1; AJvYcCXJqSJxknP4AXef4ynpBBMgaO3wxGEYoizYmuK2Nghut51JtGAjGdEvhZVbCGPZa/IJgAnVMsRR5tG2jLiAq1Q/ZPdt3gmnrVPn
X-Gm-Message-State: AOJu0YzxNAjQAgcXGfCNLxzvOqEpY4fbsFE8PouNMK2zPXKF0Qqj0rPA
	JPpg1/kgSdtBQYwj6SWuyChSyqFwhW8YCR/9s8yhng+MfyDtMMoD
X-Google-Smtp-Source: AGHT+IFCCkQkJtT28crfVh4dVwylDRgG1ZkKoBBNv6yETsgr0w8t9WZnM1sonhllRhmgeWze2W16FQ==
X-Received: by 2002:a05:6870:9a21:b0:254:79a2:38d1 with SMTP id 586e51a60fabf-25db3372855mr6905354fac.4.1719865474225;
        Mon, 01 Jul 2024 13:24:34 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f8csm6953803b3a.202.2024.07.01.13.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:24:33 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:24:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Enforce DWC specific 64-bit BAR limitiation
Message-ID: <20240701202432.GE272504@rocinante>
References: <20240528134839.8817-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528134839.8817-2-cassel@kernel.org>

> From the DWC EP databook 5.96a, section "3.5.7.1.4 General Rules for BAR
> Setup (Fixed Mask or Programmable Mask Schemes Only)":
> 
> "Any pair (for example BARs 0 and 1) can be configured as one 64-bit BAR,
> two 32-bit BARs, or one 32-bit BAR."
> 
> "BAR pairs cannot overlap to form a 64-bit BAR. For example, you cannot
> combine BARs 1 and 2 to form a 64-bit BAR."
> 
> While this limitation does exist in some other PCI endpoint controllers,
> e.g. cdns_pcie_ep_set_bar(), the limitation does not appear to be defined
> in the PCIe specification itself, thus add an explicit check for this in
> dw_pcie_ep_set_bar() (rather than pci_epc_set_bar()).

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: ep: Enforce DWC specific 64-bit BAR limitation
      https://git.kernel.org/pci/pci/c/a46de632131f

	Krzysztof

