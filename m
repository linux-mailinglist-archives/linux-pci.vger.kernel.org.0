Return-Path: <linux-pci+bounces-20731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3073A288B1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EC0167316
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3922F174;
	Wed,  5 Feb 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lTZ/NSfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8722F163;
	Wed,  5 Feb 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752630; cv=none; b=dv1N615UPcP7G+HblRYQuxoS3JbPwLZlAI/ixz37zokjda1JEw85xxzAQw4O9TYeMzjmSslILew5sGpNnsVvYylYTvOyIjQinXYIBbA7fG7bz4srRdm1z+ctrMLheiAjHnwoxX8fegwnCFpwsrv+YNUTKkLtJFhKaujm1L9B6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752630; c=relaxed/simple;
	bh=GAaQoyH6dy87JYZUhbjPz6gyv2TYG+23a7uNbP8s9Ik=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRz9n18PUK1eTojHAIh3HIsvrHD89VFXrPtfH3awzhCIJcjAspN/pFpCuqr0SL4qjKWB3rB3VXaoxkBQyQi3uHo8euyJJ8mPJCQ0fXLr1Zi3MheEErTUi+gx6M/Ora1D8LS3gwa7LgvaUrLPoTwCvB8GoFPHAs4g9ptgIMDxnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lTZ/NSfY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5157Fqqd009879;
	Wed, 5 Feb 2025 10:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yV+6qkgECPgWR+utpQPN2P2B
	yvpRL9hXJCZEqEup5Oo=; b=lTZ/NSfYhOQuFdRwxhrSwxLFb7Y+cSUcv+tccBJt
	vZN+xZKwUOAOU2uoCE6n80d+SoWXVpCPXCRv4eJ16smyD8y4pDwqzByfd6i0jbUe
	UA3rWJr6OkVzdeg9ivJzF97Vj1mPWiUXggpGNMZFeFojdKQeWL+g+eURclrLzyRr
	wlGKdYkErD2VVbqYPidtvbEo6X3PUaz8b2AMYcgnideeokrbpus8d6u8otDpl4uV
	t3ZUS/EZqSzwoBtn6O3a71uGedqwhgteILb7vKkY9DoNSasqnmQ0dK03nJHAOum+
	62aVzeMFBpE6F258uvDWymMpOZjrAQ956RJEq0To5GqvNg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m3esgfwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:49:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515Ant15000760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 10:49:55 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 02:49:39 -0800
Date: Wed, 5 Feb 2025 16:19:46 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 6/7] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <Z6NCSo98YRgG666Q@hu-varada-blr.qualcomm.com>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
 <20250128062708.573662-7-quic_varada@quicinc.com>
 <cc1c34f0-0737-469d-a826-2df7f29f6cf3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc1c34f0-0737-469d-a826-2df7f29f6cf3@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LqkeP6FXi5Jc7zuveJvZcqUkz1DwPpMb
X-Proofpoint-ORIG-GUID: LqkeP6FXi5Jc7zuveJvZcqUkz1DwPpMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050086

On Mon, Feb 03, 2025 at 05:30:32PM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2025 07:27, Varadarajan Narayanan wrote:
> >
> > @@ -479,6 +519,230 @@ frame@b128000 {
> >  				status = "disabled";
> >  			};
> >  		};
> > +
> > +		pcie1: pcie@18000000 {
> > +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
> > +			reg = <0x00088000 0x3000>,
>
> So as Konrad pointed out now, this was never tested. It's not we who
> should run tests for you. It's you.

This was tested and it did not flag an error since it is having the order
specified in the bindings. qcom,pcie.yaml has 4 reg specifications. Two of
them have 'dbi' as the first register space and two of them have 'parf' as
the first register space. Looks like the constraints with 'dbi' as the
first entry will match with pcie@xxx and the ones with 'parf' won't match.

Since IPQ5332 follows the constraints specified for sdx55 which has 'parf'
as the first entry it is not able to match with pcie@xxx value.

The initial version that was posted has the first 'reg' entry matching with
pcie@xxx (please see [1]), since it used the ipq9574 reg constraints. Based
on the feedback received [2], had to add 'mhi' area also. Since adding
'mhi' to ipq9574 would result in duplication of the sdx55 reg constraints,
ipq5332 followed sdx55's constraints resulting in the reg entries getting
reordered and the first reg entry vs pcie@xxx mismatch happened.

To resolve this, shall I reorder the sdx55 reg bindings (and the affected
DTS arch/arm/boot/dts/qcom/qcom-sdx55.dtsi). Please let me know.

1 - https://lore.kernel.org/linux-arm-msm/20241204113329.3195627-6-quic_varada@quicinc.com/
2 - https://lore.kernel.org/linux-arm-msm/6fe09de4-c94c-495d-92a4-aa902d2519ef@oss.qualcomm.com/

> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.

I run the following tests before posting the patches and go through the
output to see if the nodes I added/changed have any errors or if other dtbs
have been impacted by my bindings changes.

	export ARCH=arm64
	export W=1
	export DT_CHECKER_FLAGS='-v -m'
	export DT_SCHEMA_FILES=qcom
	export CHECK_DTBS=y

	pip3 install dtschema --upgrade

	make -j 16 dt_binding_check

	make -j 16 dtbs_check

	$ pip show dtschema | grep Version
	Version: 2024.11

Please let me know if I should add anything else to ensure my setup is up
to speed.

Thanks
Varada

