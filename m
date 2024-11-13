Return-Path: <linux-pci+bounces-16650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DDB9C6F9A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2161E28380F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3B20DD5A;
	Wed, 13 Nov 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn4CiGAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26773209F2D
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501777; cv=none; b=c3Akrpib/ikkyGS4TBRkt4sFiHGx8UgKIyRE3IP8c+5pIYwQP95pbM/unF3jAiR2mkedlQQvrcYShiz9Iv46ULzVGw0T2uykY9co5zwjdwRSLCUDJaaDqzfAbOWpVtIz7U0A/069ugqLuq+vd4bMVqCFfzkOvPeGgNtVxUlhFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501777; c=relaxed/simple;
	bh=aAbe7GmqFC4E4dG0vzWtJY0/IVRJ0ypsn5oCbly1PXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIM5qZQhp9BRGLcFmxtBFCbQVFTyjTJunyll0G0p5kBg5cB3aPsAJoJZ8xHWWD606w8QI/5Sj6v6pzJZJjDb01tF3Sr58xZHaUgagYozjsPJdUtEzm229gcJ/wmR7JlJNBxJCEeq4tVu9B+ji9lMoGS+NR2AdBMoIqcXlamR1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bn4CiGAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkAJx4kdHqc1uo2Ugvp3a9JlaC6teLxc6IU39omygl8=;
	b=Bn4CiGAxEvYGZ4SPJKKB88A9fcrHZ1GFKdgJBMMhp8280Wci16bl29skT64ZLHFKtfNK0B
	ZW+wNgZezGsr9abYNix44oenGO4YpUIyr67/WB7Z1k82gvuaeKLw6EgfiTgFev8wzFG+XJ
	8TaSt6jJ474WyzvCKwjRNllzkezg53Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Q6JCuLigO-Khkq1PAgS1Cg-1; Wed, 13 Nov 2024 07:42:54 -0500
X-MC-Unique: Q6JCuLigO-Khkq1PAgS1Cg-1
X-Mimecast-MFC-AGG-ID: Q6JCuLigO-Khkq1PAgS1Cg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314f023f55so50816145e9.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 04:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501773; x=1732106573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkAJx4kdHqc1uo2Ugvp3a9JlaC6teLxc6IU39omygl8=;
        b=Gk4IG0qplNH/s0DL/J/uM+744wEWyoHBr5p8D/kzSRVP/kKllivBZkwY6+j/HGOl1V
         pz9VBu4UvscVMjvwFwh1ciF7pC2jIITM2L2jD/MTOT+JGqIvdTFvEg7fsKKCzptrg8Kc
         OdrS3/otd9wiriVkq8DhWjdrwQR9SW3QMKI55tEVJN/QMHvTXcmYAW9ftKldgOh/ATuD
         WIjAQ3SORVCMFbEnN5ddRnwSm/tO0IGCVYjh0Oa0Ri2E3rLfF0OFXOtXL66Zqll5LBrL
         qqQfNTYVTdFyCZtrSeJ6ZlP9QgybwdWJ8vLSErl9OlMhlPC1wM0AILQMzsdF/J4a8kUg
         RJMA==
X-Forwarded-Encrypted: i=1; AJvYcCXtxiLOrcyfbKYmssTPRtbER2d4uOqNV2i6MRbk7FsU0v+F5evlqDY5M61ZlaT17FYB6FPQgVFsGYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/T7eRup9rRpPIV2XGUOJT+LIXbZ8hVMZ1n1yAiWQ/i2cnHLhv
	d37CdKSiYGCXQYqQCAGjvu5zZ7ja04T6pjMe02zgBqs+wJhKPMTvNnV7IXsVXEJEKmXXNqg7Hbv
	5u8F8i1y2KTobPa1t9gY0V2CAzF2U2LE0QQ0/33/dtP0oKujJb9vV2kh3eQ==
X-Received: by 2002:a05:6000:154d:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-381f18672b7mr16331789f8f.1.1731501773073;
        Wed, 13 Nov 2024 04:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPqy3tZYPqlqBkgyQss8AcuM2Gl+gY1MhPytnhmt1YoQ9bjJfa0GqSVyef5YXet7H2WA4PfQ==
X-Received: by 2002:a05:6000:154d:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-381f18672b7mr16331752f8f.1.1731501772675;
        Wed, 13 Nov 2024 04:42:52 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:52 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 10/11] HID: amd_sfh: Use always-managed version of pcim_intx()
Date: Wed, 13 Nov 2024 13:41:58 +0100
Message-ID: <20241113124158.22863-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113124158.22863-2-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

All users of amd_mp2_pci_remove(), where pci_intx() is used, call
pcim_enable_device(), which is why the driver needs the always-managed
version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 0c28ca349bcd..48cfd0c58241 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -122,7 +122,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 {
 	int rc;
 
-	pci_intx(privdata->pdev, true);
+	pcim_intx(privdata->pdev, true);
 
 	rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
 			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
@@ -248,7 +248,7 @@ static void amd_mp2_pci_remove(void *privdata)
 	struct amd_mp2_dev *mp2 = privdata;
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
-	pci_intx(mp2->pdev, false);
+	pcim_intx(mp2->pdev, false);
 	amd_sfh_clear_intr(mp2);
 }
 
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index db36d87d5634..ec9feb8e023b 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -289,7 +289,7 @@ static void amd_mp2_pci_remove(void *privdata)
 	sfh_deinit_emp2();
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
-	pci_intx(mp2->pdev, false);
+	pcim_intx(mp2->pdev, false);
 	amd_sfh_clear_intr(mp2);
 }
 
-- 
2.47.0


