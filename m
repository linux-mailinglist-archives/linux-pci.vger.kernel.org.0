Return-Path: <linux-pci+bounces-42197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6969AC8E526
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513943B0E96
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AC332EA8;
	Thu, 27 Nov 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvbaIS/a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gy61j8XP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B5332915
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247604; cv=none; b=NEZ9d3RKG3+oXcXRhtpRFmEGNt04zMO7v2P1JMSmY7fKGJf2CDfUSv8EY3hvFty00CU9E09zNBFo4ASnIJizfvgQlPk4deAE8aILpPoeKjW6EmR+0TZ+tPvQGVSG8F5W5m5cSqfrKUdPa2zD+9+Fny8oNJTj+LS1OuNVr6VfPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247604; c=relaxed/simple;
	bh=0ZZR9Iyjfya2K8NH4xP/NJkk24d0xMXRX0RIexl1SjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaZ2uq74n1uyvrnKU6eJZC0KQDnIc+glFkbXrfSTDvqCUEaKCErYpl2Dc1ABJf20HES/azSgWW0BLKzmnJsC3KUIb6w7N9NvJQV35dwTVPkG158licA6PvXdEfTglEayReXgUaLgPFD97NcZs4OHxRKjRoUcJdRbiAQNOlDHoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvbaIS/a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gy61j8XP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR7fbtr2388033
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i4IBizWS4T0Bcf18jiu9N98sYYZFoogd/8z9WMrOpP8=; b=RvbaIS/alT3IKl5w
	hJ8aWP1n0TXKL/AUrqpv7SRytAjXDfgMXC/y6BVOPW4xH2AB6DLqIw4yLzlGnKyd
	rJCQbhi1o4TN0Cc/xxYGEZTAvg2JGz+70Gz5dRnatBLYmCj2sxBFtDyGljL0zkLa
	pmBDnmx0/0jIvS8EwjkmKjqBFCUrWNIsCoKBgSflisAEFLLtn4CjzwLxD3mlD1fv
	IoKWbs8CwrXfUk05UPoVV61MmxeK+yDEu9O854eYFM4PtWjRrGOJRGx2ulJ/2eJU
	BA1NxF5Rd6nCgdbobV81Qd1RifvLV78+i0abpwoCUgtP4NI2NOrt99ARQT5wsjOv
	THVEAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap7n8je96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:46:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-298535ef0ccso9846095ad.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764247600; x=1764852400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4IBizWS4T0Bcf18jiu9N98sYYZFoogd/8z9WMrOpP8=;
        b=Gy61j8XPS77T5dILEKibDeOCKhQ/irxjaU3SRdyQ+zmHm4kJBJSxcq0HAZ98Mem1jV
         9leI8oJuIFurt2xk+Az83IMf/9c/pvXOvDFWI+2WMIvWvAZpYd4uwXPO+587+C6QxORO
         m22pTqYx+dB9dIGpil8/Lp2HWAtATseLLE5lFoURz17BFk3ItcKwS1kweJIFuiTIiVY9
         Dm8NXB7YHyUSRWEiiLFaTqtYV3KYEMOnJOnwuKwcxqzrJtwc5ZdaWCl/xLA0kl4VUGuR
         bw9YzvZ78OE+kYb9hupWLpUlxt1nMBoNCd4d025xBAaS6O6EvIza8HY0+cldZX/g8wS4
         hIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247600; x=1764852400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i4IBizWS4T0Bcf18jiu9N98sYYZFoogd/8z9WMrOpP8=;
        b=E5FEPaiskmUzTRbMBhHFl460RrJ4JU5ko01/IivQt3GOm1N2H29DQmBVKI6l9M+OaB
         44UsMbgf6gGYABOJ8a7HBhuVA58uYmIaWPaintlMXaxJJooLmf0Qj99XC6Pi8vsupMKj
         OSU7/ObTKnA62epzrF27OFXs8S6WPW0Oc2Hj7E/Lnk4zPAF1ba5iGVGALs0N3LK6LkAm
         BnbrP+ElRn75KRhmNNaPLpxrrglbHsB3Qkk7nwc7GzOD+dvwWvjXoBhmwb0OIC3DZbwV
         1XtUXiveD7eKWvSJp7uh5YYL8+Z/P+6P6H1MWTJJ6rlTnnD+YvvS4FgETj/uy6aJvWhK
         G3ow==
X-Forwarded-Encrypted: i=1; AJvYcCX55ztMqWQdXsKWFsM84VEWdKKs9Uj+CZ46ypWnG/5llx4aTEMWfJ5U8NWZ2UAwcOg3Vb9MyGDK3d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZo3APrFiQrRIsAkMN6NRVxm158Qj6la+Q/TAL3WPKsMQx2BG
	x1QZ+OHWIxaep5lhgmx1oOggcoSZjovFpOOrihjNl3EQQvj1bsi8vehPUVXiC18QCdcDetSo/F9
	yAf86m6nq6jfy4p3oXZLH2lLwnoQmh8MpuIY45oSnahsqMwAG+JOSK5G9eGQl2tw=
X-Gm-Gg: ASbGncszOYiun6pQY6hzm9fP9MK08nh5Hseq15kaY97O2JGCX2DDtOUH8Ir706C6I8x
	wpDBVjSAA3MUaP4mIbWOIJQAy+5D5eqZiPzHPnpbSOUZMuTMH+8SNmKmXRq9jy28kCEZPjEZlXa
	D/ggsFfrk9O12d8SCePXTx6keYDq7a1x2JzHGvf4RAJIvgppxSFOrOEHEa6JEBvwDxHQZvf872f
	EJ865rdBJnlqPUePvTVuwnt/SCePDVVV9rdnyUVOAZsMUOHfIhalKAZhpj/POu1CP3WRpFCzkSp
	k9rPzZKmLz27RfZdGtAi0wNRDnXUHu8oy7tmA7o9SXGBOBlBlYpQHsolcHKnDJ6CYEEoBkpme77
	x8X2a+oe5nN5XoclyoazbpFaO0UrpYwjWLFJexL+u3HNd
X-Received: by 2002:a17:903:11c5:b0:295:ed6:4625 with SMTP id d9443c01a7336-29bab1c50ebmr124825085ad.47.1764247600331;
        Thu, 27 Nov 2025 04:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc3yDJaJQbgjb86MURB7UPgck1TLqpQ1M7PnIsNsJjXOGIfHGQ3iljRYomVfUCpKRNgJzfhg==
X-Received: by 2002:a17:903:11c5:b0:295:ed6:4625 with SMTP id d9443c01a7336-29bab1c50ebmr124824825ad.47.1764247599837;
        Thu, 27 Nov 2025 04:46:39 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b66c67sm1951332b3a.13.2025.11.27.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:46:39 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 18:15:42 +0530
Subject: [PATCH v6 1/2] PM: sleep: wakeirq: Add support for dedicated
 shared wake IRQ setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-wakeirq_support-v6-1-60f581f94205@oss.qualcomm.com>
References: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com>
In-Reply-To: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764247587; l=4910;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0ZZR9Iyjfya2K8NH4xP/NJkk24d0xMXRX0RIexl1SjM=;
 b=pw2b+cvs6r31OeQvIyJPQNPpIwO8ahz6omEAkVre9945ogrF+Da+mrNSLzF7dYoz9SdCYULHf
 A/1n+qv71UFCRH6TFQL7IoFPfLPxbju/15EV/eFTG2CuShZoDkjtGJp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: PluLQ6XzAvJRoJmYsaFPF2UK2haBxjsN
X-Authority-Analysis: v=2.4 cv=AufjHe9P c=1 sm=1 tr=0 ts=69284832 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GqrSgIjjxmp09zFQf4gA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: PluLQ6XzAvJRoJmYsaFPF2UK2haBxjsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA5NCBTYWx0ZWRfX5amvM2Rlzbjy
 X4dMy/tyq9eZV/yeGBHk32OAosd8rDn4HCOb5VrE4K0GD1fMdAvCQ7U7/sbSUMmsGHHK7kq328d
 IVApa/XZRriFmE47KoD/HOHkL04iYUOOCSmI6g/EPqWkOKTpad426nXXj33pgcq2KRH85SJBV3L
 dgMESjNIF5z0L/Bu7z5ROPaR5OmXGv/RtCfun1PXHy12TsQh1JozpXXFcwyoavu41XHHnQbXjJA
 8rcvvIEW3E1ypYFTC2KLQIKczQdDEuenzABmavcGqznPvQrnSva/8sGGa9raIbDC9oE0RrNBQCf
 f8yPQ7MQHaCw+yq7wk7SPtm7KUzBNjpdKc0/u5j+lAgaE5YCe5T+4np62r5oETMCIq5sxbVGY7z
 oxMfwl25+P3mShBuFAMk7YhglEkp+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270094

Some devices require more flexibility when configuring their dedicated
wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
This is particularly useful in PCIe systems where multiple endpoints
(e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
line which requests platform to re-establish power and reference clocks
to the components. In such cases, drivers can use this new API
dev_pm_set_dedicated_shared_wake_irq() to register a shared wake IRQ.

Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior.

When IRQ regitsered with IRQF_SHARED we can't use IRQF_NO_AUTOEN flag,
so after registering for irq, disable it explicitly.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/base/power/wakeirq.c | 39 ++++++++++++++++++++++++++++++++++-----
 include/linux/pm_wakeirq.h   |  6 ++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b2891f3af490175362cc1a759069bd50..df34a891d54bec8737a3ef174bdfa469c19133c4 100644
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
+				   IRQF_ONESHOT | irq_flags, wirq->name, wirq);
 	if (err)
 		goto err_free_name;
 
@@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
  */
 int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 {
-	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_NO_AUTOEN);
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
@@ -255,10 +255,39 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
  */
 int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
 {
-	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE,
+					       IRQF_NO_AUTOEN);
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
 
+/**
+ * dev_pm_set_dedicated_shared_wake_irq - Request a dedicated shared wake-up interrupt
+ *                                        with custom flags
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ * @flags: IRQ flags (e.g., IRQ_TYPE_EDGE_FALLING)
+ *
+ * This API sets up a threaded interrupt handler for a device that has
+ * a shared wake-up interrupt in addition to the device IO interrupt. It also
+ * sets IRQ flags like IRQ_TYPE_EDGE_FALLING passed by the caller.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq, unsigned long flags)
+{
+	struct wake_irq *wirq;
+	int ret;
+
+	ret =  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_SHARED | flags);
+	if (!ret) {
+		wirq = dev->power.wakeirq;
+		disable_irq_nosync(wirq->irq);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_shared_wake_irq);
+
 /**
  * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
  * @dev: Device
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index 25b63ed51b765c2c6919f259668a12675330835e..61f1e840745b56baa57db37563e450cb2d757a85 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -11,6 +11,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern int devm_pm_set_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq, unsigned long flags);
 
 #else	/* !CONFIG_PM */
 
@@ -38,5 +39,10 @@ static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int dev_pm_set_dedicated_shared_wake_irq(struct device *dev,
+						       int irq, unsigned long flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */

-- 
2.34.1


