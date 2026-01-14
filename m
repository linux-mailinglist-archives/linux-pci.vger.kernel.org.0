Return-Path: <linux-pci+bounces-44709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AECFD1CE6E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD5E3038050
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD937B41A;
	Wed, 14 Jan 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kWBXQggU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMIxN9WG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6B2FCBE3
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376273; cv=none; b=EWUEkCbYqWSWPPfzNpQjKiLbq//fq4xPrQqEHHdFIVzHstUPvET3YVtnWCC3E9R7IQeU4LR6sTIR6ET4oOYdd0wos95vRQ2yBIcqkSkSLPEdMdIJfdNJK8x6exbCJ/1eDIcLGDFZDpAvFXSX+Tg13frBQA0xVuSOipvLgQfeGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376273; c=relaxed/simple;
	bh=prj+LJvF9O0gay9Oulhjr5EUZoqgCQrKxbRB0h1jmBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oZsaVsnxBpclz5z0z9qucVfSHsyQvh9iRwOaa1X+ujk5xNekeYUJJAPEF9nUibTpoxasxGnt64u363OdtbhuveNbB7ZJwo2mBTwxTu73EySMAoeUgJlzlXAT0+gflns/er9ZPxhZpsTZ6iz/pfN1C9ZYp94GlVoxAQF/uiNgcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kWBXQggU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IMIxN9WG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E66OQm2632830
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 07:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N8bW/rU3oGT54TyMlAsZS4cEzHpbcFqTk4v+cMfX6oA=; b=kWBXQggUpr1evQjG
	n08rFKHP0CtalIHbOev1tJUwJ4lMR/i6f8C6iI0vyqRVRjEDLgEVtNoJf9pU7P1G
	Xhc2YgQec+OD+LK1AjUuD5D6HbpEVqaEA1vJW/VV/KVaMw/+MtWMJ+OrtOqqb3ln
	TIBbvi5y3ShSYwhhQ1REmR6TnqR2EbWg9DyjgffhaS+azGjAtvMVt7duRzFbNF2A
	WIRH8rTG+ofMKuyC1XUwWPRFQrvnG+/tcS2Q3D1Tc/S0QG6o6dO423/JGqjN+X+A
	koQIFkhXLlrM8Afe0cNgEe9tJ866YvgQ5iazKa+vybbuRBJLyE4jOaZOXqYKzjZr
	Yb3EYw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnuk92ae2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 07:37:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so8914659a91.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 23:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768376256; x=1768981056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8bW/rU3oGT54TyMlAsZS4cEzHpbcFqTk4v+cMfX6oA=;
        b=IMIxN9WGl21V+u3oyjrASjKntz5hWpcg9c2cBR4Ak11TclDmCTgr8Ja5hr3CW2Jvh6
         Hg8LhPltU2n802Mh9WThHP3HLB08wSQVCNQV1q7OsUKswTyX5Q9VteuNJsmDSm5Ymupw
         EAOcTYtQOeflPETWB3/lNoxZBBD2Y1N7AG50PMOWwtiS2Il76DLxquzamAR8Du1VaEUj
         Q9+7xH0akitGwWV7izuat+mm/VK5NZgyBaFZXo0s8++fAdLMmF1pBZRHiqWJerxNmmtW
         aSb9SzPDEknDbMO7xx6UNwmveSYbLwyklMBwlaXtPhmZFxuXjzX8FJSqZ9thuU6+1LJb
         FLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376256; x=1768981056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8bW/rU3oGT54TyMlAsZS4cEzHpbcFqTk4v+cMfX6oA=;
        b=YUgztGVeoSb/ct5nwmSU4mWY3Mr4yv/p9cwFqizKiXWJ2VF3dlq2cqpKklifTecIu6
         67YuJr1VjLIEy3zdtumBTjFCLITKDRvI/Lorbk6mej9Evwu3zwtaOWHTozTBFMkDeRFk
         bFKeLwTcJ1HeVqaKENl7anT8Q3GHedqWlfiLjUpV3bp1nO7rSfQOOV1p76mYGUTQT48S
         zjPf3CQQ0kAWf+lgu8Mo60Erh1JIe+/6xT48e9/hgVu8Q7iMNjdvA8R565DpZFFZjsny
         URoL5SA5CJiX4AXAAzqimMWhnvYdBOggLIi2ieK1tgBF+aX0VykESNe9KypNnrbZbEsS
         pQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlkTqUY8q93xVFv70dSCHXVaI9+gVQP0wMmm0P2SNv1zDJ9S0avNdbTppA3UbW4pB3enMYmnjwWB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4awBUhgw6GT/NaMLD84jHAqpaEvLfZehJAmNynKgp20OfhYe9
	URUlpLps55NXr8aS9SK8IjAEz2vnLQeErYpOJKTftQOcqx9yIf2zbB+ZjhaQCC69/uTPTsSLXxl
	YgnudN7yGxdDgTSnXAPya3ncOnbd8P7CnYfjUWAt3VQTiNRUGcw/Bv6aHPLO+4M9Ij6+a3To=
X-Gm-Gg: AY/fxX54ooJ7Up6b9s1RI++tIK75u4ZPlWoLr4gdg9i+ymJ0b8hpOBhULRcEIHFkE81
	JZ7Otxj9U9bdCiq5SQVwS9lIU//4RTwor/KRcp54hyNM+RXcXIcjkcQvXK6Rz8kgyU89XgtnrvW
	v48bc6axoAQTDw9HAs/pIScUHBdkfA8J9dqj0NSeb4+Fhvo1CBOzQ7YSGYgxgx8CG9+ONz9pTW/
	WerIQnAkEF5LOwpCUFZHci1DCHpLiiCx5eOmVaEvikvnmHW9OSIIok7Upq3Hs7e9bgFQB9JzWk0
	4P2ztNRg97m9gZI3hEuufZ6tNWItlvDhCNWvwDsXqlSGBQQWvLFPKY3wnNnGIYmPO4TkNQ1xJEJ
	suFlZE3ex
X-Received: by 2002:a17:90b:1c02:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-35109128f8fmr1840647a91.24.1768376256321;
        Tue, 13 Jan 2026 23:37:36 -0800 (PST)
X-Received: by 2002:a17:90b:1c02:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-35109128f8fmr1840623a91.24.1768376255703;
        Tue, 13 Jan 2026 23:37:35 -0800 (PST)
Received: from [192.168.1.102] ([120.60.62.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109c78f20sm1113120a91.13.2026.01.13.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:37:35 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
        linux-pci@vger.kernel.org
In-Reply-To: <1766570461-138256-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766570461-138256-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Disable BAR 0 and BAR 1 for RC mode
Message-Id: <176837625328.207176.2407040245231111635.b4-ty@kernel.org>
Date: Wed, 14 Jan 2026 13:07:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ebQwvrEH c=1 sm=1 tr=0 ts=696747c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=tlgrONNCw2HA119KiuRAjA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=J8IMoB3hFG0qw-PMdxUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: JeIEStFzSMnyWtzBMUrEj-TaUMVtnslU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA1OSBTYWx0ZWRfX7768dEBPB/hj
 MAouE1BvYWhN7kKlZbJehcOWx+bA6dkH+QW4EIu1FD0/r9qGrRLVLD6Prakiim/RnKak5HAaoU8
 rMPY42bF+gUqKnt8mvqEQX048SkMB/DN+Qg15XBcm+52jXWWCOXrdnGagJz9Jiczj31uvZonoT/
 oiqbWRGQf35EZtw0PLpkEwV4iKslB8AacH6wYTmAt5aNrt3i7FXGTPXw8LfE6eeuDYikXLxptZV
 z1V5FuZp8sBKtHG22jgv7oCDTTavPn7NxsNWxw5Kz3w534c9agLEKe+72FhWW3DFQl+6urDFkZS
 xwlbAOxzveNXVPAOyMXQxPpZkAhBTDmdS8nb5Q7DPEzRTs8AJTBe3wiT8uQzJjdVj3tU4hG9V6Q
 s27C0gPHblrBH8dXEgdEmvyNehiZ0KGUOfShp3c98Mc+S6PIj8nmruUYZ4u1Lz5b83XMj/p9k7i
 ozaODN4cuoTdlCp8giQ==
X-Proofpoint-GUID: JeIEStFzSMnyWtzBMUrEj-TaUMVtnslU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140059


On Wed, 24 Dec 2025 18:01:01 +0800, Shawn Lin wrote:
> To slitence the useless bar allocation error log of RC when
> scanning bus, as RC doesn't need BARs at all.
> 
>   pci 0000:00:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
>   pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x3fffffff]
>   pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x3fffffff]
>   pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> 	...
>   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
>   pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: assigned
>   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: releasing
>   pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: releasing
>   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Disable BAR 0 and BAR 1 for RC mode
      commit: b5d712e5b87fc56ff838684afb1bae359eb8069f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


