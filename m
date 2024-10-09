Return-Path: <linux-pci+bounces-14030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41D996328
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D089F1F23B9D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A818C33B;
	Wed,  9 Oct 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cETpSXlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F918C34D
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463030; cv=none; b=rmVlycD7Ci95JbVpCOj93ar4Gx2UHuT/1cUdP0SRFEJlmXH06ls9hByjVf5FSYoMw9nEngzRK/DgOHkMTxKIZ8e6PKJq0FtPfFf/NErgwBHa2PBNlq7A9vybud7R2jQe2QnSG2Nyo7zQkHLvaojhOhwF5PCrySK/aoldQz2Jrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463030; c=relaxed/simple;
	bh=dQ9VnjlSSpPEnGjxY8o7n3IH4X0Lh9+lty8CWlTOebE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUujpSW9QfTRRsLh5ADxN5YStClKvYLY52aZOjv2Z8kaGkn/2fTjENrKFJenyiMc0HFKVuK+vHlGE1fJd3GMFmFQ6g346BEpH2M1ezDEC5LDDoAckN9vzX9himsTN/qnwVCmlhhIKsExves4DXY+fKQQdUabccFjb2cSvslmkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cETpSXlC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728463028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNVTMVvkzsZ7hvF5EavB0JCPwkl/fF5os/K0NJtlfsw=;
	b=cETpSXlCff4S3t69JIO9kekoSicMk1gDeXJxVnYXrBEtLYTkf9oQGgGVG2/XxPYEd652NW
	n7hXYdsiJy4d48F30i9rUklHZj3bNaNW3H5iKIAaAktU/OccEPhwSqkPmQ+yqe8gu8YWvT
	PzvIhZetvSH/yhQAx9dNQjNYb2ssruw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-5CSrbSduNBaawcg2f9mk5g-1; Wed, 09 Oct 2024 04:37:07 -0400
X-MC-Unique: 5CSrbSduNBaawcg2f9mk5g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7aca86ee1bcso781711485a.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2024 01:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463026; x=1729067826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNVTMVvkzsZ7hvF5EavB0JCPwkl/fF5os/K0NJtlfsw=;
        b=RylNlckswf2qok6UbUY/aOotI4fsRG9tj1VFxX+pg2WnFXH16H94HuKgTHgl/i02X4
         QwpHljU+zdE3JOx/f1Un5Fw0Xia7di0+z7mUO+TaFW0eSwdNUADh9+j0XB06VqLfVjQV
         BMXsxoc9dMmN37D3nasMEMDjShH+0Vn+c24vRx/ZQejLwvLgWLoN3bVg3Zq04Xr2t1Am
         AbKyHQdhKnlINs4SeNhi91okUVx0g0z1y1xYm6Tryk2+VqFkSCJwBbvkU8z+/rO028s5
         bRtuPR5lnlWjF5oQUFoh1m/xx2WUo46covJXtAxj4v/M1aA947q7lhdBLF+aBeBAp1Q7
         9LDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVyw1CDY6dnVArP9WJdNTJTTGddbrvXHb4pFUdYH+CMZFnh9UNNUEW9Zrg2fqJlXanioxZHrCsiVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjYuMXY/jiCexCRyTCyIEpFiptApmhceVFp0rr+kPDnrjK6ew
	oB4SwfNvlWf+ez6iTdTyMUwYpxqEdSeqBxFfuxdOz3iJS2eTQlZKoYXYQ1ovEj/N/kXHxEHdRA1
	NL/vHqhvfi9Wslqcskpbrq6VAqDvPxC7Z+D8PoALh9dydFiaeJDvxrssOOw==
X-Received: by 2002:a05:620a:1786:b0:7a9:b9c6:ab4d with SMTP id af79cd13be357-7b0874b2e98mr203715085a.51.1728463026705;
        Wed, 09 Oct 2024 01:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3E0hV0KwQQvESOvv48X2ciqeB9+Uq53IkSsAgik+9QXi7ONASinXEowAITLecuVI2IQ519Q==
X-Received: by 2002:a05:620a:1786:b0:7a9:b9c6:ab4d with SMTP id af79cd13be357-7b0874b2e98mr203707485a.51.1728463026267;
        Wed, 09 Oct 2024 01:37:06 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm439643585a.14.2024.10.09.01.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:37:05 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
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
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH 03/13] drivers/xen: Use never-managed version of pci_intx()
Date: Wed,  9 Oct 2024 10:35:09 +0200
Message-ID: <20241009083519.10088-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009083519.10088-1-pstanner@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
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
2.46.1


