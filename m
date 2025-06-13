Return-Path: <linux-pci+bounces-29740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA478AD90B9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC101885EFB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937C1C84BB;
	Fri, 13 Jun 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxOX/3pm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA416F265;
	Fri, 13 Jun 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827123; cv=none; b=HiopXN6/5V9O4ypfPO0eeZzZaGoTGp5ymLxs1pqcpW/D3hRNG+X7AU3gryKPDWnmu5ZWDrrl0d9sklOQlZkmaslFloS6iZxzfg45MW16W6HcZ1WYLXI/VipL3BVcWZiCVN/91joeDMfBrEdzJTEc34APHK+ze0dx4WN896mkwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827123; c=relaxed/simple;
	bh=ZUzbXl+uC0IGlwd+pRzkC/+knfBPi0nX8Q5kONj9Cnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6oSX507fr2l8vtccBWZYMca2otxF/tQp5TqlXJ+VRJ1yNcwkqag+UKLZX9awfYKafT0Xgwq4GHuGOAafSx7AlP8wsXU6n5RrbAZengS6Ex1IqlbZa5QanKarM9HtUi7QgWk3hK47txdy+RrGYvKYGB7tI/Pml/N6V8pIHc0AYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxOX/3pm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1808576a91.1;
        Fri, 13 Jun 2025 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827122; x=1750431922; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF3cFtJQTcMBQy4lM7jXXcjLVtEEtKJIoATzivLkWQQ=;
        b=ZxOX/3pmuqRyg1eDeuj+dK+J6SdbvK1zTh1QyiOsoHuNE5hsH5IklmSgio/nobpIij
         MFPi9XbAW+xyJvDLM5zJBrKIXlx12RUxsxsDDoHop0fqJxBOxPJmB4ngstGv85qrataC
         Y0k99MAoqqW+sdt68+DviTqjHGlTcOY++wos5ATNPqIGGR8kVB5weKwJjt5a3ikcndl1
         cvnHAArwYgPKpsMYm2piBx7awLfHw8IP8Z+km+OR/a/kS3qWVElKxOV5HvqBU9CWQH9L
         XFyOinVe+1oezoJegCKWNd35R5ls0tobTQBxXERzqa8Rj+Z1HAoRVg3o55LcDn6f+6el
         Osdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827122; x=1750431922;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF3cFtJQTcMBQy4lM7jXXcjLVtEEtKJIoATzivLkWQQ=;
        b=J8/qkxGXWBwJd1w6ZZNcXkY6f4dVAx6vrBkn0rOsNd5VKltSWWssxQRw/vTCMeH+Q6
         LfDWkCUK+Qx6H40SxEQOcem9C0Jw5w2LwpyoTldH1AXgiqPGPjmEU8kW4nmkhJYuqPjL
         qGn1vM8ucCCvfImu/TUwkRFNXbv3UAOcfTGwRO+lMakor4+md765qF1T6HjcRMPbPfK3
         xe64rnk94VTjrHMKIQNtAeyvCHrNLefDJLpehkCYeLwBn8IrdHgmkObcmG4Ym3ClFOya
         IrKCXsgQ+irSBwcSpkkOfUjCtagrlQcoLbHd22YyVQ/kaV1Vrl31G+bf7lUU3zC1Vf1S
         nnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa5fUs+OoRi5xiXlaXjUftE+CFPIVdmqqlABd+kRWIMyakZTUkX3g7UmxGYvSz3T9KZCUZuu/PMowhIFE=@vger.kernel.org, AJvYcCWGiUIERApJTqlfSfidoiuGFLLzvsDFAugRZOjRAiAQLqlUHg+w5B+QWXXKUfIOJq+WM/HKRgU5hk4D@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZtZQLWUrgse5nWWPyeD19/lEtS7MnMcEGOKVt6pNP5bVsWCy
	UXnptREE7iEM69W9XCM99aF63ijswTwIPHLqzjCIGeCkIntZ4K6uQAjCmxW1lEAS
X-Gm-Gg: ASbGncvzd4Ux79mkUsMNGZcSOBKAau/+gonFFa6VfdnfItNdmiuSL93IXJmPm6jWhye
	JiBV/0qNmTSrftOMNl0vYRqa5XfcpwU9srd/u25Kn8Z/ExZNPR6179sorwPdYDfW2ov+fqIpVUw
	X1ZyK/NWpqFIKUOheMSAxuDrxxT8P/vL+3PTsowCffHtzrpNXC3kAVPx2xyS8RQuT1Smcc9Ftmn
	gYfT8ZCKxsYPE2zTINF+jST+6Ej5aU6rW1uhPQEYWMYiiZNjaACdr4I3jpJx6MJbMCYGPgl8s8D
	a0qzTgnNmgmLxNPLJ8wnYHsVQFvAyxbveA6/GrbuYLfW8h7bcA==
X-Google-Smtp-Source: AGHT+IHdK8qQo3ZG3V7b3Hz4SJ4IVpLiY2VBl4h1vhl+f3MfcXfp7Rgjw/llpCTAemK6u+3no+kgZA==
X-Received: by 2002:a17:90b:582d:b0:312:f0d0:bc4 with SMTP id 98e67ed59e1d1-313f1be5b9dmr93821a91.5.1749827121457;
        Fri, 13 Jun 2025 08:05:21 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca008sm15308325ad.193.2025.06.13.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:05:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:05:15 -0300
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
Subject: [RESEND RFC PATCH v4 0/5] PCI: rockchip: Improve driver quality
Message-ID: <cover.1749827015.git.geraldogabriel@gmail.com>
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
V3 -> V4: fix setting-up of TLS in Link Control and Status Register 2,
also adjust commit titles
V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
suggestion
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (5):
  PCI: rockchip: Use standard PCIe defines
  PCI: rockchip: Drop unused custom registers and bitfields
  PCI: rockchip: Set Target Link Speed before retraining
  phy: rockchip-pcie: Enable all four lanes
  phy: rockchip-pcie: Adjust read mask and write

 drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 11 +----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 ++++---
 3 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.49.0


