Return-Path: <linux-pci+bounces-38279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8D5BE0C9A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 23:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF3540B4D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3322F90C4;
	Wed, 15 Oct 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILikasog"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE02DC772
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563082; cv=none; b=Uo2hgQyYR928EjG7GCmH0HAt79fc8tkfRRFHdY3QCT0bL5rzD/mUtgMHTJi+PywAhTS10tpvmEBsYhbREQYIN6HOOVHrx4+6x1W1LM9cpEo86pggrlwazw5YFyJUSfUdAsi6Pk/8qi6YCWeRYda8kdhsKWa5YG5O4F77kialtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563082; c=relaxed/simple;
	bh=zk0BBT4Hk+RcSV6kfked05wBSaFZl99P+G64EyCQFE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qfo8ZrmSYNteE1+U3QuM0L7nW8i4bmXj8z+gNkkbqGA4alhu9+nRr+0usSZOGkjx/loT4OeH9Zy89Q3uPO2mOtQW4zXo/aoDHQfjMjbRv4Eokjs60lG5jXb2nR5x/bw2V/PRZDKOvF9NGELthzQpwHXBPk8G4RYLoQlRwZ9YIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILikasog; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIFNwG003404
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 21:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VJeGrgf9qBiX+zK6vs7ZHMmh
	QNY8bpXGFobNX4Fu/fY=; b=ILikasoguN8vUw9dY0Of4A5sKqiegwg4lgOnqIHC
	92cSed539XnnkW/n8gS+c0nlz5XMj32aN14MprGKJYOCq5H9foyUGa3FyQ9JtxHd
	/HjrIr1rlXkJgbIPmZB2iBYhsYZTqNjc1usYb363E+IJP1CPG1Ug8XQgs3/KnEAo
	kWhCtMt4jqZFEdIhyrC3F9WASSsDmKDtP08T8zcEIGD2k84iHHY0tkyHDFm1ZIvt
	xlJaa4Q5d97EguT4RpVki88wEOwnAId50KFjeeig7R0b49Xcb4CPK3ccUkhE3UG4
	CRKtgU1eYgCXdgQp0OY+kSvvOfWNXh2JE+zXHUswp1d6Kg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8mjtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 21:17:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88e2656b196so9644885a.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 14:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563077; x=1761167877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJeGrgf9qBiX+zK6vs7ZHMmhQNY8bpXGFobNX4Fu/fY=;
        b=b0Zmc+ydtmdiMBlOE/+KNtAilbFnty9MbSU+P9xeo9TSw19Y116NhSpWUhpNQRkg4Y
         piq3jpdAcaMclqbjvtql85inIM0M96XqHuDQHtn1aKsXedeCuH7jaJk244OKgY2dXDiA
         6yQEHTjEtttlOeI4hkHeTMKDOC3IfRpprP6cBQ/lwBukiabX4Cqt1ZQ55IxnhZ9Iuzeb
         Ni+ItZNuCOCJkDd2KAmPbYNMVaylwgcU+SQXwj/XyvbCzGxVVx0IcFbYCyyT4NW/f6EE
         Js6fLl4z4knf+STxd3+VIyvXV/yK0TyYvnYw3FbDKFt3/UgKE7tTJKdKEJec0HnwLKC/
         U2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYBqkEXJ5Nfr2rgrczq5om9pvpT8TLYC+QaKx4Wei84Nlu1/h0zCMwbVlhFlZ5zoYx8gLIYmmuZes=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1V8UY0CAdjzRucS8uv5jfvhi5Q5RCzD6sy92mMZ99Vkx1RgZ
	S/NeLcqjFx/wrsjAn87CJqM9OC5drPJSY0bAxAdHAGCqdJcLIaIdJYr5f2x1z9pDiW535Cp/Rj5
	119xegVUSYzp+Ylj+Qkaa8JMJv8CbytUjfPw8pLyNES5va2aW2pb/LIJzzZsgGZc=
X-Gm-Gg: ASbGncs4w3Ty/DFw2YkVyfvulcFmdyo14BBmyp+3+huJSp6JAOXtprnTA1Dd29Bd6rd
	k8KH+v40L4OBZuQB9Sp5UGwOYbOE3KVbiMeaUG7FOmlWaro3MtJ25iwOrokg/HGvZjRaZ/j7kZ2
	PUFFGovejBddETZiqaVDC0wmUezy9OT5J62zAR6TmjG9fOB0/HoZH9o9fyjB2f5dbSUEM6+ern9
	FovBlYEXOmKkptBw2eKIGkESMnfygSLyFH5PuBmCmQTDmrIEp6DmIAFQ4aLRtyYF542R6vBHWC4
	wsnIhgZpvzBi/5XgKeP9jL5Onxg4ca1ajz66L6PMFp5nerkvmGgN74xQpHwskxSYDbf6fBSz3MD
	4Ms2nVFlPT1HLMssqtLyAOMgg+46Id67cHuVi2hz/Me6+mNMoNun3QLqyPrDYQnFIW/JkFoyFTE
	CF8vSsg7UBWxs=
X-Received: by 2002:a05:622a:4ce:b0:4b9:d7c2:756a with SMTP id d75a77b69052e-4e6ead709e5mr430447311cf.77.1760563077204;
        Wed, 15 Oct 2025 14:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUJjpWuy2SQ3uK986PVDHVWiBrMZNqixssrAxbnP8C6oKcxQyRgYATBifnIDH6x3LpocicA==
X-Received: by 2002:a05:622a:4ce:b0:4b9:d7c2:756a with SMTP id d75a77b69052e-4e6ead709e5mr430446851cf.77.1760563076717;
        Wed, 15 Oct 2025 14:17:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea3ab05sm50829681fa.44.2025.10.15.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:17:56 -0700 (PDT)
Date: Thu, 16 Oct 2025 00:17:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/6] phy: qcom-qmp: pcs-pcie: Add v8 register offsets
Message-ID: <3frncuf654d6wjvegmlwvljouk2xehsmouwjkf2zlgke3t27he@3uh5zyfyglxe>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-4-84fa7ea638a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-4-84fa7ea638a1@oss.qualcomm.com>
X-Proofpoint-GUID: 8-ni4GeQmF_CXH1FBR4i-AndrTs9dbJM
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f00f87 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=aHvCONSEC-igqZHWBgwA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfXzCnksIRa/Svm
 xeuQEgqz6tI2eXtH8Zn34LgVE49SdmA592jQ/WyPlkbvrUGZAUb5m+eSFUSkT7CIc1kD2PODvhB
 +YxwjDfPxZHEG1NPYWatY19gPFQOYGaZ5YCdxghS4tJ7tjAGltixfFhlgT3L5p7s8WcCyxuc4lX
 QnvypQUpa3/+TXrLnGhuOmw24RGdf/vsS8sPdCOda4igIu7eJaCs9tFrr1d8fFvCSB1klU49Kjv
 h8ulcSU/cHRj/Bjp19pDsZFas6r9K1+xM9RHCZ4mRWqSoO5DaPTgKL7D4UtJaobwUTR2BMOvpAq
 u2Q7o2rt6NIfn7P5Xv+b4KZFRXsiaR98BcqrpOkwgNMpsdI0kh5+89nJgmiU62fLsaNxtO5NWhD
 Z082eJsVvWHkqDN20kqeyTsOq4/o8Q==
X-Proofpoint-ORIG-GUID: 8-ni4GeQmF_CXH1FBR4i-AndrTs9dbJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

On Wed, Oct 15, 2025 at 03:27:34AM -0700, Qiang Yu wrote:
> Kaanapali SoC uses QMP phy with version v8 for PCIe Gen3 x2. Add the new
> PCS PCIE specific offsets in a dedicated header file.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

