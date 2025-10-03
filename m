Return-Path: <linux-pci+bounces-37500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 693CCBB5D08
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 04:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FA204EB9EA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 02:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F292DA77E;
	Fri,  3 Oct 2025 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="d7e4wvEP"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79112D7DD7
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759459058; cv=none; b=XMRrCVG8dAVW0HvdNpdqiSAN9YGVOCAfpaEyV9ZJXA4NY6xgSV/QKL6xIMfSF/6s29gdbOSuS7CoIvSD5Nylka9OKI8oeVSMsO+E1OgeBzjUnyztuaflE30kF7zdyiNBlZWk01WiGUe6GdvnpBO6Hj8FXIKDIAH/uuakGtTuG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759459058; c=relaxed/simple;
	bh=7rLggB2agViqZQrWye4hpzQS54FGR/0ccUoiJVdYMdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type; b=TWq+ZS2j4ju4Yiu7ZzfeD/cBsU/OOrrAnQXZOgXkGwLgBzdnx9F8kNCw9c0/bdC+ZhLao0RFLNlqlkNsNLooM2PV8fmf+GUUC9vCLHy9lH3gATv8VgboZMIz+a0Jzp7CqkLVBW6wK2mmtzQ04B3UVjdhOpZ+UBtV0Z5I/K4DKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=d7e4wvEP; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4cd9Kv35CxzDWY
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:59:31 -0400 (EDT)
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cd9KJ5c3Jz15Sd;
	Thu,  2 Oct 2025 20:59:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759453141; bh=7rLggB2agViqZQrWye4hpzQS54FGR/0ccUoiJVdYMdA=;
	h=Date:Subject:To:Cc:From;
	b=d7e4wvEPWWwoX8/Zd/QzJoBiEkV7YnTIJJN4VqYp0O1Srruw6yaLZFqr8utRCHj4+
	 2rpHmy/tPCb7/eDyk4TY5nrFkOrSmy0C3pODAGjhPrF7ANhtkOoLP4TOeJfPFw+2nD
	 9DCGfKlUyByVgFZLO/16jtShw1pmafup+SyeAZ1c=
Message-ID: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
Date: Thu, 2 Oct 2025 17:58:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Resending to re-add linux-pci (Vger thinks my tablet's MUA is "Spammy")

I'm going to figure out which line is is that's killing my NVMe IRQs.

FWIW, my NVMe is behind a VMD bridge(? I guess that's what it is):

----
-[0000:00]-+-00.0  Intel Corporation 12th Gen Core Processor Host 
Bridge/DRAM Registers
            +-02.0  Intel Corporation Alder Lake-P GT2 [Iris Xe Graphics]
            +-04.0  Intel Corporation Alder Lake Innovation Platform 
Framework Processor Participant
            +-05.0  Intel Corporation Alder Lake Imaging Signal Processor
            +-06.0  Intel Corporation RST VMD Managed Controller
            +-07.0-[01-3f]--
            +-07.2-[40-7e]----00.0-[41-7e]--+-00.0-[42]--
            |                               +-01.0-[43-56]--
            |                               +-02.0-[57-6a]--
            |                               +-03.0-[6b-7d]--
            |                               \-04.0-[7e]--
            +-08.0  Intel Corporation 12th Gen Core Processor Gaussian & 
Neural Accelerator
            +-0d.0  Intel Corporation Alder Lake-P Thunderbolt 4 USB 
Controller
            +-0d.2  Intel Corporation Alder Lake-P Thunderbolt 4 NHI #0
            +-0d.3  Intel Corporation Alder Lake-P Thunderbolt 4 NHI #1
            +-0e.0  Intel Corporation Volume Management Device NVMe RAID 
Controller
            +-12.0  Intel Corporation Alder Lake-P Integrated Sensor Hub
            +-14.0  Intel Corporation Alder Lake PCH USB 3.2 xHCI Host 
Controller
            +-14.2  Intel Corporation Alder Lake PCH Shared SRAM
            +-14.3  Intel Corporation Alder Lake-P PCH CNVi WiFi
            +-15.0  Intel Corporation Alder Lake PCH Serial IO I2C 
Controller #0
            +-15.1  Intel Corporation Alder Lake PCH Serial IO I2C 
Controller #1
            +-16.0  Intel Corporation Alder Lake PCH HECI Controller
            +-1e.0  Intel Corporation Alder Lake PCH UART #0
            +-1e.3  Intel Corporation Alder Lake SPI Controller
            +-1f.0  Intel Corporation Alder Lake PCH eSPI Controller
            +-1f.3  Intel Corporation Alder Lake PCH-P High Definition 
Audio Controller
            +-1f.4  Intel Corporation Alder Lake PCH-P SMBus Host Controller
            \-1f.5  Intel Corporation Alder Lake-P PCH SPI Controller
-[10000:e0]---06.0-[e1]----00.0  SK hynix Platinum P41/PC801 NVMe Solid 
State Drive
----

On 10/2/25 17:42, Kenneth R. Crudup wrote:
> 
> Yeah, it's definitely IRQ/NVMe related (this is a Google Lens 
> transcription of a camera picture, but it's close enough):
> 
> ----
> 1206] thunderbolt 0000:00:00.3: 0:5 <-> 1:13 (DP): not active, tearing down
> T167] thunderbolt 0000:00:00.3: 0:6 <-> 1:13 (DP): not active, tearing down
> 
> 199] nume nume0: 1/0 tag 20 (1014) QID O timeout, completion polled
> 
> 11511 nume nume0: 20/0/0 default/read/poll queues
> -----
> 
> ... and it does limp forward and continues a bit, then oops in an IRQ 
> routine somewhere (getting that next).
> 
> So, anything I can try to solve this? (I've since updated to Linus' 
> master as of a few mins ago, FWIW).
> 
> Thanks, Kenny
> 
> --
> Sent from my Tab S9+
> 
> 
> -------- Original message --------
> From: Inochi Amaoto <inochiama@gmail.com>
> Date: 10/2/25 16:46 (GMT-08:00)
> To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
> Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
> linux-pci@vger.kernel.org
> Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per 
> device domains") causing boot hangs on my laptop
> 
> On Thu, Oct 02, 2025 at 04:42:40PM -0700, Kenneth Crudup wrote:
>  >
>  > On 10/2/25 16:37, Inochi Amaoto wrote:
>  >
>  > > I think it is good to have some more information like call trace to 
> know
>  > > whether is caused by this change, or the side effect from other commit.
>  >
>  > Yeah, let me make a branch with the commits back in place, then see 
> if I can
>  > get the traces in pstore.
>  >
>  > > I also suggest adding someone related to the xe driver ...
>  > Nah, I honestly think it may be related to VMD or my NVMe; it's like 
> it does
>  > everything it can except do disk I/O.
>  >
> 
> If this is related to the NVMe, I think you can check dmesg to see if 
> there is
> some log like "nvme nvme0: I/O tag XXX (XXX) QID XX timeout, completion 
> polled",
> which indicate the NVMe is broken.
> 
> Regards,
> Inochi
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


