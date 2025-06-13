Return-Path: <linux-pci+bounces-29638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C2AD826F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89387AD3B3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CB253958;
	Fri, 13 Jun 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6XHrAhQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C28253B7B;
	Fri, 13 Jun 2025 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792005; cv=none; b=tccBR/Ed/lQhORl8ejNZk/VB6BsSJDT7UcOixewaNzSeiK7e8+6j4rmjOlnRl54THENJXIAmmLFs6nzBJMNlgslAMbRL6olQUbjAqlOCQO4t5WBkdR/Oyp1GI8SC5b72nl/mnzsiBjn9wuVQw+JgOA9zym5txsG4OeSc57NZcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792005; c=relaxed/simple;
	bh=3tCqr02/XcoI9jrC5WwlXdvw6SpFrS6i8hbAiNUOV9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+lJKO0cjY5p0Y+6WMQ6JwTQefaEbcGT41aZtuAWzkT4SK/rYQCGGwjB5tipc6qAnQZB/RzYi18Rgmf4Tar4L4fB6Y0/XQoUvSxYYM3iPaEcDO4ZyhF9QkIl1i6FasI2Dzjxo8R4cuf3j2fumPEnGCKp3bzaTEKGUOHVt0pUSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6XHrAhQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747ef5996edso1694813b3a.0;
        Thu, 12 Jun 2025 22:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749792003; x=1750396803; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8J3QiOw9YA5BRvHLHJu/HycsZALO2W/PjHSUFrfbe4=;
        b=X6XHrAhQtuFBF8iMd3MYus12MLv2NT/jpaRJ823ZG2IsH0+l2e99Aq/UAY+rhMOiSI
         JY5jgXHVeYqNFmBrhwm9Lwci9lZqoHLZ++dXURQavFxPjpJ12sl5HegOBtfr3QMbnpS2
         H22yn5QOTSmMZ2RN/AQFzmGr4B93rYnow+atx4DMlmrItgEfla9f9tnt7+vQQYCWcBDL
         +osWJtHaL0LoNTCRj2r1YNDt8DcSTG6rdVV31SpBRYKJAEoQ+/tQ8Wout2Sh3nYWAo1x
         yhtZ0CF9Md5fj7mICcTlAZr/FS1XtL6cCIKwwLcZSErfxQKBPtcXQBxWZf1KQ3oudiz6
         e4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792003; x=1750396803;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8J3QiOw9YA5BRvHLHJu/HycsZALO2W/PjHSUFrfbe4=;
        b=HYBpwsSCrZUhGcQqMWOBbDrPd7fsc6rCC5JUygO2VxV81KkOeHPpcmH+rR7SaBfwvb
         4YrEldPSm1Ty5/hUltSTnjOzM0F4Qt153z51HW1d+jQ8S3HeXPzhohBrM1+TvuPCSLRW
         MZPiRCq9TQ9MWSfXxysGnNvbTvoMFyvqUsiLVxniD+UFlOYVspVi97VAWrl52uF8aHCH
         g4JT2d2ngaTNs67ZDj/CyPE6IfJSWmPi2LjwurfD8GZohK5qCY7V2L+9Uws6FIMI3qwA
         jRwCweQFpTqan6VoOlZbo0oJBzDZAlqJeDJFimK5FV3scEUrz1eT7XeydTyZadecvYim
         /UTA==
X-Forwarded-Encrypted: i=1; AJvYcCU7aIymLbbJ8fuUZSxb4HK8TXqdmPDy0d6U1rb4lkU7hAoaUGNxsAZTFcWJGetLCphE8r+g1K48FxoC@vger.kernel.org, AJvYcCUkhY1OCHiBIya0VIf8/Dg4o8gbtlLbPAl5lBX7f6QQ0OYgEVY6gkt2NAbRXEY0DTlTUyw7nfrmih7RzGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETXmrAWFvtmEsUduIEt936vIXW2WZniO2tdF9H5UNPGz2cTx+
	XOvQN637j9yNXs6ZZMHpJecaUYNp2hTuTQ/bE0gfR1SopffqmZ7QK/Ht
X-Gm-Gg: ASbGnctgMDr21bVhoUA/B8o4CVtqcmJ0XOiTBEjoI+jT2j6Q9JHIgKR/sz46GAbB6Dq
	TJCwey0bQxTmhL33La5h6sn4ENZ7tTepKrWLH63UdkXDuFuz6QZCKKTi1n+s3NvlPUQ2VZNHs75
	3doRp+7fNufoy7XZshfXPcercj89+cLG7tefVZ9tyJ8O+L3IUBqf80u79WV5/YbDl3+QXfBgvho
	chOHEoURdEFOpMRi4/WMbJH4WMW4DOfP0wYJyLRrSWSO/2bFxlXFqxppLo6LMP4NR87F/ZFsfmf
	gol6KRH7IRQKRAPbblJBbxNdMdfMl0De8BgGqfa920wngm/mLTXDV1spj6n8
X-Google-Smtp-Source: AGHT+IHcBqV07orbqmglXVR0EDk2W9hXsnO11JVIlP10U4fClURVXyuO/Hy1R8naKjKmYWjFRCjmfQ==
X-Received: by 2002:a05:6a00:2342:b0:742:4545:2d2b with SMTP id d2e1a72fcca58-7488f6ec975mr2504576b3a.3.1749792003042;
        Thu, 12 Jun 2025 22:20:03 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7667::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9e8sm735318b3a.11.2025.06.12.22.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:20:02 -0700 (PDT)
Date: Fri, 13 Jun 2025 02:19:52 -0300
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
Subject: [RFC PATCH v3 0/5] Quality Improvements for Rockchip-IP PCIe
Message-ID: <cover.1749791474.git.geraldogabriel@gmail.com>
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
V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
suggestion
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (5):
  PCI: rockchip-host: Use standard PCIe defines
  PCI: rockchip: Drop unused custom registers and bitfields
  PCI: rockchip-host: Set Target Link Speed before retraining
  phy: rockchip-pcie: Enable all four lanes
  phy: rockchip-pcie: Adjust read mask and write

 drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 11 +----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 ++++---
 3 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.49.0


