Return-Path: <linux-pci+bounces-1204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA46781982A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE2A1F264E8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6ABD290;
	Wed, 20 Dec 2023 05:32:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100310A3C;
	Wed, 20 Dec 2023 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="143858333"
X-IronPort-AV: E=Sophos;i="6.04,290,1695654000"; 
   d="scan'208";a="143858333"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:32:29 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E44CD64A7;
	Wed, 20 Dec 2023 14:32:26 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AFDE0D644F;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.237.107])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 8892F2005994;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
From: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com,
	KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Date: Wed, 20 Dec 2023 14:07:35 +0900
Message-ID: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Hello.

This patch series adds a feature to lspci that displays the link status
of the CXL1.1 device.

CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
the link status can be output in the same way as traditional PCIe.
However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
different method to obtain the link status from traditional PCIe.
This is because the link status of the CXL1.1 device is not mapped
in the configuration space (as per cxl3.0 specification 8.1).
Instead, the configuration space containing the link status is mapped
to the memory mapped register region (as per cxl3.0 specification 8.2,
Table 8-18). Therefore, the current lspci has a problem where it does
not display the link status of the CXL1.1 device. 
This patch solves these issues.

The method of acquisition is in the order of obtaining the device UID,
obtaining the base address from CEDT, and then obtaining the link
status from memory mapped register. Considered outputting with the cxl
command due to the scope of the CXL specification, but devices from
CXL2.0 onwards can be output in the same way as traditional PCIe.
Therefore, it would be better to make the lspci command compatible with
the CXL1.1 device for compatibility reasons.

I look forward to any comments you may have.

KobayashiDaisuke (3):
  Add function to display cxl1.1 device link status
  Implement a function to get cxl1.1 device uid
  Implement a function to get a RCRB Base address

 ls-caps.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lspci.h   |  35 +++++++++
 2 files changed, 251 insertions(+)

-- 
2.43.0


