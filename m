Return-Path: <linux-pci+bounces-22362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B0A447C7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E9188D425
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121821ABC6;
	Tue, 25 Feb 2025 17:13:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41118E054
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503636; cv=none; b=rNr8j9EJ4gDeg5XFuLFl9Hccx4kTsHeRAzRH+V0Q2RCFPMd0mdBtJYn2lWeH9MYASzcylUgyO+PV66k98ln0penlxCVBTKCQ5KS+EsbpMfGG95sKNvkj0JqtGAy7n6t1PCGw3MfeiVdYr30v8t5cXPk2nYa3NdebpHGExuyino4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503636; c=relaxed/simple;
	bh=CxGGwwxJL7sxqR4HPQLaVq4hJqOkmVmqEl49h7i02ok=;
	h=Message-ID:From:Date:Subject:To:Cc; b=Q9TLlsas4ib9WXJ19OOHTdnnNbqO6xaGhQiIjDb6RQ5MiLU6t65+I97VZ9dxJ8JtNoIy3zQ9Udz95aOMrjG24d01hubSOeWnKdAbBLN41XvJwNOBqJB0zHPwMpwWlQPNpflWFDjMVs78T93j7Elj3C/asxdtHRV24FkCpuEqk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 1123210189947;
	Tue, 25 Feb 2025 18:06:42 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id D2D0260C8E39;
	Tue, 25 Feb 2025 18:06:41 +0100 (CET)
X-Mailbox-Line: From c207f03cfe32ae9002d9b453001a1dd63d9ab3fb Mon Sep 17 00:00:00 2001
Message-ID: <cover.1740501868.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 25 Feb 2025 18:06:00 +0100
Subject: [PATCH 0/5] PCI hotplug cleanups
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Here's a collection of cleanups for the PCI hotplug core.
None of them should result in a behavioral change.
Just removal and untangling of ancient, unnecessary code.

Lukas Wunner (5):
  PCI: hotplug: Drop superfluous pci_hotplug_slot_list
  PCI: hotplug: Drop superfluous try_module_get() calls
  PCI: hotplug: Drop superfluous NULL pointer checks in has_*_file()
  PCI: hotplug: Avoid backpointer dereferencing in has_*_file()
  PCI: hotplug: Inline pci_hp_{create,remove}_module_link()

 drivers/pci/hotplug/pci_hotplug_core.c | 142 +++++++------------------
 drivers/pci/slot.c                     |  44 --------
 include/linux/pci.h                    |   5 -
 include/linux/pci_hotplug.h            |   2 -
 4 files changed, 41 insertions(+), 152 deletions(-)

-- 
2.43.0


