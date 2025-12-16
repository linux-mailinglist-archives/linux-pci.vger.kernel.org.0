Return-Path: <linux-pci+bounces-43122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD9CC3D4B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E873312A405
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1767D382D5D;
	Tue, 16 Dec 2025 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IsLSz0nx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UP/5V2+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F5382D4B
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889548; cv=none; b=YbiPOUJSSoKFr8+NpF6evhVSreAxpRtGMOJ/Am0/S+eG+WeWjuvWgulNGGJeuo7LQ7CNoHPhSZ20C6TIJHy9JgJgkXDGnYYxa+8iH8DFL6TzeyjBkrRlJWe1iniYve5P9URWKC3q9mgnfytB4wMNgE1NqHVLrqkmhLNVZ0kIi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889548; c=relaxed/simple;
	bh=4RZqS9C5omgsMD+6meE6/yDTZg9+e38zvxvu7kBnSY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHmIY0+2RmMXbniYLqiRWrYIFEM0fWO75ZwjjCDr8lvD225mVmBJIN8xRxXf8V2c0ImnVpaO4gI1kcPeywhxQblWDgAy/caEz1WIZJx7ygVgtLCcvI5tceLn2PQ/YgRiriA3x3zCj8WuC8h+et9ROoxJkiP+Glx5/rxkqbNRLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IsLSz0nx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UP/5V2+3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGBNxhg3390669
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2gpMHf9kn3YsZ6lMZhd5fnKWGfnj5wMtwuzg4GBEGD8=; b=IsLSz0nxHPWWcOHn
	Gt8EWBJgOJxBSZA91uBsq6mneCxj1NOOIzqFCYsnWEXc/QPrWcs+hi9jYL/uVvmd
	79GMgviTYdiuelNpUzfE3o0vZYQiv0bf7jtEfC2xvGOoff//QqM9cp+0JcJKEe2x
	ZrY0oZO/Uu2lABy4dVdK3HeB3UA/GRlQLwglrhBXn3lHTAaj6n2niuoQX+FIPAgg
	9JyKEzu6xJG73/dHIWsHpfvVGJvbldBGwUusVXU6HKxdwwaRyRiwipU5N1bQhC18
	dgOLHIoCaUc0J005tHtYMxKZpCnJPJLJXf9PoaX2Ii9WA4MRhGWayuG2yTabA1MT
	RIEFbQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b36h389s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7ba9c366057so12370809b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889543; x=1766494343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gpMHf9kn3YsZ6lMZhd5fnKWGfnj5wMtwuzg4GBEGD8=;
        b=UP/5V2+3KFFHFbikdZKEPW0HhpBeidlcuciqmuMLa1vjPL8y2BNu+grWlwfJySnsOM
         gfmqWxRsVjL93jFhAdiMf4NYtB19LTHuj5TCl7liNjbWIpLo4kDeroWDCq6J08eN9Et1
         0TVzzIC3a3xG+ptzVdSL2+icQ8MWEEpa/SHzRdU5bf7wWYlXlu0FgymkpfoJjovPOav5
         KnROl2H+8W/ekT74gqqzrNNPqp4bh4KwejfF+zUsPMmy2m7GCKX6W+ET4iSNXOmE8ZUT
         qYMOlJ4EHiTH/ClOTk+WlNqGoR5G8hfWN9XpFIoCJE23KN6bNN47JQAgqrwQ02tqVhNU
         wOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889543; x=1766494343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gpMHf9kn3YsZ6lMZhd5fnKWGfnj5wMtwuzg4GBEGD8=;
        b=jRsIoNUJJP83M8JNmHG9U6l2ovy2Cepdo7T4OhaB3v8q+KguxzsZRX3dUaQZw8nX8D
         fOmEeF+mC/nDPVOlqK9aTTZd/F7ydb6Jw39YeqwyEF5CSvQCb+VqKgej6gPQL6r95kzx
         ps2GjFGTReUwxx/4vp43z+L8CKRa1PDa7LArF/ZU2axy/hFWjpkvsR/sz25pai4EpKKc
         rywqkMWS5pGtUbQxJ1e1zio6yWOowP7kdMg/lt772nA9bE6nbn98rqpjEt7oOJymGjtJ
         THJGfAhwPO+sveFPaNk/s1dTmQRYCX1mDJAwGHhEc29BIZF/yc539ctBDeNZoOoFQ4Fa
         l91g==
X-Gm-Message-State: AOJu0YzO6X+MMcFsDxBkabzr5FZQJE6HdUFsLbBnvx6t25hj1Te2n3hp
	5EnwfVaNlvXciNNM/2cwMQZfOzindRoMYok0YhwpBMnbswl0ffQ1hKHX5AL8BHHsUKKmHXoflqR
	kg59xD9KGYZZV4AEe1oOFBDWNSPlen0Tgl41WT3rRqBT7y3F6NijEhqb11C84+vc=
X-Gm-Gg: AY/fxX6rcpR0su1Ptegi+GEdErVsmHsNCUXbKMZu+WSmb9n7y+ciChHQfi5gJ1Mxxvr
	kodlvdNZ5X5CzmzfHeHlmm7koR2Nd1/hLSx/QyppBrBmSVkaNlBr9klOGp7BN3XZqhZmzXkalrl
	Ldgw3EvE738726uywLz/MirItnfqL9Nm7NPADWHLhVQd85fnQScKNQ2rR0O/hmi7HH1+QHpAwZ1
	qqQiOXRtfi8S0Djft2PhjEOuY+DNbNeCjcCSl8aJyNHugFlCO++7XXQl7/8A99Atg4j47Wn4SDy
	INmJNM4Y9JYrv+6pWso0hxOzO2HUXpyou/pCjmkVgsUkomlSp02CcYhudynsHUILBbruqlnYcJt
	wJDDwHivH0F+fXir1dEgYNfFUTe8SyYQmxrwUt3YQoQ==
X-Received: by 2002:a05:6a00:138e:b0:7f7:612e:461e with SMTP id d2e1a72fcca58-7f7612e46e6mr12318132b3a.57.1765889543483;
        Tue, 16 Dec 2025 04:52:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJU7gwo5fGnKCS3PuUWKoDT3aiGbjLTaLkWJF6hxZ6AQlFNOvCz8g7NH9FrkvzDdVucqhcWQ==
X-Received: by 2002:a05:6a00:138e:b0:7f7:612e:461e with SMTP id d2e1a72fcca58-7f7612e46e6mr12318108b3a.57.1765889543027;
        Tue, 16 Dec 2025 04:52:23 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f5ab7d87e8sm13634362b3a.25.2025.12.16.04.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:52:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 18:21:47 +0530
Subject: [PATCH v2 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-pci-pwrctrl-rework-v2-5-745a563b9be6@oss.qualcomm.com>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9481;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=4RZqS9C5omgsMD+6meE6/yDTZg9+e38zvxvu7kBnSY8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQVXom9V2sD9uL0evNrzSmHVYO68vB9b5L+b1r
 OIr2xTo2ZKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUFV6AAKCRBVnxHm/pHO
 9WR8CACV9ioXJL2gvQG9MY5qC3NCLI2ENXaj++tsd52Z/IGkmJerU9KaiwLKp1LHrV4MayX53XE
 aFjZKYSYHyg09D8/CWaHEYr64fjWcwH0zvqWy2aQQNYFGfRrJlFsW187ArNI1FyUYpF1gwI7jbw
 ygiLuqoj7smnXwq1+AOyEadAtlWInOoPaAVduxky3xWMyn2GRW6UAfMz0yvHHsYE5QNIGyNAjSD
 i2IVi/3+8muE7lyrjcqiyPqzuOSMwmdb6IprF1waRlzxQ0v0QxbZ1BZ+1lJjZ479MgdhAhk/5H6
 H4yZ6B27H0M7fnWersSQjpQgrdynB6RCna3BrYQG92DUehzl
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwOSBTYWx0ZWRfX+FjVoooDWLKq
 OLcHz78HyGIdSqEuxAB1S1ZG6fqL73hznvad9E7PB/cmx9xc4jX3F7829kZVNu+1rfUFWx1kwqD
 E3FnaK8+eRuwzjFgcG+6ylTMCxi7WlQWlvNOAfVHliWLhnrvqOQe94MfP/1TFNtAzH1qrzKs5AX
 QOjb9Tgcd/A1hf38VRP1P9UHsRQgKmhuL6RzsepBxzvGxXLf4fnSc+2KwwAIo4Q+d88TyJKdHkF
 +Vtz9nZC4pRjv5c02hA6UbWH0UnbcOiI2qLz9rFhFcqUidZMtOj1OHlHV11NJtrFP4SZtlKUqBz
 Nh4B/sTCYJ0xhRWobMDoWHPH78/IJvNEkUm3BhH+tkZaG3coH1vHAGsTlAAE4L4xmFNKZPgc9OY
 cfQKX5vqdlLnvZixnV5X3AGcOMwr9Q==
X-Proofpoint-GUID: CXcbFrBNGIXt9YWEdWPlYuqVJE23Z9Q1
X-Authority-Analysis: v=2.4 cv=QeRrf8bv c=1 sm=1 tr=0 ts=69415608 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=wnJ2AIBC+6MZbTdryK78rQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8
 a=Via3SN_SAYv5dIAeqUIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: CXcbFrBNGIXt9YWEdWPlYuqVJE23Z9Q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160109

Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
and power off pwrctrl devices. In qcom_pcie_host_init(), call
pci_pwrctrl_create_devices() to create devices, then
pci_pwrctrl_power_on_devices() to power them on, both after controller
resource initialization. Once successful, deassert PERST# for all devices.

In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
here, as deinit is only invoked during system suspend where device
destruction is unnecessary. If the driver becomes removable in future,
pci_pwrctrl_destroy_devices() should be called in the remove() handler.

At last, remove the old pwrctrl framework code from the PCI core, as the
new APIs are now the sole consumer of pwrctrl functionality. And also do
not power on the pwrctrl drivers during probe() as this is now handled by
the APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c   | 22 ++++++++++--
 drivers/pci/probe.c                      | 59 --------------------------------
 drivers/pci/pwrctrl/core.c               | 15 --------
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
 drivers/pci/pwrctrl/slot.c               |  2 --
 drivers/pci/remove.c                     | 20 -----------
 6 files changed, 20 insertions(+), 103 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 73032449d289..7c0c66480f12 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -1318,10 +1319,18 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_deinit;
 
+	ret = pci_pwrctrl_create_devices(pci->dev);
+	if (ret)
+		goto err_disable_phy;
+
+	ret = pci_pwrctrl_power_on_devices(pci->dev);
+	if (ret)
+		goto err_pwrctrl_destroy;
+
 	if (pcie->cfg->ops->post_init) {
 		ret = pcie->cfg->ops->post_init(pcie);
 		if (ret)
-			goto err_disable_phy;
+			goto err_pwrctrl_power_off;
 	}
 
 	qcom_ep_reset_deassert(pcie);
@@ -1336,6 +1345,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
+err_pwrctrl_power_off:
+	pci_pwrctrl_power_off_devices(pci->dev);
+err_pwrctrl_destroy:
+	pci_pwrctrl_destroy_devices(pci->dev);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
 err_deinit:
@@ -1350,6 +1363,11 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
+	/*
+	 * No need to destroy pwrctrl devices as this function only gets called
+	 * during system suspend as of now.
+	 */
+	pci_pwrctrl_power_off_devices(pci->dev);
 	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
@@ -2027,7 +2045,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dev, "cannot initialize host\n");
+		dev_err_probe(dev, ret, "cannot initialize host\n");
 		goto err_phy_exit;
 	}
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..6e7252404b58 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2563,56 +2563,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
-#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
-static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct platform_device *pdev;
-	struct device_node *np;
-
-	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
-	if (!np)
-		return NULL;
-
-	pdev = of_find_device_by_node(np);
-	if (pdev) {
-		put_device(&pdev->dev);
-		goto err_put_of_node;
-	}
-
-	/*
-	 * First check whether the pwrctrl device really needs to be created or
-	 * not. This is decided based on at least one of the power supplies
-	 * being defined in the devicetree node of the device.
-	 */
-	if (!of_pci_supply_present(np)) {
-		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
-		goto err_put_of_node;
-	}
-
-	/* Now create the pwrctrl device */
-	pdev = of_platform_device_create(np, NULL, &host->dev);
-	if (!pdev) {
-		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
-		goto err_put_of_node;
-	}
-
-	of_node_put(np);
-
-	return pdev;
-
-err_put_of_node:
-	of_node_put(np);
-
-	return NULL;
-}
-#else
-static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
-{
-	return NULL;
-}
-#endif
-
 /*
  * Read the config data for a PCI device, sanity-check it,
  * and fill in the dev structure.
@@ -2622,15 +2572,6 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	/*
-	 * Create pwrctrl device (if required) for the PCI device to handle the
-	 * power state. If the pwrctrl device is created, then skip scanning
-	 * further as the pwrctrl core will rescan the bus after powering on
-	 * the device.
-	 */
-	if (pci_pwrctrl_create_device(bus, devfn))
-		return NULL;
-
 	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
 		return NULL;
 
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index ebe1740b7c1c..4e2c41bc4ffe 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -45,16 +45,6 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_DONE;
 }
 
-static void rescan_work_func(struct work_struct *work)
-{
-	struct pci_pwrctrl *pwrctrl = container_of(work,
-						   struct pci_pwrctrl, work);
-
-	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
-	pci_unlock_rescan_remove();
-}
-
 /**
  * pci_pwrctrl_init() - Initialize the PCI power control context struct
  *
@@ -64,7 +54,6 @@ static void rescan_work_func(struct work_struct *work)
 void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
 	pwrctrl->dev = dev;
-	INIT_WORK(&pwrctrl->work, rescan_work_func);
 	dev_set_drvdata(dev, pwrctrl);
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
@@ -95,8 +84,6 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl)
 	if (ret)
 		return ret;
 
-	schedule_work(&pwrctrl->work);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
@@ -109,8 +96,6 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
  */
 void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
 {
-	cancel_work_sync(&pwrctrl->work);
-
 	/*
 	 * We don't have to delete the link here. Typically, this function
 	 * is only called when the power control device is being detached. If
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 0fb9038a1d18..7697a8a5cdde 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -101,11 +101,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pci_pwrctrl_pwrseq_power_on(&data->ctx);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to power-on the device\n");
-
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
 				       data);
 	if (ret)
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 14701f65f1f2..888300aeefec 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -79,8 +79,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
 
-	pci_pwrctrl_slot_power_on(&slot->ctx);
-
 	slot->ctx.power_on = pci_pwrctrl_slot_power_on;
 	slot->ctx.power_off = pci_pwrctrl_slot_power_off;
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 417a9ea59117..e9d519993853 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -17,25 +17,6 @@ static void pci_free_resources(struct pci_dev *dev)
 	}
 }
 
-static void pci_pwrctrl_unregister(struct device *dev)
-{
-	struct device_node *np;
-	struct platform_device *pdev;
-
-	np = dev_of_node(dev);
-	if (!np)
-		return;
-
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return;
-
-	of_device_unregister(pdev);
-	put_device(&pdev->dev);
-
-	of_node_clear_flag(np, OF_POPULATED);
-}
-
 static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
@@ -73,7 +54,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_ide_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
-	pci_pwrctrl_unregister(&dev->dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }

-- 
2.48.1


