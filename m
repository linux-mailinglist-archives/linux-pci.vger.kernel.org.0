Return-Path: <linux-pci+bounces-14209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B3998D6A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EED1C22E6D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69741E0B6C;
	Thu, 10 Oct 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiU38voE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF431E0494;
	Thu, 10 Oct 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577686; cv=none; b=NsxNSXxyUGdVQvnFAzeYV9p958vsp187JeUqfyzJ/zeoJLLvulIo8CCTAxJb651KD+XaiRmtd7NVl1+Qu8iK7WMo61btOL4GfA3Fhx1F0QSFW7wlymNNh+BbBciqWcBYRlMcvlIiTLTIdFhtNLyYbUiOePnvyh8vjX9orwbbcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577686; c=relaxed/simple;
	bh=ZBJJ2vLKYx/lE8Ife+RCMj8q75kHD20UVqcHkUSsK/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eX8NcJFEdyvPqvhNsSzq9lp7rMKFWq/bsasYyf1X6Nz7H2sHjd/k5BW5z06zB2HeqhFoBX3Z1Z1AVd7/d+Hymx/qnHwRfk5HvXtheOuBRUekvOjzxl9UJVMyjfgN+zyFpakGnZC+xF6zNpGtvAJOZezN5mG3kAiq39xW/j5IFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiU38voE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE9C4AF0C;
	Thu, 10 Oct 2024 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577686;
	bh=ZBJJ2vLKYx/lE8Ife+RCMj8q75kHD20UVqcHkUSsK/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fiU38voEEDKRCfDFoby3r+dlkbq1FLlFsWNGW9jV59FUDgTShf1TU+BQNwPV2fRZj
	 L3blQ5tlo+fQYPvxBIT4DRFx9gbSnlxADmLDc2CvSZcznmm4gapXteBjM148RK5ZWD
	 VqpDezD3vd8/g58AY6IZvdjFL22OfrxD5N+r+EEye754uOkaojumabO/XuK4l3+Y8g
	 cpaKJjlBY5oG6JVVew6tdRg7kSQL1z+s3FQXuwHBKswaVhZTkg6hrgOwe5FFSNxdTr
	 VfD9heffVLgluVzQMDWOkNkxfBus5v5zfq5YN4fEiwdADx4lJQJcuP03Hc8GA9fjcY
	 +p9SDcHrEwFFA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:20 -0500
Subject: [PATCH 7/7] of/address: Constify of_busses[] array and pointers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-7-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

The of_busses array is fixed, so it and all struct of_bus pointers can
be const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/address.c       | 12 ++++++------
 include/linux/of_address.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index aa1a4e381461..824bb449e007 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -340,7 +340,7 @@ static int of_bus_default_flags_match(struct device_node *np)
  * Array of bus specific translators
  */
 
-static struct of_bus of_busses[] = {
+static const struct of_bus of_busses[] = {
 #ifdef CONFIG_PCI
 	/* PCI */
 	{
@@ -388,7 +388,7 @@ static struct of_bus of_busses[] = {
 	},
 };
 
-static struct of_bus *of_match_bus(struct device_node *np)
+static const struct of_bus *of_match_bus(struct device_node *np)
 {
 	int i;
 
@@ -419,8 +419,8 @@ static int of_empty_ranges_quirk(const struct device_node *np)
 	return false;
 }
 
-static int of_translate_one(struct device_node *parent, struct of_bus *bus,
-			    struct of_bus *pbus, __be32 *addr,
+static int of_translate_one(const struct device_node *parent, const struct of_bus *bus,
+			    const struct of_bus *pbus, __be32 *addr,
 			    int na, int ns, int pna, const char *rprop)
 {
 	const __be32 *ranges;
@@ -505,7 +505,7 @@ static u64 __of_translate_address(struct device_node *node,
 {
 	struct device_node *dev __free(device_node) = of_node_get(node);
 	struct device_node *parent __free(device_node) = get_parent(dev);
-	struct of_bus *bus, *pbus;
+	const struct of_bus *bus, *pbus;
 	__be32 addr[OF_MAX_ADDR_CELLS];
 	int na, ns, pna, pns;
 
@@ -690,7 +690,7 @@ const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
 	const __be32 *prop;
 	unsigned int psize;
 	struct device_node *parent __free(device_node) = of_get_parent(dev);
-	struct of_bus *bus;
+	const struct of_bus *bus;
 	int onesize, i, na, ns;
 
 	if (parent == NULL)
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index bd46dbcc6e88..9e034363788a 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -10,7 +10,7 @@ struct of_bus;
 
 struct of_pci_range_parser {
 	struct device_node *node;
-	struct of_bus *bus;
+	const struct of_bus *bus;
 	const __be32 *range;
 	const __be32 *end;
 	int na;

-- 
2.45.2


