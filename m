Return-Path: <linux-pci+bounces-12453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE5964BC6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 18:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630FF1C22984
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD41B3F14;
	Thu, 29 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEyDv9T9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0771B3737
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949321; cv=none; b=RVVv2iOxDR8qksjrZoy1z/oG2z4LagxfXqLE6rV8Gne9pASA3PYjxC90MBPl2LK5fKsK8xxlNtfm8SF3divnS5XIBF+YxKdKaOKCc1d9hsiThU9nJiEgL8GLnhHKWbXMq1H3v54z/tLisCfy7KKaIBU2z/CeN1Dc7ILizaoU78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949321; c=relaxed/simple;
	bh=hP2f+lTqndWxqgdfi98tPwK5BWuuWPZj75TkZXgVj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J0mndjejDwpUJaxndtc/sD8dpIEXqJZN5oyDlBOU+gmRkbhb/KCM6joYS6ZhGji+wGobOXV+A/PdUdFYsx6ogV3H12L9f6F7ByxjkAqpBS2isqK98gDPfNsZlkxtkJYBjJZzVU0nxVkocOkp9I0i9XgtKyJMNS5TqVl2hr3RxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEyDv9T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B564DC4CEC1;
	Thu, 29 Aug 2024 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724949321;
	bh=hP2f+lTqndWxqgdfi98tPwK5BWuuWPZj75TkZXgVj4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LEyDv9T9pStlbk+NNG98BVPfI20k7gvggQryzgZQMKv4upGdGLZLfXF5BH3NHn/x7
	 kd2ITtlNSN+AuRxIP7xbxeY4KQLmiiYZYoU1uu793IGn3fJOEG1e04g9miCiCfb3+U
	 5FXwLvvYZ83J2PoSSh/BrQfHzr3uJtY2unztbv7Xy2kRYwg7R0FR2iyyWeBofHBHqK
	 By7/XuSBvBUzhVYxTI+hokEbMEH6ZaaQWEnpZMI7ZJ54LljjexoNfboyw8UH+YHiBH
	 FMDSAMxvwmZUrxiWcj7hSYa5kGh5ee4bTUf7bu83s8b90lEcmpxQn6wA9lOwvw/VW+
	 udH5w0kp2INYA==
Date: Thu, 29 Aug 2024 11:35:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Erin_Tsao@wistron.com
Cc: linux-pci@vger.kernel.org, mj@ucw.cz
Subject: Re: Issue about PCI physical slot fetch incorrect number
Message-ID: <20240829163518.GA39705@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd9ff2b16c44efca61189850fb0fe02@wistron.com>

On Mon, Aug 26, 2024 at 08:27:09AM +0000, Erin_Tsao@wistron.com wrote:
> Hi Bjorn,
> Sorry for the late response. And thanks for responding to my question.
> There's a few thing I would like to clarify with you.
> 1. Is the physical slot number associate with the configuration of
> device itself or with the configuration of device's parent?

A PCIe device doesn't know its own slot number.  The bridge leading to
a slot (either a Root Port or a Switch Downstream Port) has the Slot
Capability/Status/Control registers that manage the slot.  The Slot
Capabilities register contains a "Physical Slot Number".  This is
HwInit, which means it's set by hardware or firmware, and it's
supposed to be a number that's unique within the chassis.

The "Physical Slot" reported by lspci for Endpoints comes from sysfs,
not from the device itself.  See
https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/sysfs.c?id=v3.13.0#n277

From team1 lspci-vvv:

  20:01.1 Root Port to [bus 21-34] Slot #0
    21:00.0 Broadcom Switch Upstream Port to [bus 22-34]
      22:00.0 Broadcom Switch Downstream Port to [bus 23] Slot #308
        23:00.0 Broadcom Endpoint 02b2 "Physical Slot: 308"
      22:01.0 Broadcom Switch Downstream Port to [bus 24] Slot #306
        24:00.0 Broadcom Endpoint 02b2 "Physical Slot: 306"
      22:02.0 Broadcom Switch Downstream Port to [bus 25-2a] Slot #213
        25:00.0 Mellanox Endpoint MT2910 "Physical Slot: 213"
      22:03.0 Broadcom Switch Downstream Port to [bus 2b-30] Slot #203
        2b:00.0 Broadcom Endpoint 02b2 "Physical Slot: 203"
      22:04.0 Broadcom Switch Downstream Port to [bus 31-33] Slot #101
        31:00.0 AMD Switch Upstream Port to [bus 32-33] "Physical Slot: 101"
          32:00.0 AMD Switch Downstream Port to [bus 33] Slot #0
            33:00.0 AMD Endpoint 74a1 "Physical Slot: 0-6"

I don't know off the top of my head why lspci doesn't report a
"Physical Slot:" for 21:00.0.  I suppose the kernel didn't provide
something in /sys for it.

All the other "Physical Slot:" reports from lspci match the "Physical
Slot Number" from the PCIe Capability of the bridge leading to the
slot, *except* for 33:00.0.  In that case, the "Physical Slot Number"
from the bridge PCIe Capability is not unique.  Both 20:01.1 and
32:00.0 advertise Slot #0 there, so the kernel make the sysfs slot
unique, e.g., "0-6".

From lspci_vvv_team2.txt:

  39:00.0 Broadcom Switch Downstream Port to [bus 3a] Slot #166
    3a:00.0 Samsung Endpoint NVMe "Physical Slot: 166"
  39:01.0 Broadcom Switch Downstream Port to [bus 3b-3d] Slot #24 "Physical Slot: 24"
    3b:00.0 AMD Switch Upstream Port to [bus 3c-3d]
      3c:00.0 AMD Switch Downstream Port to [bus 3d] Slot #0
        3d:00.0 AMD Endpoint MI300X
  39:02.0 Broadcom Switch Downstream Port to [bus 3e] Slot #39 "Physical Slot: 39"
    3e:00.0 Mellanox Endpoint

This seems strange to me.  For 39:01.0, lspci reports "Physical Slot:
24", but 39:01.0 is a Downstream Port that *leads* to a slot; it's not
a slot itself.  3b:00.0 is the device in that slot, and I think it
should have a slot number, but it doesn't.

Similarly, lspci reports "Physical Slot: 39" for 39:02.0, when it
should show 3e:00.0 being in slot 39.

I guess this team2 situation is what you're trying to understand?

Can you collect the complete dmesg log and output of "grep -r .
/sys/bus/pci/slots" for both team1 and team2?  We should be able to
puzzle out what's going on.  The dmesg logging will show which hotplug
drivers are in use and should have hints about slot numbering, and if
it doesn't, we may need to add some.

> 2. As my understanding, we also have another team using AMD GPU
> MI300. And I have discovered that lspci -xxx have some difference
> between our team(team 1)  and their team (team 2). The difference is
> that when we dump the file of lspci -xxx, the content only listed to
> 0xff, however, another team listed the content till 0xfff, which
> means that they have additional content from 0x100 to 0xfff.

>   ->Is there any setting of OS that we can enable in order to see
>   the whole content?

I think "lspci -xxx" will only show you 0-0xff unless lspci is run as
root.

>   ->Will these additional content related to the physical slot
>   number? Or have any impact on showing the physical slot number?

I don't think so.  The Slot Capability/Status/Control registers are in
the PCIe Capability, which should be below 0xff.

Bjorn

