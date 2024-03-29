Return-Path: <linux-pci+bounces-5403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83CB891C6E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FBD28A097
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D818767A;
	Fri, 29 Mar 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwwTRNPu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01D187668;
	Fri, 29 Mar 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716132; cv=none; b=h5yVXN/vAymdE5EVwqCT34pVCPkI+uoyB6GGdPsz4Hl35tAOHw5m/8QnXrjcq0lJmDMGwNVsG4gjv5L5M0NOdLg7Hw4AYAePX+w4SazTEE4jMvstJPxtkoCxancd3MRlolp4/o3sSn/l+szgmrphCkNFLnokFL6ad2Q0raFDLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716132; c=relaxed/simple;
	bh=L3hRlVqiQCKM/HmF6+MB8eWM8qumHarZlp9R63F0ZzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqJX03eyJmTnus2omgAhIem1NjKItYf4xrzaTEXQni65+XvHfRXPhGo7cQfSVEjz866MvtNxid/isn0oH1bguY2X7aMrcjB4ALKujAQD0LVfcn9ca+wMgfqwCVhLg2AVjQGVfGQHeNPpmN8xSdBqGKZz507COHlTfuQ9v4od7OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwwTRNPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF50BC433F1;
	Fri, 29 Mar 2024 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716132;
	bh=L3hRlVqiQCKM/HmF6+MB8eWM8qumHarZlp9R63F0ZzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwwTRNPuZashv/fa/lM7Ob7UsnzHF03OFb+fIt0+RsH8DATbWHUkPQYT6qT8gh8oK
	 TTTRv8Pzsnd5onkfrPgsL2gu0xMaIGS5oP+r2+c7Lfn4n3Phcm0AIXNjaRtMfQsOD4
	 wreodviznbfIVZPNnP2YgNLlLknSJEo8XIK+e8ngRR72LPfNQpSZNGoS6yxa7ft9b0
	 vgy9z9oKQKlMAfcBdNjbwJ0K1nczfdTAPttLGGe8CFbWLGiGoEv53LIRomR9HnRbOV
	 W1Sw1ym1fC5GPd95n7PBtDiNlLBR9AB0d5glePOSalubrmPMPWUJrtsjiDxM2aPOAp
	 Nr6BnKBRg3agg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 71/98] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:37:42 -0400
Message-ID: <20240329123919.3087149-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index d797df6e5f3e9..6ac58cd098b2b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3765,6 +3765,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
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


