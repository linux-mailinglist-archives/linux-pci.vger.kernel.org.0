Return-Path: <linux-pci+bounces-20782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042ACA29D94
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 00:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2981679D5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 23:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093881519B7;
	Wed,  5 Feb 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMFoi0SA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090715198F;
	Wed,  5 Feb 2025 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738798700; cv=none; b=LtJIfBYAkTzPzReS5DukAizG1109lRzBZLtgZm0/zSaRLjwficG0IwK0cYMHrY2ZmV/uMyvF1Ml+l3FY6LdSglhLinQZwDPAtRThpN9ZvNxor9V9+7jnnvrLR86FSm6kM4t/Buy5LbIuBuWxhuv/OX6NP4mpl0dfpJ5vAbSP0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738798700; c=relaxed/simple;
	bh=Yl7vdVYZ3uVeTXvJQ3z2No+XRSNYHdbj0OTkCw9O71o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A25zyAbZ4D3yVKZ4HOczJ5BofKrTfLMvqTmq+hSxkHqCJpaoj7pV34My7fiCfgNVFzITjI2CwEUNNAISXWgSUauaLxbyVcT+R+hH6ZCI6zInER7lE+n0mHXd20ylEJ7QV23c/ArOXTN+n16PJpV5hzNXvX3qzhyFEzBpb/wbEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMFoi0SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D626C4CED1;
	Wed,  5 Feb 2025 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738798700;
	bh=Yl7vdVYZ3uVeTXvJQ3z2No+XRSNYHdbj0OTkCw9O71o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aMFoi0SA4J27vdHiguS7Q6MqT2JEgBmPxCY9mMLTDr3ZatvBYMKD3FgzMY4+lTZU6
	 QyHbffl3O+luWnVo/l9BFLMqw8IwZ/ISZepE7E3ulNTJPQpS4uaz6iclvBsvio2+UW
	 k2ryhBeFE3Xp7neTIGe9kXLVckLZ9Ianad/pI4W9kG4nY86qfCSNJuJjzZuvxPh9vm
	 lSHi/NdYJT6z8DfOuyHfGM9Kdmx9xyTBRbWKnOzNtzJ64JBoLkvIlqY2PVV7el7TK6
	 0bRKY8OAEldZ9OAPwEhBm/6x81Xbg9PBiSvowheCuS8Vz1LqdyiwlFAEfxvV1BC2Dp
	 x1bfEH4U9Hzng==
Date: Wed, 5 Feb 2025 17:38:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, regressions@lists.linux.dev,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: Linux warns `rtsx_pci 0000:3b:00.0: PM: dpm_run_callback():
 pci_pm_resume returns -110`
Message-ID: <20250205233817.GA949434@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e30f47ea-396e-45c7-a2aa-d141d27dae4c@molgen.mpg.de>

On Wed, Feb 05, 2025 at 10:48:24PM +0100, Paul Menzel wrote:
> Thank you for your instant reply.
> 
> Am 05.02.25 um 09:44 schrieb Ilpo Järvinen:
> > On Tue, 4 Feb 2025, Paul Menzel wrote:
> > 
> > > #regzbot introduced: b46c89c08f41..aa22f4da2a46
> 
> > > On the Intel Kaby Lake laptop Dell XPS 13 9360, at least Linux
> > > 6.13.0-07632-gaa22f4da2a46 logs the new warnings:
> 
> (Just a side note, these are actually logged with level error.)
> 
> > >      rtsx_pci 0000:3b:00.0: Unable to change power state from D0 to D3hot, device inaccessible
> > >      rtsx_pci 0000:3b:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110
> > >      rtsx_pci 0000:3b:00.0: PM: failed to resume async: error -110
> > > 
> > > These were not present up to including Linux 6.13.0-07078-gb46c89c08f41.
> ...

> > Please try if this fix helps:
> > 
> > https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@linux.intel.com/
> 
> Yes, after applying the patch these errors were *not* logged in three ACPI
> S3 suspend/resume cycles.

Thanks, I added your Reported-by to the patch, which should appear in
v6.14-rc2.  Happy to also add your Tested-by if you feel confident
enough.

