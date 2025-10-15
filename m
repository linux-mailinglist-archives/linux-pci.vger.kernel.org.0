Return-Path: <linux-pci+bounces-38100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E3BDC0DD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE97423185
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 01:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3106303CBB;
	Wed, 15 Oct 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2E5z5A1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6E2FB985
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493043; cv=none; b=Q5PN43AVqb73CVDGuhHBeac8H7l8g43mxviNai4cEYQLATX9d+Zm7DxRTqtjEARL3LrwgRgc+qxdmdYoP5GgbRhANqz5xj83RDSsJkRPO0yviWEjcuJUy7/KrjPu5Yauwnsk+XCWMxNHrSpHODkGNntkS3Q89eSJYWzmjF4+ztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493043; c=relaxed/simple;
	bh=gNxKy/NFi3oZdFH8CChq1eOS0b44Am5j10TI+FhWK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuamEQupyf8aUhyGBQr2yz+T0voD5IOH3f0Lfx1rQad6gAq67NHH+eQbe1FyUG2id16CF1Cvwk613D6BzQ7iBZVpbHXpUqFS0VxHtPiY9JmGTcUYLb6+sPifTzis8zD1Q9fVEv1YPRSd00Y80JLZFKNVEmDpx/xsEHR9TgtVgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2E5z5A1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKRX0C001996
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 01:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UMEzdqx389JwWZAC4l4+WiOd
	cOP/xrB76GzYftznSis=; b=i2E5z5A1AJr+3WMXNSpHS5OQmEQ5TI8D3PaJb/aP
	VEJ3AWrvK6LmI7BmQzaTUQsU0TxenSwIb0iJN9Dfme8KZ2rfl+eKHG5JcF5abg9g
	5BN45OESyyfyeSaXKdeq7+aZcYfRjE31nh9lIuFWoAIbfvDF/09IfwAMJ75c/qON
	0fPJ80iUNH2ESJeEEo1UMEZkz9VX//KwjqGK8HxArEFmGWqxH7v0oeLsigrFWA7n
	TQyTlZWLcvjf/l9+ZIcgh7V4NacRhYN8NkxsLlJVFUTCKI6J0Nj5QAUB1W0NDhQa
	xhEAZVfwgkPVJxFceitZGFAR5DQiKeoXCn1cgP6lcQDJVg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0tn3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 01:50:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so26895647a91.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 18:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493040; x=1761097840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMEzdqx389JwWZAC4l4+WiOdcOP/xrB76GzYftznSis=;
        b=uQ6LxTA6dBm6zoOyX+VBKDgY/CBxRQRGCFyFWJh4KUu5x1A+U5PPZZvLLgXYTV0od0
         lgIMAlfUbP0tTpBjAB096Uvfrbsey9KvN/zFJvdrGESuztVzH8NK5fbOMO70wVoBpeV9
         AA6dSYmmM/cK/RVw04QetrBc2O8aEE0zaO9qkpiG9cMKBcz6Csw4O5ZQxwxEZVmlmcfp
         hvWfRVeDAGACUfeKaX1TvbLptJEk1M2RBuM+JuRcQTWKxy736fJ6+EGh9oPSu81roOx9
         4BnmVjhY0eGD/Ka4ZYK+g+TAfHTs6DxsrUR0VQPJcZLD9f2gKfvhqUTtH9VcMBm+kLCC
         Xviw==
X-Forwarded-Encrypted: i=1; AJvYcCVf/l1plKkH933SoAmIvpBRoVd/G4XmxhH9h2Q2Ti4mJ0wtfTBSCaYbJhY5nuty7zLcTYq4aJbjAtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXt3M752672TEQgxzR9BXflXsuQuITbk/d9dJQeiVIiDdqknAg
	MWhyHv6TpVuXCwYlpEbhjMrZrFIwqpz7e6Tb++S8d/byDa8CxcmldYh/IXFnUeT4p7GYJx+dLl+
	yuiVo1amG09AJ+f99QUdgQbcMed8Gg9/Ocrlt0jWv/98RrUos4uZbqJ+2BuDLrWk=
X-Gm-Gg: ASbGnctJuuSMYy75JuBK6QfdfyXsUkIIj6scemNSm5CwOsA91sfGx9k/mHwkdHeLGUN
	Od8iII8DnlLJfkreiJFXzzfKJsV5O0RVeMKP6c9AB8SfPHs9ndm6xv1ozOwgBkrdItV9JXvyEeN
	GsRdpltqUUDFoZAZrnXm/djSsybB3q/Jlg8+MKYK9ZTuqjfozTcqSVRM41qT4Yi9Jla/Wn0FJnv
	BI44Ko3cQmcpFJtrR66C1D9UTf/VrJrWHjMOrUJ+lPLQnTtsNUlBtJ7u6fzIwRFisjhK6Uu63LA
	LEbO6Y83/2aM6fZ3JekozWjCuqNMlyroTIMy1dsFW+kJzZpkVxPZsVqepVzo16CtTjRM4irg+Rs
	ge/ex1HBNkUE=
X-Received: by 2002:a17:90b:3911:b0:32e:7512:b680 with SMTP id 98e67ed59e1d1-33b51106b22mr34953988a91.1.1760493040361;
        Tue, 14 Oct 2025 18:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnWtUi1/KGA/NsDwkjYP6WaNDZmXwB3TkYReHzrYgQhIYsKu3zKwyltFcVs6Z4M1leDOIagg==
X-Received: by 2002:a17:90b:3911:b0:32e:7512:b680 with SMTP id 98e67ed59e1d1-33b51106b22mr34953966a91.1.1760493039927;
        Tue, 14 Oct 2025 18:50:39 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787a0d1sm317573a91.19.2025.10.14.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:50:39 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:50:37 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
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
Message-ID: <aO797ZyWIrm0jx2y@hu-qianyu-lv.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
 <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
 <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0n3ujnXaoE1K
 f+xrdgz4qr3XhAjN/M16Sas7MGjY2cEoaZgxZkvWJzoRIau40MlYIr3DjDmtayixEyrWKlRkML3
 GsIZGRHUYoqpxn+tB6T3bvQ+kJn19ehOPFTzbBJB5DuoAgpLCHSE7h4aJLB2NamDh48qoZpcrte
 8vdYSSeLHATN9iv9iN2rJ49Y0EsrqbUg2R9RuLzeR+/hgjVgq/Dri0eEwywE7k2cqJmQhyXp6xB
 ogyP+9JT18Rw2Iaf1VL0t3ml0wTov/RLC52X+Qn8rOJtJw2TF3ef1pXX9HxZn40ZMCwvTZVleCT
 9jmZB3Im74VWtwF8Ts5WlED2BaVlE3dEsCIBcDR/Q==
X-Proofpoint-GUID: Zlxhcgj1pH_QTxyxOGBurSkPFV18b9-s
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68eefdf1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=DgPuKSVeHQMGQ7iqIbYA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Zlxhcgj1pH_QTxyxOGBurSkPFV18b9-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Sun, Oct 12, 2025 at 05:01:45AM +0200, Krzysztof Kozlowski wrote:
> On 11/10/2025 14:15, Abel Vesa wrote:
> >>  
> >>  properties:
> >>    compatible:
> >> -    const: qcom,pcie-x1e80100
> >> +    oneOf:
> >> +      - const: qcom,pcie-x1e80100
> >> +      - items:
> >> +          - enum:
> >> +              - qcom,glymur-pcie
> >> +          - const: qcom,pcie-x1e80100
> >>  
> > 
> > The cnoc_sf_axi clock is not found on Glymur, at least according to this:
> > 
> > https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/
> > 
> > And dtbs_check reports the following:
> > 
> > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > 
> > One more thing:
> > 
> > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > 
> 
> So that's another Glymur patch which wasn't ever tested?

I tested all of these patch and also did dtb checks. That's how I found
cnoc_sf_axi clock is not required. There was a discussion about whether we
need to limit max speed to 16 GT and I limited it. I may forget to do dtb
checks again after changing it to 32 GT. Let me push another patch to fix
this.

- Qiang Yu
> 
> Best regards,
> Krzysztof

