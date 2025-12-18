Return-Path: <linux-pci+bounces-43252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B794CCCA97E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A6E306D322
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052D923EAB3;
	Thu, 18 Dec 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JbdYS7yG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UK9xqIB6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB322D781
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041675; cv=none; b=UP9L9F3IDvqsTk++5sNGBSKnnK9x89NYWfHCxA/GgfkYslM1u1qf/zIa4Ok02u5N37baBRYgmdPOXVL712nVgY1UjNqBYNV6vHJ57iikUvnmXfeYPxLXGnSY5AXz2J/ILeTewAWhmG8IcwgcxlaDYeoZRWiW4bE9OXluewcyhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041675; c=relaxed/simple;
	bh=g3XBbXgeBacW9JCfEaMOhm6ihkGguoBLdwUEW+TveG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nEgtbTO/mCqZuj8IciTle+dyfkB2nNzz0DXQOHY+ZzKHrGa+8E/3sHVkM6OjNVzgcD4x2erv+b6DudLa4uhtdXOZFgOc64WHwkQj+nkbiXVQxfv86IbeBNLuE5BO0ThcjixdHq9TuhgIDGeFhfHIrmDfjXviYzm7Bw1QMKdabhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JbdYS7yG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UK9xqIB6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YUrT4057276
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NLRKQm7DoH5V37FRCWZ5C9eQlZ95pml+QQ+JfeIAZnA=; b=JbdYS7yG2ePYi/V5
	QDbtev0OEiNJA3BCQZwwK0s61f0WY5spliFBa+TE5Duf0bVIUooKTpGIBGjtKwTK
	f2bdaku1sL6u5O6YbhjZIxmhBfeFmJFktEK56IVE3LUbJeDWMINUuUX8sVZw8zvG
	oUgrIMfsXVnmyu6NCh6+dWi+yBCUkPcA+PjoJCIbVhXZ6RlbMk5a9tgpTzX8jhis
	ZmivsjuTF+AP3bqLqZPirKcsOrDgEqC8IAcQmbPbWlNVeS3Vdm0pxKVQ2rE3qYpe
	9RSoDnZT0oBfLES7+AdcH7cWlyQnCzQVnYpa4yIqKQ1qt44NXhTLKxa9/BDjVx44
	cpObpA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3xr5agvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so734467a12.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 23:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766041672; x=1766646472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLRKQm7DoH5V37FRCWZ5C9eQlZ95pml+QQ+JfeIAZnA=;
        b=UK9xqIB6pRJ6yLOy8SSQFo70rDgYr293id+NmZG6nZrbsY1i62xutdQVODB/74yzCF
         TV3jQIu9wRFTpV6klZKoBryxRWdWPYPn38V6X+VcqCzGhUaZmPkFvOrNcxW0NaE0D3+3
         GoSMXrBtlqlgS+BF+U6f5BE0AegreCJ8dmiemVdaEjrR/dsaiSoW8F/NYwaaEuaBhdSP
         fF3+Km8G3m8d0O2hrfK6aRM65YkC2lMNxNNqhLf4Y5QFhlR6hbpObxJe/fDE1/qtTSFO
         6YlC/H3uvPv3E0UsOKPW02ECPnBsFfLS5a86kKFdby8Sbnlo/lc8O2s5ceTUNn73rZ8b
         ta9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041672; x=1766646472;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NLRKQm7DoH5V37FRCWZ5C9eQlZ95pml+QQ+JfeIAZnA=;
        b=n8ad3xZUcrcs/XpQuXUoek9vymkQ/W2P0IhxKx3pvE1ilkN2sVzCU+2KUE7u/ojxQI
         BX2mqp35t+eGhFeol6SngcGTAOzsWGgZvkPiAR9KE4qbEKmb+B3a//vIF+dVz4EPJQcO
         SW+OTILor2NWmN0ZeEFVl3LdMfXF2d6bQCT8xU2l1Rj6B19ZOVz6bxRP7zJ9RgiNlsHq
         QiM8nr3vctEoGikIjp3Wj6wPxN3Z+YJlyGYT4+LRgnLQnPzTAiqdlFqRi6ZcnRFpx/V/
         DlC7AvTHUE0ofNVnYYOrTNnuOeJJ/UnUEoQm+WnCMrv6x/HUlcCe119VH13otlHv1Efq
         nGjw==
X-Forwarded-Encrypted: i=1; AJvYcCWCFihjRgM/3Nd/zQR7qqusHkWZRdHE3KRbJGTEOREfJQoGZgVHzw60cDPfzP0eNXEGt/hohJZSu4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNHwq55SZ4HVscafUUjtVZxQWtLtB1PtaL/srwAukj6NMJZ0C
	MkRcX2jw9lu9lRXyOHjtQpi7haWZRpgzHTxhW/ROACiFO1fdzy44LdRh/g30R0OKC9HRSsp2O5c
	MWhmLgrs0D0SexHsLR2nZ0DPhbksTQFAVMT+RJI0igzxSRzwtwv/ntjYHOD/4xkA=
X-Gm-Gg: AY/fxX7HgNnzFSe3gjf8w+aFdHHzh3uzBxLBLkky2Sy+zB2EZQz3WLfE1B0GOlLGlD9
	7Jo23x5cp63xLr5y0hhaYOWM9AInomFMLonFTbExYhQY6TVZio+lfevxHFDVtqexqUVsG84l1YM
	YSwmBP6BhagioyHWoTlGk5CuwdIxskFM66V5cyy6709KOsBTEzQoQ0hjUTs3Gpbig80kwGcN9Q1
	FGghp4N+BdZGXp/atBRH0zFHCqVWmyDLIYi4HFvAo5mmycCQKQPgALNAPw3kdclv8shCn46M2DI
	zT5PNXGREZHYnkvEFX9IVkZFb/JPmeOWZZERvCUB9aaczNRNta7eTZ9KIKSc3HGynyn6T/45A19
	yWl/UYSew2vw=
X-Received: by 2002:a05:6a00:3311:b0:7e8:4433:8fa8 with SMTP id d2e1a72fcca58-7f669a9369amr18982035b3a.48.1766041671920;
        Wed, 17 Dec 2025 23:07:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKfPxqJOeIL/L/iZacjoZESbIDMeu8FJkgs0Z2/bV2nGIAbYkcqvokItg/zt57uuve1lkqHw==
X-Received: by 2002:a05:6a00:3311:b0:7e8:4433:8fa8 with SMTP id d2e1a72fcca58-7f669a9369amr18982006b3a.48.1766041671449;
        Wed, 17 Dec 2025 23:07:51 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1185704fsm1558626b3a.13.2025.12.17.23.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:07:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Krzysztof Wilczynski <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20251107143108.240025-1-marco.crivellari@suse.com>
References: <20251107143108.240025-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: add WQ_PERCPU to
 alloc_workqueue users
Message-Id: <176604166824.697128.70874171767074760.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:37:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: -_q2GQguR1w2YTrgWiDGqPZh2Zclsiz7
X-Authority-Analysis: v=2.4 cv=DsBbOW/+ c=1 sm=1 tr=0 ts=6943a848 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=_suGTTe_43wmAZudwJ8A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NiBTYWx0ZWRfX6kTJWHNNC0qz
 l6GLwJHQr9i8SaPZZ6AdGKvTMAwXDAvF36Se/KGjYgFGotRIKdtBSRH6cgJjsGniDxr/QgDY9QI
 1svVE5eeRxx/dijtOaCwY0J7iaCKA7cPEUF1zAejv9xguG2RWkhqTWDrOmTIIChOo1yH/TYU3Cv
 YHRAuCRgz95cJfAitqTDeLVrEGGZEGhzCOQyvHJV37m6YZ20Iy2/vkseT5DoHHIqsTRyA1YE0Kn
 cg1dXlEm9mD1RMApEOfQVEhouEk/fW7RHJgPYKzDU3IzeliMjQjTZiffHN1Yg4u5qm4SbFwc3dM
 xM24WwhIwuSrCjhB/wehI8uKJHjoYkrULgmZcvZ8UKd1/90/nZLOszrdbQbVEk558dOZMc9Mepw
 Fc0E2UT9MHwm3Lw4O9S3NRS1t5DRhg==
X-Proofpoint-ORIG-GUID: -_q2GQguR1w2YTrgWiDGqPZh2Zclsiz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180056


On Fri, 07 Nov 2025 15:31:08 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: add WQ_PERCPU to alloc_workqueue users
      commit: 79fc1cbca2f0d3901d7927565799af7c92dfb150

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


