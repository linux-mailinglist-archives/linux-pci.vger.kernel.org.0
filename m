Return-Path: <linux-pci+bounces-3730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83485A58B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 15:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB362857C4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7699364AD;
	Mon, 19 Feb 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjaQAxSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B62E419
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352032; cv=none; b=IGC+geGx27A/14V6KBbNhx4+1gYCdmode63zutbAt6XN0u2J8oHK6j9Cvn+oWiEX5m4OLG1Ry/l52Ges4+9yF+hWKNIdDQUXKnW+an5jK7qirDO7+Xruuw9VjfedR82TYdcMEW1sqhbvSiu5lifnpfZ3nkKRyYCZtfome5YH2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352032; c=relaxed/simple;
	bh=x3XahZP2P6sjAaGseOhzbGD88QCyeoY8Zjanu0Fy6gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzZiymqfQrGIYlDXqDdWOd6mlONx9I6Tcm6bMJZUV/UauYDpdUsOJsYrRg6CCnpJqVsZjm6AJKSq/tjDqkDoeI3hUZfDtguqaxFoH5JVbSGscLFaZvopBSJxekBLQLcx5OwxWTnkpHMwCBoK0XkiHTwJ8FzWbmYQwL0bLy+F4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GjaQAxSe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a31b90edcso31482451cf.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708352030; x=1708956830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqaONtfofwIyhOcUouHJ9XwD5btDKUHsUP+4nmTWuKc=;
        b=GjaQAxSehXiBqls4tPZtVy+yMl+O+spar/41jvnBegabQzm5Eb8XkL2y7YojuIFvBM
         3x5Y1U4ftA7UtoSMN0MY3ILCGzW3Q+T/DTs2RuFrcrlpZdpLKdKGVf81IzMBoGDhzevL
         kCXUpOAQnvQiT0Asu/WrCSDgxf7q1HA4+MvIWMNuOsPiMoPx09N+kR0ksukLfI7KVAlY
         O6qgrLVLO03aNJIJNNPaherWFBPD3wmueglU3+Hmh7l9hc08CaTjQKUOIESictEs0N5H
         0EzrVPJSBWxrmAPKaT5fAbBNPS5uaUeNvENtv1YHSegoYan7cY0RSZMI/N1o7ImS/jga
         j5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352030; x=1708956830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqaONtfofwIyhOcUouHJ9XwD5btDKUHsUP+4nmTWuKc=;
        b=SIr2X5DYO/czDhm/zajUAKR+vU4km+QV3nSz7dPOW33oGVT8KKQAcsA1fD9XRbu3dG
         f7rHC0+y0+JDkrO3rSmfLcnI2tzYl3OWCosfZoSwZKOJ4zxO3IsCfpXkJojcVvhTi2UG
         VlLB3geO0qvRcJ5QFPFM1/Fm+B7n0xN31MP6cWHrvEIAEV1tA0v7XxCtgq3cjFWv47MU
         7yStEhqzypyLvOqr+9vK6ezSlPL412tV5o9KoHGskMfgEIVysl74AvCo+nO936oqABn/
         A5sj/zSk1dEJKk1K2zkdeIumwfY73YQ3fmKLPy8G3+WdTt8dkuzbc1o+iPizPem7p3S+
         +b/w==
X-Forwarded-Encrypted: i=1; AJvYcCU/Lr2D8X9zBw8V9yX32mp1KIdVWvttBbdZCllFm0pp67+KqsyYk8uBW1dZuLKyPma2xIvAw0FSuDuX8oGG66z5/cbf3iosbeo6
X-Gm-Message-State: AOJu0YzSaBTbrvZdsJggFBSNGGaKCkR3iIsf3gGd/DnERHUjpSYX/cF9
	INkQ1a8E9OlL21CnhNC39oWdzxqXspzr+YQ4/WbeO5Id176OGtvvYBZNgMrT0A==
X-Google-Smtp-Source: AGHT+IGBAkDL+Pu6U5GTS4s671FesCWaebH0kXYGs308nbIqu3TReIpd8RYvcfJib18AnTSFapwMjA==
X-Received: by 2002:ac8:59c9:0:b0:42e:696:2016 with SMTP id f9-20020ac859c9000000b0042e06962016mr5030194qtf.17.1708352030004;
        Mon, 19 Feb 2024 06:13:50 -0800 (PST)
Received: from thinkpad ([117.248.7.166])
        by smtp.gmail.com with ESMTPSA id ka1-20020a05622a440100b0042dd9164ec4sm2588243qtb.54.2024.02.19.06.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 06:13:49 -0800 (PST)
Date: Mon, 19 Feb 2024 19:43:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240219141341.GD3281@thinkpad>
References: <20240215140908.GA3619@thinkpad>
 <20240217000723.GA1294711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217000723.GA1294711@bhelgaas>

On Fri, Feb 16, 2024 at 06:07:23PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 07:39:08PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 14, 2024 at 04:02:28PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > > ...
> > > 
> > > > ... And for your usecase, allowing the controller driver to
> > > > start the link post boot just because a device on your Pixel
> > > > phone comes up later is not a good argument. You _should_not_
> > > > define the behavior of a controller driver based on one
> > > > platform, it is really a bad design.
> > > 
> > > I haven't followed the entire discussion, and I don't know much
> > > about the specifics of Ajay's situation, but from the controller
> > > driver's point of view, shouldn't a device coming up later look
> > > like a normal hot-add?
> > 
> > Yes, but most of the form factors that these drivers work with do
> > not support native hotplug. So users have to rescan the bus through
> > sysfs.
> > 
> > > I think most drivers are designed with the assumption that
> > > Endpoints are present and powered up at the time of host
> > > controller probe, which seems a little stronger than necessary.
> > 
> > Most of the drivers work with endpoints that are fixed in the board
> > design (like M.2), so the endpoints would be up when the controller
> > probes.
> >
> > > I think the host controller probe should initialize the Root Port
> > > such that its LTSSM enters the Detect state, and that much should
> > > be basically straight-line code with no waiting.  If no Endpoint
> > > is attached, i.e., "the slot is empty", it would be nice if the
> > > probe could then complete immediately without waiting at all.
> > 
> > Atleast on Qcom platforms, the LTSSM would be in "Detect" state even
> > if no endpoints are found during probe. Then once an endpoint comes
> > up later, link training happens and user can rescan the bus through
> > sysfs.
> 
> Can the hardware tell us when the link state changes?  If so, we
> should be able to scan the bus automatically without the need for
> sysfs.  For example, if the Root Port advertised PCI_EXP_FLAGS_SLOT, 
> we might be able to use a Data Link Layer State Changed interrupt to
> scan the bus via pciehp when the Endpoint is powered up, even if the
> Endpoint is actually soldered down and not physically hot-pluggable.
> 

I don't think the state change interrupt is generated on Qcom platforms. I will
check with the hw team and reply back.

As a reply to my earlier question on requiring 1s delay for waiting for the link
to come up during boot:

PCIe spec r5, sec 6.6.1 says:

"Unless Readiness Notifications mechanisms are used, the Root Complex and/or
system software must allow at least 1.0 s after a Conventional Reset of a
device, before determining that the device is broken if it fails to return
a Successful Completion status for a valid Configuration Request. This period is
independent of how quickly Link training completes."

So this might be the reason. If so, I don't see a way to avoid the delay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

