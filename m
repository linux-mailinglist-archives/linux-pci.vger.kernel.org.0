Return-Path: <linux-pci+bounces-17790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2B9E5C61
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5466F287E8F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4A21D589;
	Thu,  5 Dec 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nA+oCSMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BABB22256B
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417938; cv=none; b=BoGul3VLG2IwROqSXcigKr7FSs5SIEq1kGba2jnzkPMmtuGcpvV8Ym8tFPk9vdtubRb/f2OPXWLrPZzaAkddGMgdR3onsnMtAJetdWBXSdd7rRknGG399aHqkqvJR7qQeIzPnyiCNFzYpnwBozR4m5DwoQWxZSV536zypCGkReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417938; c=relaxed/simple;
	bh=29LB2PMCJTqg6yaaSPjNIptSdWN5G/aO+7nwXHFP66E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiDMfNZuqmfW2g1b4TM3JKDFh8udl+W3nMJe+TuOlbEa6Qk6dePIufbRaylXtDTecXsh32FlB6TPdlvd2CDYLRlaspkg7aIGFN/1BkGabUPFg+8LiMfbbNVIgObFEwBCfA6IMcfkRCQDPo4UmJRAagTwW2I4c7c+Q29TBrQ1FAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nA+oCSMh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5EW4rY015937
	for <linux-pci@vger.kernel.org>; Thu, 5 Dec 2024 16:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29LB2PMCJTqg6yaaSPjNIptSdWN5G/aO+7nwXHFP66E=; b=nA+oCSMh4jchwVni
	RSHAfSeWqiZFtvavwFwCEDRSpwg+QzKYPVmowHEl9wIGzr1Tm1xoVIr+rbGlwOqv
	zDs3/cxXNd4DBCZYY9XlJ1qdDLhevKbLjzCJQbghWntsu1gZTxU8abzsvynthvCF
	niHKoqDIBkkoQb7Js67T423mJWBsW0hvybopO2i3W8FYs9nn3IPnae/ZG+1vnXbS
	s1KmUqwI1d6wHdnL0bwpPZgpBXfj+TaNclXbJPrikKJdhXBn553DqT1lN41BZ7aw
	esVExIR5Tnxh1jJLU27E1WSvDRH+Ce3SMwGr6xuPcIE05y28Bo3qnoatxIML9OFN
	Wl/X8Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43be170duf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 16:58:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d88b9b62ebso3386986d6.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 08:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417935; x=1734022735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29LB2PMCJTqg6yaaSPjNIptSdWN5G/aO+7nwXHFP66E=;
        b=k4Vw3qk3Xj+h3VVjAKQ3Cn0L3kjfKAEJsKnYLSFfvN6K01ikF4LsfMQ7VYjkH6jr35
         aPa/9EqMg2HBexH505po34ha7rhkzCFewt03E8GdFV+zEN+iFcLtOIcmoK9JcbHbiM+1
         HmwxhEp/2drM6gfmyFaE9c2yY1JHhin3CQ/+nLBt/jazLbRsm06Z95OQrnHuTLQc6tCL
         8OTziVe4xSrYKW3sGoqjXFNLdR8QRpBFRagFwu9On6KrH7tFkX2Tf/w37qmxUYj94myr
         soDzjsx6njOuPfuPtpvlQir0evVpEZCDCvS9Acenwvg37aL5zs8Smmvj2dEaQY1gsCyf
         LlgA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQZwr7RyMZXjQFUhRp7w8gmlLTWmeS/BIJ8q8npDl2F4c+emOU0KhTLu15udKSmk2qr2/UssBBRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweyQn3BHbDhEs/hKknkPpBZUe6pdgLW9wtTgw6hoa3QthbQt5P
	PQfv/BsSMOZxKpC1XOfTjGLEUij0U3LEsDohFz0WE4zN2XCpPKP/5El8R62Saz3/axZJbYb/o/a
	6RJWPc8AEkZ1LggolG2fTQZNYnLnzx0I6ww3YHEz2xhs7YLncaoAG46nEstE=
X-Gm-Gg: ASbGncu5FKTJnVvGujj3zTRgGN9kggycs3ByI/YbUmqRDzRXTe3q9i/E4v2C1mlFtfb
	P2zJfeIgz2dCQZpkP7aQUADMLWb/FqRm/YpxqjZLz38YXPje8sBmN/EpLbhLlG6eyvqoyJMgLBI
	Q7NbstbJIzOWLxAAxUjrsc1X60c1gBtQoeyM7sXJHN6U6Px3mJYjK6+GENeTuV5/exzCbUgQm3F
	1XI2ZWjw3K7azVOrCbhHjEldsfXz7c0z8okkJrWaZAjU+LepCDlR9w3FS+bj3XV03oWALDgF6v4
	Moz3qXcBixjUmCgQ2n1BWNHxBx6h11w=
X-Received: by 2002:a05:6214:224d:b0:6d8:7d84:a4fe with SMTP id 6a1803df08f44-6d8b740269bmr66744206d6.11.1733417935130;
        Thu, 05 Dec 2024 08:58:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHONcwWmMF297h6ReXiuQIfs1VJfMAMwnr4Li/G53W2Qo/RcNGYjv5W4a29cWUw0S2dbXt6Pw==
X-Received: by 2002:a05:6214:224d:b0:6d8:7d84:a4fe with SMTP id 6a1803df08f44-6d8b740269bmr66743966d6.11.1733417934782;
        Thu, 05 Dec 2024 08:58:54 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e0389sm115040066b.174.2024.12.05.08.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:58:54 -0800 (PST)
Message-ID: <724bf111-ae58-4986-aacc-3db3230a7a36@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq5332: Enable PCIe phys and
 controllers
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc: Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-7-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204113329.3195627-7-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: c_nYQ8Vnw5F8m9CNOXJ0T0SHI9mYhdf7
X-Proofpoint-ORIG-GUID: c_nYQ8Vnw5F8m9CNOXJ0T0SHI9mYhdf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=703 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050124

On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:

Subject:

arm64: dts: qcom: ipq5332-rdp441: xyz abc

Konrad


