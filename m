Return-Path: <linux-pci+bounces-2467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BD838AC2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD881C23983
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2B5C8E7;
	Tue, 23 Jan 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Up1zjTwo"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89B5C5F8
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003101; cv=none; b=na+XhQbiZ0WTom96OcC/GyBKZnGC31O/I3IIGFE/TiG5uuXGPpsrQTTHoqGkqKnxOwbhPlYQJuEuafo0frp7wriSnySPek30bDi1Bsj8X1nF8AcnxqVy7OSRJd5fR2kfjJUzyB9TaaPFNG26naavPCiuPrqFySlpFF4b5cR7TDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003101; c=relaxed/simple;
	bh=KIuP+YZwliPwVC5hbGK2gsLWRa4HN6FV/A+opHrJu2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQxLJKYBv5jxqwcdVBpAhuvTwl40RsvECbu5Zx0WMiDAB1cdOzL5aSARxYCz6XhvvN/6hadzjW/IyRPwBeGzVPKaLX2We3htmCO1m3dITJ+jaTAxInqGUqITnKxYXYmvKIjktMxSuapq3bwbXotUxsBOT3dnGMyKoOUQqmJ4Yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Up1zjTwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJOcERA6WkIGWk0k/QFxozz5e8Wq1nBqoQjIfxjRAsE=;
	b=Up1zjTwoCeMFwANiurK+ZVr2LuwzeOTpS/w32ym81EUVzCm8+tW0Q5unyAOHL6zOaS9hdl
	Nu4e/TDlNpwmZ3T/R5VvFRWZ05f7wODtDbR0zGWj3Orarwpl1rFzZKrbOSqI8fdj6iDzUr
	q8IF03aUYQUvSwCcFJWV4UW44hTupMo=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-VmyriLfNPbiI6U7oTp8FlA-1; Tue, 23 Jan 2024 04:44:56 -0500
X-MC-Unique: VmyriLfNPbiI6U7oTp8FlA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-469c0622932so183446137.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 01:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003096; x=1706607896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJOcERA6WkIGWk0k/QFxozz5e8Wq1nBqoQjIfxjRAsE=;
        b=kP9WOkuRdTTJdpcJCDt1zLebkdYjv/3zk3igoxP3jMLikVa/ilWHaCtT+jstPF0+KL
         LdRqRBIJQxZ4lRtlTO39hVdWqSWKwl5EchZzAsnT+mS4ZswPpTeUYRi1eS9vfIUiYefp
         uNQqnS/AiOkYWuBAIEwKmMheqr70LGqfvRRXBc4NRzxkdnrE09Mtl2lbI+ydZYcHdxxW
         15feOo6b+jI6iYqCAH4noRSSs2RufFnmc769AfupjI0DwtUkZA6KUrgBYjrI70Lydk4V
         bDibEB3hTm8WIYVIl6XaEuxJ3YyvchlAA45rs3bPjz8pqXwezHtUCapicKAXGuFJxS4/
         XpRw==
X-Gm-Message-State: AOJu0YysHK4539Asymo9lVsuyjng53FGWLwt3uefWXiiHDXp8dgwj9Bo
	Gk8Zy4fZSD2JpiCJHQQLUdiFvqs5FqVOVY4hEZjJQgHUDE9XCwFClNwpyDmmktcKmk/U4AWQnzF
	4xhRVog9IHJ7FIgkN0P8P10DTc4/P/NiyiwUWx5CQzNkebpM+gwGrs1mONA==
X-Received: by 2002:a05:6102:300f:b0:469:a5a6:6d0b with SMTP id s15-20020a056102300f00b00469a5a66d0bmr5387234vsa.0.1706003096218;
        Tue, 23 Jan 2024 01:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfiHCQyTaU9QSY0mi169Dtu5iV731XTwQIfoBCycLdQ++32x8wjMJie+l0KlKJveytXiqnhA==
X-Received: by 2002:a05:6102:300f:b0:469:a5a6:6d0b with SMTP id s15-20020a056102300f00b00469a5a66d0bmr5387218vsa.0.1706003095921;
        Tue, 23 Jan 2024 01:44:55 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:44:55 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 05/10] PCI: move dev-enabled status bit to struct pci_dev
Date: Tue, 23 Jan 2024 10:43:02 +0100
Message-ID: <20240123094317.15958-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123094317.15958-1-pstanner@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit describing whether the PCI device is currently enabled is stored
in struct pci_devres. Besides this struct being subject of a cleanup
process, struct pci_device is in general the right place to store this
information, since it is not devres-specific.

Move the 'enabled' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    | 17 ++++++++++-------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 7bff17633bc4..696541c65c8f 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -448,14 +448,11 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
 
 	rc = pci_enable_device(pdev);
-	if (!rc) {
+	if (!rc)
 		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
+
 	return rc;
 }
 EXPORT_SYMBOL(pcim_enable_device);
@@ -473,7 +470,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eb3ec59e8822..ab8d66e05662 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1953,6 +1953,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -1967,7 +1970,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -1977,6 +1980,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2146,6 +2151,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2153,6 +2161,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2180,12 +2189,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (dr)
-		dr->enabled = 0;
-
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7c2181677760..dbb76a3fb0e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -809,7 +809,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 641ee30f7d2d..a356bdcc14cc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,6 +367,7 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
2.43.0


