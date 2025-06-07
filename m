Return-Path: <linux-pci+bounces-29126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B739AD0CE8
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 13:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A6A16F95D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7741EF09D;
	Sat,  7 Jun 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqenYY2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB4EC4;
	Sat,  7 Jun 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294040; cv=none; b=QXWrB3svyDV6+EiqZKcUXP/21Z70EjHdNfam4+wRbF21xHt9jx/DroPTe0XlrdaMPPIMmJMRplL31Cr8gKGltqpNMgKeLg0mRZKCbLVXwN/A8JxMxuzOZYi5UcUJt76422K64Fgqx3jyqQSboib+QRiTasEbkXSAK1XPr5IfBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294040; c=relaxed/simple;
	bh=kPnaDx7uvsOgZruz77FGJNt1RLG7ntciuy/w6WWh3LE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oYHK+8b3odte2G5fCTeKUnG3860GzzklxpBY4vTYvWV3j3aCax1WLZYidAtMnWsQM2HT4kahAlizdklnEO1CtBDKg3omAUsOJPoCNJMudurq6M5JP6qdcdLVLFtzhI4f6K0bAhNfyMvgLDmQYB38AicDh1yZXCbBv0PffO+o+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqenYY2o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c9907967so2928319b3a.1;
        Sat, 07 Jun 2025 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749294038; x=1749898838; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdjXka56cznUdQuW4uynCPh9h5JevUOrNvyaWjWaMV4=;
        b=cqenYY2oM9uv4W1fVli2yKLmXSstCpaPDVyjCZmzGMk2usBGP5Ntb0bN1ZukKA7Nr6
         vGCSy1FPyJ79jpJMYisrNmbWo7XEJh39+tx20LeJMpGfFjU1gcWRs3XEUZd/eKpfTjmg
         Wt12T96HoWkXcZrL216EeZp4rMbiZ92UYjRmrUcFb9zh/VzxHZGwYAHvdiCJ/cEcZe9/
         mkIPBzY1iGWkfwQI80byA2+Ai+9i1qRT16vViAzAC7A7CwHS3yLmsDd4Z4Xhgdory1Zi
         40J2Zt8+o0dJkZztucX/vc1YsFIqRsAF2WA3AMbPzZbJIF+9OFBM/Vgm0ZtUoHR9iIlG
         7dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749294038; x=1749898838;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdjXka56cznUdQuW4uynCPh9h5JevUOrNvyaWjWaMV4=;
        b=Y/YSFLl/i2NtHMDGJF7HQ0tzTcJ2gwKFUiymD4Z6tLoYKj5WUO5F8zcj+1PJQvMT47
         13y7MIoQo8gBzWmeZzr/1cS6AbOqzGE961W95w0oRneMsewS1FvPmJrJv9ThUUIpQHH+
         +G+O4X/8bb7Koh4cYLSuUgG/eSoA1nJ7LB6tfMhYys5FDu4tjI4lFbGKaBvaGNwqKfGE
         9sIbw2pJrYPfG+rQmhenbi4xcNe2Za4WUONn8f42fFfZyd+WUgGOXb7Wngq5unMby2KO
         iz/c7dhgI8FASN344l/Pw/aamUZvuF8PiXUeY3+XqoXdUQGVqmkqFVCGzsemKuIFzdNW
         xiOg==
X-Forwarded-Encrypted: i=1; AJvYcCV3H0pVL1dZVd6vWEl51NLg657bj1Iz4yTFcwGlpE9z9Fq1XMDWeZTKC1Vq90sb+zptxaEDlcdc+ZCvyic=@vger.kernel.org, AJvYcCWXH4MJSk0MDhUpt2YGxOF7tK3acBy/5oZKj2halrvJxXwYM2UZUX00OozukNOFF+6rDI01+e04ANh3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Q558OHuyKWt9sO0nzIGAkGaSXFOZjTImvUrlu+0GACOFYL0F
	b0gaWCp8Aqy1h2bw7kqLFVjD05UYUNEhbsGmDjjOhFvBSDacP+kbDE04
X-Gm-Gg: ASbGnctlwRDWTO/KuGQ1zw+tCxti5fStD97U1Szp3eKR7q3LIfe1Wri60EV3652OVYh
	op0jI52h3zpkQBrdyKdf/mdQuWnZ0AqWXwuUqqDVYEKKzHTHYQBK5kUnvoACRii1BHCQSYzirs+
	kMMTARezCCJNbHLNq5YlLX5XrjNpu0aeHfo5oBNUvPH/g4wVG8B1uPvqE0KlMxe7oOjzq61NCQt
	wnj7JmF6O0MPJg/y+Sy21pLRy3XKPJj5DdehXGBvDiHD5isP0NFxEfZ43dsHJRDmotOktDuZ3zu
	JqXI/m6bdfSWgdE2ULMudRP6cJkcNmDAxA9RUuY=
X-Google-Smtp-Source: AGHT+IGRYLSWTyAi936hLvd6o8149o/EyQpTWPHWvpkegPUAF8UXGv9uvJGM0/mU1HVRhc7meRbayA==
X-Received: by 2002:a05:6a21:9991:b0:1f5:8f7f:8f19 with SMTP id adf61e73a8af0-21ee25d62e8mr9048461637.10.1749294038311;
        Sat, 07 Jun 2025 04:00:38 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2bc9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083abcsm2642030b3a.92.2025.06.07.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:00:37 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:00:23 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Quality Improvements for Rockchip-IP PCIe
Message-ID: <aEQbx0Qu-2UKhV1y@geday>
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

Geraldo Nascimento (4):
  PCI: pcie-rockchip: add bits for Target Link Speed in LCS_2
  PCI: rockchip-host: Set Target Link Speed before retraining
  phy: rockchip-pcie: enable all four lanes
  phy: rockchip-pcie: adjust read mask and write strobe disable

 drivers/pci/controller/pcie-rockchip-host.c |  4 ++++
 drivers/pci/controller/pcie-rockchip.h      |  3 +++
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 +++++++++-------
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.49.0


