Return-Path: <linux-pci+bounces-38509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551F7BEB59B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A356E7E10
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0F33F8DF;
	Fri, 17 Oct 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rmnKi+FM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425033F8BF
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728068; cv=none; b=MFIR6R0PN6UvdQCiqrVxnswMC3eoFWwl0LCcseD1n2DVetoBNcttzFvRL7wbOKcaY7dvobV8xcVS6HkpOzuFDKqHoQU2Isy5JoOdOW6wPfZ/Py+UENq+B2kJ/D60IDsz4D0I0Kt7TGxJ/NBiJZXv+zUlKiwRY9VfoVCzt+05RC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728068; c=relaxed/simple;
	bh=LqFmCYRDrPtkcUDZw5zwYA2weRZUj13NHO7zeAuhORY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tobQkAP5Cx5PMscWeluVTpdfvoXsmRDW+fY1x+gq43mQngGxhZ6J1zthYETqaU9Spi1u91hmCUUjJaTfDoQuXFHHiPVbSsf3p4NvxZ5YrCZImJBQvYVwcZqKNclPzc8zJ+ipbbnxmQmaD9qEWtH/mGHzNAilsVHhIh4dxBjoDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rmnKi+FM; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-938de0df471so196616039f.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760728065; x=1761332865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AlkAll+OG6DFncv4Mizto8zaWsmmVbaRHf+nrpHgq8=;
        b=rmnKi+FMoDIGzf3rcVRrvUav6f6ihKSQpWXBo54c+7YZ9/CiqHPxxMa1Hjx5QG2Pvf
         AC6OBOn+DfLAdBc8wgFkqGFBwJa3F6TRBx+7jsvBvNFWin19/iZha9l8D4RMjg9ZqURC
         9Kpry/105Z/qOqerC++6SNg9S8Ss3TcrJjmbJPiJnpOWcys7yF9f8nIBP2tQT5i626+6
         nDJo01Rm+QpldHdjpRBmzAOSCa5iXZZs2vkba9PPDvNIJDWYQPXVVB86LWrk0XOriqmr
         a7CbGQj09GZffCZ8qcV86DZcLvqV5/yVujc1GnfsRCiknOhDemrBV8jmpqSGefCeTjUx
         bBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728065; x=1761332865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AlkAll+OG6DFncv4Mizto8zaWsmmVbaRHf+nrpHgq8=;
        b=NLK969+UGKHzddnjk8tzwJ6IQwJwGLNr4BQ+6Jry7CvY0B1vTU+damvXSP4CDvSkzj
         62xUJ516CMKkCv8/v449QWs/pALdaD/1yGGTyLuiqfAYk4cO9Lhdxknzuji8+knwJl3h
         ym7tpSWoT3XArmrU/QTL/Nv9gfmEO1OUvp0zUX7YjRtNZwUNvws1sV8hpmOkIeiSL4nz
         geXyAZKT7uYE+M2pDVneMELGnEVLnO7rjMQrdm7Foz2agI04oSoLodcClUHAEnr7oIao
         vjKUh2cZp9N26yf7RhWyUXA5SmVI80wCSTEMesv2Tx8ESDDgkzKClzAwUtdQmyXwpSew
         E4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUfKlU7BD/N5+X1Y5tFaaP1oHuY+rfdmV0EcCPV/S2Px+uz/gWgKf53NQLbimPe2dcXZTNCVQC6Ct0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdr/fpUDFkK6+4NeBBGdNKB2RVnNAVDBu2zZD0AT5t3K6dOMZL
	jHuExbh7AiVY5oLV/LZyWF1r/giDbNt6bsz5Xrs5eZsXlCDsau046++WnIi2GcXL2JI=
X-Gm-Gg: ASbGncunTexEcOAlghUqQiAgLgsm6Dp41b+eJCxyPMlDDHVupD6/eILgJ4s/kpo0jVa
	W0oU/NeEbDqLCF+T9lgOj0dVfhnDffGkshhWZ4/j5nitdZMEo3uBskiGNqaNKO5KAecwKDIB4k0
	y3c9YLcY1khikFdZRZ+rFTbfo2oMSN2EL7nXoHYWVSm2p+K8DSWrDsFJvqJVNJYrvxNizNWIUNg
	ndR1bWU4HUvfQ2vBBYq500pc/dMDNpfmbU9mVfdgSj6fRqktJwEHJsnUj2Qw+IyN7ac4vH/O97l
	PWx7pYUoldWBvWFpH4TKjEdHwEqjIj5AwoDQGtCe3P9z2oOc9nwMjwneUFJDuUg+BYTuHBZyIl/
	C68UMCdRg0KKRUnc3b6XQkr97BkClHBkp+mZ6k6xph28QWtzGJnIUZzLmIqnlOv+ljAc3Vppcry
	9+d+7fHkESzrqNINIS8VdMNkOz36O6YElbfapyr0uDDD+HYLdFH4JXPw==
X-Google-Smtp-Source: AGHT+IFcpf2h7+KbWg4DjQlVTU7Ya1aj204MdKeqW83UKVIYqzbU0vSTSCHA4r5eCSfPwXiiSMaLeQ==
X-Received: by 2002:a05:6e02:4510:b0:430:c77c:cc35 with SMTP id e9e14a558f8ab-430c77ccd47mr56314875ab.29.1760728064783;
        Fri, 17 Oct 2025 12:07:44 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9768b98sm153462173.46.2025.10.17.12.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:07:44 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: ziyao@disroot.org,
	aurelien@aurel32.net,
	mayank.rana@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com,
	krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Date: Fri, 17 Oct 2025 14:07:32 -0500
Message-ID: <20251017190740.306780-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a PHY driver and a PCIe driver to support PCIe
on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
one PCIe lane, and the other two ports each have two lanes.  All PCIe
ports operate at 5 GT/second.

The PCIe PHYs must be configured using a value that can only be
determined using the combo PHY, operating in PCIe mode.  To allow
that PHY to be used for USB, the calibration step is performed by
the PHY driver automatically at probe time.  Once this step is done,
the PHY can be used for either PCIe or USB.

Version 3 of this series incorporates suggestions made during the
review of version 2.  Specific highlights are detailed below.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pcie-v3

Between version 2 and version 3:
  - Reviewed-by from Rob added to the first two patches
  - The "num-viewport" property has been removed
  - The "phy" reset is listed first in the combo PHY binding
  - The PHY now requires a resets property to specify the "phy" reset
  - The PCIe driver no longer requires a "phy" reset
  - The PHY driver now gets and deasserts the reset for all PHYs
  - Error handling and "put" of clocks in the PHY driver has been
    corrected (for clk_bulk_get() rather than clk_bulk_get_all())

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20251013153526.2276556-1-elder@riscstar.com/

Full details of changes made for version 2 are available there.


Alex Elder (7):
  dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
  dt-bindings: phy: spacemit: introduce PCIe PHY
  dt-bindings: pci: spacemit: introduce PCIe host controller
  phy: spacemit: introduce PCIe/combo PHY
  PCI: spacemit: introduce SpacemiT PCIe host driver
  riscv: dts: spacemit: add a PCIe regulator
  riscv: dts: spacemit: PCIe and PHY-related updates

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 147 ++++
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 +++
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    |  71 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  38 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 146 ++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 311 ++++++++
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c            | 670 ++++++++++++++++++
 12 files changed, 1553 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c


base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
-- 
2.48.1


