Return-Path: <linux-pci+bounces-13979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B1993880
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 22:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768EA1F22C08
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BBC18A95F;
	Mon,  7 Oct 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQXcKiFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FE17624D;
	Mon,  7 Oct 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334008; cv=none; b=i4WH58npQzVA2axCw/j5fjiX7HZu5O9XBksWz9ddA5ckloBg/e/ZEOZXKC84/jCOm8dDHF6hbZZ7lrpNO/+r4MgUsgVxgZb2X9K8eGztB3rRcvhsMzHmCmoy2tZ1eini3p/6juaAQFE3JA1/MlIUHwLQPQtfQ08uSOeR3r/9c3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334008; c=relaxed/simple;
	bh=6NU6Lgxk4ULd9jdqthLkDjy5JXIEzzVVZizCSL+NbHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AOPbCcddaFnKZ+ma8WAA5b6HjAOKZFTu1fMLroW/ixG4p0kbpPu9rkGKmvT1y8o/8yd9/9TPRGu2Pptm/bssyzEDJq88f5iIvU3L9aeryT+G0v4sAelCICoBJe7CVXHwFmIsNbtmKwqFZdrtk0G9daiqCb4c+vuFN/33qDyQve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQXcKiFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F488C4CEC6;
	Mon,  7 Oct 2024 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728334008;
	bh=6NU6Lgxk4ULd9jdqthLkDjy5JXIEzzVVZizCSL+NbHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aQXcKiFaoKXktiJ5laxwJ8DU6Fpy8UAZiMI7v4iNaoWBq1lOlJAepBg96QF9Of6bu
	 GaZE4WXQLyO/io95sWnhRn8vz8mylJrjXxLQqcJWzpYPvpDEtfEPvxv/To4lqPPkju
	 qbbnprJx8mGZEL2FeicKfUQ9n0rjst7LKdLhbmuPNtQkz+I+8hYDP131vKaruS+zew
	 3TGbA/TfyeRMwsZ3iLO0/0478tE0/DmrQQxDFqIO/8SRhvth5LpJQgsySk1CGTdzud
	 mgx49dczcwdwW5gRoQDQiCyfpAHRq1dBnMXB9NmxerTL1D/1t3UJvvW7fCdWuDyx/P
	 JrUKdlzRT4S+w==
Date: Mon, 7 Oct 2024 15:46:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	Marcin =?utf-8?B?TWlyb3PFgmF3?= <marcin@mejor.pl>
Subject: Re: [Bug 219349] New: RIP: 0010:pci_for_each_dma_alias
 (./include/linux/pci.h:692 drivers/pci/search.c:41)
Message-ID: <20241007204646.GA450114@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007172001.GA441460@bhelgaas>

On Mon, Oct 07, 2024 at 12:20:01PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 04, 2024 at 07:55:29AM +0200, Marcin Mirosław wrote:
> > W dniu 03.10.2024 o 23:39, Bjorn Helgaas pisze:
> > > On Thu, Oct 03, 2024 at 08:15:16PM +0000, bugzilla-daemon@kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=219349
> > > > 
> > > >             Summary: RIP: 0010:pci_for_each_dma_alias
> > > >                      (./include/linux/pci.h:692 drivers/pci/search.c:41)
> > > >      Kernel Version: 6.12.0-rc1  8c245fe7dde3
> > > >          Regression: Yes
> > > > 
> > > > Created attachment 306959
> > > >    --> https://bugzilla.kernel.org/attachment.cgi?id=306959&action=edit
> > > > lspci -vv
> > > > 
> > > > Hello,
> > > > I see BUG: kernel NULL pointer dereference using kernel 6.12.0-rc1 (actually at
> > > > 8c245fe7dde3 but don't know what is first bad commit).
> > > 
> > > Thanks very much for this report!  You marked this as a regression;
> > > Marcin, do you know the most recent kernel where you did not see this
> > > issue?
> > 
> > Kernel 6.11 works correctly, I didn't narrow suspect commit yet.
> 
> Update from the bugzilla:
> 
> Marcin bisected the problem to 2031c469f816 ("iommu/vt-d: Add support
> for static identity domain") and verified that reverting that commit
> from v6.12-rc2 avoids the problem.

#regzbot introduced: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")

