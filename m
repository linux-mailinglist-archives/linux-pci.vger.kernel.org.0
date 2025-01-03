Return-Path: <linux-pci+bounces-19248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF16A00D37
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 18:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD247A031A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABABA59B71;
	Fri,  3 Jan 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT9+QmNa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7F11CA0;
	Fri,  3 Jan 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926597; cv=none; b=aO8Om6fNdORjgYHSUk7+VJZTKEvavPpOppd3YaZiJpkaTZwUsjScq2P8D/XeRv9lbvv+3YFEf5nr5MTSQ63DgDjPXSzkZGnFOFsxf2XBt815vL68Gz3puSVLHxcITDZfgsflk3AeEFKT/ZXtfhrP2TUogronZIoxv+vAl5aCxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926597; c=relaxed/simple;
	bh=GMFRac5OMIqXJmIVXjqHqaCXz5gJCdrMqXQ6ezJ20CM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TkDOLBwBdqHtPPfXnQ3GsX2O2TSldQbUjWfP5pG/+MjuCoX6s8ByuqU3B81/YTaTLZs6/zRx57SNfQwOb8McEfNEFr6mvrdqKWhq+DZCYtwm6Dtq+XfGO3WJ1tYsakxUZ94xBtTcrHaA3j2ZKjnkdSoKyL88Co0UmW5zGBsE0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT9+QmNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A8C4CECE;
	Fri,  3 Jan 2025 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926597;
	bh=GMFRac5OMIqXJmIVXjqHqaCXz5gJCdrMqXQ6ezJ20CM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tT9+QmNayF8rZgpwUgIKfMfDsmIv4iXFVG5sXsHI8xi4teFJc8aaAnxh8hdf+1ev0
	 SwPQaxZS1bBIzF0f+XKUos4rAV95AgVwDu8BgTWdJnxE2yD7IEr/lwoIMSngUP9qgd
	 RcQPIVdM+d8S++clm6M4OPmWVUZMHsp7Hz2W2wlF1ksqehW+4pfTYKoXR2TYMKT03d
	 MPv1U51duXN05JOXUwDt2g50dK8fW2mDSFJv+0GGj4HkdhMHx7UjyznGO2PHXmQ7gr
	 16UUXNIirhybRlk0HO3kHl+vCD3hXhBbXZqx06HiFQmHXLPX2FVi4f7306gG7522yA
	 gzjQT7CrYq9Og==
Date: Fri, 3 Jan 2025 11:49:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <20250103174955.GA4182381@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3dAvgO3XEUaJfq_@google.com>

On Thu, Jan 02, 2025 at 05:43:26PM -0800, Brian Norris wrote:
> On Mon, Dec 30, 2024 at 10:41:45PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 15, 2024 at 02:12:16PM -0700, Brian Norris wrote:
> > > From: Brian Norris <briannorris@google.com>
> > > 
> > > Per Synopsis's documentation, the msi_ctrl_int signal is
> > > level-triggered, not edge-triggered.
> > 
> > Could you please quote the spec reference?
> 
> From the reference manual for msi_ctrl_int:
> 
>   "Asserted when an MSI interrupt is pending. De-asserted when there is
>   no MSI interrupt pending.
>   ...
>   Active State: High (level)"
> 
> The reference manual also points at the databook for more info. One
> relevant excerpt from the databook:
> 
>   "When any status bit remains set, then msi_ctrl_int remains asserted.
>   The interrupt status register provides a status bit for up to 32
>   interrupt vectors per Endpoint. When the decoded interrupt vector is
>   enabled but is masked, then the controller sets the corresponding bit
>   in interrupt status register but the it does not assert the top-level
>   controller output msi_ctrl_int.

"the it" might be a transcription error?

> That's essentially a prose description of level-triggering, plus
> 32-vector multiplexing and masking.
> 
> Did you want a v2 with this included, or did you just want it noted
> here?

I think a v2 with citations (spec name, revision, section number)
would be helpful.  Including these quotes as well would be fine with
me.

> (Side note: I think it doesn't really matter that much whether we use
> the 'level' or 'edge' variant handlers here, at least if the parent
> interrupt is configured correctly as level-triggered. We're not actually
> in danger of a level-triggered interrupt flood or similar issue.)
> 
> Brian

