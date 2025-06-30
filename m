Return-Path: <linux-pci+bounces-31114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AFEAEE9BE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD77AD7FE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84E23FC52;
	Mon, 30 Jun 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awWrqABl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D231F2BB8;
	Mon, 30 Jun 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320414; cv=none; b=bS1jqQQhDDD3ptdGIk2HBI1Ud3y5/vEZ9YZIOjmhfG6cFb4rdJk0/wX0jZ9MUp+78CDbfd+kbYRL2UhBiHNbe7FzH4qVQ5U+83WgepjaKLBELsWPi133xzdLI51JaDAFbth3UwfzAVMh58jnJj5NgjxGZX/zUlEN990dqwSEsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320414; c=relaxed/simple;
	bh=Gw4w+JlfU8ZSipHyP2abRxrCX6poC9T1o7K49sJWZcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSGUphSOrFE8nVoJtC4KHltpAtk7QxQ4blkFSFHl2WuC2x7cIZyJG+dXS03mecHGGcOOOghKmZFNv3Mrj4WFr62YljlDSPHNuYQTr2HRQGXl2FBQQm10/BxT1E7GmSlbCXWtKPgwH3ACvZQVMM94PV3CrbfgeZmUV1u9k1yitUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awWrqABl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a752944794so57601981cf.3;
        Mon, 30 Jun 2025 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751320410; x=1751925210; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOqcQ9E+8drflPFHAs4vSUWLT7BoxqpED98LP9u+w/s=;
        b=awWrqABlyV2PxU2sAz61nh09jFkpIfD5kUM58Cx1DB6nXbhhV/iVS2EMURp4R7LzdL
         kwu+kfGbwZv0Tsbd5xcdG06FHNMpOk0DxcIun/CTKNAj+A1Nz5rSWZUyB+gC9plllKbN
         JlViHJkxrpSuEjGcHZchughkBlEQNvLGdPlk6Ago+W3BJe1NzLtYdwUWK3AZvr0tVLNJ
         2pf4L37rgOU0jKdDaH8e5sS7UmlhDB8QYSt6TKA4bfadc75p9crEkOQKLyqLdBePo9SP
         h7BqULWmN1qmBks+ippBFAx9wa8aN0g6KDwKdY2neTudDXe8TiV1cA0Z4C/ycU68oWha
         LtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751320410; x=1751925210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOqcQ9E+8drflPFHAs4vSUWLT7BoxqpED98LP9u+w/s=;
        b=ecw/6eJyV1yakGaUkIGIWr9WVFxYYUepV8Wb0JWJ9PyA8NN87XWGR8inU5HSlO7qJV
         4rLOUsUPGMzOIgeBcjV9cm7a0tJhZY2ra+BFyBt5fwXGLfwjhw1dAEHVE3xJ9EP48OKJ
         d1Mscpiph3ARClrlMuoOkhXEdVAEeVQAQrCnCaWXMNVUhZbVADY9KCygq70g6jIXfTBc
         FaRgv62yUpwLQ7HULFGipJf3RXONwpnb1YO06NRbPfFnN5cTtzkeOIqVrwyWvT5Y7ikw
         cXZF1eAy0pIjc21ukclVB8qV7jT7Sa2QoeZ0kQ39QSiVYlVrT/s3hL9wGl20mPAOiYEh
         Fpng==
X-Forwarded-Encrypted: i=1; AJvYcCUq/EdMThiyDXYvoa+b9Zlw8Q3SR1Q2KZg9foN6vlBu466R97YQvr0FrlbYAeSgbjyaxjNPp/yTHYRnGfA=@vger.kernel.org, AJvYcCV4hvzK2MLEq7OD8OlXG+9EN6wM2qHzdITRRv3x7NpLol0Vpp/BmJXp4JNB2MYfxPVJ0L1El2N14QP8@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjQ1Aap6SRbUQlqHZCIT7eMvIRRD0NvuT3H0fle+FiC1WAkb3
	SX9m3MFVpmi0AotC8ehg/tA3aJOFuOwTMSKT5yqut3vQocUJhmQcdPrS
X-Gm-Gg: ASbGncvzW8j2IaC/azmZB/RbqxmgIUKhWJe807emsk4iTmvpRR+FHVXvaJG72oG+0y3
	5jmexYuZZ9QrZSYA/G0p2x/efonBzNQSVBQmPNKJdTUFbYE9k7xROMDKyj2Yshhdh5I7EGZHVjB
	ul7ur+0mq31J6i+WwTuuGqOYrVcVFaD5mNxmiLBvHWNiLyraGWOsSpQLy524RQm7qB2CMWNaCRP
	ALIC7DxyFodlXtsd4oiH44tUrv/sS6jVHIZpzqgSgcJyqhYoeJx6R/nX6P/UYuXwGfb80fEcyLB
	yw6HAnAH6HMjhPCq4JNAKNYfsx6MYemHTKeSWv9T9S9bfJbCwzC5jxELRABS
X-Google-Smtp-Source: AGHT+IGpu1rUc2wPFEaXEFiIZuBQa75ZWCWrqwnzIwLkgnPr75eA1zu83NjRcG7DPZSdyWYMNBDIag==
X-Received: by 2002:ad4:5b83:0:b0:6fd:cfe:eb95 with SMTP id 6a1803df08f44-70001a48ff4mr237172516d6.17.1751320410561;
        Mon, 30 Jun 2025 14:53:30 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd77307918sm74425236d6.101.2025.06.30.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:53:30 -0700 (PDT)
Date: Mon, 30 Jun 2025 18:53:19 -0300
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/4] PCI: rockchip: Improve driver quality
Message-ID: <cover.1751320056.git.geraldogabriel@gmail.com>
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
V8 -> V9: modify third patch to better reflect authorship by Valmantas
V7 -> V8: add Valmantas Paliksa Signed-off-by to third patch
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

Geraldo Nascimento (3):
  PCI: rockchip: Use standard PCIe defines
  PCI: rockchip: Set Target Link Speed before retraining
  phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal

Valmantas Paliksa (1):
  phy: rockchip-pcie: Enable all four lanes if required

 drivers/pci/controller/pcie-rockchip-ep.c   |  4 +-
 drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 12 +-----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 15 +++----
 4 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.49.0


