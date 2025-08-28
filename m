Return-Path: <linux-pci+bounces-35008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C4B39DB2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB431BA63B2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345D3101B2;
	Thu, 28 Aug 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7fRh+kC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3130E85C
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385317; cv=none; b=YZbKzPOZB/yvrJAzaETTjEa3aGtpeaZYF8yinAfOJhadDWDyow21J5ZoFqE+OEIcBGOwGPjoOoaBW+4IHtUbZaNuRI3RisaOdPkM6afYTHoJeTJ+0xt89I1UUz2AftxjCM/1WkmOManMlxZ5yIERna5lulE1MwO0Uc07hbJIlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385317; c=relaxed/simple;
	bh=eeV/gtq8KypLeVlPryvG3QV+5gbRa2UjuJuMEtXSZCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEFwBDsQHT81BEJ3nHid6Llo33mRxxGp8fzXUQhKPceY168AZqHVuv48vXihQ+cORlLBRuLjk9CQWI15sIqhrEsLL6R9tKOqo/NGchSeizFzp6Yy3Y8FvGKfbMH730nuG+0hlzbG/KWXCEMJHzndYscA7BIkqg7b/LSfQSsetp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7fRh+kC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5OXbh031179
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OWSgUZDBbRRXs5XueZsg+EXB
	RZDVUC3PcZsLkywc4rM=; b=c7fRh+kC6V1+is+MMLPsca+M8pYXKhQ7fs/dQybA
	YtFh/0xzlQ56+tTa8zGzDIqTzMUhntFC2MmEpnF0eW02L4g/rmWA1Gfr6XFr51EH
	pLfKRnONraCiKonRqh0jqudYPy4joFF1b39PKTHkrX/ya1CBe7raGO0xaGZol5Kb
	Xm2fh02qOTHvE+Fr9BvUZrk6KHZNAUqTc2YEaZuf/+L4CGgezjjuoeEotebMBfYW
	LboE/narpYsG6R2fEsxzhqyVjRKtOG/uoFmVHL2tOK5Gv5puhUGh4Eb1aZkNZzkT
	Ie1X8ObIEyHDR8d7pbP15Zsx14LM94J/h8XYOv5p5gaFIA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615r55v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:48:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d903d04dbso21801426d6.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385311; x=1756990111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWSgUZDBbRRXs5XueZsg+EXBRZDVUC3PcZsLkywc4rM=;
        b=bI33tMVKAFvsuxNzgZpizi4kYpGXIEDgK0Q4jnAFnn3PDw0Gbol9smpzmnDb2+wxjw
         eURsXzAvgTk82IpCsooK8slgojnCTUDkB36XaEAzCc0xzVlDJ3a/QLRXRt4bjJnQgbMc
         /uRniS1QqR4vFkJrBT/3KBD8/9aizCJ2w+htVuWVVV12TOOLpqBaPSN6IcSS6ZXnLkB3
         asGIoNSeGIIqGHaanEIrcYN2s7XdA6Z/jl2UrCA20MooLJdR/Xhl+P25UYyM+VtdbfKb
         i/D4dNUxwI99MiIwdrD/xsJ/VflqTEp3oeBrVKyHaYgeLlZUYNZ25Lf3BE864fys92bF
         1v8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLP/s72juJf88K5MQPjS6Uy9O3/zW0WI0KBLaB7mJE52IlrlxZU2lTr8mWW1NuU0gdS13PPkoR+6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+b+i8sHf3zjq4kJfHUzkl36HsfUr+IGNV2sbcAK0RcmWa8QbD
	M5wiPzbHSfi1YSGSQd+ytHHSSk4IOn146XLPDsSWY07qKYLSivl+wDSYEy224Eeh/H3ft/BTAGj
	sc0iF5VXUXOOfZ0uOy2AXZrsUEDsWM3updkLP4sLPPPQ8D81FB7ms3VrSU8GRAOE=
X-Gm-Gg: ASbGncvWz+jpWKhFB8EVLcai2igz65Y3N6gJWUrzrz1yVE38dX7AIL2l6U5GkLZlNRf
	xM7PeblBBFVtTHgZAXlNU3LyQeOmc85nVhi6jef62v33yqxUqxOxN65Ih4wiicYBZR40wJKB4QJ
	/0fOF75pp8H8lO3RHvxPuYLwoxXpCsYxzm2DWEA5lb1/3TLfr9OMPdcuuT5gyGtT0M1+LhEawOW
	0ACqydeGLuGoO18u1MLhvnv0b3rpei/rualoo1JPbIaMwD876bj+AYNIJNHPO5qjEPHEvednKrA
	9uia6PUkSITBGnS/a/5f7B8+du8Z5S2a4Y4jRno+Hr29rF8TeNpLFZvNwwMmy+tzl+COXeKXHY9
	hIJSS5ayC0/hKDVxxLUYTt8BEljb2gY7E8/ta8Ib61Vpl7+IoUutz
X-Received: by 2002:a05:6214:21cd:b0:704:8f24:f03d with SMTP id 6a1803df08f44-70d9722c764mr136205646d6.16.1756385310650;
        Thu, 28 Aug 2025 05:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENXnZKSLcZXlBr0d0ibJP90HPFaIblcFK7Jg6EkmV9LMI3r6LN3MPNyS79lCEXAK7vPq5+UQ==
X-Received: by 2002:a05:6214:21cd:b0:704:8f24:f03d with SMTP id 6a1803df08f44-70d9722c764mr136204916d6.16.1756385309971;
        Thu, 28 Aug 2025 05:48:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e2687acsm32396121fa.32.2025.08.28.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:48:28 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:48:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v6 7/9] PCI: Add pcie_link_is_active() to determine if
 the link is active
Message-ID: <r2bhgghyunfcy5ppjcvxm746kzh7vyhsnbphlw4pj52wxtuxru@qzy7earmlnjf>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
 <20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com>
 <aLBMdeZbsplpPIsX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBMdeZbsplpPIsX@wunner.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX/3GN6Zfy/maN
 AJ6J9jbMBm89oZaRZyDO+whZpwLpNkCZgZmfmA+JkILqJjFdnsTKBDzX3n3C/GNWW5a22M35g6S
 iVKDq+DbzDWWHqnP2vOtIewZLHwl8Esloj2ogTdAl76a8UBXbH7MkXlJmlx9SYrV1OzRbQbUkPR
 eGAiq7lEQI/meu9HSd0n96aJxFDBGWFM2B26+iz1bL7YzrjfC1ZGqFNSHI+39zPSF4zlAudE9Ot
 /Hq4MpZg1Q0JcWPekjfRyjSLEW+V1p3NI39t8+JhdXRcqCc9z3wwXGjVECf2fcotDwT8LdxyU1H
 cJid9ZLEaJ8OLqV2w7eqDy170DiYDrFrJVBuFspfWD6vsvI5WiGloDIu99JCW54ixVvphFtBP8+
 5Jsg7zSN
X-Proofpoint-GUID: u1pFwGqbQ6ToM_kjd2YQAHkjj3NargK_
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b0501f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=DLE-xEQoUa54y48t:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_AprYWD3AAAA:8
 a=i8L4npwzgB_v-bGXBacA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-ORIG-GUID: u1pFwGqbQ6ToM_kjd2YQAHkjj3NargK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Thu, Aug 28, 2025 at 02:32:53PM +0200, Lukas Wunner wrote:
> On Thu, Aug 28, 2025 at 05:39:04PM +0530, Krishna Chaitanya Chundru wrote:
> > Add pcie_link_is_active() a common API to check if the PCIe link is active,
> > replacing duplicate code in multiple locations.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> > Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> 
> I think the submitter of the patch (who will become the git commit author)
> needs to come last in the Signed-off-by chain.

Not quite... The git commit author is the author of the commit and
usually the _first_ person in the SoB list. Then the patch is being
handled by several other people which leave their SoBs. The final SoB is
usually an entry from the maintainer who applied the patch to the Git.

> 
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -614,8 +587,8 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
> >  	 * Synthesize it to ensure that it is acted on.
> >  	 */
> >  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> > -	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
> > -		pciehp_request(ctrl, ignored_events);
> > +	if (!pcie_link_is_active(ctrl_dev(ctrl)) || pciehp_device_replaced(ctrl))
> > +		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> >  	up_read(&ctrl->reset_lock);
> >  }
> 
> You can just use "pdev" instead of "ctrl_dev(ctrl)" as argument to
> pcie_link_is_active() to shorten the line.
> 
> With that addressed,
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

-- 
With best wishes
Dmitry

