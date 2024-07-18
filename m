Return-Path: <linux-pci+bounces-10531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74117935138
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 19:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2141F22AEA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF3145359;
	Thu, 18 Jul 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJNiSVvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B49144306
	for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721323389; cv=none; b=LRfSiSvBx1FwGb4FHbXxQupmJVdACd8KGfc5B7y8ZwHfYfT41AQTAnHDl5M7wEfvXlBa784CMixjrZv1irDieiU92enrzJjQoTbzXcnlZDmHVbtHIQ9MjLG35f//f21eXkh3uyE8fXBffojf+nPxyFRD6aGLJ9IocqJvHrguAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721323389; c=relaxed/simple;
	bh=0i7KtJ9FSifVfJLTP8L6MmmzH1IONF8nR5XE9Ek8NnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6GEJQwXkq8Yd1cw1+T0aVbaEaLgniJj5cVUmr7rTK7aSuXWRDox9PHto0l5VqZGaOp5U/8Hp0X6pbi4CJUW7//KTle5zrsP3yM3BDRW6IwfEofnNB8ySVF4oJ6JFvfB5opvn12rXidkrMlICVYG3xbjnGv/FVn9WNZO+uhakZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJNiSVvY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc66fc35f2so5898445ad.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721323387; x=1721928187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ICFDDieCGpEoaZYDXXhvPh/cZNuguHANawunFSMXlc=;
        b=yJNiSVvYXGaKMDXOs618SvxsjDyKUPC2MVc3X36Wpl2m0Zj6WXd3gzC6iM4TLO+VBv
         PP/1Gc/tQqHb3THu4VmUsdlbdzIWmO+OBx47ZZpw9ycJwX+6kJ4vaZ6NCOuCk7JlWwVu
         +tmc6lkunSs5N8AZSLTiOe5+LMPI14Fw1KNDCU1Qa7qcHDTUYZjmkKDlvm71w26A9HAu
         prSUbsgJB94dI83Qmi1OirumiXr7OKBZiAmqaUB57tz6PkPEbEbj69Egab2Cmz3IouIM
         fD00D7px8Yb4Qlfz5PxBN3nXN6yuB4g7ybwRmZqWXvxXcWz6YVu3QCziZSxnX/I2Bkqm
         LqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721323387; x=1721928187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ICFDDieCGpEoaZYDXXhvPh/cZNuguHANawunFSMXlc=;
        b=DJjzcjZDC4YiNCQOtMPGiSWH9fgRCu1UCvM8O0hf9HFEDQEj147ohKM/65s5/aJQwd
         Dbn1N2S7AkOOSWbFo92EEQRfWPhNmCJg51/fPCZvNn9sNX8w0vfXfZnieZCjgFVEqHfb
         euhX0bhutAnDZdOJRJxU6ujIz6B4dU+Qh86a6KaMQ5OjUTTOTbXNgcMClz6ETXTj4l4Y
         GtGUA7Wk3HAGXsV4O1tvJ8cWc4QYAavNR9zpHA3tubeQhbQkGGxLnhGLfKOp7Xi18lW6
         wX7XriAmC1ZIVrwVUspUJedfEKsbjDggwIkwUeIcLnLPKHmzF0npH0WIN/3xyRCb6qdS
         fiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIOR11XoXpTY2m72kfxk5IfmiaQZ4sqBXrZaiPGJEkK1WWrsPGq3glGbtxYMQZO8+PNDBh7P20XtH1incWCeFs0xvRdvLRBjVJ
X-Gm-Message-State: AOJu0Yxb1g3D1VHTXXkoz+5i8tEcmT2I/MRGrTpA84mZ2jln62tqYikU
	lvzsLVdk/Io9KCw9xEH8m+6X6CK0qDKvj+Y0dwhkY9fnpd8BqqGTl4bYhvD6Mw==
X-Google-Smtp-Source: AGHT+IEKTF3lGFKsLnOuovg2GIq+pf1Ok3ICUV+brkwjfKlutwdQ6WVPpLajBng6U/Qw4CmZ5dJUQA==
X-Received: by 2002:a17:903:32c3:b0:1fc:54c4:61a7 with SMTP id d9443c01a7336-1fc5b60aa7bmr50154655ad.23.1721323387186;
        Thu, 18 Jul 2024 10:23:07 -0700 (PDT)
Received: from thinkpad ([120.56.207.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2751bsm96197055ad.143.2024.07.18.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 10:23:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:53:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/13] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Message-ID: <20240718172301.GC2499@thinkpad>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-12-71d304b817f8@linaro.org>
 <02b94a07-fcd6-4a48-bead-530b81c8a27e@quicinc.com>
 <20240718102938.GA8877@thinkpad>
 <8c3e77b6-0d23-42ef-a7db-52635bd5070a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c3e77b6-0d23-42ef-a7db-52635bd5070a@quicinc.com>

On Thu, Jul 18, 2024 at 10:15:58AM -0700, Mayank Rana wrote:
> Hi Mani
> 
> On 7/18/2024 3:29 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 17, 2024 at 03:57:11PM -0700, Mayank Rana wrote:
> > > Hi Mani
> > > 
> > > I don't think we can suggest that usage of link up event with Global IRQ as
> > > simulate PCIe hotplug. hotplug is referring to allow handling of both
> > > add or remove of endpoint device whereas here you are using global IRQ as
> > > last step to rescan bus if endpoint is power up later after link training is
> > > initiated.
> > > 
> > 
> > Why not? Well it is not entirely the standard 'hotplug' and that's why I
> > referred it as 'simulating hotplug'.
> Because it is misleading here by saying simulate hotplug. You can mention as
> use link up event
> to rescan bus instead of using simulate PCIe hotplug here.
> 

Fair point. Will reword in v3.

> > The point of having this feature is to avoid the hassle of rescanning the bus
> > manually when the devices are connected to this bus post boot.
> > 
> > > Will this work if you remove endpoint device and add it back again ?
> > > 
> > 
> > No, not currently. But we could add that logic using LINK_DOWN event. Though,
> > when the device comes back again, it will not get enumerated successfully due to
> > a bug in the link training part (which I plan to address later). But this
> > issue is irrespective of this hotplug simulation.
> ok. Although LINK DOWN event not necessary suggests that endpoint has been
> removed but it also suggests that link has gone into bad state, and it is
> being detected and notified as link down event.

Right, but what would be the recovery process if Link down event happens? You'd
remove the device and insert it back, right?

Doing link training again won't bring the link back I guess.

> > > Regards,
> > > Mayank
> > > On 7/17/2024 10:03 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > Historically, Qcom PCIe RC controllers lack standard hotplug support. So
> > > > when an endpoint is attached to the SoC, users have to rescan the bus
> > > > manually to enumerate the device. But this can be avoided by simulating the
> > > > PCIe hotplug using Qcom specific way.
> > > > 
> > > > Qcom PCIe RC controllers are capable of generating the 'global' SPI
> > > > interrupt to the host CPUs. The device driver can use this event to
> > > > identify events such as PCIe link specific events, safety events etc...
> > > > 
> > > > One such event is the PCIe Link up event generated when an endpoint is
> > > > detected on the bus and the Link is 'up'. This event can be used to
> > > > simulate the PCIe hotplug in the Qcom SoCs.
> > > > 
> > > > So add support for capturing the PCIe Link up event using the 'global'
> > > > interrupt in the driver. Once the Link up event is received, the bus
> > > > underneath the host bridge is scanned to enumerate PCIe endpoint devices,
> > > > thus simulating hotplug.
> > > > 
> > > > All of the Qcom SoCs have only one rootport per controller instance. So
> > > > only a single 'Link up' event is generated for the PCIe controller.
> > > > 
> > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >    drivers/pci/controller/dwc/pcie-qcom.c | 55 +++++++++++++++++++++++++++++++++-
> > > >    1 file changed, 54 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 0180edf3310e..a1d678fe7fa5 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[...]

> > > > +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> > > > +{
> > > > +	struct qcom_pcie *pcie = data;
> > > > +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> > > > +	struct device *dev = pcie->pci->dev;
> > > > +	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
> > > > +
> > > > +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
> > > > +
> > > > +	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> > > > +		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> > > > +		/* Rescan the bus to enumerate endpoint devices */
> > > > +		pci_lock_rescan_remove();
> > > > +		pci_rescan_bus(pp->bridge->bus);
> > > > +		pci_unlock_rescan_remove();
> > > How do you handle case where endpoint is already enumerated, and seeing link
> > > up event in parallel or later ? will it go ahead to rescan bus again here ?
> > > 
> > 
> > If the endpoint is already enumerated, there will be no Link up event. Unless
> > the controller reinitializes the bus (which is the current behavior).
> > 
> > If the endpoint is already powered on during controller probe, then it will be
> > enumerated during dw_pcie_host_init() and since we register the IRQ handler
> > afterwards, there will be no Link up in that case.
> > 
> > This feature is only applicable for endpoints that comes up post boot.
> ok. thanks for above information. I feel capturing this information in
> commit text
> would be helpful.

Sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

