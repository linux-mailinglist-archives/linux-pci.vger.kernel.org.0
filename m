Return-Path: <linux-pci+bounces-34502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C34B30AF9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 03:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9125A56807F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FC1ACEAF;
	Fri, 22 Aug 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gvMD08bF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6E1A9F84
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827621; cv=none; b=Ed4uTVwQU19/a3+10kN+92ECHOkfNqwv9FTJyoaNP1oC1669VYw7imDttsxFqNQN/H/vCFS54Aw5466PaOn09vlPeh93XwF1MVK++Y83txtH8ebgeug9URsJzIw38+mQhPxWNowlPjS62NGMgmv+D7HjgC657++yGM9Fh7Gu2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827621; c=relaxed/simple;
	bh=lcRbF4s/PQ23VSgcKM0p1j1KRQGCkTB/i7Aw1lz8Rf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dK5Kd0JDpI3b0Wod9hOHhW37ywCIi3IEmq66ruo0vQNecH/4d2kIC1B7KSqAUceEu35lAYVya70THaRYR61Aep/L/57EZPNBJYCdiH/wHGMAr310ZsxYnkeuC1UeozvMtuS37VjSeS7XNVKayQEa6Yt4iWsHyMC/BNo51uFrg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gvMD08bF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9QW4012741
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 01:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fQ6jAh+MsWJrW0ys+uDSW5pSsMHNRIQOD8QB3d9ba7w=; b=gvMD08bFuD3rSToW
	SecdwBe6Lj5LswT69wQ/2Tf715JQYvBfIZncY3lXN3AVpABeqNlCmW0mMIrc2/ue
	8EMe+e0Zw+uGiSXhwNl0cEeV/uayB1EfB/kzaXMQoJFqLWiwoRtxeJ32nyPYnlye
	9D1HD4kpSRFh7nRVI/tpk3u3HY6RLPMtaP4SXFuyPaOpoACFeq18GxVD1/jtQPSX
	byYb84Dqsjn9FIEXITDzjxbfFvvj/HhyyZl41ihq6nRVFjyRUrfQtHHlOESst1oB
	2QPZBSZkp4KUNmmFQJtwTQ8YwYRexFbwRhS/cCYKAl1/ZuY5bUl6DbIhi95mBg3o
	VwAUmw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dqbdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 01:53:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32515e8e4b3so425679a91.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 18:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827618; x=1756432418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ6jAh+MsWJrW0ys+uDSW5pSsMHNRIQOD8QB3d9ba7w=;
        b=AqJ2G6eNeesvqP5gK5L5SdBpOs3m512vYcq85txDbzOyxAbLAxYA5Xvf0svr6mJeE8
         E3QPY9EWSg2ROmB0e3xs6M80aDJxe+k117IjixT37116L+mI6qzwZ+SrA3+LD7eCbiCB
         eYfBpwO8UuQd/0roErOU7AS+VQVkwoym6AoZYNQShfVp77aEwnSxFme591i4iOxdVSyT
         YhYlCHo33VA1v/IE7002jldw+/oC02zC+dTYJgI1Tgfq/anLkXvrAQfTgQe0ocTcu12g
         KvpVZqEjFhcrsPrXy3kuUQHTm4rj5nonIem8wKxdfUot+XOhsTcO5tIUbbokH48ZSx68
         pIFw==
X-Forwarded-Encrypted: i=1; AJvYcCU65a+Rxc63iBjXbtYkoULqbw9PvuMxhb7C9GkvtMGENbQ2ECv6kNXqc9C89h9S7lFnJwhdgYCkpGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFijkld+Tr12js9p6Lq9VZ6nvwoEuCqEcPT93oCvY4DXxiblAW
	VSuiwzFVEkEZKLKJmarMRVuufC0UHZ65Yy2jKIsmpORA6fHuOgYGETeLHVucoYG7NyOITRzwus+
	InfN3crrrHTVTiQGRRaPCoZGqZaGd6KNv8ibIIYEHCNw9iC7IOVUc0TJXxpVneGo=
X-Gm-Gg: ASbGncsWBAg8MTrzbGf5FhJVgrIv/etgmhz2xt+jUxyWU/0sxDutVdtcddEUKL1cers
	Y53DXh4ANVThzP/E2SijfxmzVvzz1MMGljAvDFq6018ojWQsjlb+yK5Jx+hqpiwa2ElYIaMmfrw
	wTLld4KDtf2RSu+nV7UeWyn78h9kbgTPwtXVvPSsJ3CdYiX8+9i+uSA5OqYXVjJcwg3rP4HB2F2
	LQsFXGY59sjndrozDi4F1DwI9wxAarlMHJs5FuvI0v7udihy487P+ZAp1xAOR4/5pBDRsSPBNmO
	IWwsh+U9fWmvkmDGUA2cOM5Qv7TBiN/s8OlKpHm2BfI9/IisLX6QBCop2JnCiMMWlYpJiRJxu3A
	3gfev6dlxPMfi+4TS6jHbknHpvfOd/g==
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr2092820a91.26.1755827617889;
        Thu, 21 Aug 2025 18:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9I9vJOh+MwLycDuGMJzFuq4TmcBJ+szXaNAIctyyZVVpI/P68vxK3Jv34spYw+h3HbRLGtw==
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr2092783a91.26.1755827617441;
        Thu, 21 Aug 2025 18:53:37 -0700 (PDT)
Received: from [10.249.96.170] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325129aa68fsm1012282a91.7.2025.08.21.18.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 18:53:37 -0700 (PDT)
Message-ID: <74bbf915-23cf-46c3-b9f8-48bb43ce9c56@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 09:53:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
 <bm3cp2vyw4rpllkwoxoxwrvsjxrtolcroqwx76bkpwmcdvx7ag@b6hvybyouq7m>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <bm3cp2vyw4rpllkwoxoxwrvsjxrtolcroqwx76bkpwmcdvx7ag@b6hvybyouq7m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6oSFkSgXV+hE
 WRKAhzHRuGDRixrkip7yEJjrnYNHby1sm5K/whwC0gVbyHTACjSfDs4LTC3nmEJXnnzlmqpvPqw
 sUihSPOIYKfk7Ac8YGqOfA0jz5UA7fNN7ZHFMql4CT1YIhI5j8luP8AF22+21t6FdC2htJO5LhG
 43AvDPelCy0dbNgIO/T9+i8+VhdnjJYVxpITO1oFi4EZ4j5wzj2rnNVXN04unVMygahFXf38IEg
 HMBGTHMMbVxBzgdlmX7QVcqSLw2sNKgbQn+MCDrLjjFJJ/fz4SfQJup9iu6TFmyo3lJn2wgkovS
 ejIBJVQpFfuIQLJyV4Z8vN3i4bCQcwRxjZFATFTXk9heaw350j9xFFGgc7GT2NQgazFF60CFh+u
 ZI5r4jgTgBQTFTFRKToaCbv2woXx6A==
X-Proofpoint-ORIG-GUID: BEjon_v7uRq79R1jn0eWcO8r4o6hJt5x
X-Proofpoint-GUID: BEjon_v7uRq79R1jn0eWcO8r4o6hJt5x
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a7cda3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=AsWi3nSQ2um4y-UoW74A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 8/21/2025 5:57 PM, Dmitry Baryshkov wrote:
> On Thu, Aug 21, 2025 at 02:44:31AM -0700, Wenbin Yao wrote:
>> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>>
>> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>> @@ -5114,6 +5143,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>>   	}, {
>>   		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>>   		.data = &qmp_v6_gen4x4_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
>> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,
> Please keep the array sorted. LGTM otherwise.

OK, will fix it.

>
>>   	},
>>   	{ },
>>   };
>>
>> -- 
>> 2.34.1
>>
-- 
With best wishes
Wenbin


