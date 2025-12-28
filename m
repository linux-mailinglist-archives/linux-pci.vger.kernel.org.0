Return-Path: <linux-pci+bounces-43768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E7CE49AC
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 08:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 547A2300E786
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA542A1BF;
	Sun, 28 Dec 2025 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ekdtKJUm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evcoLezI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111582594B9
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766905364; cv=none; b=JZpHBiuHVPtpERq+lwuve6oyUT9qzjSa7OhnYyKc73Nyzb9V49XUMN/hvLiciGzfkKcGkGXg2U6ObiOwYmhBXoFxpmGTtsm/BAQ9/1W0iw5fu4YCGKvIZF2K3rI1c/WYFQOo5WXG13B7Y5nOcYtqHUduJmbUMun1/26USDhNU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766905364; c=relaxed/simple;
	bh=kb+veMitUkGZucSxKLI+utjfCapexAaExo9EQ7NU5AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhCfaw5GHr6G9/tQrsxZW8QZRiiddUeqIFbu3RW+wWVi+m4uPVh4pWDOFzf8kULxRFHtvLILUPnGX/S4S2seFOoWtI5pgASGkDoGaffaqSSOk8rMbUN1Vee/etPfjOe3D6e/dDjTSB5O3D5ZB75rGW4WHX/vMh8L+fdXlNNAE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ekdtKJUm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evcoLezI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BS3Z1aH3317204
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 07:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KZf5LmCYmxOG5r73vNe68pIQX0bbymxZl3p48gSKIyQ=; b=ekdtKJUmh/AgZQmQ
	KHrtK5+R2hZgj1XGGNk7C0Nqjr/mAOswg18lTBJetjaZLEl548kmlzDVAQQ2Znwf
	G4pYJS/hxaT8X4y/5W/scP2DzFcSTp+TyxFQWTgPXx4a8v4BLrbo3dQqlxG6OEhW
	fx8B5OEmn7YE4jgAhOig8bzGwaKaX/q6u/clUY4DSCwaFSuXVZLVbi00CQjP50my
	kZ0P/YDGUDBtXqm0VNWbxQKxNGld4riwzdDVkZEqz61eL7MCf7ckLsOfLGrdFgxz
	MXKmpiRzhNdN9pXm8GcVhPNtqDbD16Fe+1jXtSjHHT63xSlcp+EuHol62xdNhYP4
	Lbp3ZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj07sn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 07:02:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a07fa318fdso158662425ad.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766905360; x=1767510160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZf5LmCYmxOG5r73vNe68pIQX0bbymxZl3p48gSKIyQ=;
        b=evcoLezI4NDWhXlp5Ir8yHTwJRAJvU7OCaMEZU1mLIEOt2oYiOCQeZTG/5Z0GE3W2c
         zJZ1fX+txWxaCoZUHqz4k509fgxMsFX12V27E059r61z3HYZ1J4dLlnR43QF34pQspTV
         Y1xGZ5TfXdkYVK/O/EZE/niyQJpFsnFV52F00czEu7wpR9Mt+wb9MTBtP/WPb+8ebzns
         Y2tPDlmaHh8U+DfaiqakowSXoS8eVliMrRDosKCWttyIjfhijPkxj8xB+63Iif7Jf8zc
         /MYzKwPOthbjP12/zGIp6N+Xg2ffG05vYxa+1w9dMGzeB2ywLOP+Gu9lIu3PFQNdhUzx
         vp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766905360; x=1767510160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZf5LmCYmxOG5r73vNe68pIQX0bbymxZl3p48gSKIyQ=;
        b=lsnz5FaRIoVp92i5UJCohwhgQ4Hsw3KoqHzloHgk75U7FIGr4U+sMUQ4uCr1x2OwTl
         ezLI9VCzRhIpKLuW0vzg934IE/uNjdpaEyc8zxD01GA0PbPqq6LM+VgjPG5wxYtOzfUr
         Tp6qpzuJdYu23vmzjNKlNdx9gYOuFv+UvxkkOzehk+szuseZfjgdwKRYRVX14BobKrcV
         Ne4/24rR/LcsbYwqcZK9zOmDgad2l73UhNygjPGIc8gfzbJ4efegDUynCn/lfPLxnNEg
         Yp1X6rn9Omb2ElkIRC4mDkZA9JD0hDL6nUxi8AuU5e2auT1DWkJGskrZ9oAR8Z8P7BmN
         SzMg==
X-Forwarded-Encrypted: i=1; AJvYcCVjb1KjZyKYgDuQ70T8TgqJI0KCXV61RG/aCjyKMoXcu8Tozo0qZOnSgCKwhaT9+q6hoeiKpyGX6kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcoNjRo7OS7ZgKJ7WJvnhMonRqKYHkm7l2fpyskIzXOqG7hMN
	jbISFVDVxCdOwPbuFxiA7ev1rp/xDbXdl3S0H8AboeRPt1H8oXuwdrk8RT8G6V96nRsE17cqogo
	RJ86gMU9k4x3IqeaYuvtrsnUlnwIUrBFCVgKk+EsgKGntTAyVslGr8zO1ooeKE8k=
X-Gm-Gg: AY/fxX7K2p/VCJw5XX2Nj9Ya3a/JQcKRNbZBs4GDc+hP3OfRV/qz4gGi3sjuSR6qWPL
	jgthZgGPIrE7nWsADgbinO33CXMY79yOtF/J+tTdWAp8wpVobxWAZLuoJ2Gnw6v5xIrt6uOAqnJ
	0SEfZHJMVMVagdNuLXwaTC1wIXSfaagzuCbcNqmM06ejxaGDyXn/WxpvbJOJDCNaYlhVpbUYX21
	C3kw8e7VOMPwRvnmShnwu20CNRDpWPCuvzC9mvD88UNBAUFqrLMwbSH0T8u5prP3cVFVu+KpcgV
	LhW0tbFIdC+scXhDz1XyazNtymGeKcV1SbKLT7j5YeVbzbwUNFze9cWNmgDJx00mYR6g8MHA72U
	ehjc1MjQ8HC54U0sEQehijYgO7GnfIg5XTHKf3EJXsetCGU4Mn4EU4mT3
X-Received: by 2002:a05:7022:3f06:b0:11d:f44c:afc6 with SMTP id a92af1059eb24-121722b842amr22584620c88.15.1766905360361;
        Sat, 27 Dec 2025 23:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSuBRh+x/1t2TJaXLScFus1sMNpi+N6PUoXPzyRfSBJ5Cla2/z09dzZ0QgBDWTgW+ajXzxYA==
X-Received: by 2002:a05:7022:3f06:b0:11d:f44c:afc6 with SMTP id a92af1059eb24-121722b842amr22584602c88.15.1766905359727;
        Sat, 27 Dec 2025 23:02:39 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm105546648c88.17.2025.12.27.23.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 23:02:39 -0800 (PST)
Date: Sat, 27 Dec 2025 23:02:37 -0800
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Message-ID: <aVDWDaiR11RGKBuX@hu-qianyu-lv.qualcomm.com>
References: <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
 <20251226213123.GA4141314@bhelgaas>
 <dua64cg42sduzzjp623o4c72etyqtei6txk57kwbqerpa5ketz@x4cs5fjlervu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dua64cg42sduzzjp623o4c72etyqtei6txk57kwbqerpa5ketz@x4cs5fjlervu>
X-Proofpoint-ORIG-GUID: -I9CTHiolkf0-bLeEl-mQr4G33SxvY9u
X-Proofpoint-GUID: -I9CTHiolkf0-bLeEl-mQr4G33SxvY9u
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=6950d611 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rvI9OrrfPYhO3Jog6jQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDA2MCBTYWx0ZWRfX3/LOU/c+eNA/
 6JHwcMIApqP6kzKJ2myFKtvCxpo11oBARwEtzWXHFJFQ9+WkAMTgij9nTufME5N6IxU2sjZU2uP
 f4ljQIVeDLd0Iyuls/S3CJ5tTY1Npeli2kryvrG+EyOmM6OFa6ovUwHRqXI88M6LvlPyO3xNXx0
 LZfdfv52F1ySo210YD9D0asJ+hjNOiZzwmMtX6A7Yoz/OfQZ0Hh/raSvvx9oZP/oGD+53G+jAAv
 7MhfcQYhbCA6jsUk7bZ6WRARKOArR5Tr+0/Iu3cQQxdEgbdgtnX/1EAwBoTPMoDHeI5gtgrLPrF
 eN2qRqcZOI1+AixBABqbGPfb1wJfGS8GiLEMTXbnW1lOYxKYmWCikJvdtTzji4rJ6rEHBpcKA/H
 mcdeJxUkO8TBxYJCG8kSD/74Vm06RQien+Skl1nejpr7nBlggmu6+w6kxYtPG26nQvDZNHZTv7f
 dtFakztdON1tQwYB1RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280060

On Sat, Dec 27, 2025 at 10:51:26AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 26, 2025 at 03:31:23PM -0600, Bjorn Helgaas wrote:
> > In subject, s/MSIX/MSI-X/ to match spec and other usage.
> > 
> > On Sun, Nov 09, 2025 at 10:59:42PM -0800, Qiang Yu wrote:
> > > Some platforms may not support ITS (Interrupt Translation Service) and
> > > MBI (Message Based Interrupt), or there are not enough available empty SPI
> > > lines for MBI, in which case the msi-map and msi-parent property will not
> > > be provided in device tree node. For those cases, the DWC PCIe driver
> > > defaults to using the iMSI-RX module as MSI controller. However, due to
> > > DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
> > > when MSI is properly configured and supported as iMSI-RX will only monitor
> > > and intercept incoming MSI TLPs from PCIe link, but the memory write
> > > generated by Root Port are internal system bus transactions instead of
> > > PCIe TLPs, so they are ignored.
> > > 
> > > This leads to interrupts such as PME, AER from the Root Port not received
> > > on the host and the users have to resort to workarounds such as passing
> > > "pcie_pme=nomsi" cmdline parameter.
> > 
> > This will be great, thanks a lot for working on this.  This has been a
> > long-standing irritation with this DWC IP.
> > 
> > > To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
> > > from Root Ports when using iMSI-RX as MSI controller, which is indicated
> > > by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
> > > eliminating the need for manual kernel command line workarounds.
> > > 
> > > With this behavior:
> > > - Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
> > >   components.
> > > - Platforms without ITS/MBI support fall back to INTx for Root Ports and
> > >   use iMSI-RX for other PCI devices.
> > > 
> > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >  
> > >  	dw_pcie_dbi_ro_wr_dis(pci);
> > >  
> > > +	/*
> > > +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
> > > +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
> > > +	 * interrupt handling.
> > > +	 */
> > > +	if (pp->has_msi_ctrl) {
> > > +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> > > +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
> > > +	}
> > 
> > "has_msi_ctrl" doesn't seem like a good name here because there's no
> > documentation about what it means, and "has_msi_ctrl" is completely
> > generic while "iMSI-RX" is very specific.
> > 
> 
> This predates my involvement with DWC drivers, but I guess it expands to 'has
> internal MSI controller' and 'internal' probably means iMSI-RX. But I agree that
> the naming could be improved to something like 'imsi_rx_available' or
> 'has_imsi_rx'. I'll take a stab at it in a separate patch.
> 
> > And apparently platforms with ITS/MBI *can* generate MSIs from Root
> > Ports, but "has_msi_ctrl" would be false for them?  This is really
> > hard to read.
> > 
> 
> Yes.
> 
> > pp->has_msi_ctrl is set by qcom_pcie_ecam_host_init() and IIUC, for
> > any platform that lacks .msi_init() and the "msi-parent" and "msi-map"
> > properties.
> > 
> > The qcom_pcie_ecam_host_init() case is weird because it looks like it
> > abuses the pci_ecam_ops.init() callback to initialize MSI stuff, not
> > ECAM stuff.  Maybe that MSI init could be done in qcom_pcie_probe()
> > right after it calls pci_host_common_ecam_create()?
> > 
> 
> I think it should be possible to initialize MSI after
> pci_host_common_ecam_create(). Let me fix *this* and above in a separate series.

The qcom_pcie_ecam_host_init() is used by firmware-managed targets and the 
function unconditionally sets has_msi_ctrl = true without checking for 
"msi-parent" or "msi-map" properties in the device tree. So I think
firmware should take care of removing MSI/MSIX cap.

- Qiang Yu
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

