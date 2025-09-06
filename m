Return-Path: <linux-pci+bounces-35611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CDBB470CA
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053165A262E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED531F460B;
	Sat,  6 Sep 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wx5nFcnw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B110E0
	for <linux-pci@vger.kernel.org>; Sat,  6 Sep 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169667; cv=none; b=q4z1d38OUm9IinM56fCx2YE672t4xfurknCsa4F0I0HGMafxZVOuwqHBZ4VpItQ6NPDOmeFc3NrmFFNJqRU+rznhfP5iUB00BEt/BHklIkJE+uwvtAYQUKSjjpMRhAK1PNYSlQxdLmAo+UlE0hxay0A9DLueoxrYG7swjf6t9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169667; c=relaxed/simple;
	bh=XVgpzLUHjsqFPq3VSy5wZE6Wo0ZyA4QviALcYF7rVDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQkp6jcTw1IMxgGnyM5vjbTF0tysOBfeSSd18trc3mkaligzHb9Y1923673GRiERcXEc0/9w3XKrBG/l6LMcl8blkM9TdFwQUPE91X5rhX0AU7ZJWNxvHwdZ+prdpAkgK68FRLYDwfSfXJxYg5JVUXNU1cF1uArXJGE1fGZEdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wx5nFcnw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5869ahpU001550
	for <linux-pci@vger.kernel.org>; Sat, 6 Sep 2025 14:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p1AJNMYOACnHat6lQ30ApXkdKwpIkMu/q+NgZkD0nLg=; b=Wx5nFcnwYH34RHIm
	vz/y+KHFImYXx+DRQjBBUwpSgiBSTuHe/E6WnGkuMYYgQmulU4NVGzEBKXVuxlCg
	zpt4iwoH7+TrR7ZMGv/bYbpsvHAR0m/qi/LEirW5emxKPmPx0d/QJ8JcyxUdKnJh
	IossnynHevxByYUtSmxtrcwVZ7wXBWNroCX50smgnIoesq40mQPtBiuDenRGQkLn
	9gsO02Errg+++PhqPc3UiuZdvBRWNU2L6J7LUCeRpOJ4MevXOV7uuKoQjbFY/1NR
	SVff5T9l4pDACr1uHK3p+2rjlZ+eugVHiJulqv7XmweVmtXrPjp7FwBVGBYwygff
	vw3BRw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d638rdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 06 Sep 2025 14:41:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24c9e2213f8so39398885ad.2
        for <linux-pci@vger.kernel.org>; Sat, 06 Sep 2025 07:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757169664; x=1757774464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1AJNMYOACnHat6lQ30ApXkdKwpIkMu/q+NgZkD0nLg=;
        b=FWkCtRliJzLWFqJYCV0gYhUxh95ZDPv4Ee5IZFCn7OKZk1rIoreWWq7sQwur6wz7qt
         gA1PLTJo4j3XwlL6YovZQ9egFCAgIYjya3ok/toAjlni9SshvtfI6D1J7SNrffk180pg
         nJSTM5RmoKV1zcxQOwfdiDe0FeWHoERijT8Se7bdpVnT8HdAwYTJjLMoMHILw2BpCUEB
         SAcJmr/UPDjB+ywnvs0InvWcEdnO8oREjmklnfGcrAKNGWsZQ4Wvni5psB5cWiW2KzHh
         vV65kU/yZ6Zs4lii+99V9OH5a+WtKXv5C1mrgDeNC49iwJO1rwH5O+eub1TrsZKaYLC1
         +t5g==
X-Forwarded-Encrypted: i=1; AJvYcCUwJGz6JUGDhVcdG0X6zw5/a28U3Vs78gV0ezh4+nbEDFj5TMfRthOY7NxGonJzG+GZtLAF0TGyAx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRR5iC8Ui5HQH/kqx8aj89AeOT3s/Vio4uLdJm7vGPpg86/Tqe
	4LR+vOTA6p4sVfupAo7QrWFEGAjqiz+kI7CRSFWRCrhJLEutz4Kc0rF5DH3s7jy2LLQ4TiR/u2a
	gvDd3NN8C8DZQAwV/jaR9CjCObSqgCU3XCW4JwKCpxQp/ZOscKBlZ0iMGOom4ep0=
X-Gm-Gg: ASbGncuWctrVQEL5YL31ZWjk795Nwmqk2VXVbokEHECdsRn6MCE0pe+Jo/C/zHau0RQ
	zqgnKus8JMNjajbjXmWcFIHYDILdKdysnf8ZvzmTy2icKmj3JNhSFlEUQEShzE/EFkzHiWquaBK
	wMilnPq/TwEOzDAmKoMRWMAbpVCqJpqk6EfunFmpFcz17KxEUKfmmGbxhBqXUAlOSdNtAv1ffUA
	inSaM/A1Bk7HGXraqEs9BQVyzDuVgvpkinZ3i8na/TLlHbCfmzXAbsk3vNedpNZuCJ3RiDoYe/3
	zzYl5RYw+YpKHJbFWCuL0snRmxtFT3fs5aRWNLNnnI+TrT9t83UEUPA=
X-Received: by 2002:a17:903:1a67:b0:24c:786a:d7ac with SMTP id d9443c01a7336-25172b4992dmr32392945ad.47.1757169663576;
        Sat, 06 Sep 2025 07:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvC3hrjUHowMh4j/UTPBilKN7zhsjIJE+eKTb2MZvtaoTX2TSU5oKo1aO4zCwdo0bPJRSGXQ==
X-Received: by 2002:a17:903:1a67:b0:24c:786a:d7ac with SMTP id d9443c01a7336-25172b4992dmr32392495ad.47.1757169662968;
        Sat, 06 Sep 2025 07:41:02 -0700 (PDT)
Received: from work ([120.60.77.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cd5092951sm64065285ad.18.2025.09.06.07.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:41:02 -0700 (PDT)
Date: Sat, 6 Sep 2025 20:10:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Brian Norris <briannorris@chromium.org>, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/5] PCI: qcom: Wait for PCIE_RESET_CONFIG_WAIT_MS
 after PERST# deassert
Message-ID: <5vqicxeaqdljsahpsddrfcwrkqdoszq3k5ziw4kurqfwwwbjje@ynyzteelkiw4>
References: <20250903-pci-pwrctrl-perst-v2-1-2d461ed0e061@oss.qualcomm.com>
 <20250905224430.GA1325412@bhelgaas>
 <7kmf767g4jelftwbbvikk6h3tclkih3t5zrkffeyfjuy2qe3uw@tok2rpim6f7d>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7kmf767g4jelftwbbvikk6h3tclkih3t5zrkffeyfjuy2qe3uw@tok2rpim6f7d>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfXyr27Ao/9jZOy
 QK2HfhgCfPk2+lWjmlsUmxXCIG+WYVhyw87/wRK269wLBDDHhfwU8B+PwMqimzdVjUlFQhDOEMH
 qLWdh7QcYPG8ToJpnaMmbc6h6dm2A4tqwJom4NI+CuZ5+nznP20frI/Gl/mDU8Ozgdm1rVMacod
 EGUAt90spgPg7v0JP2KSGYLAJEaAo/ZJusan3Cqxkdre7/+jB7cLb1QnVXQJtn8XGWmDFXHoDR4
 HrGo+4xl6B7eosjIW4dAewb2hA0uaxLWdufgtqm8RTxtgeoDvuxif6h9i94wH/wkwXlsrPywGFM
 iaSE+CJJQQTfQUnC4jQp3JlZpk8nskQJwB6FQMrv9yqGxtabe0wpdSWsCNliY4LQsm03eloLW57
 GJM/G9HW
X-Proofpoint-GUID: SRqETSm2Cmx8jgyEiRVsThy-uuji3Dlz
X-Proofpoint-ORIG-GUID: SRqETSm2Cmx8jgyEiRVsThy-uuji3Dlz
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68bc4800 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=z2tU9dNso2TEGt+FTYZWDQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gin1pDFbZLjaKAFN3YwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

On Sat, Sep 06, 2025 at 04:13:08PM GMT, Manivannan Sadhasivam wrote:
> On Fri, Sep 05, 2025 at 05:44:30PM GMT, Bjorn Helgaas wrote:
> > On Wed, Sep 03, 2025 at 12:43:23PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > PCIe spec r6.0, sec 6.6.1 mandates waiting for 100ms before deasserting
> > > PERST# if the downstream port does not support Link speeds greater than
> > > 5.0 GT/s.
> > 
> > I guess you mean we need to wait 100ms *after* deasserting PERST#?
> > 
> 
> Right, that's a typo.
> 
> > I.e., this wait before sending config requests to a downstream device:
> > 
> >   ◦ With a Downstream Port that does not support Link speeds greater
> >     than 5.0 GT/s, software must wait a minimum of 100 ms following
> >     exit from a Conventional Reset before sending a Configuration
> >     Request to the device immediately below that Port.
> > 
> > > But in practice, this delay seem to be required irrespective of
> > > the supported link speed as it gives the endpoints enough time to
> > > initialize.
> > 
> > Saying "but in practice ... seems to be required" suggests that the
> > spec requirement isn't actually enough.  But the spec does say the
> > 100ms delay before config requests is required for all link speeds.
> > The difference is when we start that timer: for 5 GT/s or slower it
> > starts at exit from Conventional Reset; for faster than 5 GT/s it
> > starts when link training completes.
> > 
> > > Hence, add the delay by reusing the PCIE_RESET_CONFIG_WAIT_MS definition if
> > > the linkup_irq is not supported. If the linkup_irq is supported, the driver
> > > already waits for 100ms in the IRQ handler post link up.
> > 
> > I didn't look into this, but I wondered whether it's possible to miss
> > the interrupt, especially the first time during probe.
> > 
> 
> No, it is not. Since, the controller reinitializes itself during probe() and it
> starts LTSSM. So once link up happens, this IRQ will be triggered.
> 
> > > Also, remove the redundant comment for PCIE_T_PVPERL_MS. Finally, the
> > > PERST_DELAY_US sleep can be moved to PERST# assert where it should be.
> > 
> > Unless this PERST_DELAY_US move is logically part of the
> > PCIE_RESET_CONFIG_WAIT_MS change, putting it in a separate patch would
> > make *this* patch easier to read.
> > 
> > > Cc: stable+noautosel@kernel.org # non-trivial dependency
> > > Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..bcd080315d70e64eafdefd852740fe07df3dbe75 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -302,20 +302,22 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> > >  	else
> > >  		list_for_each_entry(port, &pcie->ports, list)
> > >  			gpiod_set_value_cansleep(port->reset, val);
> > > -
> > > -	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> > >  }
> > >  
> > >  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> > >  {
> > >  	qcom_perst_assert(pcie, true);
> > > +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> > >  }
> > >  
> > >  static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> > >  {
> > > -	/* Ensure that PERST has been asserted for at least 100 ms */
> > > +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> > > +
> > >  	msleep(PCIE_T_PVPERL_MS);
> > >  	qcom_perst_assert(pcie, false);
> > > +	if (!pp->use_linkup_irq)
> > > +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > 
> > I'm a little confused about why you test pp->use_linkup_irq here
> > instead of testing the max supported link speed.  And I'm not positive
> > that this is the right place, at least at this point in the series.
> > 
> 
> Because, pci->max_link_speed used to only cache the value of the
> 'max-link-speed' DT property. But I totally forgot that I changed that behavior
> to cache the max supported link speed of the Root Port with commit:
> 19a69cbd9d43 ("PCI: dwc: Always cache the maximum link speed value in
> dw_pcie::max_link_speed")
> 
> So yes, I should've been using 'pci->max_link_speed' here.
> 
> > At this point, qcom_ep_reset_deassert() is only used by
> > qcom_pcie_host_init(), so the flow is like this:
> > 
> >   qcom_pcie_probe
> >     irq = platform_get_irq_byname_optional(pdev, "global")
> >     if (irq > 0)
> >       pp->use_linkup_irq = true
> >     dw_pcie_host_init
> >       pp->ops->init
> >         qcom_pcie_host_init                         # .init
> >           qcom_ep_reset_deassert                    # <--
> >  +          if (!pp->use_linkup_irq)
> >  +            msleep(PCIE_RESET_CONFIG_WAIT_MS)     # 100ms
> >       if (!dw_pcie_link_up(pci))
> >         dw_pcie_start_link
> >       if (!pp->use_linkup_irq)
> >         dw_pcie_wait_for_link
> >           for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++)
> >             if (dw_pcie_link_up(pci))
> >               break
> >             msleep(PCIE_LINK_WAIT_SLEEP_MS)         # 90ms
> >           if (pci->max_link_speed > 2)              # > 5.0 GT/s
> >             msleep(PCIE_RESET_CONFIG_WAIT_MS)       # 100ms
> > 
> > For slow links (<= 5 GT/s), it's possible that the link comes up
> > before we even call dw_pcie_link_up() the first time, which would mean
> > we really don't wait at all.
> > 
> > My guess is that most links wouldn't come up that fast but *would*
> > come up within 90ms.  Even in that case, we wouldn't quite meet the
> > spec 100ms requirement.
> > 
> > I wonder if dw_pcie_wait_for_link() should look more like this:
> > 
> >   dw_pcie_wait_for_link
> >     if (pci->max_link_speed <= 2)                   # <= 5.0 GT/s
> >       msleep(PCIE_RESET_CONFIG_WAIT_MS)         dw_pcie_wait_for_link    # 100ms
> > 
> >     for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++)
> >       if (dw_pcie_link_up(pci))
> >         break;
> >       msleep(...)
> > 
> >     if (pci->max_link_speed > 2)                    # > 5.0 GT/s
> >       msleep(PCIE_RESET_CONFIG_WAIT_MS)             # 100ms
> > 
> > Then we'd definitely wait the required 100ms even for the slow links.
> > The retry loop could start with a much shorter interval and back off.
> > 
> 
> Your concerns are valid. I'll submit a separate series along with *this* patch
> to fix these. I don't think clubbing these with this series is a good idea.
> 

I think we missed one bigger issue:

As per r6.0, sec 6.6.1:

"Unless Readiness Notifications mechanisms are used, the Root Complex and/or
system software must allow at least 1.0 s following exit from a Conventional
Reset of a device, before determining that the device is broken if it fails to
return a Successful Completion status for a valid Configuration Request. This
period is independent of how quickly Link training completes."

So this clearly says that the software has to expect a successful completion
status for a valid configuration request sent to the device. But in
dw_pcie_link_up(), we are just waiting for the link training to be completed
by polling the controller specific 'Link Up' bit. And the spec also mentions
clearly that this delay is independent of how quickly the link training
completes.

So the 1.0 s delay doesn't seem to be applicable for link up. But in practice,
we do need to wait *some* time for the link to come up, but doesn't necessarily
1.0 s as mentioned in 6.6.1.

Also, if we go by the spec, we have to make sure that the controller drivers
poll for a successfull completion of a config request (like reading the VID)
of the device for 1.0 s. But how can we know where the device actually lives
in the downstream bus of the Root Port? I believe we cannot assume that the
device will always be in 0.0, or can we?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

