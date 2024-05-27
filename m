Return-Path: <linux-pci+bounces-7840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6760F8CFD24
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE71F25CC2
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225713A877;
	Mon, 27 May 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r5nxq332"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD813A24D;
	Mon, 27 May 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802684; cv=none; b=n3SNFjE0498MAQwehr9LaVTWPH2U9+D+5SK8bUvK5NgrjJrUNamqlXlE9MhhBAJuJKga1NWy90fBPb0JaJWo4GnhTgd+bcH4Fs9Wh9b/evWeoPfrtphyHjC0NFZ9JYwUUzbgA1OgKKSFMwktXFsLdALymln4pcEUXHU1hfSLU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802684; c=relaxed/simple;
	bh=XBN7++Zvn6jUh1suRjCaio6HybTeWQjWEhslD6Yd0b8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlTkreMWik8ZKBgBlyua1sIK9NblD4SwFhrFSB9oMinRqS+o/Dpd2tD4Tz9eGL62PmOcbFrKJ5w5gs57rh4NRcvgwc6tfJgXc0u4sbL3Kq0LcJvQc+xeWAFt89dpGX0DGBno6Bawo4ejX655E34TAr6wjZsqsOBDN1gcO8QzYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r5nxq332; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716802682; x=1748338682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XBN7++Zvn6jUh1suRjCaio6HybTeWQjWEhslD6Yd0b8=;
  b=r5nxq332giUC8OABvwXqZPb0wMgL5doOep7cWgFcYPWi3VFOclXeTjXw
   TxIrTMty7hGsOkr9dZYoz2ToDjktK7piKxh1SkfVazU44lv0cuDK5PkTy
   N3B6pVWX5tJGHR5Ju4/BVps7Llqv/PIAOwOEBeBg6vETEnX8NIUs3Kk5w
   gkjE61azd770U9uQ2ucXhDv8XeLQuY+XbZh1vN5pUFBwLTVfWSVpFS8xE
   218PRZOc/jpPefcvtmgNS/NZZop+0dS+2q+Jhcem00bSVrCYFPhBnEYLp
   0TAJY0vmSPabJglTiI6rlUaYwi/kQ76Zafhgeu68MLZMuA1EvXCdFdvAM
   A==;
X-CSE-ConnectionGUID: AcSvwgxcR7OHBHrk8NTkiw==
X-CSE-MsgGUID: 9VeZiux7QCa+8v7K5kzo2A==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="193774875"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 02:37:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 02:37:36 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 27 May 2024 02:37:34 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To:
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 0/2] PCI: microchip: support using either instance 1 or 2
Date: Mon, 27 May 2024 10:37:13 +0100
Message-ID: <20240527-slather-backfire-db4605ae7cd7@wendy>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XBN7++Zvn6jUh1suRjCaio6HybTeWQjWEhslD6Yd0b8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkhIV5Hb7ekJjy5yn61vjp/YpvsgyCxNZrvRef79E9Z3+6W 8uFhRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaiMpHhr5DDG46y3Zencpk4fFrxyy f147+COPmrgR+W7Www+D5dI56R4amTOremdfZq2zc19WvYBFssG2QYkieJsHKvE0pImxrIDQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The current driver and binding for PolarFire SoC's PCI controller assume
that the root port instance in use is instance 1. The second reg
property constitutes the region encompassing both "control" and "bridge"
registers for both instances. In the driver, a fixed offset is applied to
find the base addresses for instance 1's "control" and "bridge"
registers. The BeagleV Fire uses root port instance 2, so something must
be done so that software can differentiate. This series splits the
second reg property in two, with dedicated "control" and "bridge"
entries so that either instance can be used.

Cheers,
Conor.

CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Krzysztof Wilczyński <kw@linux.com>
CC: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-pci@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org

Conor Dooley (2):
  dt-bindings: PCI: microchip,pcie-host: fix reg properties
  PCI: microchip: rework reg region handing

 .../bindings/pci/microchip,pcie-host.yaml     |  10 +-
 drivers/pci/controller/pcie-microchip-host.c  | 159 +++++++++---------
 2 files changed, 83 insertions(+), 86 deletions(-)

-- 
2.43.2


