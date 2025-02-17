Return-Path: <linux-pci+bounces-21579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3214A37B80
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CBB16BFFE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 06:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6519D06B;
	Mon, 17 Feb 2025 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KSKAXbxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4B19F424
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774074; cv=none; b=NWS+pWgSipmOiGyROpoOyNHq6GEDcjhHstyCVwPilbg7IxRbXyjOh/Pfy8GxW7EPT8OM5PwC6F+Vm3r2LJh8McZ8sREYcPOQPo2yN3NGK4ORRrOjaj2GdpgEj9I5jqIng/dMncj/asfQZj3WqPNvXObfZKt6iQzTZlXyAr0X1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774074; c=relaxed/simple;
	bh=UOzsnW0yk1kCZhcOHUKzAXiM1zBrG/5KAYYsM43pKTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ti09TyC1wyA/DIFIx+0MoUF5hcjzauQukxaC7HiOpRnTMU0ARawpyMVJMz7MPfnazrVMbQBH16q3rgtlAJD6dr14yy6Rw2BG94NIx1hJMZgfVifUPaagS1bk2EFfhGzLwmiHATixzqhJLW7ciZTPMp3fR4dQLMMRB8vD/NV82Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KSKAXbxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H102Jh031493
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RfJAtknnM5Ix1H9l/tiQteK3hWDYQBja8j0ciMMbYFw=; b=KSKAXbxIm4a6mDsk
	OJLRGFuMB+06LODX2+xrvDCLH7scwZEMQTDuz0wfRLxCPcY2QI8XiDl1nNDRSb0T
	bzxvI/YD9ojp8KhC7Cz4o6QOtfwKoOgv6qv0Rlu3tE6uGEHDXlScsZVxu46tRXNb
	rr2QHxm/HURXIEQcGxqRSDYcOo7C6/jxQ5+58/+mxVKTY3ACga+pEexjSZEF1tu5
	YsQbjVmyxzGVdqDUNw1MM3tbHUdyRSyAhoniJbOzjsU5lRbqKkYK8cf2iUEFQJbG
	nUAL4JU2dsox7nTTNEBKMmDjT3R8+S5c+MM4FmTpvkFC38tq2pHRzOtgk5ZIfSPD
	wEUAAg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7wrpxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so8335033a91.2
        for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 22:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774068; x=1740378868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfJAtknnM5Ix1H9l/tiQteK3hWDYQBja8j0ciMMbYFw=;
        b=P/w1vjdm6MKgcMlRv8Un2B0rmyWLkemLTmyU8mkAm/ucPtTbNrYH/sBB+kgHofGJdn
         t0K5er3Iu2tSHPtoOtxwgNWNMRY3kR/BGpSjY//ufRFvhgplXvWORItYPN7aivBAXFVh
         hvLXn13o40J2APQ/wlYXCAQKholL2MpzdHvxZqjkKabzekBFDieDFbiJP5+mLpBMRZcQ
         O1T8z4MkTBNhqrXXFupXslzpPvXOwYjAz0wIkKx9qGuZXpPV+F9K0myukks+JUD57w+C
         qLl61ONG5pdfmRsIPaqHHuFnRHqWqxhatITkt3gQdJzoE4g36jsCoiHtJQnMBpF96FG+
         IIQg==
X-Gm-Message-State: AOJu0Yx6y6xOJaGWhW8OUhJYKwH3yTkIu9XUlixPQteZkr3fWD1OoW8U
	OacS4T++J1zdPVcEWYokB7JV4BPj1kg9/ibnVpPk/JoTFWLsttp5o1SvxjrD1d5mLDAh/twLyfo
	66Ijtd8yitvXpdAltzRcjrxLbe+x3c2r5VPHcM7ZmFf6Ml/APyZEfNWJnuLs=
X-Gm-Gg: ASbGncuId3+aKR8kSkQBI/YiFfOSa5XxPot9LxGeh2NEWStyFYxVM1/ydWoGKVcyldH
	8b7eNWvfwACZXahSuT8Ew1BqrHo4VDKraurSBLDbjW7yC1m4tEI6wrYzLSaew2NYccR1454HILV
	G2d1s5LfOAnymncJZLy/UZITM9jg+zoEr6nnUtJb/q81BxiZBoq5Rw9991aBVLT+0tgOGhWxB8a
	WOGR7heBMNmNn5+A+y75A27vHXOOvZ6B5jGc1QoNEajtfYILvmV7h3tYMv0aIYemfwhmdtF3+po
	Tja2/zaE+nvHvvmqXruPjKxYGX1hUhCaloetzDQo
X-Received: by 2002:a05:6a21:2d87:b0:1ee:43c3:9bfa with SMTP id adf61e73a8af0-1ee8cc16ab5mr16622896637.35.1739774068503;
        Sun, 16 Feb 2025 22:34:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ7gToBq7D4VtpV2EASi1+JDe5Y5Jkt/4aGWzWeA8pKMBeCH8FZhkAAVk6ksqeb0q+oCvNuA==
X-Received: by 2002:a05:6a21:2d87:b0:1ee:43c3:9bfa with SMTP id adf61e73a8af0-1ee8cc16ab5mr16622835637.35.1739774067507;
        Sun, 16 Feb 2025 22:34:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:34:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:09 +0530
Subject: [PATCH 2/8] PCI/bwctrl: Add support to scale bandwidth before &
 after link re-training
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-2-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
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
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=3068;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=UOzsnW0yk1kCZhcOHUKzAXiM1zBrG/5KAYYsM43pKTM=;
 b=xi2H5j+IGrnLH2KW01vOyRK0v1mmhX6st6biV7Tank1/vHMoUUt8rpVtOT60WK8uXuBhj8yK3
 8x2ATQZIgedBNLlXYuqyCQVT/znFmyy+9q/E+GmWNi3TPK/ehbPnrMA
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: PODsjlMlB-lvQWXpRxGuRvJP-2XpDIlS
X-Proofpoint-ORIG-GUID: PODsjlMlB-lvQWXpRxGuRvJP-2XpDIlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170056

If the driver wants to move to higher data rate/speed than the current data
rate then the controller driver may need to change certain votes so that
link may come up at requested data rate/speed like QCOM PCIe controllers
need to change their RPMh (Resource Power Manager-hardened) state. Once
link retraining is done controller drivers needs to adjust their votes
based on the final data rate.

Some controllers also may need to update their bandwidth voting like
ICC bw votings etc.

So, add pre_scale_bus_bw() & post_scale_bus_bw() op to call before & after
the link re-train.

In case of PCIe switch, if there is a request to change target speed for a
downstream port then no need to call these function ops as these are
outside the scope of the controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
 include/linux/pci.h       |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 0a5e7efbce2c..e3faa4d1f935 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -161,6 +161,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
+	bool is_root = pci_is_root_bus(port->bus);
 	struct pci_bus *bus = port->subordinate;
 	u16 target_speed;
 	int ret;
@@ -173,6 +175,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	target_speed = pcie_bwctrl_select_speed(port, speed_req);
 
+	/*
+	 * The controller driver may need to be scaled for targeted speed
+	 * otherwise link might not come up at requested speed.
+	 */
+	if (is_root && host->ops->pre_scale_bus_bw) {
+		ret = host->ops->pre_scale_bus_bw(host->bus, target_speed);
+		if (ret)
+			return ret;
+	}
+
 	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
 		struct pcie_bwctrl_data *data = port->link_bwctrl;
 
@@ -197,6 +209,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 	    !list_empty(&bus->devices))
 		ret = -EAGAIN;
 
+	if (is_root && host->ops->post_scale_bus_bw)
+		host->ops->post_scale_bus_bw(host->bus, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
+
 	return ret;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..58f1de626c37 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -804,6 +804,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*pre_scale_bus_bw)(struct pci_bus *bus, int target_speed);
+	void (*post_scale_bus_bw)(struct pci_bus *bus, int current_speed);
 };
 
 /*

-- 
2.34.1


