Return-Path: <linux-pci+bounces-5117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4188ABA4
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 18:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC83ECE2E92
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5863F7172B;
	Mon, 25 Mar 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D9eOlXU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87B5A0F9;
	Mon, 25 Mar 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381171; cv=none; b=mWSBIf5o3oJlo1ytvhMiMTWqD4DSbBiWpYj0yxi22DBBsTnzhYzKlcMSDwnib1kooa99iKOJOumqmE3WE24ZVPWFB840PXREXvjtZYdVx2pDJiGmLQujLdvkZ+PzuIwsLL6GY0v+GLneg47Z/EL3ofsSVcTBAh6MEQiOBKWiSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381171; c=relaxed/simple;
	bh=ccR6vDDFNWpCgtzvRTLYAx6ybATdd5DFFbWg1zrCVk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIT3/I6cNuhvtKvyRffXzopI4Sq/bi50qIKbgMvem6XWe2oNpBvyfcNaypL7ebZF9MGKQGz43r7rnJ1Fkuv/56+Qcr9ISicIvVFrhCxiJL7uYhBATrMliUCtjtddaFR4TWJwmynSo4InR8UDQlmE3EmruhfpJKBReydyYgm/IgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D9eOlXU8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B03DD1BF206;
	Mon, 25 Mar 2024 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711381167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BI9/S5YA7YwZs4xbRST77NL81NkPg54oVD1qE1aBJP4=;
	b=D9eOlXU8wYcaND6FnusPZt6Irok30wuxp54GEdap9mxB6W9LhixAg/X0hVswE48c4OHun+
	jzQY9TzU707lt5/ZTGTyww3SWdvlUs8R/GfGemg5EoI+Fs7ViocT8d/aQkRjEWUFuU3GCn
	x8CjCW+JaC1dLw1e7q0pIB1GOW7+kPeKDIdml7uuT7OY7SY7cs+w7AdsH0yU+GmZdT7RL8
	9/dFqQ/2VdwMNdOLORA4fXiBTf74VIfZAERaFxCk5mIDfhzNJWaEJrykPnvGCfsj67tW7A
	vcM5lPdYwCCglGR3XKJiHuaYHpCT9z09eJTlLiRzEq/Lz8/A1AUBvd1jukwEqw==
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
Subject: [PATCH v3 0/2] Attach DT nodes to existing PCI devices
Date: Mon, 25 Mar 2024 16:39:13 +0100
Message-ID: <20240325153919.199337-1-herve.codina@bootlin.com>
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
  https://lore.kernel.org/all/20231130165700.685764-1-herve.codina@bootlin.com/
this v3 series rewrap commit log.

The potential issue related to the sysfs of_node symlink added after the
sysfs PCI device is visible from user-space (raised during the v2
review) is maybe not a problem according to Bjorn:
  https://lore.kernel.org/all/20240319165430.GA1233494@bhelgaas/

IMHO, the discussions started with Rob around the interrupt-controller
during the v2 review are out of the issue this specific series tries to
fix. Some modifications are needed for the interrupt-controller topic
but should be done in a specific series.

Best regards,
Hervé

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

 drivers/base/core.c    | 74 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/of.c       | 15 +++++++--
 include/linux/device.h |  2 ++
 3 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.44.0


