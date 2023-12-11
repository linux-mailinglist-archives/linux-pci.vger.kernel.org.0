Return-Path: <linux-pci+bounces-754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D4280D105
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 17:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02D81F210E2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6884C62B;
	Mon, 11 Dec 2023 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAJaRjf5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76F4C612;
	Mon, 11 Dec 2023 16:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE848C433C7;
	Mon, 11 Dec 2023 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702311518;
	bh=EiRoc1cO0j90XBlz9u2jZ9jEQ9O9yX4Cj8QCkAu5xkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OAJaRjf5oBZ/VBOaEWZzCHoChUAxp7lVTVjYQjo7CFnB1HCzhfUio+urhKAOyCKT/
	 75a513cv4JDi7SCJaldhok3Gs/TAvHaFsHypYVOxfk1yXBd85VrEPI55QQSKUUjzH0
	 xs5MIS3xflkyKg/egH+Aqssb3MybsQ05It3ic6j5WOsjaRGjxVwhJzfrJr0Xe+nWIJ
	 lmyWRVekFIp+n0sCuocFqgfFb5gv+06/MfdYGLvcNTYh/8U0koGNMOjGY7R/bYpxAg
	 NvEUT1k1OhkqpgNxErlImygqJUFZJZOFQcGxML7YQpjD+7d75aL4JG7j+o/Fpl/QMp
	 RfWQFq9N7gEjg==
Date: Mon, 11 Dec 2023 10:18:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231211161836.GA914318@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5121397-2a40-4c77-9dd3-8f0f47ec1360@proxmox.com>

On Mon, Dec 11, 2023 at 03:53:46PM +0100, Fiona Ebner wrote:
> Am 11.12.23 um 15:12 schrieb Bjorn Helgaas:
> > On Mon, Dec 11, 2023 at 02:52:42PM +0100, Fiona Ebner wrote:
> >> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> >>> On Fri, 8 Dec 2023 16:47:23 +0100
> >>> Igor Mammedov <imammedo@redhat.com> wrote:
> >>>> On Thu, 7 Dec 2023 17:28:15 -0600
> >>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>
> >>>>> What's the actual symptom that this is broken?  All these log
> >>>>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> >>>>> bridge windows.
> >>
> >> The disk never shows up in /dev
> >>
> >>>>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> >>>>> bridge leading to it?
> >>>>>
> >>>>> Can you put the complete dmesg logs somewhere?  There's a lot of
> >>>>> context missing here.
> >>
> >> Is this still necessary with Igor being able to reproduce the issue?
> > 
> > Only if you want help resolving the problem.  I don't have time to
> > guess what interesting things might be missing and go back and forth
> > to get them.
> > 
> 
> I put the output of dmesg with my original QEMU commandline and kernel
> 6.7.0-rc3 here:
> 
> https://pastebin.com/UvpGAYf2

Thanks, I opened https://bugzilla.kernel.org/show_bug.cgi?id=218255
and attached this dmesg log there so this doesn't get lost or expired
from pastebin.com.

IIUC this is a log from when it fails.  Can you attach the
corresponding log when it works correctly?

Bjorn

