Return-Path: <linux-pci+bounces-7050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E637E8BB3E3
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231641C20B63
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E9158849;
	Fri,  3 May 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x3OXucSj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="egJquNjH"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251F1586C2;
	Fri,  3 May 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764209; cv=none; b=ZoXnrQq0pDyqA093M9mp9DXT2/1a/7aXw78DU4qxvCBiwMljoJX10u4+TKpEAjKpYIx5auTN8CYWyM34wCbS5qJ3pSDOqj+3zy3V/keOB84MMu8nojSQazXVLpuESTw7EMjtx7xdUfRYX4o53oUuk71a2WEeHKVugNq6+dJrXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764209; c=relaxed/simple;
	bh=fdxlFgTRTET902YIdVAvYcHjayn5OtsB/DYOOVfVLXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXSis/sbr9F/wS6D/0NNXJqE/AUtZca1wfVlbgqx0cVKJrA2slZdMrl+DY6JL2R9MnQxBuRWh6xhvoFvNUCPUvS5wJoMCT778LFRxwz0l2FK2NR+8DHwKXArLxEtL7yuuqHfwYnYHy79MM1MtrOzOZ+RC9AqhX2+TiM0yxQNaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x3OXucSj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=egJquNjH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vorNXOmdM0ttzVHsmrotgcJ5HNUuVfx/TFGSwS7Dqc=;
	b=x3OXucSjFFabheDOKU6WBdJiz+USprJaSXBm9/8KBAsJOyZssUPzW/J1R2fjdN8mq0NKMC
	npiJmM9F/9Buqmr4+Bir32YMkNV2jT3KEZj2lN1S7Obxyfb2O7yb2ys1eVzpeSCXAyuw9P
	90TVpPMKIcOGDYGHQTFBnnuO2g11U1ODP4wqBQHevPLLCtLXeamG9omuFbAYhzS+9Y1/as
	PrAcek9oR1sfv5LrWG4jUhUCMdZ3l9Ef6lWB1kmhAjz5YZvTIDlwTywiO0t68ZdhuWKCtl
	miHrweDKtyjGtE9fyIt/4IBac09z+X4hFKaWuHYgGysg7cntfoXbBoBkZoUzqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vorNXOmdM0ttzVHsmrotgcJ5HNUuVfx/TFGSwS7Dqc=;
	b=egJquNjH+SeW0ams1HGH9vOqn6vFQDAJ1fvDYlw4QPJurOUxtMy7nwKjSBTY0C2livlA1E
	9tAQ0K+qaCJ+4nDQ==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 4/4] PCI: hotplug: remove TODO notes for sgi_hotplug
Date: Fri,  3 May 2024 21:23:22 +0200
Message-Id: <26784ee39fbb3fbd0fe96508158d74419018e6ad.1714762038.git.namcao@linutronix.de>
In-Reply-To: <cover.1714762038.git.namcao@linutronix.de>
References: <cover.1714762038.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c7532b601e77 ("PCI/hotplug: remove the sgi_hotplug driver")
deleted the driver.

Remove the remaining TODO notes as well.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pci/hotplug/TODO | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index f0a1746c3c88..9d428b0ea524 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -49,14 +49,6 @@ ibmphp:
 
 * Returned code from pci_hp_add_bridge() is not checked.
 
-sgi_hotplug:
-
-* Several functions access the pci_slot member in struct hotplug_slot even
-  though pci_hotplug.h declares it private.  See sn_hp_destroy() for an
-  example.  Either the pci_slot member should no longer be declared private
-  or sgi_hotplug should store a pointer to it in struct slot.  Probably the
-  former.
-
 shpchp:
 
 * There is only a single implementation of struct hpc_ops.  Can the struct be
-- 
2.39.2


