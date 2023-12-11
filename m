Return-Path: <linux-pci+bounces-751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D080CE0C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 15:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E641F20FD3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD791487AA;
	Mon, 11 Dec 2023 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMvOiZRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D138FA0;
	Mon, 11 Dec 2023 14:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E3FC433C7;
	Mon, 11 Dec 2023 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303961;
	bh=VSph1+fDNCCmhnH5sf325cICVCA/0HcmwAI98VOjb3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RMvOiZRfsxo0D0aifsVlT6iRoA2ASvw2N5g5t3lz9qph8BTBSRPWbuNliN9AcMgAq
	 rfFqIRuS0A9mnwguzYjdhQRnb/V+EwMaStALoD6SDzbG+rstYEWC329FQ/bmCAfQkC
	 I2VOmPuHGA0rUxupUX/CXe7XYV3vyb5ewiuDojQwks9O+xqZOUDzndCerhgAM+6oer
	 2LjhqpO4iGI3FdDLReTemWW0StCkxcsAN2SrNo6ZUqAteW9BML4CIjFn47EaFxQsON
	 4q4sze+3aaQSPxgG6WzcvdqRq4KWj6g0P6JvbbSYQyc10u1MayxOkObUI9FdDUQ6D+
	 Q2Gcla2zwD/1A==
Date: Mon, 11 Dec 2023 08:12:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231211141239.GA909479@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>

On Mon, Dec 11, 2023 at 02:52:42PM +0100, Fiona Ebner wrote:
> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> > On Fri, 8 Dec 2023 16:47:23 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >> On Thu, 7 Dec 2023 17:28:15 -0600
> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >>> What's the actual symptom that this is broken?  All these log
> >>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> >>> bridge windows.
> 
> The disk never shows up in /dev
> 
> >>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> >>> bridge leading to it?
> >>>
> >>> Can you put the complete dmesg logs somewhere?  There's a lot of
> >>> context missing here.
> 
> Is this still necessary with Igor being able to reproduce the issue?

Only if you want help resolving the problem.  I don't have time to
guess what interesting things might be missing and go back and forth
to get them.

> >>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> >>> work reliably?  If we have to revert something, reverting one would be
> >>> better than reverting both.  
> 
> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> 40613da52b13f so I can't revert just 40613da52b13f).

OK, thanks.  So it sounds like our options are to fix it or to revert
both.  I'm going to be on vacation Dec 16-25, so we have about 3-4
days to figure something out.

Bjorn

