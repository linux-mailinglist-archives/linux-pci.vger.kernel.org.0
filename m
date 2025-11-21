Return-Path: <linux-pci+bounces-41850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF5C77C4C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 08:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4E2BE2C10B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DEF30AD15;
	Fri, 21 Nov 2025 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XKkzn5IE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAlWyM6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAE305066
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711776; cv=none; b=NaRrTH9xBSLJm4yxRMvlp32kgJCJrVpjy+DFxLRLhwzOakm+qhYpIl3SjET9id5toSLQ30Yf+nvzWVRQNDTXo9U0C1jUxtpm4/oaXN9tI+ruD7JW6L6sU/GKCvavYM+5f8Y7qbahWpdpPcIk3eWHEWIgPgdVQKZewL30/MrNaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711776; c=relaxed/simple;
	bh=9O8cOrJeuY9GBH3d8E5up4xj3GyVsFfoHTujS0uZIUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccu+cec+mPt+gf5LX7YuNoOzJJzhKwaTeq5Tcik00xaqsrLaFIDGCxfPuVYpH3dnIqese9XewlZ3HRmr0ESAXK2og/rKJHXGZXpi33DHNsQ35FTsxwDSXvlVAhZoab8MsSCQam+iFh2lQBoFO599u/e8AcILpm/JUJgxmGyh5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XKkzn5IE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAlWyM6g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6RI7H1830366
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 07:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nme/VvBNv/AYe693OUbdgkmznUIedHABnYiUouLVBs0=; b=XKkzn5IEDXJV1mfE
	pVx4BD9ZuRGUsr+5eDwiaojFyyCRiB5NJe6/swwk+Bd4yFUFMYq13IwlIljdR8fj
	03+tgq6QRMUucNy+dShAKg9wZdW1jSds914WnHdtXTtxd/549HM4UPWcu43ddLay
	IGkbecE4VQLlqJBsurpcT1tAO9jJki6m+VohH3X/UaOBVz3Cqe6htUwWqGrV26zI
	XvLgtYgw2KEueKm+oJzSDn51NpW2F5N+IQOxDNfzEKzgFbULnC9hOa6klgEvb/kQ
	NJp5NMRY+XNJioAZRFC7dqebv83BSyN7ZnIxiY4kb4LhJoKNcoTyIdbkJhWncXrw
	Zj21YQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aj0kw3n28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 07:56:12 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6577768ec28so3461471eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 23:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763711772; x=1764316572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nme/VvBNv/AYe693OUbdgkmznUIedHABnYiUouLVBs0=;
        b=GAlWyM6ggvBDQ5nUJnSd82wZq+LdeR/b0ljWk7aR8OZeRebA1fVgimuQwbEPlHLOTq
         BneB8WkoNTdc64fWe9KMMpSm4JvQk8Plu209YB2joDQ/QD6b4ItK2EVxDj3ixI7QOTc1
         TVK4SDH5FAV9LINbmFcCNBOJSf7bpLChgrJErxg8gmN8LwZRH8TtXZ8oxAQUBOoatuQ+
         iaxwSmus4SsqMmx8pn42Eue/W9q7fEqdKfGF6WWxnAPwKHHtoSyaFM8PElSztUsL4Lob
         tPWbTSK8LQw95j6J2Gy3/puAN6JkQ6f4t88+WwrPiP0N12iJxYo/OY424t1qvbQ2Id9t
         j9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763711772; x=1764316572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nme/VvBNv/AYe693OUbdgkmznUIedHABnYiUouLVBs0=;
        b=rV+bVF7nzU59pwGN4hv8Us6vv8iUqw3US3hMsWrqWv1A0empk9324jot0j2mb3IQqL
         9KK+qBLeRLxMBW3uZAYv1bJrWHsKDLhDw3KW5HfVrH76NsNaXlbfJCiMZlT1mY+jK0TV
         y27WER2VIyXjq2wOHfJY0ABgW4Qo2fk5hi0OKtb+1VybIplD+Ii0UjPsYc1nEfkxy4AH
         w/ZYfOHSTxRlYWeYS11hw20Mi5hAZBj3J/n68lu7wPgJX1WZfjFE3mk3PkTnyrTbS/i4
         BBK6CiNLdwf4W9YSlliXMI4eFjySBSVad7bvaBZj0/gcgfQmxZMuhUhXITJhmUkkxlpT
         28ew==
X-Forwarded-Encrypted: i=1; AJvYcCWyWPGGpXv1nVsQzCAfAlasFaNezlVlEWswutHCf/RuErKp5eBLu1XeDoo1ogkz5BbVEFm80bWt4FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXrX0OARgBi/8yS5ogGMXW95MOpH4QYoXYYPF/qfZhfFv/7Ho
	T1gqKVySQcbWYQ/zIAN7Uf03lbbTOCI95T1tUYc+Ctz0JMtIraonoGYK+8PebXbR68EFDMyGvKC
	fWF1rH0OzjRW75IoxeEvN0tN1rKiKbEgC4CGz3KdDm/JUnhaczTvYYyndhS0otEBjchWxQAqUVA
	==
X-Gm-Gg: ASbGncvzz/ZNjlN8lxQnJz+SVkvvwzxdUUYyTLwekdrQRNEicxXWHnwAtpevYajDtdj
	jdXCO4jtyYvGRBeZvNCm81XWTH7dgR61ch4IOlTWEP2QNuNd1eZSbelQcLQzNzNFRvOPhKei3DQ
	PFWUVxF0+3s6en+MaEt3vcT5YtEvAg39pbMkmr6IbBrhlE4dBMzhOEAWcyhr/ER6FJU7knHkyvZ
	lmvIFVFSlcgD80w/zt2A4gGL5MNjoySBIkx26il11YKRAO5pSz+W4bVbxJBRQ9div+T4i/NItja
	Wg1iYeUHgv40qj5A8h26RsQv17IG6ZiN4qT8v8XPhBpGzpRhU6C2ahr+GB6YzGcyqgZH8QkwNLa
	vYmyr4VrVmLrvXP6ch+8aEgfeLeB4h3yOPEOBi7crXuH8aOVUIhbqdZVu
X-Received: by 2002:a05:6871:3a24:b0:3e7:dea2:9607 with SMTP id 586e51a60fabf-3ecbbc38ee1mr719989fac.11.1763711772043;
        Thu, 20 Nov 2025 23:56:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuJnVGss4AC1dURESEaj+hVS8QGPRKiI0PbaZyLcDXBM9cxrwkCRas2nW38BCf5o39zQyqrw==
X-Received: by 2002:a05:6871:3a24:b0:3e7:dea2:9607 with SMTP id 586e51a60fabf-3ecbbc38ee1mr719976fac.11.1763711771646;
        Thu, 20 Nov 2025 23:56:11 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dcfe28csm2347744fac.22.2025.11.20.23.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:56:11 -0800 (PST)
Date: Thu, 20 Nov 2025 23:56:08 -0800
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
Message-ID: <aSAbGBJHkam5282L@hu-qianyu-lv.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=WeUBqkhX c=1 sm=1 tr=0 ts=69201b1c cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8BFNsxKPdyf3tXGkzS8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: qAPlJ2VIG5augLsDw4CllvX8lFADsofc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA2MCBTYWx0ZWRfX4Uo/0ggfSigJ
 3w0qObAhztSA/abJ80C3t9rqA0DVTjFc6u64UXxRgibwxcf7d89L+e6uoeCEi6kPWIaNrQwLD3K
 m3jEmuLX2b03oX6xiqGXuPtKP8cbjOs48S6bb7Qqzq1gghufbpwjNd0qHmiSJeIpqA4cs9mxAKw
 wmm5HbaZ1cfbVUrLpy3UEbhw+WBpRN+VAnErve/IDRIMGih/aLEoYH/YRdPgYx53IS+HlCjJJag
 2Lo3UzOkLZU9klZf4K8Eern2JdoDrTh8bAv9PQ0wEVF58kpgHcuVm1uhuCKl6UC1e1PJZ+UAGnC
 uJMlemB5pX+jacjyX1kETlgmxa+k0Ti25cm1jokSrrQCfYsO1S9aR9N8SrLkfS2GTOjsMJoH0jL
 eMBG8GO57FTSEfq8wSgTAlRjBQP2uw==
X-Proofpoint-ORIG-GUID: qAPlJ2VIG5augLsDw4CllvX8lFADsofc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210060

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
Okay, let me check with internal team, will update.

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

