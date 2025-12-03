Return-Path: <linux-pci+bounces-42546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A4C9DEA7
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 07:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316834E1854
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63898296BD7;
	Wed,  3 Dec 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9pjnpVy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aM3z52zh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAB28C869
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742832; cv=none; b=HSCT0lq9BsDR6BUTB2cCJHpzNjxDuy2RcGuveBe74NNy6ax1ZCi4tIVAlAbKBPJ0ZKuzzZOV7CSTdwN2GudFyrV73vcnClY5wCRpZo2cE3JTX3jyK+8AuTosIPiEAeMbmwpYM0oHFAgun/iZnCH8gQU42FwhcoY46gdBZjqIzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742832; c=relaxed/simple;
	bh=I7lwbfZ/sum9ggEgkOLvtEKdXooFwQXM1w2uQxWV8qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkMB8+HfTK1iO6l/QCDE5g5G6BQGe5LMJE3AiKL4vzVh/vcqmbZYOKjBiizTymq6R9UkzslXCZVt5xsVbD8hhajIt1Gz0+plhydypeTJet7nmR6CTTdiiE03iZvj0+YQE8w3FQhxEnYRgpDG/b10jQsa7kd3TrjaPKQ3EKbMhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9pjnpVy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aM3z52zh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B31W7kR805897
	for <linux-pci@vger.kernel.org>; Wed, 3 Dec 2025 06:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LW1GYrD2JFhsUAKweVjyXQ255XeGtyJhg4Fwtaiyosw=; b=T9pjnpVy98QNOSXz
	cVq3UV6bqx/zc4TV0r6uaqq+kKwtYbYhovvjkSZS3MluqtX1LLmTP9Ir13wXgpqa
	9zg66z+Y3fHsGRrV3cahQWMEYS58JywskUaMQcMHbqxLNear+7SxRWUNuL6GIV36
	avigX2rOUCdUWlCmiygZpczgnTbkt5bMCcQbV95XSE/1IAmKU7BFjKH7cYW5oq+E
	qsKsEOnFKJYu2b2mF8A3d1vEv7SDJZvYCznoZDNadQxGuHYyyDWXM5HUo70lilX1
	QTaZVsJh87vAjFxZ3s0k98fQWRnoMlZq0MhBgB3dKD1n71xvDTIXirARdzLEYMti
	qmGzwA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atbmmgs99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 06:20:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297d50cd8c4so171011555ad.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 22:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764742829; x=1765347629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW1GYrD2JFhsUAKweVjyXQ255XeGtyJhg4Fwtaiyosw=;
        b=aM3z52zhGdYjJzSAFowQuYPlP9HnlZiNXNTeyfqVZNoSscMqAuV/xQ3JlpE9g2LBcw
         sTaUparVWMQ4wT9CeaC7Jqnq+vo/NORYy47RZyP4s+e863BAj5bbi1cErpHiGOIgT1j+
         o3K0wPeT6MsZtnoCKJTK94olOjrtr2k1PQN0dmeHzfHm9oYqHrb5JnI+/ZEJylQqB6Lm
         LUgtkLlJG/nZuo5p1T84J1iZu19seFKOYGAMM3V7OF6VWhW+haHwZPKYSo71vxCFRzAX
         sVIFQ1kcqfOSQFEJVSf6duskdxQicZ9Z5z8qBZZvLdChfSIbEeAAtpHfUKiGO50d5KqI
         N13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764742829; x=1765347629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LW1GYrD2JFhsUAKweVjyXQ255XeGtyJhg4Fwtaiyosw=;
        b=uYS5NalONFzd+JAyuNi1CmwT7G+L7BYyXfZCbD20+czndVgFMNQZx1sM1gW/r5pqUD
         JVintCxOfrRkrYgqcekcJiGIutoJBR0rwYiz+7xfvzmqKlBuDSzXN7zPFn2KPosZeft9
         2FRxKu/7iTDMGbs+QdrFWk1WBezXjWSpihBwnoPyyq7sqns8uyLHT8ZxsMYPp159Irlr
         W7hCUnm8rJrNEsXkFO1hAnR+w7n7FTVo5I5KjwEZHONF+j7V26k3gpi+HVpDC+7jE6Ak
         fBMqsbapmfi9QfvrjzvUbdZocZZK2/xvqdEwFw52gQ/azTr1WZHRsHcs3NKDClTRbJZp
         Ikcg==
X-Gm-Message-State: AOJu0YwDYa3KrpeiT1phzRc92Fe38G23t5T5DBPRYeFrNfUbYtt7d/jn
	uV9VPIjhDJ64++1sL3YLCkeEgHqoAZnhCwn5/4HCVHGOFoSBsV3bgO1vAoE7BvmrMyJrMRgBIgg
	/LoeN4m+ZInUCT63u6zFr1cmEPVvNzHxUJPGZaB69pbt5XhOAG8i66VT+7gK/PM8=
X-Gm-Gg: ASbGncuOzNnZTGMsLHnnJKzPoZbBlZ600F5adQMHzyYVroF5Y2Hdn3LF394wmuNfgFL
	ZeyqyAnA9Bb491NjPOVKr4Iksk/+uOGm+VhrnW3bQD6RpdnABk5da1lY5lQs3ofjXQPkdfo+u2W
	STg9EnPNWj+2cO/YXAdXDOSfmBzCJcMCWbFKabp1DqjLBKRjT5zxUjO4MBFINTtePlVF6giTCau
	9dKTmBV4VxUFyF6LKOze13bpkpG8jjN7OBKEqo+5UwnSI27wbn04NkjzrrBEBOXwQREi1GTTV9s
	Cqhxeypw1z7vHe/+iXvM7AvRvQ6jJA+hY1Piyk/jNcuN2fAckc9YA2qTeH5uF0AOUzgarjn386E
	MUTQ7EnHGUP8XDsiZWqm4vasD8gDiHr+cQcRQd21CSH2F
X-Received: by 2002:a17:902:f64d:b0:298:46a9:df1f with SMTP id d9443c01a7336-29d68312c6cmr16848325ad.12.1764742828656;
        Tue, 02 Dec 2025 22:20:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhXGSIO8MtMkKSym6XuUzJmnhvtKTzGbliKceMBcuPLAULtc5rQcMTK5Tn02bEe2kO8C8HeA==
X-Received: by 2002:a17:902:f64d:b0:298:46a9:df1f with SMTP id d9443c01a7336-29d68312c6cmr16847995ad.12.1764742828172;
        Tue, 02 Dec 2025 22:20:28 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb4026bsm174263015ad.71.2025.12.02.22.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 22:20:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 03 Dec 2025 11:50:14 +0530
Subject: [PATCH 1/2] PCI: dwc: Correct iATU index increment for MSG TLP
 region
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-ecam_io_fix-v1-1-5cc3d3769c18@oss.qualcomm.com>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
In-Reply-To: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764742821; l=1579;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=I7lwbfZ/sum9ggEgkOLvtEKdXooFwQXM1w2uQxWV8qs=;
 b=+B0U6fYX7brfCCTn1uvATp/kFIu76VJIbKc8xDsZ1MhL8nwn4bx/0Qgrh0a1KQmZbOEd6Dmb+
 /XmuNYKzg+TCeiMNQI72TtauNjtfxAfyJOuJkKzvorpb+8GZJ+LdE2V
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: QiyFQKuHjcj2pJezlQSXriF_6RusnBz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA0OCBTYWx0ZWRfX9wf0Cb4Lglza
 8Bsh6+tBS1aufuCJkCHL2tEWX/31Ls8VGl8T2MklwY7MPsCeUze/rWLw3zepfKNjJ2O+3iJ2fYQ
 Ferz8GT4dBIX6hX5IB1mMiirnb2AK0911zOnQy6Dcg4uDBjHWsT7wbPbIyDyMK4hpn7XEJTEV9n
 67Cz3DtEJ8Or9eZIN9ZI8fKwnt73ntIl0k4QCaXb6/d3pjwn1DcmwUvYfPcY81K3BCPtqhPiClB
 B1frThhrK2J5ASjyArzJfcJVgDlUPbCfpLu7L+I6zBh5bKLYGlLBlvW8dtDIBjNTyAEwhj14/y4
 2m+qAp005cFwXXTY8gmXdjIheMLTwSaWcZpAoRd9bB5jx4jJxvY2lMA22fOp8Ctg07LL89u64Er
 y8Mejv6w2GaLr95BJv6yzhMEloRR5A==
X-Proofpoint-ORIG-GUID: QiyFQKuHjcj2pJezlQSXriF_6RusnBz9
X-Authority-Analysis: v=2.4 cv=ApjjHe9P c=1 sm=1 tr=0 ts=692fd6ad cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030048

Commit e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending
PME_Turn_Off when system suspend") introduced a mechanism to reserve an
iATU window for MSG TLP transactions. However, the code incorrectly
assigned pp->msg_atu_index = i without incrementing i first, causing
the MSG TLP region to reuse the last configured outbound window instead
of the next available one. This can cause issue with IO transfers as
this can over write iATU configured for IO memory.

Fix this by incrementing i before assigning it to msg_atu_index so
that the MSG TLP region uses a dedicated iATU entry.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda51bde3a7157033ddbd73afa370d78..4fb6331fbc2b322c1a1b6a8e4fe08f92e170da19 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -942,7 +942,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	pp->msg_atu_index = ++i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {

-- 
2.34.1


