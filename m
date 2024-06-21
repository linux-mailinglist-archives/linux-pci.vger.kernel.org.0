Return-Path: <linux-pci+bounces-9075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84352912866
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77A01C25E3E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C92135A;
	Fri, 21 Jun 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBaqXkJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB2631;
	Fri, 21 Jun 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981353; cv=none; b=aW6cM0y5LFb8Oe6QJBZg4n/xoMF/J+Hhzc5XaI7oRcSCKNi1jgG8CIuOwCSBUc51nABX3HGy82Dvzvp4IxpdxLEiJrDnqsUO7QObZpegoELB7fRrwjB7zK9CBw/fFiXvNLjxwlrRcS3QKqAhNP+bqT91vclj0bhQR9Kvhxpw87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981353; c=relaxed/simple;
	bh=JolrwFO5Y598QPe1Pt51c15YFqkxtE9Cd/0+WsztOxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cX0xSHqFdl+XNg19xNrxM1GD+E0RTVMyfQ0/z1eval3lvcksw2CYgs4YKMqpztPjFYPjFy5zH8vZC0U9Bt3DT4LdDJ7r4w74qUaTXMd4zrUuqlpfxgH6gJbQ841Dclo7SWU9g2axHfqZNDTcbTOuKJdfYApflUmX3kiTgTmy0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBaqXkJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4BBC2BBFC;
	Fri, 21 Jun 2024 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981352;
	bh=JolrwFO5Y598QPe1Pt51c15YFqkxtE9Cd/0+WsztOxw=;
	h=From:To:Cc:Subject:Date:From;
	b=DBaqXkJ+XBmgzUTWqRDn1pz6BhA0a99gz3ardMNz4byaDeMAefa653Z7afiXJLWOD
	 IN15/ghr4ycgWs3W7N3WMZ8K1HvU0/Rj08BLZJE8TrjWVz5pVOx1yqC6Qia7nYybQ4
	 5TZg978hT3LnXMMsvRgIeJTcxywi54g/Nln9Wl21Abk+3OWSw+AbCM4aGKk6aB1gsN
	 mlUbaAbmt7G/T5tDJKIOQNHBXAN57JghaEOCigKFOkjIhGwhGnhEK1mqfxj+Gf7c+0
	 QMu4j7NVNlsVVMDyZ/32MiyhcVKx1VJ06DC7qAXvpcDhknr9FAaexcelhQ8jvcJFVk
	 rUO6rvBlJbAcg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	dd@embedd.com,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH 0/4] Add Airoha EN7581 PCIE support
Date: Fri, 21 Jun 2024 16:48:46 +0200
Message-ID: <cover.1718980864.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for EN7581 SoC to mediatek-gen3 pcie driver

Lorenzo Bianconi (4):
  dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
  PCI: mediatek-gen3: Add mtk_pcie_soc data structure
  PCI: mediatek-gen3: rely on reset_bulk APIs for phy reset lines
  PCI: mediatek-gen3: Add Airoha EN7581 support

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  25 ++-
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   | 155 ++++++++++++++++--
 3 files changed, 161 insertions(+), 21 deletions(-)

-- 
2.45.2


