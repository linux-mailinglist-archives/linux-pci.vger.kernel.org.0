Return-Path: <linux-pci+bounces-15585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544999B617D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 12:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C111C2111F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623641E5733;
	Wed, 30 Oct 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dykSL0Ho"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98A1E5721
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287701; cv=none; b=hPG7aM1MConlghFxZOvbV/AqbwprHoKWmuKEKxvdwVGZYix7PfySf8DdnfcaGJSKCeXx3QwR9EOlAsMCmH1K6GTCtN1EDwscgFgG+vD7FIJQFlk2wnBVDHpy/WevBmNHdvYjZM1RVUYFx+8ZLmezEKxDmBnUSFb23FlC+OQUHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287701; c=relaxed/simple;
	bh=q3TYZ53foBadD/cMlyNi2anAEGoKt2ZxGv1qO1diPeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWzGMVnL8/QvZqFWmApOeNCjE/EuHOoEsTpsRFJI1Qd3gqwqQI9ZGlUON98C0WE808kjEV/jEt1sor/4LLBYDXXLLjVdPhQil8eRSkfTVzj31Nm6zttHl3hmIr8FsfJjTa22prUhIADDoLW7Z6bbEKI1XOO/HzbWH11CpTFkQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dykSL0Ho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmhs99F0aBbo/KjdAhIjGloV5ZKJmf6z3p3cVimWjlk=;
	b=dykSL0HocbY5FZho2yM87p/oLjqYTBloenGlCz31zv6euj+ESRubr+ovLhJoKmSMxRjvwC
	AC5be7WMXL78bPYe4cULh2LTgn30Blri09rCqTUcrKxuF/bx8XsPAd3GeQKZ+S00sJx/tr
	PGvSIp67joPPp9/WjYxLqjAMx4Y9uHM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-797DPN2RM_qLo41N_5A3JQ-1; Wed, 30 Oct 2024 07:28:17 -0400
X-MC-Unique: 797DPN2RM_qLo41N_5A3JQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a0ac0e554so79621066b.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 04:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287696; x=1730892496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nmhs99F0aBbo/KjdAhIjGloV5ZKJmf6z3p3cVimWjlk=;
        b=lks4dcTizA/tf7wyCmOx/9V0lakHhTCL025/OYLyqH09v+PPh6cPoFhiYcr8KuZE+Q
         HbHRReVRKlwJY/Rg13CxTDeOCbOxjN6Qz+ebqfV4OjC4lRZyfMO8upiJdXOmUdZYSLUA
         2G0yLrozYUqE0MjfTIGEpiE2blU1JW/Mn5IKTKcoA+cr3FCxckVryzXpPSJfelKGkNzo
         DmUQmCkPNi1Cyi+gU5zMnLEBvzMX4MSfTQebCvzqLe060bE6zpasfgX3+Ondc6aJ7rog
         /f7HhZGH6Gu9uSdYNkN4IAUP1kQAbjHeLrzpmU1Yw5Bz5/NFAyEigdjk5DOcnZmSOeA+
         6Utg==
X-Forwarded-Encrypted: i=1; AJvYcCVCOTuy0Z65IoKBJI+nHRGZyh4+ZfbaIEf01otrFQHW9h5zyy4Gzt7pxbkypAldIw3Jwml5sgrc7NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidrqVekkxJ9vN6as22/Zr3gS8lrv2YAZvY11RMSOOSj5tvkvd
	RWpJ1ZyF8NF4BraNkvWoXoVx2dcFLArqy+hCcfTajW9fSUdeFhcpOJlMWIZo8uvx6qx7ME4bmy9
	1XKI1vSPUPXXil3zSoBZuwSF43oojUOu8q9eEPrvqQyQVxvLoYm3u2ADLzQ==
X-Received: by 2002:a17:906:7955:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-a9e40fd6b13mr170562266b.26.1730287694541;
        Wed, 30 Oct 2024 04:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1NLu5M2018jLIxJX+Z/i21emZn/jQBhcI0nUHdCEwPkxlqgV1lXWB25R+uQkV5ZaptpnaqA==
X-Received: by 2002:a17:906:7955:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-a9e40fd6b13mr170558666b.26.1730287694067;
        Wed, 30 Oct 2024 04:28:14 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:13 -0700 (PDT)
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
Subject: [PATCH v6 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 30 Oct 2024 12:27:34 +0100
Message-ID: <20241030112743.104395-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..2a64da5c91fb 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -939,7 +939,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -957,6 +957,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..3b151c8331e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2293,6 +2293,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0


