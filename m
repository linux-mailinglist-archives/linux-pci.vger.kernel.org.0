Return-Path: <linux-pci+bounces-43769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EECE49E3
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A55453004D0B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463AE288C22;
	Sun, 28 Dec 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhjN5qKf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c+UFTj33"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CA2580F3
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766908189; cv=none; b=HWPRlLC4IrHUxZjYSMIna5EV6MLwNRuHj4U0KrRHYQ7p+Sh2WjewkETvg5g1jEB2ylTksEQMw5o7aj2WWnRDXVdgd74i52MskLweFnPG3RqpXMBRdBuA4+qz1acBoSAvakTd3pLSagzybWCSZ9lco1776OfE987WMtzAfvc5QDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766908189; c=relaxed/simple;
	bh=0CyKklq7gu6akXr0K6/4BgYa82ZxGPmot9aZfuyv+qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZdhghTfhEa4rXO1HtkhAgOVzKdg4rP9YGCNCmAfxNE7GFA20s5zQv7OA+5G9JhUP5ZyjTmzzkIW3XZo0BwA68cIuzshQMFYQ4CYsCRqqx7brhlkOR6tstmoq4lLp5sfhM5xjc9bYQsBeko8fvN8VIf5XdoKXhWIg/o2aWN4FwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhjN5qKf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c+UFTj33; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BS4OlW22276889
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 07:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ozAz2Jo73be66GSkicAu6eZg
	p9K2slhROeS5OuBZxxU=; b=DhjN5qKfNb6aNE0csHqc9WqSRfdjQpppFDS7UteX
	0Sju/tKyi/XgiGfCYaYTqeu905q0HoSaW3XvEZtyyzn2el3dO1e0RUTcxickCfZv
	OiCa6NTmlGIOffUGCIVq0lXcVrwvUIrQKZUgmlwMaJ23JMdcvgY0t+LlZeFb2uLG
	Xhkn5dNXxwhJSpNibEDsZszKspspnfkRivpEfggR6qJfdoen5BAY8oGssv8MIRIT
	5dXTNIqR9rC6wEoGY5KZMUM5sucuS3fk/RwbYeUzO/O523+2krFlHaWBTL2xHC5f
	yBPaKaCBU1+B88kJQ6HhVc44yft0ob9IOU5lD1ck8GFZGA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6f61y0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 07:49:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34eff656256so3577080a91.2
        for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 23:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766908185; x=1767512985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozAz2Jo73be66GSkicAu6eZgp9K2slhROeS5OuBZxxU=;
        b=c+UFTj33EY+DCMJv3Pk6+q2lDLli+Nv2y1zX4kbOl+3amy6k7qS5vdQGpbZ1NDQ31k
         pPIue/gyfCT3QWgYIvL/x4ftzWmz7Py9EkEj2s0WlFgGNqQ5QGcw40g9pBANreaYNVkn
         9452LFPKo2xIcwjD1b+QwLpebjgvxPXMlJaQlFG2VCPNv62ub5y3l2yZho1TCN8fb9z2
         oTWdzZDBM1zSWjLqjWi/4XF7TKtJBIOipAxNbEvnM6WJFGaIv4thxApR+17hwWKmyqHh
         QMMQfO1HnwFHE0PfnSH/I7tNjk+3XATIo9FaKjMjapL8v1W8QfwBS3LzGSw7yiqInXAc
         VT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766908185; x=1767512985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozAz2Jo73be66GSkicAu6eZgp9K2slhROeS5OuBZxxU=;
        b=hVVV4sodniy+eBKp8DeyBbXsw9CANlyVablxHMqVbKBxOsInTbXdCU1J/V2v5A0MzK
         yfqPmqbRRIbHC6HO62pseCepl4Urz1UE27gdTMmptN61IuRF7EwJms0GF3OiN+0OW7Rz
         2V03C6/d2rsoq5EOugMj9gj9YgvMdtetZmX20uLCwMRQIw1jXmAjey8KX9fZPTaosjGM
         P1w+zGP3tyE7qZ9w3/tvTw3J9I0FmQRhOXT6dYk4lWutMXo71jvzbJijKYgyVRET3x7x
         BnJYglngFwrpF4eobPb4iki1WWuoYNHOWUbBfGqclJlymvujb4PzLNQpgvSdodEJskk+
         1Sbg==
X-Forwarded-Encrypted: i=1; AJvYcCVuD6Uv4oNoL5ECDrRGKYkQkjI9DldxzersONpmR8Kv0XD5XKJHgbuqOZSveVlRUPKdFT+8a/6U07U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76BS/XhhBc8DbsRSQlileY2aFDwKtCi7oNqfxLWsEVeWrQuwZ
	jF3leOwQr9LMvs32OTDF3HxLaaS9V5eeHhhKBFA73a8u7Qh9gRBEVtI8uNRevvbighOfLRQVstr
	PDzGoUAeCQTkZU+q6V/1b1AgrF2vzif9ETq8ygOfO2PfVoUFdNqRywGHtLn5q/b4=
X-Gm-Gg: AY/fxX57LXfttx8kaYUtHTt8LW04+V3CBi4Cn/0nRHKlOrXYDjXR8/k9PN2mITRK6sK
	KwQCVqQ0NpFsksn7m6t+TMS2TQB2W3SRQBGPIwMtFJR57FPQyRq/5uRFtuH2YToh/vls35WtQnP
	4rhqvamfgRKLex2dkZWUbE/5cYKowvjlr+ajH2ThgQNdeS4TXZnpat9FlyMhy1jCr4VmDYE8X4S
	xbNqSZAXuIuBM8h2dO0EjBd/CIvvDEjO0N+Q9+I3+WzUI2tQplBia5TXOCn1bkPKiOEo8+4YAsG
	QMjAcbQS35Ty5vmogzDSgd1/A2JcwSPT8Ln9LeoI9adDTXQRt9N2pkLhyFzuHePvDELL/EyM/y1
	MVUZp/HXKusMGnjSjpYt/uajpFiNnaScSImhO1Mm/gS60/EnSPzoRpvyV
X-Received: by 2002:a05:7022:418e:b0:119:e569:f277 with SMTP id a92af1059eb24-121722de77cmr34166312c88.32.1766908185275;
        Sat, 27 Dec 2025 23:49:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO8thVNapHDv7G9tK/2meinfs5MkG9bbUhtOuwb786ZtYAKes66JdhZ2z3UhUTvc0TnWFxUw==
X-Received: by 2002:a05:7022:418e:b0:119:e569:f277 with SMTP id a92af1059eb24-121722de77cmr34166297c88.32.1766908184573;
        Sat, 27 Dec 2025 23:49:44 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm101754437c88.1.2025.12.27.23.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 23:49:44 -0800 (PST)
Date: Sat, 27 Dec 2025 23:49:42 -0800
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
Message-ID: <aVDhFq0Qu6pVbVd5@hu-qianyu-lv.qualcomm.com>
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
X-Proofpoint-GUID: zKz6NrHKQS4McsXeOtdyA8GZgs6QcAV-
X-Proofpoint-ORIG-GUID: zKz6NrHKQS4McsXeOtdyA8GZgs6QcAV-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDA3MCBTYWx0ZWRfXzSYnC+J9wu/4
 NdqnLDKe3u56uiJT4RFPH5iq4OGb2Rq8/cxy+2BHq9kyLQ8ncP+KDckd3NH5q/2XY7NnHZBwsi0
 0VZ2y8D+SX3qgTz1sgHIe2H/JZzbHmePb4vkB05J5RVz8D1SNlQnp++rSqzcH5GLtqzoyB4ccxG
 F7KujJDbBjUdH/UsMcN71cpfTt+BmJjlFtvJa6RsuVhTcRGpm2MsRCl8Annlag2wLun9m/tWSHU
 cHxjq0+8YFSjkzzTHeuXsdY2QL266jIdhbA7uB/szaHGDcbQnpQ6TZ+F2gkmOfwuCaF/T3tnNRa
 7OsvWDTTNu/5P9OjbtebZYUWDjdks5mQpOZFKYEbfb7ycQ9Tvp81dyMx/rjHggMsTWYSNjdcEyC
 D9DrOPLgGog8PSok8bMamz/Nl8DzQohed/YCNPbLRz91o71oEAjQaMS4+MBfeOjphfhpgaRumWW
 Gm4IPVm4snFhPgDa9bA==
X-Authority-Analysis: v=2.4 cv=YuEChoYX c=1 sm=1 tr=0 ts=6950e11a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=keqCWTWlQfiW9DbH:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tMZTvqJGQEdRqENTUMoA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_03,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280070

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
>
Setting the capability ID to zero is simpler and works for all
capabilities. However, it makes users confused to see a capability with
capability ID zero, especially when using debug tools like lspci to list
the configuration space. I think it works functionally, but it's not a
clean approach. Setting capid of the cap at offset PCI_CFG_SPACE_SIZE
to zero is a last resort.

-Qiang Yu

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

