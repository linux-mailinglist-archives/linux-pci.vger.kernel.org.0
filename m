Return-Path: <linux-pci+bounces-11662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8AB95162D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421771F244C4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB413D518;
	Wed, 14 Aug 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL5FPnVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B713D2A4;
	Wed, 14 Aug 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622959; cv=none; b=YXOV+/7IxUpEvtcCOUdYPMLnoP9fLKWuGN+8poWUc2niaXhPVtgb24TAOa/4U9gV73rcf+PppQbKouOXjpIBEoZ3H5fjATerx0eK1T7WbBGV1uGcG6t3v/GKNewILM3RUe7OGGFvMjTo+kaCx6zOjcqE97Ej1Atbl1fW0F4hha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622959; c=relaxed/simple;
	bh=+tqs6o2jIS/Xoflq9ps38miVMDp8z82qkSyMMzRu+wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oE6+pGEBbBcEgkmwA9ZXpWCtPz+SCO5dKm7R2xCbb45IC84PJvJBGHJJyyAT80uAxVgKaoDoEGEgMJ3OzYGB3uSc+G6b+C+/iz2pleIwULye5v7DonhJwC8Ez1tYC4CzA9Id1Pu/vUzgGL0JXxkLWJPwt3tH0KOaDEgozj7hg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL5FPnVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8663EC32786;
	Wed, 14 Aug 2024 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723622959;
	bh=+tqs6o2jIS/Xoflq9ps38miVMDp8z82qkSyMMzRu+wk=;
	h=From:To:Cc:Subject:Date:From;
	b=XL5FPnVS0XG3jZaQ2fxN9roq8cXM1UZgQsp4125Lpwj5Y5tDS5bEvyGFzF9HRtgAv
	 46UuzBbbcl6yWZnUtB5Bp5JOpnXtZ1bcXFVgulp6aLOc0+9grH0pJ/43jyGJgjqP7C
	 RZohY78Pe3SaTukhlMn/ULK/71mWywZhFFQvR2Ot28qzxSSi3EOxyMxZ0IgANaIajF
	 rtZu2myiysFS/Yn8qtrOCzVJHoyVdindo+OOwZ7YMsj55609AVXBMRKtFXl/vVnk9P
	 w8oxVH1ZY4x12KiZkzkkneveTB4XO0iSVeE7qeWdGd9/up9lOwv0xAmfewwwffIFWm
	 fkrPeqS2v+yyA==
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
Subject: [PATCH v5 0/2] PCI: microchip: support using either instance 1 or 2
Date: Wed, 14 Aug 2024 09:08:40 +0100
Message-ID: <20240814-setback-rumbling-c6393c8f1a91@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=oenr9RCh/D6LfU/4KK35V3BOr+N0Qxe0IOLLSKy4LD8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl70jg+RjA47pJwV3uk0HOPS0k6de0TVcO1UZ+0/O78q hfMu9rVUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInU7Gf473jEo1uzcPbRvStF WDV9Cgyf2yXp67kq1MslvV3+1nX6YkaG/VrHH8iy/toZ+EleuublDx1WXkE9fW+Hojcav5c4yuz nAAA=
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

v5:
- rebase on top of 6.11-rc1, which brought about a lot of driver change
  due to the plda common driver creation - although little actually
  changed in terms of the lines edited in this patch.

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

 .../bindings/pci/microchip,pcie-host.yaml     |  11 +-
 .../pci/plda,xpressrich3-axi-common.yaml      |  14 ++-
 .../bindings/pci/starfive,jh7110-pcie.yaml    |   7 ++
 .../pci/controller/plda/pcie-microchip-host.c | 116 +++++++++---------
 4 files changed, 87 insertions(+), 61 deletions(-)

-- 
2.43.0


