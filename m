Return-Path: <linux-pci+bounces-3999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D279C867143
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D800286179
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18825763;
	Mon, 26 Feb 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IkhqcI4k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5525634;
	Mon, 26 Feb 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943143; cv=none; b=DGxz0T7m0SO2XZQhRQMZEF3sXE/kfQKnLUeOljAaFoPManUVDm3Guo/PIFlRp70sXvRJrwfgXYMMIThmFNidb8llKl52dUZ6JU1dBaDW/Qom9vRmTqWxu9iesglZj96GmKgRyGX09Z5YC+LC1cBbMO4qvwhaAfefuk+BmaDMNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943143; c=relaxed/simple;
	bh=FB9E9JyNIVEQ3zPi5pRp1wKuBvGQBRAGlYj3fhsP/j0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l6gwQBpi5QLPF17ZbU7KmZDTI7HdkWzS8Jsxop1Ll/cYSsQy1OuvDC012L6AIEXAkGd6UlSiWCEkwZI9x/5Sn0X8Y09JMP5GW5g/49lavr+Z1w+ihJtuaeVLU37GXYeM8fDUwOtWPsxcSu4nU2RQWAnoHPbtk2T4glLBZL0Uo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IkhqcI4k; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vdsavk55ifat5gl55bl7736lum.protonmail; t=1708943133; x=1709202333;
	bh=hvFaazzaDjEhKYnLhgusyXuDE9SwR0SnEtKd0g5cI2w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IkhqcI4kDYcn9GN5/V9oh3ebZ9f4hJ/d2RaIUInChPoCxCblvoyZ7Zkxy0v/yi7MU
	 6fJg/T+O/CREAppqWvdCCYLL+NMXX7ilsxJNXqTWgN1b5XDsV4w25qktJRgI/VkMUH
	 cwXd8JNgfpt7e73Gju7Cp10TGceZHiEGiEn28ZchWIGljboTZcZjy7fWlEj6DdKXw4
	 X2y7UyGg9EqLdhcRWKxZ65TM5A56sH9cjkFYk1Pja6HbRExQobDDaKzzEzAU7CWj7o
	 1WGijrHxmf4awf7TkbT/lq9kl092Vi4ky+EtPBK5z9k/nsTviF8WiTTX0aROJ1XSzS
	 CZqGt3mw8VEAA==
Date: Mon, 26 Feb 2024 10:25:12 +0000
To: bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Edmund Raile <edmund.raile@proton.me>
Cc: Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240226102354.86757-1-edmund.raile@proton.me>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Using LSI / Agere FW643 with vfio-pci will issue an FLreset, causing
a broken link only recoverable by removing power (power-off /
suspend + rescan). Prevent this bus reset.
With this change, the device can be assigned to VMs with VFIO.

Signed-off-by: Edmund Raile <edmund.raile@proton.me>
---
Usefulness:
The LSI FW643 PCIe->FireWire 800 interface may be EOL but it is
the only one that does not use a PCIe->PCI bridge.
It was used in the following Apple machines:
MacBookPro10,1
MacBookPro9,2
MacBookPro6,2
MacBookPro5,1
Macmini6,1
Macmini3,1
iMac12,2
iMac9,1
iMac8,1
It is reliable and enables FireWire audio interfaces to be used
on modern machines.
Virtualization allows for flexible access to professional audio
software.

Implementation:
PCI_VENDOR_ID_ATT was reused as they are identical and I am
uncertain it is correct to add another ID for LSI to pci_ids.h.
 drivers/pci/quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d797df6e5f3e..a6747e1b86da 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3765,6 +3765,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x00=
3e, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset)=
;
=20
+/*
+ * Using LSI / Agere FW643 with vfio-pci will issue an FLreset, causing
+ * a broken link only recoverable by removing power (power-off /
+ * suspend + rescan). Prevent this bus reset.
+ * With this change, the device can be assigned to VMs with VFIO.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
+
 /*
  * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIES=
S
  * automatically disables LTSSM when Secondary Bus Reset is received and
--=20
2.43.0



