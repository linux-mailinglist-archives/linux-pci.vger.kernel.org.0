Return-Path: <linux-pci+bounces-42425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE1C9953C
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 603CE346657
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95629DB65;
	Mon,  1 Dec 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="abj/44TL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA656299954;
	Mon,  1 Dec 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626922; cv=none; b=MN/I7cyFhjidTX5StZ6dYhdpVP5EYsBCxDrrjUBENUXhMxGXkrSXe1EAwVSYQt0N+qFsU2nR89Bxf/Jt3mZaLju2U054h769qh3gUgQ0nFKkx2LlKF5wN4DDwpenJlyNtsvKq4o8jEk9DHhjRgQsgOoHWl/ffyrJx/Vi7R6M6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626922; c=relaxed/simple;
	bh=CL9amgpdUd6LxUEr/YT085YtohIgRDHhS18eGpgfq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/yjPHqLkjCRRXWtvOhZIFGRAQ7XHZGJWwpTMrC/lsQFE6Do4kp/xYqb0VQzwo/ueWS4GudCiV0Vf+IkckaN0DVcg+3zRWlGWPUXyW56DHt1TXKCEMTa6JQy9oTgA+GPDTPOmAhJQ1zCfSRCibn6Ie7qlz2HKDRtNCMIf2IiJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=abj/44TL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1HAuun001213;
	Mon, 1 Dec 2025 22:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rj53TWf0kuRpN06VP
	ZkUtzWBR/nSfZooR+oMGQY7N1Y=; b=abj/44TLUC/yNKk97ysAZeCu4xjpx+tJ/
	+ViSdk2XCVj6lr5btPw0DQ/s4ZNxtR/llxDCUYQ5two3zsTQhy+4kDktiFGrzHsa
	WC1RBGwKsJatTPn5BaeBN6tLLsyZXrbvMcs5Z1aa2Z0iyBSKi6ZiMaYSUu7SP0R6
	jbPyOMonZdXmaG0XPMsnAZWMpKqhkz9EMVUFiOBfqOsvpQNahYLLKOu69egZa3zs
	M/+2HrDGTQ6++TQdyFyMilVzdm4X9rd8gNKlIXKP5qrwup/morFcWnWUVYGKmSbF
	XM4mnC4X2qABR83lcekHAeOoo5mziWmAZQn4UkVx/a6qSgcvclMxQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg1s93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1IPoeu019042;
	Mon, 1 Dec 2025 22:08:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhxs0b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M8Wbw28705464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:08:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC935805A;
	Mon,  1 Dec 2025 22:08:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A69C658056;
	Mon,  1 Dec 2025 22:08:31 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.160])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:08:31 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v6 7/9] vfio-pci/zdev: Add a device feature for error information
Date: Mon,  1 Dec 2025 14:08:21 -0800
Message-ID: <20251201220823.3350-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201220823.3350-1-alifm@linux.ibm.com>
References: <20251201220823.3350-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gex42jiePiKqHBVVw0Hn9JodZhbF-1rQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX/cLA8TJzJHne
 XTLY1E92Mo8CRODkQrMzKb1W6mY8Aoh61UHORhXrJqgJzfZpI1i4wazXHC54DmmLgA5ByUPb7UX
 RrxAraqy9ebGLCTPfEFi/kKzL21G9Dr+8yEMzx0RVAQz6ERSQurlPMU2MesIap3mR4R8EQfm8ao
 or/ohyNrgqwkcXYIPbVwDKC7DjVfybUDbT9NlYwzWpGs+3OPUK74vmubth5+g/Oyu6t4DDi9uNB
 TpEtWDd8qTKmqADMBWSiTxMGwLjfGkJZMvG7VgP54ibQLTXsGR8e43Upktes92eCsecMNkmwK9k
 9yqje8GOtC3zuMmkEmtQxxcWHKBUvlAf2D8TdF6MPkAYvMFp+70MF9tnOBcpf8T7d4EfUJw4Y1i
 knZPeBBFmHwnyYfcEqeFnD6GQ1Zzcw==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692e11e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=QIy8Zix3hhx26zbqT_4A:9
X-Proofpoint-GUID: Gex42jiePiKqHBVVw0Hn9JodZhbF-1rQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

For zPCI devices, we have platform specific error information. The platform
firmware provides this error information to the operating system in an
architecture specific mechanism. To enable recovery from userspace for
these devices, we want to expose this error information to userspace. Add a
new device feature to expose this information.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 34 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 15 ++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7dcf5439dedc..378adb3226db 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1514,6 +1514,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
 		return vfio_pci_core_feature_token(device, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
+		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index a9972eacb293..5b7c9cbeb733 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -86,6 +86,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 				struct vfio_info_cap *caps);
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)
@@ -100,6 +102,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 
 static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {}
+
+static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
+					    u32 flags, void __user *arg,
+					    size_t argsz)
+{
+	return -ENODEV;
+}
 #endif
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 2be37eab9279..261954039aa9 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -141,6 +141,40 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz)
+{
+	struct vfio_device_feature_zpci_err err;
+	struct vfio_pci_core_device *vdev =
+		container_of(device, struct vfio_pci_core_device, vdev);
+	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	int ret;
+	int head = 0;
+
+	if (!zdev)
+		return -ENODEV;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
+				 sizeof(err));
+	if (ret != 1)
+		return ret;
+
+	mutex_lock(&zdev->pending_errs_lock);
+	if (zdev->pending_errs.count) {
+		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
+		err.pec = zdev->pending_errs.err[head].pec;
+		zdev->pending_errs.head++;
+		zdev->pending_errs.count--;
+		err.pending_errors = zdev->pending_errs.count;
+	}
+	mutex_unlock(&zdev->pending_errs_lock);
+
+	if (copy_to_user(arg, &err, sizeof(err)))
+		return -EFAULT;
+
+	return 0;
+}
+
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 75100bf009ba..d72177bc3961 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1478,6 +1478,21 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390x. On s390x PCI error recovery involves
+ * platform firmware and notification to operating system is done by
+ * architecture specific mechanism.  Exposing this information to userspace
+ * allows userspace to take appropriate actions to handle an error on the
+ * device.
+ */
+struct vfio_device_feature_zpci_err {
+	__u16 pec;
+	__u8 pending_errors;
+	__u8 pad;
+};
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 11
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0


