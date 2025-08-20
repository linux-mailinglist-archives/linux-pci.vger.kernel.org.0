Return-Path: <linux-pci+bounces-34343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818AB2D54B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEE51BC722A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F02D8762;
	Wed, 20 Aug 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TyroSmEu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA8237A4F;
	Wed, 20 Aug 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676700; cv=none; b=nM+jOQka9T0IM3wB+PghW5Q0ENupOy7+umz96cOsyozPIcRXtNWcza2hdUuLWu4rxWj3ZfqeDeJo6plZgRleqdtDsG/V4hVbKIx3Uv2SMPLxSRKpO7CLYN3R06k2jv1yYVTiie3eamJ5Ojjdmkw79kPcwa9ytRt5k0KILFoB02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676700; c=relaxed/simple;
	bh=VswK+T6lrXX8TBMHScYShK1aPc7/uYZrwhvm7c2S5a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZLV7Du7mqPkAAUgDbu7P4ReBiJ2rEodqFCpUO904MU1PM1Z6IWxSOscSCt4QubxX1wF4zkQxdAE/dzsvbJo4UcYoopevGMnhinw5dyF9UAPLZRATC9P59+r1GWJRHKj9xC86yHlnkc0OJDODc8mmT7n+ZbxAwrPfeYXKfGqnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TyroSmEu; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K7ONlA019376;
	Wed, 20 Aug 2025 09:57:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OufJCp1rsW8Y0CwW3FwQWRlgvOGtMFrmPlUPtX/3tvI=; b=TyroSmEuVdY6idAu
	OUnsV10dWfwzxPh5fPhQ6+8E8xUWkWZP6832cHrI2t1ViE7R29zInci/QfN8HW3T
	hWWol3Mr2JDufPAq/7kWOCHOEYSiEk22TmSapyaoWsSwgg9HSr+GMNTyUc8IiqLy
	DpJbC63vdoGNdCvYlfXR7GemBqlMbdHIogrJ8yygrOSTDR60tetEPVxzVUlxo7QA
	SLBvfNzmzhQ9TtDy36T5zTDLAk00KmGsZQn1sA8kwieVVE5/sXfhg/q4Av/cosTW
	NFHnCX1/QhnRb+Aa14jFIQjZX9nFJz7xzarnAAmv+hX8xx2EKV2q3c2AYQ2u0vJw
	5Zk2eA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7548wy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:57:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E76E540046;
	Wed, 20 Aug 2025 09:56:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D32C475830;
	Wed, 20 Aug 2025 09:54:42 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:54:42 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linus.walleij@linaro.org>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <shradha.t@samsung.com>, <mayank.rana@oss.qualcomm.com>,
        <namcao@linutronix.de>, <qiang.yu@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <inochiama@gmail.com>,
        <quic_schintav@quicinc.com>
CC: <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v13 01/11] Documentation: pinctrl: Describe PM helper functions for standard states.
Date: Wed, 20 Aug 2025 09:54:01 +0200
Message-ID: <20250820075411.1178729-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820075411.1178729-1-christian.bruel@foss.st.com>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01

Clarify documentation for predefined standard state names 'default',
'init', 'sleep', 'idle' and their associated PM API.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 Documentation/driver-api/pin-control.rst | 57 +++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
index 27ea1236307e..204cc3e162e2 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -1162,8 +1162,55 @@ pinmux core.
 Pin control requests from drivers
 =================================
 
-When a device driver is about to probe the device core will automatically
-attempt to issue ``pinctrl_get_select_default()`` on these devices.
+When a device driver is about to probe, the device core attaches the
+standard states if they are defined in the device tree by calling
+``pinctrl_bind_pins()`` on these devices.
+Possible standard state names are: "default", "init", "sleep" and "idle".
+
+- if ``default`` is defined in the device tree, it is selected before
+  device probe.
+
+- if ``init`` and ``default`` are defined in the device tree, the "init"
+  state is selected before the driver probe and the "default" state is
+  selected after the driver probe.
+
+- the ``sleep`` and ``idle`` states are for power management and can only
+  be selected with the PM API bellow.
+
+PM interfaces
+=================
+PM runtime suspend/resume might need to execute the same init sequence as
+during probe. Since the predefined states are already attached to the
+device, the driver can activate these states explicitly with the
+following helper functions:
+
+- ``pinctrl_pm_select_default_state()``
+- ``pinctrl_pm_select_init_state()``
+- ``pinctrl_pm_select_sleep_state()``
+- ``pinctrl_pm_select_idle_state()``
+
+For example, if resuming the device depend on certain pinmux states
+
+.. code-block:: c
+
+	foo_suspend()
+	{
+		/* suspend device */
+		...
+
+		pinctrl_pm_select_sleep_state(dev);
+	}
+
+	foo_resume()
+	{
+		pinctrl_pm_select_init_state(dev);
+
+		/* resuming device */
+		...
+
+		pinctrl_pm_select_default_state(dev);
+	}
+
 This way driver writers do not need to add any of the boilerplate code
 of the type found below. However when doing fine-grained state selection
 and not using the "default" state, you may have to do some device driver
@@ -1185,6 +1232,12 @@ operation and going to sleep, moving from the ``PINCTRL_STATE_DEFAULT`` to
 ``PINCTRL_STATE_SLEEP`` at runtime, re-biasing or even re-muxing pins to save
 current in sleep mode.
 
+Another case is when the pinctrl needs to switch to a certain mode during
+probe and then revert to the default state at the end of probe. For example
+a PINMUX may need to be configured as a GPIO during probe. In this case, use
+``PINCTRL_STATE_INIT`` to switch state before probe, then move to
+``PINCTRL_STATE_DEFAULT`` at the end of probe for normal operation.
+
 A driver may request a certain control state to be activated, usually just the
 default state like this:
 
-- 
2.34.1


