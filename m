Return-Path: <linux-pci+bounces-39822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE69C20FDF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DCD18910AA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF633644BD;
	Thu, 30 Oct 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nleKMoCV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0141990A7;
	Thu, 30 Oct 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838756; cv=none; b=KndHoHJbxsQQ7lo5yMqD2t+1oovhq3s0nh4L26j+0ZNJGOuFlH7GF57KLfikSQ2g4bHcUWCH8pHcZa+4kYt51Ufgce8z2ywajdpFoYHSBTNjPGgGPHwxpEoiT2Ls6j3Dedrg3UphHcYIy6InAXj+WLgHsZjxleJlKJCrr/BtPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838756; c=relaxed/simple;
	bh=ek0IzzttXXx97qNT2h1xklMaf1xglphbe0kKLIhYhN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=em5Jri69zrBQVwEnuO7kXjkwVVZjMCq7o6WvfYbVrsWJxPQ1w9bslZyf8LVwo+ZoMQucmNZvYdSuxHezyoTVup55gV0XNer907lGuXzURIA3o3q5JgjOFlnTLZbjOX1NKIgfSbP/OeF7P66kwtIbcU2a6w3JgAexQAQIMorj4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nleKMoCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7E4C4CEF1;
	Thu, 30 Oct 2025 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761838756;
	bh=ek0IzzttXXx97qNT2h1xklMaf1xglphbe0kKLIhYhN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nleKMoCV/yk0BtnlIzx2I86cr3HqnGJCU2jCbp9S0N/Q/Sb8AY040g42QhifNtB8Z
	 udiMRHAA0R8lBIhjvOVioR2YzQFLaGzXZ5dBAAhrCBor4d9fALEU1V4A4qV8rnRdEq
	 hP0KMwy8FhR5ib1gdGtUvhOpN+eHx9fT0K9XJtrFhb+fVmFC8Elq8IuEFMvQzBKIew
	 QKFOZ3tVdkiCBLZ6ZaLIOd7pOt6K+mygmbGAtJ7KwZ3oBH8c24H2QJBS45eYZMwFyC
	 0zolbfs49T4uyRqBOcIkUj/9tq1+KJte6+ls+ftCku+3nWF1ALDRaetliGcVLmOyYm
	 WYCCxgN+u+CRQ==
Date: Thu, 30 Oct 2025 10:39:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, amitk@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	jorge.ramirez@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <lumag@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
Message-ID: <20251030153914.GA1632785@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dccca2d-272f-451a-9e38-901a6fa3a24c@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 09:13:29AM +0530, Krishna Chaitanya Chundru wrote:
> On 10/30/2025 4:53 AM, Bjorn Helgaas wrote:
> > On Wed, Oct 29, 2025 at 04:59:53PM +0530, Krishna Chaitanya Chundru wrote:
> > > TC9563 is the PCIe switch which has one upstream and three downstream
> > > ports. To one of the downstream ports ethernet MAC is connected as endpoint
> > > device. Other two downstream ports are supposed to connect to external
> > > device. One Host can connect to TC956x by upstream port.
> > > 
> > > TC9563 switch power is controlled by the GPIO's. After powering on
> > > the switch will immediately participate in the link training. if the
> > > host is also ready by that time PCIe link will established.
> > > 
> > > The TC9563 needs to configured certain parameters like de-emphasis,
> > > disable unused port etc before link is established.
> > > 
> > > As the controller starts link training before the probe of pwrctl driver,
> > > the PCIe link may come up as soon as we power on the switch. Due to this
> > > configuring the switch itself through i2c will not have any effect as
> > > this configuration needs to done before link training. To avoid this
> > > introduce two functions in pci_ops to start_link() & stop_link() which
> > > will disable the link training if the PCIe link is not up yet.
> > > 
> > > This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
> > What does this series apply to?  It doesn't apply cleanly to v6.18-rc1
> > (the normal base for topic branches) or v6.18-rc3 or pci/next.
>
> I sent this on top of rc3 as we have some dependencies with latest changes
> i.e ecam changes in dwc driver.

Oops, sorry, my fault.  I must have been trying to apply the v6 series
(not this v7) on -rc3.  This v7 *does* apply cleanly to -rc3.

But all the other topic branches are based on -rc1, so I think the
best thing is to make this one apply on -rc1 as well, and I will deal
with the resulting conflicts when merging into pci/next and ultimately
into Linus's tree.

Bjorn

