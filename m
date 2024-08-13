Return-Path: <linux-pci+bounces-11656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179DA950DE4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 22:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72611F23736
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB71A7044;
	Tue, 13 Aug 2024 20:25:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF31A7047;
	Tue, 13 Aug 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580751; cv=none; b=juzeVIQTkXox5QbKrLPnBL5DSdQbO2UU5SMJ4JuqKxUJc5vogSLRQzbWroP2h5Nfau6syBc+82XdWLnyhdsuQiblFwuDBxiF43Rh97bJ0bq5kK++5vBP8PXXvc7d+niltVy+aj8IzMFI8jC7d7DeZiLY0A3MKH2eaf3l5UNql8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580751; c=relaxed/simple;
	bh=z44RztmMtf5SITglTxONm/jYUCjvFDooxkvRIMfeOGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj+LEycMhrrCZwBbfFo0C5qppU+4kgCuKz+NcKzlPRg0GfEljClSBhzaCS+AzvlJH34qZfw9tt6SaQnPLNRky9B89JcDSqWkbdwcL+kfIEpGaYUPnZzpqn+EazxH7DzsD9kZruGxryc/pOBx62FKADh2YXEBE4+W4WzaVDFYdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ff4568676eso57101595ad.0;
        Tue, 13 Aug 2024 13:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580750; x=1724185550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV0uIj9ZiP/YeZH/VpPgdI6zY7QFHUilTAHYpLb2t6Q=;
        b=op0JWIrsE/zT8eBk9z3qGXsdbsbS2NMgVBBjs6HtsO0TX/YeCp8N2fLix2KcclwotW
         SC456gdIv0+IoUM8KVWc4Z4BXPzXvUBDNSv8izpIwSGYaEjPhCNm1vlw/ZF0e4zcPO8r
         PttsYUQMKjm1pgaGTjTbAEMo7Its0YvMzZ4SJ7KvAP1gaH62A5IDx7VksosSVQUJX1Wn
         +i+7GITekaFmjxYtZu4r8lJXT/LNHjKW+OlmxnkrUcs2SgkOft5HV6WZiHJF135AfgMa
         iVYBP/hd9H3ZHMNQuxWnTu9O7lUXMVbF8hrZffHRK5vkvvDE6gN31EYaEt8ex+d//LGS
         2vGw==
X-Forwarded-Encrypted: i=1; AJvYcCXoTvfgMcA9sD3iwRLdkr+UcPudTXXm6rM4YLMGw0ClVAQdutHXcA9MB/8vVMnv9KicVAnkpdbPqq7PeFpOUPJ3ghfMD2gtIUN04YKwgyLqmOS4AnS6oNvsWyctjwNp4nhGkTS/taImf8hD0eLv6P2Sy4IwBBPSIPTsHue1VIyLge+YhXbauA==
X-Gm-Message-State: AOJu0Yzm4quN+lIkW/0+8bScT/UMtIh65tWD5gQvkwAX7GXDwSwTKJN+
	1j0QczhKNIX4WoOxV6fh2Zhthbq7lz1tJ+PaLP+vUtnulg3ECMjY
X-Google-Smtp-Source: AGHT+IFPHJgjFA+x8OjfXI7lztWMo3R/k3TEX5vSm0aeHgFpmHiP833wBXYNGxb8GBXBaDY3CMP51A==
X-Received: by 2002:a17:903:2312:b0:1fb:8620:c0bd with SMTP id d9443c01a7336-201d63aa520mr8568325ad.15.1723580749905;
        Tue, 13 Aug 2024 13:25:49 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14ac7csm17523045ad.108.2024.08.13.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:25:49 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:25:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240813202547.GC1922056@rocinante>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>

Hello,

> Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> for drivers requiring refclk from host"), all the hardware register access
> (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> from host.
> 
> So there is no need to enable the endpoint resources (like clk, regulators,
> PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> helper from probe(). This was added earlier because dw_pcie_ep_init() was
> doing DBI access, which is not done now.
> 
> While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> EP controller in the case of failure.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom-ep: Do not enable resources during probe()
      https://git.kernel.org/pci/pci/c/cd0b3e13ec30

	Krzysztof

