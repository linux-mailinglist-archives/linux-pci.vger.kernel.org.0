Return-Path: <linux-pci+bounces-33713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1CB205EF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA9317FCE2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE825A2C3;
	Mon, 11 Aug 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+1VAEJL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9E24293B
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908994; cv=none; b=CwRKaZiL+OE4DpoUhXgWRePklatmVojCjCJiMVZwDL0WMDTkXzZt2ZN5D6B08Y1oY2FqW8wtWC2VJGdyLEy4xK9j+uROuqy1LLCQAt170S3BS5MzpROy8m6pEjKKj5byddYVeSkoGSDZ10Wok7VErurY0wGw8kJTzgjJ8RPJTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908994; c=relaxed/simple;
	bh=uI1qlE8mNwl+7U/Zq89lRtEDqXY5odccHvrk8H31t3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UUCIQ6WMFKCytSw0Xg+dO/4kjGf2WOQ0AlAtaxEqoQQdeoMsiBvjYGFscToaxj7VbMWwmqShR8qDN8NBVppFcJEQzhzQcu1dCjKNZgO68YxHM+ry8pW1lAUbT/9BnVUrmTUxHNDu56FeTp/A7hMISC9OUQuJ0Il8QvRfAMRvfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+1VAEJL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9r8019056
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8zYECM9evko8+4kaPfkHLKf4WdgTATPIrfOBTW6QamI=; b=D+1VAEJLDSNUiaTo
	TLFhVViWnLmEST1vj1Xzy96kl2T27LjhJhhVnZAViKjqTdZSUCPr5BGHsB4nYLLf
	IFp1ZE1v6KL1K8DbFx9M3op/z6nzgeTor3XV7hFr3fw9yS/7IO/E6f41vtPEQOg9
	tJoDO6IUa++JKBGS9Hj5twnTDx0y5iLmCs/nEm66+O+nCfXn2yqyv7smtbvLqA63
	TTC2rA5JuWCDIDXPAhkXqYPpS9WReKGzeE25d1UOoMVC1QJB3DMAypcrMyg9g8kF
	qtPu+u65t4+1Xu9O5NGBUpvxPRUvET9d99zFMJNSTcDm4I88YbgAo7neelsjXZIf
	HRhVzA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduv1cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:43:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fed1492f6so64336795ad.2
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 03:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908991; x=1755513791;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zYECM9evko8+4kaPfkHLKf4WdgTATPIrfOBTW6QamI=;
        b=tWWqzbMzjyP8oejVe2VlpE7N1cp+HgGZxWgy7SSwkEYcaxOoxQYNlCBaFH7Fs/yr69
         sUizeo8wTgBp+vYgerAqxZyiKVmKJvj8qTWDmV4BuTRFedYV+QSb1h6PfSFRk8b5Vlkn
         xZIM3LWCZ/lE1+mI7FPir6suO+Qkqf87x9q19JQt2EknMA92ZWDgn0B7oNNsfBW+D9PS
         oLCyb6jw4/polQ4zT/SONx3IFfdTvmaV+ZKA1npf8yCfhIuFd6AvjuBREfus7tSigw/l
         WmB5m6vnlaxpC0qPePGzyDtyG7D+ZQtuum7ThXUpdzMpWaxI4UHfW0AcWn/8EkRpuX6P
         Ac7w==
X-Gm-Message-State: AOJu0Yw+izP5gHCgi/FL584CRS4Vi3iryCpIDCQtNbF9xVMXa7zT2HeX
	i7wS0GLZI5nNr32nsgW0EUnTcYb5qOQWY6/ECos4yXiximyCF0HjEOQAyPY8ZBR0D+XU8ILCFXp
	I7TLbXDmdskc0PfDQoDLlX1BLUEQ54XIWF7lGr4YwwhBvsxqliQ6QQvmQ2Env0YA=
X-Gm-Gg: ASbGnctzIjdXTdDPbKqpsSb6O2nturIZTzNA4RX9zOtexQE54yr/wC09PcqSs24D0Da
	jJN3h24UvUnsGMpNzYitCt9ghO/mtHXnHjgtH7k8UnIE22uAvdY/cFdUi/dDdOJozNFQPxSW566
	RZm9vhdNjyV1FgqK/pY2w4xpbshOlVyIcTpEUiLcV1gKAZ/sAOZf25HDpr0EVfmMT2YSRePUK5g
	GUGKn5nGS3vEkSiNECS6QP3lcwKzb4XnJxPb4KbP3omo/ZpjH/bPUPm0HZ7x2uY17NB86dpmkXY
	Yrmfxso8pnZoh3rlHEtnP7HO2YyXx5ju1y/k+A32
X-Received: by 2002:a17:903:2391:b0:240:96a:b81d with SMTP id d9443c01a7336-242c20703ebmr149368715ad.5.1754908991086;
        Mon, 11 Aug 2025 03:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlsLmB/Pp/RBYg+2IKrGsD7TxooswoCU4sh8Et/J0LGapHBMCtkeQm+I0Y4vEDJ1kjwbVqjQ==
X-Received: by 2002:a17:903:2391:b0:240:96a:b81d with SMTP id d9443c01a7336-242c20703ebmr149368575ad.5.1754908990693;
        Mon, 11 Aug 2025 03:43:10 -0700 (PDT)
Received: from [192.168.68.106] ([36.255.17.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cbdsm271590415ad.75.2025.08.11.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:43:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com,
        bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
In-Reply-To: <20250807074019.811672-1-sai.krishna.musham@amd.com>
References: <20250807074019.811672-1-sai.krishna.musham@amd.com>
Subject: Re: [PATCH v7 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP
 PERST#
Message-Id: <175490898683.10214.13460972543852737432.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:13:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899c940 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=tivzXH558BYE5qsfyb1zSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=PQAuWm2BogaHsNf8J6gA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: aAvnT_wEDrMt0W9_aaRvtjjc-7rd2-Mc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXwiu1Urvaa6ck
 luWgLNQVkOQpEKC077o94c/NWdw6T/rrvUWOm8R3tvx0xeoORfPkCLGbqkV2AL9stsYXFhpEf1Z
 QfuTXLjaFewxWVcwKp3an8bFOMxDU3bL205wmnkM5Q85s9uNg0KBYeBPv6eCwK8c2DIKDIab+Rm
 uiCv1KSaC5r471og4GOYtR37Hx+KCn+8B0q24fnUYXIkcF+cgBomP192eQFPavQNMKt+OxdxtQl
 tEMImAS0C/BJX6JTkwCIGlxa6OfA+u8GlBTfz+LJnfXdDm3eXa4ZQzsR7GbD+Y7KAt+q+1dT99A
 z3TEGry845RVLlfKIxOC03ZFJ+Wk5FyBUJI6vjzr6g2HLNhDJ8OmXTUMr6jzmXLh4iA58xLHGSt
 FX1c+/QS
X-Proofpoint-GUID: aAvnT_wEDrMt0W9_aaRvtjjc-7rd2-Mc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025


On Thu, 07 Aug 2025 13:10:17 +0530, Sai Krishna Musham wrote:
> Add example usage of reset-gpios for PCIe RP PERST#
> 
> Add support for PCIe Root Port PERST# signal handling
> 
> Sai Krishna Musham (2):
>   dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe
>     RP PERST#
>   PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe RP PERST#
      commit: 0b9275edc3543d0d2d03313a7c8de5157d61b189
[2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
      commit: 1d0156c8b230ca74272708a3206684e6d6157302

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


