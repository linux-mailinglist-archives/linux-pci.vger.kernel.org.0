Return-Path: <linux-pci+bounces-5408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334B891E3C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF2A1C23B53
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704861AA305;
	Fri, 29 Mar 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DovIWKRg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474871AA2FE;
	Fri, 29 Mar 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716511; cv=none; b=TO0S7ofRIpQcyz+T2a+MCeBVD5JzSrJKpd28SLcP/2iYOc9K7i0TgHuTJukywIHclV15PzRNuqYs0Aw2zVdoSXAs2YRFdo433vx6wewTE4bPAAzI2WudmNicHSEfHQ5eZde0qrzpiWxQ2n+yjTZOWq+6LaF9gZj3srYOJAWzl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716511; c=relaxed/simple;
	bh=wrgoYIwXfWwL0pSAyWQzL3um30X/2cmpWHSwMZMCNUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiDpWB/yIK60velM+kJSMfoD0JNl69Vqa1S6gfMF3GjGMDL/fryOMe9yjyRmgGOALawVJolsIAJDEEoqAvLjQge4VxHXBya5xa625W+pZi8EUae+/yGZREkDZqN1XUNKoVtJS+OQ7HC8lF2EYZToh7aBbN/DI6exVVHppdxobPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DovIWKRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D56C433A6;
	Fri, 29 Mar 2024 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716511;
	bh=wrgoYIwXfWwL0pSAyWQzL3um30X/2cmpWHSwMZMCNUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DovIWKRgbS+Ekf4fC3/30TtK0bd6euRKezFuGQnmhnlL3eliHXMW7qVUDXV2NJZFG
	 E/emNqjQdatJioKMsNjdihKtLMYFMSiHyip0oWUNK7UsxyMHtpwFMJ7vC//a4IKncD
	 zy9DOMfkco+DckfWY3L4w1E7WcMlvYh/dPmiPQHFfI8W+mZOKaNZwAMdmDytJKMb1G
	 iE4ex6FBLKRrsNMwAgrl/dZw8XkEUguAgLrvgXtLaGRxBGOkGMUorJdGrA/+T4Eixs
	 iaMpiQ26w9tTsoQIHts8KO3zQa+3A4X/clItALyZtsqpMapPwyY4r3QMAG5ksAv/wD
	 NtVWsvnEWIJOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 23/34] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:47:24 -0400
Message-ID: <20240329124750.3092394-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Edmund Raile <edmund.raile@proton.me>

[ Upstream commit 29a43dc130ce65d365a8ea9e1cc4bc51005a353e ]

Apparently the LSI / Agere FW643 can't recover after a Secondary Bus Reset
and requires a power-off or suspend/resume and rescan.

VFIO resets a device before assigning it to a VM, and the FW643 doesn't
support any other reset methods, so this problem prevented assignment of
FW643 to VMs.

Prevent use of Secondary Bus Reset for this device.

With this change, the FW643 can be assigned to VMs with VFIO.  Note that it
will not be reset, resulting in leaking state between VMs and host.

Link: https://lore.kernel.org/r/20240227131401.17913-1-edmund.raile@proton.me
Signed-off-by: Edmund Raile <edmund.raile@proton.me>
[bhelgaas: commit log, comment]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fcdc17bbcc8ee..1a4ae9aeebfea 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3638,6 +3638,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
 
+/*
+ * Apparently the LSI / Agere FW643 can't recover after a Secondary Bus
+ * Reset and requires a power-off or suspend/resume and rescan.  Prevent
+ * use of that reset.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
+
 /*
  * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
  * automatically disables LTSSM when Secondary Bus Reset is received and
-- 
2.43.0


