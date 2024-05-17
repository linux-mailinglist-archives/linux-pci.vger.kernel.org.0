Return-Path: <linux-pci+bounces-7607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B58C8555
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32FC1F213D1
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E73B78B;
	Fri, 17 May 2024 11:12:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDF79E4
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944377; cv=none; b=Xs6i2SYXIDYSUMtwQfYHA3p0IXp8CR4g+OcE/FNv4RGedjpwQ5rRcp2c2b0Ihkj5Lhx6qLvNQMCtGwlN5qFopNWGk8oBuXc1pjOlMyHJBaz1WITTHGXKQ27usaKmsaE3jJzkgxu8kMb53KlIXpTTQrsxzDYhCiKhPKSS33xwk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944377; c=relaxed/simple;
	bh=GlgVthoc/NPpMCFjjArAdbE7kmwAQ7+I0BSliO1DpxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q59Fpvgxt11dK+9k4Z3wBUSSVveoz5GLmXMTMRveM/XwpXNc8hfm+/28Yo4LQhUmMrBCTghX+PAutGkKsBgPBGTQiIRpBMw4ZsSw4KVapqvAe7mnoRMVbdBTGIkrFAubDew5uSaeSMN0nwxSqYwzOR+k5MrNz6Hsf+AvbNJT3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c9c603b1dso6694875ab.1
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 04:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944375; x=1716549175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eHjitQqyqxkdwddMgK+syMYj+ckIZ7XvdRdxqO+nwA=;
        b=Kwof8I4COzY8c6kZtTkYiEBl2cR8MWv/eZwW5OMhm1zzR/EkjcsKKYNi4Xu4mQHoVE
         IVA58EEhmyP1Z0rZv7HwBe0Gq0wZtCfQVYd7dE0zn7kKJd4Q5e7clJ9/du8Hkqrr3++A
         YwaOu8zuD6S53opqkqMa7UJLF6DuEPhTvTQUe4BDpmUAemIfDwsOItIf7qJgLVWXtLYo
         PSIIPGH0u0K3h1nf9DDlsBFN76dIpiuBUBla/39pgbs6p8luWbBAqBY6a4w9etMaVl3j
         PpnH1tK8SZHa/hkim93vle5LRQ9X00aBBU3VjQuK1WDuk+r7CH/pGS4YAbLOaGsiovMe
         Xdag==
X-Forwarded-Encrypted: i=1; AJvYcCXcCKE95kBhEsrz499yh24aHqGOHvKW8n7gNPqQ4Vt6njqwyzb+xJCLWNiEM3abisaq8E8X1q2pbmX8rSPAUCvoKnEHgDBno2a6
X-Gm-Message-State: AOJu0YwRY8qc8/vAUaB9BpDCaR8ksZntkpfaZ9WR2rZxa9BULEAOIVhu
	wpvnTuX306XCzv25QbcEfXBsdHYOSBxUsFdgIzlOBomYNZYnlmyZ
X-Google-Smtp-Source: AGHT+IFh7zapzrWdJbKFo1EKEJxjYaG/QR+RjVCvwVxJ2x+NE3Fd7xt0ctaolpGz4+C75fzUHqjaVQ==
X-Received: by 2002:a05:6e02:1546:b0:36b:80d:b90f with SMTP id e9e14a558f8ab-36cc14c0b62mr264039485ab.26.1715944374806;
        Fri, 17 May 2024 04:12:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b862572sm13065196a12.37.2024.05.17.04.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:12:54 -0700 (PDT)
Date: Fri, 17 May 2024 20:12:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7] minor PCI endpoint cleanups
Message-ID: <20240517111253.GO202520@rocinante>
References: <20240320113157.322695-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320113157.322695-1-cassel@kernel.org>

Hello,

> This series used to be called:
> "PCI: endpoint: set prefetchable bit for 64-bit BARs"
> 
> However, since after discussions with Arnd and Mani, that patch has been
> dropped, however, the other cleanups are still worth including IMO, thus
> the series has been renamed.
[...]
>   PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
>   PCI: endpoint: Allocate a 64-bit BAR if that is the only option
>   PCI: endpoint: pci-epf-test: Remove superfluous code
>   PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
>   PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()

Applied to endpoint, thank you!

[01/05] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
        https://git.kernel.org/pci/pci/c/417660525d6f
[02/05] PCI: endpoint: Allocate a 64-bit BAR if that is the only option
        https://git.kernel.org/pci/pci/c/29a025b6fbf3
[03/05] PCI: endpoint: pci-epf-test: Remove superfluous code
        https://git.kernel.org/pci/pci/c/828e870431aa
[04/05] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
        https://git.kernel.org/pci/pci/c/e49eab944cfb
[05/05] PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
        https://git.kernel.org/pci/pci/c/597ac0fa37b8

>   PCI: cadence: Set a 64-bit BAR if requested

Applied to controller/cadence, thank you!

[1/1] PCI: cadence: Set a 64-bit BAR if requested
      https://git.kernel.org/pci/pci/c/07db0fa80cf3

>   PCI: rockchip-ep: Set a 64-bit BAR if requested

Applied to controller/rockchip, thank you!

[1/1] PCI: rockchip-ep: Set a 64-bit BAR if requested
      https://git.kernel.org/pci/pci/c/de66b37a174f

	Krzysztof

