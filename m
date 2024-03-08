Return-Path: <linux-pci+bounces-4676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D28768A9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225441F21E10
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735A7484;
	Fri,  8 Mar 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8P2CCKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F31CA8E;
	Fri,  8 Mar 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916043; cv=none; b=J7lTrnBHA/Lz6VZSlU6lpRFMCu10egCEt11CJCHauP03xFd1d+SCW0jxhFoz2C5Msmh64Y1QZldDuOsIpDGPfe4JhUEdY74UModw0cQFOqGkCffdvn5/Gy8GttFhUbWP1FV65rrow34fw1cg68f0qWaprGfmdkv2ltmuBsp5PvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916043; c=relaxed/simple;
	bh=ivspc6KyS5C5s0+lppQbNKthOBmzM+WjLyrCDyM1dTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D6/zKY6Jk3Tq80MdILmFjKo2gRPj25DxmhatgpaL5H5ntnCProekqx1y8Ky1lZdL9Wt3bQjgZt1EHycb9E+fQLsaM9NvlRP+a0AQ41o2+UZ+iQXV2GMg1B3+qiLEjWdhK4ikmSRkgz/Z9Gw5pNHgY/a6B99EKSPTqryFRRfClS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8P2CCKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6479EC433C7;
	Fri,  8 Mar 2024 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709916042;
	bh=ivspc6KyS5C5s0+lppQbNKthOBmzM+WjLyrCDyM1dTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y8P2CCKNotEK8bIPwpQaSJNAUOzJkpkjGk1h4jqzyEoYEel48uJPzIeSsND50VvqB
	 1sNPZNAk1dJnTIAPjE3YRQ01yrbEavHZjiuxx3fm4yk3XoHAmbz22gJZ7L4HK4kZO5
	 +klRU1+rlY7EmtVjnZkxAOfjbsJRN59WKIS2cax4VgRwjenyftUJx1lnf1WJhzCI+N
	 bqwklRn+5FbIkhnxjNsTmRpbdGg+gVave4Nrnervp4+T8dy+ma9GfpD6nvrW3S2hua
	 q4qMF3+x0HpiSLjxH6J690K+LembhWfzlv1zZqyTT0ImivUm3k6CssfUpMNNtY42ux
	 ZEsWgXWjlz/3w==
Date: Fri, 8 Mar 2024 10:40:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Michael Schaller <michael@5challer.de>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, macro@orcam.me.uk,
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	gregkh@linuxfoundation.org, hkallweit1@gmail.com,
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Message-ID: <20240308164040.GA683683@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p6GEPJe3rNNrUAah5PdLXspKh5Gz9tFstR6SFCREs+9=Q@mail.gmail.com>

On Thu, Mar 07, 2024 at 02:51:05PM +0800, Kai-Heng Feng wrote:
> On Wed, Jan 10, 2024 at 8:40 PM Michael Schaller <michael@5challer.de> wrote:
> > On 10.01.24 04:43, Kai-Heng Feng wrote:
> > > On Fri, Jan 5, 2024 at 11:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >> On Fri, Jan 05, 2024 at 12:18:32PM +0100, Michael Schaller wrote:
> > >>> On 05.01.24 04:25, Kai-Heng Feng wrote:
> > >>>> Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?
> > >>>
> > >>> Yes, `echo 0 | sudo tee /sys/power/pm_async` does indeed also result in a
> > >>> working resume. I've tested this on kernel 6.6.9 (which still has commit
> > >>> 08d0cc5f3426). I've also attached the relevant dmesg output of the
> > >>> suspend/resume cycle in case this helps.
> > >>
> > >> Thanks for testing that!
> > >>
> > >>> Furthermore does this mean that commit 08d0cc5f3426 isn't at fault but
> > >>> rather that we are dealing with a timing issue?
> > >>
> > >> PCI does have a few software timing requirements, mostly related to
> > >> reset and power state (D0/D3cold).  ASPM has some timing parameters,
> > >> too, but I think they're all requirements on the hardware, not on
> > >> software.
> > >>
> > >> Adding an arbitrary delay anywhere shouldn't break anything, and other
> > >> than those few required situations, it shouldn't fix anything either.
> > >
> > > At least it means 8d0cc5f3426 isn't the culprit?
> > >
> > > Michael, does the issue happen when iwlwifi module is not loaded? It
> > > can be related to iwlwifi firmware.
> > >
> > The issue still happens if the iwlwifi module has been blacklisted and
> > after a reboot. This was again with vanilla kernel 6.6.9 and I've
> > confirmed via dmesg that iwlwifi wasn't loaded.
> 
> Can you please give latest mainline kernel a try? With commit
> f93e71aea6c60ebff8adbd8941e678302d377869 (Revert "PCI/ASPM: Remove
> pcie_aspm_pm_state_change()") reverted.
> 
> Also do you have efi-pstore enabled? Is there anything logged in
> /var/lib/systemd/pstore (assuming systemd is used)?

It seems possible that some recent ASPM fixes could help this issue.
These fixes are not upstream yet, but should appear in v6.9-rc1.

Your (Michael's) bisection identified 08d0cc5f3426 ("PCI/ASPM: Remove
pcie_aspm_pm_state_change()"), which appeared in v6.0.  This was
intended to solve the problem of ASPM config changes made via sysfs
getting lost.

We removed 08d0cc5f3426 in v6.7 with f93e71aea6c6 ("Revert "PCI/ASPM:
Remove pcie_aspm_pm_state_change()"") to address the reboot after
resume problem that you reported.

e4dbf699467e ("PCI/ASPM: Update save_state when configuration
changes") is planned for v6.9-rc1 and should solve the same problem
08d0cc5f3426 tried to solve, but in a different way.

390fd84739c5 ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") is also planned for v6.9-rc1 and fixes some problems
with restoring L1 Substates config during resume.  These substates are
enabled for your 03:00.0 device, so this commit may also be related.

That's all a long way to say that I think testing v6.9-rc1 or later
(or linux-next as of Mar 7 or later) would be very interesting.

> > I've also checked if there is a newer firmware but Ubuntu 23.10 is
> > already using the newest firmware available from
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/iwlwifi-8265-36.ucode
> > (version 36.ca7b901d.0 according to dmesg).
> >
> > Michael
> >
> > >>
> > >> Bjorn

