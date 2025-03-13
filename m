Return-Path: <linux-pci+bounces-23607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507DA5F2A2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DBA17B225
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E326739A;
	Thu, 13 Mar 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmXvMXzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE39266F09
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866054; cv=none; b=UD7zMsQDfLKz6Q6HYPbSuMs54V9LAHupbGcdk9Qfh0Bv3Ly4fwQYE0BhsR9u1q7xr8OG+xN/LDt/K2r/cqMZa7qya4QeXHkD3AET6pi+Cyg5MLF4iZdFTuxeBrVh/VokE9+sPWP7uQL+4eP/x7MZLLvt39vasizYN9JSHqLHaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866054; c=relaxed/simple;
	bh=kC8jbRyoGWHcr5F6bMdpdYEPmSroHXkD/t16CewXuhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nw88IBjTUKhJ/gri6K6Wbz3Q+auhzG66tZ9o4bzzNlJVg78s5Pjgzj3vwdPRVdcObiR7H7aRb9I4BMTfJ1B0fbj9ffmOk4qH+UMZ8Pk8jB9lPiJ0U3MtnWLibnCdSTmstH1Fbxz5rfZq0nTndITrPL9R/XwZDgEhmfeOMrNafTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmXvMXzU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D2KLJE007315
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDJhVDK2s1wMdCivo+PnGOHqGOzFfulqMDQxzsMg+uQ=; b=HmXvMXzUoTP8Q8hI
	I3LttVypEv90ARIUfTW+7FEwKadDufSkIiWfgbb/CQwlr1WPnWZPczd92TM1LSIJ
	NRyLQZxKmth2DPuaCpl4bCWFN/LRvbjystJkWPKpYwpC1MYL9UHnw3uXy+IOzcvh
	11myRbTGdnhRs9kzgNl58CdZC7o7DNbELWlEbQMUFiPtzXB0xFNo/nJqpkqOGVcR
	QsaXNNPXbTas55XxnNlXuWnlTqk1Ox92eMJjj6h4Xq82VE8KeL2uK2NlHRyBnLtR
	Asl+hJ3aF5S2twK2tlEk/cW3noS8QR0P+ceF8rEKVX6fb7F4VZu/GBweQhBXYw0/
	90/HzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg89dp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:40:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso1645548a91.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 04:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866051; x=1742470851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDJhVDK2s1wMdCivo+PnGOHqGOzFfulqMDQxzsMg+uQ=;
        b=ZKBca+GPibmJBsJAsu5V8qIeHRnAi1RjEETMujp7z5d7S+qPBmavtM6VZhRSQ9tUp4
         VnD6zR+JIEyyamz077ckoR7mF7Pl6/m3WRxQXLTPHaLP5qT8ijE9MZrD9rzdzn9H+f4D
         +Y+kRVgNgCDqQwgkpFkSuM+4lCFcwVN706VnUBvM4OKGfgx44kifJqOVGMLzndDf9N0/
         aICquH58etZvC1v818MsUbhJDOVh3t9kLFxDw+gDC2G2Okj/vySGXqHwU32o5AlbwZ7I
         tWzAR/fO6PqzDH+A0gUyOuMjJmwFHXR1a3F/dD1qDJcQx9fAj9yNWkjCXK4JJbKMGln2
         pyGw==
X-Gm-Message-State: AOJu0YzoS23XUryO++cwlT4wJkXWTeXdZPIcXiX3e0aP8a560J3u0IZi
	fQfcAQ0IJGsSBv6k8V0c4BHv1Ux0ITQ7FKTcuI3+s3WpLIysCEHo+Aq2cDbvTx2vuwYsiKEdSmw
	DcrYq4s6fat8OzoYCqkPhNNE4V8CgqXYWNK9PI8pyhgzIzXfPvS9yohoeWU5sJyScOF0=
X-Gm-Gg: ASbGncusWObRw7cB9a6faExEcsXQVLCy6t2qmSFpqCpWpJhR9jG6Jg9sFCXi/FN93XW
	fqVAKZ8+J/Lx8cm8oQ+F3FLbG+WFEpE2oohkEzmlcxLUuVuZgKmsKUG8RElhLxxK4FmaaBKvzqX
	QtXyQfOqNShFf8+CwVFfNiFpGKikvgmCnxt/Qm7bJDHjj4U4Ffwih/UbVHc66AZu61X8zlzHXvc
	cBm48LY9So9re19wdWu2wzR6qXa3kdE0d0sAnzjX87aT0pC2zL4sISyTngzZSl8/7WHtCIaI2/x
	PgObiW39liQJqhrwo3TYN4xnLpLeaYJy9nkplENHM/40QsLhCY0=
X-Received: by 2002:a05:6a21:a8a:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-1f5535c862cmr38690638637.35.1741866050739;
        Thu, 13 Mar 2025 04:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX0osURi3EPGsBhGonuGqBQDJB5s6R9Ee/fm3sZrU83VNV9iwXDBptbFr6kXXFDh+i9IOGIQ==
X-Received: by 2002:a05:6a21:a8a:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-1f5535c862cmr38690595637.35.1741866050366;
        Thu, 13 Mar 2025 04:40:50 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:40:50 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:08 +0530
Subject: [PATCH v2 01/10] PCI: update current bus speed as part of
 pci_bus_add_devices()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-1-869ca32170bf@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
In-Reply-To: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=865;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kC8jbRyoGWHcr5F6bMdpdYEPmSroHXkD/t16CewXuhA=;
 b=ahY6Y0A168tVls7xeIA9KMyOy4DdXUlaSCT4aLtCvCoOwCqtVuPLJB4oihUbL9V6lKzs0jMIr
 YbHNVpW7tlaAw2nG6V5+CebfmNfg9kEZrPSIm76H9fmD5LPSKow5ily
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d2c443 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=u3yxjsl3ZikD_R2semEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: QQjgd5z2DaocV_FASVn-ka5ZKbe2MOvz
X-Proofpoint-ORIG-GUID: QQjgd5z2DaocV_FASVn-ka5ZKbe2MOvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=982 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

If the link is not up till the pwrctl drivers enable power to endpoints
then cur_bus_speed will not be updated with correct speed.

As part of rescan, pci_bus_add_devices() will be called and as part of
it update the link bus speed.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 98910bc0fcc4..994879071d4c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -432,6 +432,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 	struct pci_dev *dev;
 	struct pci_bus *child;
 
+	if (bus->self)
+		pcie_update_link_speed((struct pci_bus *)bus);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Skip already-added devices */
 		if (pci_dev_is_added(dev))

-- 
2.34.1


