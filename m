Return-Path: <linux-pci+bounces-23064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8822A5516D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 17:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A8C189AC02
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6D92253B0;
	Thu,  6 Mar 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be8xOyYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7797213E64;
	Thu,  6 Mar 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278525; cv=none; b=GruOOIWTKUju+/Doq/L4bBR2v0v7Rx3Jr/8UyvNvBHJu5vAu8ZyRkIK6cE7ZArIirIw7PPwMMNV+F0sGqbB2UDdQ2V7UWudgmYRWelc0sVSIy+KlDbyjrTpXENpg6nFTKutTyQk0OKKpAixDVlvFfsDAcKhCtTXDo0mAS5DdQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278525; c=relaxed/simple;
	bh=jLROWwkGrjUcunK7jfUFxszWDwIIb35RmR32aQ9Dg+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TmzH4mlmtu80xzAY6LYOJcyLjPuZpwItb6GpmmnnEpAi2We2DU/LDnJT41boJSY9U4WOpTLTyN26Yuhp+ILxqA0y1f20F4MbpNdLmV9NvatbaLixuiob1JcT8Qk14QGD7yGOhSbkmIVzXgNNAneTJinyyce2ISzCk565Npuqb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be8xOyYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ACDC4CEE0;
	Thu,  6 Mar 2025 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278524;
	bh=jLROWwkGrjUcunK7jfUFxszWDwIIb35RmR32aQ9Dg+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Be8xOyYj3u2frUl+QZNZgNTLIvh7iEQGFAs6wXJACjG3cs8XBnjtHQ2EZpnWCXrxk
	 Etp/OTDhwRm52et3+4a6xCrJ7Yv5gZfcu5HhjroF0OpqvpNR7A3vqzjCuvIjwUIhyL
	 7Eea4pcYaJq0AtHI6YPAHET18DG4nzndVoFPXhcQF7SMvhizQKpy8/jOOWueDzu8Pl
	 /cf/jVECBMneDABSIKGnX950KlrjEO7435yZEF8Y6hdnagES7Mkxc4iKKjpUhPUcKb
	 BvP9+aB3FDTHS9EMRw9nrRKpmDeriXQWpgQPZFujjHwkYD1DGwtbo7RSHtBpWHupik
	 3W2TBISN0MvOg==
Date: Thu, 6 Mar 2025 10:28:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "hans.zhang" <hans.zhang@cixtech.com>
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>, ChunHao Lin <hau@realtek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] PCI: Add PCI quirk to disable L0s ASPM state for RTL8125
 2.5GbE Controller
Message-ID: <20250306162842.GA344204@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a00461-b8fa-48d0-9049-9a34abfe87a3@cixtech.com>

On Thu, Mar 06, 2025 at 11:32:04AM +0800, hans.zhang wrote:
> On 2025/3/6 06:20, Bjorn Helgaas wrote:
> > Sounds like this should be a documented erratum.  Realtek folks?  Or
> > maybe an erratum on the other end of the link, which looks like a CIX
> > Root Port:
> > 
> >    https://admin.pci-ids.ucw.cz/read/PC/1f6c/0001
> 
> Name: CIX P1 CD8180 PCI Express Root Port
> 
> 0000:90:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0001:60:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0002:00:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0003:30:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 
> 
> This URL does not appear right, how should be changed, is it you? Or can you
> tell me who I should call to change it?
> 
> The correct answer is:
> 0000:90:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0001:C0:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0002:60:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0003:30:00.0 PCI bridge [0604]: Device [1f6c:0001]
> 0004:00:00.0 PCI bridge [0604]: Device [1f6c:0001]

This part of the web page is just commentary.  In this case it's just
an example of what devices might be on some system.  It's not a
requirement that all systems have this many devices or devices at
these addresses.

The only important parts are the Vendor ID, Device ID, and the name
("CIX P1 CD8180 PCI Express Root Port").  If those are correct, no
need to do anything.

> The domain might be random, so whichever controller probes first, it's
> assigned first. The URL currently shows the BDF with one controller missing.
> That's the order in which we're going to controller probe.
> 
> Best regards,
> Hans
> 
> 

