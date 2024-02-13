Return-Path: <linux-pci+bounces-3410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23C853B73
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F21F26D9B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF3608F1;
	Tue, 13 Feb 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joyk1+7c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2686089E;
	Tue, 13 Feb 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853558; cv=none; b=qhvPKtrjyDu5ksMUqs9BXZFBM5JD2HaHcX6UqXFQ5csBMb7JEz8Zkoj0lGPvuIzlY2IicGEeEWGzkdxRNnU1ktVhhDnYMsqVs9OjcNL8JgW/OZSNcy7eZ3AbjtRL1WptXdpobGxUfH7V2WzXNXCmbBlz/X8Vfd4ry20Os5ZjW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853558; c=relaxed/simple;
	bh=WqPW2wosKK+QvQBbaPKSnDNPFyjxQDlHQS+8p1UqimA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZTP6Ff1RFzpPZKFmgslmRzQDAm8SiyyXUVcoftI3X86vV/8hHc3um1j8wdlOBiu/0OMreR2dg55HL60iSJOAL/XChbAjKgQTHxmKGMzZI2NY1KIS54ldP8r0zxienwhr7i+OilVP9ZJ5GUEZjXgqbS+QwBIRnCD+d6ILqlSV9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Joyk1+7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1C6C43394;
	Tue, 13 Feb 2024 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707853557;
	bh=WqPW2wosKK+QvQBbaPKSnDNPFyjxQDlHQS+8p1UqimA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Joyk1+7cLubMET3MgM9ZGOQIKH4vVDJAn/+pfdOm8wTA26Xx1skYGHM7tYt+UVKxk
	 OG4RzVv9+xZgqq0rhwrffVr3GJvoDE8JSyV24DcoCDWjJ3m9o8wocdd0yq0Kw477MU
	 naAXhqU5rrlrjSNWa67lCiGrinFrkakctSZfZEEVAGSHRTEeMTKbgiqOD9Np3wEwqE
	 Q+DXyEq8kIcqYzZd4LcLXLtkFeFbFAjpwFqNuBpI14GwEtaBqiv9RNoZtydcLlGSmh
	 ISY5LXqnwcZ15oJgF1IBh2S8uAyoBXFkkFes6QgNoqb5U9AsheurPGa0Ok2Ai1PHJs
	 xi4gdZBIPdLig==
Date: Tue, 13 Feb 2024 13:45:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jim Harris <jim.harris@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre =?utf-8?Q?Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240213194556.GA1219770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213174602.GD52640@unreal>

On Tue, Feb 13, 2024 at 07:46:02PM +0200, Leon Romanovsky wrote:
> On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
> ...

> > I guess that means that if we apply this revert, the problem Pierre
> > reported will return.  Obviously the deadlock is more important than
> > the inconsistency Pierre observed, but from the user's point of view
> > this will look like a regression.
> > 
> > Maybe listening to netlink and then looking at sysfs isn't the
> > "correct" way to do this, but I don't want to just casually break
> > existing user code.  If we do contemplate doing the revert, at the
> > very least we should include specific details about what the user code
> > *should* do instead, at the level of the actual commands to use
> > instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".
> 
> udevadm monitor will do the trick.
> 
> Another possible solution is to refactor the code to make sure that
> .probe on VFs happens only after sriov_numvfs is updated.

I like the idea of refactoring it so as to preserve the existing
ordering while also fixing the deadlock.

If, in addition, we want to update the sriov_numvfs documentation to
recommend "udevadm monitor" + /sys/.../sriov_numvfs, that's fine, too,
but I don't really like the idea of merging a patch and forcing users
to update their code.

So I'll table the v2 series for now and watch for a v3 with the
refactoring.

Bjorn

