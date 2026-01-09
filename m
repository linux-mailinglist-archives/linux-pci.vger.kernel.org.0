Return-Path: <linux-pci+bounces-44333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9A2D078A9
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 214373051C5B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F12EC56D;
	Fri,  9 Jan 2026 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FdOinPKa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ShTQDBeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358122EC0B5
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943294; cv=none; b=tT7ZC3ltc+l8DhKBwB8/NYLLPdgG238tJwZISbO2nom0J5sXAYzm8I/pd+UhR8wJETLFfvyQM6Goubb37BahoeEuJNdoCMw/7D4GeYPnDkflYv25r4/vAszTwDiGDOPPJteOROBaCj7+ePjk3bhcSlVqyzh3dxsStvoKvP6Vf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943294; c=relaxed/simple;
	bh=sATat5gXi+RmClCqAUl81QS783eB44xkTcOkPS41g74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pf6B5nb0RqoB//pSkjXdxEZ38QQTX8KSpZCCMmFDJgJ5gPByFYLuAme29W5/4tAf213M3CCILRIT9oZYR9Ofpg7mseLJYX1+mTvaejvqrvozwLWF9QUzHwyoow8IPdoXyOse/KhGeWFfJQTK2rkI9bZUjjvADZmZWhfuiAgJeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FdOinPKa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ShTQDBeS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095UWlY3166817
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 07:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	72S83sFcJLczdJt8oEW24FAL+N/F40XzrhBECgz9llc=; b=FdOinPKaTYDaHT4h
	fQToOCGUwhBzCHAGgahjXuDn6HqKxW3zHbrFvSl4wuwsfAmtpkcyOpg0gFXeweiy
	grH6Yg44JTuzVq/mVqGlZ1Kb3aPHZo2b2uNV+y/LlSJTCCrSOXtYgGTFqZUxNbWq
	1EuFLO9vFg2HDCEhCi5RuY0+U/NW4YWTvOBC7MP45frAnLDKbdirpS/kh4laBTBh
	RuOJwRrbb8d805eZvUaOm1Wcy1/RaKTKtNJoNg44iP9YXh5d+Z6H5+gdehM2PSZg
	f1A5I35RGuUzUAI5TZ9/I7B2p+X7mgYj2yUegnumUiSpu2re8SsrSNdAd2XYDaip
	IJoukg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj8923xqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:21:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b952a966d7so7455728b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767943292; x=1768548092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72S83sFcJLczdJt8oEW24FAL+N/F40XzrhBECgz9llc=;
        b=ShTQDBeSOSn5ZTDX0X6R6PaYLQQux+GIdFZldqGsRVkaGDkt7NRzuITdSbTvHpcPoy
         6Kf7gu6snLgdDK8R7ysVknpwfIfT0eWif+tIjlTXGGWDFzOYl9x6zRo+QMI1N8Mt0l0S
         srbtVCn8UDlMkwqFyR9qZzkqWyTRYB4KXCIdaGD7oROW4ehBQSIKLCWXiOMhYOV+uB6f
         1JkLSe6YrHfhL7DsC/MdDG94AJLHYru9NDALj8hQLUfBN1G1he2W3K5/VKsf7Rq5Xuoh
         wXURCyoZj+q3b7fRx6fQDjvbFt9oIn8NHNeJpvvKPpvhqQ1ZvV+SPP3ewMS9UWgzpj/I
         5tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943292; x=1768548092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72S83sFcJLczdJt8oEW24FAL+N/F40XzrhBECgz9llc=;
        b=mGr04ok3ehhigfQF936qQzm+yMZgiGEzTOyC5kNQO3jf414iV3mixDp7EedIF2Dhw6
         jnpMv3/IdD+CXbHlKPBDPAv0xxqbDBHzMiaulzeRSlWEAs49h3CIf+Vr+lcqxDgnKs/t
         vjWOr8vcx95msfw0i0i0cSUck5irymIYXooN2PJb72GVM7txmerX9aAZ4CIKlO9I04/A
         LUSrg1k86q1csHxkKztxNObzjgmNPlTc6CvJpCYCmFQuk9oqM08qSjy34bKhDFG7pDG6
         mNpo7EZbdyCj2hEg70/A7iRNrhGyQ91HLFmD8FkWaB4AEjdGRWlYTBZmA40qtD8Hg06c
         N53A==
X-Forwarded-Encrypted: i=1; AJvYcCVjtudKGHHCYYu/UoDexcql4r9VD8aED6r3UuuukPm8LMIHugclqCmFhNiar7DRJ+8WOF54r0xYqMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZJSQVIFskQvG0sqJxIHkKMhzZgdipwa8N0OFE1JADPGV+Kje
	/CrnMkmh1PV75y26HPDqn+/SUbj4mEUTxLD3ZNDCH0r6lz1EgpeYNouQCAcaSjttqdh822eKFat
	twLooN8LZuTam5q6/d7vXSlUQUMnnQKvDb9pCw3ufMCwMPGF/bLQOnnI0nMxhuxs=
X-Gm-Gg: AY/fxX4bC6DV7FVkDjBRiOQMhVw2/8sVbVkDES0Hu3s/7yYEatoX/giuz4C6tvh47Ta
	iFulzdjE1Oi/ZGVjZMb29FrAt+eHiCP8KdvZAFIaRJVN86qOrilNnjl1iEmOqiTdlAJG+KLRCh3
	Up6kLpwTKK5uvCseuUloLvwabApWC8k5yaSOSyDkiW78YVldwkjydYSHlCLU5C2TexegKIHlJ8V
	noZ9ThG+MEEeaYQrvttVmB8thtC99tCMFv7rlifMb9m0WbW8GnIVIzgKg2zzGIhaESW5djeYtbE
	YrKXEVMW+jE/eu6lz3CMo+HqD19IBfQnkcVT+xq6NutphGXZX8ArIMknAVNi6WOXn1SBPQyIhUV
	41D2coFpEIsan3CAcy4BmpllpNJguCP0OLW63Y2+BO7uA
X-Received: by 2002:a05:6a00:e19:b0:7e8:43f5:bd18 with SMTP id d2e1a72fcca58-81b7f3f1ff7mr7879177b3a.45.1767943291764;
        Thu, 08 Jan 2026 23:21:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBsaYWHr8eZog5Woy39kTSosevSsQ2EU8sshvTGXJv+BXUHaeNfYg7ku/1jVEn99TS7RH7bA==
X-Received: by 2002:a05:6a00:e19:b0:7e8:43f5:bd18 with SMTP id d2e1a72fcca58-81b7f3f1ff7mr7879143b3a.45.1767943291246;
        Thu, 08 Jan 2026 23:21:31 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb4c85bfsm9510369b3a.30.2026.01.08.23.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:21:30 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 12:51:09 +0530
Subject: [PATCH 4/5] PCI: qcom: Add link retention support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-link_retain-v1-4-7e6782230f4b@oss.qualcomm.com>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
In-Reply-To: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767943270; l=4282;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=sATat5gXi+RmClCqAUl81QS783eB44xkTcOkPS41g74=;
 b=/zFkBrsSntluR8iQc/wubd+dohrF5L/1t1GC/liOmhwA0+Vxai9BpzHpjhct44yyHtNpaSt6d
 70jOpWu4WP0Aofc9GwjUx9bfI/LQXB3Oy5Huej4BYcKA8AjhCv1Naim
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=M45A6iws c=1 sm=1 tr=0 ts=6960ac7c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=S-wDCh2AgS0RhsWIeBgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: cnVYG8N7MTzdF9DgdhUoweOuCD8pIK2b
X-Proofpoint-GUID: cnVYG8N7MTzdF9DgdhUoweOuCD8pIK2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1MCBTYWx0ZWRfX9BFFhR/WRp96
 k137DxWpMNeiHgr/B4Tt0f/rr8tzGoh12xw10zZgMYv1bVuoIQMjm5jG2FEkP2BqZO8rMMMQ9XI
 WXsQgRqcRjeY/p+Qz1LrL+29OdTvScozFS63gdAqrCuQlWc93mQKjE+XTmJ7cHC3Gz7ffZYf3M7
 WAqvAnrWCHyaVGWxyDWQrWShZE0vHymF2fnZxEA6hHc2/Q9b8uVsyUyDeRE32waokNNIXJGhu5v
 1bJHO8SG9TOqyjhts0Re9xp2VYEufYXtAjQhMRKH1gL0S08YF4ShLsnDsehx8dP6W0dcoSq863I
 2ezr1gHTS16W9lbeKj0A5PHCpysahC+7VjufNHo9BbRviiMw4ZvXTQkQ/fjbV3dRi9eqqYrxYtB
 kXnW3XE8RXsPKnXzPMMMh4MXLO8tctnovl7FJEhZgmVXg73szq1ze7aQNs3Zz8KCUgAT/7yt8pW
 xOwgx+Nwr3Epy3i+4cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090050

Some platforms keep the PCIe link active across bootloader and kernel
handoff. Reinitializing the controller and toggling PERST# in such cases
is unnecessary if driver doesn't want to do link training again.

Introduce link_retain in both qcom_pcie_cfg and qcom_pcie to
indicate when link retention is supported. During initialization, check
the LTSSM state, if the link is already in L0 or L1 idle and LTSSM is
enabled, set pp.link_retain and skip controller reset, PERST# toggling,
and other post-init steps.

If there is a devicetree property to restrict PCIe data rate and lane
width go with the normal execution instead of link retantion logic.

Configure DBI and ATU base in this scenerio, since bootloader DBI & ATU
base may differ from HLOS one. So use the DBI & ATU provided from the
devicetree.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 50 ++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9342f9c75f1c3017b55614069a7aa821a6fb8da7..bdd5bdb462c5f6814c8311be96411173456b6b14 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -259,12 +259,14 @@ struct qcom_pcie_ops {
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
   * @firmware_managed: Set if the Root Complex is firmware managed
+  * @link_retain: Set if controller supports link retain from bootloader
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	bool override_no_snoop;
 	bool firmware_managed;
 	bool no_l0s;
+	bool link_retain;
 };
 
 struct qcom_pcie_port {
@@ -965,6 +967,35 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
+{
+	u32 cap, speed, val, ltssm, width;
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	ltssm = val & 0x1f;
+	if ((val & LTSSM_EN) &&
+	    (ltssm == DW_PCIE_LTSSM_L0 || ltssm == DW_PCIE_LTSSM_L1_IDLE)) {
+		qcom_pcie_configure_dbi_atu_base(pcie);
+
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
+		width = dw_pcie_link_get_max_link_width(pci);
+
+		if (pci->max_link_speed > 0 && speed < pci->max_link_speed)
+			return false;
+
+		if (pci->num_lanes > 0 && width > pci->num_lanes)
+			return false;
+
+		return true;
+	}
+
+	return false;
+}
+
 static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -983,6 +1014,14 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		goto err_disable_regulators;
 
+	if (pcie->cfg->link_retain) {
+		pci->pp.link_retain = qcom_pcie_check_link_retain(pcie);
+		if (pci->pp.link_retain) {
+			dev_info(dev, "Enabling link retain\n");
+			return 0;
+		}
+	}
+
 	ret = reset_control_assert(res->rst);
 	if (ret) {
 		dev_err(dev, "reset assert failed (%d)\n", ret);
@@ -1043,6 +1082,9 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
 
+	if (pcie->pci->pp.link_retain)
+		return 0;
+
 	if (pcie_cfg->override_no_snoop)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
@@ -1300,12 +1342,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	qcom_ep_reset_assert(pcie);
-
 	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
 		return ret;
 
+	if (!pp->link_retain)
+		qcom_ep_reset_assert(pcie);
+
 	ret = qcom_pcie_phy_power_on(pcie);
 	if (ret)
 		goto err_deinit;
@@ -1316,7 +1359,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
-	qcom_ep_reset_deassert(pcie);
+	if (!pp->link_retain)
+		qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);

-- 
2.34.1


