Return-Path: <linux-pci+bounces-4531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886788725FE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4583128ADDF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46771182DF;
	Tue,  5 Mar 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKB5D2GP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182531863C;
	Tue,  5 Mar 2024 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661069; cv=none; b=pSOFjdk5RMg6onzAOQGTqM/jGgEWs9Br1ENIh/olQXG1Epas792oqsuT/tB1DoOLKxgHcChH7WeNMWYogPUpn15OjoAZrGXQVxMFCtjN5y2oQ7fAD8At0Gbbw6Z0qMF7Z8v41lWHS5d/kcvNKWOtKZilh/wX4WN2oit0CIwVlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661069; c=relaxed/simple;
	bh=i3sj+3QUUkb8LDWhJ8xja55O9dd546/LpAv+OJKYYSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WL+q247difErRyccds4PyRrssjZRZrgEcQyxf0gFNNwO0QzqQMN83N9Grk7KJGcza9u7JulARlwrpnXAGln8ZeNgHAjzZqZd62apR78rjC9F92sG+mYSylG/mb0UtY/3uAYzyI2aCLOUN2SMaYT3+ZFeZwleUGVNKEsL6QFQMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKB5D2GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990D9C433C7;
	Tue,  5 Mar 2024 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709661068;
	bh=i3sj+3QUUkb8LDWhJ8xja55O9dd546/LpAv+OJKYYSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MKB5D2GP1NSseE/csFxyOIwBe3jzJ47A+UDe6QrBkf888ziwxeza6b6QLb2Kqy9tj
	 /j+aZZ7hGNpAqxY8GDiZIdwN3lKskqN+D+1JitxxV3IppynlbynfMEvaqs+R76Iv67
	 C1ddcoDWTndj5sZjVSY0NioMyxkalw/qglh2pImcLcat6gA4cP2iv2ptxyNVCGVmjH
	 L7mZWN+9z6o3bFER3brBCo4N6hwcbCMymFU3Gn5QQmdbLEyCl38bl5U6X0UyLj6qpO
	 vOm8vGA+fb18aUNhbyTLUMwXM9B9qxJn4iaXZLJ9dKE8vJnuOnbYv0jvMQhyEYjtgm
	 hyD3YbP3rn55Q==
Date: Tue, 5 Mar 2024 11:51:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240305175107.GA539676@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305162537.GA8339@thinkpad>

On Tue, Mar 05, 2024 at 09:55:37PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 22, 2024 at 10:40:52AM +0100, Lukas Wunner wrote:
> > On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
> > >   1) D3hot doesn't work per spec.  This sounds like a hardware
> > >      defect in the device that should be a quirk based on
> > >      Vendor/Device ID, not something in DT.  I don't actually know if
> > >      this is common, although there are several existing quirks that
> > >      mention issues with D3.
> > 
> > My recollection is that putting Root Ports into D3hot on older x86
> > systems would raise MCEs, which is why pci_bridge_d3_possible() only
> > allows D3hot in cases which are known to work (e.g. Thunderbolt
> > controllers, machines with a recent BIOS).  It was a conservative
> > policy chosen to avoid regressions.
> 
> So pci_bridge_d3_possible() is only checking for D3hot capability?
> If so, I'd rename it to pci_bridge_d3hot_possible() and also
> 'bridge_d3' to 'bridge_d3hot' to make it explicit.

Every device is required to support D3hot (and D3cold), so I think
"d3_possible" and "d3hot_possible" are not very descriptive since they
should always be *possible*.

pci_bridge_d3_possible() seems to be more about whether hotplug and
power management events work in D3hot and maybe some firmware
coordination and validation concerns.

> Since the default value of 'd3cold_allowed' is true, I believe the
> code expects all devices to support D0 and D3cold. Please correct me
> if I'm wrong.

D3cold means "no main power", so every device "supports" that
situation.  The only time 'd3cold_allowed' can be false is when a user
has set it to false via sysfs, so I think it only reflects an
administrative policy choice.

I think the important question for the code is whether software can
remove and restore main power and maybe something about what hotplug
events or PME can be reported, and I have a really hard time following
that decision path.

Bjorn

