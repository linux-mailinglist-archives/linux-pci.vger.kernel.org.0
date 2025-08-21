Return-Path: <linux-pci+bounces-34447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96570B2F4BB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D901D5837D8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36492E2EF7;
	Thu, 21 Aug 2025 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEKIUoI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F362D47FD
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770254; cv=none; b=q5ZnfdAxvlMIDQXq23DKzygO3jZF5YuF88FrkF5Kn1eR+o06QtrmDEDxyrkAJwVdI5hLRwiAvxTKa8ELOqG+k76sf1fAwrSC7T13njcACR7ZUKbKbmE1MBxgeETclnlLmNmfwGImUa47hr6nOMlcVN/LwazeXAqUVHYVw3a1cT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770254; c=relaxed/simple;
	bh=vy2/4IDxVTP8B1054laffR6LkPGsxI0lLeNGiepTPwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA272mMQ6Th7wgjeGPK5UIWuCABPcmGWusSv1WptrYtptwJySTJFNIliosC6M3Kv5B+/urxjPPSxM8JeAS7wHkjcXCj3a54l1BLQmgie36sO9/TzJDBtBjQGmoQ3kBBfGP/Y7JH0cLysRtdAjMs5ToScp13AFFbFj5yIl1/IdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GEKIUoI0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b85d014720
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g7PwJmWud4LLm5PEBKc0rhlg
	wmfYyGE456fNQ+YMjxI=; b=GEKIUoI0KrJX3ctpuKhvi/fCWZUkiKZNzLnRXHmA
	RF790C7FnptHnL8LvovYOR9qsce3k5T+jFLaHV+KgJLVyh4FQpJQG3O8gB9htIMP
	EX8bHOnCEamW0p6jclZb4yg3W78A5fbTLf3zJlstXJeciAl7ahRKFxurfIxxgH0w
	F2Ql9/N7HtQSwqL8FcvTbcmXfh4G1XUYlWNI1Hsi+bVG1TdE1Eav6nrJoGAgpqME
	MbAK8asuZKKaeRtz18XTy5RR9LuggXf2OtanGCCI33iCaUOnFXXQQpr0KCTEaEpw
	d2CIXgTFqB7oCEcJ68F2aJQSBEHSNjqNCpVMUBqwF0m8bQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528vxqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:57:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a927f570eso17454266d6.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 02:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770250; x=1756375050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7PwJmWud4LLm5PEBKc0rhlgwmfYyGE456fNQ+YMjxI=;
        b=C0a8+jeLoWx4wq6TzePw8ItPNm4QFjTLCxx3G35HCUM2rHOwEdMvrDLNa53EXX7Bxo
         EQCjuDH7NmcFIOPscUcuUZDUYwevo0+YaKk0UhLW/OxCaptmoBr9H7SvpVUSfIN5MkBa
         s0fPps/63hGVTlP+On/qwHz6wd70vjW1oZ1+ks8AF29YZUxwKnJaQzxmGUrO/2o4wtmK
         fsZGcNUNqLIBEW6cSzS5gW0X+mWFTeZaOl9mgy8tJBNwxlDRxHTqPYuvFiwg0crMdIWG
         N+BRTCNOXItHPDn+31cekHRLgi86CeocMLkh3zTl7CMUxSRp5x5i4QQTmLFTKsxOeSk/
         +IoA==
X-Forwarded-Encrypted: i=1; AJvYcCWAKDIHGbnRS1rDuHH/It5Yhn+nbPyg+DlPGOPDGLjeVODSwSXO0TYBHGKlAQmsZQd0zSvJpYa9fN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySe5nis1ff2GI0c4gvE/i8KC0AOFYUnvCW99YV9Bsld/N1oZ4E
	NIKlyhvGfQ1YYWyF4bKKw7lToyxxxtHuBp+Icu4DgqqiDJfL/35n3njl1ZF5GR/7I9IY9ibhX/7
	uTBIeaNRk6LNS8azfqp4I8KRcjylmwGutt3FetjwBVlmUDPTHFIu8xWa6jMB/6LE=
X-Gm-Gg: ASbGncvH7LNMlsL9dmREfjv0rFIAn3+AZmwuec4nNjQeuRMgBuiw/E9983nJInNUg9F
	piSLXyN4qCYQuMTwiC7raUIl/JsbpjNXcLiVfWR21FxeWFGnqPLuWq0ZZnLhs9USGK9MxLfLR3j
	47imQ2mN7HWiVGKtwjARRw82yN4BnXheh+JFNwWMxCQr7t0cfY++8j87q+2qXH10VHdoWVUfG2+
	3ocBEqbV5zFxW4L6C/FxwF3b8C01XGs2/LjD9Ih8cPVZ4j+Yu2FgZW0QPwyxp76EuXaRJH4n+PL
	MaeyeMYTtsLDpxrtmywij6CQfAmWAqECd55o8odRE3JeCdGs7LcyjcUYMZ4amvz8KAEuCIgfq/R
	xicBKBTNA0VPKmHPxBy5geu+b71MjUmQnbvzyJV7+ynGI9OFwbgV/
X-Received: by 2002:a05:6214:c82:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-70d8904ec58mr14210386d6.51.1755770249852;
        Thu, 21 Aug 2025 02:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEFy709p/UfP4jm6FhUpBzgWM0SGkek8iTlc5fP6qfmNzP7NFOaAd+rkmJecj03zIVotF/A==
X-Received: by 2002:a05:6214:c82:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-70d8904ec58mr14210196d6.51.1755770249441;
        Thu, 21 Aug 2025 02:57:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41d325sm30632461fa.5.2025.08.21.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:57:28 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:57:25 +0300
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
Subject: Re: [PATCH v2 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Message-ID: <utakatkrxgfggm2fo3rtg3w3t43vibqaomnwfsp5wi6okuxv62@sdsx74667hgz>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-3-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-glymur_pcie5-v2-3-cd516784ef20@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a6ed8a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oUcIdNJcVQQXXIIADcgA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ToIRiKbmBSKdSb9Yl3qv-sHeYqIRGYma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX2v8ffCn1CrY1
 f/EzlsyGeKVspxh8qFvNdV7djBeF8NXaAi4hkkiGMKQD4pQy1qz5m7VjvsyAexzUd5eyn0eR9KL
 pmgmLIulJgRRT+bzf9xi6U7sOaS1qRYyAHtanmMQpF5NScD/Xg/eMNqFENyv+zY8UfoXJK9d1Tv
 YEOzZngrq9cMTvjO+tbioPW++G6xekDukfARQdA/rS2fbBQgjrsvgoEBP0Y62c3vx/fnMB7X91p
 p5Vc4/RNmtmSfiK/3rvt47KhRR2Fv4gPPRbDQO+xwIhzdmxnl9L8+osF0q6xdLDa5cydA94dCO3
 a8fvdXiI6vtXOGPFY6RdI9WYXc0jDKzmF3hW8/iR5NbRi2MdQ+6qbHOojJqXClEK6OlTym6h+ZR
 tf9sUx25cEDt9bbF0wRFWlUQxY+zrw==
X-Proofpoint-ORIG-GUID: ToIRiKbmBSKdSb9Yl3qv-sHeYqIRGYma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 02:44:30AM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
> g5x4. Add the new PCS offsets in a dedicated header file.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h | 13 +++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
>  2 files changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

