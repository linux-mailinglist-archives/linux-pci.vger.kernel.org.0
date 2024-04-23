Return-Path: <linux-pci+bounces-6576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E618AE9EC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C391F22425
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04341137903;
	Tue, 23 Apr 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MX0nABRe"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7413B582;
	Tue, 23 Apr 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884237; cv=none; b=EXzelHHfsE56T64eL+Xq5FBfGvHEuARlTG13KtNMHa9OMFRMXDFLBWPpnZRAnRun/eSRdCEcHvVESvcu6Cs+ByEz/N063ZK3Pp+sitXYPilgFEDRYJo7W020CCpC00i/7RsV5b7t2SS4tdRp1Q+4ah5gRRkldJLz6pVEkLPAF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884237; c=relaxed/simple;
	bh=DuawcNa/W9G5s+blYbeqO21xE2gDEz/xIRPspz04RUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t2RPosDMhLdLPML8wCWvEhTWndBx9CPMR5kJWV1eUm5oBAAxMUfEQzcBnNnj3tLeQjoWf8qCburf6bB+15PcaqIAzIq+PqEjko6+yB96mQaOejMoNbUP0FuhiGSF5+c/bqr3qMgx9MlftVkGsEwOkX/wE0Q1X1TrVlnrjsA1cZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MX0nABRe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 57A092000A;
	Tue, 23 Apr 2024 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713884233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7tCUyoWOieT3ct2HHWEZBi0piGX9UNgmmeXMfQxZhHA=;
	b=MX0nABRe/ITKnyAAk7o5jkcHQhRuiEml+n2cvJnfbuokoUMOHjRfZTL6tQiiu2cBVgAWRP
	F+90NGj8nG1vzj4CxenrzCpnmRPcyisu7b1QiEhJV3gFxLxpkMqxmW8geG0887DrP6ITiU
	izUwdiT72XvHjaFOK5cLq3UYViLoDA5WglvKLppzLJ70cTgrvqswf0CiBli3nk9C8FQJRn
	fGwyfhC3MRh/FpbM9asZKyLkHFvaEg5PHpBQAzTacrx3nXOIsJm5n2xTJ86ryHJpuNfTmg
	7+j1q6Ifs57iTA00FmPTkT5JwATRB+Alrpc1AxelWkoX5Ed/mTU3TCgiI9T+7A==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v4 0/2] Attach DT nodes to existing PCI devices
Date: Tue, 23 Apr 2024 16:56:57 +0200
Message-ID: <20240423145703.604489-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

The commit 407d1a51921e ("PCI: Create device tree node for bridge")
creates of_node for PCI devices.

During the insertion handling of these new DT nodes done by of_platform,
new devices (struct device) are created. For each PCI devices a struct
device is already present (created and handled by the PCI core).

Creating a new device from a DT node leads to some kind of wrong struct
device duplication to represent the exact same PCI device.

This patch series first introduces device_{add,remove}_of_node() in
order to add or remove a newly created of_node to an already existing
device. Then it fixes the DT node creation for PCI devices to add or
remove the created node to the existing PCI device without any new
device creation.

Compared to the previous iteration:
  https://lore.kernel.org/lkml/20240325153919.199337-1-herve.codina@bootlin.com/
this v4 series does not create the of_node sysfs symlink.

Best regards,
Hervé

Changes v3 -> v4
  - Patch 1
    Remove the of_node sysfs symlink handling
    Update commit log

  - Patch 2
    Update commit log

Changes v2 -> v3
  - Patch 1
    No changes

  - Patch 2
    Rewrap commit log

Changes v1 -> v2
  - Patch 1
    Add 'Cc: stable@vger.kernel.org'

Herve Codina (2):
  driver core: Introduce device_{add,remove}_of_node()
  PCI: of: Attach created of_node to existing device

 drivers/base/core.c    | 52 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/of.c       | 15 ++++++++++--
 include/linux/device.h |  2 ++
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.44.0


