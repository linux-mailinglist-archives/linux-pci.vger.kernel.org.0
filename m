Return-Path: <linux-pci+bounces-11277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F613947699
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317B51C20FDB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A515383B;
	Mon,  5 Aug 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ru29SQiW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695C150997
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844933; cv=none; b=BUdd/aOXew4y5APnFGNmaHJCPr0LIifpDeE8/gTKJoGK5CHDxdS/yBCCJ33CQ5GAl3QxXWVK/s02aZ8BmiztopyHvbEmkJdNrvB2Ige3r/z3A1U2AmiZRlHGW3yUp61x47EgVfefRfiQHGKdyff5P78ODU6E7VFVdrAdZtBFXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844933; c=relaxed/simple;
	bh=PMvC17bGpWpI73UNcLQbu72jMyBfAq60m2YMRm7gpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNSAPHr7eolD+GyvJ2PMXWcybtZbNvQsHZRF4Mtx3xd2Mqa84eI8gLRc6vzh1vXnKTxOjvbCWHJ4L1d9i818SDvw0y+hEG5naeVe6TAa+sSKBRdPsQy+ebpi9ERb8NSARGGEUZpYE+MDfaCR1oTw+VzdOvaQTGZjhJug2AEaiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ru29SQiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCKgXS8g88Bg2YGymWSAuOupDyZ6pDfS4Oy1WWS2It4=;
	b=Ru29SQiWVU8YkKzVFlDLGVIuqCETpfEcSMr6fQVkKa3i0LH3SRNG0o6MTg0RltrKUA89J/
	YCdTEnIvSi9+IRK8WPAFlGzlW87Y2MzaUTpntY6jRCcDuTylihuurLhPcHVFNW+rRlaQMM
	s6V7LbL3B1z6GuAJNT4bnnc1861bgBY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-PL61tcbLOBqCOs_jW8c3WQ-1; Mon, 05 Aug 2024 04:02:07 -0400
X-MC-Unique: PL61tcbLOBqCOs_jW8c3WQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a281e55710so2064185a12.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 01:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844926; x=1723449726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCKgXS8g88Bg2YGymWSAuOupDyZ6pDfS4Oy1WWS2It4=;
        b=a0EBkCrF10U7BBJBZNQVKrjRxe1dQ1B2N+YKxP0e8GIWTwx4hany0wQNL7YxKDrzFA
         VEzVVYDWk7PR0t08KKw00kzsUkX0ifsBPl0YQQN4+aaTIICf55ULvuKNYOH5y4BrGnpo
         g7G/F3Jo4wRclwtnHNcjI8WJFlZvH4GrCJP0c55zKzGW8lUqSTwCQiA0p02KsruQe+6U
         bH18NSOE3bGLVOLzCrUfM9zpcFiVdSqjhiRXDzedQY4z4KTZpmJ0LPj5wl5wjAT1VqyR
         xuVTPaPF4GdRgHg4y+MiCEfEb2JDDX5FvjBGvigfLsKHmenBz+nnaEdV2bTPs8ishYtM
         K9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDXl3/6+z/+E3mUD2DbHc8963f1GcyWha4mjiBCzWycQtWcZWUhBXse9YRjtvpsMZKpmOrC9y71BAN8IlXbW6PkxxIXS2rI7rW
X-Gm-Message-State: AOJu0YxXASjfl4T7ehsy/AVQ54M8gZWPH4FuI4c6LnBGEdSsfIBywVjQ
	pKUjx38Ojp9b3REowY3xS8F3dCJ0tOWu0rkD6NHoQGUeg2ImPXnnsUDuvxKlCgN2Bbep+SE3btL
	IIdW5ujOFxuvCH081URTZJQpH8QNIahWIDshpIldPCsqKtWkEnVQMFOMjgA==
X-Received: by 2002:a17:906:cac7:b0:a7a:ab8a:38b with SMTP id a640c23a62f3a-a7dc50a036emr405426466b.7.1722844925250;
        Mon, 05 Aug 2024 01:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8B0uAdpCjmN8RXKqb6GrkT9cJblAYXyonWs0YpjO3v6slHT4MqkSoaoDsG7XIcg/iI+6TwA==
X-Received: by 2002:a17:906:cac7:b0:a7a:ab8a:38b with SMTP id a640c23a62f3a-a7dc50a036emr405424666b.7.1722844924726;
        Mon, 05 Aug 2024 01:02:04 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:04 -0700 (PDT)
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
Subject: [PATCH v2 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Mon,  5 Aug 2024 10:01:28 +0200
Message-ID: <20240805080150.9739-3-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0ec2b23e6cac 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -950,6 +950,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..5b5856ba63e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2289,6 +2289,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
-- 
2.45.2


