Return-Path: <linux-pci+bounces-17707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AB9E47AA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3754918805A0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E85193404;
	Wed,  4 Dec 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZA2ZicY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927D2391AF;
	Wed,  4 Dec 2024 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350636; cv=none; b=VV+y/EjH3MPz0T94hRBZOP4e3mWBBk00N5aP+06jNu4yv8iIWYwfX1BkOqTkdA4ryy6bjIjDGlfYbuWXUxUjVWP3quETaWAtgGDHyRBC+dolalUv0WY8UgeWOOTneyQIGLcG6+NKeX7BjEp/Pn8O6OYXySDELVng+xmMbrQaUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350636; c=relaxed/simple;
	bh=Fl90+AqVZ9g5FdLJ8/BupUsex03x1wVTP97T4Uaj06M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kSOFscB684evXKPw4itFO6FMSphkq7TGs7ic2SOzCytddGW4VNBVNrLSwnEIACMWm3qZ+SXeKloDhs7JSodSis64IPl0EXpWPiK82IjRUAh3XrZMlB1uNGERcRB3JboRJsWHGlbrBtX5O7BbiZ0R0ZWaRUWBb0MZfyx59oZ2fGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZA2ZicY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50552C4CECD;
	Wed,  4 Dec 2024 22:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733350635;
	bh=Fl90+AqVZ9g5FdLJ8/BupUsex03x1wVTP97T4Uaj06M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GZA2ZicYA8xRMEjiQ04uuo75ZOxXfKrYkkUF8KjRSQmaHqvPoNLt+kqYAP7inAZiv
	 cfmvV3KlqCI26nDtl6rm8+eTMqQwrfHzwB4+ymcYoaNLdIgABTg9A/AVw8WOxgfZgm
	 VC3pWBrMS3Ksawh1GjFMQbbiF0f63haVVuWMLV20JWUBlAMKEsyD/QbWFGQdyFi5XE
	 CzpGOpDfFF7E3Ff5+LUG8h6FkOXfgI8siyzWEjg/LtatIfBy3B2Ry/Y+RHYA3gFon1
	 iXYrRJyjg5qnYM/pqI5PVKlAjROPhGBJY73DyUOf+zsLXTxqWcUOg3JI56sKj4T+Qm
	 tSSFTIkK1GShg==
Date: Wed, 4 Dec 2024 16:17:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com, mmareddy@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <20241204221714.GA3023492@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b42e1ec7-11a0-ab6b-c552-86d204dcb041@quicinc.com>

On Wed, Dec 04, 2024 at 07:45:29AM +0530, Krishna Chaitanya Chundru wrote:
> On 12/4/2024 12:25 AM, Bjorn Helgaas wrote:
> > On Sun, Nov 17, 2024 at 03:30:19AM +0530, Krishna chaitanya chundru wrote:
> > > The current implementation requires iATU for every configuration
> > > space access which increases latency & cpu utilization.
> > > 
> > > Configuring iATU in config shift mode enables ECAM feature to access the
> > > config space, which avoids iATU configuration for every config access.

> > > +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct dw_pcie_ob_atu_cfg atu = {0};
> > > +	struct resource_entry *bus;
> > > +	int ret, bus_range_max;
> > > +
> > > +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> > > +
> > > +	/*
> > > +	 * Bus 1 config space needs type 0 atu configuration
> > > +	 * Remaining buses need type 1 atu configuration
> > 
> > I'm confused about the bus numbering; you refer to "bus 1" and "bus
> > 2".  Is bus 1 the root bus, i.e., the primary bus of a Root Port?
> > 
> > The root bus number would typically be 0, not 1, and is sometimes
> > programmable.  I don't know how the DesignWare core works, but since
> > you have "bus" here, referring to "bus 1" and "bus 2" here seems
> > overly specific.
> > 
> root bus is bus 0 and we don't need any iATU configuration for it as
> its config space is accessible from the system memory, for usp port of
> the switch or the direct the endpoint i.e bus 1 we need to send
> Configuration Type 0 requests and for other buses we need to send
> Configuration Type 1 requests this is as per PCIe spec, I will try to
> include PCIe spec details in next patch.

I understand the Type 0/Type 1 differences.  The question is whether
the root bus number is hard-wired to 0.

I don't think specifying "bus 1" really adds anything.  The point is
that we need Type 0 accesses for anything directly below a Root Port
(regardless of what the RP's secondary bus number is), and Type 1 for
things deeper.

When DWC supports multiple Root Ports in a Root Complex, they will not
all have a secondary bus number of 1.

Bjorn

