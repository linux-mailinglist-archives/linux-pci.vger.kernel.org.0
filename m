Return-Path: <linux-pci+bounces-43261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E7CCACF4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31926300ACFF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283DE2EA173;
	Thu, 18 Dec 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+PjNPIP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ed52xWHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1762DFF28
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045397; cv=none; b=EjR/FrF5ZGLXT1MC5juUySpEqc6YwiuHuHIj1l0Wvii5AJjEMeqIeVczXID31mL3UvumRd6Rd7ehXMPLCjAOsfhQShSZKfpL519CODPuFbvsvFNuoZFO3Wq6lXWkByrZhZLt7RlfW3J5K6kuuGbEFBkOmZ8VrX7PtrN3YbgkXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045397; c=relaxed/simple;
	bh=saa4VKlFYyLHfuWyHCKZ5f+ZXKNvWIGJSFi6Kv3epTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m4Q7OX82YL8OaTUZTju+nzhoF7QL08gFHxHSix4R1IXM8oaRKgyYWfY4K6/tAGbCrYWv+2d2GEEVhfUkVFp+IrbiXsDqHPslWG7aiYGRl8G0sp490gFfsVnNXAmYK0YWerJwcxFCzUbacfYay2FvMK8nC0+4GjCQ+ABG9OKZ5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+PjNPIP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ed52xWHn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1ZC4I4058529
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0PRJSZMhYjIrNXAJQcqmzs0QiGuEw9weuKeOmqDlpz0=; b=M+PjNPIPNp7lk+vS
	Q+fDoqhgvjHbentJfBf3yeRNqQdmMkBniYLrMuYRMGDqOKntk5wHVTMQ8KzizstY
	n1zq78trk69FnGhbLEhJgl3T25clS7ZCkpikxddGIJ0pQgcdplhYoJaJcCcXh1nz
	Hrn03sq48B1hX2Ffc2+cQo+y4b1JkucKMJ+EVa8E+iVM2jmN3Hz5VF0/sWrHzdxn
	0rG5eiz5+tfIni4NzuDB3saRmOsmUDFhNvqIEd/8jbAolBapI986pcYib3ecYCXj
	4+uV7E/B1TMmT4chTYKS//6g9ec/KQx8rJAkUefGVg77je6qG3hNZjKs0jI4F+rY
	qrdCxA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3xr5ap48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:09:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b96038aa68so416358b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766045394; x=1766650194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PRJSZMhYjIrNXAJQcqmzs0QiGuEw9weuKeOmqDlpz0=;
        b=Ed52xWHnxJV59FHAzY54I8STw3mV84YxrBngI+Wc4aAA4dIzg7k8ZoYAWvlNC+kopU
         ocwgO9J8rwljHvKC5HX4iE+7E36KEADtOKyhGjryB7Bf3wuUjq0PFT0dLk02+Ap2nVG4
         eIVU/7tilPdAiY3NhhuXa9LiVvy2J1ivd9p+pZmbLhI8VJwP68ZQSQnG2inG5RpctNi1
         KM5HRzS6n3Fyjd1arjfaMDOzkisjquQg8CmXxAkutk4RC7otSofdu5pje/k2tUkPWuF+
         AlZS8kbPGKA1P87H5QjiItuJp79k4WHvRAsjQLOdAdHjaNRkkTrRPln5mxtZJ3DrWCNL
         gRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766045394; x=1766650194;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PRJSZMhYjIrNXAJQcqmzs0QiGuEw9weuKeOmqDlpz0=;
        b=CkgM7b9mxRM1UR5Dw+9dAjsz4H6XqT/4zUC/+U5TTNt9oB6rEZS/EWyLjYrtzMWxUk
         X77RoP2y4xwyjSou1UwVmnt/8Xk//eY5hIzMkKI+7XOu7G4gvcy0qNH+764L2/cpKJMT
         xyf8TSPmSJQm3EUx+yT8Xt7fJVpoqSefgZgI56khGVXo2uX1tpx7CRGnK+3QBstmoEI0
         acz9iHuLj0yZXlIWYTfA896I2x7pcQ3YaARQEU95xzlgQXQmD/IWAwKV0PgaE2IhckU8
         qe4TkAewyArQiS3u5T7tnU3ky9dxnMInKubfHS9Ndu+Fvsybs8cEfcETCz0CGHTJljUM
         l0ZA==
X-Gm-Message-State: AOJu0YyHSOe3ObFd0gkprDSeXwz8ChhdWg0AMD675JaswCYaeErlqp2w
	wy5xoI6CFYGB3TqB6uuJAqBZjFAJ49Qr1hc5bnERvCw1R4l+9v1vRGmSYzQ5HCZtZqhuXd0PM0B
	iSRNKk99GX+cnkCjHQsAdgrlECVtlVkGNhz3PtPsJwCnjnAFQmAQFWcumdYBF4PY=
X-Gm-Gg: AY/fxX68HxjS39Azi0kBQG8exnr8HpAnLv2yN4PuvUd0gDhHOTBQ78aOXaalIKyOSXF
	lTRaxbm7iCm4VezanECKJs/ihnQEjxJkSKqbnqttXs/q/kWLtoKiu4FwOIbasA7mAKHO5ka/JGA
	iDuemM7nELvXIoICAMMvfVQK0ha6j1pBIcMXTBJtCrRe+HzzwoUFOUMZJ8tpx5a+/2O2HXVo9TP
	Q19n1+c0oIG5Q5mO/TwHEAwZrPoBSd59v7tCpvuXczHeydFESfpK/PGQ+dfweAIjph8hq6KHB1R
	UI2uL6PbBePKYYAR5zsnrs/miRKQU3ztNDOrZu+GdfO64UIr0ZFa6Fv3WbitPqdd6ydHTNH6VA9
	cqZa1vqR9zDg=
X-Received: by 2002:a05:6300:6c07:b0:371:b0c2:4acf with SMTP id adf61e73a8af0-375526a87d4mr1612183637.7.1766045393607;
        Thu, 18 Dec 2025 00:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmIccgva5UfIoEzAcbWNW62aOKsmh4XGCH3pevdPzZO0B8HmmMiRvdVF+mtOme/r5SawQ5/Q==
X-Received: by 2002:a05:6300:6c07:b0:371:b0c2:4acf with SMTP id adf61e73a8af0-375526a87d4mr1612168637.7.1766045393117;
        Thu, 18 Dec 2025 00:09:53 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d19269f0sm16396495ad.79.2025.12.18.00.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:09:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251119023308.476-1-vulab@iscas.ac.cn>
References: <20251119023308.476-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] PCI: mediatek: Fix IRQ domain leak when MSI allocation
 fails
Message-Id: <176604539000.841113.9092054369644605366.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 13:39:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: TSb0uwLIpnZ9Cg524VY5WaXBzeycYMi3
X-Authority-Analysis: v=2.4 cv=DsBbOW/+ c=1 sm=1 tr=0 ts=6943b6d2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=GFOaCdBx-FylsINtx1sA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NSBTYWx0ZWRfX5/RoVZX+VQ+3
 9lu7OGSMY1Am6Ur5VtiXuvjXV9PPEgJu+LV7yiPRig6s1Ahbk7a1pLGB5t/EiZz6oDLqwQZsMDH
 fsK7H4L3idcWH0Q64m3bhpEerL/fPbrWMkYNfz1f9y+SXdSbo6Eyg0Ol9JGY7raSU8qlsU4ti+J
 Cpze9DJtbuNikJFllveBVpJUxRm2gv1evT/NaVCdAE+JunhhWf6MbnAK3GsmfO2gTmmBabjlrcJ
 LX4HtQDYGCYHDdZgqzHHnOi9u1usGZduCHNUmkT/rqGtneqrFwSwGApCNlCJLKMReTPEJhuvtTu
 Rcala/gCHZ/GllHF+ySAVKrY+aE0qGtW/Qrz42A/BbotWnS/hYMaQ5Mftm6oJ8uVbW812LfsHGS
 XF5YkVt4GvZ/+jqBLIDkiYYIvCPRdw==
X-Proofpoint-ORIG-GUID: TSb0uwLIpnZ9Cg524VY5WaXBzeycYMi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180065


On Wed, 19 Nov 2025 10:33:08 +0800, Haotian Zhang wrote:
> In mtk_pcie_init_irq_domain(), if mtk_pcie_allocate_msi_domains()
> fails after port->irq_domain has been successfully created via
> irq_domain_create_linear(), the function returns directly without
> cleaning up the allocated IRQ domain, resulting in a resource leak.
> 
> Add irq_domain_remove() call in the error path to properly release the
> INTx IRQ domain before returning the error.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek: Fix IRQ domain leak when MSI allocation fails
      commit: 7f0cdcddf8bef1c8c18f9be6708073fd3790a20f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


