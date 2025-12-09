Return-Path: <linux-pci+bounces-42840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8812CAFEAA
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 13:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6E4D3020C0E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B122B5A3;
	Tue,  9 Dec 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ejd+ybzd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbGzCe/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D527380A
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283213; cv=none; b=nspAerOB+MVrFV6drE1UG8fLArhADDAoDppEGeD/RcVscKFSo58Xp8EVx4+q1EdbDmj9Xyxwh7o0XZPZfUW+2KhByWPmZz542XeP86bCKWgqrMWopWTP9aAZEPKrepv+wEvDlBVntcpsp1yOBSgwQFNcUmuXTAMyS71AWeJ2FAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283213; c=relaxed/simple;
	bh=GqSi+NaSjOAdoK1lVehDB9WsVKqDCJlJaZjK1aY0QcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrH+BiFdFQcakpUddFBcdbfS0NJO2dpUMc7+7ng7K9EtOPPmlvp4BGAAGQO4ZzFv9oXx020+nsmxv8FyNNV59n64cLWL5sYyRr3eIHXfcB0zqZP52xkRRgfeldZY64YAOTBBaCDppJ+sQE+8g9LgJJBJd1E3JDPDLs+CcWyb11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ejd+ybzd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbGzCe/h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B99NCIT3259550
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2025 12:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2PEpJk7IgU38zacFTiky2AJlaJYCwvwEw4p4GRx4/Z8=; b=Ejd+ybzdy2CVfvXW
	9O3TvHMuaMXlXI59V5I2+mzBB618rnLnFgamUIbkesHb+5IiaGl4FwkODNPhtBoD
	QAZiHKxRzLSGTUlzQj8Cs93dalulwpV/8804d3SSOckWIRHpwDNfvkVyTJRvblkD
	5nkHutQd8rab2M/CaWPh9DWrm92cr9xQsBp5/PQtw09pl73pFbCm8HoHtgpiS+W2
	BC7v25UwhDW9sbUSKgI+BXvInZO8Rn1s5Th2YJDZp+VkghK7gCEBYAOJr+GYzrc0
	0g0HV/Q8/jIQGKcDJPvNCBLXiIVonhLh1e+i7Ve1M0V/26HuWUiInkJmR26PC4LT
	Go6k9g==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axgqprm9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 12:26:50 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-3ec31d72794so12046891fac.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765283209; x=1765888009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PEpJk7IgU38zacFTiky2AJlaJYCwvwEw4p4GRx4/Z8=;
        b=LbGzCe/hs7vImFkAfljeVz7Osb5tVjwg2gIkfKAteu5k1k/n+ghDQYu2EujA+cl1U5
         79KJrQNXTxNnU/mXfPr/nBN6ORdeJqegCxKBXAOz8+RBBDmRswwbl0MwzclMS685HuYT
         +bw1nZ9dCm9pen2qQXs+nDQT/VoRflKm1dkOp8u9e7GoO7kU7U2JSJGtgGTkNiBbGk+R
         q2pgrI6eOtgvHVO24/jobpsoN9vhVa8X+swqkI50KkuJZycSXlibexTQKqiphTCXcIbo
         9+bEmZVon0QCZD7MEgZBMpLf2/kh+mzwoB244TF6D+oMMEx/EP3jq5v7G+KOtIMV1jw/
         fasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765283209; x=1765888009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2PEpJk7IgU38zacFTiky2AJlaJYCwvwEw4p4GRx4/Z8=;
        b=lNco69QSbnPz1p2yZwtWr+Z/PCzPOZs1hd61Nupdx1BnTNw3gYTLF3GmrQ1SAhfh7g
         klV1kcgYF0I+5zKREFg/fzCMJSU9yKk0h1hTahY+PHTY1MnuayxYT/J7mlV3T/lfgVld
         ckCNfmKssUIp4Pc0DopjlVm4dfoVzcaj4f75AjH1oqNPsOOQnUetHLqFL6JApz73KtJr
         B6kXXxIpSfftKJTsh+Su79YFkxAAB/wL2+9BWoumKzeMdtW7zHke0aoVjcyUhxhPTgjn
         Ly/6GUIBdmwRz/ODHpCLOvvQ8t1nT+lx3vbPrDQbZx3tWUVK2xMaNlK/4WIfxMm8YY2M
         bSmA==
X-Forwarded-Encrypted: i=1; AJvYcCXokW/SKpWTM8GHXVrdmnNLita7Pw/PnDhCGX6znC+Kw3aYt+cWlzV5HKgSyw4E1Xxh3mQHR5vcqbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxoF6RAcAjBevYpFc3BXhSsCPUMuGM1+OU0xUqhcdtYY1SRkB
	cPl3D1aAzKB+glEUaHrbcTIEPnK4dX0lw6a+5QsCmSM/6pZj1fP8XmYtnpbeL72mJCvra+CWkSc
	Q0k/ojxBmLqnL+iNX463MaQWymTiMrA9j/w6FwyIZZjKnMaktYPBSiUYklwtA5aDrfdky4wKUyX
	RhaM7to/foMYiZhn2eWx6s7xeWE9F6G2uK8VnO8g==
X-Gm-Gg: ASbGncuJAT+bHrIoRZ4AzHUU1Vu3rEftRVZj8LlHzMOyqEHft/MNX10i/2lcq+c6GWI
	w5crjAIbcjxDmrNNqFyfZqt6VAvdXpSnYRaSrAZ4R9t0PnNMOcBfji/LwK4ObMgVH9a+Kz5rxAA
	963rra/YHPsq45ge9A1AxPmBYTR6EYaja/YT8Iz2zUPqwfZL8p6viowNObCqMUYMm9z74=
X-Received: by 2002:a05:6820:2ad1:b0:659:879c:2d74 with SMTP id 006d021491bc7-65b2329b2a6mr415141eaf.3.1765283209260;
        Tue, 09 Dec 2025 04:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMGguuvYpx7a5HSZbu4KJD0pLAsLmgHb+0LYXmTqzA/6VGKRMBsF94bf32Fys7QOsNpWfOyhWhTO5xQUogNi0=
X-Received: by 2002:a05:6820:2ad1:b0:659:879c:2d74 with SMTP id
 006d021491bc7-65b2329b2a6mr415134eaf.3.1765283208844; Tue, 09 Dec 2025
 04:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
 <20251203-firmware_managed_ep-v1-2-295977600fa5@oss.qualcomm.com> <gpheliezabdbqpip2d4opfsu7zdfvltifrovtf3dz5bri4vefu@cuklytg4t6if>
In-Reply-To: <gpheliezabdbqpip2d4opfsu7zdfvltifrovtf3dz5bri4vefu@cuklytg4t6if>
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 17:56:36 +0530
X-Gm-Features: AQt7F2oBy2NpzBl3GgDuLDRWfLORDYP9tXJz-wP53weUXRpuytzDTxINTnHzzTA
Message-ID: <CAMyL0qNQa1HuLE3F+rtk6YAKvthbzMKLmE+it_K7BT12vt86tA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KMhXzVFo c=1 sm=1 tr=0 ts=6938158a cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GkPVL_tSjSO2TbYxaJsA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-GUID: EOr1ND5xqo11FxdN6NZvikGsuaSMYCyp
X-Proofpoint-ORIG-GUID: EOr1ND5xqo11FxdN6NZvikGsuaSMYCyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA4OSBTYWx0ZWRfXwH/qenbfEqcG
 vaPdhmK96fwYE+IRJW5VIS1bSDsWoU8ycyFUwuY3mbtzODrM9nEZ4J4U6F76Uc4VG2Y/LNgfCd9
 IBkEjOsgkx/hCJUhh3XZktJL5jFcJiIrvUCy33Nadl5BcmTMOSsHGK63LcfkYK5g7xvnkeGDObP
 sYGQEv+rkX04cSyb6PYY/GkQB1k+sEFoBFtt+rZ7Y2DzDzQZ21YFu2Vhbm4G1jLQb8XEDteQFfe
 obc26R6r4+FbpSA88AHqYEvNxFZ9w/Eo6mBDxM4upRec3YE4wsAtaG5IfmdQqErcInJq5HAUiQ9
 n3nyqpNB4hn72XQg+4S0lyonhESf8/SPYlZvvWaJ5AlCSJhD5vFhukl4lR2Xydwms9Hx7i6N7Uv
 zdeu4x+M4zungh8UwZBxLStcTaGQFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090089

On Sat, Dec 6, 2025 at 2:27=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> On Wed, Dec 03, 2025 at 06:56:48PM +0530, Mrinmay Sarkar wrote:
> > Some Qualcomm platforms use firmware to manage PCIe resources such as
> > clocks, resets, and PHY through the SCMI interface. In these cases,
> > the Linux driver should not perform resource enable or disable
> > operations directly. Additionally, runtime PM support has been enabled
> > to ensure proper power state transitions.
> >
> > This commit introduces a `firmware_managed` flag in the Endpoint
> > configuration structure. When set, the driver skips resource handling
> > and uses generic runtime PM calls to let firmware do resource managemen=
t.
> >
> > A new compatible string is added for SA8255P platforms where firmware
> > manages resources.
> >
> > Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 80 +++++++++++++++++++++++=
+-------
> >  1 file changed, 64 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/co=
ntroller/dwc/pcie-qcom-ep.c
> > index f1bc0ac81a928b928ab3f8cc7bf82558fc430474..38358c9fa7ab32fd36efcea=
0a42c52f1f86a523a 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -168,11 +168,13 @@ enum qcom_pcie_ep_link_status {
> >   * @hdma_support: HDMA support on this SoC
> >   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable ca=
che snooping
> >   * @disable_mhi_ram_parity_check: Disable MHI RAM data parity error ch=
eck
> > + * @firmware_managed: Set if the Endpoint controller is firmware manag=
ed
> >   */
> >  struct qcom_pcie_ep_cfg {
> >       bool hdma_support;
> >       bool override_no_snoop;
> >       bool disable_mhi_ram_parity_check;
> > +     bool firmware_managed;
> >  };
> >
> >  /**
> > @@ -377,6 +379,15 @@ static int qcom_pcie_enable_resources(struct qcom_=
pcie_ep *pcie_ep)
> >
> >  static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
> >  {
> > +     struct device *dev =3D pcie_ep->pci.dev;
> > +     int ret;
> > +
> > +     ret =3D pm_runtime_put_sync(dev);
>
> What's the benefit of waiting for the put to finish? (i.e. why _sync)
>
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to disable endpoint device: %d\n", r=
et);
> > +             return;
>
> For some reason the pm_runtime_put_sync() failed, so the device's state
> is going to remain active. But you prevented the resources below from
> being disabled - without returning an error, so nobody knows.
>
> So now the phy refcount etc will be wrong.
>

Thanks Bjorn for the review.
I think we can use pm_runtime_put() as we should disable resources
even if it fails.

> > +     }
> > +

And I will add a check here as we don't need below for the
firmware_managed case.

> >       icc_set_bw(pcie_ep->icc_mem, 0, 0);
> >       phy_power_off(pcie_ep->phy);
> >       phy_exit(pcie_ep->phy);
> > @@ -390,12 +401,22 @@ static int qcom_pcie_perst_deassert(struct dw_pci=
e *pci)
> >       u32 val, offset;
> >       int ret;
> >
> > -     ret =3D qcom_pcie_enable_resources(pcie_ep);
> > -     if (ret) {
> > -             dev_err(dev, "Failed to enable resources: %d\n", ret);
> > +     ret =3D pm_runtime_get_sync(dev);
>
> You're missing necessary error handling for pm_runtime_get_sync(), use
> pm_runtime_resume_and_get() instead.
>

Yes, we can use pm_runtime_resume_and_get() here as it will handle
errors safely.

> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to enable endpoint device: %d\n", re=
t);
> >               return ret;
> >       }
> >
> > +     /* Enable resources if Endpoint controller is not firmware-manage=
d */
> > +     if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
> > +             ret =3D qcom_pcie_enable_resources(pcie_ep);
>
> Now that you're moving the driver to adequately get and put the RPM
> state, can't you move the explicit resource management to pm_ops as
> well?

Actually we are planning to enable runtime pm_ops in a separate series.
We will be taking care of this in that series.

>
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to enable resources: %d\n", =
ret);
> > +                     pm_runtime_put_sync(dev);
> > +                     return ret;
> > +             }
> > +     }
> > +
> >       /* Perform cleanup that requires refclk */
> >       pci_epc_deinit_notify(pci->ep.epc);
> >       dw_pcie_ep_cleanup(&pci->ep);
> > @@ -630,16 +651,6 @@ static int qcom_pcie_ep_get_resources(struct platf=
orm_device *pdev,
> >               return ret;
> >       }
> >
> > -     pcie_ep->num_clks =3D devm_clk_bulk_get_all(dev, &pcie_ep->clks);
> > -     if (pcie_ep->num_clks < 0) {
> > -             dev_err(dev, "Failed to get clocks\n");
> > -             return pcie_ep->num_clks;
> > -     }
> > -
> > -     pcie_ep->core_reset =3D devm_reset_control_get_exclusive(dev, "co=
re");
> > -     if (IS_ERR(pcie_ep->core_reset))
> > -             return PTR_ERR(pcie_ep->core_reset);
> > -
> >       pcie_ep->reset =3D devm_gpiod_get(dev, "reset", GPIOD_IN);
> >       if (IS_ERR(pcie_ep->reset))
> >               return PTR_ERR(pcie_ep->reset);
> > @@ -652,9 +663,22 @@ static int qcom_pcie_ep_get_resources(struct platf=
orm_device *pdev,
> >       if (IS_ERR(pcie_ep->phy))
> >               ret =3D PTR_ERR(pcie_ep->phy);
> >
> > -     pcie_ep->icc_mem =3D devm_of_icc_get(dev, "pcie-mem");
> > -     if (IS_ERR(pcie_ep->icc_mem))
> > -             ret =3D PTR_ERR(pcie_ep->icc_mem);
> > +     /* Populate resources if Endpoint controller is not firmware-mana=
ged */
> > +     if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
> > +             pcie_ep->num_clks =3D devm_clk_bulk_get_all(dev, &pcie_ep=
->clks);
> > +             if (pcie_ep->num_clks < 0) {
> > +                     dev_err(dev, "Failed to get clocks\n");
> > +                     return pcie_ep->num_clks;
> > +             }
> > +
> > +             pcie_ep->core_reset =3D devm_reset_control_get_exclusive(=
dev, "core");
> > +             if (IS_ERR(pcie_ep->core_reset))
> > +                     return PTR_ERR(pcie_ep->core_reset);
> > +
> > +             pcie_ep->icc_mem =3D devm_of_icc_get(dev, "pcie-mem");
> > +             if (IS_ERR(pcie_ep->icc_mem))
> > +                     ret =3D PTR_ERR(pcie_ep->icc_mem);
> > +     }
> >
> >       return ret;
> >  }
> > @@ -874,6 +898,16 @@ static int qcom_pcie_ep_probe(struct platform_devi=
ce *pdev)
> >
> >       platform_set_drvdata(pdev, pcie_ep);
> >
> > +     pm_runtime_set_active(dev);
> > +     ret =3D devm_pm_runtime_enable(dev);
> > +     if (ret)
> > +             return ret;
> > +     ret =3D pm_runtime_get_sync(dev);
>
> As the device is already active, this will just bump the reference count
> and return. I think the correct way to write this is:
>
> pm_runtime_get_noresume(dev);
> pm_runtime_set_active(dev);
> pm_runtime_enable(dev);
>

Yes, here pm_runtime_get_sync() is just incrementing the usage_count
as the device is already active.
we can use pm_runtime_get_noresume() instead.

The reason I was using devm_pm_runtime_enable() is because it
automatically disables runtime PM
in case of probe failure. Please let  me know your thoughts on this.

>
> But to handle the non-fw-managed case, you probably want to just remove
> the pm_runtime_set_active() and keep the get_sync(), to allow the
> resources to be turned on, thus would though have to happen after you
> acquire the resources below.
>
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to enable endpoint device: %d\n", re=
t);
> > +             return ret;
> > +     }
> > +
> >       ret =3D qcom_pcie_ep_get_resources(pdev, pcie_ep);
> >       if (ret)
> >               return ret;
> > @@ -897,6 +931,12 @@ static int qcom_pcie_ep_probe(struct platform_devi=
ce *pdev)
> >       pcie_ep->debugfs =3D debugfs_create_dir(name, NULL);
> >       qcom_pcie_ep_init_debugfs(pcie_ep);
>
> This was last, because we don't care about failures. But now that you're
> adding a source of errors below, you need to remove these entries again
> if below fails (or keep the debugfs creation last).

I will move debugfs creation last.

Thanks,
Mrinmay

>
> >
> > +     ret =3D pm_runtime_put_sync(dev);
> > +     if (ret < 0) {
>
> I don't think this is adequately error handled.
>
> Regards,
> Bjorn
>
> > +             dev_err(dev, "Failed to disable endpoint device: %d\n", r=
et);
> > +             goto err_disable_irqs;
> > +     }
> > +
> >       return 0;
> >
> >  err_disable_irqs:
> > @@ -930,7 +970,15 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 =
=3D {
> >       .disable_mhi_ram_parity_check =3D true,
> >  };
> >
> > +static const struct qcom_pcie_ep_cfg cfg_1_34_0_fw_managed =3D {
> > +     .hdma_support =3D true,
> > +     .override_no_snoop =3D true,
> > +     .disable_mhi_ram_parity_check =3D true,
> > +     .firmware_managed =3D true,
> > +};
> > +
> >  static const struct of_device_id qcom_pcie_ep_match[] =3D {
> > +     { .compatible =3D "qcom,sa8255p-pcie-ep", .data =3D &cfg_1_34_0_f=
w_managed},
> >       { .compatible =3D "qcom,sa8775p-pcie-ep", .data =3D &cfg_1_34_0},
> >       { .compatible =3D "qcom,sdx55-pcie-ep", },
> >       { .compatible =3D "qcom,sm8450-pcie-ep", },
> >
> > --
> > 2.25.1
> >
> >

