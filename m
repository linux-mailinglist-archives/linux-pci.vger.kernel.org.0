Return-Path: <linux-pci+bounces-3568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134BF857600
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 07:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FE42842CE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 06:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C710979;
	Fri, 16 Feb 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="WkGAnwRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8913FF8
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064797; cv=none; b=ruBwzhHmoKoB1AAhSC50v4MgW86Nvzph7PdQx7R5CD910AnL9v74PlI6knnfpxbY3O5EolD9RlJFkLKh19Iagz4iuGukGLf8yWRwihHZE6SUiF1So7O9cXNunjQ8NgFZrpM9HCfYTVf6kF7FV8qV3lSIaDwIXEs7hPrnMxWFmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064797; c=relaxed/simple;
	bh=jklpYMPLXKpsCG7Ee0MeNNjpe+TTYfkDLz/jt2LOqb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCKJBcyOQ2x6K/kiWZc2yIZxc9MsrpPTBpvionuOGR9d33yMdZvFl+jFhorLX5XW6+bVqGYGV+bcaJ0trZHk71VjmMKWxPuzVWO9/VyJRnxO8OxPot/UogTKSVGRkKM1Ynv4sjvd/hcAyqj5bobob9IN40Zez2ByKivcIbgR6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=WkGAnwRt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso2210837b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 22:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708064795; x=1708669595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSz0QdC1Wat/mJPngx8k1JqTxF0mKLTeVX1uUrMHgiQ=;
        b=WkGAnwRtaoaZD3T8E970pyEm36Rz0wyBbkY88sNNvmEU0ZTeyyvHmuZoU/N+ofVgNl
         BMbR1BZ2GgYiwk4+xYHAWTU6Oydcfmzsld+A8VSeq/HBzyaZ6Zln996J/HOv7w/j9Sy+
         5gDnNfjKuHlIFtHUhMy7JKsjM8keVxlElqcfbh6mmNzY8ZeevGuZKtQtd3w2u8JActVg
         p+YLVsnl6uTTDoYfgy8f8E7DiWkYQLulDbjBf6Xev82rwabJxJj7ZJsC4u9yFapeJRpl
         pV4tlY/FeqZHTdj4qGtLPrwBjXBsVxrmCGxT5Rkr4QHzb4i4niLNX4OLUxngQAI6tFEI
         YepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708064795; x=1708669595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSz0QdC1Wat/mJPngx8k1JqTxF0mKLTeVX1uUrMHgiQ=;
        b=K9oVacnq2rm8p6+u7xUB7WcwaXRz+alRbNZGyhmQLQRl+WsHKxpCdahHibghELiCQh
         USi6EWQbl+rMaT3EVLGnfhrxNC4YJ3FRFf5ULZ8St8V+SLP5XOAaxnT55zjT+0nPkXL+
         DrIXMOX8kjr8Mj59hiuNhuxzmbVTQXYQ7hOmzFhG7DTZ6Qt+M3G693t6Wne+7Uny0Cfd
         64LFWAk82QHo9UWX4J+o4VLjOEFGa6BX67jbQLiyQfI86U0IuDeuQtuBmVSfcJs8Eom5
         YT1oZsKc6Jp1FXCx8c3LH31gJn8cSOQ8QWwwaNem94+AEEkNFi4OG3HqCzVH8TTB+i82
         0sdw==
X-Forwarded-Encrypted: i=1; AJvYcCU1cQ2wjpvWMJj5r2WTHzqlearpqX1BYaJw2JWA77X0c6oJAKx+9BAgVxl1W74+D9Sqr4Dw0UFJgOFcP807n0AXKCINVI4sw7Ia
X-Gm-Message-State: AOJu0YwTdeKZXeqrJ8ZtYybJNbGVQY/3kmvUMFLTKA0H7orbgwuvGR/Y
	Qm1lAbZYTP56zvdWuhXu1hCt0YV+f9nILgldE4531mP793LORxXsOF/JbEGKagg=
X-Google-Smtp-Source: AGHT+IFDDYexqazb9SBGCl+HFcAYZy2hDMTlj+p8oKIIScQ3GaCUWAG7poqclFCQSU+umGxqsOSQ4A==
X-Received: by 2002:a05:6a20:94c6:b0:19e:8866:9e56 with SMTP id ht6-20020a056a2094c600b0019e88669e56mr10979990pzb.11.1708064795526;
        Thu, 15 Feb 2024 22:26:35 -0800 (PST)
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id h63-20020a638342000000b005d8b2f04eb7sm2387041pge.62.2024.02.15.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 22:26:35 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v4 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Fri, 16 Feb 2024 14:26:01 +0800
Message-ID: <20240216062559.247479-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCI Express Base Specification Revision 6.0, Section 5.5.4:
"If setting either or both of the enable bits for PCI-PM L1 PM Substates,
both ports must be configured as described in this section while in D0."

Add notes into pci_enable_link_state(_locked) for kernel-doc. Hope these
notify callers ensuring the devices in D0, if PCI-PM L1 PM Substates are
going to be enabled.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v3:
- Fix as readable comments

v4:
- The same

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7f1d674ff171..a39d2ee744cb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1416,6 +1416,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1432,6 +1435,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.43.2


