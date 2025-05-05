Return-Path: <linux-pci+bounces-27202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF13AA9FFF
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BB161B81
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E603128CF5E;
	Mon,  5 May 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G90kA/nZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7728CF58;
	Mon,  5 May 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483393; cv=none; b=rE5UpgVPohz0Al3vKN82K77KuUnSG+KZnVBRLIidkmDgLjQ9WAPtgzEAsEnSrq7NLxovMcGaXpwzYmXI8poTPaFpTbZY3zHhMU4X87o6v93VPm/RFcum9XQiXfajlrcSyNkXgqS7+S06oTxBWmeSrujWd5lrFMS2a34ZwmQa8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483393; c=relaxed/simple;
	bh=JLs8UOekNU8q8VY9XYXcwWPAxa1gJSpnuFQ3tSqQplE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuM1bBo19D7c9A50okgtbBwFGcqJLTg/rJT/FqUsVXANECqqmdRi6FH9e0i9EXPg4ZCQ83qZIs2H7CRRMIokpaVZZ/Du3fMgkVOgbWGA6nfs7FbOZaI3a9iBwS3WKkACDAUfSRS5qMf6paeZoqqtHoJr3TxvA66fU8aPxcTPRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G90kA/nZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701BFC4CEEE;
	Mon,  5 May 2025 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483393;
	bh=JLs8UOekNU8q8VY9XYXcwWPAxa1gJSpnuFQ3tSqQplE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G90kA/nZxIO0Wh4sccsobu2k9nmcyyQL4CN0bZwhbD4z7MNyTff2/sFPfweixGNt0
	 Meq+EnRs6To/Gqo7DhearAihrYAMHPoJqCvwhxkzLmbjR+AzAfxpFZ04p7CV7mMmVJ
	 7j1dIp6V7tTx5S9P6ShnJ884QHD3YImpRiUj6ZApkqZeTqEDOcS8n/xIi4LmLT1TFt
	 R0K7dqschuPccRorBJbFBayRTYkqFOfxYxhdnCF6YrwXyDrx7W/7zYKwdCKdKedA1y
	 OEu6fJKhRcCkQUdeZTjtSYzbjzwtuxDpaPAYR2dOLLs4QM4st90sDlirWj9ZCGATYm
	 w6nR31iYdpd9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 063/642] PCI: vmd: Disable MSI remapping bypass under Xen
Date: Mon,  5 May 2025 18:04:39 -0400
Message-Id: <20250505221419.2672473-63-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 6c4d5aadf5df31ea0ac025980670eee9beaf466b ]

MSI remapping bypass (directly configuring MSI entries for devices on the
VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
and hence cannot configure the entries using the pIRQ interface in the PV
case, and in the PVH case traps won't be setup for MSI entries for such
devices.

Until Xen is aware of devices in the VMD bus prevent the
VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
any kind of Xen guest.

The MSI remapping bypass is an optional feature of VMD bridges, and hence
when running under Xen it will be masked and devices will be forced to
redirect its interrupts from the VMD bridge.  That mode of operation must
always be supported by VMD bridges and works when Xen is not aware of
devices behind the VMD bridge.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <20250219092059.90850-3-roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94ceec50a2b94..8df064b62a2ff 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -970,6 +972,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain()) {
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus
+		 * because the config space of devices behind the VMD bridge is
+		 * not known to Xen, and hence Xen cannot discover or configure
+		 * them in any way.
+		 *
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write by Linux to the MSI entries won't result in functional
+		 * interrupts, as Xen is the entity that manages the host
+		 * interrupt controller and must configure interrupts.  However
+		 * multiplexing of interrupts by the VMD bridge will work under
+		 * Xen, so force the usage of that mode which must always be
+		 * supported by VMD bridges.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+	}
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
-- 
2.39.5


