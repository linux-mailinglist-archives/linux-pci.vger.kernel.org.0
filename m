Return-Path: <linux-pci+bounces-11280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB029476B1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FB62819F7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61947155A3C;
	Mon,  5 Aug 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOHj6gTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93478155346
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844939; cv=none; b=WQD2LS5r1z3VPlpHw/jP/IaOJlXD0Js4UPT//FJ+i3B9Q07dpedB9sVRP9i4dpDb36CElDOUmp3i5QEhBXJ92/xX4fqzosn0zxVciMurhnRECwFVvSlxCeb5bnKWvlvWApSDe0OIkIbyxW3+OIpFsD4QV9MU0/LC5MVnFZvooXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844939; c=relaxed/simple;
	bh=T/Lr5R3ZpRsNgk4LNzf4i3JOmIq6wzNv8zvkRdHooAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZPgT8GVS8QdqC62/nwixPY9A2g/gCdJ7XRxksiEIR10TFdHWHr4adPv/IvWskDP33X52rdjF82YG3hCshbVDgx9dpqYp1JIK+Q7S5Z0rXnSIc8nDVaDyojP24AT2AQKD7m06RWElUQPZjnpW5195D71Ng2cKSGUOH76wHJizaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOHj6gTS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIcu667vSRZRiKEHakO3GAIgbzPtgHQvNS3his8mZEo=;
	b=JOHj6gTSxw2RHUI3fLDTy2KoN14j6gEqkXxo/Y/jmfl7g40YvTc108L7xM7vteXDGjF2uA
	pJ291aZvBDpMd6NqVgFhkyS3hTsnJnTIk5+zvZ4/Dfr8KPB9LW3k4b3vwSuTD0v5igK4Qz
	+tbzWQ6tV82P+XkTaWdx+jEuPcOIAuQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-rWh-NxzEO66d3_vqPiPZ5w-1; Mon, 05 Aug 2024 04:02:15 -0400
X-MC-Unique: rWh-NxzEO66d3_vqPiPZ5w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52f028a33aaso1063484e87.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 01:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844934; x=1723449734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIcu667vSRZRiKEHakO3GAIgbzPtgHQvNS3his8mZEo=;
        b=FVuMUDwcYuv/gUqTar7lzfteTlYTPdts21Etv+AE4UecT+l2MtRVgdvk8/B4c9Kcs8
         Dd3uoZfi8nEiGIx5SVGk85SKrtvkig/xFJUlHXsNncqwWwNrwFkGOKfvUUC37dl/iYaH
         1q34KMak8pNBMPnbq5PvochynfPx2QsRJT04GQCDshb9Fp8bI7ErcqWDeTaijRkBMYwT
         gW1ojPXGEUNnBlDR2Y0ik8R1dgzb7mzuXSXniFxrgUPrzRZvbCqJoe/44NOKBNa5tZ55
         pffTvFXqXfMpQ5qEt8jiIGz4VV2guAEDd+p+t+xfOqYZymF54q38mTEKd0KMjG8dJ/af
         l77Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMMLkNwlHN88tRhOm8gNMrsjRcd8upzoXXPjclRNdvKWX8ChDSXvqk0ayMUe+go039ZFWHJrr8xZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WHnQVVn0O8RyS7qmscQv43nxfM/H2Df+e+lhxU1GXJ3fO4Kj
	l0C8mXblOCIdHDbMiY/nIXX0pkPhozC/UKzyNkhU4JPb/lT0avFUm7FVYSwYr9aXJjR14bxXK7A
	+y82PEMPO0WD3HwkUWXcAFG9qsJynenIxYNJz47/a+7k4VsijWUDEmmkOIA==
X-Received: by 2002:a05:6512:1307:b0:52e:ccf5:7c3e with SMTP id 2adb3069b0e04-530bb3bd143mr3696389e87.7.1722844933755;
        Mon, 05 Aug 2024 01:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwcaUohyPPqlQalc7Ds7xBVbw16Nwe2cO8DiX+lGZ7pO2pVwTP2h5T41+23RRZFgk9XX2iTg==
X-Received: by 2002:a05:6512:1307:b0:52e:ccf5:7c3e with SMTP id 2adb3069b0e04-530bb3bd143mr3696318e87.7.1722844932669;
        Mon, 05 Aug 2024 01:02:12 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:12 -0700 (PDT)
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
	Serge Semin <fancer.lancer@gmail.com>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
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
Subject: [PATCH v2 05/10] intel_th: pci: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:32 +0200
Message-ID: <20240805080150.9739-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805080150.9739-2-pstanner@redhat.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
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
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
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
2.45.2


