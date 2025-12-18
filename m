Return-Path: <linux-pci+bounces-43251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380CCCA975
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4240D305FE6D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC8231A32;
	Thu, 18 Dec 2025 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tcj5i1sO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I4cNTaw5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF923D7E3
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041672; cv=none; b=KCHuOWo0fSV2ZlQah/thTBKCBCsKznE6r9qsyXL7izjvmYcHrK9E7UjLAVym51rO42ANx9PpBiby9wFPLTXGa/cmkvva7HS8PNaMMbXBKwU/rbkiB3a2UEjwmayDAF8WFxe/111jg3BxgGJ9wNp9LT3hl7hlEsc5c63rLopPFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041672; c=relaxed/simple;
	bh=UvVZ96eGgGZ7aZdP/ro0L4KqWpxNm1vDLLkOz27O/2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TW5+F/YpFqBQsiwi2cfIQTjVmMBc0Ci1ikno0lWiSPdU9JhSLC8lzmUjA0+Ba8XkTLvptle9vnokw0kZ4XnVfABo4wdyXL8Z4TBzvI0kR0kQeB0If/drHiRAuKSo0VY6+yOsiRJqOZDrkhCjgNRd2hkir6a0ORW0fhdICKvEL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tcj5i1sO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I4cNTaw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YYxN813750
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WO/7Iu4Vj+UiCe9ZLdLVp8Dioi+keWzDQdYuQnODphI=; b=Tcj5i1sO/731NiNL
	0K4F00Gn35wOCD1FfckYNPGRTsr20yQKHqxTQtXS+yyoBcA+r9alkNVawz2jIBa2
	poLY+aq4pASSZaOxMZRFxnH6yqo9u+mzoIZC+QmrqcAHcbECEn3VH7wH/F8Qr4gT
	aCHfSVpFGadsBQepw/+9nRKXvvca219O+13/I2IIZNLbaIjTRj35nEDBka0KxfCL
	pR6oF2IeNY/n44mLK5egDyXNtQGEEGp8lUw/YY04iuy8OzEhfKQAZX7EdUyXv/iU
	cFo7d6V2CLq4nXNRDpQd3cj7zUbkreSytgXkQiywZBvutM5bELSV26vrK8HRuG2S
	u9pPaw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v7a08r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:07:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so496544b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 23:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766041668; x=1766646468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO/7Iu4Vj+UiCe9ZLdLVp8Dioi+keWzDQdYuQnODphI=;
        b=I4cNTaw5i/c2zTSbCmsZKfl+J3SdpjC2dADKpTJj8YGhf5sJxPMIoLRQHizdrlTYFM
         XgombJrrGo5AT22TSILT32F65wAFAZlDmg/j6FQ79C9v9vmGo7JittAGgAjuiZ6oGlkN
         eJHYWwQNnRT7IEWwYJ5cum7Yue5Z3sml8tqBPiw2p4oN2dcpiHEBMx99XgxWw+ZRzmvq
         z6HcVWxGY4qyePwb2n0hyIttufTY50oU27u9MDn0XIEKAh+gbC9GCLHb7UY4W17B3Zm+
         +EiGrXyGyPUkQcxgjE4NbBjcTZuXJV6uJ4R3HKGy+uWtrAWeus6RolZp/coFQk14ZNLP
         EPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041668; x=1766646468;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO/7Iu4Vj+UiCe9ZLdLVp8Dioi+keWzDQdYuQnODphI=;
        b=nbiGlB8s3O5ZzX1SqyOu+J3+Fh3/uakuKlQUF5OAHFhVA07H7uNyHALanjlaM5y4wy
         BZkA7jtQgQ3pZn1smsn3P4xWC55djEhj/5K3213XxU5Z9HD+GpNfahzJbW/UpEoe4trq
         X4BgyiHkWilKLWqttqfNrfLkR+VL73gGyWXkqy07AGCEUyRiZYAQwNQkNW31y7r8ccxu
         DSjNR1HgLs7gAWQiKVJm/zYjklkHKipCkmdEmpP5n2U9n9TZQ69+IeplgRkMDvOR87F8
         0VGHg/isgw1p+HO/Pf7v9Iaz25MvLe3gqXueRP7yJvlP7yRcj4u7GPMBsd5N/7r/WapH
         SHxw==
X-Forwarded-Encrypted: i=1; AJvYcCVr0WI5O7CCCb0eO5yJZtI52QGluMQTfIMKOD26E0zIyDmJjfZiPJ1GymYyRmzH9wtz8boEDLjQKSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5uIJiCCJPRD8SixhupBDeNUYwsS5M2Yu9lor1ppC6CeTeR2V
	ID2/5NfFOkfFzr94/J/voID05sUgojFsRgHN8giAJke/78b4A5QjV0zzy85VLruepqZOeEF7NtE
	O9aTAW8AZRLHVtWBsfxaVHMmr7EkldBCstMp8O8cis2ZU09Gg7h0hM5ozu+9bqTY=
X-Gm-Gg: AY/fxX6T3M0ragUMHImuvB+SxbMpsV0n+4iuyTjUpHuxLQ91V5JGZnjsvwcyXCWMN/k
	i57fLtoErBtc1/Br5jdhELvBbD2HKRLuwpBGWAkVZSR/lVh9AXvJJeDl+ku+NGJJCsKDvMHDXXS
	NZ1o61XA9/a+NWWKAw8l4Gf/Ni3OR4SpyDS6tLuFZrZCNI/a1yCnae5P3nK6Mn3PfW7peem3w3y
	IUVsbWzzKh4cqrPPMGiITt79Bf0VB8FFULiNNDr/livczdySdV3uxHODptF/4gQn3REf8aE/d/L
	npvi8Y37vSjNbFqOikE9sf76A5Zw942YomVm6uiUa6u4Y0v632jC3Mi/n4tB6+dGM7wDgaWjEgX
	dcllyM8RuQrI=
X-Received: by 2002:a05:6a00:f03:b0:7e8:43f5:bd3a with SMTP id d2e1a72fcca58-7f6691b48f4mr18451594b3a.38.1766041668460;
        Wed, 17 Dec 2025 23:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIxc3Ba7kYqRT6O1G8e+PsY7D8Sy48R60zLnBO0db5g/v7kywvaHG0MylHhjnj2PISc5FkVA==
X-Received: by 2002:a05:6a00:f03:b0:7e8:43f5:bd3a with SMTP id d2e1a72fcca58-7f6691b48f4mr18451572b3a.38.1766041668005;
        Wed, 17 Dec 2025 23:07:48 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1185704fsm1558626b3a.13.2025.12.17.23.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:07:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Krzysztof Wilczynski <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20251107142835.237636-1-marco.crivellari@suse.com>
References: <20251107142835.237636-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] PCI: endpoint: epf-mhi: add WQ_PERCPU to
 alloc_workqueue users
Message-Id: <176604166443.697128.8351761767000938363.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:37:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: zZgLx8tgXZkXWmOJgCF9kdrtoameXsLe
X-Proofpoint-GUID: zZgLx8tgXZkXWmOJgCF9kdrtoameXsLe
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=6943a845 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=_suGTTe_43wmAZudwJ8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NiBTYWx0ZWRfXz/KiEG9Fjqnt
 7anFANgcdnV6ecnpurf5XpPvjpjZymx6BUvF4e8tc1EGWqrpk33d/oe3u1cPdNM9myijpxGFIXU
 IDLobe6djan6oySoNBd7pC2I6RYnoT/NfDm3V65M0h1ZsjcmzQypPneAgXTLwApaLFYpbD7Xw5a
 iXE+IgxWXhJjtKURPJeW4pNNENcSd9p13Jp2iKYmuRcP12u6pRySCvTOZyrutv6+RdYbn+dYfCg
 tq9E5y3ZZwgBwyPstbSLbdFbAoWn476OA9a8lmAn1r+4YN0rNAqCp4V7UKPZjtKIAdVYOX1UMl2
 PiCdeXbuh537jfVHozoDNZ96sNe/0gSfZCux544IWBj25/iXDEvd5npO2+oh20J8QYOyJUniNat
 UrAJVofwbVHMPjpB7Brx962BX57XBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180056


On Fri, 07 Nov 2025 15:28:35 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: epf-mhi: add WQ_PERCPU to alloc_workqueue users
      commit: 5c826b1540045cf5824eeca7c967cc25692afc23

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


