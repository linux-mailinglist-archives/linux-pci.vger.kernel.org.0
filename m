Return-Path: <linux-pci+bounces-32657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C292B0C756
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478344E4E8C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC8170A2B;
	Mon, 21 Jul 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAiCgRJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D82D23BA
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111104; cv=none; b=VewBYSfv2QfN8a1xl6r5lWuOuZfrQ0AbmANguVqPwqHDhYg6LF6zFV/h7FyxoPW2gRssmexZm02RBoons75TCKPj+3q++as6D+mPJa7DHSq6cJNqnelsoE3vnPnix8BGXNmTHRiafbH4qM6waRai8+kmgbuOrsQw6nW8Est8Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111104; c=relaxed/simple;
	bh=SXL92SK6RLnjeu4TR611q3PmOYh1uO3csbhddbYMOKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V2/Sy5Ih45pjHbTUdWQlYk6Lzmx2F1YIDbA0Q06rWZXsVwz4X8p6F8vVScOu0SD+IQpOuh44SYk6uPyjVZ7jhqUlKOfEAlr000ir63IPQBr1i9t6oaZgsoCgWt0QeZDl+DYxEoThB+2DWAM5uCcN/pIRPKZsQO2NVoMHFlTJ9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DAiCgRJw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LACvxQ001178
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 15:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1BdmigYJpjrB18BbkMDFazSUEuKPPs8PoGZmiojEMqI=; b=DAiCgRJw2OwUoLBo
	xejOmvcpDQLO32S7cxefoMsenyKV6lyVx3Mgr+0bXGlUDkurKUXh3a9TpZ0bTpVQ
	k+2hMswXU+uio/dDzKepfL0Ae3Lwyvvn2lTcW+vVpGmTH20vO7vrrZQ2Wq6rSU8H
	tO4kqDkizXuo87O8miuGQZab/fegso4cuYYGnqWnSh3ub6GjRdIbShDSR8YVWGgo
	Tfys32Rqf0/dnLVlpzxsOyorWJv2xB3duHLxsGLwglfbp7llmCbBLPZLP2ljmbeD
	XaFY/I8bu4ksT8QxSAIOnPA1awLGBEmoiWzSt5OOqskUPLy2A0yC01BZO7IEPrIh
	SrKZlA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044ddsgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 15:18:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2349fe994a9so35696765ad.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 08:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111100; x=1753715900;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BdmigYJpjrB18BbkMDFazSUEuKPPs8PoGZmiojEMqI=;
        b=NjcE2EcvHOlUbSv7XmZ2foQxbpfmm+15+3xCuffz/PNmwhPJDg5c1gwQXlZsBRgHEY
         bmevi7YvE8r84/yPcXkNKT9s2qOm+1elBJ7xdx8/IR4lIncUFVGAtxok6HnKwx47VFjm
         LXd1dWSR4cnOKfAFR9bmFdE8HTHtEJWx1BCza/TVY0ebHTvOwCNZY82sbeQH6yllS1xN
         o1nbsVEJup3UFa+9hcCpKdHS/9TD27WsQVUlV9x54kposLIcDx0709fbHG+sG+76R08E
         yyGqGahZiB/2lwbf1sXLREgsv0bTmR60zeglvYjZhrkmHOr+vIHG6FzuhGtdh1HLT3rJ
         K74Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSrTXNf7DzNXhh2OerpacbE3a+jLPrsX/eUOsnhcN3v82kcvsbHC7CN/YRYmlYeCIJSIeu+gU6V84=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxJ6iJHQ9/yJt9DhiRqSiT8znXPHYC51gO+Mc0EVWI6BZyo5A
	SPgPG4xAAI6a0hCGjd8f/oZy4PSRPo6al0OZKJHtY/AL6Txrt+fi3Oo02MK3WVzXv0mjx9z/pvo
	K4K7rCljirW6mRFt1GCAV/JRofoQVjRQwwpdmfSOdk9cbyc+7rPA772xGUh8PweE=
X-Gm-Gg: ASbGncuaxhkbbjTIdk++tmdDXH5TlFWyIk3kwhrIPghOVGPFl6WfqpBhcjZNTjGkAIu
	cJivOTZmjRgA+Lp5DXlxSPw209MpdBfwnbE3i2wJGyPQPoT2zKhLbJ/vZwE+a5m9nVTkiKJE9nt
	vXJesplN8HoT128fzT/7yX7v4X4XIYr/FJR8ZgLpCd5MPKvWawxcB+ZzwkuPoZf37jWksVrdwed
	UneO/8qAiz1lFPnAVj8k6pjkTCdnHc7OIoJeGsSynz+2oDjessXOfT1j5ZB0XFNe0k4F6v4KOYO
	vKBoZNvPAe7Hf5oLzVB3mY3Y79yQp3SdQg==
X-Received: by 2002:a17:902:ccce:b0:235:f143:9b07 with SMTP id d9443c01a7336-23e25684c62mr307165885ad.5.1753111100262;
        Mon, 21 Jul 2025 08:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ugeT+tg1rObYeMWRAE4o7TCFabu2wYnT3Pq2XvXvsVUV+/A6SbpWkAPzmNqqOT48gw/5Cw==
X-Received: by 2002:a17:902:ccce:b0:235:f143:9b07 with SMTP id d9443c01a7336-23e25684c62mr307165455ad.5.1753111099767;
        Mon, 21 Jul 2025 08:18:19 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d22e4sm60329335ad.153.2025.07.21.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:18:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <apatel@ventanamicro.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        imx@lists.linux.dev, devicetree@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
In-Reply-To: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
Subject: Re: (subset) [PATCH v21 0/9] PCI: EP: Add RC-to-EP doorbell with
 platform MSI controller
Message-Id: <175311109182.25848.8880954995049551501.b4-ty@kernel.org>
Date: Mon, 21 Jul 2025 20:48:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e5a3d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=5oemJFBbzWj47VPNxq3P8A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=FZZ2ILZgcEXfV6c6dVwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: lUHS_S5hC8kqTuhB8VrwmQZEqeFJu0VQ
X-Proofpoint-ORIG-GUID: lUHS_S5hC8kqTuhB8VrwmQZEqeFJu0VQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNiBTYWx0ZWRfX6UJj82tiYooY
 6TudUQ9V3CONFWZuBsonC5mNe6rnVow+2BssaSIoNU6XSbqcC5TUqFl1dMKIIvTFJCpccBjz/2X
 lcNuv1zwKJQT+3NVNVoZ/7uXQxRaLJRqRD4IkVOpsZEKcMN7w02HqAgyBxKWlD/Va/T64Jzs7Kz
 ntlvxWjtgmtujUYbh3jIIUWc+Kaj+aWbGtVcKmWCCH0JsoLgKLKpmnmJcrBTp9tOnVw7yR3gYLk
 5Rh43p6dIxW/1uROCVR1YK/DFJYZPJ64/hTesvgJ6E82MR1uKjC+LmayOxGxGPKlAdghLyCxiV8
 ijiOSxNkh9T7SoOGp8OjAZnuNKAIoz6V6NDM/LBxzTowKtSPnkD8mM3rUHlH6o+D1uXl6Xl7YII
 veUwe4vaBCtdbTaE0C2tnRhc8qwU4QeYoXmPTtxMxCvLkNRndiKXEmPspKAGTVN3QLmKZaal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=839 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210136


On Thu, 10 Jul 2025 15:13:46 -0400, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> [...]

Applied, thanks!

[3/9] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      commit: b537ffe0eb2ab458f20ec135cc2b565c63a2ea00
[4/9] PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      commit: 1f2ed78e43abb9ac0856a82867f64d472368a832
[5/9] PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      commit: 1c2c5f9855a5cf4617bcda721c22dbd3345f06a1
[6/9] PCI: endpoint: pci-epf-test: Add doorbell test support
      commit: 5d4da5f8092e5a77ae371ae1112283b59790ac22
[7/9] misc: pci_endpoint_test: Add doorbell test case
      commit: a1a293e709a4ec0fa2e4253993a4b75f581c6cf2
[8/9] selftests: pci_endpoint: Add doorbell test case
      commit: b964b4894fcfc72e7496cf52a33cbba39d094c5b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


