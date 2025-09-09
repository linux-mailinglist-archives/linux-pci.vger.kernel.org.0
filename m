Return-Path: <linux-pci+bounces-35724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A25B4A1CD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 08:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EB41BC3406
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3E2D8791;
	Tue,  9 Sep 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQyu08Eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0C2DE715
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398243; cv=none; b=ms5ofmLyRAEdPESAQ7zVDJAQ3bkVh4Vg3VGzprELUaZj+gMr72BGaawyz2ZtwbabP0C9wjJbPOFcoxHXnoV8HIcmDR+t3x5BnigyyfeqvvjbYsDxgJCE2zW7WFAjPeg8HvktfVqDHQdEoj6fz/WPUjS+E12nuuaWk61Ibo3hUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398243; c=relaxed/simple;
	bh=rVHuikTiUm+yYiuh5ynrRZAPChfwAhV3DMHGrmyb3vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbUIbNctRfMXHdZKB/Rjecus+Qqe4w4npslwU54AZf81H/xa8iKAqDSUEM6QSNXfuwB4jOcm+5rK6F9tFVf/sWdzyjk89ytr4mVsTNcVvEPT8j1zsMrVDY/I+dK6VdoE3SeP4NPqLrQhEcPcU5LvWDCx4U3J5yrgYKtsEVSJMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQyu08Eg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5895aOdS022902
	for <linux-pci@vger.kernel.org>; Tue, 9 Sep 2025 06:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	10/u9q+Ectl5aZ4oToFDw7ffJZNCBBFAUzBbsaG295M=; b=MQyu08Eg7cEJVEmU
	I1wgOJUpg1xSzLHrhw8119YJdVWxQLVtr4k0wK7LN4XUBw0CJu0YGvh4FcJ5nVNV
	YvVRls4WyFEOWUaNTPru4iC3vj1Cyif45YvXh8DYL+CPbo0YmrTMQVbdhOKvFzOF
	h2Ndg8hRMbTD+UBUg1sEBbdBxav6X6eQrcj98gQAwXnTAlimoWt5MJ4G+0ZUSIsP
	bpbMx3P2VjTKSumFq6wxM0VoDioZpLhfwGIh6mfwf0TpltpK1EF8EMpFkdWVYADF
	3zqhrqkXlaYpO5092DDopTnh47gLjC2yWrIpKV8Ryh6Iv5+ho/ZxOeAGNtw+QM9C
	3/gIoA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kxyrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Sep 2025 06:10:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32bc286bc1eso7191010a91.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 23:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398239; x=1758003039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10/u9q+Ectl5aZ4oToFDw7ffJZNCBBFAUzBbsaG295M=;
        b=h8chcJnD5q6i3wINB+XgtqnBSG5dyDBhhIL7eYjkMaGLtl0hwqvASCwKHPUwftEuVC
         sdChv3n+nO/TUE+q8nUxUZv0Bko7ZdZ6NM/gXoAAAiVO2OCVJ255Tqe4yOF9qu9Dlr+q
         nKBAPk6FmMTa1WqFG9QDsX1QOyxf28rrLi7V8HkKppR0E40wxPnPtmxIqwX5fBfMuR9C
         iejKZNGf5UqS1kNKmdPUL1kd8QuT/sg4ZdHzJD4p7n4yFf7bwHCxu4ZMo09/oBMVvhy7
         jyjkaRP+AljUbbbp7vN3sHQxs0S4+CRlzjSd/pIpoIRsQPEHapbQKNos0z4f9DoJBlxx
         F7wA==
X-Forwarded-Encrypted: i=1; AJvYcCUK3lYZpWnUusy8H2Otdqf2oYRYQ95mH1a/4ihHBThd/feMBp+WRVVJob73R9goSgXAI387JB8vNeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqyh0NDEdJ5vVtw9O2pEtMQTZMxqC9NQLEYpuhsK0r1TP3Wi1
	iYO5HQAxwlycaKm4O1acVs5+bLG6W4a5AOQ1SNJIf8krE/8eP2siIIuRaq/c3yj7hQs1m54wcQa
	BnP0nfIW1iMI4VFnuNkoAdMSgwM6rmCBg4Xu9j4mGtUOgn6HdwlgE5XeiQD9q7gY=
X-Gm-Gg: ASbGncvTM4XVr+4K+/gsMUqbS2v62FAunle1fkxRWwcTIGC1DH/F5T0GXtyz468/U4b
	T+uTgAmWjE0/B4kNWCKAonA90Q/2i24nWjd3WfAoiqnuPLo2aDYw3DLeaiDB075EvewK+mjF5Mw
	S6fMW29Z6SXzewf2N/kQjvMOilF9uFhoGM3SE92smQ0epdR3vukHo560id80KVYwbnmju9NBi7a
	RV6FG1MWRBRh458tCwpRKxc7RRZrJR8CI1sMd/uPe23+cx2tddTBMCg8AG2FXUizVpbSGJuec2O
	lIUVuKmVXKiXzxjC0s2b1nHoe6wPn55AzTC2eWIJDLYLOGUgVnuOjp4jF1YDdMg27nNOkXBkLOJ
	iWDSJdNlX176Mf/IdKOmUtPk4zHlk6g==
X-Received: by 2002:a17:90b:2b48:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-32d43f4383dmr12807305a91.9.1757398238851;
        Mon, 08 Sep 2025 23:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/3YW/AGyw1pOiBdMzWKnU27fUqMCjMtdcgsRqWOBX438S0Hzgd28bb+NRvv3OT8HTB4tgzw==
X-Received: by 2002:a17:90b:2b48:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-32d43f4383dmr12807249a91.9.1757398238249;
        Mon, 08 Sep 2025 23:10:38 -0700 (PDT)
Received: from [10.249.96.170] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f9cfdsm853480b3a.101.2025.09.08.23.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 23:10:37 -0700 (PDT)
Message-ID: <e514dac2-a732-45e8-a80d-a7a1b889f593@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 14:10:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] PCI: qcom: Add support for Glymur PCIe Gen5x4
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
        qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXw1zLxAPuiVXs
 ec9bWf0pqviTQwGhYhKpt5k6ou0GxcN30hP4QoKUwZfdD9txPskg+zf+X3MFK1JVubDaNcEOp8v
 l5q580ftZAcTf1DsaC7zq8yU2tkr98SN3nBUDpNxhl2MsXLJLbhOkq8Xy1N0c2I9QoQmElJ6ydi
 QfxdC2YQhO2WEBpOGVl8CFZBChXMTKs4ZLruL1DCRrH/sMvPWY9435BQs8d4wi+Bo0cD68ffQjF
 Nmf7JrNsLt70H0UvzqgGbuw+XnozATkORNJBompvlYzCr27SQlCOZpOR2RbwoI8n27I+pOlaGYD
 m7lzpzgnRWT3OldCavzOwMigX5pCv+XDRAJP86myPTz/OD49JlvCEz+H0TVBy9pwWB/VeeMJZzW
 89S8ItNS
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bfc4df cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nBUzdE8Pax3goPOuR84A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: zgkT7-05B8tgJwYuI_YXXgbdMxytTCDO
X-Proofpoint-ORIG-GUID: zgkT7-05B8tgJwYuI_YXXgbdMxytTCDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 9/4/2025 2:22 PM, Wenbin Yao wrote:
> Glymur is the next generation compute SoC of Qualcomm. This patch series
> aims to add support for the fifth PCIe instance on it. The fifth PCIe
> instance on Glymur has a Gen5 4-lane PHY. Patch [1/4] documents PHY as a
> separate compatible and Patch [2/4] documents controller as a separate
> compatible. Patch [3/4] describles the new PCS offsets in a dedicated
> header file. Patch [4/4] adds configuration and compatible for PHY.
>
> The device tree changes and whatever driver patches that are not part of
> this patch series will be posted separately after official announcement of
> the SOC.
>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
> Changes in v4:
> - Rebase Patch[1/4] onto next branch of linux-phy.
> - Rebase Patch[4/4] onto next branch of linux-phy.
> - Link to v3: https://lore.kernel.org/r/20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com
>
> Changes in v3:
> - Keep qmp_pcie_of_match_table array sorted.
> - Drop qref supply for PCIe Gen5x4 PHY.
> - Link to v2: https://lore.kernel.org/r/20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com
>
> Changes in v2:
> - Add offsets of PLL and TXRXZ register blocks for v8.50 PHY in Patch[4/4].
> - Link to v1: https://lore.kernel.org/r/20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com
>
> ---
> Prudhvi Yarlagadda (4):
>        dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe PHY
>        dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
>        phy: qcom-qmp: pcs: Add v8.50 register offsets
>        phy: qcom: qmp-pcie: Add support for Glymur PCIe Gen5x4 PHY
>
>   .../bindings/pci/qcom,pcie-x1e80100.yaml           |  7 ++++-
>   .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  3 ++
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 32 ++++++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h      | 13 +++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 ++
>   5 files changed, 56 insertions(+), 1 deletion(-)
> ---
> base-commit: 356590cd61cf89e2420d5628e35b6e73c6b6a770
> change-id: 20250902-glymur_pcie5-bec675b7bdba
>
> Best regards,

Hello, do you have any futher comments?

-- 
With best wishes
Wenbin


