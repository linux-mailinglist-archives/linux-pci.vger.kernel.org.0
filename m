Return-Path: <linux-pci+bounces-29728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108BAD9001
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FBD7A3E76
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295D1A2389;
	Fri, 13 Jun 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GukvyTlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C411A76AE;
	Fri, 13 Jun 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826111; cv=none; b=QyM89kusR623Ao35qlHCsjiZcp95HzGu3xWreb+yYquJgixJSOnn/f6kUv55wJbsayC4V+2bzk/p2bMv1kBqh0hex0Cv2SIB+Gy9DHhHMBjLonW0yVwWYKXdNdnxhFsvfGX2LDB8snQskWIsMgYVIra/iEdVnAl7yuVcFQA5cQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826111; c=relaxed/simple;
	bh=26ErZJ2j5j8tbM2DQYOWAirvOPS6iIdLWscIEgu7UGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pVK++9rLSzZEvJpKax+lpkKloEjIB2dshWz7Nxi0kYMFq5fAKrb7J0WM9z53v52c5ZnmDfqQxQ4+Ko8bNBkJCewUcz1IdptNWmXVoxhVqI4ZjLXRm/94+Iz6+GqI5R8N5SxUebgdoCfeNzP4rPQr+UiGe8yIGVMDkePZRIIl4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GukvyTlS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so2460661a12.0;
        Fri, 13 Jun 2025 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826107; x=1750430907; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9JTiirLp7dFXp65A+6dp+48wUewOH1a1vp6gPpeVWM=;
        b=GukvyTlS7OrhVGp0KN8ewbWkAJ3Z1bygdVi15CnQYghBGmkdLyTEEKzAlVqGF5xrjp
         hVW9gyrE8rZQI8V99hSCOj35KKRFBlEz3jN6gRDc7d2owSe187p2ciMN1uM2fkIjbDUU
         mYQc/23BALXF1Akqu4SIt3p3AdgkQkh0qlWbbMKh61HFdcUq2l/ZaN+7tmvnkjT4tgJV
         M27yCWhHAdF0ixT5apRnj9YJIzLq0EPGa35EOBsiNM/WWQrXXBm/kEWLY1EGHUvKzRGw
         4kawFUZAJORPIOZ1ppctDB81umz7PoKne469GGwQWVRgoM2/tJe4FIkFVKX1wz9KlN2q
         7YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826107; x=1750430907;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9JTiirLp7dFXp65A+6dp+48wUewOH1a1vp6gPpeVWM=;
        b=eAVFAf/5Sm5NzdodR484m+Rx0vvvXwv/bM2EUZP8D6bVcMNh6/JTLssz0Omi9piuXx
         4imIgRLVzQemDvrpi7Id9yBZbXqsQx3J+Nt4QfZFc9eQ94svQNBHPaDqIeh3E2AmPWBI
         8TJMSCBtRyYLfP8JSKY/nsOSKIfwkKF9+1jneDK7yZuVLeX77yaUmwQHeIShbhEnEQ4Y
         aLZbbG90VHwxT3g0ym0S08pb43X7I0tp/EzVeU9NS1OPROESZ/D6EnPvBrnOa3yamZjm
         YrYOgPpkg6RhC1h8AqcCtBUUsHKGez03dKhYmldjWFT2zTlEO/3WmL3xYOx1NsafaSIL
         mbBg==
X-Forwarded-Encrypted: i=1; AJvYcCX1i0Obh3kS0EPvLQWkf0Nm59y7CRNbu2S112VxI21I/HuOzns5LSG8Wt6MzRb07rnInQnNQRbupz66C/8=@vger.kernel.org, AJvYcCXQf2KJciNCx1TWKUm3w19lAcLEMaYq0pad4F3b5ERvYSB0q9Osb7YGtZa0H6nd51Nxp8lsTN2/Fgzh@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhvVE0VWHCeudFJXdOytJeKwe6eCm9rl67UcC9oX2XsaFYg0G
	AvliTm/UwighjJ7jnbUPY30dnsJepZUhg3tC+BCoSin9sWvoDFjbqkyT
X-Gm-Gg: ASbGncuqujPLPBC7202sPstRMje2hJ2hcxoH8jVf8IhDoAPEB7Ctd4AQ5UzcFKEMCNz
	hAivzHi8M5hqh5TcKtT/RL8efkCF3k0XL4K+sTxqY3V8MRjZC3qdEU2UtRK4IQKQhyNmMVIEaRs
	mhCR4aWnFE31Fl0m3tPX03csy9SobLoU8M9wzrS1vG8catL1jX1SHmyfylz+pEOPny07ZdzdSno
	4kXHEfQbSXvfVOqmGNAaggPPjUTFXJz3Vwc12bE4tC6Yc4Z0Q2pOjImvm0j6s6JuHRUHifH6Kws
	ZR1/6v8R7YmO3V1+73jTDQL7F6KYfiEqqBCp4ivw5Jf4ylrtag==
X-Google-Smtp-Source: AGHT+IHcd33U1pPTm2OZvPaNgt6ez8a+j54CjSPCSVvtmMq9GaYDflpq+hrFnm/a0JpIR7GcANSQcQ==
X-Received: by 2002:a05:6a20:728e:b0:1f5:64fd:68ea with SMTP id adf61e73a8af0-21facb4a140mr4610926637.4.1749826107267;
        Fri, 13 Jun 2025 07:48:27 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe164406esm1803644a12.27.2025.06.13.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:48:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:48:21 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/4] PCI: rockchip: Improve quality of driver
Message-ID: <cover.1749825317.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During a 30-day debugging-run fighting quirky PCIe devices on RK3399
some quality improvements began to take form and this is my attempt
at upstreaming it. It will ensure maximum chance of retraining to Gen2
5.0GT/s, on all four lanes and plus if anybody is debugging the PHY
they'll now get real values from TEST_I[3:0] for every TEST_ADDR[4:0]
without risk of locking up kernel like with present broken async
strobe TEST_WRITE.

---
V3 -> V4: fix TLS setting-up in Link Control and Status Register 2 and
adjust commit titles
V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
suggestion
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (4):
  PCI: rockchip: Drop unused custom registers and bitfields
  PCI: rockchip: Set Target Link Speed before retraining
  phy: rockchip-pcie: Enable all four lanes
  phy: rockchip-pcie: Adjust read mask and write

 drivers/pci/controller/pcie-rockchip-host.c |  4 ++++
 drivers/pci/controller/pcie-rockchip.h      | 11 +----------
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 +++++++++-------
 3 files changed, 14 insertions(+), 17 deletions(-)

-- 
2.49.0


