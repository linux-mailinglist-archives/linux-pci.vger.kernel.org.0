Return-Path: <linux-pci+bounces-290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60067FF382
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A81F20F1A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408C524AE;
	Thu, 30 Nov 2023 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nhujXbLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B091;
	Thu, 30 Nov 2023 07:24:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 33BF9FF819;
	Thu, 30 Nov 2023 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701357864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v+nQkelvQTnzRkwxNq+pa0F2OV4hlU4a1lu/z9jwG/s=;
	b=nhujXbLLrrHYyrkii78atlpuWy3D4MaZDc/zTxdwqPaaImGYkMaRZDEUdbvKyC9Ft/PyRI
	69+8sC8yBbcmWctv64fXgCTj+lpZ66wS5PxH29kNB0GTUEUhulBVpHJhhukIAUKy5imN45
	oeGzoFhhHh+BUYjqI5l3SJ7507YIKzJPEnk5G7AzzPSCmPJQW9pTbgHngpQemjAPQ3LUtS
	YmtIFiASTaRdubN3zTmpGU1O2Fqro8clgq603HnznVE6Viq95j2L/fPvFAe/783nHUQdLG
	0RH29lj5GFOfv1lrsmr8ok8Ak0GRVQhStf2j3+kY7Bte1mEDM1MkNot6hhGcSg==
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
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] Attach DT nodes to existing PCI devices
Date: Thu, 30 Nov 2023 16:24:02 +0100
Message-ID: <20231130152418.680966-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
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
new devices (struct device) are created.
For each PCI devices a struct device is already present (created and
handled by the PCI core).
Creating a new device from a DT node leads to some kind of wrong struct
device duplication to represent the exact same PCI device.

This patch series first introduces device_{add,remove}_of_node() in
order to add or remove a newly created of_node to an already existing
device.
Then it fixes the DT node creation for PCI devices to add or remove the
created node to the existing PCI device without any new device creation.

Best regards,
Hervé

Herve Codina (2):
  driver core: Introduce device_{add,remove}_of_node()
  PCI: of: Attach created of_node to existing device

 drivers/base/core.c    | 74 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/of.c       | 15 +++++++--
 include/linux/device.h |  2 ++
 3 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.42.0


