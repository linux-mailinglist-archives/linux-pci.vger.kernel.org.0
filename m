Return-Path: <linux-pci+bounces-15317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCBA9B06A4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9239F1F23278
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE418171E65;
	Fri, 25 Oct 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMFXXuqC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC6169AC5
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868442; cv=none; b=Y0wyYGR77fdXt0mug+aWsrVE7pUtblUyX8pNbIiG8/w2NppM+bm/KxuwJ/5jVvtxFYmH/8+r3Y2var3Innq7zpYgknJjjZP659mHmpxg/jyVw67nqVV4srafEAoEAhWw6kx16hjNaJLfJlmK36hbm+I3mZCCnAUinDld82fJiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868442; c=relaxed/simple;
	bh=qn2zisIVAp1A3sOByjD0CKUjzgN/331GtrAdNv9H2Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aw1U366HIJnumf4azO3sjLr8BO51Y46FEA5nwlttGwFGLW44aN4AaUUdOt/1s6H2AHdogcYHPRUwr/uHdRVDtc6ata5ZqtoQdlNb/LxxF0jNgxW9xfcUnCtkXKwOffjQrpYNCGhGUhceEj2/BrtYUmM6nLMqFF5oXXZxo2R2NO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMFXXuqC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6mk7pVJi4FxC5YCmtGMcoceHkePQhE8sXwo0Yl4cl4Y=;
	b=XMFXXuqCWVUAVm2tG0dM6PHfyyu2sAT5PygTKygfI0PlWJGAFHZ3iM/d2ihMi/CP50iLyq
	cZZbMf6XKhTF+mAjaPJoOiRsVUXeCPIGNVTjqyGiCMTSG7nZaKRqfg+nt77nzC63/p0nNY
	hYKf70wC3UUel+04RKeBK0NIJHhSEI8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-sjC0DZDwMImhpX9qv60_rQ-1; Fri, 25 Oct 2024 11:00:37 -0400
X-MC-Unique: sjC0DZDwMImhpX9qv60_rQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so16020155e9.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 08:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868436; x=1730473236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mk7pVJi4FxC5YCmtGMcoceHkePQhE8sXwo0Yl4cl4Y=;
        b=c9t3T9IQZAoGaYG+3XHUtqhF/u2pXapaAHOC97qkJrfKCyoEcKWrvRTcBYt39O1apa
         0YjhjGOQGsYvzpH1vJvRhh1aEJR8Wl/GTd02nOjvkxqXQ4eESTy7zGabvv7aY9cujoqn
         ZLhp95TrC9+y2M1tX7ySvLs5EHlXvhCWQAZreaR+IojFq3rlO9h6FVvCKCG/UwOBr+sV
         m0TlhAkPbetnnYBMdt8h5aPIG6pmUQj9aIkb0P43K8xszPOhzH1aC9RMpXd7Um+Y5U+Q
         gXPm4dqYrn7Lvri43tR5sbalpm5jXZ+6aZe7uigs6I5NNlGIbYKuetxkF0786vTGXEOz
         KgCw==
X-Forwarded-Encrypted: i=1; AJvYcCWBnc+kHQdOH15davFW6MO/d9ER6wpJUncWPEF16zyGUhxGcxadutUnA/mmYL9NjGhn3nNfmEdLtIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxce5DvhxfQMnqPxF8g7xuZ5hhp4wt70bDcVQmYgKvJKao+vqKv
	KUxl/tINh+WCuQrccn2PLZI7uktQUHYFw85Y98zhRmUIFaZt9qoiSYZpWgAzz99/BnHeGc2GpR4
	8eg18dszZin8JxqgBXIrgXN9b/KPVW38v4t/VSF2PEjeo3KdjIL/+uWdtdQ==
X-Received: by 2002:adf:eac4:0:b0:37c:d2f0:7331 with SMTP id ffacd0b85a97d-3803ab1a8bbmr4410345f8f.0.1729868435663;
        Fri, 25 Oct 2024 08:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDs+qGkPhYGAaZ+QRORXNw+V6iATQJifr1mVHJ8hw/ogKGV0BNUWn6+ubNlvP8p8bNny4MNA==
X-Received: by 2002:adf:eac4:0:b0:37c:d2f0:7331 with SMTP id ffacd0b85a97d-3803ab1a8bbmr4410253f8f.0.1729868435070;
        Fri, 25 Oct 2024 08:00:35 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:34 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
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
Subject: [PATCH 00/10] Remove pcim_iomap_regions_request_all()
Date: Fri, 25 Oct 2024 16:59:43 +0200
Message-ID: <20241025145959.185373-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All Acked-by's are in place now.

Changes in v5:
  - Add Acked-by's from Alexander and Bharat (the latter sent off-list,
    because of some issue with receiving the previous patch sets).

Changes in v4:
  - Add Acked-by's from Giovanni and Kalle.

Changes in v3:
  - Add missing full stops to commit messages (Andy).

Changes in v2:
  - Fix a bug in patch №4 ("crypto: marvell ...") where an error code
    was not set before printing it. (Me)
  - Apply Damien's Reviewed- / Acked-by to patches 1, 2 and 10. (Damien)
  - Apply Serge's Acked-by to patch №7. (Serge)
  - Apply Jiri's Reviewed-by to patch №8. (Jiri)
  - Apply Takashi Iwai's Reviewed-by to patch №9. (Takashi)


Hi all,

the PCI subsystem is currently working on cleaning up its devres API. To
do so, a few functions will be replaced with better alternatives.

This series removes pcim_iomap_regions_request_all(), which has been
deprecated already, and accordingly replaces the calls to
pcim_iomap_table() (which were only necessary because of
pcim_iomap_regions_request_all() in the first place) with calls to
pcim_iomap().

Would be great if you can take a look whether this behaves as you
intended for your respective component.

Cheers,
Philipp

Philipp Stanner (10):
  PCI: Make pcim_request_all_regions() a public function
  ata: ahci: Replace deprecated PCI functions
  crypto: qat - replace deprecated PCI functions
  crypto: marvell - replace deprecated PCI functions
  intel_th: pci: Replace deprecated PCI functions
  wifi: iwlwifi: replace deprecated PCI functions
  ntb: idt: Replace deprecated PCI functions
  serial: rp2: Replace deprecated PCI functions
  ALSA: korg1212: Replace deprecated PCI functions
  PCI: Remove pcim_iomap_regions_request_all()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/ata/acard-ahci.c                      |  6 +-
 drivers/ata/ahci.c                            |  6 +-
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 11 +++-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 11 +++-
 .../marvell/octeontx2/otx2_cptpf_main.c       | 14 +++--
 .../marvell/octeontx2/otx2_cptvf_main.c       | 13 ++--
 drivers/hwtracing/intel_th/pci.c              |  9 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
 drivers/ntb/hw/idt/ntb_hw_idt.c               | 13 ++--
 drivers/pci/devres.c                          | 59 +------------------
 drivers/tty/serial/rp2.c                      | 12 ++--
 include/linux/pci.h                           |  3 +-
 sound/pci/korg1212/korg1212.c                 |  6 +-
 14 files changed, 76 insertions(+), 104 deletions(-)

-- 
2.47.0


