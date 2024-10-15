Return-Path: <linux-pci+bounces-14579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F699F68C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 20:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C21F21781
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0C3DABEA;
	Tue, 15 Oct 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpEQlPAs"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F382296CA
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018347; cv=none; b=tBurp/SpbdaB5zxrfccZSiujW2YcuCdKHV+Th3kmr8nJgQdo+KWXC+/if4nRx4XSXKgUS9fZ+IXe55kvH2hD76xQIiELurSw3yN016je3WL0w+4C6enkbUuA+krddkORZVey80ytK6yyt/jOJg11tjJApDNNimHJCiXE/IFQ9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018347; c=relaxed/simple;
	bh=ZGl79UfjjHp/dbanoMIKpsfiBb1RGuN8b5mG9T34Oqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8hWaNW4NS9Pu/vyc4b+KAtyXd5k7p8u02qsk1Qnsf/+4CuGXhX9jUD+CjNpvAV5c0dj6KAGj24UIS71rMhLEmjfNwYj+yhpAfABCSHFmvexyzrQzo/WXQz5zA2uU6FFRMY00rPvFe4P0Wvnkj74DF7IJIvRd/DhfwalosDAgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpEQlPAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXTMrjROGaTcKBpC5zD8IzpbS8kTElR36tpy9F32tfY=;
	b=ZpEQlPAsYeOvXntrSbW0ABh7+2tSnwXa7WDwEHLDoPzkzPlltrF8A4RHQEjn0jScLBUlis
	wmd0W+PAX8Yx9bEeoXRDah/Ys1P/curCYyNwbglXIlutUGsLFDcqyRME90m3ZSCtEYFUp5
	H9moGF9JCYMYdcT+qjaQvzQDOz9LTZQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-iLrs0pvoM2CN0Xb6AEoAuA-1; Tue, 15 Oct 2024 14:52:22 -0400
X-MC-Unique: iLrs0pvoM2CN0Xb6AEoAuA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c91d498e4aso4378637a12.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 11:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018342; x=1729623142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXTMrjROGaTcKBpC5zD8IzpbS8kTElR36tpy9F32tfY=;
        b=V5PpSB+GLQCmMlSZllxtYt9kwsWXObRcvwlykw4bQVcmd8wZTpB3QavEnKuBoBIzd2
         N0xaV7EVu/mqTU5yLAG/MjNEboP4anPZyldjQmEtejQD1Oy/2C2fal4O1sx/jDQgPBnb
         LTFu7ThXXcxG3WQzUHlss62rQJHVYpJQ4SDFiGZlhz0ARxpni4LJsJrxOOGs+RIwf1kn
         VMcia4NQI2+WsDnnZQ95Cq/eCnbbXnNKfabJMeh2IWpJUPq4ghxjYrwryYbz3gOECxpc
         eZwY9+XDeF4qQsbJaxun+169RBVFmKZKCLyVtvNl8P18W7pWiNn+CHXD5amY5J1NJa24
         0uvg==
X-Forwarded-Encrypted: i=1; AJvYcCUA1mNhutBSJZVJot0X/NeVigifWJHhiUUCPAuO07gx/TgwAYocUINcyGoR4afZAhvvPxU9cAlmhf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhn8YpKUM6c0aCfCfFVG/5h9RJUKPY3NSi5w3DdP6F1mccjhiU
	SdWPge1RzpBBO67Ew0AvvUmddpt6I/0/8FgDoGA9K0OKroEc1nru37CO9ecClOYEScjptDctQ+5
	J4hzN21N3woS04Adv+UoZJBZNhY4Fl287Wnzh5DDrRwb+XGH2AUfL8dC/7Q==
X-Received: by 2002:a05:6402:520f:b0:5c5:ba82:c3b1 with SMTP id 4fb4d7f45d1cf-5c95ac4e471mr9747021a12.29.1729018341622;
        Tue, 15 Oct 2024 11:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4IRS8nhPSbHHMGAr1esFr/1sORzxV4dHhLUSla/ENaT5Qe2x1SJKm+qMzu8Ky2rtxd6imbQ==
X-Received: by 2002:a05:6402:520f:b0:5c5:ba82:c3b1 with SMTP id 4fb4d7f45d1cf-5c95ac4e471mr9746938a12.29.1729018341069;
        Tue, 15 Oct 2024 11:52:21 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:52:20 -0700 (PDT)
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
Subject: [PATCH 13/13] PCI: Deprecate pci_intx(), pcim_intx()
Date: Tue, 15 Oct 2024 20:51:23 +0200
Message-ID: <20241015185124.64726-14-pstanner@redhat.com>
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

pci_intx() and its managed counterpart pcim_intx() only exist for older
drivers which have not been ported yet for various reasons. Future
drivers should preferably use pci_alloc_irq_vectors().

Mark pci_intx() and pcim_intx() as deprecated and encourage usage of
pci_alloc_irq_vectors() in its place.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 5 ++++-
 drivers/pci/pci.c    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 6f8f712fe34e..4c76fc063104 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -435,7 +435,7 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 }
 
 /**
- * pcim_intx - managed pci_intx()
+ * pcim_intx - managed pci_intx() (DEPRECATED)
  * @pdev: the PCI device to operate on
  * @enable: boolean: whether to enable or disable PCI INTx
  *
@@ -443,6 +443,9 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
  *
  * Enable/disable PCI INTx for device @pdev.
  * Restore the original state on driver detach.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pci_alloc_irq_vectors() instead (there is no managed version, currently).
  */
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7ce1d0e3a1d5..dc69e23b8982 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4477,11 +4477,14 @@ void pci_disable_parity(struct pci_dev *dev)
 }
 
 /**
- * pci_intx - enables/disables PCI INTx for device dev
+ * pci_intx - enables/disables PCI INTx for device dev (DEPRECATED)
  * @pdev: the PCI device to operate on
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pci_alloc_irq_vectors() instead.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.47.0


