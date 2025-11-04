Return-Path: <linux-pci+bounces-40194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A6C30F3F
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF211189311E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B302EC542;
	Tue,  4 Nov 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cP6E9mUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A82C0F97;
	Tue,  4 Nov 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258602; cv=none; b=a8tF3fBAEpaJSQuZcegquE1URpiJu8UomIJFutIqXro2A1bCnwW+cL9/4q5+JZzEqzPZeiRzNps8OkmYxxfX+/iDfObrm4b6UjB+cNJ6U5RF40ze/gPgODzYNY09t/1JuGVkP6/Pcy8eLEK32PcU5ZX+4TwaNtZE/qr4wpeYkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258602; c=relaxed/simple;
	bh=CaIU/ETYPPssWMPvYMqOLbcN/qfzPMEJH8nRXbbwcL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntIs95B5QAYNKxcRtYadKK4uo0e/EKsZmI98ii6IMFflcTEzzNEfkRDdO8wvxTD1g/n7Fds5OZEg2KKfJynB02OZmx1M93nB/i7IQ3xlKmuqowzwARpQR373ZzpWP/z2dMj9xzmdcxzuPZLViaTU7wj8DjHKv5oRglZRHCFDWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cP6E9mUo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258601; x=1793794601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CaIU/ETYPPssWMPvYMqOLbcN/qfzPMEJH8nRXbbwcL8=;
  b=cP6E9mUowETQPpa1Exz9IYeCvpRpwYkB6T8m6uIxlWcnhQ5mibAHSXVa
   bOvIi0TwGUJc+TVCy0U5GbIjn38tDQjMAmD3t9qbsAuqUOKXWqdwXbPm1
   u+IZxzAtnvBT13/X9uwx2W4rwF3iFzuZ/Rv4Xf3r6urIcUC2+mgqVXPWK
   2wPTTuegIdrZEEIetV8USOaxW0KagIiykF8kjC3EbiCkh2OC7OhwJbXWE
   AsnGyun5pqpNHEsEf1FaJOtKIcN6UTHlsJBNiVkJb+jzjt8AXv3D3+fOf
   rHyNhFZ2y29phWI4zvarBC0ei2lz/YM/USOVrW3yg/h+BuzHMZ1r6ZZjw
   w==;
X-CSE-ConnectionGUID: H83lplhTRTOcxez3wNc4xg==
X-CSE-MsgGUID: VZ144IvFQYGjVIprfVQIig==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187499"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187499"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:40 -0800
X-CSE-ConnectionGUID: sO9DsIrNSX20xR+fSh7JDQ==
X-CSE-MsgGUID: EF9dLBimSe629mlVYo3q7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832417"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:36 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 0/7] ASoC/SOF/PCI/Intel: Support for Nova Lake S
Date: Tue,  4 Nov 2025 14:16:43 +0200
Message-ID: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- Add information for the users of the PCI ID
- Add Acked-by tag for the pci_ids.h from Bjorn
- Add Acked-by tags from Mark for the ASoC patches

This series adds initial support for NVL-S from the Nova Lake family.
NVL-S includes ACE4 audio subsystem, it has 2 DSP cores.

Regards,
Peter
---
Bard Liao (1):
  ASoC: Intel: soc-acpi-intel-nvl-match: add rt722 l3 support

Peter Ujfalusi (6):
  PCI: Add Intel Nova Lake S audio Device ID
  ALSA: hda/hdmi: intelhdmi: add HDMI codec ID for Intel NVL
  ASoC: Intel: soc-acpi: add NVL match tables
  ASoC: SOF: Intel: add initial support for NVL-S
  ALSA: hda: core: intel-dsp-config: Add support for NVL-S
  ALSA: hda: controllers: intel: add support for Nova Lake S

 include/linux/pci_ids.h                       |  1 +
 include/sound/soc-acpi-intel-match.h          |  2 +
 sound/hda/codecs/hdmi/intelhdmi.c             |  1 +
 sound/hda/controllers/intel.c                 |  2 +
 sound/hda/core/intel-dsp-config.c             |  8 ++
 sound/soc/intel/common/Makefile               |  1 +
 .../intel/common/soc-acpi-intel-nvl-match.c   | 90 +++++++++++++++++++
 sound/soc/sof/intel/Kconfig                   | 17 ++++
 sound/soc/sof/intel/Makefile                  |  2 +
 sound/soc/sof/intel/hda-dsp.c                 |  1 +
 sound/soc/sof/intel/hda.h                     |  1 +
 sound/soc/sof/intel/nvl.c                     | 55 ++++++++++++
 sound/soc/sof/intel/nvl.h                     | 14 +++
 sound/soc/sof/intel/pci-nvl.c                 | 82 +++++++++++++++++
 sound/soc/sof/intel/shim.h                    |  1 +
 15 files changed, 278 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-nvl-match.c
 create mode 100644 sound/soc/sof/intel/nvl.c
 create mode 100644 sound/soc/sof/intel/nvl.h
 create mode 100644 sound/soc/sof/intel/pci-nvl.c

-- 
2.51.2


