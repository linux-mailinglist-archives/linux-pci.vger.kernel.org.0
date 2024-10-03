Return-Path: <linux-pci+bounces-13760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F698EBCF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 10:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397C51C212E3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639C13D503;
	Thu,  3 Oct 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OAEDgIgz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DA2232A
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945031; cv=none; b=T+9TmsQhGPpXBkZ2IYU0RE02DfUn1eZhuNTqVgQ/9K9el/6MErEarbqDipzRV2FRNbEUo9Q5H8VC7Y1MnG1jp2KATVitT4xIhVE7VsTjq7BOvwOgmrhFzo5waF2/O1qYpssE8DzDYmnhtK5OX5SF+5qBvheYNrfWVXz7yRpbIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945031; c=relaxed/simple;
	bh=V39ByUnb6eQA7DEYoba3mYdbfJS88SGqKjIcIGHEECI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQHYcoWanuRzMvMSUt/HufLVtkrP48mAvWMM7UAieX2hfWdaLJeMP2vrcOEFfnNRiaxj//L4U9DFDmpYMIjm3kuo7+2kUkoBPp4Dybf8p7ZzdY/v63BtEmfTTGj8V4tJYhsOb5nvCU72YdG/H9TMZ7oEAcqRbdV480xPDNbnG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OAEDgIgz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso6541325e9.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727945027; x=1728549827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91R25a2wyX7P6HDTIfgpwuQpgkreLb8uwItCcCtAsaw=;
        b=OAEDgIgzG645IelmgVnDuAV8XAm3PcEl0NIhwNuC/YtMKcFsWpsSSnrWhEjsdWmjRE
         pFtOs9D4OWuyGyTJMrupDlbrXV+m7FcNquLBhMOMTN30PeTdiBylok11scxe1DmJK3Ot
         p0jliDmJmeQgRiC6FGWvO7d20xVeIM73Wj1yX6c1PR60Q8LyqRgLuAEcbixZGFT1ltqV
         f0j5xpcAPErMZTHVPJVhS/Kimctc/rmj73w2RV1ExBZbYiHyqzGP2JacVIHl0Pv0NDxc
         qPkl0IHSggKNW60D0sh0a2DW6PIuD9hwdkfn55jHI9ZyHlGqXZgBE2/8+VX+9iqsZGan
         XRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945027; x=1728549827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91R25a2wyX7P6HDTIfgpwuQpgkreLb8uwItCcCtAsaw=;
        b=XKYXgC8fvl+u1CFoKTZVOp2Ztcf556zR9daAsj3qqjfeJEZo7HuliAEsbEMECkzeJy
         7p/SnEA5h0kB5hIdTL3sEUC54d6WNBYZc0iiz4VGZmkXX/dsC6xiIks+9nULf7lg1Xw5
         6wqEiTGLk0jT/lNhHOiWqTpCOyFs8GOzDeZa5+fEzDA72o9cENEvk0+U4+QzsC2JTUSX
         MnfH9pYqxEOTHbn3Ygw5xrltJq2YKJ1T9RGICxl2NtNkR5C76iqoaBFS7+S4f2K8HPOV
         AIvtfGgPbX7XTNb6I/7PynARjncPKmCIYYuMAVz+5lLbsOci4vgwS5fmy7oxrCav9geb
         qJXw==
X-Gm-Message-State: AOJu0YzzgYV/mdZKsS8EGyIdODiBuTexUNkX9avZaMMDukIntzWsnauC
	JoZzxqwhAsBH5TZJK+/Vi5OK8gYDNID60nszaunaq7tNaB+0uw5A/QkEvn5oPoc=
X-Google-Smtp-Source: AGHT+IF8q7SdaJlu7Cz2gjY5BfS++DH+bKC94NBze2ggp+J2cvIzQEdbZw64rpaHfv/VwoxVyvianw==
X-Received: by 2002:a05:600c:3ca5:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-42f778fca5amr47022515e9.30.1727945027265;
        Thu, 03 Oct 2024 01:43:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d16b:3a82:8bfb:222a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02f174sm39362455e9.44.2024.10.03.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:43:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2] PCI: take the rescan lock when adding devices during host probe
Date: Thu,  3 Oct 2024 10:43:41 +0200
Message-ID: <20241003084342.27501-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since adding the PCI power control code, we may end up with a race
between the pwrctl platform device rescanning the bus and the host
controller probe function. The latter needs to take the rescan lock when
adding devices or we may end up in an undefined state having two
incompletely added devices and hit the following crash when trying to
remove the device over sysfs:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Call trace:
  __pi_strlen+0x14/0x150
  kernfs_find_ns+0x80/0x13c
  kernfs_remove_by_name_ns+0x54/0xf0
  sysfs_remove_bin_file+0x24/0x34
  pci_remove_resource_files+0x3c/0x84
  pci_remove_sysfs_dev_files+0x28/0x38
  pci_stop_bus_device+0x8c/0xd8
  pci_stop_bus_device+0x40/0xd8
  pci_stop_and_remove_bus_device_locked+0x28/0x48
  remove_store+0x70/0xb0
  dev_attr_store+0x20/0x38
  sysfs_kf_write+0x58/0x78
  kernfs_fop_write_iter+0xe8/0x184
  vfs_write+0x2dc/0x308
  ksys_write+0x7c/0xec

Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Tested-by: Konrad Dybcio <konradybcio@kernel.org>
Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- improve the commit message, add example stack trace

 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..f1615805f5b0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	pci_lock_rescan_remove();
 	pci_bus_add_devices(bus);
+	pci_unlock_rescan_remove();
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);
-- 
2.30.2


