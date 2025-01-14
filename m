Return-Path: <linux-pci+bounces-19716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A117BA1044A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF6E1685F8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53E28EC73;
	Tue, 14 Jan 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jJySU+1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523B22DC48
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850893; cv=none; b=prh1E5QHKkbAM3QqKUhr6R0btIJUaykLK7FPIut9mM0G6YZg3VJb1eGtOVx6lOmbbf26LSgong+EceKVpy8j05L43B/figAPmrwyji+9dAMPiy7hAbvA9+lQzzOuNB/sCC+VeBy08b9s1BqiLH8KIs0acvHEKJ7XG2ZsEefBW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850893; c=relaxed/simple;
	bh=VSqmcVBfwXIY69B6YqMhcuiidU9hF5xOgQJpsgmErXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTpYZQUhEH7TFHi4quwT2jIV8sXpm6aqqAhxlb+OrVnwWa19U4uPyYedv8KCASZivadLp8AAlyomRVy5ltiJiEzWH6baESv62OftayV3k76sxU6h93eF5TydP+8upqDtqkzYKpcV8+i0PZQKcgQ2gOTfiBk/F42rGbzRPFzAlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jJySU+1K; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso938602066b.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736850889; x=1737455689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aKUOtOG9BVgReGI+Nw2NzmnaZPU8conWgd+JDzRbKo=;
        b=jJySU+1KCSAaJcLXDvlC0zF7jGDof+k0ld6Ex7CHTEhONmyml9pp2Fvqyl/oOl5bs2
         HKboPPde3o2hSvv+jhcTWf/eoHF+sLsQpTvssqJPjNKrCuHdAxASCUqjj/6JEfyJ+pqm
         0ssLfkTHOIRHZp/4S0BcrOtq2YSuXOGiYVCy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850889; x=1737455689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aKUOtOG9BVgReGI+Nw2NzmnaZPU8conWgd+JDzRbKo=;
        b=Jik8I7eLl1g8ePQ57QghbEOwmuNTaRVHNpm6t3PaxNaSMglzGIHDxs/4iUGs5ZQ7Fe
         OrC1k8FKmidp9m8zdDyW/+HY1wtoybWS9wD4dzIlKyhR0kil8OuzJdNe3S2mBO6c7ot1
         gkInmx8MjanWtCbLPpYKdAs2fhmNM7TQXCzKcxFP3j2iNPtawVhtmznFFGPRKzW3s1ER
         CdAsk30YDptxdhzRY5az2gBhTd2wkolBhJzht3Tfp7rxKfYK6qJ70iPi3JVo5+qksUPz
         5HL8y4QE/7ATWQTUPK+/XLN8ihXhuY/gPaEGPD1Olt2yhzrrVyH79a8YmSr+Qp+YUgfL
         MhKA==
X-Forwarded-Encrypted: i=1; AJvYcCUNkXNQ/5UQsHMoUauQfXYnui4h+7l19d+/Tesh5EX5M2Z0b8Z3XF816CUHn8Tx9LgShQBs67mlMV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqdRJTdPuYSTb0TV6qzkO0BztSAl5qO3Wm1juh2wdMAo4ptqu
	S48s/dibh/79AVd3V2Qy67uZk3c87TzCZOoL9kakZ5XwOtwCqbWHnW/yCFudb1k=
X-Gm-Gg: ASbGncvdttFhuhoWDDf/QqxZyQGFtTslx8PpnpICHWRnASxMOsUn9RvH3ife6BMjJVM
	HCE8Wt8bTnfIAyStd7V08qCcKUaFLKL5EAdPOfyTcBiYqQRdtrOUMgGeqNw4XIlZXkQYcZmyUwH
	flKXpPzlYb/xErtn8kE84t4CCFpllJcueeANZhZF/pIbcTgYTtPgzGwgllUG3FCtF50csB020AQ
	T8oUNGmoL4InJadxRL1Gu/3MoB0hIuQpUUm8QirAcb6zDUA+yMakmwqdc4Nu1Xua1I=
X-Google-Smtp-Source: AGHT+IHu5De2z/QFEQRsmLROwHRAnH4F5r3sr8PBreqTBE5z0L97HWAie9gr7imKD5uPM/cH1y3q+A==
X-Received: by 2002:a17:906:4fcb:b0:ab2:fefe:7156 with SMTP id a640c23a62f3a-ab2fefe94f8mr1052272666b.43.1736850889114;
        Tue, 14 Jan 2025 02:34:49 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c913605csm608116266b.82.2025.01.14.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:34:48 -0800 (PST)
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
Subject: [PATCH v2 2/3] vmd: disable MSI remapping bypass under Xen
Date: Tue, 14 Jan 2025 11:33:12 +0100
Message-ID: <20250114103315.51328-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250114103315.51328-1-roger.pau@citrix.com>
References: <20250114103315.51328-1-roger.pau@citrix.com>
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
Changes since v1:
 - Add xen header.
 - Expand comment.
---
 drivers/pci/controller/vmd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 264a180403a0..33c9514bd926 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -965,6 +967,23 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain())
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus
+		 * because the config space of devices behind the VMD bridge is
+		 * not known to Xen, and hence Xen cannot discover or configure
+		 * them in any way.
+		 *
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write by Linux to the MSI entries won't result in functional
+		 * interrupts, as it's Xen the entity that manages the host
+		 * interrupt controller and must configure interrupts.
+		 * However multiplexing of interrupts by the VMD bridge will
+		 * work under Xen, so force the usage of that mode which must
+		 * always be supported by VMD bridges.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
-- 
2.46.0


