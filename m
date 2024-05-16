Return-Path: <linux-pci+bounces-7579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F378C7858
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D824CB21C53
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0728F14884E;
	Thu, 16 May 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjfc0Ikh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBEF14A4E1;
	Thu, 16 May 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869064; cv=none; b=JOurS6o+en6O0xuj6KJcjtOFc4/tIJYUUtnx0rmoDmtfR+blWDxURUjDmLDFcLLi66ofA0GVewkLOULKbFHe+5Uckd16YOHXfgvXTOX52bH+99QVYhCSBk6JOE7DRKNPze9SRrhSjhZMtkyku928SxvnsIk8vFg/9scV325ZO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869064; c=relaxed/simple;
	bh=xMv7XT50PYQKLPovqBhh7bmTIxuh18H6PUJ2EPoy6u8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MyHtm/fjn4JoMqEnA8JfFvz2CI25o0KwqTWEnjYbmxPSXII0ohS/WLwryraXiyHK5WIQWDqxPGpsbJsrDouF++zYoO1Jz8UnmztUlMly5KIXSeymhwr7H7YIggR88zlufGp3Yg8X0GdnGP4OT2xgGXA/v8dJsYKxjN8oJ+QWKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjfc0Ikh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC60AC113CC;
	Thu, 16 May 2024 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715869064;
	bh=xMv7XT50PYQKLPovqBhh7bmTIxuh18H6PUJ2EPoy6u8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Kjfc0IkhMHVHFnfxmOd2jro4rjH+gKB/gy2doI4HcBeGt0EUDniqlL0+B53yKUoQS
	 iP+x9qB/rqsFwNPjy7TzFDVo76JhA0/2ZRrm9vUfIS62+zCbpgTgJU5Hv9Y8r1+8SF
	 hMv2Xuiq0DLYIt+NlHbvelhpnSVzvSzuk5Wr5ElZIvtR6SYooK01prdKH8hrTgXlYp
	 YbDSH/wZFUIQFEQgIdHApYFg+KXkyPku6hzF2pg4s9SfO1ECfIGq9KG5n2B/LdoGut
	 93R9egqzEpqLQRkDWP68NHSc0SD4jSZnGAtGR+Gdg+wDcikonmxoUujdlKCpwQKdQz
	 4LzP4wGNeksJg==
Date: Thu, 16 May 2024 09:17:42 -0500
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
Message-ID: <20240516141742.GA2204499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5f54a8-c19f-4a56-9a9b-f8aeebf475d0@ti.com>

On Thu, May 16, 2024 at 11:07:27AM +0530, Siddharth Vadapalli wrote:
> On Wed, May 15, 2024 at 02:26:14PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 14, 2024 at 04:14:54PM -0500, Bjorn Helgaas wrote:
> > > On Tue, May 14, 2024 at 05:41:48PM +0530, Siddharth Vadapalli wrote:
> > > > On Mon, May 13, 2024 at 04:53:50PM -0500, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > > I'm not quite clear on the mechanism, but it would be helpful to at
> > > > > least know what's wrong and on what platform.  E.g., currently v4.90
> > > > > suffers Completion Timeouts and 45 second boot delays?  And this patch
> > > > > fixes that?
> > > > 
> > > > Yes, the Completion Timeouts cause the 45 second boot delays and this
> > > > patch fixes that.
> > > 
> > > And this problem happens on AM654x/v4.90a, right?  I really want the
> > > commit log to say what platform is affected!
> > > 
> > > Maybe something like this?
> > > 
> > >   PCI: keystone: Enable BAR 0 only for v3.65a
> > > 
> > >   The BAR 0 initialization done by ks_pcie_v3_65_add_bus() should
> > >   happen for v3.65a devices only.  On other devices, BAR 0 should be
> > >   left disabled, as it is by dw_pcie_setup_rc().
> > > 
> > >   After 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus()
> > >   callback to use add_bus"), ks_pcie_v3_65_add_bus() enabled BAR 0 for
> > >   both v3.65a and v4.90a devices.  On the AM654x SoC, which uses
> > >   v4.90a, enabling BAR 0 causes Completion Timeouts when setting up
> > >   MSI-X.  These timeouts delay boot of the AM654x by about 45 seconds.
> > > 
> > >   Move the BAR 0 initialization to ks_pcie_msi_host_init(), which is
> > >   only used for v3.65a devices, and remove ks_pcie_v3_65_add_bus().
> > 
> > I haven't heard anything so I amended it to the above.  But please
> > correct me if it's wrong.
> 
> I would suggest specifying the failing combination since I do not know
> if there is another device that is using v4.90a but doesn't see this
> issue. What is certain is that this issue is seen with the v4.90a
> controller on AM654x platform. Despite the PCIe Controller version
> remaining the same across different platforms, it might be possible
> that not all features supported by the PCIe Controller are enabled on
> all platforms. For that reason, it appears to me that the subject could
> be:
> 
>   PCI: keystone: Don't enable BAR 0 for AM654x
> 
> which implicitly indicates the combination as well (v4.90a on AM654x).
> 
> The commit message's contents could be reduced to:
> 
>   After 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus()
>   callback to use add_bus"), ks_pcie_v3_65_add_bus() enabled BAR 0 for
>   both v3.65a and v4.90a devices.  On the AM654x SoC, which uses
>   v4.90a, enabling BAR 0 causes Completion Timeouts when setting up
>   MSI-X.  These timeouts delay boot of the AM654x by about 45 seconds.
> 
>   Move the BAR 0 initialization to ks_pcie_msi_host_init(), which is
>   only used for v3.65a devices, and remove ks_pcie_v3_65_add_bus().
> 
> by dropping:
> 
>   The BAR 0 initialization done by ks_pcie_v3_65_add_bus() should
>   happen for v3.65a devices only.  On other devices, BAR 0 should be
>   left disabled, as it is by dw_pcie_setup_rc().
> 
> The reason behind dropping the above paragraph is that BAR 0 could
> probably be enabled on other controller versions as well, but not on the
> v4.90a controller on the AM654x SoC.

Thanks, that makes good sense, I changed the subject and dropped that
paragraph.

Bjorn

