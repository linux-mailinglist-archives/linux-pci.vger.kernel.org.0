Return-Path: <linux-pci+bounces-15981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ECA9BBBAF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A4281C8A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4C1C3027;
	Mon,  4 Nov 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CMXuZy5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6517583;
	Mon,  4 Nov 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740812; cv=none; b=s5u3pwOkp9qlip/fbq+gtNp9ZDbyqXXHsLBAF7TcyJFA6zRHS4mbxkP1vny3LZmWQozok+UXRFDD5nQ6eImiKhsHWEA0dQLN9SVXpnicNDDYLX8HLCmS+EOIxEDknOuW5/aPf65xI/OBgthqsUaPLK/F6vy9o8PoX2qnOrID/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740812; c=relaxed/simple;
	bh=ycNpH8N3PKMFz0qEcThX5vwxP3PJEWDvCPGGURohHZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJGdByZv0J9SFz4kCfQLpwE9/iIlYEh+vujqIQh14rAj+1tgULPF9URRIDI5MI1AGm13UfSf+HFLzSupjSkJdo8H+ncZT3Ww2wro6lbHaxQRSxw3HHCiE/PyWvHANU8tlWk30zbGTXcvM03AZ2B9h2nFMOwyrX76dFpljR+Kdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CMXuZy5h; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BB9A11BF208;
	Mon,  4 Nov 2024 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730740808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=npjbI9uj87WSUYfFGpUGAN8meUGo04Pd9AMGOB6e2IU=;
	b=CMXuZy5hwqJT9ec4pp9SqWAesgOegVBQ3AgWUqIEfldt9OkKZuBD0DxOFYMJe+axF8NAvD
	8wWovHSC82P/F5rX5Ip+Rw+7MGZKpr7AUVa/nIwj7Qg3vKzHxyaUymVRFqBQKjgQTfi9f2
	76cxWYGADL/yliG5HXox04MJWWe3cEEhRki9T9pVDkmv8SMTbaI4k7+hgmASrkIQ4OeJO8
	qhY5BMRnI+nGaFflU7S9iyO2ovjSXWOJ47oEkdDz7RtFRwOU2IT3qjIgyevRCyBSuum8kR
	5SZq+gHgp1ks3Dndis31VULxwN95PBVmkFISBeJ8sNt8I/8nXqcRZW0y4WsJ9g==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/6] Add support for the root PCI bus device-tree node creation.
Date: Mon,  4 Nov 2024 18:19:54 +0100
Message-ID: <20241104172001.165640-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
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

This series adds support for creating a device-tree node for a root PCI
bus on non device-tree based system.

Creating device-tree nodes for PCI devices already exists upstream. It
was added in commit 407d1a51921e ("PCI: Create device tree node for
bridge"). Created device-tree nodes need a parent node to be attached
to. For the first level devices, on device-tree based system, this
parent node (i.e. the root PCI bus) is described in the base device-tree
(PCI controller).

The LAN966x PCI device driver was recently accepted [1] and relies on
this feature.

On system where the base hardware is not described by a device-tree, the
root PCI bus node to which first level created PCI devices need to be
attach to does not exist. This is the case for instance on ACPI
described systems such as x86.

This series goal is to handle this case.

In order to have the root PCI bus device-tree node available even on
x86, this top level node is created (if not already present) based on
information computed by the PCI core. It follows the same mechanism as
the one used for PCI devices device-tree node creation.

In order to have this feature available, a number of changes are needed:
  - Patch 1 and 2: Introduce and use device_{add,remove}_of_node().
    This function will also be used in the root PCI bus node creation.

  - Patch 3 and 4: Improve existing functions to reuse them in the root
    PCI bus node creation.

  - Patch 5: Update the default value used when #address-cells is not
    available in the device-tree root node.

  - Patch 6: The root PCI bus device-tree node creation itself.

With those modifications, the LAN966x PCI device is working on x86 systems.

[1] https://lore.kernel.org/lkml/7512cbb7911b8395d926e9e9e390fbb55ce3aea9.camel@pengutronix.de/

Best regards,
Hervé Codina

Herve Codina (6):
  driver core: Introduce device_{add,remove}_of_node()
  PCI: of: Use device_{add,remove}_of_node() to attach of_node to
    existing device
  PCI: of_property: Add support for NULL pdev in of_pci_set_address()
  PCI: of_property: Constify parameter in of_pci_get_addr_flags()
  of: Use the standards compliant default address cells value for x86
  PCI: of: Create device-tree root bus node

 drivers/base/core.c       |  52 ++++++++++++++++++
 drivers/of/of_private.h   |   2 +-
 drivers/pci/of.c          |  89 +++++++++++++++++++++++++++++-
 drivers/pci/of_property.c | 113 ++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci.h         |   6 ++
 drivers/pci/probe.c       |   2 +
 drivers/pci/remove.c      |   2 +
 include/linux/device.h    |   2 +
 8 files changed, 260 insertions(+), 8 deletions(-)

-- 
2.46.2


