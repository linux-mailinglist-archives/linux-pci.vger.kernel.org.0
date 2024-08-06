Return-Path: <linux-pci+bounces-11351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA65948C5E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 11:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9891F25281
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44715FA96;
	Tue,  6 Aug 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="YmRoAwQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72405F4FA;
	Tue,  6 Aug 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937739; cv=pass; b=XNy4Fz08uH1T5tSZSY6JombWAgelpVkT2VOsWTJcsOywxDsIPVm9oUTirvJAkfLWMveQ0LDEzH8UiST/FhMN2ibgll0T+BeaTY5FpnyKXqjn1wujaV15fqFg1C95OfXiajv3AeNyCTdLg9ZmlmFAc5wkawn1Gr0gyT+1go9iYGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937739; c=relaxed/simple;
	bh=7fLqWi2BjWnRYrKdY92w35tkVRXnBR0Sx/FU8FTlufs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1i/r9S5SHVu0wUK7O6xOzJdRWK3H8Cx7q/ikFRnsmB6dJNo5DVcAzNUIbqKh/eJCJq9FE8GupBvRSWsppPTTmx2sMs1xY3C569XaX+JGgmnqOhiqgVGEMtLefpIdohNva0637ON6JMcwOMwf0j3ZjswtxTzyBkGjTJvSBvAU8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=YmRoAwQs; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: angelogioacchino.delregno@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722937716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eTRyLMgnJDJ7dunwP9cq0OaMk0Kmu34D9i95rhbTYrubDVQWQFS6qgnJ2yX4vFpuArtH/TcdBUamrepDklk7/XfpfI+PvGBC2vFF/g/bT3m+LAGwMsGyX3H7A4FeioV4VVCDr2dJn6fNmEbnoD94IEFbrHGW50/ErC3EhpkaLFo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722937716; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GD6UfvEC97KIOXebIuAdSZtO5uJ9zS4OySQ69BroWWE=; 
	b=WsXNK+A2p4HobHfRJZMNprnn4NGoYK7jhdVcGLaZBV23xa7NwCHOrJRZ7zdk3t9ntafVy5UfCP1fCiUAUoCtozcHsl7aWBbdnL0si6QuseVtdxmrXeOpYWvLGpjg+uRpbB0+wMeMngyYOGQd+ZRvhyHPc+kQIDhPTm+xVTktS3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722937716;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GD6UfvEC97KIOXebIuAdSZtO5uJ9zS4OySQ69BroWWE=;
	b=YmRoAwQselZS8RKt9U4ejDe0TdSc1YP400EhtrGgI/a5YDaEVuZoJz8Jd6XYUREi
	XqjzmRAeThu1LoyqUKGn37NKj2Fry1k1hd8L8jtRjRGluzmCRfs12Z0xa2LpdplqGiJ
	ZEytU6EB2vE6cN6u+tjE2G5iZ1PhfD/jdCLUwI5g=
Received: by mx.zohomail.com with SMTPS id 1722937715671111.35593195710089;
	Tue, 6 Aug 2024 02:48:35 -0700 (PDT)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/2] PCI: mediatek-gen3: Support limiting link speed and width
Date: Tue,  6 Aug 2024 11:48:14 +0200
Message-ID: <20240806094816.92137-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series adds support for limiting the PCI-Express link speed
(or PCIe gen restriction) and link width (number of lanes) in the
pcie-mediatek-gen3 driver.

The maximum supported pcie gen is read from the controller itself,
so defining a max gen through platform data for each SoC is avoided.

Both are done by adding support for the standard devicetree properties
`max-link-speed` and `num-lanes`.

Please note that changing the bindings is not required, as those do
already allow specifying those properties for this controller.

AngeloGioacchino Del Regno (2):
  PCI: mediatek-gen3: Add support for setting max-link-speed limit
  PCI: mediatek-gen3: Add support for restricting link width

 drivers/pci/controller/pcie-mediatek-gen3.c | 76 ++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

-- 
2.45.2


