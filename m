Return-Path: <linux-pci+bounces-6739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB368B46D0
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B633728246D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8E15A5;
	Sat, 27 Apr 2024 15:09:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F010E6;
	Sat, 27 Apr 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714230581; cv=none; b=COZ+CFX1AySJpYsEkmsioBq/+6kgvOD+gYtVrHQtNGbrUYkXrW5EZN7bPqA4KZ5XPo4G+3ctfDfsry7D7odf56hz0ZOwDcZr6stmo6f+Mj+kBgiTBLjuDpib/OSgbqtiveExsCnbWHtAai/eekwNbVGQ8oOYg5+I/woKRyFUY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714230581; c=relaxed/simple;
	bh=todmIpEhyteA5k+IsTMgSMDRr410TnQF+2voYfCWoaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmcomeRdpNCERIAUV9++09hkTRnWLP7tV+I4Ik8HxYm3sYFoflNcLrDbz/HSuLEmc1/aXFVQUYXzOR0WMfY32gWfrrNAGGm80EhNBSTWYk++CsPfAArRxv9o4UPGapaGD+fHoYaSlOQkM8/pQhuo9S3hn48K4FOSthy1yPwTPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4B76B280142F3;
	Sat, 27 Apr 2024 17:09:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4035018B432; Sat, 27 Apr 2024 17:09:34 +0200 (CEST)
Date: Sat, 27 Apr 2024 17:09:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <Zi0VLrvUWH6P1_or@wunner.de>
References: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>

On Thu, Apr 25, 2024 at 05:16:24PM -0400, Esther Shimanovich wrote:
> I did find one example of a docking station that uses the DSL6540
> chip, which has PCI IDs defined in include/linux/pci_ids.h:
> #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
> #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
> It seems like it has an NHI, despite being in an external, removable
> docking station.

Could you provide full output of dmesg and lspci -vvv of a machine
with this docking station attached?

Perhaps open a bug at bugzilla.kernel.org and attach it there?

Could you then try the below patch and see if it prevents the
Thunderbolt driver from binding to the hot-plugged device?

Thanks!

-- >8 --
From a10a294a650232c16447a43c2b591f34d3cb399f Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 27 Apr 2024 16:24:18 +0200
Subject: [PATCH] thunderbolt: Do not bind to NHI exposed by a hot-plugged
 device

An NHI should only be exposed by Thunderbolt host controllers, not by
hot-plugged devices.

Avoid binding to an NHI erroneously or maliciously exposed by a device
by looking at the upstream port of its switch:

On a host controller, the upstream port is of type TB_TYPE_NHI, whereas
on hot-plugged devices it is of type TB_TYPE_PORT.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/tb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e00e62de53f3..d95ff9ed4d96 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2786,6 +2786,13 @@ static int tb_start(struct tb *tb, bool reset)
 	if (IS_ERR(tb->root_switch))
 		return PTR_ERR(tb->root_switch);
 
+	/* NHI erroneously exposed by a hot-plugged device? */
+	if (!tb_port_is_nhi(tb_upstream_port(tb->root_switch))) {
+		tb_err(tb, "not a host controller\n");
+		tb_switch_put(tb->root_switch);
+		return -ENODEV;
+	}
+
 	/*
 	 * ICM firmware upgrade needs running firmware and in native
 	 * mode that is not available so disable firmware upgrade of the
-- 
2.43.0


