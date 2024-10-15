Return-Path: <linux-pci+bounces-14567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4399F619
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9B1C21804
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720311F5821;
	Tue, 15 Oct 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMUi8Dti"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E51DD891
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018309; cv=none; b=PXPdMs76V9SMvm9wwKBHaawxiVWv8RF99dPhhZhQUW1LlxqqV6kp8q21ykz0WpXCld/iE3Yj+F5nfJeP5x0Mnz4vQvAP6L4sxi6u9n5ejsIyIF/8a8Fg5d772RNtByGrCcTYeZSAuPxXO975BZ7faz2XCxpY9h6u2UJ6lYN0AeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018309; c=relaxed/simple;
	bh=1E3Wc2PJtRAaUOY99NG1G0bwDF3Rsad6VUjYO+8q0lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbcBfH7vjsAOLePWF1UwsgSUx9PWhbq9otmLyUYNUQ0Yky/ANtxsxHxaDxXSgMTOdn+X5klX47gly/8fMbGJm3fqq6K/F/l5uFfAt5ICnVmCZ0+7YMLmP+t/d1Ie02nCBeYjQEGL3uYfdEYh9TGBM0fszMX0HSM+3N+Dp8/DfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMUi8Dti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU/PZdKXdnBqqSwxJC6QaxHUkhQ/Rh93i2Z0bgmQYHg=;
	b=XMUi8Dtiwd/zb6YBekauGXPnsQhDU1hGcJ0Pl9JIzNVV9FqEAY5ijVdhFX8yGLIAq0cEaH
	ORoZx9vuaUISGTbVHQjvTJdqVcdJekCTKNCkFsYzmQkN7xAlJY6Gte8OMHH4lxBC0gkqLu
	05wsZ4bFo4f6RZNibT1oR2JiBc8fGnY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-HPPgxjvdOgqnhbAFMiTGyQ-1; Tue, 15 Oct 2024 14:51:45 -0400
X-MC-Unique: HPPgxjvdOgqnhbAFMiTGyQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99e69deec5so145185966b.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 11:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018304; x=1729623104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU/PZdKXdnBqqSwxJC6QaxHUkhQ/Rh93i2Z0bgmQYHg=;
        b=WpcVRxctO0jffegMAGrGALZKfZ4uTzH98gokQEuruT8CN1f3sba2p2L9M23ZrSBLO3
         sPU1ayFSdVXx6VfXiBa8C6X7OhW9159R3Sl5yRxm4olzRqdeTxKRlDECE/G5zJghSyzn
         2BrfQhxnPyH7aaS7mPv8QpMVv5PvdjWtIM5gBt0PnsNJ9HMoHk5rGbK5Cv8BXNB1oSJN
         L3kVPRyBzEyQ+TzJH9w9l/IScxP3hNl1UXm3Nkak8pmL5nHt4yUfVVZ1oxvv0LjPbfa+
         u8J+sXcGVnoB4bF5Xf3Oev1rCf4tySdaQtQhPJ2Bc7EDkFnkRaWisLL4o3gRi7J+/5/W
         CCgg==
X-Forwarded-Encrypted: i=1; AJvYcCWIOKZwdBqd6s4S9jKde+pSLGPnnE73ndEuU8pi4wwlGUj6alG4YzL6Bbr/5B8pli/VgPseIwSirwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyikTGX8NWbFBE4bYLoaFt9yCNIkAcPT/wWff5uo3/JNMI2koXi
	1ZByPa951HeHoJqRgdCep+ljGXKHeCH82/nIMpb1Tmu+R/ZtkE7EdWB39UzAIMpiHC3f0V4cD6h
	QWkaERlQFvfmpsmTMX1VeKzKhKNydkDcVZBtoS9TYaKrTPJseYdb1kcWQgQ==
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c95ac09876mr18284556a12.3.1729018303815;
        Tue, 15 Oct 2024 11:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZgBAdLrLu4wVCTKTVra2bi/zOy1A/yhu7xkqftgD6kovhQdMFl3ZjsIezqx0bvqyWUCvsqg==
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c95ac09876mr18284485a12.3.1729018303219;
        Tue, 15 Oct 2024 11:51:43 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:42 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 01/13] PCI: Prepare removing devres from pci_intx()
Date: Tue, 15 Oct 2024 20:51:11 +0200
Message-ID: <20241015185124.64726-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015185124.64726-1-pstanner@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which sometimes performs devres
operations, depending on whether pcim_enable_device() has been used to
enable the pci_dev. This sometimes-managed nature of the function is
problematic. Notably, it causes the function to allocate under some
circumstances which makes it unusable from interrupt context.

To, ultimately, remove the hybrid nature from pci_intx(), it is first
necessary to provide an always-managed and a never-managed version
of that function. Then, all callers of pci_intx() can be ported to the
version they need, depending whether they use pci_enable_device() or
pcim_enable_device().

An always-managed function exists, namely pcim_intx(), for which
__pcim_intx(), a never-managed version of pci_intx() had been
implemented.

Make __pcim_intx() a public function under the name
pci_intx_unmanaged(). Make pcim_intx() a public function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 24 +++---------------------
 drivers/pci/pci.c    | 28 ++++++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..d32827a1f2f4 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -411,31 +411,12 @@ static inline bool mask_contains_bar(int mask, int bar)
 	return mask & BIT(bar);
 }
 
-/*
- * This is a copy of pci_intx() used to bypass the problem of recursive
- * function calls due to the hybrid nature of pci_intx().
- */
-static void __pcim_intx(struct pci_dev *pdev, int enable)
-{
-	u16 pci_command, new;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-
-	if (enable)
-		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
-	else
-		new = pci_command | PCI_COMMAND_INTX_DISABLE;
-
-	if (new != pci_command)
-		pci_write_config_word(pdev, PCI_COMMAND, new);
-}
-
 static void pcim_intx_restore(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcim_intx_devres *res = data;
 
-	__pcim_intx(pdev, res->orig_intx);
+	pci_intx_unmanaged(pdev, res->orig_intx);
 }
 
 static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
@@ -472,10 +453,11 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 		return -ENOMEM;
 
 	res->orig_intx = !enable;
-	__pcim_intx(pdev, enable);
+	pci_intx_unmanaged(pdev, enable);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pcim_intx);
 
 static void pcim_disable_device(void *pdev_raw)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..d7fd0772a885 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4476,6 +4476,34 @@ void pci_disable_parity(struct pci_dev *dev)
 	}
 }
 
+/**
+ * pci_intx - enables/disables PCI INTx for device dev, unmanaged version
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
+ *
+ * Enables/disables PCI INTx for device @pdev
+ *
+ * This function behavios identically to pci_intx(), but is never managed with
+ * devres.
+ */
+void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
+{
+	u16 pci_command, new;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new == pci_command)
+		return;
+
+	pci_write_config_word(pdev, PCI_COMMAND, new);
+}
+EXPORT_SYMBOL_GPL(pci_intx_unmanaged);
+
 /**
  * pci_intx - enables/disables PCI INTx for device dev
  * @pdev: the PCI device to operate on
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..6b8cde76d564 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1353,6 +1353,7 @@ int __must_check pcim_set_mwi(struct pci_dev *dev);
 int pci_try_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_disable_parity(struct pci_dev *dev);
+void pci_intx_unmanaged(struct pci_dev *pdev, int enable);
 void pci_intx(struct pci_dev *dev, int enable);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
@@ -2293,6 +2294,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_intx(struct pci_dev *pdev, int enabled);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0


