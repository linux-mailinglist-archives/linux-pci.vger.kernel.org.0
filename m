Return-Path: <linux-pci+bounces-11285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2389476DA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09001C210D1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069A158D9F;
	Mon,  5 Aug 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lpgiwlw6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F414E2F5
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844951; cv=none; b=A2zcznYjwZJThp97rQI/3GAgpPi5sBTudVebLDqBml0d1pZbTNqW7qHjd0DgbLcwH5E+gVW/uh4/4DD+hlae2NYYFi6INzJM4yc1n+GlIps4GE+Rmf9QptiPMjBfpZ9RI0s1gcASR0Q7y6hbQUPsC6uR0mwx6eBSbTfShQ6jFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844951; c=relaxed/simple;
	bh=eDX/oUhvMuTvOdEU35gML3pMZ3bHnmTWwtIB4yn4vRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+GDGzVm2+bwdXBulOhCMuoUFZ+SxmM6xI8jDqYYc75uGsANNcXMTVjwZ8OlKLMv6RU4konU+yl865o0kt6WgV3PDO/ZB6Od1kCGnOUevINB/r1L75tfSjfrt1JUs3vuQpieBmNvVmLA4LsR/H2R9TO4BZbLnctx/02sqajRws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lpgiwlw6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6elIcVAva6IdGos3xrpBxA061GwStf3eghsSoUI+FxU=;
	b=Lpgiwlw6Yzni8oZdZsXAJZKU51WMQbOAlS0RMvSm3eAgKu8INGw4B48EtTu0AfsmrIvM+R
	vRVytD+85GTW9hYl3mYN3N9K8YTN2yZsSn6Ww6K84evLqyW4mV49WzMiVhiAtN10dvFmba
	RNpimBuZ7P8vG8bJLgSXudsQycPz5iw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-oF_ffyHsO9GLYWpvAf9X6A-1; Mon, 05 Aug 2024 04:02:22 -0400
X-MC-Unique: oF_ffyHsO9GLYWpvAf9X6A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77cd5611c5so79468066b.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 01:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844941; x=1723449741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6elIcVAva6IdGos3xrpBxA061GwStf3eghsSoUI+FxU=;
        b=OjUgo40k+5t8O43quJteqI0sIKymEw8i4Q4p2uALfvx4wQQlmKB/gLiLaO7ubu5Apt
         ZoMiyF1/Xw9pFqY8AxJcfjiD+lSX9FXzkwqpmoGPC60ygqWQjcNpGVMnGVYAay6pjURB
         hiXkTJmWNlRDeF4gXVH3aDVoJpPlAQ3IoFw1vwZaaxncke2rROvLQbULRICoUCkkkSDj
         O/yUIuYkA4KiuwUzqstytTLs8UkC2b+nYaibndtApLQRr8gfsd3IJ5hl0N80g5AKe0M8
         ETWjTSoLvLr/kXyfacRGgSe2u9iJ790xHxXxPLcws2kPcXwtR4S3yKXPIXrcn2zkAzhP
         48jw==
X-Forwarded-Encrypted: i=1; AJvYcCXhtnSdQ2RFcor7joIMcQ28/wDy6BInG9/c4GyQEQsiLqcm/kfjEeIzatihZnKOTDrjECfGTTOXu8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjAZN9ehq2BZNt9lJSflwpX13oljSVxbCTmslICgOLMyIZynm
	mgERbORu4fjm2MR3ENst+saDQCujOHcGDkuNEN8GLW2BErn8AMDytKMf86WDuYQuwtZbiMOChLx
	LsjlFDBSo3eb728oiLaZ2aKdD2N9WGTXMHNeM1w6Q4HiU1/4bpHCv0Cio4A==
X-Received: by 2002:a17:906:bc0b:b0:a7a:9a78:4b5e with SMTP id a640c23a62f3a-a7dc50ff341mr387930066b.8.1722844941107;
        Mon, 05 Aug 2024 01:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkK5Lt7n9jXqXSSRLA1PwUtBlM1U1xQiwgfbtLyFZ2DIUDAUIZgCzu48VuDRqWx5Z3WdARVA==
X-Received: by 2002:a17:906:bc0b:b0:a7a:9a78:4b5e with SMTP id a640c23a62f3a-a7dc50ff341mr387928066b.8.1722844940701;
        Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
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
	linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 09/10] ALSA: korg1212: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:36 +0200
Message-ID: <20240805080150.9739-11-pstanner@redhat.com>
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/korg1212/korg1212.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 5c2cac201a28..b5428ac34d3b 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2106,7 +2106,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
         for (i=0; i<kAudioChannels; i++)
                 korg1212->volumePhase[i] = 0;
 
-	err = pcim_iomap_regions_request_all(pci, 1 << 0, "korg1212");
+	err = pcim_request_all_regions(pci, "korg1212");
 	if (err < 0)
 		return err;
 
@@ -2128,7 +2128,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
 		   korg1212->iomem2, iomem2_size,
 		   stateName[korg1212->cardState]);
 
-	korg1212->iobase = pcim_iomap_table(pci)[0];
+	korg1212->iobase = pcim_iomap(pci, 0, 0);
+	if (!korg1212->iobase)
+		return -ENOMEM;
 
 	err = devm_request_irq(&pci->dev, pci->irq, snd_korg1212_interrupt,
                           IRQF_SHARED,
-- 
2.45.2


