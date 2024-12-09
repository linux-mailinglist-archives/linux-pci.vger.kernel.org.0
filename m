Return-Path: <linux-pci+bounces-17975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC49EA333
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 00:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF952827FD
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838A21505D;
	Mon,  9 Dec 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJSprN3B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54136197A8F;
	Mon,  9 Dec 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788532; cv=none; b=f8b7YoH9ZEnLeiYmDHxICNgZil2/fYI3tNJXE0c74JGuxL5QU/3e2v3/qTHZwyD89BNozf+WJ99qoOJV/nZp/JjgjV24VEop2FoVfSNDueaRx6M4+jDCoIPtc3lvvQYSTNlLzB3+L5qOMPoMl9ejSfnd7M1NbK0tMrldLQ6O4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788532; c=relaxed/simple;
	bh=CG06Lv7MHNV3x4UA2INq8o2HNvD8GFR6sCPVSGN6fsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=btyXaQ4faAfy3Aun23y8DQZxFK2OTuzNcPvyx5o6rVGS8NoYydWiMiMxc9SK1W9A7445K0SAkkiZGL+C8dUXbgWq64uaWN74PvbkjXlPDVXHqep4LtDJBJO+JzBPPEIu2EqYSPHP/4N91u0V8HOFu1/JbcF0/u2xAe0+HE4yzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJSprN3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD37C4CEE0;
	Mon,  9 Dec 2024 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733788531;
	bh=CG06Lv7MHNV3x4UA2INq8o2HNvD8GFR6sCPVSGN6fsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uJSprN3BCwn9frkpjNwK4Iq1wZPfr9xCZc6BSp3ncgGB+PuqHdudUAPo4Pc2oVaSm
	 m9N2N+UG34fJhYXV6yEVBKNITMjPW6MdDYazGlOBK6kf9RTAF/HNWOs1+mpmGLd8nz
	 SPAvukc0EtfjOx0jTwLsW57CPLCWJJXuM+SSByVRrjTTT5qjD79nqNrCU0Qvm9CAcs
	 eOWfIK1OqECAHyQrY+tYafaPJQpJzHgiGMBiMqjhe8HJ2HGvL88zLYd/sKzYnCD0jc
	 y9Aj8Gh5/CWzIHcOEX6G/SRk0GNtCaXxF6Anv8F73n4A1wmDYpZq7d1xCna2d3IOSB
	 l89X1V+aZslLQ==
Date: Mon, 9 Dec 2024 17:55:30 -0600
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
Message-ID: <20241209235530.GA3221939@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c9839d-c61e-3c2f-4d77-5e8813f3a9c8@quicinc.com>

On Mon, Dec 09, 2024 at 10:00:06AM +0530, Krishna Chaitanya Chundru wrote:
> On 12/5/2024 3:47 AM, Bjorn Helgaas wrote:
> > On Wed, Dec 04, 2024 at 07:45:29AM +0530, Krishna Chaitanya Chundru wrote:
> > > On 12/4/2024 12:25 AM, Bjorn Helgaas wrote:
> > > > On Sun, Nov 17, 2024 at 03:30:19AM +0530, Krishna chaitanya chundru wrote:
> > > > > The current implementation requires iATU for every configuration
> > > > > space access which increases latency & cpu utilization.
> > > > > 
> > > > > Configuring iATU in config shift mode enables ECAM feature to access the
> > > > > config space, which avoids iATU configuration for every config access.
> > 
> > > > > +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> > > > > +{
> > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct dw_pcie_ob_atu_cfg atu = {0};
> > > > > +	struct resource_entry *bus;
> > > > > +	int ret, bus_range_max;
> > > > > +
> > > > > +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> > > > > +
> > > > > +	/*
> > > > > +	 * Bus 1 config space needs type 0 atu configuration
> > > > > +	 * Remaining buses need type 1 atu configuration
> > > > 
> > > > I'm confused about the bus numbering; you refer to "bus 1" and "bus
> > > > 2".  Is bus 1 the root bus, i.e., the primary bus of a Root Port?
> > > > 
> > > > The root bus number would typically be 0, not 1, and is sometimes
> > > > programmable.  I don't know how the DesignWare core works, but since
> > > > you have "bus" here, referring to "bus 1" and "bus 2" here seems
> > > > overly specific.
> > > > 
> > > root bus is bus 0 and we don't need any iATU configuration for it as
> > > its config space is accessible from the system memory, for usp port of
> > > the switch or the direct the endpoint i.e bus 1 we need to send
> > > Configuration Type 0 requests and for other buses we need to send
> > > Configuration Type 1 requests this is as per PCIe spec, I will try to
> > > include PCIe spec details in next patch.
> > 
> > I understand the Type 0/Type 1 differences.  The question is whether
> > the root bus number is hard-wired to 0.
> > 
> It is not hard-wired to 0, we can configure it though bus-range property
>
> > I don't think specifying "bus 1" really adds anything.  The point is
> > that we need Type 0 accesses for anything directly below a Root Port
> > (regardless of what the RP's secondary bus number is), and Type 1 for
> > things deeper.
>
> I will update the comment without mentioning the buses as suggested.
>
> > When DWC supports multiple Root Ports in a Root Complex, they will not
> > all have a secondary bus number of 1.
>
> mostly they should be in bus number 0 with different device numbers, but
> it mostly depends upon the design, currently we don't have any multiple
> root ports.

Say "root bus" instead of "bus 0", since you said above that the root
bus number is configurable.

Root Ports should all have a *primary* bus number of the root bus, but
if there are multiple Root Ports, they will all have different
secondary bus numbers.

