Return-Path: <linux-pci+bounces-14208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257E998D67
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823EF1C220AC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF91D0BA3;
	Thu, 10 Oct 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kETxjbB+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD61D07A1;
	Thu, 10 Oct 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577685; cv=none; b=c+wozfnOQtdrNtw3GdcO147WpkwfQozlwMRfqn8Zrek5mvEg08yWWkdKDU/ImEXffy1fDnb6DVw5S7vBBToA+bGR1IefqvaVC9l2j9piXYYRXhJefoQN9FITF5vt6QQb/pui+RFKB1BMcM4zsJrhNnaUV2fyserfMeCCutg8aAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577685; c=relaxed/simple;
	bh=z4IyvVjXjEZw7zQtMyfkFIU6h9M3fysnHZi4qbEv91k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EC8CMrrjW4EWbbEtkJWS9DzQz1Uw5gdEP/fkfvrEUmjj0Qj+6OVcacC+APf1hIqLlPZ3fupDrQSAyTYaCqNF5/J0KMEHoAGZhKzL4cVMdsjtk9fEfRGf7yUVxPlyzuK/59ysPHwk03C/5nz74ZoIgFQOjQFNFPD9mpmG2pa3EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kETxjbB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2413C4AF09;
	Thu, 10 Oct 2024 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577685;
	bh=z4IyvVjXjEZw7zQtMyfkFIU6h9M3fysnHZi4qbEv91k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kETxjbB+qFxSVd8WfNceqjYnXjY3vmv3dRwsMF8CZ+Xr/bEtcrq2t7ERvDWGwfJxw
	 8wTvQ9gBjdi23hY2/44Igbq3o6q9y2P4L1jL3cPrTGSiAwy0LEJbFonUNxO1irntkf
	 JOs46Rds7ENouyfUDdkUJKxXWnG0PoS/FgjWdv3xG8KJxSbphmBkTTRbJWyf3LcAHG
	 PgqtFqtgHmQcqiLLvadGdWhX/8Z4nbW5l4MTL9vWgK3B9hhzRVcQvyPYyyChxqEJTg
	 8KPh9++W/SIlahpxo03BFj1xVTdns8hibyoMGFm3p24tt4j9vSv5B4nN6w9bMypuNb
	 KCorX3nIJvRpA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:19 -0500
Subject: [PATCH 6/7] of: Constify safe_name() kobject arg
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-6-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

The kobject is not modified by safe_name() function, so make it const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/kobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index aeb1709d4e85..cab9b169dc67 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -37,7 +37,7 @@ static ssize_t of_node_property_read(struct file *filp, struct kobject *kobj,
 }
 
 /* always return newly allocated name, caller must free after use */
-static const char *safe_name(struct kobject *kobj, const char *orig_name)
+static const char *safe_name(const struct kobject *kobj, const char *orig_name)
 {
 	const char *name = orig_name;
 	struct kernfs_node *kn;

-- 
2.45.2


