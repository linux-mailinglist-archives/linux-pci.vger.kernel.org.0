Return-Path: <linux-pci+bounces-44338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D41D07A9A
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CFE03008742
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644E2F619D;
	Fri,  9 Jan 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQ9G3sGk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fA+gMjt9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8E2F3C26
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767945553; cv=none; b=k8u8gcbSUUm3Li8IpBG1ptmK2fCMnodg5OiCIsW3cV5aqwa39qXHppDkWnyrvlI3sAgl+JMC0U17Ek+wNGyTyjJzxr2JwawgplBkEtm3I0ggCUSeG0xJsNtcCYp8ks7jGkQlKBrNVnzrVkDgfEKJ7TjALmmGoPKD4Qxom8t+cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767945553; c=relaxed/simple;
	bh=20oprbe99mrw8N6Q+pLR09KbFExDNoA0lCTTXPurYCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q559Hj/SZOEwp5lazPaKpJkpT2bWCWa+/nYLb4pie5LR+uDVpML/cuxpCL0PFAX9vgUOcYbZpRQuo/KLx4IIUEA/+xXoCGgHzb037A5WJzK1fZrO54skZC/dNT/IU2buM1fj0erJvc6dUu5bDpjHTma7X4DueLBDeNuud7doxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQ9G3sGk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fA+gMjt9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qT473324889
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 07:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gY9iEHXSaar+/asVR21mAoMD
	i9tA3WfBcc1ae+dnUno=; b=TQ9G3sGk90JAH1YCFDqZrKAaoWJyaczFxJOeGTLx
	NMEVooQ1pwMIiSo3lV1ekg5ul1mrMb+zp2aIlBxmIb7I97mf7fIS0eJkQd8+o3/j
	GzW4mdLqmOvjXs/icSa3u9l1QDr4NnGBrE4i5JIrx+b3Vru5mtKh380KSxAChAum
	9La5Z151rfXOAwtB6eQKLDwbwt8vE+umq4NYLoCpmt2ExZZHVnAGit0RkehQJ/rm
	KNo9NwA+/uCMNmfJ++5ySqy0jGh6OrK+MvKqKwcvgiXzCxrYt3XJV9vqLJGOvUrJ
	rttsjQJrqWujZANUYIuI90mkf+1CEUWzIW7prCwJ7L3k0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6gwrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:59:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae546fa935so18528248eec.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767945551; x=1768550351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9iEHXSaar+/asVR21mAoMDi9tA3WfBcc1ae+dnUno=;
        b=fA+gMjt9WeKl0Sou0j7KbsF0faGXEGMdnf/JHBff9KxHFBq/xtRb0l6IlLgcYDb7h+
         V2b7KoVGzD68L62FO1mlm+H++xPJN2K5tmo9roZBCAPgyRUHOjByAu+2vxjonHGDkfIU
         D80NHL875Ms02lHh8RSbqaFpEJ9Lp/Fltk0Ui83m/ZK1P8PtM6flTf+SZq8Y+CLCw5PD
         mB4PQ9ZbHjUh4z9rVW3OOz2DbOUhY6PrkrzI7bQa9tNPZNJndKX8SJDj81AE9E0uUicu
         budfTY5UCkvtokVn+NRTcrQU+wnkx9Z6LUoimjNqwyBHJj780YgOiJpaF5xTQp1frwAn
         XX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767945551; x=1768550351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY9iEHXSaar+/asVR21mAoMDi9tA3WfBcc1ae+dnUno=;
        b=eOiO0n+MUAmlOXVHU0Wf58QI4WFSmwKHgHMh7ggW/kzm8uvK7biaOXgrdT3rb/Hqyv
         FT5LNrPKV9Sodjb/wndjm4TPO8FSTETZhRYj3Pu/c3Aw9YOTY4HsUT2aqZrGchyChhud
         HLFcWaGayIBHMvfVkgWLfF4pqxeKNr8eTe8osvJV2xvcBIefLM2laVEm5YOxCxW4190e
         Hp6gHYeKXT2Rph4Z9dSnGQDPZKweJ0NM7QkInhKSfWh7Ik4PxZ0VKtj51UxZjDaESYYg
         Le8WmuPMS9IckwFBPP9WevGUzwiwTzAoTpoDHrjh9ahzxWii1xhYySZ2Ys9sPyHFpthT
         bFWw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZQJ8ax2AXwtWpTJlynoNWd/uWiQfbLw+l4BIhcmLlTcsvjqwcE4/0HgEEFCqmIY/06DkSKwCy5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5NIBvEkdS0s/d+vkYdk6xl4Yxz7vKZV41dHdRdgXokBIxL3Q
	ydh1daiCtxHYNLKSSniRWzvw6UNx/l4CTsSxlsOfFHkA+c/zco2DndRpB4u0oo+9EWazLSEf3od
	nwH6jIo3lH00sJhp2Vp+hK/WKpRxG+TpU3YSneIIpBYiAUOL9p9uOxkWwR3gE+lo=
X-Gm-Gg: AY/fxX4yrK0A1c5h3vCeC/VmfMz7L+8mRROazoLaoZojByLnIlLOC+OsUxB2P68KKpv
	jR5HMQNK6NwRluvKT2L0Q89bWHv/LrdmFinCqvzbn+0jg6jzj03yslJ7iaILSR4LosdWCsOsdkT
	+2RFQiUenVWDkumOkWh4QrPGx8pMN+YjLSQkty+F88WaaKWwu6xLsRuM0lLFYA6LLTkJM/JdZdM
	4TY/ddvdTUaSpvZiZT47CBKvLdWfiV79gOZ8pHMujO2KXp7J+XUryCLMocXpZlDcJK5BBC2imNO
	KRgo5wskSucqUMeoeVEGDTU70kTNUm99fqlkOV25oK+ifM05zwl/rXh2CKjITk5W3DFaK8FUDsY
	GaS6gJ0lWDvYre4cN9If2oPtsM0cOcutCYseujPLGlhJ1CNFXWEqn7wj7
X-Received: by 2002:a05:7022:e07:b0:11f:3483:bbb0 with SMTP id a92af1059eb24-121f8ae75e8mr7031118c88.19.1767945550415;
        Thu, 08 Jan 2026 23:59:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3d0juRmwLBIp3YmHg/Niju/fMNLgYKKjY4LGEf0G9IFzmUnA/cqDtsNCjmnkqlxwt1Ln7GA==
X-Received: by 2002:a05:7022:e07:b0:11f:3483:bbb0 with SMTP id a92af1059eb24-121f8ae75e8mr7031086c88.19.1767945549756;
        Thu, 08 Jan 2026 23:59:09 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm12877992c88.17.2026.01.08.23.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:59:08 -0800 (PST)
Date: Thu, 8 Jan 2026 23:59:07 -0800
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] PCI: dwc: Add new APIs to remove standard and
 extended Capability
Message-ID: <aWC1S3m1V4JotL9C@hu-qianyu-lv.qualcomm.com>
References: <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>
 <20251226210741.GA4141010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226210741.GA4141010@bhelgaas>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1NSBTYWx0ZWRfX/U2/Xb0y9Jgs
 mxnhWjGzNDF5fj7CgVabV561evjKCSimnXPHYYL18HlWDU3OStoyRaGE5G0VbFEfiVOJwNoeMfW
 aYTtiBkS5eMfm/9DuqMY+8726xUsxjmZ8gl2TTMwJqOIP2yfX3x1GRU717mu4XBgWqC2x+UyNJB
 8t/ubcadc8i+5riDjC3uqaXaJOePvO58XJoIxZ5RUda31RkRKjtm847aAhwG9/j8b+3wDrPN7ju
 +jIP1t1n5S8nVnysJMs5xXGXugSBM4YajqP3yVcIqem7Z2u8Jvn5gfyqr+mIisytkfxhRwjVdtl
 bEz3WTCPMqnFuNB4NUF/z9DqJnlXALkjk31Yti7v08BfQ4cGnPoNOdl8ktEtapuy91MokikrZYg
 9Zwh8qcfRnfAGywfGdJKaJLQHZHhhbUSllMy0boGAHqFOpil+sDL7EeI32qcYEDrIn4DR5HbncA
 9d+LfJkmpWH/VOEmZ5A==
X-Proofpoint-GUID: kkxuJ9Dlnk3ku84XKWnjzUiowWfzmbvJ
X-Proofpoint-ORIG-GUID: kkxuJ9Dlnk3ku84XKWnjzUiowWfzmbvJ
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=6960b54f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=keqCWTWlQfiW9DbH:21 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=D5-yWOEsi3iyDatbWL8A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090055

On Fri, Dec 26, 2025 at 03:07:41PM -0600, Bjorn Helgaas wrote:
> On Sun, Nov 09, 2025 at 10:59:41PM -0800, Qiang Yu wrote:
> > On some platforms, certain PCIe Capabilities may be present in hardware
> > but are not fully implemented as defined in PCIe spec. These incomplete
> > capabilities should be hidden from the PCI framework to prevent unexpected
> > behavior.
> > 
> > Introduce two APIs to remove a specific PCIe Capability and Extended
> > Capability by updating the previous capability's next offset field to skip
> > over the unwanted capability. These APIs allow RC drivers to easily hide
> > unsupported or partially implemented capabilities from software.
> 
> It's super annoying to have to do this, but I suppose from the
> hardware point of view these things *could* work depending on the
> design of the platform outside the device.  So the designers probably
> assume platform firmware knows those details and hides things that
> aren't supported.  But in the DT case, there likely *is* no platform
> firmware, so the native RC driver has to do it instead.
> 
> > Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> > Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 53 ++++++++++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
> >  2 files changed, 55 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 5585d3ed74316bd218572484f6320019db8d6a10..24f8e9959cb81ca41e91d27057cc115d32e8d523 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -234,6 +234,59 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
> >  
> > +void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap)
> > +{
> > +	u8 cap_pos, pre_pos, next_pos;
> > +	u16 reg;
> > +
> > +	cap_pos = PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
> > +				 &pre_pos, pci);
> > +	if (!cap_pos)
> > +		return;
> > +
> > +	reg = dw_pcie_readw_dbi(pci, cap_pos);
> > +	next_pos = (reg & 0xff00) >> 8;
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	if (pre_pos == PCI_CAPABILITY_LIST)
> > +		dw_pcie_writeb_dbi(pci, PCI_CAPABILITY_LIST, next_pos);
> > +	else
> > +		dw_pcie_writeb_dbi(pci, pre_pos + 1, next_pos);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_remove_capability);
> > +
> > +void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap)
> > +{
> > +	int cap_pos, next_pos, pre_pos;
> > +	u32 pre_header, header;
> > +
> > +	cap_pos = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, &pre_pos, pci);
> > +	if (!cap_pos)
> > +		return;
> > +
> > +	header = dw_pcie_readl_dbi(pci, cap_pos);
> 
> Blank line here to match style of other comments.
> 
> > +	/*
> > +	 * If the first cap at offset PCI_CFG_SPACE_SIZE is removed,
> > +	 * only set it's capid to zero as it cannot be skipped.
> 
> If setting the capid to zero works here, why won't it work for all
> capabilities?  If setting capid to zero is enough, we wouldn't need to
> mess with keeping track of the previous capability, and we could drop
> the first patch.

I tried this. Setting capid to zero only works for extended capabilities,
not standard ones. Standard cap id is RO and can not be cleared.

- Qiang Yu
> 
> s/it's/its/
> 
> > +	 */
> > +	if (cap_pos == PCI_CFG_SPACE_SIZE) {
> > +		dw_pcie_dbi_ro_wr_en(pci);
> > +		dw_pcie_writel_dbi(pci, cap_pos, header & 0xffff0000);
> > +		dw_pcie_dbi_ro_wr_dis(pci);
> > +		return;
> > +	}
> > +
> > +	pre_header = dw_pcie_readl_dbi(pci, pre_pos);
> > +	next_pos = PCI_EXT_CAP_NEXT(header);
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	dw_pcie_writel_dbi(pci, pre_pos,
> > +			  (pre_header & 0xfffff) | (next_pos << 20));
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_remove_ext_capability);
> > +
> >  static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
> >  					  u16 vsec_id)
> >  {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index e995f692a1ecd10130d3be3358827f801811387f..b68dbc528001b63448db8b1a93bf56a5e53bd33e 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -552,6 +552,8 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> >  
> >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > +void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap);
> > +void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
> >  u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
> >  
> > 
> > -- 
> > 2.34.1
> > 

