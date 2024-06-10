Return-Path: <linux-pci+bounces-8553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDF902975
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 21:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00578282AFD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0D14D45A;
	Mon, 10 Jun 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6lJBmeD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896314D449
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048559; cv=none; b=Q6pW0ELjd+qfuF+LZGGw35dyNtONwpVj+kjTgzWgofcDNh2JUGjKlO0UTtZT7jCqOH0gbAzAxFB/G00V+15XtsI+hR8jFgL8IiRMOT/sMpiQw1Gwl286XyXQq17OipSCrcqs3QX/XUcbtaGr4xaKSexsBsVBw9O5yU0tSHa2Qxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048559; c=relaxed/simple;
	bh=QSAGLDQ63SQRF/cky4WCaOl6TodA5EsuTJ2HcRYVd6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lPHYS81kxH9tbYBcOO+yGQaKQc10eEmCIRMvK5Cj64jWDKs3Ja4AJQo978ckTLoAiv1armjT9H0z/w6kf/Fl+KHNW9oGd+yd+jRJ4IKG3E9xklV6j62/DlicxNRcm/bXQS+40PG/HN6RxCiH0r5DyqEwO4olgFaiORuVY4O2h+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6lJBmeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC96EC2BBFC;
	Mon, 10 Jun 2024 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718048559;
	bh=QSAGLDQ63SQRF/cky4WCaOl6TodA5EsuTJ2HcRYVd6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y6lJBmeDzPbT1xzGmIcDa3u8FL2/4RWqszB/H+/2YuMmQf6XcHg84qP9H0Ai+ZTTO
	 r79BWc40RnHnDi6DDdy1MGhYi0/0li5a+jpDUPse0xtzQWz4z3WX7qE2gd9xnnVeE+
	 bSmY8PVDzLYZ3mdOCseWyjgPDR25ndShkhuu8ueCImsyrh4j/Hmh6qyx0mJ/EDL8DD
	 iQyvLGUGh9haaWZ3uKnNTOQ0Swjn34aUHR6FQRwC1BPQ4izBIO2pcCL7JFmM354lVH
	 FYlhCL3SIRgfqFjDgzHMS+frr6DvEqvX6957UjZptC97aRTUj99Urx3sfCepe95UbM
	 5ipU/hwQlO5AA==
Date: Mon, 10 Jun 2024 14:42:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
Message-ID: <20240610194236.GA954050@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de>

[+cc Yunsheng, thread at
https://lore.kernel.org/r/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]

Thanks very much for this report!

On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
> On the servers below Linux warns:
> 
>      Unknown NUMA node; performance will be reduced

This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
NUMA node info"), which appeared in v5.5, so I assume this isn't new.

That commit log says:

  In pci_call_probe(), we try to run driver probe functions on the node where
  the device is attached.  If we don't know which node the device is attached
  to, the driver will likely run on the wrong node.  This will still work,
  but performance will not be as good as it could be.

  On NUMA systems, warn if we don't know which node a PCI host bridge is
  attached to.  This is likely an indication that ACPI didn't supply a _PXM
  method or the DT didn't supply a "numa-node-id" property.

I assume these are all ACPI systems, so likely missing _PXM.  An
acpidump could confirm this.

I think the devices on buses 7f and ff are Intel chipset devices, and
I doubt we have drivers for any of them.  They have vendor/device IDs
of 8086:6fXX, and I didn't see any reference to them:

  $ git grep -i \<0x6f..\>
  $ 

If we *did* have drivers, they would certainly benefit from having
_PXM, but since there are no probe methods, I don't think it matters
that we don't know where they should run.

Maybe the message should be downgraded from "dev_warn" to "dev_info"
since there's no functional problem, and the user can't really do
anything about it.

We could also consider moving it to the actual probe path, so we don't
emit a message unless there is an affected driver.

> 1.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.13.0 05/14/2021
> 2.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5 09/06/2016
> 3.  [    0.000000] DMI: Dell Inc. PowerEdge R730xd/0WCJNT, BIOS 2.3.4 11/08/2016
> 4.  [    0.000000] DMI: Dell Inc. PowerEdge R910/0KYD3D, BIOS 2.10.0 08/29/2013
> 5.  [    0.000000] DMI: Dell Inc. PowerEdge R930/0T55KM, BIOS 2.8.1 01/02/2020
> 6.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.5.4 08/17/2017
> 7.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.5.4 10/04/2015
> 8.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.11.0 12/23/2019
> 9.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.1.5 04/13/2016
> 10. [    0.000000] DMI: Supermicro Super Server/X13SAE, BIOS 2.0 10/17/2022
> ...

> 7f:08.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f80] (rev 01)
> 7f:08.2 Performance counters [1101]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f32] (rev 01)
> ...

> ff:08.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f80] (rev 01)
> ff:08.2 Performance counters [1101]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f32] (rev 01)
> ...


> [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.4.2 01/09/2017
> ...
> [    4.398627] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
> [    4.437865] pci_bus 0000:ff: Unknown NUMA node; performance will be reduced
> ...
> [    4.901021] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
> [    4.940865] pci_bus 0000:7f: Unknown NUMA node; performance will be reduced

