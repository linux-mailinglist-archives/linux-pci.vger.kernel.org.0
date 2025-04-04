Return-Path: <linux-pci+bounces-25296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AEA7C2B8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 19:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D884E189A27F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434021930D;
	Fri,  4 Apr 2025 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gedPMeAg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A81FF5F3
	for <linux-pci@vger.kernel.org>; Fri,  4 Apr 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788797; cv=none; b=GVGu8YNKLCXniaFZbC1vxiSf8fo1rQ4YpZRcpuHvXK/d7mt6gvifrafhWqBS7Hzs/VMPGQIBSAkIiJCpG278SlxE+qgFK/u0zLhafver8Xr4kgF6pMirHuolYKANQddwM2h52tnBPr1YIYicYs8GFP2zxB6zCJ/xS+BE/Mbi83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788797; c=relaxed/simple;
	bh=HnIKeuPS9ScxVqrmLvwEy/zskUnDiOArxioE4fgpNKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E7k2On5zLJgpEGSXRGP9sPoxcKd52d+HUftu/Qr5xtDX9sEly6l3Jnj4+HfMLvSps+XOmPeT8llXK8g/W5VdvqiTlbtke2p4TEZocqQfNUZioJcVQQdVWUq/NluHFf1YBTNmDuduKqlBj/j5XCxYO6zfUj5DaIcDvw3CBPAliu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gedPMeAg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1506078f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788793; x=1744393593; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9P/EfEIlZAESjSXhp9OseFFolhRdBBkLN0jHHdJSb0=;
        b=gedPMeAgzPCWkbh4Jdtfzo6StXD3PwDypEuMjE22jHifxtoSWJbDAQvNFAziZG15kp
         LJziDhJoG520ChaWY9+8YTHSx9CgupivOEordaXH+CvZc1e4li5nKL/wWLMDTPh9YUm8
         Orley/VH/pp599KHv7WNt4qLJYoGy9ZOwNcQtypzKrBHl1enxPJazJCmzmNRK9uCspG8
         Eb7SIpQQ9qugIBqoz24SRqLjxUn2JeJufUtEuhrroHlRz7cgirutrddRslYotb2TWoli
         8M3aXf9ERSHCEHF6sMGUTqS889Prab4dxEIjG/wgZ7CAMFA5wAULOcCPIbZHV342RQbP
         3BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788793; x=1744393593;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9P/EfEIlZAESjSXhp9OseFFolhRdBBkLN0jHHdJSb0=;
        b=Ruz45tkPXD+oNVhqz7ysrLyG9gyZJiU/Hu7Zdl5twwKVz/gUy3oRYWvC2Ll1waM3GG
         pTm2KSafnyTq+S7/GiqWL/Km6SvMBp8NGqkgctUPMphRBDLFqc2124qgJIOQbhUntjX1
         o2GFYSgcVe0OL382HXN5QZTmkqD4Aak+L66VUoVY06tAzSodghdfEfBsYYa2ElaFeo0R
         wTof0uTLa8+1sNojZa3/CCrx9lezLvpkaeRs9q3RW55TDy7vheo1FohHMxCTkdgDtB3e
         KYaWO/lLP/Fgu9YRuoXVoMP/fmo3UBQ/kr/EC8fLpSuuVcKrvCedW0Q3lLlS9R6zhJ//
         r0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3uIGF2x10aVeq8W/1xo77tuYBnpPXgfMltdXKAYQEH8ySarmpgWgPenPOrDA+DwUtk5lkMZS5Zcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyswCOy/lz44nGKPmK0yRaUbtPobMtgSQVmvN2/vNaPcMP7AiRk
	1kD1nWkLDJOcoV8qRnt+XNGvC32xlUBks/uYXp0to0o/Le+QVCjLTG0M1reZjQI=
X-Gm-Gg: ASbGnctWF9tZzRufxXdk+E7pY4VMdkj+/bouYkfm+1z/LZaEkHdqxyYaKFgoyWzxGrL
	jYWJWE12l8rT6XzFq6SD8J1aT2iO3ILL/TF6ylb87zllzsrA+HukSR4iZAx1X9EZ/HDsL3rLzrY
	drbb9nBe0e5w8FO6GVf1UChY1hrQTzHo6TGFiKMHsAZCTu+AcGNCR1sz0EvcqSAxketoLEb143G
	IhJ4RBzEhZqNTL7G+MMc0CRJ06+rGzDw0Jf8nCWURfMKZHoONRZbmh0zEUnnm3LF7qz/oeEAFCD
	Kg94Oj/mp682NbkSSLS3KfXDeLmwVW6uNwiH2BFNXyTCcfomtCuHG+nVyw==
X-Google-Smtp-Source: AGHT+IGswdimuWy71mElHnsix4QxjHQgPPPL6pnV5SEEI7VP4vSW+eIfVbl+qVp3zMV1Qro4ys96Qg==
X-Received: by 2002:a05:6000:4304:b0:39c:12ce:1052 with SMTP id ffacd0b85a97d-39d07bcd00dmr3359518f8f.7.1743788792654;
        Fri, 04 Apr 2025 10:46:32 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] PCI: endpoint: space allocation fixups
Date: Fri, 04 Apr 2025 19:46:19 +0200
Message-Id: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsa8GcC/4WNQQqDMBBFryKz7pSYEhq76j3ERaJTHdAkJBJqx
 bs39QJdvgf//R0SRaYEj2qHSJkTe1dAXiroJ+NGQh4KgxRSiZvUGHpGCpj4Q2hmHt1CbsVm0Mp
 KbbVQAso2RHrx++y2XeGJ0+rjdt7k+mf/FXONAomUvWtbK9OYpzXbzDbStfcLdMdxfAEsqBEIv
 QAAAA==
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=HnIKeuPS9ScxVqrmLvwEy/zskUnDiOArxioE4fgpNKo=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br0GcS36RFMmRwE/Qtn26ZHmwW0s83GBeg7y
 773n9yVaTGJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9AAKCRDm/A8cN/La
 hfvAEACA0VtF3NMnYIFrqEUkjvSb46Wkq2f7q2zeUzwCnDEAkjmm5h6qGhYVIehmnD1/clPJrU3
 5ijoeFmk2YGiozkRlrVfP9CIHbnbt2J0XDnpImDVPRsXmM0+lE8BLGYx4F/zR3ClRfMykKjThy5
 MpwKJP1Pql+X4z1okaSp5kxHPiWz0EYdSEwaG7hXvlY1fUeUD2H0WmR7E8q/zHygnBVBAV2VnUs
 c/NL+8wGvxfMmYI9CbK+Y8sTBvoZP73yt7ZyygSAS+Xef6pm4kEXCd5rh36aZKcKauJoK9uRNe/
 blZiSOqCYREwN9a8w4lImfVuvMwZWeW3bYeABAjrLHjgJPRykGlEAoh3MxNW33SrITwPbjd5BiY
 6r8ieK3B5GnXTCWljHKymVLFYis89YjSOYf7HIvLO3L0HQIiXbMgh8tpHh7EIDavIvuCb/lQ4nf
 AmGKNIeNmvkk67kIXxodz5CVYBoMIi+SXuZfHbnHvltLoxFVybDM6y940lUzp/tegXVQpm21uBn
 +T4Nl1XsOW8+84QljYj6HUatBhxoZ11FX9pninfWRWDKmDU3XMr1OxWUH3d85boNMcipoKtb8fA
 qMe+9GF5j5FLgjbr0jwZleVpuQkpNRoQs46Bdu4MloDosRGiWIFfXe82VzfcgvGkInT88Zsbb3X
 crvrJtyRCZ0TwyA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset fixes problems while trying to allocate space for PCI
endpoint function.

The problems, and related fixups, have been found while trying to link two
renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
function. This platform has 2 configurable BAR0 and BAR2, with an alignment
of 1MB, and fairly small fixed BAR4 of 256B.

This was tested with
 * BAR0 (1MB):  CTRL+SPAD
 * BAR2 (1MB):  MW0
 * BAR4 (256B): Doorbell

This setup is currently not supported by the vNTB EP driver and requires a
small hack. I'm working on that too.

Changes in v2:
- Allocate space that match the iATU alignment requirement, as previously
  done.
- Chose not to add a new member in struct pci_epf_bar, as initially
  discussed. After reworking the code, that did not seem necessary.
- Make sure SPAD registers are 4 bytes aligned in the vNTB endpoint function
- Link to v1: https://lore.kernel.org/r/20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (3):
      PCI: endpoint: add epc_feature argument for pci_epf_free_space()
      PCI: endpoint: improve fixed_size bar handling when allocating space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 42 ++++++++++-----------------
 drivers/pci/endpoint/pci-epf-core.c           | 27 ++++++++++++-----
 include/linux/pci-epf.h                       |  1 +
 5 files changed, 40 insertions(+), 35 deletions(-)
---
base-commit: dea140198b846f7432d78566b7b0b83979c72c2b
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome


