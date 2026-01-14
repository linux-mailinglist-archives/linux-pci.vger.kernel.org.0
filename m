Return-Path: <linux-pci+bounces-44783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD507D206A8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92A2300DC84
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436682836AF;
	Wed, 14 Jan 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyppVcgr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD527A916;
	Wed, 14 Jan 2026 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410197; cv=none; b=VldsaPKLKm55+zvmzCt03cmc42ahpFuR1W51vz+3Yk4gURWM7GW4UdL3TFrOSthceYkJiCLqAqiwJ8/04QRk3nyQ3ApHQHa9+y4514+cAfaxsF8SfBLGjREqFzm5eJDYlkeJeWGWlgUbGkBOZbZ9nB47S0vz+5KXXzKBHFR+Rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410197; c=relaxed/simple;
	bh=tbOQiaRsx985jHNtRaNVTBPCED2t5Ue5EhyntK5pH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkW611NuCKJd2amRPLNH9orcup3E28mPnU0op4Hk/t+83h/oBwTYJy7DlehXIC+wNHel8CbEeNm3GtBZYiznaoGf7KDLHz9riFGrdeWUQEJNOokyVmFUmHRZjUKRuw+Xq3ArRXP6srLVnWEnd4nwa7+rhHh8qvsRRgLa0OwBU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyppVcgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719FFC4CEF7;
	Wed, 14 Jan 2026 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768410196;
	bh=tbOQiaRsx985jHNtRaNVTBPCED2t5Ue5EhyntK5pH6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyppVcgrGQZ1NBONlc4fpePseUDyJJ5N6Yy1rFPXWoRD9W2pnQjhQNzPNvWnOxBCb
	 G1t0jtfLWEDR6MbsfgstatxJPWC9XvqhLnH3fCLwNktUz9dwOxOCa7QpAfAuNQL5md
	 ygkbJjx3EBgBIXKPBS6lD39Fe9MZQhTUvRGTHu/CupCMqWIjAhmKbAJ+eB45ofOZlf
	 zWyX1a4qZcJeYuL5gy+CdLM4Vm1Zi/TdnPhErIEZb/DgQvi51QJD+IUS+8c9oIF4pD
	 kpAiVjPGipG1q6REbWLFgrzjvJqEfHi0+Ya+MvL5OSfEL3eMsw9DQ3jQ9FVVHrdRs0
	 8UY5o/VIqnWUg==
Date: Wed, 14 Jan 2026 18:03:10 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Jose Marinho <jose.marinho@arm.com>
Subject: Re: [PATCH v2 0/7] irqchip/gic-v5: Code first ACPI boot support
Message-ID: <aWfMTjukKcIlQugi@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <CAJZ5v0gqso3q8gUZ3wPq1iG7zOBUu2cWMDZiHqCBU5dgdu_KTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gqso3q8gUZ3wPq1iG7zOBUu2cWMDZiHqCBU5dgdu_KTQ@mail.gmail.com>

On Wed, Jan 14, 2026 at 04:56:53PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 18, 2025 at 11:15 AM Lorenzo Pieralisi
> <lpieralisi@kernel.org> wrote:
> >
> > The ACPI and ACPI IORT specifications were updated to support bindings
> > required to describe GICv5 based systems.
> >
> > The ACPI specification GICv5 bindings ECR [1] were approved and the
> > required changes merged in the ACPICA upstream repository[5].
> >
> > The Arm IORT specification [2] has been updated to include GICv5 IWB
> > specific bindings in revision E.g.
> >
> > Implement kernel code that - based on the aforementioned bindings - adds
> > support for GICv5 ACPI probing.
> >
> > ACPICA changes supporting the bindings are posted with the series; they
> > were cherry-picked from the upcoming ACPICA Linuxised release patches
> > and they should _not_ be merged in any upstream branch because the
> > full set of Linuxised ACPICA changes will be subsequently posted in
> > order to be merged, I added the two ACPICA patches to make the series
> > self-contained.
> 
> The patches in question have been included in this series:
> 
> https://lore.kernel.org/linux-acpi/12822121.O9o76ZdvQC@rafael.j.wysocki/
> 
> and are going to be applied shortly.

Thanks Rafael, I will rebase the series and mark the dependency then.

Lorenzo

