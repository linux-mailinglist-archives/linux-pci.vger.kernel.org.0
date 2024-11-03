Return-Path: <linux-pci+bounces-15892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB7D9BA815
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EFCB20EEE
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863AE18BC05;
	Sun,  3 Nov 2024 20:55:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80983CD3;
	Sun,  3 Nov 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667320; cv=none; b=I0jtCW91WtZP1EprTtfBaAxfb3zqbGRDKuabPP0rhy9wMxrgTIwJpETKVyasmOrdPeMIDDSnKxHW0JwUtQPLsqnqTTO+mG4Fo4dc3QXAvTVBUWSU2UqYg3SetWbHlY9n85CjACRbomVqbyBUPj7FVBcoQRM/Ex3EBtfxeYaLMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667320; c=relaxed/simple;
	bh=169TU0I8OqVfMkV44s8qmmQuBgGmdkRGfXbq2TsNqRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv6yYb8+h11/EUbb+wdFNwcnr6mTKGEd6A7/LMEVYh/N1q7hxFYNLIv1v5vfXlSdN5+bvHYfEmcytIeYDFQLX9oELSfTocrZ5Yb3d7du8kGuiIytMLHqUxsCJgiWyegcbQ9ScV/mYKx1FPx743akFAVm0st2MdNcpeW8uXiOG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7203c431f93so3013314b3a.1;
        Sun, 03 Nov 2024 12:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667318; x=1731272118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkTm3ISUki3FFYUseRADV3hbFvsQp+6guXHl9w2tk54=;
        b=VHFXNxu/vmUX5r/zkC3qlKngITEUXr10lCRxVWU9WXdJHRsG35cXtbsfsdzXg+W5NG
         oRuYmjg7cLyCrpXYCc8sSRbza++RlMTI6+zf3nBoDRzdBM4ErqHm+pFy0zbV9DhbulX+
         ojh6WqGr1HIL6qbzkda0/XVEjKUdxretYRggb4C/eGHgxPNv/dmixH2uqU/N6s6BUPl7
         bqFOcGM/v4IJMVWliir8bnbGgFyk7Yutm1SKplZ235UfY+OSSyo0xuu6fJqEDPaVlS8V
         QbqJibduQXowOSTGwMsgU00zty19iZzGtFX8FO415x6PxH6BZHoLOrIzKQz6Wl08EsEP
         mU+w==
X-Forwarded-Encrypted: i=1; AJvYcCUQdybWBL29nrac2ai8YnOjkM6PPsWOODm6C8eM4oAsXVT5ypSDiPmkavkA/bibFBDhYlBtV532YyfmItQs@vger.kernel.org, AJvYcCW+/rWBSWy30lhm/MhzWIDCkpOf3HPD9yUPx1xK86hmjZ1fhtnqdvrw/q0q2gfbXU/dT76Jjcgs6AO2aLo=@vger.kernel.org, AJvYcCXfjQsfwfSbt2wS5T4XiTrCTLEsesiZtnRlg4ZOBjXi+c7QRqWw3nkjP4s/47KGx4WieA+qdsAQhrYj@vger.kernel.org, AJvYcCXosUCX/+T/buMcL01HoHH1Dcs2e21qVj8UVy/MjIjuEwqnMuIOmyZX7vkoYWY+i+Pcbw4OyVMlgTFra96C@vger.kernel.org
X-Gm-Message-State: AOJu0YwvwK5UmF5qhz/ii5rkP83VEGeSdv+pmDvjMcyRDVNJk8hA/B2m
	D1f0aZdwMHhCzB2OUu9jnASd1xnKolTkm6T8ru5lWdUbc3ckj9v1
X-Google-Smtp-Source: AGHT+IEVUlFcuurAji9Axfc1ULN18ChO+rIWASnT5jNqDNMJTj4409fS7E5e/UYWPl+N9KVFKG0WaA==
X-Received: by 2002:a05:6a20:a10b:b0:1db:dce8:c26f with SMTP id adf61e73a8af0-1dbdce8c29emr1170730637.33.1730667317773;
        Sun, 03 Nov 2024 12:55:17 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2f189dsm6038978b3a.181.2024.11.03.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:55:17 -0800 (PST)
Date: Mon, 4 Nov 2024 05:55:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra194: Move controller cleanups to
 pex_ep_event_pex_rst_deassert()
Message-ID: <20241103205515.GH237624@rocinante>
References: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>
 <20240817-pci-qcom-ep-cleanup-v1-2-d6b958226559@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-pci-qcom-ep-cleanup-v1-2-d6b958226559@linaro.org>

Hello,

> Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> deinit notify function pci_epc_deinit_notify() are called during the
> execution of pex_ep_event_pex_rst_assert() i.e., when the host has asserted
> PERST#. But quickly after this step, refclk will also be disabled by the
> host.
> 
> All of the tegra194 endpoint SoCs supported as of now depend on the refclk
> from the host for keeping the controller operational. Due to this
> limitation, any access to the hardware registers in the absence of refclk
> will result in a whole endpoint crash. Unfortunately, most of the
> controller cleanups require accessing the hardware registers (like eDMA
> cleanup performed in dw_pcie_ep_cleanup(), etc...). So these cleanup
> functions can cause the crash in the endpoint SoC once host asserts PERST#.
> 
> One way to address this issue is by generating the refclk in the endpoint
> itself and not depending on the host. But that is not always possible as
> some of the endpoint designs do require the endpoint to consume refclk from
> the host.
> 
> So let's fix this crash by moving the controller cleanups to the start of
> the pex_ep_event_pex_rst_deassert() function. This function is called
> whenever the host has deasserted PERST# and it is guaranteed that the
> refclk would be active at this point. So at the start of this function
> (after enabling resources) the controller cleanup can be performed. Once
> finished, rest of the code execution for PERST# deassert can continue as
> usual.

Applied to controller/tegra194, thank you!

[01/01] PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()
        https://git.kernel.org/pci/pci/c/40e2125381dc

	Krzysztof

