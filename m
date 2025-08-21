Return-Path: <linux-pci+bounces-34446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB76B2F4B7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A45615ED
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCF82E040E;
	Thu, 21 Aug 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EeUCq43k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9D2DBF78
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770236; cv=none; b=ADiW2HEen5V18SBFQxUJziIbXyHhC9deOQsOmxkdc5gzIcf5nJDyYaJarX1r3xAeX5KGL0GQrjZ8o5qv3Tv7tQvAFwMgJc41bbNcMSlROWr/0UNqXsmNH7YXztbhzKEjfConB8OPZ1r7sKmO/K3UAMt2kKkEanM7RJ0W24PN7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770236; c=relaxed/simple;
	bh=IOpmcn53PEqkS2CYk/u+AVkw5l37Cd/P5pjacTzQpXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXjg+tr+cyF8OqdtaNj58YDaovbeCRd+5fWNXzuItjdKBHmpRRW9u5p6OBqkT9nvfLl/emU6rvlvYKke5Tho3x9T4UJxGSY7LTb0hDFVnvhX6M2XBOPhsQ6g+1HMmDF2eSkhX+ODGWwIL14cnQwwGI/liDckOpncjZb2QivyN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EeUCq43k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b7Ik007012
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SVb9XlaHh7NAzDiLQrW+htsh
	4PsmGg/oSLr5rbvMx1c=; b=EeUCq43kFHXicsz1AxT5uF7u5O7rqZHJ3xxwAfDn
	dAoz5zy3dbXp0J6cgkRG4hr/iIR0La6XgV8F9I6IXxukzNVZPoptQT1yxaSETHhj
	h3v+w/wVHnn4dd4Xi8SHUi9E1buREiZZWRHzrelcaYEXInWbYpVguQJauIslnf5J
	3j3t1ay1quy42AoFzDT3urFsMCq8kd1sm+iPhcyTFyaqdJoX9N/TnLazKop4tQsn
	xay7YO2vRCMPZLjTsmiztnMjV4KwSC677fYCNusqkFV527BBGMVto7NCs0jreSuH
	3HsxigaDt2xtUxgyDezqw157YdLDSH2WDBXBuE4Eol8U8Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52950vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:57:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a92827a70so18540246d6.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 02:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770232; x=1756375032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVb9XlaHh7NAzDiLQrW+htsh4PsmGg/oSLr5rbvMx1c=;
        b=cEddRSGOYnsKlIwwZ6MZRtzHLZDT8yW3/AOJLMDpMMWBvlJMsg9anLjS1SSvgjNarz
         RLIxdi73Cp5bJPLArC12T4zEjgp6JyxiFn80VuEQHyJES7JkBpaO7QqrsrU42HLJzuqE
         JutEcm1yl/VCvAoOr086epbHyZD4qq8nHnoBHSVJ3ocQ7ihhUJJcRH5VK/PIDrbAaouP
         ip8+64xcKDAczfj436QH9K7rMTnERe8JbO9K+SScx0LoyXlFgrv7oEen8OXwTVow/vgn
         DA9ggYyqcYFtafSZaZGBz3O952hxdlUKC8bZXAfxfPz51TOUh3KJyH/+zmVaZRx+BiVz
         TIjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCdSHIJ9g9fo6vMsMYXwOgheoiJEucwnXr7LZhfleKL9Rq/IMNGCQn1/MmZ3THmM28AI8jly+vk9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbc+BV0g3ArqsC+MDGLeoYNOw64oKDyfEetggisQpf7TI+EI6O
	pG2GzuJYQcDIxnMqO2oeY8KhkY1pTNOHcl7DymBPG/Xldg9q9gav2SIHTxyvhddMjUsOheBCj4p
	7AhQtdBZ+yq29dG4uYwZqx+rijOk5t7SutlLBCrpV0F2XozIGVvRdOBRNOu5MaLc=
X-Gm-Gg: ASbGncvlk4Oq+km07ErCp7U/D7ItorGVyVNRIQhEc7zkjCHAxCsYIw3qXuXCiBHMqp/
	Qmp+Np9+1C15XWO8rHJPoZKtJlzYeDERdsZoVXtqyJBENkWCGctwCDqR8qvs54ub7d9o5RlphEk
	JWpGFSXtyCvDPI4BeUNgOpPjg1PtlYvCXmuqRK1PF5owJJ0t14Svevg9i5WihyYaojvGx90V9Iv
	fGyQE6enmUXvfuDDByAyyRxkKwE2dUuyscuq84HYDEhQGWy65joCKjt1XC2t4KZmoszpFXoGQdG
	cZoQVN6dHlM3+cu0JbrNXsDHpsIB0+E+puCB+lVzXYqlrc2LlFU3JhleIVUTYCnnmcZ1/Nye9N4
	yNisN9XqzIJYvyNOzpEuf/cFtYdRUDCUiUfCv+2pH1X99ctofgsuJ
X-Received: by 2002:ad4:5c4c:0:b0:707:56a4:5b56 with SMTP id 6a1803df08f44-70d88fd7384mr13862726d6.40.1755770232108;
        Thu, 21 Aug 2025 02:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqWaMiKK7y86qlSXKsjy23FxD9WLBPQ8WQUmWHwy0IkQdYYOWie51bXUGTqyoqGxLizYaDnQ==
X-Received: by 2002:ad4:5c4c:0:b0:707:56a4:5b56 with SMTP id 6a1803df08f44-70d88fd7384mr13862556d6.40.1755770231656;
        Thu, 21 Aug 2025 02:57:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef367728sm2973854e87.56.2025.08.21.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:57:10 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:57:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Message-ID: <bm3cp2vyw4rpllkwoxoxwrvsjxrtolcroqwx76bkpwmcdvx7ag@b6hvybyouq7m>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a6ed79 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=nE5-FXN1NE7ZT85CS-kA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: YUSOVyeQ_8ve1FkkuP5FUz38DCh-WiBS
X-Proofpoint-GUID: YUSOVyeQ_8ve1FkkuP5FUz38DCh-WiBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyQ61WA+bAPno
 jIqun4E81KkjgHVd2vJi6l6eC0v+ZAjJbgiaqiaOWgl3Rh6M5pDqYVycUzdmELrdmAfqxB0v95b
 JlIFW9VWp+Q8K07DPZuPEomlsVEbC9GG2X9WeMVUbEZpHYeCBb6o++qDS8RQPIei+uDSbF7SKnM
 fd4lsc/4VDR0oVGUEiBskeSfwCwihzTQfg5AZlQvkEuu6ry3qZXINA6t3q5x702JRBvYSClK56d
 Pt6SN4f8ocVkgTBaP1qwyX7ZWGh7MO19U7C9P1XCgBi+py06Vn6d/G8L5nGw2DxFC7ArZ8wC9Wg
 I6FWL5DASxCmygnm6Crte8ToSOplZnJeF69bMAqbgdTGNaJRqR5JVqG/M3qgiZxlkiknkU3vMr9
 ntBU9O7BzvQXy/A84iKty96HNHd/oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 02:44:31AM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> @@ -5114,6 +5143,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>  		.data = &qmp_v6_gen4x4_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,

Please keep the array sorted. LGTM otherwise.

>  	},
>  	{ },
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

