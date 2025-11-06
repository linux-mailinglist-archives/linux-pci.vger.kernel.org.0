Return-Path: <linux-pci+bounces-40451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E3C393AF
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F8A1A26460
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFC2E8B8A;
	Thu,  6 Nov 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fv7C8IWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KX+i5+PW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214872E613B
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409620; cv=none; b=n+Bg++fqiqOVRYpid2uuBI/xZIh7h3rXVlmsne0aboPErFbqoHai47rAuwVwRK2aofFq4d91BawJ9pvATXbkaXH9Yt7hmpUX+Yo3q8JoQlg6QEwosZjRVr/9ASiOTSOGRJiXzM4cUiTt+W5Qrs9BU6w7ZNO5U2AlPYbcOM709oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409620; c=relaxed/simple;
	bh=DYLwHmGdJ3coXsTh0PPuy3fj9KL/zT5BoMmCnNKTDA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwRgMBJCsbLc9fXXCXNF6S/8mRtyQSOH8OXU7lEKqVmHBy85N5JjQcPJM/DYDA0sAZHgCnhPxXhGC60szrr/4Ye3bv3hOVjAGskLnoyJ9ilO9+lgASSxsDoOMHnYC8iGJtnMozcj5t9FahVLCYiCFZclAwTArh6gVJE0I6nECDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fv7C8IWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KX+i5+PW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A60Hu7Q2326472
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 06:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hP3iVDjjm1Yh6lCxDh4PcKbNlm1B6eEBTsx
	Er8EUr5Q=; b=Fv7C8IWKKNTfWD7DUqKuBJ+G1XHzrQsl8QL66j8W33JsZeKpXbv
	mghddo2CKE6qqCG8WQJBcnbhWx1jIGXRVIyvzdo7avGzE1nd57wdSVhh5KX74nXp
	uuJI43H3JRk57ZNKCQitR/EBvV995sX1jZxrpcBi0GFlFfX+luCmHQ5s4ulSn9Ce
	HAFCOdHYk0KdbA/I6pKeBVAld1piRNotcrHKa4t5EFwsE/tpt0/6/G12v0iX4OTY
	nDtaEVmp3I57fv70WGzzeB+VXW+0+iDDqvidA/9mTB6D4040y6AKfDkGtsSfMIxA
	tt1G3d7FzGDGKuuFcSUpW1Du9Zk8ppKUVvg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h0v0u1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 06:13:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2953deecdaeso2428805ad.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 22:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409617; x=1763014417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hP3iVDjjm1Yh6lCxDh4PcKbNlm1B6eEBTsxEr8EUr5Q=;
        b=KX+i5+PWDpuGUK2kPeug8ovB6GiGRWmeKstEETsvrwNBiR5FBAKBTtLauf6jeyovTG
         DjWo9aJDxoiyBpKEe1+4LJvifYtplqa0MchZPon4iSRSbOmDZgTlffutROfcP4BcY+q4
         L8UEYNd8fXbKNRBp1fV4kd+BJ7wUKTJhIRAiUE8NZ2TPV7DtKe5RG9/sqEwqv3pCn5m1
         KODCOVrdbMMzXqL/XWr6UpUep1yC/UHRwyXZu9bPnXJxnzRC1FAuGYF9FnaP5oQdRuXV
         gltp6rGS61QZBlXGg+qAinm+6PwoKaCNhSkESDxKuOWqv+ngk7CM/WSpBnMVnwbI96VW
         fyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409617; x=1763014417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hP3iVDjjm1Yh6lCxDh4PcKbNlm1B6eEBTsxEr8EUr5Q=;
        b=Ci45IvodMELu5ovcW2ZkBV3j0i2yaUgzItfSHzQ6osLLrN80LGJdQHOP8GsqLCi3M4
         f3nq1l9zcT0qpptQf2lWrm6h9ZBpe6GZu78Or0HbpQdvOOXhSce5dRqBPGXMpIUQ0VuF
         4zYea1/74XNuOKHNAPmyhcpaWC/1S3G+Zc5veXwxWAHpFHlIt02eDxy3KUt3uOT+5Bpi
         rudw5kbJ5b6UCdqVNplhiFzB3RulxTiwZe0RIR8knEjCWo0LdcxBHeqUL8hbVPJ+nv8l
         c+t/3pBQ/t/Ux0sENjp7UEengR4YsQrgKN1l6wIYDUZbtZawdqPwS53lj5xu2aJHEoRq
         XNDA==
X-Forwarded-Encrypted: i=1; AJvYcCU4MiSFDMjWMdYWl82d/AL2CyIZXjL9zhXCWdEknIQH1eHweuqIG+z3lkqmiwQsit/hlCPZbrH4mEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1O3k+e8IlVNujF35wNztONrEHgmONbO8wMGyqMXoKkzVHEVk
	Yzw/sCqoxRhK1/WHZNXgVq1CRMif0dSRfyk0hqdj17tDwhXLDDuLod5y9vpxEb/apagKCrMksBk
	GFCkjFhUTQh13PouRG8lgfd1wNjnbHpx9weDQcZred27cKNHjNjZqophumQdx8RU=
X-Gm-Gg: ASbGncuUED4lfdfr94FKDXnGcuN46sRqf5K9t0qTG56bsSXfCtyZMzIo+mfoY6JQdDX
	798a8TLrvQN0bG21yrQVrhWMfUC9XHah0DF9zafAfvrkI/JaRDASe9A/hglGXXqf0cC5cALTluM
	QBVUsrYpzfJssO6RcLhrcmNezA0frtsj7ogc/JQBW8odi2fE+A7/peTkNDPkQ/oF6sHIs6hc5JS
	ae7WYceN6MfH5GuT6VuJiL0otgNzUeNojfy/5kEe5hAJvrzAxM1InVnTFZXh7l+0xgiGspP1mVI
	ARJ/UthSJiq+8YvTJh8iAhrFgutkVpbn32K+vrhOdWlN8Pfl3c5qNObxqz/JB/8+psebjAHen5r
	wdeMSxeUBjjyd8O5x
X-Received: by 2002:a17:903:2a84:b0:295:4d50:aaab with SMTP id d9443c01a7336-2962ad21137mr94077525ad.20.1762409616899;
        Wed, 05 Nov 2025 22:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEewmaTtY8AK26J3oyoLch8DjGfmDdZM/mLVA1EXvkwehtfnOLT0872UXtmqd16alDYM/BoXA==
X-Received: by 2002:a17:903:2a84:b0:295:4d50:aaab with SMTP id d9443c01a7336-2962ad21137mr94077055ad.20.1762409616339;
        Wed, 05 Nov 2025 22:13:36 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:13:35 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] PCI: dwc: Replace Link up check with device presence in suspend path
Date: Thu,  6 Nov 2025 11:43:23 +0530
Message-ID: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ec8gGWaVWULjEbds5zJluK3pufWqygMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfX4E0TAq+498Eu
 wf9TPQ085PWhJLZWnRCFTXQBwodWb8Y9U7ATdNjt9PYKcaOgtkf9CAaVe+ERA6k/70mCcbYb4KV
 R7+Y28542P4/qFSvKdg8i2+mpHxOsSO6XqsZHyd7/7n+EbUP8OBvLALfKrv9nFk2rLCceL5Zkg3
 6NirM12nQZx23S/PwFaLt3vOGZaC+iBMgv8lNOC9ZdtWxLpFl7f4YKOhyI1+gczTUJ38jbaoYw/
 VLdOFwK1DwOeDOdzM1T3Eb8g0d+y0Ff2hM9yey/gTxyjFMDoUp0WmRSApJyc3WXVePBs6DBXKoD
 9RaQHdU5Ug++XV+9wQ37yNJyF2wu/AVm2dmBGMzTvAqxaQGMA0kUBfT3Oq64dO2xL8KUmOiWAvH
 5guHafpLf+4ndL6B/0DJaEF25yj8cw==
X-Proofpoint-GUID: ec8gGWaVWULjEbds5zJluK3pufWqygMm
X-Authority-Analysis: v=2.4 cv=PoyergM3 c=1 sm=1 tr=0 ts=690c3c91 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=h4SL0BZ7AAAA:8 a=nOfjJzbYKU6Ixk5oWvAA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=Cfupvnr7wbb3QRzVG_cV:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060048

Hi,

This series aims to fix the usage of dw_pcie_link_up() API to check for Link up
during system suspend. The motivation for this series comes from recent
discussions [1] [2], where developers wanted to skip PME_Turn_Off broadcast in
dw_pcie_suspend_noirq() API when devices are not attached to the bus. They ended
up using dw_pcie_link_up() to check for the device presence due to the bad
example in the pcie-qcom driver which does the same. The usage of
dw_pcie_link_up() API here would be racy as the link can go down at any time
after the check.

So to properly check for the device presence, this series introduces an API, 
pci_root_ports_have_device(), that accepts the Root bus pointer and checks for
the presence of a device under any of the Root Ports. This API is used to
replace the dw_pcie_link_up() check in suspend path of pcie-qcom driver and also
used to skip the PME_Turn_Off brodcast message in dwc_pcie_suspend_noirq() API.

Testing
=======

This series is tested on Qualcomm Lenovo Thinkpad T14s and observed no
functional change during the system suspend path.

- Mani

[1] https://lore.kernel.org/linux-pci/CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com/
[2] https://lore.kernel.org/linux-pci/27516921.17f2.1997bb2a498.Coremail.zhangsenchuan@eswincomputing.com/

Manivannan Sadhasivam (3):
  PCI: host-common: Add an API to check for any device under the Root
    Ports
  PCI: qcom: Check for the presence of a device instead of Link up
    during suspend
  PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if no device is
    available

 .../pci/controller/dwc/pcie-designware-host.c |  5 +++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 ++++--
 drivers/pci/controller/pci-host-common.c      | 21 +++++++++++++++++++
 drivers/pci/controller/pci-host-common.h      |  2 ++
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.48.1


