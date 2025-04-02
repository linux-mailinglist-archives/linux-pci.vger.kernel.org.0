Return-Path: <linux-pci+bounces-25186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5222A79123
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA502188D322
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618921B9D8;
	Wed,  2 Apr 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nC0THpW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257223643E
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603767; cv=none; b=m7BccM76J2vBvUOgVjzhc/OAtlp1kkWEgtGj9joGHxBLUokpFSu75MJUiMBeulSneJitMSHy7SwnEwCRM0uBf7GgtedNNb67seaXrxwR+VVydjGyIYWGpiTIRS1rBUq791qiqDRASaA00x73QzXovDcASi3Qbvjs7+3kSbYqojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603767; c=relaxed/simple;
	bh=ZBtbiksapYhQuPRHkCFj9XCSDMzKTcXQGX7XPNMUCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knP/wGRjpvZQOIGKHODcz0+epI2Xa/0J6xO6rkBBNa1uAgZ+Aj0uGDJr4cSYcJce/bmarViJI0K1VW112Gkg1XIYZYPx4xK3IrIHI5rBcYvDi++plf5GZPyJ2Tw+LPPODf/5M7mAcQE/bjh9+lzqDiiygtXworxyDnKBTuHgzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nC0THpW1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532B7tZP001410
	for <linux-pci@vger.kernel.org>; Wed, 2 Apr 2025 14:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XvDkTPzUzc+MUFlUQ0cUCLKe
	htMRcvALbEgPYK8eAHE=; b=nC0THpW1BNK60WGhHw7MHNH01etuoISc2WlFJ2we
	gmleIBlDHnHfABhdYoi+2Dcu9k689V/rFIa2LuCktEEQtt8Ps5OIGAw5XfgRL7Kw
	/nQMM0S/GivXchUE6dh3bFsqj9ce/EcEBLWkQbQpBPYgW4r7WoOzzzAxkIv0MoqP
	hlyH3P8HEUQPNfqTMRVvAnGseO3rVSoJH3ilwn5SCeGdrefvC6wMQlDjNDzDEYYb
	mZyWDKWD0KPRfO8L1ED7SCX9UFNkHNtRFZD1fUJiCQNMholoyFfziTwMcM+sqY3H
	fIwFIpM1t5zamALBIiY3rotL5eYCiFJJ4AXSrL3rIWuUTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qm02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 14:22:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54e7922a1so1509874785a.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603758; x=1744208558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvDkTPzUzc+MUFlUQ0cUCLKehtMRcvALbEgPYK8eAHE=;
        b=ehQxovegXf0SZyqdE0VNxq1Ude9JSNwIOONbGdefi/ItdClRrmsFmhiWu2W92TywSw
         H254RWVZPkGQccFx50v1k28jpftiTpdiGTMug06mBU7qokEKM5wsehox3uEkgtxfkbN0
         p0RHFqIHRVd5ko3BJ5KEt5OHC1Nhd/0v39r2eTaW6gUXoI2Px7PVctzn6Dbqj4f7I/Am
         y/sBdY7aiWLkfNI2kr8bfZ863paS+6m6F7o5zTUN+44mxtzHJAWSHH0aotdL4MpPfQvM
         YV8YsGj+ZcbU9rFgfYL94ZyItRQRD7l5HyWpBgJ5rjnOcKpoq82k4yd/rH/Lsz16CzHC
         aVVg==
X-Forwarded-Encrypted: i=1; AJvYcCXWRSJ35+EbSkfM4mlRgIJHLqUjOVvwXNZU+aAWN2Uwkh1T2Ckx8bjqKaPpQjCE9orOpoxvYYdakO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSsdV0+ijqF5kIFksg48fgdttK+VbYQHZ0Mdlv5uBlgd2YkBV
	FOeGuvk/+xnOXAsLY90GJ0RJNbGVsB0o6Br3vvrsRilpM0cOhIJ3k/48TqWLbtzBUe2cB7LbMQ3
	6z4+nvl/s7i1lRH14a4RwRH7WdZt6Y8cx8nX/uNO5HI+GGgiKOmyimfRB1LQ=
X-Gm-Gg: ASbGncsBGgfdhAdmW+z9QBFjwXpRFnAuBzzLGYQtMVvbIuRr4z0qYPvsJE/WMr3bCC4
	HLaDVmwXTIrIeRseSPGgOisG0llvGmFtIlBzLNzCDTKH3n1EL1/BYNT1cmrwcawuMWWyuLRQrJJ
	QSnKp+1U4kBAfGXkq0AqvudboBvP7mwsHhT+QgRjdWv5eDh9jk+Dp/FXBGykvQOYBt/AVyRXauG
	72haleLFWw537DXUwKa3+fNedkNOgSLlJO1ZceOCxu2SvlrH1003WLRa3WDj5pRI2LvszoNnvwN
	wLc/fMOz0GmPjlH9gKDwF3rVOUwD0ExTtUvwuX9s6IXdRvuhkBeP/YRAPHYTd4ByH3UTFsAKvdl
	SKMs=
X-Received: by 2002:a05:620a:4106:b0:7c5:57b1:1fd1 with SMTP id af79cd13be357-7c69088f338mr2355763885a.47.1743603757786;
        Wed, 02 Apr 2025 07:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPoRHZRX1Q5/R8yYiX+DDgzB10Hi1NvWzDrIs6W+c5ZzX7/mjDrP1np54E+MI/I3ClFYT7QQ==
X-Received: by 2002:a05:620a:4106:b0:7c5:57b1:1fd1 with SMTP id af79cd13be357-7c69088f338mr2355760585a.47.1743603757474;
        Wed, 02 Apr 2025 07:22:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094bb230sm1628216e87.15.2025.04.02.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:22:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 17:22:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Set intx_capable in epc_features
Message-ID: <lqdw6jrusqv2w773ik73kgrkfghktzvfnq62qejagpbwtgpmyy@wfo4scb3xgtz>
References: <20250402091628.4041790-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402091628.4041790-2-cassel@kernel.org>
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ed482e cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mTN9ipMCngZs2EERi8MA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Ojd4bqiU3uOuFBFYjity7lFXzLhP0tR_
X-Proofpoint-GUID: Ojd4bqiU3uOuFBFYjity7lFXzLhP0tR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=894 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020091

On Wed, Apr 02, 2025 at 11:16:28AM +0200, Niklas Cassel wrote:
> While I do not have the technical reference manuals, the qcom-ep
> maintainer assures me that all compatibles support generating INTx IRQs.
> 
> Thus, set intx_capable to true in epc_features.
> 
> This will currently not have any effect, as PCITEST_IRQ_TYPE_AUTO will
> always prefer MSI over INTx when both are available, however, perhaps the
> supported irq_types in epc_features will be used for something else, e.g.
> failing a ioctl(PCITEST_SET_IRQTYPE) with PCITEST_IRQ_TYPE_INTX, on the
> host side, before ever configuring anything on the EP side. Thus, ensure
> that epc_features represents reality.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

