Return-Path: <linux-pci+bounces-1431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4BF81EDEB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB201F2160D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1C24B2F;
	Wed, 27 Dec 2023 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="IuFwD2Kz";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="eR2hJIv+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C028E10
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 856A3C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670339; bh=MrPLZlmO7NpnZQ/Gkn/8Bs3Tf678R+sKC9Qzg7CAIWw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IuFwD2KzNHZ8GWACvAwJj3Npqrk+txFg2byuWTaOdCk5ktcvY+hR2650Kt4oq48S6
	 b5HI2SKT4Lw0q/o99QSD2SJrIi24V9B5Ow7WV/AljA+yZ76Qd7dJNWafpYMDNE0LUm
	 x3oI6VqexIV2HIv9JicTs+y0tnUTGFG4jswaxj5SC1HZlneFwB6ZhIAONea3/Y3CfV
	 VWKXKA0j6BurltfmY2ULeKstP7erqVeZqXuEXm8k1iaPEM+OEAGS+U5oO7i57j/lKi
	 cZZrmKr9tA7CbpOM38dI4j42EGl/jiY67Z4R8Kek9dNx8nz/KhcSujkFUP/NL7mkeA
	 COBcRj7s+AA8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670339; bh=MrPLZlmO7NpnZQ/Gkn/8Bs3Tf678R+sKC9Qzg7CAIWw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=eR2hJIv+Pv3sas2xEl9GKeMGOrYr+NdEuQu7n+fqLQcHhUfBEN+Jac6IHo4aT8Vg3
	 1P6LaJWKnhBgKLt8DS7urUMJYihTUU2ls7Vke2lh0KgnsT1UWvid0IasCCbDj1roCT
	 tXFDvFgKs7hba3rbZYE5sBGqqERnpYyygV/OF4d8Vv0fV6b9FjsvF9T4z0jgARoFgE
	 q+M3Z1VLTV5Ou4gTjF3iTE6VV4JvazgZNWfWG43jGV+5gKHhKjqwC7Jn/nfA+TAQQz
	 Zb3ZR6rzjh+6nOvMbuaC/IW/BJQzqTWAO7CLCiXIgM4f9PsgcfoiwFqnmQwlWSX2K6
	 OeZ3WBSbUSTzQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 00/15] pciutils: Add utility for Lane Margining
Date: Wed, 27 Dec 2023 14:44:49 +0500
Message-ID: <20231227094504.32257-1-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

PCIe Base Spec Rev 4.0 introduced new extended capability mandatory for all
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
(16/32 GT/s Link is required though).
Utility was written with Linux in mind and was tested only on this OS.

Example utility results on different systems you can see in gist:
https://gist.github.com/bombanya/f2b15263712757ffba1a11eea011c419

Patch series is also posted as PR on pciutils github:
https://github.com/pciutils/pciutils/pull/162

Changelog:

v2:
- Replace packed structures with bitfields for margining registers parsing
  with BIT() and MASK() macros;
- Hardware quirks are now based on ports PCI ID instead of /proc/cpuinfo;
- Refer to the PCIe Spec properly;
- Clean up the formatting;
- Move the entire internal interface of the utility into one common header;
- Use pcilib u8/16/... types instead of types from stdint.h;
- Use common.c functions such as die() and xmalloc() as Martin suggested;
- Change utility building to the variant with linking object files
  separately instead of building lmr as a library.

v1:
https://lore.kernel.org/linux-pci/20231208091734.12225-1-n.proshkin@yadro.com/


Nikita Proshkin (15):
  pciutils-lspci: Fix unsynchronized caches in lspci struct device and
    pci struct pci_dev
  pciutils: Add constants for Lane Margining at the Receiver Extended
    Capability
  pciutils-lspci: Add Lane Margining support to the lspci
  pciutils-pcilib: Add separate file for bit manipulation functions
  pciutils-pcilmr: Add functions for device checking and preparations
    before main margining processes
  pciutils-pcilmr: Add margining process functions
  pciutils-pcilmr: Add logging functions for margining
  pciutils-pcilmr: Add function for default margining results log
  pciutils-pcilmr: Add utility main function
  pciutils-pcilmr: Add support for unique hardware quirks
  pciutils-pcilmr: Add the ability to pass multiple links to the utility
  pciutils-pcilmr: Add --scan mode to search for all LMR-capable Links
  pciutils-pcilmr: Add option to save margining results in csv form
  pciutils-pcilmr: Add handling of situations when device reports its
    MaxOffset values equal to 0
  pciutils-pcilmr: Add pcilmr man page

 Makefile             |  16 +-
 lib/bitops.h         |  39 +++
 lib/header.h         |   7 +
 lib/pci.h            |   1 +
 lmr/lmr.h            | 228 +++++++++++++++++
 lmr/margin.c         | 573 +++++++++++++++++++++++++++++++++++++++++++
 lmr/margin_hw.c      | 160 ++++++++++++
 lmr/margin_log.c     | 158 ++++++++++++
 lmr/margin_results.c | 283 +++++++++++++++++++++
 ls-ecaps.c           |  22 +-
 lspci.c              |   1 +
 lspci.h              |   6 -
 pcilmr.c             | 483 ++++++++++++++++++++++++++++++++++++
 pcilmr.man           | 182 ++++++++++++++
 14 files changed, 2149 insertions(+), 10 deletions(-)
 create mode 100644 lib/bitops.h
 create mode 100644 lmr/lmr.h
 create mode 100644 lmr/margin.c
 create mode 100644 lmr/margin_hw.c
 create mode 100644 lmr/margin_log.c
 create mode 100644 lmr/margin_results.c
 create mode 100644 pcilmr.c
 create mode 100644 pcilmr.man

--
2.34.1


