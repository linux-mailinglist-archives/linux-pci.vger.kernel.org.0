Return-Path: <linux-pci+bounces-15589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203F9B619C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302642829AE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568EE1EBA02;
	Wed, 30 Oct 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKrs7Mau"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC91E5738
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287709; cv=none; b=IorWiY15NpnyEYlcEZRqQojnrFcHVUpGogRsp1sERFGjmYFSuUGnaTcL/lt/DcnSg2tFAGBLFS6igssWZR6niuEmalJRWASsxD+iO92Xy0+w+E2vM+jba2cQ+gSrRPjpqTT5KihukayedlJHFNt0me2OgLzX7hXGgrjvOXq2VzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287709; c=relaxed/simple;
	bh=J3pG/0Gfw8HnALwZ/Br+hrSE4pEfpHhtl4LqImtqkrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzvVmoWQLO0WraWLVBhho1Gk3DJikBF3R9IuExMEMXbMKA6iYmmOuLgzwDHOenDDwmUihdmEwcwYeOufcl8mJ0KQAaem1/+nY+SWGt5hH3oevqqQHKkSRp4wvbn9SqpSsAlMLUYXSWxcGw0AAOnpWc5PpE+4D/vNCxk8fOWKThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKrs7Mau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLUy2S875DNBeHIOQOxEOE4p7AHnezc+a90RKtjms08=;
	b=KKrs7MauxxeEQPIHrZFTN+YXZxZK4LG068geFRPfZ0i3WMOIO9BYErrV+cXSwW86bGk85b
	tkX4aUfoAIzAuEqKn1LwByHoOQh4vK6Tpau57zppYS7lsS41NNWNNYsBsC2dSzoHWMPBa1
	RLmmbLwM640XqQ9xAk/FYMl3SQbiM+U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-Ur2qVSQdPHSl9UAPuYhU8w-1; Wed, 30 Oct 2024 07:28:24 -0400
X-MC-Unique: Ur2qVSQdPHSl9UAPuYhU8w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso135465666b.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 04:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287703; x=1730892503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLUy2S875DNBeHIOQOxEOE4p7AHnezc+a90RKtjms08=;
        b=rDsMvWI66naJoVkQBvobo6BtPMbxZv8KYjCdAz85M3og6BuWCdYD2DXzEVg5dM6sEm
         rJ3M/pnaHP3yFKL02e4lN/X0XH81MCrbdJofEYUEprSrGpwnxhww+e0BpaHIlT+ovg/3
         dbuc3NJpg8QBqTLcaIv3rI/7a9HDLd4t9GzAT6j1KhUlC3aj8WwXsAi+BPLCZd3sjDWm
         zNL6pKmGQ/5BEjWRTiEa+oUP05ifHazKzTR17vdsetML8QhQ4vk5V7cQRrj9N4siyah9
         QgcwrO0+22vDQOxL7khH0/sFNy1SrFNW76CcpYPDh+YjhE98etMMzsswg/75KazFTD6y
         DouA==
X-Forwarded-Encrypted: i=1; AJvYcCUUe8+EiuZs9UK9YOFf9K9XCQi7t0KiHNTku2GJKySOch+7UAvr2iBPrAc/Lz99O7qwO0nuLJPMrmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvCHHfazebwvc9oMlVvgiKF82hiOpL/vMZ1ZIwlRCH2tMvxGz
	X/mgE/KpgViWde8CLY5jTk1jfiBs60U8a0CBFA3/2YTB4kSOT++P4uN/F0nNTnP8qc7m0ghYNyE
	3ufn8cPmQavnFf0RyeVW1jkZMfTbWloOvm9V/AwxxGDHa0lHADvMOjJBEng==
X-Received: by 2002:a17:907:3a95:b0:a9e:3af1:eb1b with SMTP id a640c23a62f3a-a9e3af1ebbcmr190405266b.38.1730287702750;
        Wed, 30 Oct 2024 04:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFToQp/dfLAgkkWdoKZY9+BkNjMsRPPHY3dBsz+y7GusLq7PV1rFcL96Aa7HB79+WgO83hbWg==
X-Received: by 2002:a17:907:3a95:b0:a9e:3af1:eb1b with SMTP id a640c23a62f3a-a9e3af1ebbcmr190399766b.38.1730287702314;
        Wed, 30 Oct 2024 04:28:22 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:21 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v6 05/10] intel_th: pci: Replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:38 +0100
Message-ID: <20241030112743.104395-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0d7b9839e5b6..e9d8d28e055f 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -23,7 +23,6 @@ enum {
 	TH_PCI_RTIT_BAR		= 4,
 };
 
-#define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
 
 #define PCI_REG_NPKDSC	0x80
 #define NPKDSC_TSACT	BIT(5)
@@ -83,10 +82,16 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions_request_all(pdev, BAR_MASK, DRIVER_NAME);
+	err = pcim_request_all_regions(pdev, DRIVER_NAME);
 	if (err)
 		return err;
 
+	if (!pcim_iomap(pdev, TH_PCI_CONFIG_BAR, 0))
+		return -ENOMEM;
+
+	if (!pcim_iomap(pdev, TH_PCI_STH_SW_BAR, 0))
+		return -ENOMEM;
+
 	if (pdev->resource[TH_PCI_RTIT_BAR].start) {
 		resource[TH_MMIO_RTIT] = pdev->resource[TH_PCI_RTIT_BAR];
 		r++;
-- 
2.47.0


