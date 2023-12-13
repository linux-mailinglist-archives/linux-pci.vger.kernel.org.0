Return-Path: <linux-pci+bounces-889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B5811C02
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD60C1F215C7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905515A0FC;
	Wed, 13 Dec 2023 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX7QEjno"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927C59527;
	Wed, 13 Dec 2023 18:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAD9C433C8;
	Wed, 13 Dec 2023 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702491076;
	bh=DSiErSlPeiuZHKb7NJWMA2u0Y0HWFXxL9sLwA8/tUYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FX7QEjnoKh72ueYdqD74yg05wXYTxMVUztUw7TdfxupRtYLKoHIGYJsP11rYCTQTo
	 uouhlxVXtBC887SAwVBb2yYOQa7RH4MrEYgKX87qK4bOiWqPPkpxqFjPcU601TN7hL
	 3Y0w4pGKpX4nIhjLB0nfK2THpQRnnGuPmwgLix/TXa+9n+BK9+hlXUHWdpyFI4Io3g
	 BuXr8NgPUAxhJZrmzByMoXBeHYq8iJHblN+8jdDxw66md/V3s8P2fCj3+F1CPH3oNl
	 77uySKk2deCI6nau+9Rd9hSX6X6qf/SM7mcEvXTGHk0J0gEcAG6wcmkdS55T54Eti7
	 3ObQIm+NmM4Bw==
Date: Wed, 13 Dec 2023 12:11:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, mika.westerberg@linux.intel.com,
	boris.ostrovsky@oracle.com, joe.jin@oracle.com,
	stable@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [RFC 0/2] PCI: acpiphp: workaround race between hotplug and
 SCSI_SCAN_ASYNC job
Message-ID: <20231213181115.GA1050010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213003614.1648343-1-imammedo@redhat.com>

On Wed, Dec 13, 2023 at 01:36:12AM +0100, Igor Mammedov wrote:
> Hacks to mask a race between HBA scan job and bridge re-configuration(s)
> during hotplug. 
> 
> I don't like it a bit but it something that could be done quickly
> and solves problems that were reported.

I agree, I don't like it either.  Adding a 1s delay doesn't address
the real problem, and putting in a band-aid like this means the real
problem would likely never be addressed.

At this point the best option I see is to revert these:

  cc22522fd55e2 ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
  40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary")

I hate the fact that reverting them would mean the root bus hotplug
and ACPI bus check notifications would become issues again.

But keeping these commits even though they add a new different problem
that breaks things for somebody else seems worse to me.

Bjorn

> Other options to discuss/possibly more invasive:
>  1: make sure pci_assign_unassigned_bridge_resources() doesn't reconfigure
>     bridge if it's not necessary.
>  2. make SCSI_SCAN_ASYNC job wait till hotplug is finished for all slots on
>     the bridge or somehow restart the job if it fails
>  3. any other ideas?
> 
> 
> 1st reported: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com
> 
> CC: Dongli Zhang <dongli.zhang@oracle.com>
> CC: linux-acpi@vger.kernel.org
> CC: linux-pci@vger.kernel.org
> CC: imammedo@redhat.com
> CC: mst@redhat.com
> CC: rafael@kernel.org
> CC: lenb@kernel.org
> CC: bhelgaas@google.com
> CC: mika.westerberg@linux.intel.com
> CC: boris.ostrovsky@oracle.com
> CC: joe.jin@oracle.com
> CC: stable@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Fiona Ebner <f.ebner@proxmox.com>
> CC: Thomas Lamprecht <t.lamprecht@proxmox.com>
> 
> Igor Mammedov (2):
>   PCI: acpiphp: enable slot only if it hasn't been enabled already
>   PCI: acpiphp: slowdown hotplug if hotplugging multiple devices at a
>     time
> 
>  drivers/pci/hotplug/acpiphp_glue.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> -- 
> 2.39.3
> 

