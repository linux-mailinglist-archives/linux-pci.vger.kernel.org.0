Return-Path: <linux-pci+bounces-15435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADFA9B29DE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ABA28681C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40E15EFA1;
	Mon, 28 Oct 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUD5aU41"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683141E517
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102744; cv=none; b=lMUL+3SKqlhr0uGZVjc1cWe6QLy0/JBge0xrvGY9tFcnTLIvTlJBc9e/2SzquSNBCss0Dh09VsdkjY8pM0Pz7Aa3FrtDkR0EZzh2o5EWhFhfzCghDYAEMYHp8wOfoX1kmtJfiv3Sl4HBoZhf3M6iG1+JtqqGJ16monBPchtiJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102744; c=relaxed/simple;
	bh=RgfLHsW4aA0oWTTBVUyt9LmOHFo5wg/tsPOTrDLAxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCp7iq5AFKVOlbY5Xe8sTNrz2j2Nf9Y8J7hghppi6yEeQKcBJioqJJZJ+JGE5QJPSg7ZoM6nPgv2cuBjmbllDEage+k+IAPmOcVOGqZCNZq9T6sunnpcx1zESrTtrzBcSyd1pCNYXQV09j0IlL0/imY5S703eLx/mNH3fQ+wcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUD5aU41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FF2C4CEC3;
	Mon, 28 Oct 2024 08:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730102744;
	bh=RgfLHsW4aA0oWTTBVUyt9LmOHFo5wg/tsPOTrDLAxoc=;
	h=From:To:Cc:Subject:Date:From;
	b=LUD5aU419z/lHyStFpxDzd1xiYXrKdCGbbkrouGFv0swUTyzIgcwrRwBrvCgtoKoq
	 7QOD+VxNGS894tyMnZvtE+6LIC8ih5TOtZfAVInxLzRAFlyfGQe/JNWkXC7S8/I5P6
	 q8nZZ8r7kmXVRBz+Sx4ka4cFi/CvErb5+2z74gQGNnjLvrjPkrHwCSNhg6nJIIkmvb
	 mcKGokeqcJigsiNud/GIRfw/39WbKSCcQErNL12a9bS28K3Lw6bsZega92XGIm+Eg7
	 8DUm5i9pr7aDGomQuCtPyIohmf6dwy953H6cB9BtTz14FbLQUHXp8mfWkvBs+8VV1W
	 HFqLOEuZQvh9w==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>
Subject: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Date: Mon, 28 Oct 2024 10:05:33 +0200
Message-ID: <65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The Virtual Product Data (VPD) attribute is not readable by regular
user without root permissions. Such restriction is not really needed,
as data presented in that VPD is not sensitive at all.

This change aligns the permissions of the VPD attribute to be accessible
for read by all users, while write being restricted to root only.

Cc: stable@vger.kernel.org
Fixes: d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
I added stable@ as it was discovered during our hardware ennoblement
and it is important to be picked by distributions too.
---
 drivers/pci/vpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e4300f5f304f..2537685cac90 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -317,7 +317,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
 
 	return ret;
 }
-static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
+static BIN_ATTR_RW(vpd, 0);
 
 static struct bin_attribute *vpd_attrs[] = {
 	&bin_attr_vpd,
-- 
2.46.2


