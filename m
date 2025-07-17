Return-Path: <linux-pci+bounces-32392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8101BB08DB9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DCD1C251FC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A812D836C;
	Thu, 17 Jul 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSxIg45F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F11136351
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757254; cv=none; b=dE1s03AlLxUHwpq2SH5kldGB3gVx0L8n992P5g3bhqEVVtwyljhDpkeCqR5RA+FzY8ndyBS+6DRlb/5+miK1puofd+xSMuCfs1U9chmK5Hhp9uXOFDBf4W2qtNA391m79aWXHeJxO2o0J7ze1TX+cRjyyzwQ9c7eYmXqNcbJdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757254; c=relaxed/simple;
	bh=0F1kHARcqcek/JZk1Kigy9uIt+1rYuJ4Elk2jvl60No=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rKizv/aynELUbEQSycfPhi5gL3dlS7VklWfg02K/f+o3fUqbbIFqp07Ohej79vnPE0IRRSTlOPjs3FjNZnr1bz/I/f01ZV4F9JXw5y8zcoTNtE5fz571HaMVZb2OLZ2ozlheCrj5Pyg4HD6E7otKgULhoEVIYZZFE21W8UPpuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSxIg45F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC65uM025209
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SGYhux02JkDeCa7bIXWDqxESSxZrWDxZm9RthkuLWPs=; b=dSxIg45FvwQM5cyM
	axuHeEj0+95O3CP+FBMh82/SlkonuknNg2NiTC0R0VKT6iIxFyR2fswcBjEkIJLd
	YWrni3OiCLe0ROTyk9VUDRce5lYuf/bdiHQfGq2uWGvpSRVUj4l25soBsld/T/HP
	H4Mk2Fx/QV/OCXPI9ZKZ898ZmTYcjV+sh0vyMCb68e25xLbIIDnRRMkAn+hHBH/d
	vM31IEIfPdJDLkzAAoelrkgwQC7CrYYevlwBabL/hovkVZGaB7e3U2jU2R1SR20g
	YwLXfdZjL8pi2nhAGX+1DQBH8+rJ5irehQx6lo5laQq4EorZOcqHYYNOGFIG45lP
	JoSQkg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqbwdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235eefe6a8fso7769535ad.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757250; x=1753362050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGYhux02JkDeCa7bIXWDqxESSxZrWDxZm9RthkuLWPs=;
        b=WncPyxiwUYuRZ8QxycC4v/ciGBkupB2ZCXRBUOQ83zGFSwbUd2jmSN5Gw1mL42TuWc
         HdLUESAe4RdqIL1Ls67Z2khOexvJ9KRL1NQ6CwSHLgj8YpT1U51DtwxU6PYFXPUYYCMV
         Ms1qI3SWg5Av/OjlHhdgEbXLYPZ1cNa/FLisHfJHXPdnDGO8jq9+dfM/KTw0MHperGh7
         ScmNkjvKdgNYA8fDa5mDg2dgMqFO9IKn2gNDFr/NXoaY/Bs6La3FzBUsn8j106tnLkTM
         F3ahHDyq2TRAcA//h7pcAWX6iWjR+8mKY6FGe+xks4y5WQh0CQZt1gL4xaV185HWIuMD
         ouDQ==
X-Gm-Message-State: AOJu0Yx/ldLuiRMK2uRKIRZuR7+PFT/3lYIVBgxR1MDWK0dCPlcOjXzG
	prY2v5Nd7Y9hMd5axnE+dikF30iwvn/a+kbE2xKmQmruMBQ0MtsNI9ClWu+zfqQGuPmMEj+/fLW
	t8FgoCEQsAdaOYX+AmkHjKHx3ZhCTDPfv+yWgKHulHVZUh2kcu1wQ97xjl9M5HgM=
X-Gm-Gg: ASbGncv7DAHWvDyXUFCw+cp4P9XbeJJOZ0STnQlzg38TTxxH0aAQ34y+CZzXLdW+hJd
	gYZDblT9iSZ0Zth2u1lG7UIhAclHJgxbTIRWnLSBbLsgzC3emjPdzvxvC6sBBLm6MfknXVZuemW
	wKjce8dJkIOlD0d2pZ+xWw8jcn7QCBDtPPPZsr7sQt85M/eo+UYFupqdGT0QLErE6OeF0rzzfVx
	n7eFCWNMHKUquo0SdOo4GdQ0hVA9Kb+bv61qHCx5LUtBlh/kHsCwl5d5umQz0RZbNec908Bsb9O
	5Ai6pMWf9fHO2gk64rCgf0vmXHs/k4WTZcO1
X-Received: by 2002:a17:902:ea0d:b0:235:ea0d:ae21 with SMTP id d9443c01a7336-23e24f52331mr113997175ad.35.1752757247675;
        Thu, 17 Jul 2025 06:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1kBVO2Ywe21J3crd9hiessDh7ZOs86Yr8mTkNt3GXBW5oVJGDQah7i85OKCnPnB58K1SJkg==
X-Received: by 2002:a17:902:ea0d:b0:235:ea0d:ae21 with SMTP id d9443c01a7336-23e24f52331mr113996235ad.35.1752757247142;
        Thu, 17 Jul 2025 06:00:47 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:46 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710180731.2969879-1-robh@kernel.org>
References: <20250710180731.2969879-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pci: Convert st,spear1340-pcie to DT
 schema
Message-Id: <175275724382.8776.542107390528988557.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6878f403 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=DHq1HpS8T7VkJ5FY4o4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: q7HtbEBYZcIlO36fqgGNFMo1T872UYBB
X-Proofpoint-GUID: q7HtbEBYZcIlO36fqgGNFMo1T872UYBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX+eTcamd9yROF
 N5Ph0EmEM8WnTFS/a33X/suM2KkJeYOMeHHHY93sErs4YtIbYqYF1FUuAbkfbZQBCH8DGG1+/3+
 4sG8pTfUCJuhsSNVJKOj7j4ZHvxpuZgOwiHZMYR43VB4aaR83VTvH0vjXj3yxeILmIbWlIipbJj
 ErD8nortDDPCqFkr2Uf/kpCMtsB6o4ZH9YISL8cYbcrjxxM1djOd9toO6iEbIR5HgnRza3jviRe
 IFR7cTMtnIi9aENF+r4hi69pgn0+uGZpkA6E/+Qrw7nVqli2r9cENoNW69tCHLp0w0Q8yY0m2+H
 aTo6heK3hJKLpfqEbvS0SlmQleDnSj9qcy7TBbwvq1nmXgT5/E4pQR9q3QPCvrCZ1UDtZlNv+sm
 NS1DjOlJ0DsKAXhZy4uBbMDWoWFusfaHW/f1r0a66dOBnRpg7DWOBbCRfZokyCnZe7S9/XFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=772 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170114


On Thu, 10 Jul 2025 13:07:30 -0500, Rob Herring (Arm) wrote:
> Convert the ST SPEAr1340 PCIe binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pci: Convert st,spear1340-pcie to DT schema
      commit: f8766fdbefef2b0ac4c068c03ecba55a111051b0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


