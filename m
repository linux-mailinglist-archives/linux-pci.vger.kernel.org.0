Return-Path: <linux-pci+bounces-31971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E4EB0277E
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A06A41A8E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056A92236E5;
	Fri, 11 Jul 2025 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQy/grzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67483222582
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275419; cv=none; b=DPjK3A8A6475slv8v0k05Vae9JArMbPour4vZw7rC7RVxl9L8Vd+o3Gm6/0Nr+RoKjXuAIObFCOs/FYJyzKucM/6dKgNtdXvgYhOP9HVYyWBpjBANAp1I+kMbM/YbAo3vseZGeaB7EubdlBojdIn8P9CZSYQxPManptyaxchAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275419; c=relaxed/simple;
	bh=aMkT7VCR7/G5eL1+EN+sboSxvDAd1jJ/UJlcZ65dpqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJK2B9zjNmSAbrZNtmjtzMLlI9q2EBDXNPCEI7J8FyiRS0VX+m/Xz6h0u8Tyo/ljWrvcK5yagoiSQUvcvkl+c0gayUrDDCcu6M01PtC5gwaI83ZxYvbh4wsMKfeN1JOS8x9LoWC7xEFrOTYB/lPd2ZOCj7xXNw4z+A5pHFdzDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQy/grzz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBK4F2002577
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJaNlSK/GbStS7lb9/17BUr8ds+mo5PWyFhZUdAGzHU=; b=fQy/grzz9xiKmQcY
	a9nS7NT6LgbLz1F96MqwoPoiXvRywypXDx6Sf08cSwryd9uFUVSiYqrOewsHCQ6K
	ZTYKYsQjPHxnBbsnvU2S3LSF9TADqJmEn0byQFJZkdELEI5dbfSpKsFRvr773BEh
	nhtbO+1wzVPcUyf3bkj0rIxAaFy0ra0lNI6u1u988q4kH/DEWPGZy95Vw6GlwYaE
	GbNeMh9C0hOz41mTHqQPMHBeRm8byif+HdRWmxpbx8XOYFgV4ZRLWLjMecQG1CAr
	xUW/C5Dicr/7KlfGcn9lxibMFkT1V13Wt5QPZoG1dAASuem8fVd1/DzwkLSHO6xp
	6+5ajQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucndgyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:10:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b0e0c573531so1882498a12.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752275416; x=1752880216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJaNlSK/GbStS7lb9/17BUr8ds+mo5PWyFhZUdAGzHU=;
        b=pAxnUeAsfBb26/s8w+ghTgpuFfVNpfM3bxbV4TbriR4Va4qAzj+iu5kHUssDspiwKN
         BBGIlnFSySRS3UJDSMQzgCVwLtlbynssCsMIacaz0Z3/Klvn2A6kP071xY5j5KSTt+cS
         6YhDV/fJdz5BV9WVhxZ9HX+023ldZTzqY+0BL/NObMV9mp5ALDB0nrAiRv3nvOGsPZWN
         xl3kU2cba1dHUTpAKCIns5zPckJRBc5lbh2wt37xuPQxHVEV2oEoG3/jenL2ruuC66jr
         Kulv5mnZ9ASIJe1b3/IylxZl0Ku1px8TRWyso4ZlY2Fy5PuAwCzoPd9MuWkdW+w+juM2
         0ecQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1p9ctmMdPMBjwxnEYfsFI2bmSVc07Tqf2ibJJ6/HZX+xm3zPy9TYpX9hyBvOp0d/4HuMDDFP92UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+uJ75jtI5GwoBeWKWxFBckkOkrkYlcVdvEM5QS/bP00D1C81
	tx11KxmWBS1Sm6YiZNBC2+uFHHd7RH32kFS837jNYk0Yi0pEEJhYJ7M5SHD+O+Wvfh/NEyns/qd
	bYIFKtXsXzuuM3KixGCs5CnOtq60cN+WEXh/7HNCORwSP+e1tZRY2KywqLW3IwlI=
X-Gm-Gg: ASbGncsoXwqctiLZU9+2UJreX4TPt8eITmWjdEMUAa52aauRauEDFlaTLloftfP5fUK
	e/1uLWlXCJBywf/THDdE6qkdAqX8AIc38WkoDgr7EGot3kFwx6mFmr7M4YcKRIH77zS9B79hlTP
	NfF5CvVVYpAgq+8Q6mcaOPn3qD2hxgrLmXPsr8kAsk91AMnbM9F4RyWFFAIGFTFFQSrm2FDIHdb
	XD0KQbyWKynY/IBz5+vpyfh2JRO8Jd7YubOH3N1zI/dv5H+/2FJWfLR65OXb8TmfQHf1CU4MnvI
	nblyxsJTPIGq3EOvyxVdLgx1UpnHn9bY3P/PxCAU+Oos3ikjAM1fHKZEjxej0OIXu0QG
X-Received: by 2002:a17:90b:580c:b0:311:ad7f:3299 with SMTP id 98e67ed59e1d1-31c4cd9d001mr7043609a91.25.1752275415667;
        Fri, 11 Jul 2025 16:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Z1TQfgkE3r2PMQwTwfxQjj0gjR9UsVQ1UbIMeevZFsnCWlYfrpvPY3URH71qwyKf5RhBCg==
X-Received: by 2002:a17:90b:580c:b0:311:ad7f:3299 with SMTP id 98e67ed59e1d1-31c4cd9d001mr7043560a91.25.1752275415267;
        Fri, 11 Jul 2025 16:10:15 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.227.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb467d7sm6197116a91.26.2025.07.11.16.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:10:14 -0700 (PDT)
Message-ID: <0bc51460-f25c-4607-bb9c-0e317e362201@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 04:40:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711230240.GA2312867@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250711230240.GA2312867@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=687199d9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=4nqOr+EkFiuPl9GB/B4vcQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=nqD_WAsoW_ZkbJYGnRIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 3Ize0VkKxQ5l-J0YB06lGP8mkGAdQb6b
X-Proofpoint-ORIG-GUID: 3Ize0VkKxQ5l-J0YB06lGP8mkGAdQb6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3NSBTYWx0ZWRfX6jdKo+xYLuRe
 Q91119ZNztCuFlbXSjJOwCHzvk3s/JbTNjvQ9a8hEgZGvnVv3hyddgDTOnFVRyvpXTWjWJSfKhX
 Fg/YsL3MvvLg5PRhriCWZYJPthkTLCE7wAS4YYrb9ONd8qA5BHWc9IzZ6R5nFpRXthrFlBev8cv
 huUQyiTqnNA2feGsdRDEptgydFT1XQ0AqQJZ8RvokBv+p56Xgj/gV7Ixgcyf28Bx8wBB2NQUeUE
 pLOsz98cTkefsKGetJZi+Z/ok/9ZzHTlY8ccvhM2BRqhf7YKQhmfydIw0GNhPJoswon/+kLNgF+
 NauhlCNw2ShfaDky0VmPpL1c0K3KODdSWJzV0Nzy4iG02LNhZNeLQlvEcMt0RQkbbURD+yUaZGl
 xt53O5S1eUv46WewZ5Cuxt10/BUEP7xcLtd/9akwP3JfG4La4s8CB/EMkAqhVFUp8IrL1X6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=868 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110175



On 7/12/2025 4:32 AM, Bjorn Helgaas wrote:
> On Mon, Jun 09, 2025 at 04:21:27PM +0530, Krishna Chaitanya Chundru wrote:
>> ASPM states are not being enabled back with pci_enable_link_state() when
>> they are disabled by pci_disable_link_state(). This is because of the
>> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
>> flag is being properly cleared when ASPM is controlled by sysfs.
> 
> Mention the name of the function where this happens for sysfs so we
> can easily compare them.
it is aspm_attr_store_common()[1], it will be used for all ASPM sysfs

[1] 
https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/pci/pcie/aspm.c#L1595

- Krishna Chaitanya.

