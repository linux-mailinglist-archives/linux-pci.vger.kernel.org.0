Return-Path: <linux-pci+bounces-4276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A0586D310
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 20:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30491F22C60
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E513C9C2;
	Thu, 29 Feb 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2zY3ncs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFE7A140;
	Thu, 29 Feb 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234801; cv=none; b=fPsx/fn2jhsSUKafomwLOV4Wgdr8rcAtsCLQifSnxPhlzY8IvoE5814DpdhxsbNsi2uf0HsSVyIYdRVP0GlPueMMSNOG0AwRoWl0lCBlVFn5B2uGuCq2W8twGCtfudn9KWNcq3w039hBsDGUlIDKzl2JILG74+l2ax7qYZXt0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234801; c=relaxed/simple;
	bh=+k9lxLjUm+D20rV0ZetrkJ4GbTv5jE0llwdBdYuTomM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=USxWZUCW6rpGnulGenqC4zDyDzxv8qfrOlITQGnIMkW4ZczcdVT79eIEgTVfL4iec8ddePjcBpwNu3UN9XbEfTwsvXHkiXBQ+CyBNKEpU7DRITbwow2OBHLeCcVnmotGR2vhb/EsiKneo/FwvAMxSjU7Z27Pw3np/hsi/yrwNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2zY3ncs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120DEC433C7;
	Thu, 29 Feb 2024 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709234801;
	bh=+k9lxLjUm+D20rV0ZetrkJ4GbTv5jE0llwdBdYuTomM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P2zY3ncsHkHmLWClE0zPZ44INslXD32URU8p5wb5wJbZ5oiBwIAeeFjqnSSM8RjUB
	 jUajOXmfiBM6+5ksQsCBfG1QK5Ooo8+e463W2LZuq+etT+MrjQ/3m4Ry+Tfe1e9qvA
	 +Ac1ZFkJXgAssJe4loBZV5eXfJfJTc743dNuEdPCbYh/qmT+OCkdSPviYqQ7FOztqU
	 aCpd75peVSOZmXUWNuy9GQpRVG+OJANKNz7es/F1QABA/vNfUdsVioKLd0SeKDH+pN
	 VgtNqFpYFhacG7JDZ35+rJulP85yQBalp7qn6PaeTfzvSR1SYQvm+Z0U9hzQwDznCJ
	 EWSQT5dKU2Qiw==
Date: Thu, 29 Feb 2024 13:26:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	david.e.box@linux.intel.com, mario.limonciello@amd.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [PATCH v3 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
Message-ID: <20240229192639.GA356181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jhEE9X50TGaXpwFA89wfQb8HYK9qNRnhhuYjU6oM84eg@mail.gmail.com>

On Thu, Feb 29, 2024 at 06:38:01PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 28, 2024 at 11:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+to Rafael]
> >
> > On Wed, Feb 28, 2024 at 08:53:16AM +0100, Daniel Drake wrote:
> > > This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
> > > was originally put in place to work around a s2idle failure on this
> > > platform where the NVMe device was inaccessible upon resume.
> > >
> > > After extended testing, we found that the firmware's implementation of
> > > S3 is buggy and intermittently fails to wake up the system. We need
> > > to revert to s2idle mode.
> > >
> > > The NVMe issue has now been solved more precisely in the commit titled
> > > "PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
> > > Acked-by: Jian-Hong Pan <jhp@endlessos.org>
> > > Signed-off-by: Daniel Drake <drake@endlessos.org>
> >
> > Rafael, if you're OK with this, I can queue both patches for v6.9.
> 
> Yes, please!
> 
> Feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org
> 
> to both.

Both patches applied with Rafael's ack to pci/pm for v6.9, thanks!

Bjorn

