Return-Path: <linux-pci+bounces-39202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D76C0366E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 22:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD523AC91C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68404218AD4;
	Thu, 23 Oct 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPGgIEa2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27A17C21C;
	Thu, 23 Oct 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251950; cv=none; b=hkDMPEy2aT2I19aUpce7C5v/bp/OV2sQW/UWaG5ui2Eskzpipz38PmwGLFs+hJvsFpF0zbLscQVsSD35alFpz347W2+Gfq1r1jsJwfjb4bI2sNV1aCoZdYLN5R65ll+kR9i1fwcuvQUafpkJ5gQQ/d5Ad4svjJfszCbK9N6vm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251950; c=relaxed/simple;
	bh=Iifi+VbV963RwdpYbf2ljnl0AJ421iOJ11fymH6RoHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KqTWdsUZDDp8EUCE2fasH9n43akuphpij5p9RY9Skv2sKYqIF0+xgnakO9xge272Oui6edXJYQFuR4UZlQiFiq5X+cq+RhBK2Kk6rSD7OzHHRY6NaQE7Bmsb6aqlku8ujm4t1SyzAhTrxmwye/4kMYGjyvd+jTqZg/9+DMBF9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPGgIEa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54ECC4CEE7;
	Thu, 23 Oct 2025 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761251949;
	bh=Iifi+VbV963RwdpYbf2ljnl0AJ421iOJ11fymH6RoHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FPGgIEa2tcCqmJ6crL47tJjlXDlazTRrJVHvyevCAimVX0h63+mCMT2vecNCsIhnp
	 8CWWHyJhr0778CXW9/vnLFOIuRmoZYHri9IZ4esCTVuVAZ/8diIGKk86aaJCPuLX37
	 FSIuNxRgonsLUllGN7CGgXzzQUmHsw24RfydNgWz8Mpvon5HpYuGTajd+P4Suot8kU
	 TqU1EW518gKJmt2+rH7jjuIS2FO9UHwGE/ajoB3B0R66pYunD9PW8en+k5BrazM8Vx
	 WiMfKerWzbFgGJAuDBzVhRXqCP8UDLdjlLznC7/kkfBvWZrvmhzy8GqrnNl1CQZQHs
	 i7NryYntI+n+g==
Date: Thu, 23 Oct 2025 15:39:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Dragan Simic <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251023203908.GA1314564@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDPYVBSYR01V.1OSGKL2X8LT82@cknow-tech.com>

On Thu, Oct 23, 2025 at 09:59:41PM +0200, Diederik de Haas wrote:
> Hi Bjorn,
> 
> Thanks for the patch :-)
> 
> On Thu Oct 23, 2025 at 8:25 PM CEST, Bjorn Helgaas wrote:
> > On Thu, Oct 23, 2025 at 01:06:26PM -0500, Bjorn Helgaas wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >> 
> >> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> >> platforms") enabled Clock Power Management and L1 PM Substates, but those
> >> features depend on CLKREQ# and possibly other device-specific
> >> configuration.  We don't know whether CLKREQ# is supported, so we shouldn't
> >> blindly enable Clock PM and L1 PM Substates.
> >> 
> >> Enable only ASPM L0s and L1, and only when both ends of the link advertise
> >> support for them.
> >> 
> >> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> >> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> >> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> >> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> >> Closes: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
> >> Reported-by: Herve Codina <herve.codina@bootlin.com>
> >> Link: https://lore.kernel.org/r/20251015101304.3ec03e6b@bootlin.com/
> >> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> >> Link: https://lore.kernel.org/r/DDJXHRIRGTW9.GYC2ULZ5WQAL@cknow-tech.com/
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> >
> > Provisionally applied to pci/for-linus, hoping to make v6.18-rc3.
> >
> > Happy to add any testing reports or amend as needed.
> 
> My build with your patch (on top of 6.18-rc2) just finished, so I
> installed it and rebooted into it.
> Happy to report that everything seems to be working fine and I can't
> find any errors, warnings or other messages with 'nvme' in dmesg that
> indicate sth could be wrong. IOW: it does indeed fix the issue I
> reported earlier. So feel free to add my:
> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>

That's tremendous, thank you for all your help and testing!  I know 
it's frustrating and time consuming when things break, and I really
appreciate your reports and help.

Bjorn

