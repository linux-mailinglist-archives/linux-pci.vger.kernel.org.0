Return-Path: <linux-pci+bounces-4291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47086DAEB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 06:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385AC1C23412
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 05:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292D3FE23;
	Fri,  1 Mar 2024 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TfvnoU4l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919D50255;
	Fri,  1 Mar 2024 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269972; cv=none; b=ZkXuRARa0RVonkA3aDPf2WLZuKs82/NP5CncN+4SrSy1cM91DjgpBSK2S8mbva+nNElp8FpfH6EaGZlCbPGIGc2ha+I+wkVN4P4XvLSQW0yzfZis23RaTSjD2qKcJyTHLRHshrY+D89Bay+JuATgKkeoITKSgNdJ8aXF9YD5J/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269972; c=relaxed/simple;
	bh=56AuIvRZRYVZW3F9/Ru/KCv+HimWYyl1J7FNg7YPToI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULD9TxuK6WbPQfEa7opLSY8TN5gju853rTwi3fpZrT9i3tdRV6AoEyK/UL75LWGPLPVW0nyfdYmzjoklwDdAliSIQR9jIQiTNYklnaTPYmHaINYYH7XrhJOQleE89z0mJYrA1qUwBL6nYmCw4wHPhVu9lmJwfd4acJLWGKyjkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TfvnoU4l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42146RR3009410;
	Fri, 1 Mar 2024 05:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=5LhIvMQ
	3psoWBPfLm0x3yd9TkceC7/52XWiJNO5w+4M=; b=TfvnoU4lz6V1vL7/5osHwgj
	OvTpAo2BshBZqwKfmBnmEr0auBRrX2NUXlmbOIMSgnAQE3+lzZDPuz/JPqJ2Yx/L
	TqJ6BL66qI3NMnCeJ08zY93tIc6CzLZ2e7laDF9mcfAvsDPkUU5aEOBm+4tvxB6s
	JplcMzbmmcj5PVqkAP56sKTLdtQa7+VtvqHhwdID8oZdMA76iln27EGeTzZ2xocb
	FGXGJ26AFauKvha/AYYRaoIXA8ktBvAxTqz737er/0C2WROcsse8c7uNMHLfueTW
	6FSA4EGXRm8c47HKBZgIA7a8mkQGB98/L3FsK4qDNjsZYUaK1/52jrpjtHn6S5Q=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjmwnbfg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 05:12:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4215Ca14008780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 05:12:36 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 21:12:35 -0800
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        Josh Triplett <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 0/3] Add Gen4 equalization and margining settings
Date: Thu, 29 Feb 2024 21:11:33 -0800
Message-ID: <20240301051220.20917-1-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xvkh62cVOShFyddpsMb4Sp7I-9RNdj1e
X-Proofpoint-ORIG-GUID: xvkh62cVOShFyddpsMb4Sp7I-9RNdj1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=526 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010042

Add Gen4 specific equalization and rx margining settings. These
settings are inline with respective PHY settings for Gen4
operation. 

In addition, current QCOM EP and RC drivers do not share common
codebase which would result in code duplication. Hence, adding
common files for code reusability among RC and EP drivers.

Shashank Babu Chinta Venkata (3):
  PCI: dwc: refactor common code
  PCI: dwc: add equalization settings for gen4
  PCI: dwc: add rx margining settings for gen4

 drivers/pci/controller/dwc/Kconfig         |   5 +
 drivers/pci/controller/dwc/Makefile        |   1 +
 drivers/pci/controller/dwc/pcie-qcom-cmn.c | 152 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.h |  87 ++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c  |  45 ++----
 drivers/pci/controller/dwc/pcie-qcom.c     |  73 ++--------
 6 files changed, 269 insertions(+), 94 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.h

-- 
2.43.2


