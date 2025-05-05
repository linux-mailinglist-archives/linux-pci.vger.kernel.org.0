Return-Path: <linux-pci+bounces-27227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40EAAAB36
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F0A1BA4FF2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E508F3A91DE;
	Mon,  5 May 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/NjKlhe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926D286419;
	Mon,  5 May 2025 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486185; cv=none; b=jbZ6UVbM9mm+8gNoe33JvisZL6VrBfFuxjHm7DHOHkF5bDt8e36FISnH7bDU/U0PcFyT9wQtIN0utkDHKF5pJ+HsSzxNHed7hy7a7us41Oncpr+cN6Jhdp77D6rv92jfLkhL2ZCXCMiBygWDSziNHbROlUCvTPwX3xUDM9ygUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486185; c=relaxed/simple;
	bh=7xVHlKYcGGt9MwEn59ezzkiBU8yGeyaBGkRbkbBHMZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVy8xF5QvTiW1UEkPytGvniflSSjx8QPHoX0xuyAGPty1pOazsg0XPglG2R65zP4jRfG3LYy7IyqjIZSSrZGJaFXEQgpje5CTT7dTjx79WAh6rLuhG7L19yLuubRsRZWhufG15rMg0gFVpuiu6xUO2u+nTfrHC1Lrb1FrgLd1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/NjKlhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB22C4CEEF;
	Mon,  5 May 2025 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486185;
	bh=7xVHlKYcGGt9MwEn59ezzkiBU8yGeyaBGkRbkbBHMZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/NjKlheVYLgZSRqZA4nA8k/lgOIqc3NohgaceQBWkRFRu2opkMKKSv78HHQQa1bi
	 T+ip+VTvLYVCHSF01/QPmYgdLM6jdnRYoswrGvlaE2UFqID5N1XWT9LGri0OTAow75
	 hnYH2FECx1wSU9yBzWLZmVbJl32jMQgDXlK4JFPjrqqHraOtv0nvo+di4ft3wayIdY
	 6SvKPVQ/9z9dnOf5w8O3E3cuviNY7dnBY/UvCxn5AFlOoxSTFde3T8ibmAs+g/5GvG
	 KEf0U7haLOnRjEkLTZtX/DE6vKoUf4avUV944rKPkvDTPvqrwxaSqa9NyZ4vsZfYG0
	 OAY9hdCE20pgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xiaochun Lee <lixc17@lenovo.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 192/294] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon,  5 May 2025 18:54:52 -0400
Message-Id: <20250505225634.2688578-192-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit ff61f380de5652e723168341480cc7adf1dd6213 ]

Commit 903534fa7d30 ("PCI: Fix resource double counting on remove &
rescan") fixed double counting of mem resources because of old_size being
applied too early.

Fix a similar counting bug on the io resource side.

Link: https://lore.kernel.org/r/20241216175632.4175-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xiaochun Lee <lixc17@lenovo.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fba402f4f6330..3f40be417856e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -802,11 +802,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
 	size = size + size1;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
-- 
2.39.5


