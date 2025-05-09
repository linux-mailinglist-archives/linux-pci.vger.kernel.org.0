Return-Path: <linux-pci+bounces-27529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662BBAB1FE8
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 00:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA84D4C8390
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78715E96;
	Fri,  9 May 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UGD+Ntob"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB652620E8
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829708; cv=none; b=BIQGkAtyh9EBuYUdRHIeAmduWrJmOg2Ftfn+nr/+7hD2Lg1mID+CCfPNoGJQ7+uCTNDw2ZXylYWZRU2AB8ApDhaZGcj9y+B+/T6tBVGbBy3GQC/Yab0RoOp1DABGsyKgxAjTFEexp7xQPWdxa6cLaRJ5Neu5Y7wgYYoLCHqT+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829708; c=relaxed/simple;
	bh=8tLcmcPNDjDv2wNIMRwkFTH/IVfOGzil3SZBQKcfqD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRrz2d+luxnT6uX78/+c4FSLsQFBB8YwL2BDlHo+e2H7Try5M/UYKIxXNJ5T1Z68F406CSHMr8UM7ohHKXtScfXwkhQyP8M6RW3vVcr5mmFAzpgVTG7/fblVdpXbHTCnlG+BPN/rl48DyWJ4LCKcoBFaR/NZm7jKypVSpKlZx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UGD+Ntob; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e8e4423ecso25092485ad.0
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746829705; x=1747434505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuvwOYm4GSUNUy2wD5gyT6WoJqASKId1GoOL6RjMuAE=;
        b=UGD+NtobAmKKju2DCjGQbP7E+ijgWEuM1TB2+3KQlPk8+wqBRPtwAq4ZnvVZ7LA1xa
         XwrrKWRsXHUwlnkc5RY7BjxVRz0cELHe4j5uk30BXk+jmydKZY1hGjloT66c1Iyoz0c/
         bT/0znOiShuDHddGcZAWYnHyg7SkweVLa2myo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746829705; x=1747434505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuvwOYm4GSUNUy2wD5gyT6WoJqASKId1GoOL6RjMuAE=;
        b=gVsSYA2y3RjdiTnYLL9cuCUpxCE8oPVszk9FBVa9q4IoeC7Cy/XJnmoNAZzVQwt/jh
         6PvoxRZcPV6JncwAfHTi+/qswu0kD+PaeRIfB9fyLlXGFZ5lMk5+EeKEI9w3yQ2mYL7V
         3b0KgXMy3VfDoJbNCrP5ZCPL3reVQ1TL07pOpxWrWEdZUXtp6gjmhHaeJubvD5Er0Pkv
         hTyp8+8rgdrygvM3t5ESmNFgKNZT6zVx9fMOKPIIKQPS3fgeecB4oa77QuDXaeNlvP9t
         9Nw5a1CtVwUThiG+4a6NIvoe1DUh9cmyigAdzuAbFGRKw2FIpsOV1olhATH/7ahuNCdb
         Cssw==
X-Gm-Message-State: AOJu0Yx6rlM0vg8aS+1lhoCEgex2qC5h40yEBq89cJ4ruTFd5YDtjVoI
	gTptEgLBzedKKbSR2D+BCiAjJpMW8h7xJZdHDWEY915P3c45qWAzCRVI9NAVl76DmGPqEd/1bbD
	upr2POkPkEtdG4y7hhUPCN/8lCTamJt6dETM3gt54UGjTLYlRc5407NC9gt80zSDCN63cwuTcw6
	aHvVU+1gtQOti/dJ4sB0nqzT5tOO/T8D87hz1XFRi4Usku6A==
X-Gm-Gg: ASbGncvQYAKj001tW51KGJ1OZOVPm2bKFgukmDsk5LGBI+ponpmv8B+FRP7PzbDDxX1
	xb/Fou4lOjTF5gCTYg/N//KfQbFp0bO08FWKPJY2MSaShGPrRtqUMOH5WbJK7PT2MkPO1G5Fuq5
	KlfGv/mtT9sNKr90nEGmTZB5kR/kesbH1yYyPEVmNj1peYj6dMk2EynV4RJbIq0AfDgRPrt4751
	WQmiJiiH8stCI1RP5DCL5cqTCjvaRrE1zWsXKaGJ/zEUBOHExFfEt2jtx8C1wJn2FGxslDhAg5c
	+ApAU9AWfH+Y+KSVPPvAsyD3QX4ERCL2kj+qvaefdpTXSZHWjtLLuDEAAOqzJjGhkvaK7LkY2VA
	hDaPeC6LM9KsiiuPFYijlucLWMpqNIMM=
X-Google-Smtp-Source: AGHT+IHnRTtiNbjExYWwvoR2t+W7MP9bwGubNxYQG/OewKoIdPhHsxX+NcKse+IqZBIXhDqj/IpvGw==
X-Received: by 2002:a17:903:2b04:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22fc91caf3dmr64938435ad.52.1746829705327;
        Fri, 09 May 2025 15:28:25 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544fadsm22584465ad.24.2025.05.09.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 15:28:24 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 0/2] PCI: brcmstb: Use "num-lanes" DT property if present
Date: Fri,  9 May 2025 18:28:11 -0400
Message-ID: <20250509222815.7082-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If present, grok the "num-lanes" DT property for Broadcom STB chips and
configure accordingly.

Jim Quinlan (2):
  dt-bindings: PCI: brcm,stb-pcie: Add num-lanes property
  PCI: brcmstb: Use "num-lanes" DT property if present

 .../bindings/pci/brcm,stb-pcie.yaml           |  2 ++
 drivers/pci/controller/pcie-brcmstb.c         | 26 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)


base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
-- 
2.43.0


