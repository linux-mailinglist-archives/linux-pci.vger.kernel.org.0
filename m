Return-Path: <linux-pci+bounces-5410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF9891ED0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007C21F2A36C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F4153501;
	Fri, 29 Mar 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtY+C7Ju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3453152DEF;
	Fri, 29 Mar 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716640; cv=none; b=chqpFO/h/zlC+Pv+TsIy7wx5ttnR72TTat2X9YipLKDH50xgVf/x7/gYV1Rkb4AeK8doCdu627X8Os5J0TGHCo+KuzXBhu5A5AraqFTt169CIfDwRznoUjpLD2Hb7x41hFuuehqjPpdB1CUUHD7dMZTGE8sbFdy+qjjhiQf6C+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716640; c=relaxed/simple;
	bh=c0cSvFtaha8uW8yTxZHbsbZUx/PHmoVdkuzCzjt6a0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzvFk+qDiBhahQtAKAQF/w9MdlMsEjGYzXfQ+cBCJNLOntFLmhtvAXtCfWM1PQw8TNCXkiPdtZY/4ETjxxUuajbYSN3GG5uH5BTtXxSok2s6LqmaH8DjH1ujy01DWu0E/ToZnt37FbmD4063m3UZZ5dXqEX2c4/9gGtIy2W/vaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtY+C7Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F9DC43394;
	Fri, 29 Mar 2024 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716639;
	bh=c0cSvFtaha8uW8yTxZHbsbZUx/PHmoVdkuzCzjt6a0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtY+C7JuSs4WuNMWwciBaaniSjhqyF+KPbBjYU+3prsImwkzh/j8ZUok3SgWOK2t0
	 Alt7ac9FP21riggAEqHLR1liwz36bSG4KuGZSoVnuTfPRiQUCb0ESQ9ijLGI+7yNuY
	 gqLRXkWKSnpWptMXx25b7kmq4lt8dwpkGp5kTT+YgM15CJuM0LsILEaPp3cIGet8OV
	 Ssv8EJLqwMwfsUyR0Ryt0op+8XA0pplSmOFP3mm3MbcJ9AgvHzRQhya1mmlMAQcu3T
	 kyDSxXg5YjL2FVA0EU7M5CUXEaZ9gQS4vIKorfV+pV0imB8g6wqwFmdPkB0CIZWBVr
	 uiL0i6D80dtaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/23] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:49:49 -0400
Message-ID: <20240329125009.3093845-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 821e71a45849c..91aeef1be7e70 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3598,6 +3598,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
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


