Return-Path: <linux-pci+bounces-43713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928ACDDA30
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78757303AE9A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010A93164AD;
	Thu, 25 Dec 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIts07Al"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488262E8B71
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657215; cv=none; b=hZqvUeP8Jh4DqRA+sg3Sdkk0NpGqXK7H8tAwuWtoO+kXD+YlpGkjOYRPaBzccy7BXPTEiUi9LtLqly2VvoozjYiCKLePCjqMuLk4RNyl2rTJ8fNDrGKIKZrJHngZM4VH1bFuAWCq+xrxR+LWvIR0SjXsd3YdWgSHgEl+vx29dck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657215; c=relaxed/simple;
	bh=ZzOdUNMhuT8F0aRUiUAWGdfQcxqFelYu4TJpHAJtjjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVUqtWYqTS2zMW2Z2y9K0+eGQi0FYC5AL2S9N0HUCpcTlbDjTULhCmXOQbmp9w383pO7TrtUpLqUumQX/afELfyeVRFzQsMwR5LnbbvdBpnmJBxrsK3LpZ5JzwwQSYwsf41HuuiEKOTc8sDjOCNEWh3I3Wvy2dQb+Vqs9/IpQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIts07Al; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso3677371a12.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 02:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657213; x=1767262013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKv9AmSkB7bwFTo+4QrtWfuiVpsMTBZ+yI4lWsjh46o=;
        b=eIts07AlEfZNu8+3fl4kP+MKZp1nLI8JoSCID1tYpTlIv20kmPGCmelM5CvXrAABe3
         smnLFtaITPoKxuzRpSuURFPl91Zsrh/nOcqFujSXRJQj8DfnP+K0uLoYOW4G4MM8KaFj
         KF5kFTVVK3V5oGOXnDLE437jw7O9VG7gmJRM8IRYoN7+/SMiwwSQH5Y/zqUakVEp23ed
         G4Xy9DweuqYu4F0PQGGiEbcZpF7azQXINpnqdDx84dPBYz/XfFf/4n6oFeMMK2C9/F0b
         RCfC1kW1ueByrCaCktKdUNXiwwfFK1FPVhkWvemXm5O8qoNU0Plu5m8hHCHXoO1r8l42
         tm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657213; x=1767262013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKv9AmSkB7bwFTo+4QrtWfuiVpsMTBZ+yI4lWsjh46o=;
        b=aFpx93+g8rdFvaNvNiGlOlUYZxxFw1+816LePxAMU9E/Acp/vCLMpV5GKoV+jhLL6G
         GaVNT97h84LHeiJd2OsOM9HT457VUHRhkGPa6uYTA+4cZmUQDcZKQpsTAW3Skd8S2ojA
         UOR09tjIEZdF65+apd8uv/nOKadYO92uNNr2Mf8y4q+f9id31i3dVXRPgkiyVE2lhG2f
         qKifSX+txNJo2LIBPhA14vy8uwCijuxHT/mX3MoOXa+479LVV5k90iVb9gqwygjkRcKC
         aw4LjJvvm9hyvKz39OO51EpUuYa5qtMvX1/c6SaZ0KfEf4Eys3fvfKCAwi+JuKXSaWsf
         HXHA==
X-Gm-Message-State: AOJu0Yz42RQXeD8tXkyWeGdwbWorMeR7gJ02hGQwRNF8beupcGzwabik
	ZFURLOdwDaFirojBiWkV1KcjbbcFXpaLQ02tVI69RvP/WCwkDpTs5DVi
X-Gm-Gg: AY/fxX6MqgczDJBd9rJidoOW9rjFRmUfNxhz1dT5Xk40w6gX9bmxU9ogmmgjBx03FS5
	8/8oP8EifvODULyhGudlm5rnkz06NC6GK2hHDdg9y3MEve2AyNRWCJXkuDB8P738H3RkQi1l40i
	HPG0cydYZ6DtkWxBtpHsucnhnGxkswtL0fH453JvomySvwpcrUJh2/fqDa6SHPwwvGkZD1O1B7Q
	dvKFe5mKk83PpeUIIWZVKt1QUB0KPo8FpJZeLSJYl+GA+g0ao6Ib022nD+q3Nl1NGTd+AgcmXKF
	gSVw1AbtwLao1bA0ZdELbMeuYwoKmrFGlFS98c2Qrv/MsH+NZpmoPpT/HqtoE8Llj2GSaueTO4T
	TdKamQORUI6fBDxZMV2hMmTvZYieg2mH01atk33IH7mJvZxIfzyytgRJNlg2J0oAthnDKFOyegu
	N0BQKDx+4cRg==
X-Google-Smtp-Source: AGHT+IEBv+zByQkOPrhwHx24FbblKRdt9e59rEckClTuU4HVXYmpU4e2ytFHg/K5FaWxv0cei7TfGw==
X-Received: by 2002:a05:7022:989:b0:11b:9386:825a with SMTP id a92af1059eb24-1217230390fmr21043695c88.47.1766657213391;
        Thu, 25 Dec 2025 02:06:53 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724ddc30sm77810208c88.6.2025.12.25.02.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:06:53 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 1/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
Date: Thu, 25 Dec 2025 18:05:28 +0800
Message-ID: <20251225100530.1301625-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225100530.1301625-1-inochiama@gmail.com>
References: <20251225100530.1301625-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2042 root port breaks as it advertises L0s and L1
capabilities without supporting it.

Override the L0s and L1 Support advertised in Link Capabilities by the
SG2042 Root Ports ([1f1c:2042]), so we don't try to enable those states.

Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pci/quirks.c    | 1 +
 include/linux/pci_ids.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..d775ff567d1b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2526,6 +2526,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOPHGO, 0x2042, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a9a089566b7c..78638cbf2780 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,8 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_SOPHGO		0x1f1c
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.52.0


