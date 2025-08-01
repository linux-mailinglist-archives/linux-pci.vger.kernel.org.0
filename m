Return-Path: <linux-pci+bounces-33284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8547B1808A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E7C547284
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783C2405ED;
	Fri,  1 Aug 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMjT9RvH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1C240611
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046007; cv=none; b=sPg9Oh0WixJ9eXVOEFOUt2ha4nfhfmycYg1wkLxCNBitLD5UCDwwV+mqu9fY9lS5rC7Cx4Qa8da8nbkiL4xoN/AMSSWrhe8RrGGP6OlBe+DR/lSu9KLqPA80MtK1UpL+YN9OW4rCKolVODo9QIO5LWYTQyAhhuqt6QlRkaqvtnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046007; c=relaxed/simple;
	bh=LnbQg2sDe0pqchIakyRVwGVYUjeMZzMPTINu0g316oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpUB56tj2X0ON1iWkRIV6wpRMpx2cLzDjUgpigAiVtNNGFOTouo4q6VG1q5GxledZY2yuaqF5mfXKi/OAahWnnJiKTF3zrp5iUvAI2ERfXBYz3IPJ/FE0XwF0b/Gn4nQaVc/AWqOiBPkri79caVzYKb9Op9S1M3/fEvK+gVE1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMjT9RvH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719ER2H004907
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2025 11:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iOs/tTl/xKfZcN3YtOj2BRULWxgX1Hen/AyY+WRXmYY=; b=pMjT9RvH/m8D3pdb
	mhbRRgQhVSQxrWI5z4/NrJW3cJRilwy+0PmrV62TKpjpinZYLPRKIjPffwBHWwn/
	AuUTL5rOKIZq4ePRYdJvahcU+F3HK4gay19oyTP64FBpny620wF1NSE0n3tctZS9
	xKtJVqbE3FZSPzvoV5rYyaIDAAt2R/Ov+DPfvWmKfEe1tA4y9RELetq2srTwvx5I
	bnw+7wrDymYir6yVKW2rXQL0o6TuNu7mdW7afDZdFFGwnExulFoXklG8VbrodZjE
	uKnK0f/Z/0nXGATQ+frOYDRDf6N43D0uyza+y61N27fr87+R6vOLxaCxSI8/kRe0
	+sGdOg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86bw9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 11:00:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400499ab2fso17124145ad.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 04:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046003; x=1754650803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOs/tTl/xKfZcN3YtOj2BRULWxgX1Hen/AyY+WRXmYY=;
        b=l0/EIQa6+uj8nvN3GR+RZjKp0tvJiLfInPzKM2oAua9rWm94NP0PPhC2nX3gPTfmEH
         0a25hDqbO2xe3yvX3H1UO+eIsfld/7lJmeSmoM5iPVR/6+f5EibSwjzCnKx9SZEQpa3o
         mTOU4LFQmPK7nbRN22Htc5M6cwAAuNs4VQ9m6kbme9oyJQqBodtuLjQ5qq7SKRgqvPNx
         tofjM2vGruAxmbn/mfwHxWtd6G0SiuGqPkJ5SMn7P+EU+sY95eCgQctihovURN0T5/8I
         U8W0nQZqE6wUrUKL94ryspaxE9TNWzKpZN2PBRM0EUbYtTPGC7Tt6x9afLC69qF0Ffo5
         8PeA==
X-Forwarded-Encrypted: i=1; AJvYcCV36PfpgOoW/8OBO70Db2ZjxWc4V0mdt8jAMLe5iJZWZYmGYuI7LGFk/xGdewd1S8rOT+FIv+ZMynI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjv/9jY/QXRK+H3RjIJZ6wh9xudqa92bUfKHDlHWMbnV3tZlgS
	xq7U2vN/b/UvMu0fA4L7LibHcAkCbMLM5MeRrx2mXuamFaTqrSaNwaO+ZWuur35rJnzoNUpNsSx
	5iK07H2Lp2bs1+KbDDUPdmbE95u8vpqnYgDES44HPABzD06Wx86YfDk1mvmQvW2s=
X-Gm-Gg: ASbGncthSl3/PfnVz5qtLJsJo6BsoByROMibcNCjWfBz+y/Dww1ecoBxb0SWfl8TbU+
	ZSV2nMxqb4mONSf2sDtnoCOrCQ62gWKDtNa1rP+Ho1M0Ov6WAJ0M5XrAGFzbL2QhBoF77MRAel+
	5IeDZDkeiUbXmn0dSugOyWMv4dwJNtEwN1Icme79fYvq3Qs7iY3Rj3DHH2IhnXgiHgAhLydULjF
	cXgsnwjOsedBRF3+3Sj5r0M9rNz2zZghQ5iO1SfnY8B09/XutmFDriB9Ke7VS+Bt8eLUc0c9r8f
	Oct5y2fT3+wBRAS5Ngs6LJpKVmSon5GKyrWMhpaquf/3jaYkIQN9Gy9ug6drth5eaWnceWA/6Dc
	=
X-Received: by 2002:a17:902:e786:b0:240:41a3:8e0d with SMTP id d9443c01a7336-24096b1fd84mr163736315ad.36.1754046003009;
        Fri, 01 Aug 2025 04:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1oklYkkLVuvg1lUtd8rA4DNw1Seyh/RpKrSPQnHDnpw4ds0kW0/fxyTCKKQmXfrV/KuX3tw==
X-Received: by 2002:a17:902:e786:b0:240:41a3:8e0d with SMTP id d9443c01a7336-24096b1fd84mr163735735ad.36.1754046002514;
        Fri, 01 Aug 2025 04:00:02 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm7154395a91.26.2025.08.01.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:00:02 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:29:43 +0530
Subject: [PATCH v4 2/3] PM: sleep: wakeirq: Add support for custom IRQ
 flags in dedicated wake IRQ setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wake_irq_support-v4-2-6b6639013a1a@oss.qualcomm.com>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
In-Reply-To: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754045985; l=5089;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=LnbQg2sDe0pqchIakyRVwGVYUjeMZzMPTINu0g316oY=;
 b=dRzVe3xH76u3yaU2qJkF2Tvf4F20Kw17oEh9rcPNjEMDT8IKfWWqeN4Gyvw7jMhohjC5xGGg2
 DN9X4DkY410CqB8TBKkSP6iSRU9w3h8l2N/Cpw+KLjn7JE+7yMA9J1n
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4MSBTYWx0ZWRfX9OzSwFTHjWqV
 4ZEoRg8PegC8w0HVXC45fivZZHbKbasNw1afqQNHiIwlMWSaKldoPgGRg/D3P6M8SJIamUnBPJU
 Au7nMjrflyYJGPl6B9C0clBcIv7MueEntgXqtV7g+4Az4j0xMvfM96Q1d8cgVBXJpzHOQtpwI9q
 Idn3cnrUa0FdapyF5EyIgsbPMT8yxo+ho+Hj0OF3zFUY26icCMIovqJLTfxjLqIS0in9ck1DSJi
 D7lhNhBH2IWkldkwI35p41pihLacnZg7TIsWBL6Ygs4z/mBpiMCb3mD/SHs8tN23FADORtiDBXg
 iiDexh1I+KeSJhfSQVjH6JUnRnamdxNq4vilfAKxCZow/B1T1UrYg17q+r4zm6Tls/RDPWe4gT8
 Dv8ADkVc3UCXFj/L+Pj+XqEeMATjC08UWLSGAkdlP2MF2XZIqwRoilo8/7LBuFTvPDQk34xb
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688c9e34 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=GqrSgIjjxmp09zFQf4gA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: yfFIz0oFGe5DCGdT-xipU2vEBAD-y_J0
X-Proofpoint-GUID: yfFIz0oFGe5DCGdT-xipU2vEBAD-y_J0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=683 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010081

Some devices require more flexibility when configuring their dedicated
wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
This is particularly useful in PCIe systems where multiple endpoints
(e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
line for waking the device from D3cold to D0. In such cases, drivers
can use this API with IRQF_SHARED to register a shared wake IRQ handler.

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


