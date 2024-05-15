Return-Path: <linux-pci+bounces-7527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8B8C6CC9
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03D02847F7
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034203C466;
	Wed, 15 May 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd0OOavE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF573219F;
	Wed, 15 May 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801176; cv=none; b=sml3s/Q7vBq0CZPVYO0gWo8y7BYgk6/4STtPFhLIQnth0W0uRQJxVmfM6Zd/crF7OdZfdMJrnANJqmb0wPni8Bhl0+6Mkga31QVz60pK6hTKvJ8lt4bbtNOndxUcolhKb00zS79kPIOABN/vxvGGdpVCv59KkV2GrMJV6DQ5YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801176; c=relaxed/simple;
	bh=/uESMWzJ0qlSKrj7tTV6bA6iZEGcMmGLFrgFJNV8pRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tyYOnY0mMOgH/K6D4dAD/0N9BfpqJ4T/SzBwVKl2IFwqTDJSUYuTwiWDku+Uh+X7o08x0XhB70b1PjjFsjsNel9BXBJ1KxDC09D6INTLO2PX89xf/0M8Bb1fTJmSHKVUfko4VpHgZxGe0ZDJRbeZuYDdQxWRHuqgn8a0ljJtU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd0OOavE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B8C116B1;
	Wed, 15 May 2024 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715801176;
	bh=/uESMWzJ0qlSKrj7tTV6bA6iZEGcMmGLFrgFJNV8pRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rd0OOavEspsrXZCLoWfQd9F0nwYmVhee07cuGCr3AuSmzbAjut0BwGJXJ1bEGG5X/
	 PEhN/sIZxqYTUlj+2aeX5cHT5EKuoIeIS4ktf/z75viJF7glR0Jfor0zdMT1vV9uYT
	 mxQlAZbM02ILp/HEf3/Kb4DF7xVZ6nxuC04hOGs6Z3PYv4UICDFlR5oxIAbeU77wDu
	 1tl8P3gxgmi8BCm/ZAqs14E6/LS0jPq+aAuoPFA/iBPx3IpnsWZR/vA+8m+8aN40dm
	 tP1ThsT073Z2eVI4bYkZa7jb2JT7ENOZUXctkERnL2xXV+XvNDeb4pfCNF3aV61oqw
	 rKpaCCodJ91Iw==
Date: Wed, 15 May 2024 14:26:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	cassel@kernel.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v7 2/2] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20240515192614.GA2133406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514211452.GA2082543@bhelgaas>

On Tue, May 14, 2024 at 04:14:54PM -0500, Bjorn Helgaas wrote:
> On Tue, May 14, 2024 at 05:41:48PM +0530, Siddharth Vadapalli wrote:
> > On Mon, May 13, 2024 at 04:53:50PM -0500, Bjorn Helgaas wrote:
> ...

> > > I'm not quite clear on the mechanism, but it would be helpful to at
> > > least know what's wrong and on what platform.  E.g., currently v4.90
> > > suffers Completion Timeouts and 45 second boot delays?  And this patch
> > > fixes that?
> > 
> > Yes, the Completion Timeouts cause the 45 second boot delays and this
> > patch fixes that.
> 
> And this problem happens on AM654x/v4.90a, right?  I really want the
> commit log to say what platform is affected!
> 
> Maybe something like this?
> 
>   PCI: keystone: Enable BAR 0 only for v3.65a
> 
>   The BAR 0 initialization done by ks_pcie_v3_65_add_bus() should
>   happen for v3.65a devices only.  On other devices, BAR 0 should be
>   left disabled, as it is by dw_pcie_setup_rc().
> 
>   After 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus()
>   callback to use add_bus"), ks_pcie_v3_65_add_bus() enabled BAR 0 for
>   both v3.65a and v4.90a devices.  On the AM654x SoC, which uses
>   v4.90a, enabling BAR 0 causes Completion Timeouts when setting up
>   MSI-X.  These timeouts delay boot of the AM654x by about 45 seconds.
> 
>   Move the BAR 0 initialization to ks_pcie_msi_host_init(), which is
>   only used for v3.65a devices, and remove ks_pcie_v3_65_add_bus().

I haven't heard anything so I amended it to the above.  But please
correct me if it's wrong.

Bjorn

