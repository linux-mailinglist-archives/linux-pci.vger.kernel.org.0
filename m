Return-Path: <linux-pci+bounces-39579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D00C16DDD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9BA19C0513
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51829993F;
	Tue, 28 Oct 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLE4fNEz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDF2045B7;
	Tue, 28 Oct 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685601; cv=none; b=h68BQ36Rsa62EeN3MoIfFo6PESqXJrLZGxxgPLr0KOCB9jl5z0arXWsXVcOlW4jpXX4ne8oGLd3muMKyCuqyXzwbJW86jHeizOaBctLu6YqjLUhwSw4miWR/dSCfhCgJmsap2z0gzO65nUyYL9RyRC06zrekfl1xNMnGLuiSHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685601; c=relaxed/simple;
	bh=WZyoXFnSW3BbAdQwLgqA9HXUOcLoQ+YurBEXGagcnAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XogOFP8ZQ/d/p+YI2yMUyMqxg55G008uw/4ltnJe/E4YRozFQDJSuwNDcy74kdhhhbgQWDM6WMSrBDbQhNJ2cxKTdEjmGLvh06Jz4LghbNldix4fwdMQ93e5ZK1Z+029NrqyQmcF89lk3UV9n8jUPLXZp59wohislAswQ3BP7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLE4fNEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4301DC4CEFF;
	Tue, 28 Oct 2025 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761685601;
	bh=WZyoXFnSW3BbAdQwLgqA9HXUOcLoQ+YurBEXGagcnAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eLE4fNEzmMbs3ZttKKxVXldubPxVMga5wWSdEkCHizdfX+clHLqvioionWt5Aesmq
	 lWzibpA7SSdm2Cv3hWJr8fwQUfGHmd0Hte2ae5n6l05eNsAuo+KG/Cy7usNLtcNC1P
	 pYFZIAhrwVFNc/tYmta5zV/MJHN5ThDBRnt0YGsfBdjrjD+pAuGj7Cj/ojhY2dN4iG
	 Woe8I/WZPOTCNuFvMjuhsMcHK/pP0C3QNREA3oqMo8wrdEK7qlZkCpdhbYQu9uY6KK
	 RNZZtRHkHoXOTutam4O2XxczSN2hvisXIzBMd9lU7Ux7aIOC545/Ceay4xPeuSe1pn
	 ny4UKd62ONoRA==
Date: Tue, 28 Oct 2025 16:06:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
	"K, Kiran" <kiran.k@intel.com>,
	"Ben Ami, Golan" <golan.ben.ami@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Message-ID: <20251028210640.GA1529794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7acf9a2f2cec5d00fc1581ad3a12b1f4b580b349.camel@sipsolutions.net>

On Mon, Oct 27, 2025 at 11:08:22AM +0100, Johannes Berg wrote:
> Hi,
> 
> So I've been asked to chime in here, mostly on behalf of iwlwifi, and
> I'll actually respond to two of your messages a bit.
> 
> (from your previous email first:)
> 
> > Sort of weird that the commit log mentions FLR, but it's not mentioned
> > in the patch itself except for BTINTEL_PCIE_FLR_RESET_MAX_RETRY.
> > Apparently the assumption is that DSM_SET_RESET_METHOD_PCIE performs
> > an FLR.
> 
> It's not just weird, it's simply wrong. This is not about FLR at all.

Thanks for clearing that up.

> > If you reset the device, you know the state of the device afterward,
> > and the driver should be able to initialize its own data structures
> > accordingly.  This should not require any PCI device removal or
> > rescan.
> 
> Obviously, we know the state of the device, but ... it _does_ require
> PCI removal *and* rescan, because the device completely falls off the
> bus and needs to be rediscovered. The drivers also fundamentally have to
> be unbound from it, since all state of the device (including BAR setup)
> is lost. I'm fairly certain that if you were to query even the device
> IDs after the reset, you'd see 0xFFFFFFFF, but in truth I don't fully
> understand how this works at the PCIe bus level.

It might be different for other buses, but the PCI core really doesn't
do anything to the device during removal or rescan.  It does turn off
power management interrupts from the device and the like, but I'm
pretty sure it doesn't reset the device or do anything to make it
start responding to PCI transactions again.

Obviously remove and rescan reinitializes the *driver* because the PCI
core calls the driver .remove() method, reads the Vendor and Device
IDs, reads and if necessary programs the BARs, and calls the driver
.probe() method.

I think it's really the PLDR that's making the difference here, not
the remove and rescan.  I guess you could experimentally read some
config registers after the PLDR and before the remove/rescan.

Since you know the other device is dead already, I don't have a
problem with resetting the shared parts of the device, so you do need
some way to poke the other driver to reinit.  But I think using the
PCI core remove/rescan to do that makes it more complicated than
necessary and distracts from what's really happening.

Bjorn

