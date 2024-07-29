Return-Path: <linux-pci+bounces-10936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5293F14A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43D11F22CA0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EE6140E30;
	Mon, 29 Jul 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dkw8oh2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C63313DB99
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245827; cv=none; b=asqRLb72OZ3XxqxZAfoyTstw8cBqiyXpYEY6aGvDwMc5zFT1YVz8FmQ4mlPWlbgJZ5ZEBuwWU21gWSPES2Qp/WtmsDpDg2WL36Vk++ognaAXgPyUCQwaTtBqY3jcqE3Y3fpC7N0rsONkF5NMxRDphV0Htc6tMaVmcHz8qJpv9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245827; c=relaxed/simple;
	bh=sOPFbdAZcLvZ5+tla0cjE7R9UahwXgYuHDOyDiiXoq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMb4xdki8ld+iL4UgVwqv8AHSAh8ACh84wrvMCriNASP7J0BhvI5200S4AbqARFnyTet4RMaCb7q3ENsQq/BSexEozv6Sf8NeUndDSKeUXiWJp7nXaOj9Unr8SRMhTElu4YGk+1sUW7/e8x+3Od8sd5jPk+I+8xkwy7W7FOjmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dkw8oh2h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42kYX+we7aWmN9i2s2pGfyq6/m9TDK9MaaqQ5jcnuoY=;
	b=Dkw8oh2h8V8BabQ0xUrXugLbFJHV70nxP9Bjy6ml2ajYcX4WSzO4AoWBfjvs/2qrupWvoS
	BqkgdH9xTmssJlCJEJVLAf9fTXUGrrpCs4MTl58DmUHRDL1TtCpksj9qyYNcnyKxhw/ha3
	dQh8QaoT3dTBZJ74jDhbeM3X4GpYGPo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-HtKo6Wr4NCeSpbTX1iperA-1; Mon, 29 Jul 2024 05:37:02 -0400
X-MC-Unique: HtKo6Wr4NCeSpbTX1iperA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7678caf7dso8362206d6.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245822; x=1722850622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42kYX+we7aWmN9i2s2pGfyq6/m9TDK9MaaqQ5jcnuoY=;
        b=rRf6Rz6kQcFwJQubJWXNIfMdDHIQxxLhT8LI+ScafX9RsyMQDuf7B0Gs33mJ95SBll
         Of5RPvuhWt2MyIX93B6AbBoCK6iArcI4HW4CBK0/TY9VRbplufyWgi2bIDEDAXZDq/oS
         hw4hGLsGkaVGvDF+GwEBz+UXKZ6m753CbBOPXjVfB1JYzpPi7L2oT+oExQvQfJFAJI3w
         Ox5XWDILeaOP5uPd6Y1UYvaXbcbqOiJa0o3H4IrgIHEzcanMYdagu3GlHTwzOv+UvYtq
         Tj0SmSUyWHx7gQ9bTCKDC3FJ0v1uUaKJWRR3YihmFbx6/wwG0tCmbz5pz0jBxMIQze9F
         xrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy1cZLpHJPKXh4Eua+8Wh04cVxukWv2cwMFsuVvn492/qvrJPZ+IjmOXSjrDjr7f9LDFHWA6euGauDM9rpO5TcjZP8BHf+SxJK
X-Gm-Message-State: AOJu0YxhmM4bkM5GSnjKhpu3OcSVoVLGFAa6YZSK1iMuSJvVpAv6kzaj
	KfGPkZ32fmK6rvqvpDZwHMNfQfCPv4OWEXN7kW11VzgMSUFfj45CZJuZV7kjMeCzI6uSyN2XXST
	EzCNlBCYmnD+LYPN7+HWC5SyjiKb0AOSaIgY9McqCSuUbt208a9G1gYKHVw==
X-Received: by 2002:ad4:5f87:0:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6bb3e38b497mr93633316d6.9.1722245822099;
        Mon, 29 Jul 2024 02:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkPP99cFbQc6WSD5piny1t+VTMR84B7lZvZiZJT2aKKHRfx8A/j8DuWgpWI66gNwcsld6zA==
X-Received: by 2002:ad4:5f87:0:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6bb3e38b497mr93633256d6.9.1722245821694;
        Mon, 29 Jul 2024 02:37:01 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm50047086d6.86.2024.07.29.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:37:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] PCI: Make pcim_request_region() a public function
Date: Mon, 29 Jul 2024 11:36:26 +0200
Message-ID: <20240729093625.17561-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>
References: <20240729093625.17561-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_request_region() is the managed counterpart of
pci_request_region(). It is currently only used internally for PCI.

It can be useful for a number of drivers and exporting it is a step
towards deprecating more complicated functions.

Make pcim_request_region a public function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 1 +
 drivers/pci/pci.h    | 2 --
 include/linux/pci.h  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0127ca58c6e5 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -863,6 +863,7 @@ int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 {
 	return _pcim_request_region(pdev, bar, name, 0);
 }
+EXPORT_SYMBOL(pcim_request_region);
 
 /**
  * pcim_request_region_exclusive - Request a PCI BAR exclusively
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..2fe6055a334d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -887,8 +887,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 #endif
 
 int pcim_intx(struct pci_dev *dev, int enable);
-
-int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
 				  const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e36b6c1810e..e5d8406874e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2294,6 +2294,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
+int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.45.2


