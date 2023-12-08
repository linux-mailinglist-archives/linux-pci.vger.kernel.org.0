Return-Path: <linux-pci+bounces-656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897B809F3D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5122281849
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C3125A3;
	Fri,  8 Dec 2023 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="g1Ia679n";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="fw/nJ5nK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FB1724
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 170C6C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027126; bh=LffEoy7BEXtir+bHG7zJLq4DE9Brdo6hglCGBOxdd2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=g1Ia679n2fdVYMpGRRf6jtxZ+7nhAi05WkZUGSEd4UKcT+ZcPcdU+TFINAI+tuITg
	 +0I3KQmFvwGTHL4AOeLX/zjYJFw7ys+ypD7zmBIVTN77iGrMZ0ujFC5a2jM7r7ObXW
	 Q6zEGUNldETjEcBj/uLgM7viNR6aViqxryTYmU1nVrSuvuF3t8Dsf2mc45vSwtFO5p
	 k8wO1JX8BCeeollweFqGYa2DAiwjCAxu3KAGKNtozPL9pCIJUm+Wcyrg3PkJmuwJCV
	 /wzI/7njksEhbA5QYfgzE9ekRQqrO7phGhlmHBGX0bkinFqCbD96bvHvA/5L0CXZe+
	 JoTvIGVKC5zcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027126; bh=LffEoy7BEXtir+bHG7zJLq4DE9Brdo6hglCGBOxdd2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=fw/nJ5nKLAznNu3diBoHUwwzp3s/h4itNfbzaXYcgvACmp/6HIUUCFVzIJ0tX2CvZ
	 A24xQqrvM9LDRGPA4eN7dQbyLG34W54pa08ZAS6kOfgghxz0MbwvbqtQwpMOwFJ2v9
	 TF6e30Af86Oj4Vg5vHOv2xu0QPvwIp7VsnfnPwDM8yObGjWVZnW8Zf/zX1647c3o7K
	 Mx04UNQegoYQMxyC8qMIiuTzs7dfPUJE8Kw5h5AVDlJMEk0jt+QJOElY6diZ6AfSuC
	 4lE5GJH/As97vvuLCyDEuwC7Pisi+um9DeTKxb4kZll7bNIj6aUO4ZL6Vh9ExMEE4i
	 n69pbuTXazpcw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 00/15] pciutils: Add utility for Lane Margining
Date: Fri, 8 Dec 2023 12:17:19 +0300
Message-ID: <20231208091734.12225-1-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

PCIe Gen 4 spec introduced new extended capability mandatory for all
ports - Lane Margining at the Receiver. This new feature allows to get an
approximation of the Link eye margin diagram by four points. This
information shows how resistant the Link is to external influences and can
be useful for link debugging and presets tuning.
Previously, this information was only available using a hardware debugger.

Patch series consists of two parts:

* Patch for lspci to add Margining registers reading. There is not much
  information available without issuing any margining commands, but this
  info is useful anyway;
* New pcilmr utility.

Margining capability assumes the exchange of commands with the device, so
its support was implemented as a separate utility pcilmr.
The pcilmr allows you to test Links and supports all the features provided
by the Margining capability. The utility is written using a pcilib, it is
divided into a library part and a main function with arguments parsing in
the pciutils root dir.
Man page is provided as well.

Utility compilation and man page preparation are integrated into the
pciutils Makefile, so run make is enough to start testing the utility
(Gen 4/5 device is required though).
Utility was written with Linux in mind and was tested only on this OS.

Example utility results on different systems you can see in gist:
https://gist.github.com/bombanya/f2b15263712757ffba1a11eea011c419

Patch series is also posted as PR on pciutils github:
https://github.com/pciutils/pciutils/pull/162

Nikita Proshkin (15):
  pciutils-lspci: Fix unsynchronized caches in lspci struct device and
    pci struct pci_dev
  pciutils: Add constants for Lane Margining at the Receiver Extended
    Capability
  pciutils-lspci: Add Lane Margining support to the lspci
  pciutils-pcilmr: Add functions for device checking and preparations
    before main margining processes
  pciutils-pcilmr: Add margining process functions
  pciutils-pcilmr: Add logging functions for margining
  pciutils-pcilmr: Add all-in-one device margining parameters reading
    function
  pciutils-pcilmr: Add function for default margining results log
  pciutils-pcilmr: Add utility main function
  pciutils-pcilmr: Add support for unique hardware quirks
  pciutils-pcilmr: Add the ability to pass multiple links to the utility
  pciutils-pcilmr: Add --scan mode to search for all LMR-capable Links
  pciutils-pcilmr: Add option to save margining results in csv form
  pciutils-pcilmr: Add handling of situations when device reports its
    MaxOffset values equal to 0
  pciutils-pcilmr: Add pcilmr man page

 Makefile                 |  11 +-
 lib/header.h             |   7 +
 lmr_lib/Makefile         |  10 +
 lmr_lib/margin.c         | 528 ++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin.h         | 206 +++++++++++++++
 lmr_lib/margin_hw.c      | 163 ++++++++++++
 lmr_lib/margin_hw.h      |  46 ++++
 lmr_lib/margin_log.c     | 141 +++++++++++
 lmr_lib/margin_log.h     |  23 ++
 lmr_lib/margin_results.c | 255 +++++++++++++++++++
 lmr_lib/margin_results.h |  15 ++
 ls-ecaps.c               |  22 +-
 lspci.c                  |   1 +
 pcilmr.c                 | 532 +++++++++++++++++++++++++++++++++++++++
 pcilmr.man               | 179 +++++++++++++
 15 files changed, 2136 insertions(+), 3 deletions(-)
 create mode 100644 lmr_lib/Makefile
 create mode 100644 lmr_lib/margin.c
 create mode 100644 lmr_lib/margin.h
 create mode 100644 lmr_lib/margin_hw.c
 create mode 100644 lmr_lib/margin_hw.h
 create mode 100644 lmr_lib/margin_log.c
 create mode 100644 lmr_lib/margin_log.h
 create mode 100644 lmr_lib/margin_results.c
 create mode 100644 lmr_lib/margin_results.h
 create mode 100644 pcilmr.c
 create mode 100644 pcilmr.man

-- 
2.34.1


