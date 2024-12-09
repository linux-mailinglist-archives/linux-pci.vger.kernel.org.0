Return-Path: <linux-pci+bounces-17934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E249E961D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A19167B4D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71B230D3C;
	Mon,  9 Dec 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVmZoDxx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AF2309BB
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749620; cv=none; b=UqBPmOxLT/RwrkfBPTI1V3Q0znK1LpPmF0bYePnRSGeARWws/iGb2XoDRWMqANMCUhcAA1RFuCScliQcTLgqPRIrdw+hjn6U4TXokvhxvUGHtDpyYsBawglrcCkxhCXSD13CdKnVLsk2cLvy2/HNa1EVeKsI6E509Afhee1zjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749620; c=relaxed/simple;
	bh=MrbDrpIsvZ1dKVLDYervP0Vycy2eBw/58VpDKwA2pz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOGwBVX0QUK2qqz7zXBvjSgn90rhPVa9PpOZaCdN7shhf+VhGtyWncXd804q7E8SnzJ2RRS9P3UbbedG4G9VsojLGEsDI4LXakcgL5AdI6qN1gGtH8Qnzpru/ryQsKRu1XIPgZAq3GjfAnHHiDDvi/Qjg2uUGfFsaXDscwD3Sj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVmZoDxx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVrHbQL/WtPUoVmg5iNOH6KPahEUlaDR0JYKoVLlaPE=;
	b=CVmZoDxxLkgeW2Xciu8YccLjLIIODkY5hN3b++wZztr2oYUDtwpiP3rmyXK1keATkbZRK9
	hR1Ih2Rw/k+cVNxmATkBgwXdJ+b1CsO7pW3KGJ61naC4LTIcpIhsv0z0oWPw93QYIHppC/
	73KFpcf316eXHcjgUB3CLbhxqNcREkM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Be-1S1smMsa5KG8wc9sYZg-1; Mon, 09 Dec 2024 08:06:57 -0500
X-MC-Unique: Be-1S1smMsa5KG8wc9sYZg-1
X-Mimecast-MFC-AGG-ID: Be-1S1smMsa5KG8wc9sYZg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f47b0512so8002075e9.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 05:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749615; x=1734354415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVrHbQL/WtPUoVmg5iNOH6KPahEUlaDR0JYKoVLlaPE=;
        b=tV/58kzSvZLsSknlxIdVxiQp6MaA33hCxLmRqVHn3f4fxrQT9mqetnUbSN0ZzB/Fj7
         TQhWhcUU5oE3l/sRZZq0nyWFkr7rGE5zJjQ+PMB2GIlXGMl3kPHdyKkx9wutIm+tRqgG
         rXRrXmawVqwR0JGi0Vo89R9cEt34yPdrnZOd3Sbyj+pgyCfH3ad3I/LAP8Nf9M8l6nqm
         gjl/vjU8FePm/WC9B6i//4Y6ycZhZae12U5DgKgnEyuJJ7ZmQN6splUWU7o1Dalm6+wF
         vL9eGLgArAN1d3tH2lDKITgDy0PNU775yV0IXWWXnDQQJNSLbCHCbyIZLp1HHcsYCKh7
         Adow==
X-Forwarded-Encrypted: i=1; AJvYcCUoNjzIaO6PAtBCHPmKaPq865OX/ZIEsVpz1EXcYUXTGH3o/VmrTw2NhSJ0sNzAi8yV+JojLZki4+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02xJWLeHnkRn23dIRyW9XcoFESPAwhw5FnUEJQrMAHvJoFqWO
	v6I5hAEMXKCoOyJ8bi1DTAa0moUBED3TzPaN6RecwoD7kxR5Qzmh8iltjo5ySpWo4sti1rnaSRY
	NKjyAcCiEr3640+nEVzOacnduUjCsPNim0vSp8p/7TIHqjutlJNCyqNLmXw==
X-Gm-Gg: ASbGnctMXgdf+lMcloqWz6YErLVY5+hsIPkYJVWq2HHbXq9SOQ/5VGENc6klv4kv6G1
	LqaH0GZBTuCQAPFpYrgHPISu4b1cfqIvs1azO+8ZnvIjihV2aA8Y8Gi9I6KiVLLPl88nexulCJL
	AyvOOMgZ5G2P36eJW+byr7H6eOYEt4X07IT23CGUaVbiZN+x7S7coX759HuSPEaYAA7xAHl4Q2s
	WjCYLhg3plFYtlBlubQcBCITnDHCEAll+G1vWUx1EyMqw56nbXsTUHiQWMWIuTnVPO3h43sAWVS
	Bzq5NgvC
X-Received: by 2002:a05:600c:3544:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434ddeade70mr103095375e9.2.1733749615456;
        Mon, 09 Dec 2024 05:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8dWBtsXMwPpsQh4FEW+o80sVo3gsVutdK8rZwCICXTNWn24DfDXUekpZhDfdomYwt5/+rkA==
X-Received: by 2002:a05:600c:3544:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434ddeade70mr103094435e9.2.1733749614932;
        Mon, 09 Dec 2024 05:06:54 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:54 -0800 (PST)
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
Subject: [PATCH v3 04/11] net/ntb: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:26 +0100
Message-ID: <20241209130632.132074-6-pstanner@redhat.com>
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

hw/amd and how/intel enable their PCI-Device with pci_enable_device().
Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> #for ntb_hw_amd.c
Acked-by: Dave Jiang <dave.jiang@intel.com> # for ntb_hw_gen1.c
---
 drivers/ntb/hw/amd/ntb_hw_amd.c    | 4 ++--
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..b146f170e839 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -791,7 +791,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 err_msi_enable:
 
 	/* Try to set up intx irq */
-	pci_intx(pdev, 1);
+	pci_intx_unmanaged(pdev, 1);
 
 	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
 			 "ndev_irq_isr", ndev);
@@ -831,7 +831,7 @@ static void ndev_deinit_isr(struct amd_ntb_dev *ndev)
 		if (pci_dev_msi_enabled(pdev))
 			pci_disable_msi(pdev);
 		else
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 	}
 }
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 079b8cd79785..9ad9d7fe227e 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -445,7 +445,7 @@ int ndev_init_isr(struct intel_ntb_dev *ndev,
 
 	/* Try to set up intx irq */
 
-	pci_intx(pdev, 1);
+	pci_intx_unmanaged(pdev, 1);
 
 	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
 			 "ndev_irq_isr", ndev);
-- 
2.47.1


