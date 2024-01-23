Return-Path: <linux-pci+bounces-2492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED483965B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D2B25920
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E57FBB2;
	Tue, 23 Jan 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVeaiKmt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCF7FBB7;
	Tue, 23 Jan 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030740; cv=none; b=koILiff/dGsVsvCgpeelak+Qt054br/bDXu26m/VawdV2Q9fmGKju1/8TOnTk2dqcVbmfpQjMCO8fdwF+xlCitZP2jIv590rdETsG1J5ltIdn4jq6clqpYlJjd9FKRHAGF3TZ9VnJqsuzin1/lVvJ2rqbGY/t3FzSJtOCd1WvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030740; c=relaxed/simple;
	bh=owFnlOk5Q+Eu97Jy5r3Vid9vDSX0Lx7bNco6ENdRQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzuO/UnXyFOrC+o3AiOlntRsdzotIq3IKfLUsVKWx7j9tEV/NXA+Q0m/sMKc4M1ibyypGJwkv3jDbD/JRUj0ChdsG7LqO9AXo9vsAy3dlkIxwRJ0hkC1Xm8WDwr9paiMqukr+8Hy/tU8Hn4fQyXn64Otx3Wre+JnUie0yGyBVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVeaiKmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9132C433F1;
	Tue, 23 Jan 2024 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030739;
	bh=owFnlOk5Q+Eu97Jy5r3Vid9vDSX0Lx7bNco6ENdRQVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVeaiKmtcDgGgLP2BYukxjpQuCpS7FHhAOVvGmITyqQmxJjHmQAmJSho2kK9qbYys
	 N7hnRBqP593yishGnCQ2Xz1+0IgedKNu5UsjM99Bedc+EvL1a5PEnJ7kuyAiBSfMgO
	 IYrpWRJ3AStrid4TzT4QGOB9RSFiuEKjVn5sYjWp4of9NnGTw+540q6CvXzkD2ijJx
	 uHvfmY/+viLzh5Sl+SFyT6C9r5AAozbEuIk5ix/4UhqCSaLSZvWLzmjfdv1PklNkJG
	 vpM4YbB3kQkJC2ZBc9XKQakq+HPWXOBOZLI6ttq2KRhQp9W7pneReTea9xsPNzHWfz
	 CzMX1q7Rt+pGg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSKX2-0000000007X-1K2C;
	Tue, 23 Jan 2024 18:25:53 +0100
Date: Tue, 23 Jan 2024 18:25:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	regressions@leemhuis.info
Subject: Re: PCI/ASPM locking regression in 6.7-final (was: Re: [PATCH]
 Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()")
Message-ID: <Za_2oKTUksw8Di5E@hovoldconsulting.com>
References: <Za5JLxRC-K20sIfG@hovoldconsulting.com>
 <20240122182615.GA277100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122182615.GA277100@bhelgaas>

On Mon, Jan 22, 2024 at 12:26:15PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 22, 2024 at 11:53:35AM +0100, Johan Hovold wrote:

> > I never got a reply to this one so resending with updated Subject in
> > case it got buried in your inbox.
> 
> I did see it but decided it was better to fix the problem with resume
> causing an unintended reboot, even though fixing that meant breaking
> lockdep again, since I don't think we have user reports of the
> potential deadlock lockdep finds.

That may be because I fixed the previous regression in 6.7-rc1 before
any users had a chance to hit the deadlock on Qualcomm platforms.

I can easily trigger a deadlock on the X13s by instrumenting 6.7-final
with a delay to increase the race window.

And any user hitting this occasionally is likely not going to be able to
track it down to this lock inversion (unless they have lockdep enabled).
 
> 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") was a
> start at fixing other problems and also improving the ASPM style, so I
> hope somebody steps up to fix both it and the lockdep issue.  I
> haven't looked at it enough to have a preference for *how* to fix it.

Ok, but since you were the one introducing the locking regression in
6.7-final shouldn't you look into fixing it?

Especially if there were alternatives to restoring the offending commit
which would solve the underlying issue for the resume failure without
breaking other platforms.

I don't want to spend more time on this if the offending commit could
simply be reverted.

Johan

