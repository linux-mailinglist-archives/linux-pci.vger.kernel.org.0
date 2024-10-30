Return-Path: <linux-pci+bounces-15588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447019B6197
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986DFB23012
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402B1EABC9;
	Wed, 30 Oct 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCdf/2E5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86E1E4928
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287707; cv=none; b=rQr9iTwXCDusLmH2iWMxrbg9vVtUC6wqrEhHm2a213AtIzoINls49g8LZnxMvIq8wZRVA96x4uspJtSDeF/g36Jq9+oEwJVaFu/1/nkDF1ImBc+iOjQLq0Dg07LojbZtOsWJuXiXmq3pAGd5FvsEAS0HID+khoXfsVuabcudX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287707; c=relaxed/simple;
	bh=sVXXOvwhjUtLTRw/diUu9Q79ppS0cnZqeXoEIt69lpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZobJmqo0OHOpqv696fMWhn2qcYzsa7XX51JyyIqHdppqAWOgPmaQWWikI9WMxuSaIme2Quz+bfs3YTK/ld5eZUQL4jfhSBTnaptUW3dFw8lL3dKd2UmBXEJabAjs+yPEI8YtM/PBIfXxPOg+AE27MrcbZuXlv9U36XUg3jUy10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCdf/2E5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcVaObSC/M1H9Whyn9Sm9wUdy5PG5I9wFKqHVmMGOas=;
	b=cCdf/2E5c0LtngjaLCn8QmG/SzIrJdqiBl5fC6KKONcGeooj0rrEdEcAHjIhzg9TiucNGJ
	iioQNRahrsRCMOy9x7N0M40B62OKrJHEiM4wM2xKhs0i/ed9RwMAOEadlfPI2VlHWV2ujj
	9d4499aM7IeD9Fgo5uxr+JtobMPRjPw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-P5XJE0WSN06mZukgngzvaw-1; Wed, 30 Oct 2024 07:28:22 -0400
X-MC-Unique: P5XJE0WSN06mZukgngzvaw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a2ccb77ceso449096666b.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 04:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287701; x=1730892501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcVaObSC/M1H9Whyn9Sm9wUdy5PG5I9wFKqHVmMGOas=;
        b=JjI74UUCsIQiKlxFPTHOQZmrVZwh1lpN230MhOAdbNKKRvZVje87Ev8q8Cwklprow7
         uyvwwbf7Ox3kDWzxL8wIVaWzhZ0Iu8kc2XeimHPqHScGmNleGd3wKmEKFXq0jfNh4ho8
         lT2qVbdyv+yKCkIXzcxJKRvejlKhMjnDWH1+ekWBkntWfvOae7TeK1x30/tQXJMHjFC8
         E7V9uEixVtUxriGNFHBxUHbOalYvcCpyn4KdPZ18uw22nDgKTD3cy2/dcn7CYVq+H2Hw
         5jxVjbrpc9ynIEJ203HMd/K1q0TJJWbev9mu6s7gAVn/8v8YmfI1TWhL/wG5qM9Nc+Xf
         V6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsGaHlNtNIZeIdrbBnU3slZlKOn2pDDSDh7owJhQFliewnbc3NMvA3Li/fhPjinorkwDxwt/mb5Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38GQebsLy65u9uScddZ1at+0vBXnbWJN61K1fXCaYG6ouHLe5
	/qrIhHKwKWBG41jBzRCebA8t951nxgklAxVBs18Gg1b/lPFFNOgVUWCHeWAptLJo03UdSzo6fn0
	/LPbqZzK4pidcVRgegZUi/jSl4VzzHaxT+GEbR9GjHqs03wYyy3bJ2FPjhQ==
X-Received: by 2002:a17:907:96a9:b0:a9a:a88a:466c with SMTP id a640c23a62f3a-a9de632e59emr1415761766b.61.1730287700876;
        Wed, 30 Oct 2024 04:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGudVnW4el0kwXnwPwEMeL2fjTQivAxmW2c9/C8Z0/IVDdT8lY+OqbI5Fm1jj0o+gAHD8cpew==
X-Received: by 2002:a17:907:96a9:b0:a9a:a88a:466c with SMTP id a640c23a62f3a-a9de632e59emr1415754866b.61.1730287700250;
        Wed, 30 Oct 2024 04:28:20 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:19 -0700 (PDT)
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
Subject: [PATCH v6 04/10] crypto: marvell - replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:37 +0100
Message-ID: <20241030112743.104395-5-pstanner@redhat.com>
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
Acked-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 14 +++++++++-----
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 400e36d9908f..94d0e73e42de 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -739,18 +739,22 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 		dev_err(dev, "Unable to get usable DMA configuration\n");
 		goto clear_drvdata;
 	}
-	/* Map PF's configuration registers */
-	err = pcim_iomap_regions_request_all(pdev, 1 << PCI_PF_REG_BAR_NUM,
-					     OTX2_CPT_DRV_NAME);
+	err = pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
 	if (err) {
-		dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
+		dev_err(dev, "Couldn't request PCI resources 0x%x\n", err);
 		goto clear_drvdata;
 	}
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, cptpf);
 	cptpf->pdev = pdev;
 
-	cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
+	/* Map PF's configuration registers */
+	cptpf->reg_base = pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
+	if (!cptpf->reg_base) {
+		err = -ENOMEM;
+		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", err);
+		goto clear_drvdata;
+	}
 
 	/* Check if AF driver is up, otherwise defer probe */
 	err = cpt_is_pf_usable(cptpf);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 527d34cc258b..d0b6ee901f62 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -358,9 +358,8 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 		dev_err(dev, "Unable to get usable DMA configuration\n");
 		goto clear_drvdata;
 	}
-	/* Map VF's configuration registers */
-	ret = pcim_iomap_regions_request_all(pdev, 1 << PCI_PF_REG_BAR_NUM,
-					     OTX2_CPTVF_DRV_NAME);
+
+	ret = pcim_request_all_regions(pdev, OTX2_CPTVF_DRV_NAME);
 	if (ret) {
 		dev_err(dev, "Couldn't get PCI resources 0x%x\n", ret);
 		goto clear_drvdata;
@@ -369,7 +368,13 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, cptvf);
 	cptvf->pdev = pdev;
 
-	cptvf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
+	/* Map VF's configuration registers */
+	cptvf->reg_base = pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
+	if (!cptvf->reg_base) {
+		ret = -ENOMEM;
+		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", ret);
+		goto clear_drvdata;
+	}
 
 	otx2_cpt_set_hw_caps(pdev, &cptvf->cap_flag);
 
-- 
2.47.0


