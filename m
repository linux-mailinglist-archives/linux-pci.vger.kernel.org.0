Return-Path: <linux-pci+bounces-13111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7899769AF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811301C22802
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58B1A42B0;
	Thu, 12 Sep 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASL+w9VZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E11A0BFA;
	Thu, 12 Sep 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145648; cv=none; b=nBvTSaydmYlpry1Szbe6xPuNVdNNYQcqmSoxuH6wA5B+c0AnY2TkGwn3Fxo0kEC2Zvu02LeuwoPoahj9tQMUjn42o16+oC6892Hn/GctJIfinLUr86cm0HAlBGBhZ3MNyo4zyYbmWzgA32IfiCK/xyAIDcJKL5ZVB/S6br9/7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145648; c=relaxed/simple;
	bh=5Bu34kiktecMZsMoYtV7l8gwxncj8jvSh9tNPZneEHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zm8my0e6N/DWUopB2omuq861s9Jr3Qb07QTK95kCKeYtw4oXaMUCdxNOBaTZ1jdmg2mU5G9llm7azvToEqja55vaDOZWYapygyrJEDXxLiTdmCdMR0+jO209aSXGDYksq4Ym7vozpauzeWdxfHdCeMq4ctoABH814ojQQTF/n7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASL+w9VZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06823C4CEC3;
	Thu, 12 Sep 2024 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726145648;
	bh=5Bu34kiktecMZsMoYtV7l8gwxncj8jvSh9tNPZneEHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ASL+w9VZCExWvBL6SVR+fwA47/AIK3b1i7kkcONsZI0wUOkLYJgeRPIKdMel2b2VK
	 z1AoXO90kFQCFT+FphmsQPS1iQPjajxIwUptv2BLJS3cIMG+Xy79A8i4Id0KnjXzJF
	 DXSC2A1zMMWa7Df4LsEbt72CQcMQrPJbI8vCOMmRNA04d70FOrdE19HC1exlceuKLH
	 geUy7KhPGQFTmoJidcFsdsA17BXJT+HrnY8tvIW2oy3ahpFW3t3l6rJTAtJYzcEuxm
	 fKrMf1tUcXEColmqSsDWSwUKVF5Ygt/yRDy5sLA/3MfXV4yXEe2u3X1V76/FbrN43K
	 9PWtXBIROuWow==
Date: Thu, 12 Sep 2024 07:54:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Fix potential deadlock in pcim_intx()
Message-ID: <20240912125406.GA671060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd2b8dd20ce3e7a26b6eb795dd7c496a7d91fd01.camel@redhat.com>

On Thu, Sep 12, 2024 at 09:18:17AM +0200, Philipp Stanner wrote:
> On Wed, 2024-09-11 at 09:27 -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 05, 2024 at 09:25:57AM +0200, Philipp Stanner wrote:
> > > commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
> > > allocation step for pci_intx()'s device resource from
> > > pcim_enable_device() to pcim_intx(). As before,
> > > pcim_enable_device()
> > > sets pci_dev.is_managed to true; and it is never set to false
> > > again.
> > > 
> > > Due to the lifecycle of a struct pci_dev, it can happen that a
> > > second
> > > driver obtains the same pci_dev after a first driver ran.
> > > If one driver uses pcim_enable_device() and the other doesn't,
> > > this causes the other driver to run into managed pcim_intx(), which
> > > will
> > > try to allocate when called for the first time.
> > > 
> > > Allocations might sleep, so calling pci_intx() while holding
> > > spinlocks
> > > becomes then invalid, which causes lockdep warnings and could cause
> > > deadlocks:
> > > 
> > > ========================================================
> > > WARNING: possible irq lock inversion dependency detected
> > > 6.11.0-rc6+ #59 Tainted: G        W
> > > --------------------------------------------------------
> > > CPU 0/KVM/1537 just changed the state of lock:
> > > ffffa0f0cff965f0 (&vdev->irqlock){-...}-{2:2}, at:
> > > vfio_intx_handler+0x21/0xd0 [vfio_pci_core] but this lock took
> > > another,
> > > HARDIRQ-unsafe lock in the past: (fs_reclaim){+.+.}-{0:0}
> > > 
> > > and interrupts could create inverse lock ordering between them.
> > > 
> > > other info that might help us debug this:
> > >  Possible interrupt unsafe locking scenario:
> > > 
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(fs_reclaim);
> > >                                local_irq_disable();
> > >                                lock(&vdev->irqlock);
> > >                                lock(fs_reclaim);
> > >   <Interrupt>
> > >     lock(&vdev->irqlock);
> > > 
> > >  *** DEADLOCK ***
> > > 
> > > Have pcim_enable_device()'s release function,
> > > pcim_disable_device(), set
> > > pci_dev.is_managed to false so that subsequent drivers using the
> > > same
> > > struct pci_dev do implicitly run into managed code.
> 
> Oops, that should obviously be "do *not* run into managed code."
> 
> Mea culpa. Maybe you can ammend that, Bjorn?

Fixed, thanks for the pointer.

