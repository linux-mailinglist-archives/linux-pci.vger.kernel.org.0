Return-Path: <linux-pci+bounces-9758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C56926952
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 22:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A89BB2625F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B8718E776;
	Wed,  3 Jul 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uanslunZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB013DBB1;
	Wed,  3 Jul 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037343; cv=none; b=pjhP4o9lzB1l5tw+FNeGyojDgp6JUR0Ehdw3ba59Ybg1cZ04kE0q87pEymxZSbD0ZUb4JrQuOEt/UsdX5K08N0Ig/BBEOzsQzQBhpAPkr4jUnEtdsvYCOmC81ZaJJrZfDMlFyvQkFs8TwivLRhatgLsu8QdrCI7C5Mkj08+NxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037343; c=relaxed/simple;
	bh=aYbHslMbo5658qwdT3gkCNxpaGZS1ogTj90k1s36n8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H18Olbz8VO4W5D6xbhPDjD7UBcJPAs5EYETYxr2VwtKK1jOcwn0rILvn2t+iwGe0yZrsHFp02gVbO+naS0z7suK4qLjTEu8rkMxvpdNFbYFVfG59IRmcEE8CeoMU3UpcoLhVhY5M0TS8GyB6OkHcmWJL61KfUOWP3I8KfABYQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uanslunZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094EEC2BD10;
	Wed,  3 Jul 2024 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720037342;
	bh=aYbHslMbo5658qwdT3gkCNxpaGZS1ogTj90k1s36n8M=;
	h=From:To:Cc:Subject:Date:From;
	b=uanslunZzMpUHeaPZtIAM39fLDSvTd1CwE9fVzu8B5nqpbjKgU/SQ6b4DISEy0yZb
	 HVsZ6IZqzBzpihZE6wCzy66hurceQj89cdo2PwEnzzIi6e81l3wD3jBOTbTEWWbtFW
	 x73RPVSKxoZAQ5zuJ/RYb2hXnPQ/Zawg73DdTJ/IGrkJKk6BfkCQ7ZtnhA2sDgWXHK
	 b2uF/7ZT9VU1EjQBv6zVkvTjoHuHLkHO1fmjZMmEjgU3FeUokuJzkbhFc+o3W/Ma1M
	 phQOwB5xuCdI8w1NdngTACZWbgrimvWNgToTe2IDDWybFRRGgDJnPPPGi59YvZD+wz
	 MbJDpsWIJZ4HA==
From: Conor Dooley <conor@kernel.org>
To: linux-pci@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/2] PCI: microchip: support using either instance 1 or 2
Date: Wed,  3 Jul 2024 21:08:44 +0100
Message-ID: <20240703-stand-ferocity-bac033ac70b1@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=nUAy4lu9tNjB0mh9nOJJDmgdT1HtV+a+iNjY3WPTG04=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmt66/+UGL/e0tL6N9S2cu/zXy/nQg/95Eh/U36NvX85 NjPT06zd5SyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiMxcwMjxI2bTLN+DissjL GY3fwsR/2cj7hPZJz53Udn/2xj8v9aYzMjxtEBFIXfByd+4iR5XPHKxrrVOmLDO0yZq97CH3Aa+ HfzkB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

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

v4:
- fix a cocci warning reported off list about an inconsistent variable
  used between IS_ERR() and PTR_ERR() calls.

v3:
- rename a variable in probe s/axi/apb/

v2:
- try the new reg format before the old one to avoid warnings in the
  good case
- reword $subject for 2/2

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
  PCI: microchip: rework reg region handing to support using either
    instance 1 or 2

 .../bindings/pci/microchip,pcie-host.yaml     |  10 +-
 drivers/pci/controller/pcie-microchip-host.c  | 155 +++++++++---------
 2 files changed, 79 insertions(+), 86 deletions(-)

-- 
2.43.0


