Return-Path: <linux-pci+bounces-40568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F5C3F221
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B92D4EA061
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9452DECBD;
	Fri,  7 Nov 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Thb4hkgm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ua+h0Jyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6682BDC03
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507371; cv=none; b=aPlkVhd0mv04t8H8Mn4nwcczNkcw+W4sS+0zCmduH3vIASGeJkQJvWyRFXk+u9VG0vXVY58LsSa7pEIHp75EcSXbHtSy8TtUTkn9zCFlJt80LJhXxwU1BMIZkGHe+nE3Oh4BzPqnOP7Hf6AtlSx3dqqCBoZ3b26STqBjvSAMBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507371; c=relaxed/simple;
	bh=EX9CO42W9zASCP7kuRRumTSBqNb2BX6/t1dIqzeTEI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooGdjRx2R0fenFo1SpjznTpoa7l1BzOKHoZ0CYhBeBeKlQIkHr+7eaQ3bYySG2UdMMF16kUXX/QBZrcQFgVS0TFt6K94oQkJyTuB9E1icIC9rcELoCPe3MOJaod+33+fUv5avYtg8Z63DmxVDbQshi4IefZZq5zG+tqjVPfY6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Thb4hkgm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ua+h0Jyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A76v9YK629489
	for <linux-pci@vger.kernel.org>; Fri, 7 Nov 2025 09:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LTJqcQVogypE+VMJXFPv9QRbTKEt95A1okWlbeu31VE=; b=Thb4hkgml1QDx93a
	9oTSjtEPqQrdmgSXUoX1rxhmt3O+qRVldGJNSk+MSLFNE06x26YLHZ4key+KIowd
	xIhzuNu5yBWONIlEAfkkFAUrUngr+NQ7GAV6ITynFjEyONcXbY+LcHB3EO6YOigV
	WES0CrUjDgxBFvQSrCBaRpkLtZ9TLJZQl5jvONbEq5/o3TAOQrwKUMIQhwQ8arNf
	jGX1W3oZiof4hr6kk04yc5IJZvA+90MoL6uHfF7HoNUJXf2r8bCIU1I7/DQXrXvB
	FK8Rl1ZhZKPU76LwXTQ/AGEIz51vUv4MNQqOewrzGuL5ZtlG7lk+2/8V1tzT/h1v
	v1B8qw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9223222s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 09:22:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-286a252bfbfso15499565ad.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762507367; x=1763112167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTJqcQVogypE+VMJXFPv9QRbTKEt95A1okWlbeu31VE=;
        b=Ua+h0Jypy2f824DQaJa1BLJe3TQwTko2oYxcm0OAkdzZr+bSgs9BXWZyzgFWIUdsUw
         //I9PeaT1MuHqMzpaB7ZY+KF0wgtr5ZAxto8r5N2OPHlwVkqFLenkT8EvXzC8ti42qbK
         yPhmDAL32fonKkEf7Sq2g1QikLK1u2YbTExrSKQr9s2iwDEacYdV34MG7CiwAOkNk/zn
         HWmD9FHBtibHnC9+W1sNkaJt1iCdPQ/g7WpSOP7bBFol2TXGYPzkSzCH1UbEYguoKd9H
         fI0lCjXpDvGq/3gUigVpbVcVv/gXfA1ptE/AHMO0yL9L8jvsuKtZhWo5GEwdz4szQngm
         7bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507367; x=1763112167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTJqcQVogypE+VMJXFPv9QRbTKEt95A1okWlbeu31VE=;
        b=i9f4CWXYgRMDigL4fCeeKJBGxJZncQuKaDR7Em381fRRUmw3KQRUScJVkh8GuD9cps
         k0W7WBxfhk3W//8I2972EzjImkoORfLVBxu/XpsNOYbif8NfPj3I9VSY4M5pJmgOqQ8Z
         QOYFv0qSGjPgevMaBuSO9w53SiUw6NZllSjQo/8CO7uEzndrRTaAnIWbkuKPGjARdpyW
         A9to+SSI7KuQJbQkhdG+fmwWzjuUwQZ5G6VjEecldbuXXdwY1vNvMExdNuTkWtpOlTpG
         V31h2P3321C2esbNESWRWjyjDpcWbdjZbx4Y9BOQWKPKxkLTgb5qN7+MPIMlUhqKlEXp
         5WVg==
X-Forwarded-Encrypted: i=1; AJvYcCXtJi9ZUEOY/J3CgQuoC+BU08Sf4e7M4EjSJZCxydwH6FqlXegYF2bVLTE8BFoLGnpaOl+vnISbGa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys36f0MEIk4brrsRyGja2NVcU3RO3pIsMBFvTW6DUH05kuC8+l
	hfuLte4DSMq4MPKJqyQguX3mKtOj0Fdcf16AQrRcqBkozHneH4Eqt2K9kB8AT06rqrJQSzeyo8l
	vm0gQFyLqIg4yCXb6d4vUUHgmdZ+M6sUZ4ZEvmkDm08T+ROhuUNGy87feGRYdoIA=
X-Gm-Gg: ASbGnctprd34en5bQgFD4vp3dYhU7EbwIIfJJlwLXutGCNSw8htAIkp6/xNL1pJB3go
	2buOqZl5JOxSjA91AiHUg4lAvq/eGkXF6+cRrJAGR4sN/lFtDy+BozBEAtQP9rJGeSCoXMgKm/U
	ggbSaccG/O2bLJWKgDJyIY9LTIo1+Yi5MoO+xEnppabDcsXDU67OcNuwh56uCwGY88NJoc6EsTu
	7Q2FiwASvzisPngD4tAA6ZPFfT79sEcaKykLihA6mHQvb0MElT9m0+b8anhOFIDXxwlko4ypKQf
	UD/RChlT7AHziNhAwyVRtJply6BpI5jB/DRa26/ojp4ltSOnW4miwsQYWROntkLnCZyaM9Khycu
	GP1vPYqFFftGHqUp3byPzppnKJqCMHpeicg==
X-Received: by 2002:a17:902:f544:b0:295:9e4e:4092 with SMTP id d9443c01a7336-297c0485f18mr34795585ad.56.1762507366774;
        Fri, 07 Nov 2025 01:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFSfz5KQv+/CPlazxoGvvLLirFeMduKRG942uUWu6GGKW8x0JbcpQmTWfS/Vf8VzkyNThkMQ==
X-Received: by 2002:a17:902:f544:b0:295:9e4e:4092 with SMTP id d9443c01a7336-297c0485f18mr34795235ad.56.1762507366225;
        Fri, 07 Nov 2025 01:22:46 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c747d1sm53241585ad.63.2025.11.07.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:22:45 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 14:52:24 +0530
Subject: [PATCH v5 1/2] PM: sleep: wakeirq: Add support for custom IRQ
 flags in dedicated wake IRQ setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-wakeirq_support-v5-1-464e17f2c20c@oss.qualcomm.com>
References: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com>
In-Reply-To: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762507357; l=5135;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=EX9CO42W9zASCP7kuRRumTSBqNb2BX6/t1dIqzeTEI8=;
 b=Jy/gD9ALilIOqnoUDLx+tlaHC8TkuVcWUEJeo84PJrasc5IXWte0Z51RRSvWFWNoa1nf5wTWM
 wxMduIvy4akD6JLNmjjhdY1/gaStsNbckN9o3x2YZfKPw1gu6oCTh68
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3NSBTYWx0ZWRfXw+B1BYruKDcv
 r+wVWjUn2mtZNZi+nH7gWja6OYi1m+sKgwdGFILqTIacY9pMQ4r9PZrcZBRuDdiHTifL78GzQp4
 SLXjCMfzzcLXAO8iblK/cvhkjuENfRlqPSgEXz43rYs68qyX+zGp2+un+RwltnquGjGqFsNJNv/
 D44RNo2GW2pJMFCH7vNXXpiFXYtIpdvm3N4ELiEMqBwpsredN9ePH0NrtXj3XU6wJuQNqATqIzs
 hs/fYknMpjXJ9sElw+OwUFDB0Y0208Y0ypteZtL9VeI+hLtTdX1s/BhmYM5REtkB3JzZ17AfXv4
 r+jVVq230L+c01Y7XsAVig7/Hbg8ckMC/YOzd6MwC5IfuF/WQsLxgnRQd8Zq3Huefk7lMWjl4oB
 HRC0SlbBNl7uGLWPPgmOfyK/M33OVg==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690dba67 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=I2ZlD7AWKVb8eD_RQPMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: NJP5uhKJl6dGCURHRhFCvUb5_TXLj-yk
X-Proofpoint-ORIG-GUID: NJP5uhKJl6dGCURHRhFCvUb5_TXLj-yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070075

Some devices require more flexibility when configuring their dedicated
wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
This is particularly useful in PCIe systems where multiple endpoints
(e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
line which requests platform to re-establish power and reference clocks
to the components. In such cases, drivers can use this API with IRQF_SHARED
to register a shared wake IRQ handler.

Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior
by passing default flags (IRQF_ONESHOT | IRQF_NO_AUTOEN).

Introduce a new API, dev_pm_set_dedicated_wake_irq_flags(), to allow
callers to specify custom IRQ flags. If IRQF_SHARED is used, remove
IRQF_NO_AUTOEN and disable the IRQ after setup to prevent spurious wakeups.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/pm_wakeirq.h   |  6 ++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b2891f3af490175362cc1a759069bd50..655c28d5fc6850f50fc2ed74c5fbc066a21ae7b3 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -168,7 +168,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	return IRQ_HANDLED;
 }
 
-static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
+static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag,
+					   unsigned int irq_flags)
 {
 	struct wake_irq *wirq;
 	int err;
@@ -197,8 +198,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
 	 * so we use a threaded irq.
 	 */
 	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
-				   wirq->name, wirq);
+				   irq_flags, wirq->name, wirq);
 	if (err)
 		goto err_free_name;
 
@@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
  */
 int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 {
-	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_ONESHOT | IRQF_NO_AUTOEN);
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
@@ -255,10 +255,43 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
  */
 int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
 {
-	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE,
+					       IRQF_ONESHOT | IRQF_NO_AUTOEN);
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
 
+/**
+ * dev_pm_set_dedicated_wake_irq_flags - Request a dedicated wake-up interrupt
+ *                                       with custom flags
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ * @flags: IRQ flags (e.g., IRQF_SHARED)
+ *
+ * This API sets up a threaded interrupt handler for a device that has
+ * a dedicated wake-up interrupt in addition to the device IO interrupt,
+ * allowing the caller to specify custom IRQ flags such as IRQF_SHARED.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int dev_pm_set_dedicated_wake_irq_flags(struct device *dev, int irq, unsigned long flags)
+{
+	struct wake_irq *wirq;
+	int ret;
+
+	flags |= IRQF_ONESHOT;
+	if (!(flags & IRQF_SHARED))
+		flags |= IRQF_NO_AUTOEN;
+
+	ret =  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, flags);
+	if (!ret && (flags & IRQF_SHARED)) {
+		wirq = dev->power.wakeirq;
+		disable_irq_nosync(wirq->irq);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_flags);
+
 /**
  * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
  * @dev: Device
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index 25b63ed51b765c2c6919f259668a12675330835e..14950616efe34f4fa5408ca54cd8eeb1f7f0ff13 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -11,6 +11,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern int devm_pm_set_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_wake_irq_flags(struct device *dev, int irq, unsigned long flags);
 
 #else	/* !CONFIG_PM */
 
@@ -38,5 +39,10 @@ static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int dev_pm_set_dedicated_wake_irq_flags(struct device *dev,
+						      int irq, unsigned long flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */

-- 
2.34.1


