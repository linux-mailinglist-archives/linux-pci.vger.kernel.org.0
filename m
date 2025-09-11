Return-Path: <linux-pci+bounces-35891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA80B52FD3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BACF1886A65
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480B3128B7;
	Thu, 11 Sep 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kfTWZwMz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1C312838;
	Thu, 11 Sep 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589106; cv=none; b=mOKvTXxRgQ2H4LhrOqi9mrBZVVHyLv7EstaouSQbr+mBjBoSP4ymWUcAPfAI4WM/9USTI7e0yFmnKyyHASkh7NS09nemPy7CJDg58In2NY/0Q3S/rUUwk6LHtKXroJKWoA4qHj6H1MY2K7zUw7T5MKWWJ4SIhps5FB8c0Jm7DDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589106; c=relaxed/simple;
	bh=ZicswJt9W2wtis1MhknedD7TIPkGFjcjQ0LmjRvb9T4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ojOb2NkPa6mVh2nYDw2BSBRhPnNZDy6KgKfHbGK+VZN3FyEIl0P71gufwhjsBuaVOI+tTB76Qr1p+NjAna0hRm4QNMQGSwuU+H9iJFqccP9adBFvtXc8m/Esy01UdLemNnbAwG4swwvK3skoSit+SqnL4RZVRjq3PUKnEaJQiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kfTWZwMz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B9jJ0L026069;
	Thu, 11 Sep 2025 04:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=IWTicSappntxUxW8mOAPYaZ
	p9rNWX5+1afQH6X1ORkg=; b=kfTWZwMzBVXE0AC8vP0UOPpw1QTW1pD5arHuVRS
	QChdJsGIPOHtEGlPxt0V6gICf8hiJbvEVfIMna1cc6i8pk7Vz/wyNf8z0nD33AlU
	MG7I3fFjM/9EoCtc6pQ1szJTgHGTruIflu3a/rykpixEElg6k85lHIL8mLGnDujw
	9srClSUfi66vR7MP041TZ4nFOGidaOobvk4YiBaseMnqmvPbWcAvjkLtjHQoq8tF
	U76Twt3eIzDc/Ur/reya7m1tqg7h0NfbXZy8pbxqhKDnta/jQRJK6kuJexSh37v7
	s3rLg25RvsZrohyK+0vrvHxerhRz3XY4OyotEqxzPrkxS/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 493v2s85j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 04:11:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Sep 2025 04:11:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Sep 2025 04:11:42 -0700
Received: from marvell-OptiPlex-Tower-Plus-7020.. (unknown [10.28.38.120])
	by maili.marvell.com (Postfix) with ESMTP id 06B463F7098;
	Thu, 11 Sep 2025 04:11:32 -0700 (PDT)
From: Shashank Gupta <shashankg@marvell.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <shashankg@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>
Subject: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution during SR-IOV VF creation
Date: Thu, 11 Sep 2025 16:41:06 +0530
Message-ID: <20250911111106.2522786-1-shashankg@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TNe00e84WmzNRu1ecvYAMyvN-lhOcSv7
X-Proofpoint-ORIG-GUID: TNe00e84WmzNRu1ecvYAMyvN-lhOcSv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA4OCBTYWx0ZWRfX2QdE/7ENdGyp fW7fUdTjyHvDylk5V9NdQJpI4WSPwktpnHUA9TiHd4Gmq6RTit0MFOngaLd2jkQj7NMMoQNL4U1 sJ2UbaKu/xPPA2+HJamuhZ+v28iA5csHDvyR2PNipb4bckoCpRfMGWQF7xGhf5tF24wtgAVz4ue
 +hI3jUt7d/Brsc/jyqUvxRGzipRi5z6/kahZ+rWqgQqrMb9iRKfUEdnfC9NbeMjZuKuGysDIIb9 7STM4k95GWA8uGy2kkLAt6C+OhlC+A6c7HCM1b3typI8iXh7G2aWCrA++qgGNfihjJRTpFbplJd eIRsXkDhMw5HC/CEIq3V+LuvlqZnl096Y9s8xwla1GI40ZOVCyhO9dEinu9J2sjgc4s2ObMTKD/ 0zSCt3Z3
X-Authority-Analysis: v=2.4 cv=T4yMT+KQ c=1 sm=1 tr=0 ts=68c2ae68 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=0muEbM_J4OP6Rna8yOEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01

When enabling SR-IOV VFs via sriov_numvfs, a race can occur between
VF creation (`pci_iov_add_virtfn()`) and a parallel PCI bus rescan.
This may cause duplicate sysfs resource files to be created for the
same VF. `pci_device_add()` links the VF into the bus list before calling
`pci_bus_add_device()`. During this window, a parallel pci rescan
may iterate over the same VF and call `pci_bus_add_device()` before
the PCI_DEV_ADDED flag is set by sriov_numvfs, leading to duplicate
sysfs entries.

sysfs: cannot create duplicate filename
'/devices/platform/0.soc/878020000000.pci/pci0002:00/0002:00:02.0/0002:03:00.3/resource2'
CPU: 10 PID: 1787 Comm: tee Tainted: G        W
6.1.67-00053-g785627de1dee #150
Hardware name: Marvell CN106XX board (DT)
Call trace:
 dump_backtrace.part.0+0xe0/0xf0
 show_stack+0x18/0x30
 dump_stack_lvl+0x68/0x84
 dump_stack+0x18/0x34
 sysfs_warn_dup+0x64/0x80
 sysfs_add_bin_file_mode_ns+0xd4/0x100
 sysfs_create_bin_file+0x74/0xa4
 pci_create_attr+0xf0/0x190
 pci_create_resource_files+0x48/0xc0
 pci_create_sysfs_dev_files+0x1c/0x30
 pci_bus_add_device+0x30/0xc0
 pci_bus_add_devices+0x38/0x84
 pci_bus_add_devices+0x64/0x84
 pci_rescan_bus+0x30/0x44
 rescan_store+0x7c/0xa0
 bus_attr_store+0x28/0x3c
 sysfs_kf_write+0x44/0x54
 kernfs_fop_write_iter+0x118/0x1b0
 vfs_write+0x20c/0x294
 ksys_write+0x6c/0x100
 __arm64_sys_write+0x1c/0x30

To prevent this, introduce a new in-progress private flag
(PCI_DEV_ADD_INPROG) in struct pci_dev and use it as an atomic
guard around pci_bus_add_device(). This ensures only one thread
can progress with device addition at a time.

The flag is cleared once the device has been added or the attempt
has finished, avoiding duplicate sysfs entries.

Signed-off-by: Shashank Gupta <shashankg@marvell.com>
---

Issue trace:
------------

CPU2 (sriov_numvfs)                          CPU4 (pci rescan)
------------------------------------------  --------------------------
pci_iov_add_virtfn()
  pci_device_add(virtfn)   # VF linked to bus
                                          pci_bus_add_devices()
                                            iterates over VF
						PCI_DEV_ADDED not set yet
													
  pci_bus_add_device()
	create sysfs file
        pci_dev_assign_added() set PCI_DEV_ADDED
						pci_bus_add_device()
						 duplicate sysfs file
														

Issue Log :
-----------

[CPU 2] = sriov_numfs creating 9 vfs 
[CPU 4] = Pci rescan

[   93.486440] [CPU : 2]`==>pci_iov_add_virtfn: bus = PCI Bus 0002:20 slot = 0 func= 4 	# sriov_numvfs vf is getting created for vf 4
[   93.494002] [CPU : 4]`->pci_bus_add_devices: child-bus = 						    # Pci rescan
[   93.494003] [CPU : 4]`->pci_bus_add_devices: bus = PCI Bus 0002:20				
[   93.500178] pci 0002:20:00.4: [177d:a0f3] type 00 class 0x108000
[   93.507825] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 0        # pci rescan iterating on created vfs
[   93.513288] [CPU : 2]`->pci_device_add : bus = PCI Bus 0002:20 slot = 0, func= 4     # sriov_numvfs: vf 4 added in the cus list
[   93.519388] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 1	    # pci rescan : vf iterated 1
[   93.525438] [CPU : 2]`->pci_bus_add_device: slot = 0 func= 4	                        # sriov_numvfs: enter in adding vf 4 in sys/proc fs
[   93.532515] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 2	    # pci rescan : vf iterated 2
[   93.539904] [CPU : 2]`->pci_bus_add_device create sysfs pci_create_sysfs_dev_files: slot = 0 func= 4 # sriov: vf 4 sysfs file created
[   93.547032] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 3        # pci rescan : vf iterated 3
[   93.552714] rvu_cptvf 0002:20:00.4: Adding to iommu group 85
[   93.559812] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 4	    # pci rescan : vf iterated 4
[   93.569002] rvu_cptvf 0002:20:00.4: enabling device (0000 -> 0002)
[   93.576069] [CPU : 4]`->pci_bus_add_devices PCI_DEV_ADDED not set : slot =  0 func = 4 # pci rescan : vf 4 PCI_DEV_ADDED flag not set by sriov_numvfs 
[   93.576070] [CPU : 4]`->pci_bus_add_device: slot = 0 func= 4							  # pci rescan : enter for adding vf 4 in sys/proc fs 
[   93.576072] [CPU : 4]`->pci_bus_add_device create sysfs pci_create_sysfs_dev_files: slot = 0 func= 4 # pci rescan : going to create sysfs file
[   93.576078] sysfs: cannot create duplicate filename '/devices/platform/0.soc/878020000000.pci/pci0002:00/0002:00:1f.0/0002:20:00.4/resource2' # duplication detected
[   93.608709] [CPU : 2]`->pci_dev_assign_added set PCI_DEV_ADDED : slot = 0, func= 4        # sriov_numvfs : PCI_DEV_ADDED is set
[   93.617714] CPU: 4 PID: 811 Comm: tee Not tainted 6.1.67-00054-g3acfa4185b96-dirty #159
[   93.630399] [CPU : 2]<==pci_iov_add_virtfn: bus = PCI Bus 0002:20 slot = 0 func= 4         


Fix trace (with patch):
-----------------------

CPU2 (sriov_numvfs)                   CPU4 (pci rescan)
----------------------------------   --------------------------
pci_iov_add_virtfn()
  pci_device_add(virtfn)   # VF linked to bus
	pci_bus_add_device() enter
		set PCI_DEV_ADD_INPROG
                                     pci_bus_add_device() enter
                                     PCI_DEV_ADD_INPROG already set
                                     return
	pci_dev_assign_added()
	pci_dev_clear_inprog()

Fix log:
-------

[CPU 2] = sriov_numfs creating 9 vfs 
[CPU 4] = Pci rescan

[  178.296167] pci 0002:20:00.5: [177d:a0f3] type 00 class 0x108000
[  178.302680] pci 0002:00:1b.0: PCI bridge to [bus 1c]
[  178.307746] [CPU : 2]`->pci_bus_add_device Enter : slot = 0, func= 5   # sriov_numvfs: adding vf5 in sys/proc
[  178.313636] pci 0002:00:1c.0: PCI bridge to [bus 1d]
[  178.318592] [CPU : 2]`->pci_bus_add_device set PCI_DEV_ADD_INPROG : slot = 0, func= 5  # sriov_numvfs: vf 5 PCI_DEV_ADD_INPROG flag set
[  178.324939] pci 0002:00:1d.0: PCI bridge to [bus 1e]
[  178.329895] [CPU : 2]`->pci_bus_add_device PCI_DEV_ADDED is not set: slot = 0, func= 5 # sriov_numvfs: vf 5 check if PCI_DEV_ADDED flag is set before proceed to create sysfs file
[  178.337719] pci 0002:00:1e.0: PCI bridge to [bus 1f]
[  178.342704] rvu_cptvf 0002:20:00.5: Adding to iommu group 86
[  178.350586] [CPU : 4]`->pci_bus_add_device Enter : slot = 0, func= 5     # pci rescan : since PCI_DEV_ADDED flag is not set it enter the pci_bus_add_device for vf 5
[  178.355597] rvu_cptvf 0002:20:00.5: enabling device (0000 -> 0002)
[  178.361193] [CPU : 4]`->pci_bus_add_device PCI_DEV_ADD_INPROG is already set : slot = 0, func= 5  # pci rescan : check PCI_DEV_ADD_INPROG flag, it is already set 
[  178.373726] [CPU : 4] <- pci_bus_add_device return : slot = 0, func= 5	# pri rescan : return 
[  178.382852] pci_bus 0003:01: busn_res: [bus 01] end is updated to 01
[  178.395474] [CPU : 2]`->pci_dev_assign_added set PCI_DEV_ADDED : slot = 0, func= 5    # sriov_numvfs: set PCI_DEV_ADDED for vf5
[  178.395721] [CPU : 2]`->pci_dev_clear_inprog unset PCI_DEV_ADD_INPROG : slot = 0, func= 5 # sriov_numvfs : clear PCI_DEV_ADD_INPROG for vf5 
[  178.403289] [CPU : 2] <- pci_bus_add_device return : slot = 0, func= 5
 drivers/pci/bus.c |  8 ++++++++
 drivers/pci/pci.h | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index feafa378bf8e..cafce1c4ec3d 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -331,6 +331,13 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
 
+	if (pci_dev_add_inprog_check_and_set(dev))
+		return;
+
+	if (pci_dev_is_added(dev)) {
+		pci_dev_clear_inprog(dev);
+		return;
+	}
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
@@ -347,6 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
 
 	pci_dev_assign_added(dev, true);
+	pci_dev_clear_inprog(dev);
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ffccb03933e2..a2d01db8e837 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,17 +366,28 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
+#define PCI_DEV_ADD_INPROG 3
 
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
 	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
 }
 
+static inline void pci_dev_clear_inprog(struct pci_dev *dev)
+{
+	clear_bit(PCI_DEV_ADD_INPROG, &dev->priv_flags);
+}
+
 static inline bool pci_dev_is_added(const struct pci_dev *dev)
 {
 	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
 }
 
+static inline bool pci_dev_add_inprog_check_and_set(struct pci_dev *dev)
+{
+	return test_and_set_bit(PCI_DEV_ADD_INPROG, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
 
-- 
2.34.1


