Return-Path: <linux-pci+bounces-33279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB5B1805B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB04171138
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9CA19F115;
	Fri,  1 Aug 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxBIxb4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5E2B9A5
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045159; cv=none; b=OtOGf+fTF0vsVxZ/uiPnDgHDZZisOqHMMT8OfHx4qfXSEWnzKuVb8x+6kAI5oODDbm4wi6a8zfBIq1SK/1IwMOU1WCIXQaPCf4aBGuntqtFJjdPytJIiNcw/5JRe1evbGDs/XiOTpXF7zSShpE6g/mhjXBbN5x+MCC3uJAMlD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045159; c=relaxed/simple;
	bh=rtL7Zm48rkHeuKfJVjVKmU5mrB09UF1YwXoUH6HI4lU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pdlu70f/koBhy4ss7k6RwPHOK76c52xvJ+xPcqyhHI5iuCmGqf1PY97K/Aru9YtKEii5W/3pYsjh2BfQhfTxctgFl4CWRQGWIf72dnagS2Ltr54RbqIEhK8L/Msjg9FGt608DRsGKgVGwSM+f22lYmZvM2WWsl47FlApVEJ1j2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxBIxb4t; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754045157; x=1785581157;
  h=date:from:to:cc:subject:message-id;
  bh=rtL7Zm48rkHeuKfJVjVKmU5mrB09UF1YwXoUH6HI4lU=;
  b=SxBIxb4t0O9a507x9b9tyEN/f9NvT45OzJ6BP1VqgBKBWrjzL6SF9+WF
   ajg5gSIYwD0hcNEff8vuJ1mMEwW6Jgrvyj9Db3BiT6zkznW16wpiFDJR3
   6g/5PsicayhQAamkaCaR40FYEVET90HSaMIhAkO6GmG2I2O9D/s3tQeY/
   gtAd5rpC9dpGgChB0If79NE0CqnRdSvzsz0L3k1qUYP9Hc3D+Q3MamQMP
   gj/dlEhTwJfMlgjjW1HNrKUsS18oXLiRjSeRUMts7/IzqwbFjDZkRKx3/
   /rLBzDwHuCk190BF5Lu1S7iJHl2KTBRJhJJfUbus2H8RIRXI3Zr2l6kp1
   A==;
X-CSE-ConnectionGUID: wZnCIL8ATUWL0JPqG3laKQ==
X-CSE-MsgGUID: pKEEZf2PRiidJJ8slBtx5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56092005"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56092005"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 03:45:57 -0700
X-CSE-ConnectionGUID: 7dMUGLBYT0iNi6XLeP/kEA==
X-CSE-MsgGUID: /BXgxBDiSr+l2Zr/gDF+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="164327569"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Aug 2025 03:45:55 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhnGq-0004Yu-33;
	Fri, 01 Aug 2025 10:45:52 +0000
Date: Fri, 01 Aug 2025 18:45:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 fbcbd66fddd2e9ad295d6e3707e2421f062727d5
Message-ID: <202508011822.iAI0YtX0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: fbcbd66fddd2e9ad295d6e3707e2421f062727d5  dt-bindings: PCI: qcom,pcie-sa8775p: Document 'link_down' reset

Unverified Warning (likely false positive, kindly check if interested):

    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20250801
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   `-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|-- arm64-randconfig-052-20250801
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   `-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|-- arm64-randconfig-053-20250801
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   `-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|-- arm64-randconfig-054-20250801
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
|   |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
|   `-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
`-- arm64-randconfig-055-20250801
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-qcs9100-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride-r3.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c00000-(qcom-pcie-sa8775p):resets:is-too-short
    |-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):reset-names:pci-is-too-short
    `-- arch-arm64-boot-dts-qcom-sa8775p-ride.dtb:pcie-1c10000-(qcom-pcie-sa8775p):resets:is-too-short

elapsed time: 755m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250801    gcc-15.1.0
arc                   randconfig-002-20250801    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g4_defconfig    clang-22
arm                   randconfig-001-20250801    clang-22
arm                   randconfig-002-20250801    gcc-8.5.0
arm                   randconfig-003-20250801    gcc-10.5.0
arm                   randconfig-004-20250801    gcc-14.3.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250801    clang-22
arm64                 randconfig-002-20250801    clang-22
arm64                 randconfig-003-20250801    gcc-11.5.0
arm64                 randconfig-004-20250801    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250801    gcc-13.4.0
csky                  randconfig-002-20250801    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250801    clang-22
hexagon               randconfig-002-20250801    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250801    clang-20
i386        buildonly-randconfig-002-20250801    gcc-12
i386        buildonly-randconfig-003-20250801    gcc-12
i386        buildonly-randconfig-004-20250801    gcc-12
i386        buildonly-randconfig-005-20250801    gcc-12
i386        buildonly-randconfig-006-20250801    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250801    gcc-15.1.0
loongarch             randconfig-002-20250801    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250801    gcc-11.5.0
nios2                 randconfig-002-20250801    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250801    gcc-13.4.0
parisc                randconfig-002-20250801    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250801    gcc-13.4.0
powerpc               randconfig-002-20250801    clang-22
powerpc               randconfig-003-20250801    clang-22
powerpc64             randconfig-001-20250801    gcc-8.5.0
powerpc64             randconfig-002-20250801    clang-22
powerpc64             randconfig-003-20250801    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20250801    clang-22
riscv                 randconfig-002-20250801    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250801    clang-22
s390                  randconfig-002-20250801    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250801    gcc-14.3.0
sh                    randconfig-002-20250801    gcc-11.5.0
sh                           se7343_defconfig    gcc-15.1.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250801    gcc-15.1.0
sparc                 randconfig-002-20250801    gcc-15.1.0
sparc64               randconfig-001-20250801    gcc-9.5.0
sparc64               randconfig-002-20250801    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250801    gcc-12
um                    randconfig-002-20250801    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250801    gcc-12
x86_64      buildonly-randconfig-002-20250801    clang-20
x86_64      buildonly-randconfig-003-20250801    clang-20
x86_64      buildonly-randconfig-004-20250801    clang-20
x86_64      buildonly-randconfig-005-20250801    gcc-12
x86_64      buildonly-randconfig-006-20250801    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                randconfig-001-20250801    gcc-8.5.0
xtensa                randconfig-002-20250801    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

