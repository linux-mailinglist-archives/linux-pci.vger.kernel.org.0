Return-Path: <linux-pci+bounces-45256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE9D3C5E5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 533FD740AC6
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B23A6405;
	Tue, 20 Jan 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyYqUelI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E7223324;
	Tue, 20 Jan 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904168; cv=none; b=mrvuAfFVXTxby5RsqheGJplQrIbXrrCimPftlDsL+ZiQH2aZ+pUEpZC9PCQSSkmqdGC7s4IXMUkN7izuCy3bdTPKJTlJpiO2/6I4NkfQRAY6HR00xRvAyr5UMYftW+sKsfd2K2bWEjDCdnhsqbS/fvtaLfc4lXqK+DZS0ebI9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904168; c=relaxed/simple;
	bh=iXDM9sQqzNpRwm3a7W6kTb784YafZHJUjqkBDX1rr50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPc6Vzgct7s/pfU5MctC1YqGUafNsv82QYlxO5/ZpsukKqVxsMLrYpDKir7XCcUmAB9kOfP8UkOL/2xstEUjS/pZYDX65KvpGLDWfgIEMHPi/+tdSSTURDjcDOj0jXriFWw22KhyhVFX8ynxJiBLu4nFqgFb7/8XBFgoKZiUti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyYqUelI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE761C16AAE;
	Tue, 20 Jan 2026 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768904168;
	bh=iXDM9sQqzNpRwm3a7W6kTb784YafZHJUjqkBDX1rr50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyYqUelIpqO9hvVWaQPDGsDObTc/l14pEqaWMEXqDTRvmkULuUgQJ+YbgBO1bJdUd
	 jXF4TUvmeARvig6cC07SCREg4B3IPvGRkgGabtgV6Djhl0QxP0gpLwQntNGnaEODgW
	 JbdUllLe5Ea1O6tvBFVkJjSzYZCplcF1UrODrwwCuWUYECDqV2Ch6x2goeVGuxnTYJ
	 m+0AHx5qR+Ya4GrqsHdfmqxNcIvNQM4l8mW2iRkNif4HWUdCUoSeH68cpklAkP/6Rd
	 1OKfzWm24rQioRqs8Mp7+J4fxktJeUdZ5tLuHciJin1PFgSIub34glcfIWaBe5Mlzk
	 JuAbtZaKbqq/A==
Date: Tue, 20 Jan 2026 11:16:00 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
Message-ID: <aW9V4A7lTGZWTO9e@lpieralisi>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi>
 <87sec30yhk.ffs@tglx>
 <aW3pALPxn4i9fiDO@lpieralisi>
 <87pl751zeh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl751zeh.ffs@tglx>

On Mon, Jan 19, 2026 at 02:54:14PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 19 2026 at 09:19, Lorenzo Pieralisi wrote:
> > On Sun, Jan 18, 2026 at 03:47:03PM +0100, Thomas Gleixner wrote:
> > I think the simplest way to sort this out is for this series to go via
> > the ACPI tree if that's OK for Thomas, given that the ACPICA code will
> > go via the ACPI tree anyway and there are other dependencies on it there
> > I assume (this series is fairly self-contained).
> 
> I'm fine with that
> 
> Acked-by: Thomas Gleixner <tglx@kernel.org>

Thank you Thomas, Rafael I hope that works for you too, please let me know
if there is anything I can/should do.

Thanks,
Lorenzo

