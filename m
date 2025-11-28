Return-Path: <linux-pci+bounces-42245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B013EC918B4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924FC3ACDAA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773E17BA6;
	Fri, 28 Nov 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ph0bkRlG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HwnOHixS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A8308F11
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323842; cv=none; b=YsX8fPa4jb9DRw7UrIU5oBdTTrX75OzGdVogLIf4jFK8Fr4ZnILdczD/9xOXsbH6AJzMhyvB8wcasuDAgk8Kwv1pG8gEQbJbvXl32N4bCAjQhyj9JwODiv4oPRyB44Xn9QpoSG5PoC6QAx4hlOYgVlAK6cCRbENkBfgPM4oGR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323842; c=relaxed/simple;
	bh=ZCQ+X6CcJNnx+pPiStYcloaCorZ3vkX6wLFtfUvufdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFwvzv0ZJLayG3CpJioBPWFu52qlrbKBLwSeY/o+oiEa9NrF1NInDpYA6optBR8nEp9BgyNAs2M7SRE2tRxRzHtAAK1bLNnE+FRy4RXHICs1DCrG3M06pfPkz8v4ji9aTz89YGSfaSWgjGcA+XjkHcX3e67EzAhADmPSJYFUD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ph0bkRlG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HwnOHixS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8rmUv3989819
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 09:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MOyTbwOeGqQB5EkYD/6KseST7rH0TIy381RauUT9o68=; b=ph0bkRlGju6I6WaS
	dgjo1eSQxVWS38oBGdjQjX32fg31UwKBxtWTqeCmLvx5lFkwIWuJZj6UwQvFl5aP
	CObMWbSviY/Vu85tQV5jLpLqw8yzQCmatAm0ReFm7ARLqweLlSQVjIYRZVVN3LE7
	oKWr4+4xLLf6Otti8shnRIkvhuzFfN/X4rmuxQWiofIuo0cxOzMNzzOK+pcMvfuK
	sZdHR2FYMoO7UVa/xUlgSv9UIOk9/xNEuuC3Rdg1P0eFyWKMDzyyT1mgneT0jDe/
	e1vyZOPrAh8pt3A7LMUOvcqtrjWgIzAeNiSWJtZ545UGPftc6tm2U8+MGbD/XnHX
	hMpn2g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aq8mm86yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 09:57:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bddf9ce4935so1414866a12.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 01:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764323835; x=1764928635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MOyTbwOeGqQB5EkYD/6KseST7rH0TIy381RauUT9o68=;
        b=HwnOHixSz9kVW0sHphIdZR7hq/ezA57aaF0cb6n8ukM6I0jZy8SHBmN5lfc9SDwGmT
         nTytnAu5Nvt555+PbrWpBSFgJcJU+KYBieYH/S0Nrpv1AmHyOyMZubhUkJB5zvJrNNyR
         m0dam8zlLPjJ8oqJvsbT9itT4kJhOlV9k95oZHbaxuzH3GR0crhGqAUNLb+MeRRfH7pb
         Yxk09gJayK+Tf7YYaE1eD5L8O0/PAneWsOmgSfInrksKvgQW8SS5A8ZX1iyGb3yFf+L0
         WuCbC96pb92qKgxhfAO6wNEaHDfuiemRGOOrZTGXM15qmI8eARasjKpH3AiVV1hyUoi8
         4YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764323835; x=1764928635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOyTbwOeGqQB5EkYD/6KseST7rH0TIy381RauUT9o68=;
        b=WOFjzss1GWdA4Jm0tHmAr3K/DfVehFeD68ZWNdC08+sJ+f+wHvtfWA1D5bMwZTDGtd
         xyfsltXpUqOG8ZM5Iz73FOuFumQDasVwtpmcT8bOZB29xRhVD4hYbH6G7/BIf2cOQIrm
         kWuXZUV0HU6eoqs0BQMFIfid85Q+3nI3DotjVo4VZsS50jJz3jUJpvkVwSAHwQWSil9e
         /xa79RXNSm/XZNRvTYPa57QurcZI0Fg4pZkVS8qa4+SQvXuiS2l6Cv7LLdtFMiFYaf+f
         cWG7sWi8KaV6fg7KHxSVj/BlyyvPS9C0UL08MfVPtCSNwLRv+UFOIAAVtHeC5RQrdw+C
         B+9g==
X-Forwarded-Encrypted: i=1; AJvYcCWLl6EXfNxyIuEzUARlYWK50LhViZOEdc612zQZE9f35JeGvUUr2CzePmq9kIhgEcMKGjMMkXFoEmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6nD+zDKKmwhdl52EPdU4AfyRhQ8LaHooVW+EXaSMjT/0rFw7
	ce5dfqIKbh1xJh6dsOVyctPtPrWRkg6fcA6bPp16AH7BzqSDPkMC7E99FWtMy/j6NGHdFNy8t5K
	5yPSR4hTBgl5J86cK5qR1QwlWe3JYz/YOytiuUjYuWfLDFOkUmv9RNTx8MPMPbD4=
X-Gm-Gg: ASbGncu5BwY3QPdkLCcrHGpKBZejIdGzMX91fa5KXHpBpn9/f8/TTtxTDjLS42YocUl
	NT3s947WlhGvBCbV+XvTiK1PJ06OWyhTDuJhQmjDKgpTPPLG0vstUV3myjANAzZQo7ejwacEd5r
	eomiIJexKFgMZyc7BTndzfZV1QY7as5lC9CjsZxdbrDHmqdWIKaDX8fP4dRje/OnPx+RbVGngXJ
	MSimjYb5WsqEc8hidL3E9Qrj1KjUU+WeQUrvogUTSJTqaJJTDh8Fyej8JI/6AX8UZ11+OUF4h8L
	KtHGkDTmRrizeUNcvk9SraTxeU2YokyZRkwGZztWekZmAq/ARdEbOpfXTg1/1bV3LHc9WkaS1qw
	+6yHQMgrb04HXBzQ9+QuPhTVnGNwxhh4S+fccdZRRxx9iXA8h81VO/r/f
X-Received: by 2002:a05:693c:248b:b0:2a4:5c3b:e2b0 with SMTP id 5a478bee46e88-2a94176125dmr8165223eec.25.1764323834412;
        Fri, 28 Nov 2025 01:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHocW7i1Sn9KTPY4QfjJZylauhsGHMC3Tm4JYoMU9NxglbeedCvSs5CRZc2eN/HIdaKiy39SQ==
X-Received: by 2002:a05:693c:248b:b0:2a4:5c3b:e2b0 with SMTP id 5a478bee46e88-2a94176125dmr8165205eec.25.1764323833621;
        Fri, 28 Nov 2025 01:57:13 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm13697351eec.0.2025.11.28.01.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 01:57:12 -0800 (PST)
Date: Fri, 28 Nov 2025 01:57:11 -0800
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Message-ID: <aSlx91D1MczvUUdV@hu-qianyu-lv.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
 <dc8fb64e-fcb1-4070-9565-9b4c014a548f@rock-chips.com>
 <7d4xj3tguhf6yodhhwnsqp5s4gvxxtmrovzwhzhrvozhkidod7@j4w2nexd5je2>
 <3ac0d6c5-0c49-45fd-b855-d9b040249096@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ac0d6c5-0c49-45fd-b855-d9b040249096@rock-chips.com>
X-Proofpoint-ORIG-GUID: J2xC_7cRQ22gFW0zKbDv9traZyGTrdwO
X-Proofpoint-GUID: J2xC_7cRQ22gFW0zKbDv9traZyGTrdwO
X-Authority-Analysis: v=2.4 cv=Cvqys34D c=1 sm=1 tr=0 ts=692971fb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8BFNsxKPdyf3tXGkzS8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA3MSBTYWx0ZWRfX2BpHtkU4refA
 +p9kmRD3LishZmzLQU4vju4H2rR9rr0I2aH49DcS2UthcoYec8UPjzKDFchECcS/jv3uX8xQL9c
 weEcBkLQh8oi1pXBvn/Wb4DNX+N2vu2wtizzt+7gXYbPEh6glTH7o5rTLhfZ5YH7OflD2H/wigN
 HLk8ivyYHrRICJMhCobPsTCVTyfBXcqxEYnAhgQw8e7LAuo6OYJYGmwQ6sBtBdpthUSrWoNIGTo
 L2X1FObKwU6VuQJCdzDhMAFiU32KM4WtgLY1z9Y7vD6vqkc0hZU+jmUmlHU6MFlUuf7bUCimCgv
 mSxDDcOfN+DBqw54b7CS2OEwjhR8sFA5Z8s8aFkCGMNZ72/Djg/UKApY4XwDnlDO2vOnaeBCkpC
 lqjuui8nVVOjv/jgfDxNo60xIlTa3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280071

On Fri, Nov 21, 2025 at 12:04:09PM +0800, Shawn Lin wrote:
> 在 2025/11/21 星期五 1:00, Manivannan Sadhasivam 写道:
> > On Thu, Nov 20, 2025 at 10:06:03PM +0800, Shawn Lin wrote:
> > > 在 2025/11/10 星期一 14:59, Qiang Yu 写道:
> > > > Some platforms may not support ITS (Interrupt Translation Service) and
> > > > MBI (Message Based Interrupt), or there are not enough available empty SPI
> > > > lines for MBI, in which case the msi-map and msi-parent property will not
> > > > be provided in device tree node. For those cases, the DWC PCIe driver
> > > > defaults to using the iMSI-RX module as MSI controller. However, due to
> > > > DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
> > > > when MSI is properly configured and supported as iMSI-RX will only monitor
> > > > and intercept incoming MSI TLPs from PCIe link, but the memory write
> > > > generated by Root Port are internal system bus transactions instead of
> > > > PCIe TLPs, so they are ignored.
> > > > 
> > > > This leads to interrupts such as PME, AER from the Root Port not received
> > > 
> > > This's true which also stops Rockchip's dwc IP from working with AER
> > > service. But my platform can't work with AER service even with ITS support.
> > > 
> > > > on the host and the users have to resort to workarounds such as passing
> > > > "pcie_pme=nomsi" cmdline parameter.
> > > 
> > > ack.
> > > 
> > > > 
> > > > To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
> > > > from Root Ports when using iMSI-RX as MSI controller, which is indicated
> > > > by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
> > > > eliminating the need for manual kernel command line workarounds.
> > > > 
> > > > With this behavior:
> > > > - Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
> > > >     components.
> > > > - Platforms without ITS/MBI support fall back to INTx for Root Ports and
> > > >     use iMSI-RX for other PCI devices.
> > > > 
> > > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > > ---
> > > >    drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
> > > >    1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > > >    	dw_pcie_dbi_ro_wr_dis(pci);
> > > > +	/*
> > > > +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
> > > > +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
> > > > +	 * interrupt handling.
> > > > +	 */
> > > > +	if (pp->has_msi_ctrl) {
> > > 
> > > Isn't has_msi_ctrl means you have something like GIC-ITS
> > > support instead of iMSI module? Am I missing anything?
> > > 
> > 
> > It is the other way around. Presence of this flag means, iMSI-RX is used. But I
> > think the driver should clear the CAPs irrespective of this flag.
> 
> Thanks for correcting me. Yeap, how can I make such a mistake. :(
> 
> Anyway, this patch works for me:
> 
> root@debian:/userdata# ./aer-inject aer.txt
> [   17.764272] pcieport 0000:00:00.0: aer_inject: Injecting errors
> 00000040/00000000 into device 0000:01:00.0
> [   17.765178] aer_isr ! #log I added in aer_isr
> [   17.765394] pcieport 0000:00:00.0: AER: Correctable error message
> received from 0000:01:00.0
> [   17.766211] nvme 0000:01:00.0: PCIe Bus Error: severity=Correctable,
> type=Data Link Layer, (Receiver ID)
> root@debian:/userdata# [   17.767045] nvme 0000:01:00.0:   device
> [144d:a80a] error status/mask=00000040/0000e000
> [   17.767980] nvme 0000:01:00.0:    [ 6] BadTLP
> 
> root@debian:/userdata# cat /proc/interrupts | grep aerdrv
>  60:      0      0      0      0      0      0     0     0     INTx   0 Edge
> PCIe PME, aerdrv, PCIe bwctrl
>  63:      0      0      0      1      0      0     0     0     INTx   0 Edge
> PCIe PME, aerdrv
> 110:      0      0      0      0      0      0     0     0     INTx   0 Edge
> PCIe PME, aerdrv
> 
> > 
> > > > +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> > > > +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
> > > 
> > > Will it make all devices connected to use INTx only?
> > > 
> > 
> > Nah, it is just for the Root Port. The MSI/MSI-X from endpoint devices will
> > continue to work as usual.
> 
> Qiang Yu,
> 
> Could you please help your IP version with below patch?
> It's in hex format, you could convert each pair of hex
> characters to ASCII, i.g, 0x3437302a is 4.70a. The reason
> is we asked Synopsys to help check this issue before, then
> we were informed that they have supported it at least since
> IP version 6.0x. So we may have to limit the version first.
>

Hi Shawn,

I checked the IP version of PCIe core on glymur, it is 6.00a (0x3630302A)
and iMSI-RX still can't generate MSI for rootport.

- Qiang Yu
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1057,6 +1057,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> 
>         dw_pcie_msi_init(pp);
> 
> +#define PORT_LOGIC_PCIE_VERSION_NUMBER_OFF 0x8f8
> +       val = dw_pcie_readl_dbi(pci, PORT_LOGIC_PCIE_VERSION_NUMBER_OFF);
> +       printk("version = 0x%x\n", val);
> +
> 
> 
> 

