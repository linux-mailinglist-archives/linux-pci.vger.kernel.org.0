Return-Path: <linux-pci+bounces-11124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12029451D4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BABB1F2476B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A061B9B32;
	Thu,  1 Aug 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRFX/tPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D271B9B36
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534391; cv=none; b=rINmW9wH1wQeHALVhTg1hUPYHmJoEdt6HhEnFqseoaKcSlogM5YdCkKmmHcCl49SmrhSeMBR8RACOxaI7TBncZWrxqtj4pGJRaGxraOPOnBnHlD+WJOY58tBGwxFQnFbjsy9belpN7gD3c3eQHJ3cTjn4cj+tVLv2Nph1irAqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534391; c=relaxed/simple;
	bh=lqUBCglzn3f4G/USTNUZWIqwmTKyh9NTx5PNNci0oUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDKolvPcQGGH2+33B0p2Bsmzvf2uXol/sJGHggzQ4AEIUkK1kEaX1c/qZ1qQoLTpF3Q6R4wFG3dsWI+e96bWozeEJvWTcP0j0RM2egtl3KlbhgT4rOvFXvft2jZ9WbT0jCEthNz95JXgiJouATu7n41Qu9FC/hB5uhMuY10l0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRFX/tPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IdydxZIGJr3ghOK2fEzH68i3FlzUyX1ZkiOar1Iub4w=;
	b=dRFX/tPV4f6iP2XtdCy/ukBmKmFOsf/rz/SADRumAgOr9H0HCnPfxlO8rMHOHyWKe2DVq4
	oJV5GKZfQuaEs9mmtcbiQCHYJd/XGP27CxQF99lvzoHUB+J0i1v44Ev4HuMtnSTuDtgKQv
	5h8YN/oHMfra7PxVEG8DAwmFm7wX5kA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-YAnLnuHEMX2e6fN3bdQO1A-1; Thu, 01 Aug 2024 13:46:27 -0400
X-MC-Unique: YAnLnuHEMX2e6fN3bdQO1A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a10a3517b7so1096370a12.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 10:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534386; x=1723139186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdydxZIGJr3ghOK2fEzH68i3FlzUyX1ZkiOar1Iub4w=;
        b=r8TAzMUJ6wiCks6bUrQkOcCgoeFDD5XsTV2IUQ0mvHEfODRidIfeT7TNnEEIdJNKqa
         yKQvr7Zx01r/0LlkLsryRGe8XhMNgta4Y+G52vMFxAuERryhnvMspk2xVqpp7kKjI3Rt
         G5n1mBkXyi6JvOufA89H9EiPw/X5IGdz87s8eSVyqiQnCqT4Jad/MWQ/obj+CWHxIzQ3
         t21KWQa6d1Ka+1TXxHONEPvr1RF+pYPRMW7z15vg/vtuV5aHLuSEoBVDFXxV4RMQarbX
         N2q0xq42gHSNBSpf8If5Ka2M2TuHR/hCl6Vo8eu2Tyjgxh+Y6vINXxIVHMOJHo2kg/Eb
         CHIg==
X-Forwarded-Encrypted: i=1; AJvYcCXj7SmfPkD0nRxUZZuZneiVDYcTUDKOLZlIkwq70Co/VpAZxaoiLZ+TsTLAjLsaySXtFGn/lbxv3JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZxKW6p8xAllYIaf9F2VMkrk01S8VFe8UFC0nugS+FHpvY/05
	pDHPzhXlbYKf1nRPxvOxSbGL49w/gegX5OWz9ygcuC3QzhMqJO/wdAa5jURXwKvNxWefSSUOy5I
	jE4ot8ASYWxgjZZiF9FsJWcHOuZXx+lgx8Y0VTa0hi5b2vII+ynttcIE1qg==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr44422166b.3.1722534386284;
        Thu, 01 Aug 2024 10:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Km5jd9cOTYruluysPjH0y6sNbWlr0amJSpmaneqU1ki99pbWjXrxV2Pr+1gBC+OPuM4UGw==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr44419866b.3.1722534385669;
        Thu, 01 Aug 2024 10:46:25 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:25 -0700 (PDT)
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
Subject: [PATCH 00/10] Remove pcim_iomap_regions_request_all()
Date: Thu,  1 Aug 2024 19:45:58 +0200
Message-ID: <20240801174608.50592-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  serial: rp2: Remove deprecated PCI functions
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
2.45.2


