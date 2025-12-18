Return-Path: <linux-pci+bounces-43250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968CCCA95D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECA1B3014F68
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93882239E9B;
	Thu, 18 Dec 2025 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dltcYNCp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R2Q89NSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B422D781
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041668; cv=none; b=oiD7DQKKRQjOTOOwkaMzoWfGdqeKEjzJS6vc9hMFSvZgWY/qS0S1qlG4egZF36NA7u0Wy8qHVu4gDyKKwnCkH1i9/hpH0Y9KSKmI1Jzqt+GyBtEa2fagee/zNq4uy/fXN/Guqz6blmx/ynvmwAa/t/jFuyYKefv38Q40c5AjBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041668; c=relaxed/simple;
	bh=zhIWfIAbeRifEEK08wUVDmcfjUSY5wqTdVr2XzFL9uQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rHChyXKCsUOfHrumMwYSGyp7Su3bS2iw+EUbXzH3UI+IvZ+pQcY7g4GWGPI8VqKimnaMIDwDtS8twUQGqMRlULOQ4T4OoM9/SLSfHPcjHpIYZNG96BYfr+USn6QlSBFT4yr80QoaoaX0dLicIEFvHx5cGmTZUGwfIRJrC2G4tNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dltcYNCp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R2Q89NSv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YcT2813844
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hh2VG3YFSe+FK0FMXraIExmjgFSAV/hqrMaw0XzNRPg=; b=dltcYNCp/PU8uew2
	7QjACqjs/kgLAhW472Y8MDYOyYoHFUmOefcrMjc4ISATDgFH+gAtePSKBFwVTKE4
	faCjmCGYNSoRwhBB4aYF5ZuPFjCJgfkEvLXjkel14Ro+NnGD0A+gR7HA5PkMTj8u
	8hWl8lTDK3ZltRfLD8O2z66i92bwTZjuMbMk3vjB1/IjQgT3Pm5+lVz7fnNfPCoi
	UB2nlV29AZ3S3Su5PJfjYBDeHjfa8yceZfF9rVDEMBN/idLZIP28wr0tThTm/dwb
	coGuc5Rr2HmtULJ4MMQ9QV9r6W3eQ8gXt4CKpU30WJEi/i+j/TiXbrYJhJB8Xa0L
	toeR/g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v7a08k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so496491b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 23:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766041665; x=1766646465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh2VG3YFSe+FK0FMXraIExmjgFSAV/hqrMaw0XzNRPg=;
        b=R2Q89NSvsfSijFQj6BO/p3AqjZXAu2vBqFYGTAdXxIrlQzVQ1j9xheAcQxFgPC1HpJ
         fkdfMJlOWEu6ltxYhhObxjCS8QexecsKlZdwgwyCY44QejJC7pv9BZETKjzBmsa7ppDO
         bYuVE40E6dJYO+q5AaLOSLOTy1XLHv/ODIjiWeidd6xaSfUs6ZrCkyRoU9BclN40FUP7
         WkzWiIE1177JVwmYTK5n4K/S6KTbShtJXqjzKrmMjgTO20G9zMFT4eORg4wJazyWECuZ
         vwppSdmzvtIuxu8wrBnMleR1KxCSZPke+KMP84ntku/UIMj05/nfwIjZ+5bYDunhATDu
         mZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041665; x=1766646465;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh2VG3YFSe+FK0FMXraIExmjgFSAV/hqrMaw0XzNRPg=;
        b=kNlVUwHaaOqrdn+6JSwp7pzGyBVurhmTJbvpG0cICVdOGeYuNNfLquzqw8tnVB2/ck
         7hwYXNv0CK1GhA+R2pOU9Yg0GkNODpM41JmK+MxaSjolAPcrLeyM5UDKrb5/428B37+i
         6jEsFjnzY0mUBFLuag9eSRj/KBHJiIJtXUOGnbLRfTYibgc8PQy+DVy7j503Fv82vMhE
         VloDl7Td9R1g4AtGu+PZ/sTqi6jeknoZJqsrUuzl/pNcDsY9PS7W+7cVQM1O8z7L5psC
         QZ4yDJatD9Mk3lYM5WNxDqXs5MsdLu4FPyfyHqp1iK0RB+zcWhG8pFQ0s0YaRWSca8Xa
         APEw==
X-Forwarded-Encrypted: i=1; AJvYcCWc7kUQQNOq0cuFSdQC+dS1Sgh/Nl6KDizh9LRjCiUuc3bc6qTYQlWWufP6B23I6HVHhsq5f03P04s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2ZuCkMJBLMMSDx7kHyM73WbwVzx8jkOwDieW+Z3Js6L1jWDf
	hg9Ty+GAjyThaLLQbyrrhcTJzRkpwhZSeIGH7/pBNx/yerYCJt/pKEvCw4UJ+VaH8T92SUuu8lw
	o5Qmv0wrkF1iJ4p8YYTIcwFqHo7cDHKLNDasUvg5EkIWFt6z+sD6VScEpT9mgNaU=
X-Gm-Gg: AY/fxX546PAJN4M5r/KBiV1qCeKgulbMNpTQJoCOXekbwjTJIAZAO+LAGy4ePmM28mS
	2OgN6Z7+5Vt9I9sWDstWFSYX+PhkUAEwckBRhYrZzY8pa0POskl8NYVcQEg4UgyRNOn8703ffCN
	83BdBnZ35tkXXL65ba8zFleFZHKSx0LA5Sq4J9QnHGiutdVfp07Gqd1bnHvDQZ1jh/rdLCj8aDt
	dDqk/mht9hyU6bk2bime2dAiivjOSDSLcxd+NG2M6Ri4H9rIsMNPI+nRBEXgAAS6gtZCa7h0qbA
	xGyqsCRp8lEhVMQhA6hQ+i7idlDcUD+0BGntCNgdMyadTZAtc1YUbLdcOkDS9iJ5QtoOt6TglCx
	f3OQkkTfVGVA=
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4471:8e4 with SMTP id d2e1a72fcca58-7f66a470cd1mr19278069b3a.69.1766041664691;
        Wed, 17 Dec 2025 23:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFe3idJUw0yYXcoiRiACrwrk0j6tYdjgrteRDIaFEJ8ebk4f1vPq+K+YB7SnXBa2btwDjYWQ==
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4471:8e4 with SMTP id d2e1a72fcca58-7f66a470cd1mr19278038b3a.69.1766041664194;
        Wed, 17 Dec 2025 23:07:44 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1185704fsm1558626b3a.13.2025.12.17.23.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:07:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ntb@lists.linux.dev, Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        Krzysztof Wilczynski <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20251107142526.234685-1-marco.crivellari@suse.com>
References: <20251107142526.234685-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
Message-Id: <176604166015.697128.10969426809262148398.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:37:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: rPr0759HQxsapZ7nw9U--RiEPcsagXY5
X-Proofpoint-GUID: rPr0759HQxsapZ7nw9U--RiEPcsagXY5
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=6943a841 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=_suGTTe_43wmAZudwJ8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NiBTYWx0ZWRfX8bo9/zbtovxA
 HI9RYhLJE0jLjrB/wf1WCbbXUNfNU3sy+FTqxmfeqf2ChZLY1Hav6niN8UTnVkCUGtxnw8/krdw
 uT1BfClzrPlkxieYd8Hlua8mkDJJWZUuVtn/MfsDE2qrS/bUWzGj5BQTHvozfkfD3T/Afp8eTRq
 bLq8PWew81RviI89bDDgm3HD9PXc8lbGBZMqkpVWMbX4b/v2KJmu9rM5OXkBbEBlJYLTRSWegFT
 LHE2lss8c9pY00ncrD1QhyhaAWTuCFW593NSYAp9qRlw+2FlZ41en3PvomKflcXM2WAVujy6DQ3
 Bwtp1IR+1Cyx9o9MciyLg1lvvdTfh530LRBbYa8U5F1EspkVzrwAuA63egx7XWNdU8NFWcCInIi
 B/HykSYh9E8yDd9ZwFh0s7MgHv3S8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180056


On Fri, 07 Nov 2025 15:25:26 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
      commit: 8b2ff37c6b50cbe722ebd780aac40f92c4f8efd3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


