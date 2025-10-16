Return-Path: <linux-pci+bounces-38302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ACFBE1E68
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1955419A7A85
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188592E6CA9;
	Thu, 16 Oct 2025 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcehCPxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D92E2DD8
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599439; cv=none; b=PXoUS0oNy2sliZl6Sr5KJ7PgnM5//AjoSNBBmXmf4s4NbXoZ38HuppHru7IBTd7eqlZ8B5tzDOV1PDM90PCVn4cO7hW+6zbmXw5l8ABrVYhSsCBe5j8gRfZm5Df6C7t7YqXLNebPRP1vu3jzKyEX75USZfgPqPUg63oyjFKWZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599439; c=relaxed/simple;
	bh=u/pvDB6NNeRtZsdN9ugitJ4p2VYbjeZ0yG4iEuphbPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFp6Qrd4/J4il9Zi2A2tVfTCW4cb3f7iuOsMNT6LXfRg9S59TWG1aQMXfx3UxWx/Zs1VfCPMe+FwpxQksepyO6RreLNQM8CHlpbK06PMmlG2/lAn9zDUY0ItZk0pyzpyhWOfUx95t0SCZLEtA7y+K+NnrByzF0zyro9ZEKbLM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcehCPxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJaY2l002578
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 07:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HNGoDb+vaeJYhaVScXJVKuKu
	/Vv4DWy6iQO7I53RXv0=; b=lcehCPxdI3Y3P4qM+yY4UhPyGsxAao5Pp/qdcZiG
	OsMZzCfojghPy6kLmWAQuHukdmPKI5dtOZlrv9CZmxrYxZw3ADW99vJTtiqw7uce
	1W44E0QRpEFdP8Xt7Ni1hOZTPYs+S9bKymX1SOX8a53k2jHcTGXeFn1dCi9FprYG
	5PQ+D5Vpx+HOi4rGzhpdM8oY8w7+dIcLYDyv1McaTcRTL8QuOthKT0qUn2BD7onW
	r2z4no7LHMbWIvn6qzyAiEJjYnv6jEHkWsXoxwOoXwPdhlRP8AXRe5Dmy2mx6dKM
	FhCpW+uv2KioBWzyoLNYccyX7+jb30gQRDNOIx3WR+3p0A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8fe2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 07:23:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5529da7771so292429a12.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 00:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760599435; x=1761204235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNGoDb+vaeJYhaVScXJVKuKu/Vv4DWy6iQO7I53RXv0=;
        b=heU+et98rY1xWSqoPtaGkZ0OOU9ZHlPepTEgzgkavXQr9qa3fuPeyzrU3fRwUlQaG6
         o5koHrfbPN1Moi1HIMa1MewMi/Q068ULSSGmfq8giO+XYq0ZDOUBYjGkDRmosV53sQte
         sRQnBYIrNM6/q5J1HkpUeMqcLqc+o0X5f1W51acpuybqyzDFjBxHeQdifLDdd/r6W0s6
         DV2KEkmv7Cj4EzXSfd7DELEe3QKifIA/jVxtsWVOBAKeV4kIQL01w8LYarmkvCN71J3N
         0cYF1EU8x1zzClAYCBU/O3Xg8Js7Fv+x2mvy2bxqvnQgEFwEbk95DXiEZc4VPehpAmuz
         rniw==
X-Forwarded-Encrypted: i=1; AJvYcCUBlUIh9y5BjWr45TQQDKCY49ejYNiqDrpCooxrEDU6ovqWOlnYTtFr9z1hN+2RpQJ0bGU/yoo+v+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCe/DHenXicvsztMvmsC6IU+/NGMO3QNCEaBLiHhELhvX+AdN
	DvyJz/g9Aj46nQdhnBGXn00cASlKu1EKHMPvzEbxiCZwuNnZMYc0+bLpyahRZdNod2K0zo44mnl
	vs413NeParsjgiGflDeNmdRUsUdzMyhopcyzqjNbmtBJqO2s17MN0slEJhqLKLf0=
X-Gm-Gg: ASbGncvd5QxDeGfk6WM3Vrqr44x1pk7USDZDd54bFDiA8XTgp2jvqkS7edOYTO4yPJ7
	iFhhSzL9e2H5O2CkL3fiZUPlat5J1ftfr97XAvs4m6oDajIBxH/UDQ+qmALHbuwYBD4jhnCbLxS
	Ex9CSv70mGYWtb0clH6wYqFh1EpjN1Ak/Vi+c7m2Z4yyHn/sPi2PBaUIAOscHuRk58dtYe6Guz8
	m6GXSnkcmGkNCKvVnQu8ZyyRdZb5ToyO6Lfjb1oABAzVUV4ibmyoB5w/9qfo0j79wjiPQP2kLU5
	9VU0SCu/Y4kWYdwQMgAHNlDLmgm6CG/KOsL2LnDN0umOhYLEckJTDdUSXvHwxTZoGtWRmOlwEf1
	LH1WMGaqWtqLL7cEuysrRG1ywca6/E0qDQz1JX+0qmQFyuQ==
X-Received: by 2002:a05:6a20:9147:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-3348d0b695bmr6237504637.8.1760599434713;
        Thu, 16 Oct 2025 00:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrFPYz5L+0gDGKdDM3zwqmU9HSI97jDmKx2e+L9OE61zcHAbhnCy3ioFU+PCD6S5glLBXkw==
X-Received: by 2002:a05:6a20:9147:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-3348d0b695bmr6237464637.8.1760599434258;
        Thu, 16 Oct 2025 00:23:54 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb116basm21248313b3a.30.2025.10.16.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:23:53 -0700 (PDT)
Date: Thu, 16 Oct 2025 00:23:51 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <aPCdhz+kr/Hghol/@hu-qianyu-lv.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
 <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
 <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
 <aO797ZyWIrm0jx2y@hu-qianyu-lv.qualcomm.com>
 <w4kphey3icpiln2sd5ucmxgo7yp72twwtnloi5z7a3r3a63fri@fbebffeibb7p>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4kphey3icpiln2sd5ucmxgo7yp72twwtnloi5z7a3r3a63fri@fbebffeibb7p>
X-Proofpoint-GUID: ttm_2CSSrPUBcBgFAV0XZNA9YZXAs2DS
X-Proofpoint-ORIG-GUID: ttm_2CSSrPUBcBgFAV0XZNA9YZXAs2DS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX6j3qV2fUpVgM
 hIWryz2HVD5uFh+QNToklMpifpSkEWQTpdGNi8ObFr3wWnhGODeOiTmwJ/BZMr4jIU/eSjkX1IA
 tsARWWM7TJ3KMY0WEubUUlq1BR/VmEhlgJij09VLtTPQjCyHY/o1ayNg7ya2/pNPuuUAu7ByYfg
 dDYxGWbCYxi3B3mRb/ENpKM+Y3RWu73Qi6sHxqRHVu1X3PEa127Y+F7eQ733ZGabNNCtk/Y+mb/
 9TnNHkKd74SwvfySMvUH9XJ4Lg2s6Eo84OGY/URwHm8EkII35QLjty1/wYVUGWFOv9DV6Lxzf/Y
 ITXCuw1nLuer//77eDpAZgK9A5GjDGF/oapBWDNKyY55+x7fF/8ZAscYemkSgtmcKhM70wiXt3V
 ezGFhv5OsKKeR8N64ZLgg27l0btqcA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f09d8c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=AS9496Lnv1pbona6PS0A:9
 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On Wed, Oct 15, 2025 at 09:58:31AM +0300, Abel Vesa wrote:
> On 25-10-14 18:50:37, Qiang Yu wrote:
> > On Sun, Oct 12, 2025 at 05:01:45AM +0200, Krzysztof Kozlowski wrote:
> > > On 11/10/2025 14:15, Abel Vesa wrote:
> > > >>  
> > > >>  properties:
> > > >>    compatible:
> > > >> -    const: qcom,pcie-x1e80100
> > > >> +    oneOf:
> > > >> +      - const: qcom,pcie-x1e80100
> > > >> +      - items:
> > > >> +          - enum:
> > > >> +              - qcom,glymur-pcie
> > > >> +          - const: qcom,pcie-x1e80100
> > > >>  
> > > > 
> > > > The cnoc_sf_axi clock is not found on Glymur, at least according to this:
> > > > 
> > > > https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/
> > > > 
> > > > And dtbs_check reports the following:
> > > > 
> > > > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
> > > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > > > 
> > > > One more thing:
> > > > 
> > > > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
> > > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > > > 
> > > 
> > > So that's another Glymur patch which wasn't ever tested?
> > 
> > I tested all of these patch and also did dtb checks. That's how I found
> > cnoc_sf_axi clock is not required. There was a discussion about whether we
> > need to limit max speed to 16 GT and I limited it. I may forget to do dtb
> > checks again after changing it to 32 GT. Let me push another patch to fix
> > this.
> 
> Still, you need to add glymur specific clocks entry then, to fix the schema
> w.r.t cnoc_sf_axi not being needed.
>

I think the clock-names too short (cnoc_sf_axi not needed) issue has been
fixed by below change.
https://lore.kernel.org/all/20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com/

About the max-link-speed issue, we will remove max-link-speed = <5> in dts
as max-link-speed is used to limit speed but I'm not limiting it.

- Qiang Yu
> 
> Best regards,
> Abel

