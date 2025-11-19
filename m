Return-Path: <linux-pci+bounces-41668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DBDC709CF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 19:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87ABE4E54F5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD234B1AF;
	Wed, 19 Nov 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izGZTs45";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cfYbru2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAD22A4CC
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575828; cv=none; b=DRutB1IKoHTp11z5zkMraxk8hCxj/9Dn35AjbleejIQyu+2ucUld8GLo+3GE2zUrZgkmpO4BJXu+Z7wHc7YkHOtdKuHGyBKi7FccM+H0/DgA/jarPjJvXPqvuwMOicTVEElnVO3ol8HQAxZqeqgHuy31CAAfmaQnL6ExBXF6IcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575828; c=relaxed/simple;
	bh=UqTRfGTlLFnFnLJT795Gce5rgRelPWEYSKPJHW5Q1A4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fRl5+BQYlzTUIWEGmH4VzzeAIQuQIBGm+xDSyQ+b5Td/tpwAd+HXgRNRetfyaX5GVhtCHkgvxDC1SEs25YQnlrbGDU3PsMhn3pZ4lqUxp9Ad1qAFDmqgytxHRr050sbUBpyM47HUMfHSN9H31MljKAD1hC71Jnu+ZhDHIMCvYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izGZTs45; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cfYbru2F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJGFc9L1970068
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gZohcjfk+swEgCLeoS8gcI
	uGMGrfbfG9q4MR3r6ObsM=; b=izGZTs45a8ELZVRJQF0rhgowIGu38a+1di5vHP
	JU2bFAEXl9ZM2NBg+7lutBjg9aAzxqk99WZK+XxpDGF4+JBIdPCE99s6WfWkUrXX
	WEKvBOvz/xRoAoNTVCvGqxeRwxmQAlUrPkBORDAQXeA8VyC8sd8l1d0Kkf4lsHyh
	XQNDB70zRfPReRsWKLs85zjKAv1TpOGo7xWhXPmAO9lI9T/IzS/UOKcrpFmSAAb9
	83Rv1PHBt2dEpaW5RYNUmeRvNzvJUZd744AqvE4n3zsFJPMB8Bu5ceCz3vVIdoe7
	3L/oErlrB6ws/8UUNUI4gFRkr5/ZKmyhzYh5kit5HVdImwCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahh8t0c92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295952a4dd6so14686175ad.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763575817; x=1764180617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZohcjfk+swEgCLeoS8gcIuGMGrfbfG9q4MR3r6ObsM=;
        b=cfYbru2FoX2z+Z7Ja4fvdJTLJMQ9UUTnrnwL+pdjOmItmG2Cd4gN1+66z3PgknPuS5
         FbbEOhMHjNkKPXwRdMTSKqpD2JVbsOMyTOL/wNQDz3PRowrzKOaHwxuV//iTo+FGnU6+
         hn5ui4aLa7ElxcY5UUAFDpfzFfraDMFstJETpPAiJOiXHCtKqrt56+/+b1LFT+LHLyzK
         KMqsMHagdaPw65rcXrZqeUnbvKu16MK7eR+6XAT8peiNE9nq2UpMgoN25lhYGAPfqXuU
         OFxjzYUYT0d5g1MK77x96r4ILoXGa/Hu021fv9Ky3bcHhrqlx57FnVIP6ZrgBJU7MpkF
         PdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575817; x=1764180617;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZohcjfk+swEgCLeoS8gcIuGMGrfbfG9q4MR3r6ObsM=;
        b=Z9hvBFlkoP545roFxj6DmFGGx3zDoOi9RT2ckVftzoIBc3BN+jxNr+/PKgnpivDqb4
         btEgWIIP276dU+KzrI56R9TQuw029wVmSrafosk3p0IhkIzSnm4WHt/fB+QBg97EdFxA
         UejseSSIdqtGobCBlJLEdAclrZuPTAYuRas+3sw3VTQ+5Ual33nVtqcqrTYrSMgTW+Lm
         BuXSN9rCNLRjSI4NuctTKpJqFssV6WaIeYfVJ8sZsKz7ZMtRMN7Cjsq50NHdVKt4VT+V
         Yd96iFVVb4GDImuW+FcJ1dcb/5RmBG0pD9FpiYGK+03c7LfQ5bLaDrPIpBKuS7hJVoml
         Clsg==
X-Gm-Message-State: AOJu0Yx1dti+di8UUNTsO1R7jGvDZk6FwrO/k12CT1tZDsJX49Cb8HkC
	cT1weCTAgfKAGm5zHZIgILggwD4hmunRWyBY94ssnrin0pfHgc+s2DeaiJv7f+JB3G9AHrSP23n
	B1GQyLskYy0RF/krDuCoNtQzuQ+92J6Kxi+aB0ET9glEKJT/VCN13Q0oplyJ2c/E=
X-Gm-Gg: ASbGncvXvjb2OalQpO519YClc70WCwta2TzGP2du1z1RclETGnzGz9qy/LCGYD2BEqY
	h+Nx+nCcw1Y2YcRfhEH/N5EbRKR7A+9nyb0n2uqt9jVborcFXTnaxpMtS84nuUCp21dEXC72kIX
	iSJES1kX4lJZwSzXe+9nZ8TvCZMjrRydUP6T+bmYJcEJxbJMI6upWi0p36wKMldNZGJqH9el0Ir
	cVJFaKhwi9p+UUeDPjxokbRZ89HFBj5cv+qSAfhVQ4t03SgCTkQQ3rGu77Xy0UQpy8U5QvYuVwK
	Nk8qiEkNkA2hBqEahN+hrCMxLhU7JhSr9wbzfGwVJ/xmlpe3thAyGAPQD0jSiKOvKvVdTd0t0Ti
	kq1NCQ0CrU/MycM4oG8xBKFIWEJ+5xM5Myfk3wLQ=
X-Received: by 2002:a17:903:19ce:b0:298:5fde:5a77 with SMTP id d9443c01a7336-29b5c47b865mr693815ad.22.1763575817145;
        Wed, 19 Nov 2025 10:10:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFOSakO7OzOsLfzlojZ8XpanVLGi6MSPOP/5VeNmPyqr5K+/kan2jQvaZmuneUsjg4Dq5V3g==
X-Received: by 2002:a17:903:19ce:b0:298:5fde:5a77 with SMTP id d9443c01a7336-29b5c47b865mr693475ad.22.1763575816630;
        Wed, 19 Nov 2025 10:10:16 -0800 (PST)
Received: from [192.168.1.102] ([120.56.197.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111016sm1408865ad.6.2025.11.19.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:10:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: Suspend/resume rework
Date: Wed, 19 Nov 2025 23:40:06 +0530
Message-Id: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4HHmkC/x3MTQqDQAxA4atI1g0YZfzpVUoXOpPWUBiHBDuCe
 HcHl9/ivQOMVdjgWR2g/BeTNRbQowK/TPHLKKEYmrpxRDRi8oIhe7TNEseAynnVHw5z7chN7dD
 1I5Q4KX9kv8ev93le4TImlWgAAAA=
X-Change-ID: 20251119-pci-dwc-suspend-rework-8b0515a38679
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=UqTRfGTlLFnFnLJT795Gce5rgRelPWEYSKPJHW5Q1A4=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsiU42B2ztrMZjBV7pNA9HfzhkPOBkz5R6YuTK782W/+U
 D/wm0l1J6MxCwMjF4OsmCJL+lJnrUaP0zeWRKhPhxnEygQyhYGLUwAmwt/I/ldAaC/r5yuycyWW
 a3KfFTq4TOTW+T++S5JuMfy6ZsYc/WdiVsrNOGUJ9uWSbve3FslYzHiZt8RWy425MnjBJ5562+V
 lnH/eBXiHM6yK6J9Q0p9foym97lH7DkkuE7fq1F/nJhhs3sr9/fvU5/Z/Hl96Z5+S6KrZOs3ZiT
 Vi/fn2sq3SZvXNrkIb2XRvlnVuZ9CQ0H8bW6zZ+PWmg6O47O24jBV7rBX8H4fGiE3nMmuUklY2Y
 v53MKZTVXRBM8McXvkGW4FtUvy1ZjKB8ia7V3TUsJUsDPu84GHodvvFad/+yZxqfXTvXI6v2LdP
 m4JX1f/12XLx0+5n9je3ODgyd56cI5BS87Pv+wNDa/YAAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=F59at6hN c=1 sm=1 tr=0 ts=691e0809 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xeX0Tm50+WxWVv+NCdhSGA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=h4SL0BZ7AAAA:8 a=3T5FRkqcJ4nPFekQ4VUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-GUID: 9F2SjY6TPaXjMiK79dsYmm8V6w8xi5cB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE0NCBTYWx0ZWRfXwRPKGmaW1ui0
 zHtFsb0CIZ+ieyudDLIZi6nritRgMOK9N++Th26RlomqbJZnpoJGFsjlZMtSzFfHQOoZgOcb7ki
 5I2MZdIUBXk/89yCk110bIZiaEtNiiUG/iV5wMwo8z3N8wpNEshLjW5tATfJXpx3gsrYhCyfUPf
 8bZznN6HRe2zpo5YkrGzNwsviFDOt223CDzuzaw4m4guCqJ/ueRK3jjtGT+aMxnjldr3Yfhdq+c
 n84HJMmno8wSa7nVYUCcGOrwXl3kWvXEP1qvTgLjKMMn4jL5Qse1b+No00dL5wVA6M2jS8ctjiE
 3K3tnhfNCpmTynLfTZixtzL3a+CA9VVIOLPixk+OOxbvacbsd9/4aEb2CzeOj9bmh4cn1rADGvt
 qhh3zwnJYkK72HwFxzeny+iFUvOjCw==
X-Proofpoint-ORIG-GUID: 9F2SjY6TPaXjMiK79dsYmm8V6w8xi5cB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190144

Hi,

This series is a rework of [1] to allow DWC vendor glue drivers to use the
dw_pcie_suspend_noirq() and dw_pcie_resume_noirq() APIs without failures as
reported in [2][3].

Currently, both of these APIs will fail if there is no device connected to the
bus. This is not fair as suspend/resume should continue even if there is no
device. Hence, this series tries to address this limitation.

- Mani

[1] https://lore.kernel.org/linux-pci/20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com/
[3] https://lore.kernel.org/linux-pci/27516921.17f2.1997bb2a498.Coremail.zhangsenchuan@eswincomputing.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
      PCI: dwc: Do not return failure from dw_pcie_wait_for_link() if link is in Detect/Poll state

 drivers/pci/controller/dwc/pcie-designware-host.c | 12 +++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


