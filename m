Return-Path: <linux-pci+bounces-44329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F71D0788F
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626A73046547
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3022EC55D;
	Fri,  9 Jan 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cRvptH0L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9+sbVEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAACE2EC0B5
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943282; cv=none; b=HykN95hqTAfyr//3piN45SefMpm+b2legA7F+ov3997Cou0BJ9qqrZYajYDo826/sMD86cIFG85o/cwWQlUjL2ViA1JHO5j74iBvtCRvMWHvRVgJVg8qBZ/UaHdUdhtInHJ5UzvwLL0UjOrUgDmyAbDK0efa79c88euDGIj4IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943282; c=relaxed/simple;
	bh=qCZcq4ePhl1M5OCnTIjZBXNlTVq1DHiR6pXLBB27pc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq4lBm5LdVNCLOeGny83gMRjiw2vC6Zj1yz5t9QoCd4Z/b51mgOvr2zsEvm3T6t87ktRD4LPptBMv1TeW0UxDISMgdx/iOmu1TkBbj46Xmy5chuvkUzqYa95OsGXbTl/KSgtCSJ3F80EMcDJqNKxQhIXB3Bqp3N+t1SGHhAixhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cRvptH0L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A9+sbVEQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095UWlV3166817
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 07:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBmQ3JjkNs0c0gyqtwiCkbDYZXIghaKkt8zCFfC38Yw=; b=cRvptH0LuvCIZSDx
	VnvmliRwVLOXFc3Oxqnm7MPBygiRJTgvngIvBDNQkcUtOpcMyCt4Iu0RNuBCjFgn
	r+XERZce5WgltbLC7gpeMxkaiPX1IumruHFgel9eucnqkjp3jskJcTpX9MSikw+V
	EYzslPwSpvitGSQqQJfibNsGVt302E2Vk8GpWYsNjWWPN28/P/w8Z54iFfgLj49O
	B8N4gx/MEPyGIWBQiLhhFb65QnetlHiAikpnfh3Iy6XribkkjqDDV6zKfeVoQ13w
	1kg213MQIPitU+x39+5vaMhdnnNQ6qWb4KnIzV6Nr+GOf8nb1MAN2EYqzA2xKq9B
	xEzVsg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj8923xpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:21:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c56848e6f53so174878a12.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767943279; x=1768548079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBmQ3JjkNs0c0gyqtwiCkbDYZXIghaKkt8zCFfC38Yw=;
        b=A9+sbVEQuWDoOMJNIknA/NODy5rrGe5cKGjz9xLKsoW1DK9kEeYt5GPg5v3wvGTCxh
         1uwsrkUjcg28Muk60HhH061CA6l4ovDSaDs4B5PltucLq+ypqMcRdnW3OP+Xb0kjQP2v
         2K4iO9A0mUnGpSgGNlR5jKNVWXF7D69UqjJUfvyBEfkjvANVPNi8Ft4X0CJGljPTWNXJ
         2l9UuMakL+vWwXQgE3Cu2fRLFXdSlZHgWrgvpCxQnMs2D6TfxahndTw4pPhmAep85mDG
         vw0Wu+CSDiOArWgMfqv+nprCgsNG9w+7h0dDIAqlkYVDkkk+sSml0ktQoRjQEnTfsE8F
         9Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943279; x=1768548079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KBmQ3JjkNs0c0gyqtwiCkbDYZXIghaKkt8zCFfC38Yw=;
        b=Z7RgwTMaWO93pmX3C6EGfGnFslYabMfh3jZcdpIvuQN+3YAtdq3emsaies5E0h5REZ
         5JI5fvD736wjVTLhjqYUTT6IqzWQNqvuQR6Ce5ZXAN+erUdxkezhVt9Rvkaf/bQ2G1tI
         bQF+XmYKgFk1JdAXGCsYJaXJPh9VC3X5KrewQbjlAZjSln+3mg+bgiZLOvPI3ibLYNCe
         2+p+OmZg+3mNDG69uvL5WkYZqR8SQ1m8V2kIl/WprnkRERVIUR4NniVxiRJx6ZGAa21X
         rbHZF6q5tDkbfH86d6sNZtMiwBfCoGuAMaviQYLXNGj5OyIcLN3XH0eJbTe76996+KxW
         TK6g==
X-Forwarded-Encrypted: i=1; AJvYcCVawNChXQlpa6bmhDC0fQNbL5l2AhV/Ppd5fKjgkGk0QEDPGvlrvSF1A3OgB8Hop2gdzzWloLj5e1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfrgWmESnUhO02rUKz/3qIRJ0JLvq8eSf9iQBepUI+cLwThRB
	1T2Y+hwWHNzeuno7rVpadPkN74P0lhSEDSSZykZRrZhTZkpkLjM1s4/i/pPwnkqJcqbWb1pLxlK
	DCgZLcat6aA4i+1ZQGdrDpbw8qUOl+4zYdpPIg8dScTJKQ1UPn1GUcKcHMIJBFtU=
X-Gm-Gg: AY/fxX72qS/SNaDm0yxEfXK5t9TY/o7/E69cOR+Mhos0t6It0zDItXTMqWgIT3dcpjo
	VKXxq8bICu+vwjVDR8k67MfH9k4fpuibTigjvv0qpQb3VS45EuQWmMPHH8v3p5hyFznBFpSAdVi
	gwCtxnsebfG2IIKt4aEcalL4MbmxPEeWtGNncdNlye34quV2+qO3xKPo2hl0gMH76bG/H9U7TNf
	2/BAZVscWz90RGqt8MBGlPScjamoGmgYL0rdfSy3ECDPCigDidfJwPDHra5kDsv12iAOlOfVDYK
	b5sUAT5OBntOH8Cb29pJ6exy6xp6IzxQFiPYMYnaAnfUikyaGjjLW3rPswRdgRpYEnRXmNcmHoJ
	7UVnM9n2bcl9FlKUHN0KIqJA9dQim8bTurA2/ZvzJuW97
X-Received: by 2002:a05:6a20:728f:b0:366:1992:89a6 with SMTP id adf61e73a8af0-3898f92caa7mr6887750637.9.1767943279216;
        Thu, 08 Jan 2026 23:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs6QOa9xeUO4AhsQgCzcZWo5NIQzpXhO95M7HuPd07DAWIleAAX2o3DQHUnSO32As//Hm8iQ==
X-Received: by 2002:a05:6a20:728f:b0:366:1992:89a6 with SMTP id adf61e73a8af0-3898f92caa7mr6887727637.9.1767943278706;
        Thu, 08 Jan 2026 23:21:18 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb4c85bfsm9510369b3a.30.2026.01.08.23.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:21:18 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 12:51:06 +0530
Subject: [PATCH 1/5] phy: qcom: qmp-pcie: Skip PHY reset if already up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767943270; l=2601;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qCZcq4ePhl1M5OCnTIjZBXNlTVq1DHiR6pXLBB27pc4=;
 b=YpF4qKbOyrlgyQ4CyawhI7IS6EKsaXBA+4/Z0aFC6PdpPG7zBMYWxMqQZiX4GJyBrsCRqaoDp
 jKW3/Fu4WofDn1ZfDcK0KrKy+FDO4y/0IUdCB55OBqrI5hbEk22kX1W
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=M45A6iws c=1 sm=1 tr=0 ts=6960ac6f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=HRk0seaB8xIaapVIQOkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: k_tupV1Uxf8gPazYJymC868TqtDsE47d
X-Proofpoint-GUID: k_tupV1Uxf8gPazYJymC868TqtDsE47d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1MCBTYWx0ZWRfX/AqCKXYpY6KK
 cqANuH7pkhAhE8AurgXEVFhJ0Rd3vnGRyvkPnz1iR6JzKP9ZJCk2iDUW7PhQ2ygVwODMyB3S9pQ
 TLz+fee8W3v9oG952xBVEsryQoFayoH8xoB8ma9iDRdqVp6YRSzN4DW/EoE89mVtudzElMifSrt
 yLZPfDWKzYv4OnE+QHNmkwQE6kFhAYdRuqiXitWsMioBiCT6ErlJTiDqlwbDusKIpGMdqdg94QN
 mSF2Y+WD1SSNAV9gBlrb85aozk6l4TrzBLRyKNBNEDWqeQKSlNiiKwDgbBWHapWe+qNBtYRlvDB
 K6uxEWvgOJ9jMixsCKcR1GPAQv7nCWVxLscH9mpr+5uLlmmJCZWGnpXIettjXXTUU1wgO1rhTLS
 iiLCaFse+1zStuoasjzRNiX+XIVnXTXP9lbsS7ia5Ldhye1TG7T0vOG47htXJJ+g+3cnqZwE74k
 69QbNuq+y0c+y3X805A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090050

If the bootloader has already powered up the PCIe PHY, doing a full
reset and waiting for it to come up again slows down boot time.

Add a check for PHY status and skip the reset steps when the PHY is
already active. In this case, only enable the required resources during
power-on. This works alongside the existing logic that skips the init
sequence.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..c93e613cf80b2612f0f225fa2125f78dbec1a33f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3153,6 +3153,7 @@ struct qmp_pcie {
 	const struct qmp_phy_cfg *cfg;
 	bool tcsr_4ln_config;
 	bool skip_init;
+	bool skip_reset;
 
 	void __iomem *serdes;
 	void __iomem *pcs;
@@ -4537,6 +4538,9 @@ static int qmp_pcie_init(struct phy *phy)
 		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
 		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
 
+	qmp->skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
+							    cfg->phy_status);
+
 	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
 		dev_err(qmp->dev, "Init sequence not available\n");
 		return -ENODATA;
@@ -4560,13 +4564,15 @@ static int qmp_pcie_init(struct phy *phy)
 		}
 	}
 
-	ret = reset_control_assert(qmp->nocsr_reset);
-	if (ret) {
-		dev_err(qmp->dev, "no-csr reset assert failed\n");
-		goto err_assert_reset;
-	}
+	if (!qmp->skip_reset) {
+		ret = reset_control_assert(qmp->nocsr_reset);
+		if (ret) {
+			dev_err(qmp->dev, "no-csr reset assert failed\n");
+			goto err_assert_reset;
+		}
 
-	usleep_range(200, 300);
+		usleep_range(200, 300);
+	}
 
 	if (!qmp->skip_init) {
 		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
@@ -4641,10 +4647,12 @@ static int qmp_pcie_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(qmp->nocsr_reset);
-	if (ret) {
-		dev_err(qmp->dev, "no-csr reset deassert failed\n");
-		goto err_disable_pipe_clk;
+	if (!qmp->skip_reset) {
+		ret = reset_control_deassert(qmp->nocsr_reset);
+		if (ret) {
+			dev_err(qmp->dev, "no-csr reset deassert failed\n");
+			goto err_disable_pipe_clk;
+		}
 	}
 
 	if (qmp->skip_init)

-- 
2.34.1


