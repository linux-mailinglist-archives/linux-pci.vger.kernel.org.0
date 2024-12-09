Return-Path: <linux-pci+bounces-17932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665939E9608
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC1D1889C6F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BEA22F3B8;
	Mon,  9 Dec 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5Njczhi"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219722E403
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749617; cv=none; b=WqszB8Zz9mq8M58qj4Ip9Yt846o5N8DgoiiSh+ILFIkkyFori8Kvhl92NMB5/nOTXIFKQEzjLC/yEmMgaEmLF0c3SHPCR1UTOr6uyB+E2aKIIgAVOiEauF1KxAB4BK6ozmNfoatdcBsGFOa0YaHKVeRGYvJtdOrb2oLoL404iZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749617; c=relaxed/simple;
	bh=lb7GonT3+ZCBn5vd8Htudn5MDz8T66fffMcfmzxL9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVCIT+7dGXDKLtgL8BpXdW/9MJrXUKripV/YRlaq7v2jC6aPldHH0DZKsDdifZEGJWZmBVsXcAVvg4AYsy3eQhct3zLm73JEMY7FfeB4WylAeQD6naiSWv8M6O1Iy+km1wB64Jn0P7OQ5TYppeO56GcKVb4APodIEIXC+vAyZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5Njczhi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
	b=h5Njczhizrv+D0H+RvkoG7u8bWVdiuF1wzQ33g/UdE0EPsc0uMUJBr0Z2VnAZAL60tScfS
	Ch3FERY7n0AU4qRpEgTWX6uur6RcORSDCX1HNp0O6OM6i6SwFfOm34SiIM/+Z9dmOsfHRq
	u8Nr5WEnqSCUJDOw+cm0Um+KJBv8JBg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Gi7cRjiNPf-EI9OSOgTN1A-1; Mon, 09 Dec 2024 08:06:52 -0500
X-MC-Unique: Gi7cRjiNPf-EI9OSOgTN1A-1
X-Mimecast-MFC-AGG-ID: Gi7cRjiNPf-EI9OSOgTN1A
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385ded5e92aso1674230f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 05:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749611; x=1734354411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
        b=JRH7Md0PdQLvgktkDpfy9r/QSE7cKp/pe+ako7FMHPO6PbTZNWyine5jX2AMAF0JPM
         bybyY7lKyKE4RZI9Rg24j6zdWQKALCqpLu8sIUhyfJ+JFGHHwmtV0yPF1jvUiugXuSXd
         nDzNy1z0rUKv5SrDw4QyVW75r49j/Np86Czv/Y7GCzXA8KSsJhQaB9X2B8om/D7hNRCd
         7uiSnCTgmTlInhul7DF+bxHyyzse+w0Fmi+6J4jLy9abbcn05Lg13P+I12n14qrsmF+L
         ekvAntZxNvVpmr1rriuFeMkwf9tWzwY1ILsYYW+f+os7hUCep02m5dxEVfAkJFMvFMbr
         aEEA==
X-Forwarded-Encrypted: i=1; AJvYcCUaDMCjxQDpDA7L2PMtJT4nkHnIHBhYjvVOJ01tmeGFJ2ojPD4iBXngKYfNIYsVv2wLUA8t8duE5SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyls0C70XhROai6fHAiuSaVXgBHCFu1qOzJN7OmCuQeX1aLj7w3
	/6BrV5KU92DiBzx2VTQFFwI+ITqSI4JmBcXNExMnHvaACev5+PRc+6wm2r3oer8qDjgzY4uVH4Q
	6yq77FO5YPFYibk5MhJmdQpmUG8Gt1XTLX6dOumfj7+LfK9jkZqDjhhMRPw==
X-Gm-Gg: ASbGncvijs8xHyezAPK76npro9wQg55teRxnJZ+CL2TRKciTbqQoH/cp+7W4HFeh9eH
	pRRIPFzDm+y/CpOnHrgm8HvwO6/ZOV4kNbiHbb6ribZrkssTdBgx0NeJXl1a6FW5rzOa2OUeCJd
	TLrYp1/C1AcI42BB2M+BvzWhfAJ/5s+yoHIBgqdeW1A4Yk6KcoGinD/io1COg5uI6vd7LJ0a4KJ
	hlZ0QY/4JW9LKWFLv+/4E3QVDtTr4Qe6k09VLX+dbwjqAklXnAk7hSVgRDKzoRwXJe+hGb0FefI
	gDUrLiVt
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224947f8f.47.1733749611251;
        Mon, 09 Dec 2024 05:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYLGzMuES8pL8UNwc6rduiHNSssmgKFMI0arqDxmQvwrHwV9r5BJKNGyDbmmGP7hHm3hITRA==
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224791f8f.47.1733749609723;
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
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
Subject: [PATCH v3 02/11] drivers/xen: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:24 +0100
Message-ID: <20241209130632.132074-4-pstanner@redhat.com>
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

xen enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-pciback/conf_space_header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index fc0332645966..8d26d64232e8 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -106,7 +106,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 
 	if (dev_data && dev_data->allow_interrupt_control &&
 	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
-		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
+		pci_intx_unmanaged(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.47.1


