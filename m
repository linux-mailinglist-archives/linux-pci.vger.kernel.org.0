Return-Path: <linux-pci+bounces-37770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD70BCA378
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7775C3E5D08
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE672226CF1;
	Thu,  9 Oct 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kXEPNCUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7C223DD6
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028167; cv=none; b=uxnr5oRq3qzsKwDJ9ERVje5gW+/WWGHuc+Y19eGIZtKxIeWIXj2oNvTLsTRo1S8NFx92lEPTHELEJoOrfMNnEoe5wLQ92DwMkUGjp4p1zhY5Y03cPMaWY2GW99xbuBATBYo0xIJ8fyhp1uokoDKjB9UeCXFO0Vs6EyDrYjPmrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028167; c=relaxed/simple;
	bh=jpEMqFlCEK47jrlh7cNwBVNuJFzpm9xEWzxYgXkTIbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diyDC3eazBzpCEhH2N9D1b8eLJXvGXjhLasbGDDLzwe5lB1hxJrFbMbXY10xEgHqpsCFgU6XctdTgaN2cfEtz/9wo2P+7dfMIW/D58FYEVa47q+JwKr7TmBRiumHsowTVJk9cpZirGOthIL7PGI560Rn3fwLeih3reog/Eu0phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kXEPNCUh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EKN03023267
	for <linux-pci@vger.kernel.org>; Thu, 9 Oct 2025 16:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=agrtrs+DJSL7nf5oW/g8lusy
	admL/3uHNzUwQtR+shY=; b=kXEPNCUh99s34FdTrDEhnVL9Tlwkm3qcVkRzxonM
	1CQSiLwiRHPHdRWWhnrticBXCH3/nagiptcADiqpHh6iQTAHdhrwZbSN38KIpoIV
	l5t3d0IYAKiR+1ivXhokKhIHVmETQC+KcpU04sP3goXxDeDmNqP778AloK71q7Wh
	TVFmK9nMIZWk58TSa5BpjhQauerSARH4TIJfAFZPRR534N8G8hg0qQbLJC9XLya8
	L5wE6cwr+wg1KutbOAEKUnhNkvAApZLHsTA8KSIKR+QOJOOMMiSDK3yZLrUT5TQ3
	KaIfk60KfxJRw2FPuHbKvacL0pK5JHtGV1xlXRk/8pzEyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m3nqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Oct 2025 16:42:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d6a82099cfso41664101cf.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Oct 2025 09:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028163; x=1760632963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agrtrs+DJSL7nf5oW/g8lusyadmL/3uHNzUwQtR+shY=;
        b=WOto+3/bp9ySw+mu/47wO5Urliod/yFaDVzybq8RcY3oXeMKafFTYzFXizKw8qJhh3
         G5DAOUEabpgURm7cb9X7bwaVFACxZV5qxQHupYrfQ2JZNZRP+CstP9uc3NHwKZ5y3+9u
         AWuiB+4UID9g/sHNgsuFP8FJTF0NS5Kex/NfHphV2dBBdo1ztn9Xr9mer6GtqIT2ZJqL
         pLYe6KTSPk9bFvoVUTs/UxpLE/YeIEDg75ok/oIZf+12Thzx9sTWRH+r0VBvBD7+oDDd
         vEaprC09L9K1vJMwOkpicq8mgexieKAUpuMOFUUxf56zxJUOyJoTZKl/hkveYzyCg372
         5/dw==
X-Forwarded-Encrypted: i=1; AJvYcCX7/wWaWuKS0OtQAKKpnrgUGKM3R4JB0Cc040cbhwsm0macKHR+AlI9+mzcqMQxPSGMnQCXaYqHFO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGSDiqyW58J7vKq6e1Fvk43DLTKPw12ZehaRl63Q2x9iIccIj
	LWwqivBOCXWoClX2irLIveLMsgL9vbZLaABU4VvQ1W73Qjf8dMGApKCev8DjKtCGIwCnpPhHxSH
	Lrdr3Z9Un1IEx+97uQyGnXjQzrtz47UdadxcNo43OXAVyZwYfdxJsOHr6sM7KNJA=
X-Gm-Gg: ASbGncvgtQDeY70UHyxwwCg5x8HSkXHxJ6bscWTLq4YBk++vQeHdZhmFpWF73rTUUHL
	/+fwoVTJg7Dc3mJY+yA7CFxzbiC+x9LD+CTCwy2GUpNmVDvtT1IgBt1Jcveinwj7JdeCSZpX+2N
	NVGbbm4XODtZKmm6F5vsQHwyf50gKadEnrK7Mx6c2SHfypNp1sklidhwHa0oqVQnjxNvsAkjnEQ
	H4zj2gPIiQ+wnb/balbIAtwztShGZEeTHYUcygwbk5xQsqgPQfx1oaJv3qt9IHn1djHm8paarLy
	G8czozFds92Ec6gIEHLzfohRuLmzk0KBv7g58ijVZ2XpHU4Jd1b8Lk6ahWghQw8U3RMmdkQGssj
	5rWre8rCxdevYSnFNiNskU1FkZHoYf3cagegPjwd+5V4CqYXKZj9YDgkznw==
X-Received: by 2002:a05:622a:1a94:b0:4d8:372b:e16a with SMTP id d75a77b69052e-4e6eacc5dd8mr122162401cf.4.1760028163255;
        Thu, 09 Oct 2025 09:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaQz67QvaR/gWsBxDITOOw9Xe6x4vHfjxb37JqA0HRLVHcGGuc5OS1bitAvcqNx2Bj+xJB/A==
X-Received: by 2002:a05:622a:1a94:b0:4d8:372b:e16a with SMTP id d75a77b69052e-4e6eacc5dd8mr122161931cf.4.1760028162757;
        Thu, 09 Oct 2025 09:42:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb2705sm1174139e87.105.2025.10.09.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:42:40 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:42:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Message-ID: <53wepdhpn3fgvq5fum7u6n75su77dligfjtnxkfdh4r723a7yf@6u43pwkwt4yw>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
 <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
 <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
 <qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3>
 <b5538a86-c166-4f20-9c3a-8170d3596660@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5538a86-c166-4f20-9c3a-8170d3596660@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzCT+IfUnIfrx
 p4cYQwTNkhMzWYzpMZ5U6L5Zb2i5cWo4cgusOOkGbZPb73LT1+hDyXiUfheW+9DQreQvFg/NeQ3
 oq8z1ZCsxkP4HNbSAzZ/0tLdEVbcvGNt0B/oFsVuHQtBws3DsLlEvLg4ArUwa6LoIqJCTauqaFx
 PCefpXjkZige/6c+dvwdzQQBsL9FT8O3ADvVDQyWdyWM/JXhuAL5iSY26sPRCFym7zx7Uo4yPIm
 jaV9vFiky5euHTf9xpsJXIK7RpccKePJAAyhpkJuzu1zhVXr7B60nqBQdRItjd2aL2N2n0GNGS5
 kOzfV7JgnkQjV9tbP5A4tAm3niWrAnZMeTj5YofDB2MGUiNJP4UizS6+IonAh/G0JJVgZ94O4Em
 VnuA7y8A/hBbwRst8F/VSeAjUPIh8w==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7e604 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AjAdDlCQjSUW_Sxw7NwA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: M3L9tvCN9hw1EcqdVtyE9bSg9NbxeaVO
X-Proofpoint-ORIG-GUID: M3L9tvCN9hw1EcqdVtyE9bSg9NbxeaVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 10:35:52AM +0200, Konrad Dybcio wrote:
> On 10/8/25 9:08 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 08, 2025 at 11:11:43AM +0200, Konrad Dybcio wrote:
> >> On 10/8/25 10:00 AM, Konrad Dybcio wrote:
> >>> On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
> >>>>
> >>>>
> >>>> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
> >>>>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> >>>>>> and x2 lane.
> >>>>>>
> >>>>>
> >>>>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
> >>>>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
> >>>>> is crashing during boot as PCIe is being probed.
> >>>>>
> >>>>> Is this a known problem? Is there any workaround/changes in flight that
> >>>>> I'm missing?
> >>>>>
> >>>> Hi Bjorn,
> >>>>
> >>>> we need this fix for the PCIe to work properly. Please try it once.
> >>>> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/
> >>>
> >>> This surely shouldn't cause/fix any issues, no?
> >>
> >> Apparently this is a real fix, because sm8750.dtsi defines the PCIe
> >> PHY under a port node, while the MTP DT assigns perst-gpios to the RC
> >> node, which the legacy binding ("everything under the RC node") parsing
> >> code can't cope with (please mention that in the commit message, Krishna)
> >>
> >> And I couldn't come up with a way to describe "either both are required
> >> if any is present under the RC node or none are allowed" in yaml
> > 
> > What about:
> > 
> > oneOf:
> >   - required:
> >      - foo
> >      - bar
> >   - properties:
> >      foo: false
> >      bar: false
> 
> Oh yeah, this works.. would you mind submitting a patch like this, with a

I'd prefer it it comes from somebody who is actually working on PCIe so
that the explanations are not ridiculous. Mani?

> 
> # These properties must either both be under the RC node or both under the port node
> 
> or so?
> 
> Konrad> 

-- 
With best wishes
Dmitry

