Return-Path: <linux-pci+bounces-18498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D969C9F2F23
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 12:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCEF7A0294
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09A204563;
	Mon, 16 Dec 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="deP/Zqj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FB4C7C;
	Mon, 16 Dec 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348451; cv=none; b=Hy0Zi4iu0ZOSC2yW7fOvGTFfzkseKPA0eJc1bStFSiKYGOyLkQZADu/YLh3U67A2GtoNeZP9dAgF8rj4VCmiRdY6UmjTpYP9q+RaHVaLetKcWVQz9NMFRZLAFGTDnf7wvW2EwVZ1CFhXtwapmSySvB1uroGgUyls9YGnFPBpRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348451; c=relaxed/simple;
	bh=yS0zVlxHlLTD8tI0J1H03O10KE6qBhEOdmvDHwX9Rfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4Ec879E81j75yJfA/uSia60MLqXDjglwMufzOxl/9MvzcDCp34pzzgdHgMrMzjXPVQ5ZYGCz4JK6tlD3NThhkP2h13k38RbWaSfMOOS81oqMtWp/wOuWBEzfPoxNjUvvtBWruPVWVzOeISMOxjX98moPY4mXdjJBK2rAgiZMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=deP/Zqj7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8URqh022389;
	Mon, 16 Dec 2024 11:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/hdgHoRUHpcpPGI4AsqT8ARw
	fAjor4xIfdr+yncp2dw=; b=deP/Zqj7zEmYwapc7pGT9Re9svKv6xIE26WbBeEE
	SEAEDQT9wmkfew65YQce6hSbe6OKeAfaCR5TLZx9bNPZFdjXIlQ3cnBGnW5FZaUi
	7n+DlYzoDg4C575Ppk/d7X0UBsTODWb8HP4Nz9CzmSEuirF6qRvbvZl9NoMfiYwG
	y/2KEpIEG9e6c731asjm0FkOAy0mrrrwwo3YNsGbEMJMMDRSC0Y7/ylIRNpCbQaJ
	H2rI+wpJwvmW0xVZBNSL9LCHejjJUEs1w+KdkESVJgDf16jPsriZNTokfRcsY+tz
	CQoH5qCFkWxpbMUTblTv+Wc1P82EHjkV9FQhKYLo/LHalQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jgrr8fdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 11:27:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BGBRG9D005554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 11:27:16 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 03:27:09 -0800
Date: Mon, 16 Dec 2024 16:57:06 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        "Praveenkumar I" <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq5332: Enable PCIe phys and
 controllers
Message-ID: <Z2AOimZhQWrU+1jy@hu-varada-blr.qualcomm.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-7-quic_varada@quicinc.com>
 <8a8cdb54-93b9-4093-8e85-f3d698d66e22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a8cdb54-93b9-4093-8e85-f3d698d66e22@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZM-DAk2_nqbMaDvi25VcnfaS-Yg7SVxe
X-Proofpoint-GUID: ZM-DAk2_nqbMaDvi25VcnfaS-Yg7SVxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0
 mlxlogscore=945 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160096

On Thu, Dec 05, 2024 at 05:58:19PM +0100, Konrad Dybcio wrote:
> On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Enable the PCIe controller and PHY nodes for RDP 441.
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 74 +++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> > index 846413817e9a..83eca8435cff 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> > +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> > @@ -62,4 +62,78 @@ data-pins {
> >  			bias-pull-up;
> >  		};
> >  	};
> > +
> > +	pcie0_default: pcie0-default-state {
> > +		clkreq-n-pins {
> > +			pins = "gpio37";
> > +			function = "pcie0_clk";
> > +			drive-strength = <8>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		perst-n-pins {
> > +			pins = "gpio38";
> > +			function = "gpio";
> > +			drive-strength = <8>;
> > +			bias-pull-up;
> > +			output-low;
> > +		};
> > +
> > +		wake-n-pins {
> > +			pins = "gpio39";
> > +			function = "pcie0_wake";
> > +			drive-strength = <8>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> > +	pcie1_default: pcie1-default-state {
> > +		clkreq-n-pins {
> > +			pins = "gpio46";
> > +			function = "pcie1_clk";
> > +			drive-strength = <8>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		perst-n-pins {
> > +			pins = "gpio47";
> > +			function = "gpio";
> > +			drive-strength = <8>;
> > +			bias-pull-up;
> > +			output-low;
> > +		};
> > +
> > +		wake-n-pins {
> > +			pins = "gpio48";
> > +			function = "pcie1_wake";
> > +			drive-strength = <8>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +};
> > +
> > +&pcie0_phy {
> > +	status = "okay";
> > +};
>
> 'p' < 't', please put this before &tlmm
>
> Also, would this be something to put into rdp-common?
>
> Do we still use all of these variants?
>
> $ ls arch/arm64/boot/dts/qcom/ipq5332-rdp*.dts
>   arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>   arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
>   arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
>   arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts

Yes.

Will fix the comments (here and other patches) and post a new version.

Thanks
Varada

