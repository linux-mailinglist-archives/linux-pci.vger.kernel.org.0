Return-Path: <linux-pci+bounces-31024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A1AECCA4
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE11618911A4
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64771E521D;
	Sun, 29 Jun 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcr/NMPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A22AD1C;
	Sun, 29 Jun 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201267; cv=none; b=UzA32dal3cnCpHkZQIAWtVIMHzOFbUpBhgaTLFBzn3BJvmVawqfsxw66nmR9D7f5TId8i1r21V9Cm+jjRjN1HY0KY/RQmlu8hNks8U/0DzexcjfYLktPAtw/phKi/8xBONgJ/VBirqLPt4TMutEl3jqT5JTxc0pwTfDrKAzFtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201267; c=relaxed/simple;
	bh=VDLyD7PbMXd2/C5aSn5E0/3gCiOxVunJAWwm6pytKHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LRKezCHf7bEYKfwL0tsAwJMlQFIu3WRy/6s/nmO+q8MnVtJ7n+ysFGycPgfWtFvFNWIsB7GTuxrLsd624436ee/pfS0TECIhLVxIovve20R2p+O1erKjCQAiwSze6Aq5C0VKUlvNthxsb9dYI+AGLxa6B7lSM/4XqSjfpSLlmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vcr/NMPY; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6facc3b9559so19183596d6.0;
        Sun, 29 Jun 2025 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751201265; x=1751806065; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qT9O4ctgmI4E+K04BSgVRvvO5rn1N9tEpioEcUF5MA=;
        b=Vcr/NMPY8Gz1XGIqCigstlOfWPQkEBPZd+Rum++2f6FPKQiEjMLLrMkz+5VJ7K5rdW
         uVH+ekgCOiEuxB9Dz14MI8P4XjJE8mgIUpuGJAtfXzgKdISlEvhIwoksG5CQrNMB1gr3
         9ZG10nMe5EQyb7w4SHyDUSxEm90dH1mDEhaXodpSNjFWH/tDNSJ0GjCLcEF2CHXpTpla
         XhwQ+jWo+Jw9k16tOviPYOxpOZGBj94BvHwGYGXdFPBzz1wk7zNP0l9OaJyWFvTpt5VB
         IOPgs/uaZtiCJ3w3LhhkyPtcke+mUhieCtu59LHkxJKFvcvBmtRCTrO53C9fbK+CP+W/
         vuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751201265; x=1751806065;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qT9O4ctgmI4E+K04BSgVRvvO5rn1N9tEpioEcUF5MA=;
        b=Qf99wioaYeTcLz99HcskD1imxUyDB/UIlkZa7RttzG5huDBQuh27bJqgWCDn23IjkH
         hg1OFL9UU1OKDDbTz8RWhqf9LDZLwUG0blLVZVtl8AUYw+9ak7jxieRtuKMARezg9MoU
         LSy083DJE7ekJzxPGhuL3WapZccX1zrc8Xgd5+AKYppLcBwxrtESXW55AwztTNtt1wOB
         xqUYyCyzjRrfBLzIB3Q5pFlkUc1Ut+Uk+d5TJBLXRrN8Qo/RjnOc2sxKtrA6YzsGc8XS
         Xgo1H9cS66As/2PXXwd2Ax8mx2xaPwqeZncVxhzdEvPMinY+yBiL/jhm8rn6deqUBlx+
         D1mA==
X-Forwarded-Encrypted: i=1; AJvYcCVROF5g/HL0cKDeGA4PoQmtYUWsKsfjCCTSmrF9+fI+1Ug5LnW5qYN8WnoBSPzKnJnQyo3OLdohWbSi@vger.kernel.org, AJvYcCXXOM0ovyyLaI/rYYUqP3L/fn2WPNWwtf2bE+FCyuExo3B7OxEQnPTqiPO+CeCENUgJt0XBWWhEvi17bZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjaW4NF2tCZBwYQ3x6OT/rpDzWW80LNSmwHEfv2hhf/saGGuTt
	OWLJl8xKqfL+iWJTdPpD5G0YzlRUuCjP9jw/p2EvG0QFVbMZYJ/H8GlQ
X-Gm-Gg: ASbGnctyrR9DNf6aGjZJAR1LxFfhPi3n5D7GwcgzMryFb6hYc+JXImWsQl2YXg+1lCL
	nA6M1YAcC+U7cLbvThb4wKDJMCOL7zVm2T3oL5gGl80g3wwtnTphXz7YcwbwNMDBDPp6W3yvngg
	pkrCwAjgFvTqgmx6mEJ2TLEfFNFEMkg6fjZ0YjIl59HtyqxacNOUr0/sQu/BerCMCj1LDKN0dXa
	93Y9ID6U8HXVbviFLeprN6CrZe5MAytQ/zeKscwSxycvzXDnanXH/OotAv6VIXJbdhCy8bA7UW2
	n7fRdffmgy/nzMDeNzlz6/LY3rmfZU4U4PzzouWXAE90fr45EswDNjrMpTdJ
X-Google-Smtp-Source: AGHT+IFcnXAwt3wLBy9B+NJBG4yLeL8rwe64avI9teL+o/I8vjzQhNTT6+gyyIUOBrLOsm/ff7s0DQ==
X-Received: by 2002:a05:6214:428d:b0:6fa:cd55:3823 with SMTP id 6a1803df08f44-7000214f607mr153311086d6.26.1751201264933;
        Sun, 29 Jun 2025 05:47:44 -0700 (PDT)
Received: from geday ([2804:7f2:800b:24f4::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44323bba2sm430549085a.109.2025.06.29.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 05:47:44 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:47:38 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] PCI: rockchip: Improve driver quality
Message-ID: <cover.1751200382.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During a 30-day debugging-run fighting quirky PCIe devices on RK3399
some quality improvements began to take form and after feedback from
community they reached more polished state.

This will ensure maximum chance of retraining to 5.0GT/s, on all four
lanes and fix async strobe TEST_WRITE disablement. On top of this,
standard PCIe defines are now used to reference registers from offset
at Capabilities Register.

Unfortunately, it seems Rockchip-IP PCIe is unable to handle 16-bit
register writes and there's risk of corrupting state of RW1C registers,
an issue raised by Bjorn Helgaas. There's little I could do to fix that,
so on this issue the situation remains the same.

---
V6 -> V7: drop RFC tag as per Heiko Stuebner's reminder, update cover
letter
V5 -> V6: reflow to 75 cols, use 5.0GTs instead of Gen2 nomenclature,
clarify strobe write adjustment and remove PHY_CFG_RD_MASK
V4 -> V5: fix build failure, reflow commit messages and also convert
registers for EP operation, all suggested by Ilpo
V3 -> V4: fix setting-up of TLS in Link Control and Status Register 2,
also adjust commit titles
V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
suggestion
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (4):
  PCI: rockchip: Use standard PCIe defines
  PCI: rockchip: Set Target Link Speed before retraining
  phy: rockchip-pcie: Enable all four lanes if required
  phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal

 drivers/pci/controller/pcie-rockchip-ep.c   |  4 +-
 drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 12 +-----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 15 +++----
 4 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.49.0


