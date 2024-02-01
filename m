Return-Path: <linux-pci+bounces-2935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D13845C5E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9529B2F7EA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80415F33C;
	Thu,  1 Feb 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G9dsRo5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CA15B961
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802951; cv=none; b=lI+As+VlETkbawJQANZpMnQsDrLkSy/+osGADRtu2LcqF0z/XZ7qlnK4wbW/OdlGDaO1keseUvbBvbrvnGdNsZiSTyF+QcEGRGUWjOHk17H6HeD6932ncoDo9GV0lQZpaJc/pQ14xZekggrX3Im6adBXkK5efWtsQxRWLbeAgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802951; c=relaxed/simple;
	bh=2TB7G9586wBiGx6TP08ByJQQGcZ49ktk6A5S0Zz7eEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XO3olNJwhm9HBL5Eyc/u3NcULWJRxaUFR6oI8cHeJ6DVNa5bylcvAuxTYaz+WtpUn/sFZUm8/78jZQ9l1B3XD3EVAYNaQ4bdc9CWtn0x11SNOGBz1SpMo604m/zwViFQAeljRABbsfUuFKzmO4GBcAf1/3maZYGp1mNfotutfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G9dsRo5m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso9671725e9.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802947; x=1707407747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGIV5k0CAIkt4/Drq57Mr31uOV54nJUOwQSsCzcpX2k=;
        b=G9dsRo5mBndH0MSMW/uIl8ZTCJMpbP3e+U977Pmx50Reev4/hGbbKFGBEa9gOtTHJC
         ID5z1P9L5CvkQymS8iaQ+y/mzAlLqWcHlxeBqb4swkzauyAomfVjEnsGBnGPcvfx/wRz
         T4xlsYTOygksWhfjaDrC3geL8Opf4yoKTMAVbtW0vwOAQ/LrnYVrAaIoiVH+40XjsVxa
         6q3QPbK6LeclniG5WGwJriXZ7NIvToK/Jf1H5CZK3ZVJTqP/kqSETyyBJXa2PVpJkwtX
         XyaSOtzAXpSU0/UxVScVGyMhvyTr60EfXB15zko2cgLL0U6Vyv//EOZTvQbaEWkmTRAB
         zFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802947; x=1707407747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGIV5k0CAIkt4/Drq57Mr31uOV54nJUOwQSsCzcpX2k=;
        b=aITVN9FE70w7eESyvAWQeOzoPNVybsSBTewDtWoJaf13JlJ2w5EXybDbZM7aOAt10N
         Rya36mTkQ3/wOK7jqOFrn4m7v9C0GO/cE5pbs8noFKSM8HT2p7hH/xA2Ve9YEadMptTo
         pdDgYK+k94GqhndE1Pv3WEtgnacnYCLtocHP4aJYNWFDYk/dGnmz2X8eQ/iKQAbM5FMo
         gcKXnqZD6ZMFcqZFXQKiDt35gIdMk24rsKGs4WWGlCReuWzzcmx3K34KEY7iiQvLJZ5v
         4akRWlc/06vHOMoCUgTrQmi3cJSZAivVISfZxpEtEICQJVN1QxQtjQ+ajdK4acTpPbB/
         OBXA==
X-Gm-Message-State: AOJu0Yz8McGqVpVETnZdUGi4ixIPnk9z96SNdWymdDRVeV/C+/5QF4rN
	+JZuSeN5H8Yc8/xjf12bl3uibU4RlO/ja+gx69W95syRMGOSpxG2gj8PQXSgGO8=
X-Google-Smtp-Source: AGHT+IHrIgtPBGOwwkToCnKJnB1aV9LD4TnNqN3x0TxT01CT3Pl7rZrWkB/WvconB244cLvA5Ru8sw==
X-Received: by 2002:a5d:5051:0:b0:33a:e8b7:14e6 with SMTP id h17-20020a5d5051000000b0033ae8b714e6mr3518028wrt.55.1706802947384;
        Thu, 01 Feb 2024 07:55:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXUMnyLPTzxs2SEFue0K3khL4YRX36+K6a24zNZtfHXX30QIy5AwLzkcOFoQSx9bYdOnjgFk7fGi0X9bf1oNY2Rzsr48eGGsQM0HqMrTVjODTok8uzFCEUfZMJ/z0yH2DMWVPkCgiO68mL/fAJoYRlh4Bht0FXuPud6GmRWwoHr5b0I5y7PiyFAHcZbs7jjbceC/CpoxGEKvsgtzrD7cBZyPq18HXGgzDlBxCaos0IFTiXOezjtX7SoBaSj7pgGXyNXnX/p9Wpc4F/rDMrXogWXuMF4jYSV9N3WATTc9bh9Ks9ibvnx+bPrvGdjN2q6VpaysNTaWNew82h33i/0/7b3DY3XG1/VBurZpJLKtQcBCiDZjKJGcUcOPEpcQ1UVzRy+qayZSl1ia/C2V8RhZ8LlWcHt49Zms7PtlFW1RbPzdG6u92Nyk8/WnpHoLTyTbZptchTnRl3JYj3PsW2XAXxiwB703s3Mvf8nGow5+gFM3Xhv3paQaGkxlIz3PZiwmP+Q2rRBdxhqLKPOcWNXxxB42qj5QBv5APxVn+nzH/EDWPc9WRVh/KcN0tf4zmDdNiOUnpSZBvkNAxjXh7EaukBQOjDrQyhBz2FmKdlD3UppVYUnQJdIR82XBPMlDYo6YG17TNElV7HBrLnk7AHx9sUICFEbIsJoNdLpDlrkadi6IWQJy3ycgqIukkp/LzSJyUvja3GPJN3+
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 6/9] PCI: create platform devices for child OF nodes of the port node
Date: Thu,  1 Feb 2024 16:55:29 +0100
Message-Id: <20240201155532.49707-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to introduce PCI power-sequencing, we need to create platform
devices for child nodes of the port node. They will get matched against
the pwrseq drivers (if one exists) and then the actual PCI device will
reuse the node once it's detected on the bus.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 ++++++++-
 drivers/pci/remove.c | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..17ab41094c4e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
-	if (pci_is_bridge(dev))
+	if (pci_is_bridge(dev)) {
 		of_pci_make_dev_node(dev);
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..fc9db2805888 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -22,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_platform_depopulate(&dev->dev);
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.40.1


