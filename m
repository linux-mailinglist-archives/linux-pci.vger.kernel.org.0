Return-Path: <linux-pci+bounces-21799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9075A3B97C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 10:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292F83B94B6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236401D14FF;
	Wed, 19 Feb 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="qdcGHmef"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAF1B4F0C
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956953; cv=none; b=p8+RMmeSLeL2EP0G2IIRLD0Wl0P+Pxjzv4fPj4EEIWYVyqTrbKb0fjrashFsp5Ay8+q4GZfIIkYTQvbUeKgr5+3rvb0GcTt8JHBCqPpGhk4iy8HLPunNc2XchXhsFAk9CviQJ9Z76D6z0Oh4ostSPuVO4dYKqZQtT/jQCu+wiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956953; c=relaxed/simple;
	bh=Emq0s37HWVf+yMAcB00SXuh2VSIdv4rvq6v00xkLO3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqgoOFDWm+8IPO4McQPKgkhfFPxYEi/aZkLoxR808yUlfzG/CnOirHnn+PPlTMN4HxYI9WfmjyEGFSkxo2HLby96wkDlsQtW8158Dq/IHOaO0w/vrhvp1TzHDwk5kRzXEAUeNgU1aR71pvBis82SFiA9rBX0MlTSaDccsDp7aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=qdcGHmef; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220f048c038so84580655ad.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739956951; x=1740561751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjpV/rOsBTZhvMzmuINLNFZE/6rbEow5DAVU2rYU1PQ=;
        b=qdcGHmefAT+xBHykoCBohWDqLuGjyyk4gBR2fizHuEb3pIKIZEhVoD1ACMHbtbEbZ7
         a1ZdP2SSuu5Q0k8ugHRKDNhZ9p32HVG8hMuLDx/eNQTnkXXK1AjxDvJ70uFgo2LlZ29f
         vgikYZ5iiyl9tcBOQaWXX31305V3D7xoWWspw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956951; x=1740561751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjpV/rOsBTZhvMzmuINLNFZE/6rbEow5DAVU2rYU1PQ=;
        b=DpS3R2qtu2yYamM5u5b2SZqC4cvY7sOM8QB/l84V4MjlcIHh/2G2Hg+Z4H1IKgbX/x
         edSMedGfnXxb2MKilEZ48sydX69179LEugNl7u/64Kzd4ZmMqXBkF1aeTDRYYZ/cIc7m
         VsYcv5gMtnVv+HmDtEXdg2bXql4eXn0UrQR8l22peobcJhHMnPPLbHP0wPwjN8kgs1BK
         0PFbWCENtvDhT19zXiB44byjsGaiaecyKYFPBIeLNqahsLcEtI0x0+NW3lX0qe4tW7cY
         0c4vfLRSHH/bogWDQQ50IfQV3L6wmXG+GEOjtgaS7b4ykd8rzNf8CZ2/udXKdd6geUMU
         e+cg==
X-Forwarded-Encrypted: i=1; AJvYcCXO7Vr4FlJ1s8bgRsJS1QP+VqQDbYZRzB4zTU66H9jsDWfZbdYjCRD9tG+6lGVqx597k8lbtmGtO/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYDQKLpAbFWnnaWdTl0dKT+N6k5ZKl3ulZvf0I8aA3/OSpFO/
	sMDLeS29nErgP1gvvFnxqVZVkP3SNYXaQBlysuk8dv5NqB8Vu3DITGcXIwJapvY=
X-Gm-Gg: ASbGncsw6ggY3ivV9U77Wx7o5fmI3tlwsESCOPFJkMmmn6CXmEi4uNJn4T4xW7RxBCF
	EuA+9uQ2ZWYuDFQmVWzcyUKbNGMyuDDXBP12lq9ABdcO3Ri2taVKtnaiMRqyBHAYey/7O62zbhs
	/0AjM7AKf1TWIg0LW/v5e4Fu8uCW3WbX90XbF5qA80rdlL5hoMJ8JrA5ddRhOebTMlHgIeMY8a6
	ky8gIW590XEIjbDOzQfNKri0ADXYzSGhGlv3ZMgqLFxCsZTPh/Ay022zl6xJHzNQwRcILoZjyX7
	GLS4WZ769Rgq9zTl6oGZ
X-Google-Smtp-Source: AGHT+IEJm44nEb0TxcOjkAjrcsD0xsD/CPlwgrhHME8dtzpc5/4Onda8YE7jAeRTGmWr+ZG5phmDmw==
X-Received: by 2002:a17:902:ce87:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22103f16b56mr276089045ad.15.1739956950796;
        Wed, 19 Feb 2025 01:22:30 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d621sm100543165ad.136.2025.02.19.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:22:30 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/3] PCI: vmd: Disable MSI remapping bypass under Xen
Date: Wed, 19 Feb 2025 10:20:56 +0100
Message-ID: <20250219092059.90850-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250219092059.90850-1-roger.pau@citrix.com>
References: <20250219092059.90850-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MSI remapping bypass (directly configuring MSI entries for devices on the
VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
and hence cannot configure the entries using the pIRQ interface in the PV
case, and in the PVH case traps won't be setup for MSI entries for such
devices.

Until Xen is aware of devices in the VMD bus prevent the
VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
any kind of Xen guest.

The MSI remapping bypass is an optional feature of VMD bridges, and hence
when running under Xen it will be masked and devices will be forced to
redirect its interrupts from the VMD bridge.  That mode of operation must
always be supported by VMD bridges and works when Xen is not aware of
devices behind the VMD bridge.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v2:
 - Adjust patch subject.
 - Adjust code comment.

Changes since v1:
 - Add xen header.
 - Expand comment.
---
 drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947350..e619accca49d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -970,6 +972,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain()) {
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus
+		 * because the config space of devices behind the VMD bridge is
+		 * not known to Xen, and hence Xen cannot discover or configure
+		 * them in any way.
+		 *
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write by Linux to the MSI entries won't result in functional
+		 * interrupts, as Xen is the entity that manages the host
+		 * interrupt controller and must configure interrupts.  However
+		 * multiplexing of interrupts by the VMD bridge will work under
+		 * Xen, so force the usage of that mode which must always be
+		 * supported by VMD bridges.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+	}
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
-- 
2.46.0


