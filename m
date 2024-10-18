Return-Path: <linux-pci+bounces-14863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC929A4188
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8123B23E0A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6E1FF5F6;
	Fri, 18 Oct 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib+iL0Y7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C410E4;
	Fri, 18 Oct 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262892; cv=none; b=I0iAhgiZ2vATNMHJJ/ERY9BgXCoT69TCJYc5Y5FadJJN9JroJV3pwJlGcr861K2XQ/RnrdntT2xs86z19aISToNkzUMQQ28Jmvnn1A8N2tItxxDO1tEWQzpjoIyXZ2G3clL9VsPr+R7f+JdCLcosCoJ5fZ9QKrDawlv6Z4BVRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262892; c=relaxed/simple;
	bh=O7wOviqV/219bT9BFDohUMQAjVvTdrZUiYrHNbY+ai8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Jb8ciFYE2V/Ap1cJ49EP/7ZtfZeHtqlISztp0N2lHCBWzohP5kmzKSP4Ol/jcTgjLFQ+0hOf6sOl52EcXD4aA+z4WTKttUH+foXev/7RAAR8u/D8qYBQz+DF5wiC2qFASDag2Z69zdHD+iVUBMdo2m6PH1Q8euqHs/b+dE3TFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib+iL0Y7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262890; x=1760798890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O7wOviqV/219bT9BFDohUMQAjVvTdrZUiYrHNbY+ai8=;
  b=ib+iL0Y7HBpICaGok4xey7FWPyrptinNfExnmTyJzIR2PLduWINUxcuh
   44JsGOgajTQ3IU5Y7LHdOreyoGPbJJady5C+geXcqNgPIQZxxYiImxz6t
   cJvslLBqFoK5/Q+hgOD6LksrSLkrCpFPpLbdfZX5lWt/omAj7On93Oeza
   IcmfQbvnf75oPvzDVNxBnNBGD2oIAMWmbYvr5w4wdIj+dyEbyPpHNuTDb
   WFgPOqaseTmNTYsY9acgpXF1lKjLGbK7mo2uffu7mWKqdPG5J4pa99ICJ
   y5hTSTXAGEJ1Y3/QdJHNcJzf4ua9quBnK6ZaR6neby17g0RxkdjgX9G7u
   w==;
X-CSE-ConnectionGUID: aTGh4fCARC6JmsAT0TaOfA==
X-CSE-MsgGUID: BA4pf05kTCuwqZqVfddp7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46296800"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="46296800"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:09 -0700
X-CSE-ConnectionGUID: 3z+p7+FoTdu9oIxiK4jJ6A==
X-CSE-MsgGUID: CtEeCNBlRXSVszmWHINN3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83658045"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 0/9] PCI: Add PCIe bandwidth controller
Date: Fri, 18 Oct 2024 17:47:46 +0300
Message-Id: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
cooling driver to the thermal core side for limiting PCIe Link Speed
due to thermal reasons. PCIe bandwidth controller is a PCI express bus
port service driver. A cooling device is created for each port the
service driver finds to support changing speeds.

This series only adds support for controlling PCIe Link Speed.
Controlling PCIe Link Width might also be useful but there is no
mechanism for that until PCIe 6.0 (L0p) so Link Width throttling is not
added by this series.


v9:
- Split RMW ops doc reformat into own patch before adding LNKCTL2.
- Comment reserved 0 LSB even better than it already was.
- Consider portdrv future plans:
	- Use devm helpers for mem alloc, IRQ, and mutex init.
	- Don't use get/set_service_data().
- Split rwsem into two to avoid recursive locking splat through
  pcie_retrain_link().
- Small wording improvements to commit messages (from Jonathan)

v8:
- Removed CONFIG_PCIE_BWCTRL (use CONFIG_PCIEPORTBUS)
- Removed locking wrappers that dealt with the CONFIG variations
- Protect macro parameter with parenthesis to be on the safe side

v7:
- Rebased on top of Maciej's latest Target Speed quirk patches
- Target Speed quirk runs very early, w/o ->subordinate existing yet.
  This required adapting logic:
	- Move Supported Link Speeds back to pci_dev
	- Check for ->subordinate == NULL where necessary
	- Cannot always take bwctrl's per port mutex (in pcie_bwctrl_data)
- Cleaned up locking in pcie_set_target_speed() using wrappers
	- Allowed removing confusing __pcie_set_target_speed()
- Fix building with CONFIG_PCI=n
- Correct error check in pcie_lbms_seen()
- Don't return error for an empty bus that remains at 2.5GT
- Use rwsem to protect ->link_bwctrl setup and bwnotif enable
- Clear LBMS in remove_board()
- Adding export for pcie_get_supported_speeds() was unnecessary
- Call bwctrl's init before hotplug.
- Added local variable 'bus' into a few functions

v6:
- Removed unnecessary PCI_EXP_LNKCAP_SLS mask from PCIE_LNKCAP_SLS2SPEED()
- Split error handling in pcie_bwnotif_irq_thread()
- pci_info() -> pci_dbg() on bwctrl probe success path
- Handle cooling device pointer -Exx codes in bwctrl probe
- Reorder port->link_bwctrl setup / bwnotif enable for symmetry
- Handle LBMS count == 0 in PCIe quirk by checking LBMS (avoids a race
  between quirk and bwctrl)
- Use cleanup.h in PCIe cooling device's register

v5:
- Removed patches: LNKCTL2 RMW driver patches went in separately
- Refactor pcie_update_link_speed() to read LNKSTA + add __ variant
  for hotplug that has LNKSTA value at hand
- Make series fully compatible with the Target Speed quirk
	- LBMS counter added, quirk falls back to LBMS bit when bwctrl =n
	- Separate LBMS patch from set target speed patches
- Always provide pcie_bwctrl_change_speed() even if bwctrl =n so drivers
  don't need to come up their own version (also required by the Target
  Speed quirk)
- Remove devm_* (based on Lukas' comment on some other service
  driver patch)
- Convert to use cleanup.h
- Renamed functions/struct to have shorter names

v4:
- Merge Port's and Endpoint's Supported Link Speeds Vectors into
  supported_speeds in the struct pci_bus
- Reuse pcie_get_speed_cap()'s code for pcie_get_supported_speeds()
- Setup supported_speeds with PCI_EXP_LNKCAP2_SLS_2_5GB when no
  Endpoint exists
- Squash revert + add bwctrl patches into one
- Change to use threaded IRQ + IRQF_ONESHOT
- Enable also LABIE / LABS
- Convert Link Speed selection to use bit logic instead of loop
- Allocate before requesting IRQ during probe
- Use devm_*()
- Use u8 for speed_conv array instead of u16
- Removed READ_ONCE()
- Improve changelogs, comments, and Kconfig
- Name functions slightly more consistently
- Use bullet list for RMW protected registers in docs

v3:
- Correct hfi1 shortlog prefix
- Improve error prints in hfi1
- Add L: linux-pci to the MAINTAINERS entry

v2:
- Adds LNKCTL2 to RMW safe list in Documentation/PCI/pciebus-howto.rst
- Renamed cooling devices from PCIe_Port_* to PCIe_Port_Link_Speed_* in
  order to plan for possibility of adding Link Width cooling devices
  later on
- Moved struct thermal_cooling_device declaration to the correct patch
- Small tweaks to Kconfig texts
- Series rebased to resolve conflict (in the selftest list)

Ilpo Järvinen (9):
  Documentation PCI: Reformat RMW ops documentation
  PCI: Protect Link Control 2 Register with RMW locking
  PCI: Store all PCIe Supported Link Speeds
  PCI: Refactor pcie_update_link_speed()
  PCI/quirks: Abstract LBMS seen check into own function
  PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
  PCI/bwctrl: Add API to set PCIe Link Speed
  thermal: Add PCIe cooling driver
  selftests/pcie_bwctrl: Create selftests

 Documentation/PCI/pciebus-howto.rst           |  14 +-
 MAINTAINERS                                   |   9 +
 drivers/pci/hotplug/pciehp_ctrl.c             |   5 +
 drivers/pci/hotplug/pciehp_hpc.c              |   2 +-
 drivers/pci/pci.c                             |  62 ++-
 drivers/pci/pci.h                             |  38 +-
 drivers/pci/pcie/Makefile                     |   2 +-
 drivers/pci/pcie/bwctrl.c                     | 366 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c                    |   9 +-
 drivers/pci/pcie/portdrv.h                    |   6 +-
 drivers/pci/probe.c                           |  15 +-
 drivers/pci/quirks.c                          |  32 +-
 drivers/thermal/Kconfig                       |   9 +
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pcie_cooling.c                |  80 ++++
 include/linux/pci-bwctrl.h                    |  28 ++
 include/linux/pci.h                           |  24 +-
 include/uapi/linux/pci_regs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++
 .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
 22 files changed, 843 insertions(+), 53 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

-- 
2.39.5


