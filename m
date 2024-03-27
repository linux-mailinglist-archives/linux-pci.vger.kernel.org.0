Return-Path: <linux-pci+bounces-5265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5088EB07
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AE2B39811
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A212FB1A;
	Wed, 27 Mar 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo77l+r0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93112DD8C;
	Wed, 27 Mar 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551681; cv=none; b=bUQFzOFVW4PjbkZPEMkCNB+9ASelrGEAjQryuB87FbcJsDUY5MsbZ3wjX5kEmBYOuIodgSyGrUD/4Pxt6H+o6OdTVwVe6xjRM4ALN9fr3clhpc+P7UMydQ0TkRXenBo9z3/6Yl6UarBQ3BO9FAXYJiwlmaI+xI0rhN+A80eOHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551681; c=relaxed/simple;
	bh=J1IG8WkI6niRQrYbH+CydZSlvMPIcnN9NC49WgCaKEw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sIENnrYZbudch08Y6YLDYKVOAHrEdE7DFHUnMPI8REgiaq0aTTgSdBeu3OBVpvvF0MrJdYWOasiedwPGGzdHEW0xy/mV6rZJXL54SFta1xsvK28D526fO0nHqHs9us7IE35EP2JzRQ+F3qr1B8pRwgbMhIOEFg2YgeBUhlcgT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo77l+r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B7C433C7;
	Wed, 27 Mar 2024 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711551681;
	bh=J1IG8WkI6niRQrYbH+CydZSlvMPIcnN9NC49WgCaKEw=;
	h=Date:From:To:Subject:In-Reply-To:From;
	b=bo77l+r08VyDZusL1lvJnpzTbDKMRv9t4X1x1fCDXF46NEQyN+IYLIMUCNyueHvI5
	 MJzQOpz592+f8p7AkgJHyedVolLcSTVW1rlbd4c2xdqkLN/1hUPNgz5k6E31J4f0dR
	 3wA0Ikqadfq/CFtSAKlsj0vVrJ1Znhs+8aP07qRJNhpBG8mQYhlxtZbCdX2WMOHDU1
	 dLObMKbsv8ZHgqdgncISiemEknX8SLgv59zuxPyt7SzZh3dr2VvC/eIB669gge5i4G
	 mmSkX67k0fqpWC46zqBAtBYftCYEfgLhyblyADWKH+IjTwDNeUfUUFiokFyjZUib/R
	 anoC4aWasDf5A==
Date: Wed, 27 Mar 2024 10:01:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240327150119.GA1502858@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326131858.GA140624@workstation.local>

On Tue, Mar 26, 2024 at 10:18:58PM +0900, Takashi Sakamoto wrote:
> On Mon, Mar 25, 2024 at 09:41:49AM -0500, Bjorn Helgaas wrote:
> > So even without this patch, you are able to pass the FW643 to a VM
> > with VFIO, and you don't see any issues caused by VFIO resetting the
> > device?
>  
> Absolutely yes, at least in my VM, for recent years to maintain Linux
> FireWire subsystem and ALSA firewire stack.

So there must be something different between your system and Edmund's.
Maybe we can refine the quirk so it avoids the SBR on Edmund's system
but not yours.

Can you both collect the output of "sudo lspci -vvv" so we can try to
figure out the difference?  Also a complete dmesg log would be helpful
and would contain DMI information that we might need if this is
firmware dependent.

> > Can you collect the output of:
> > 
> >   $ find /sys/devices -name reset_method | xargs grep .

Edmund, could you run this command, too?

Thanks,
  Bjorn

