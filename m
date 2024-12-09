Return-Path: <linux-pci+bounces-17936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4669E95FF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C587B2815C1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE04233D81;
	Mon,  9 Dec 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFkY59K+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E7230D3B
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749625; cv=none; b=ima9D/BhtMEfMwbYAIa9DbUQETBdxeARMFPEb/3FFTXqxfJ3qkDHHGrxkPXYyk0JNwGBbbXHqFsxNwHClomC/U2wRYNbLBsfFDXppESBVKoRsIeOqaV2DsxYGB8YYYg/Zfcghpla8jvqZGf2s/sXgyLpKEwQvXHTo7XV4OVpP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749625; c=relaxed/simple;
	bh=0TEaieIECTc3OVhk8DBvWvo0jSHs3A2Aqh2fvN636xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dort1mp4YI768Emi1fpXXsVOo4CdUY24Mfqm1ztcJwZoHbPdfIIJQj2JM49OE//FWXlrh48kjNPcd9wksndpkRLeSn4cqHOzclA3Ov0Q+Yz9H/Pcpd7kYNSgr+r3kySNTCTrwtjwf38DJPDd89qwLxUfoJBIEnRq+xLkg2e6qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFkY59K+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6O49TnPkNeMtIPoWkV2XdJjg3ziNzZQ3FlPq3drZuU=;
	b=TFkY59K+0YI6oq2tdTrR/JKZAyzRPZrCVX4vUguTgB6YNx1kmrcZN2aO5GaXC1Op7U2mA1
	rpNIDG9cGgs194xg10ZamDxlALJBAySu42OGaBRFRjX6BuLASD2UAIg5kpOYVx71/cP6iP
	P1isAdQPpt95N/h7g8WLRQBbBUGAi3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-CYL3hc9bNl6fYqeNRppKNQ-1; Mon, 09 Dec 2024 08:07:01 -0500
X-MC-Unique: CYL3hc9bNl6fYqeNRppKNQ-1
X-Mimecast-MFC-AGG-ID: CYL3hc9bNl6fYqeNRppKNQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e9c69929so784111f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 05:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749620; x=1734354420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6O49TnPkNeMtIPoWkV2XdJjg3ziNzZQ3FlPq3drZuU=;
        b=rQG4ZvOfVZ2edikP7fMemp0PYv5rTcQoMwrjqzXZu9IALXyVMg03pQEl5EW8kHKqu7
         Odg7Ql3aykUbzdTIpy299aGsxrnwj0q2fH+n4DNZB5E8crHf/L0IAulJn2IOmjdosbhO
         J1RUTiHd3+es4obFTaMsOGlBbuDuKDIzkbgM9qfEwg9ezP5tQX3YC1M6srXQIIqRa12s
         V1KVlZUxHS2YEn6OzcatBqb14brntOnEh+fpg/kiIyvavb5wEIom6+drra6AIPiu6Tb/
         eC4NUsHdPF5LyQwBoF3lPg6SCF2hLdLpliNBpKrp3zhJ+eNYfuIs4p2tG6gwtvpGlafG
         jrmw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6lvPbVpuHW+EOZ8oE6LrhPwoMWBDvNHOP+nKrSSxcCiazBqgbQcs/1Bn1/aPnk9gZl5wBb59bCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpk2y2JzwdqcH6PrLt/2lBwYyje+bTcDTTZ58dkJve8mb0Mwkr
	MxFCOmQpHeWzl+qm4IXNCoaKPNzEda9RMWX9+8uSS2s4MIURMDYp9FlH1jq6UlR8uozxh7QIaDA
	UVRyBIxDOg7bOp8+TiJJKk3FmmAcUsDULEX1ZYW4gh9HQ9GSyV23uITV34w==
X-Gm-Gg: ASbGncuGuIsxpqC01DZNzHwm6nv696ghpP2pKz+h4YpHL25R72dw8WWMIFPr2LiC+N4
	1V31hgudJa6JaYPr5d8Av8X8V36ijS/stvME5QncnYI+gQCjLVdOOSXY7rlgULoKy+R3zWZ5qY6
	aIUqxB5XsBA7312fA5qcg62iFyQER6+GTLfx/Eh84bCUABlKqWXRKmMQ1HASTkegU8g9HQzsALf
	KRk7iA12P6zK2+o1lZv8yQImTSPL8p51MMCmKnI4Q37KfXyt90+Ae+Sg7Icybue2upCD4p2AX1Y
	UMRC8DOR
X-Received: by 2002:a05:6000:481d:b0:386:1cd3:8a05 with SMTP id ffacd0b85a97d-38645402350mr183791f8f.54.1733749619731;
        Mon, 09 Dec 2024 05:06:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtkNHnOC202GyBKEBPTwiG4UTLfJs2pkouVC4IktFgJYuC2xwE//LEhilVtJ79VvBlgBAiYw==
X-Received: by 2002:a05:6000:481d:b0:386:1cd3:8a05 with SMTP id ffacd0b85a97d-38645402350mr183738f8f.54.1733749619256;
        Mon, 09 Dec 2024 05:06:59 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:58 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
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
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
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
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 06/11] vfio/pci: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:28 +0100
Message-ID: <20241209130632.132074-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
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

vfio enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vfio/pci/vfio_pci_core.c  |  2 +-
 drivers/vfio/pci/vfio_pci_intrs.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1ab58da9f38a..90240c8d51aa 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -498,7 +498,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		if (vfio_pci_nointx(pdev)) {
 			pci_info(pdev, "Masking broken INTx support\n");
 			vdev->nointx = true;
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 		} else
 			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
 	}
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 8382c5834335..40abb0b937a2 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -118,7 +118,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	 */
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 		goto out_unlock;
 	}
 
@@ -132,7 +132,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 		 * mask, not just when something is pending.
 		 */
 		if (vdev->pci_2_3)
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 		else
 			disable_irq_nosync(pdev->irq);
 
@@ -178,7 +178,7 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	 */
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
-			pci_intx(pdev, 1);
+			pci_intx_unmanaged(pdev, 1);
 		goto out_unlock;
 	}
 
@@ -296,7 +296,7 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 	 */
 	ctx->masked = vdev->virq_disabled;
 	if (vdev->pci_2_3) {
-		pci_intx(pdev, !ctx->masked);
+		pci_intx_unmanaged(pdev, !ctx->masked);
 		irqflags = IRQF_SHARED;
 	} else {
 		irqflags = ctx->masked ? IRQF_NO_AUTOEN : 0;
@@ -569,7 +569,7 @@ static void vfio_msi_disable(struct vfio_pci_core_device *vdev, bool msix)
 	 * via their shutdown paths.  Restore for NoINTx devices.
 	 */
 	if (vdev->nointx)
-		pci_intx(pdev, 0);
+		pci_intx_unmanaged(pdev, 0);
 
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 }
-- 
2.47.1


