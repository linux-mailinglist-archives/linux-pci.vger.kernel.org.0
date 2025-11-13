Return-Path: <linux-pci+bounces-41177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB46C59C65
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6906D34E914
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99531771E;
	Thu, 13 Nov 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgY7hI1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC9320A08;
	Thu, 13 Nov 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062566; cv=none; b=vAG9fyqboKYjjkZEpamBN2eGoj19ULPFFotAVV5q3eoq0TaJhBU4sS+t0dHs7N+r2yWZb+uRCcKSi9+ZX255kKLzrXS2+wNB3bu/59ig8kFVnsaknQ3gVX9SD5itEfRtCnEV7z2q9aiFpEZqrBZvWcFl/4TJxhDBGRFEvWp5aZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062566; c=relaxed/simple;
	bh=PBFH+ADRleOCfP4HnfjAr2xVRLcV8QfGms5yV42h6ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwxOACJFB87Z3XSVtkpY3bpHMd8bAb+s2yWZcXEnBcDnw7Txa3ojAsDpGW7HXt29LxyoC0w7IjDDHv2OB6OLFhTaTPmqidfsUHuxk9DHz9R37LICIEgiqbUDSgHFuN9Stl38CuHdR4GnMVzqaSazAYz66Q4thdpn+GlfmBFEMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgY7hI1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3308EC4CEF8;
	Thu, 13 Nov 2025 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062565;
	bh=PBFH+ADRleOCfP4HnfjAr2xVRLcV8QfGms5yV42h6ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgY7hI1f/4Zgm5vpRR3zSZmagPjmCKT0wjxKm1d/6VLZaLHafOQqtBO8QgkCzAqpw
	 7gyJiC2oOwTgCIYxq/8FKKUfkRcKt9zYcXq5qMK6QVWYnVvKIulaHK2uk98D4clksS
	 NyJ6BOD2c2IWxeEXEwYlxDI4YFm3OOv8KOBkX9YjFOtTyI98OEWVVDhA+TmzBMD1Qv
	 CyhBgcI4JPrI87he+YClCFGbQHNOoH6OhkPHSxC+EjQEz6XgvDX0K/d1+pgkKnjquJ
	 Md1QXjk+WrwiKGUR2bnqoRN9CWLw+5y5p2sUGlJ3TyruWjGoa2o9gjaQ8p2vptWAcD
	 KudT18xC6zhNQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject:
 [PATCH v2 3/3] PCI/sysfs: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Date: Thu, 13 Nov 2025 20:35:27 +0100
Message-ID: <3932581.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5959587.DvuYhMxLoT@rafael.j.wysocki>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
to make the code look more straightforward.

No intentional funtional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Adjust to the changes in patch [1/3].

---
 drivers/pci/pci-sysfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct
 		return count;
 	}
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	if (sysfs_streq(buf, "default")) {




