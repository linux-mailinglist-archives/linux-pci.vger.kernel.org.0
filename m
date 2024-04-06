Return-Path: <linux-pci+bounces-5823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FF89AC5B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6391C20A4A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F13C087;
	Sat,  6 Apr 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRJV6jFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4E3BBDC;
	Sat,  6 Apr 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422436; cv=none; b=H7kn1EqZqn5IWNTqcm8nce8/W4T26lzJpJdYR+fTgazGu3W+nV5lOx2UgB377j9mIPWAGQoBmAKZaqtDrazgHCMgLVXEGBDL4cQrgfWlOmar5sRKbV+uQR4CMSxadpLyCsx09L5o/7FnlPAl/QoZLDjCPwBiknFTgh8KgbwVC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422436; c=relaxed/simple;
	bh=1qimZkep5xZiQzyu2eUxcP7jnhAfGtPqwZw7vfyWuX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSe2e/S4Kmh/SNnfPauTVK4sjal2J5ODMgf1rQ5gnIBSU+vEP0L9mt5wHK6MwHlXrCBki6XBgoKobKwQi08T08S2wutE+O4w9ia/VJ4mWNvw40vste1NKfLP8PqSSZsxjwL++Vmet6YHbwMx3dBZ1k96fK2MxaAdfVfBIjO4n0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRJV6jFY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4155819f710so24145125e9.2;
        Sat, 06 Apr 2024 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712422433; x=1713027233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psv/GlMaJGOOpJ57JXOaGrX+rNDJiD7uMq/kkvE+Bek=;
        b=eRJV6jFYZNd+4vTHb/I5ehza2JsMDT+y/SLkLIGkhJ9S6ZNXaXf3LM63y+ZPceXEBc
         2cXnAjqPCEP359Ciaz+3/QHHj60DBFWqm8SNN0GqNTx0DO1D9/ObYwi1qUGc+hf+9mrP
         1EQcvdbvAzPc0S1c4DKORzhsGyeuYpzTXsFSVMJILNKmm8OujnYIRVDjzzxeA1vWVcCX
         QQ9eZf16iaTnVL55LsQXT4BBWCJjynYNK8Pp0pTdQnGYaBqD9Wjxedt5gdbDmy8l3/FG
         1UcJ+7PLcweL8YMwCxco22orBtOujYqvRv1srrpt1tuZhiI/RcGhrS92dHVGCTCIV4Wu
         tQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712422433; x=1713027233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Psv/GlMaJGOOpJ57JXOaGrX+rNDJiD7uMq/kkvE+Bek=;
        b=hLAhGgatvmpHl78TMydSSM9GvLm1XkV4zBkjd1vUz5KHY41OOmGRC83Ek8IjgHvTKZ
         W0dVGqyKm98v6T7eCI5psfJ73HILSLsfu82Ne1jVkfWis7EvQUcgOJclh6wW0MaRufUW
         S9FIr5cUWbrgEVo2yMPvS/hY10jgIANBg0mNvpUvaP9hiEObw726KPG93xER+8rfdwye
         2wMvAeApU0nfiVYN6ShWN59Y0lSKCvfxOHZljZFPFhizzOM8RQAqbTVzlOOXL31OHAfZ
         uU4JOlQhxFFouJVyUoOrqt8MOG7GG8UX0Kro1FyHVdkckxT1pLIYlaASTGbNAnDv0Coq
         e7zA==
X-Forwarded-Encrypted: i=1; AJvYcCWRqCL+u7HvJ3IzNYZLGWzJzq8SXydzS27WFE7ZJqHtJdZj478RlDPZH8nnxj3wvD1fvktGzpI6kxdS/uqJLmjG61TMXvRpqIPs
X-Gm-Message-State: AOJu0YwW+naqWPNDukb1mpdvv4sewxqCYlnGX1/EE6rM1Bt9ptRrrf6w
	qChskpAsBT2DMRa0yPjZsZ0RZWbPwDhS1UczHhZ4o0NgSwuZRBf6mFk1k8fC9CzmdU2qllBTri2
	87zBVihgDsCGe3TgdRahPANyrVxo=
X-Google-Smtp-Source: AGHT+IEr/ZC7bg3T6FL3ts+enqO0RPp0z+8ObaTMkbwmh2q/ANGhD5zZy7UVU7h5ip0bpsJtirwUI5VuNah7yz+R/SU=
X-Received: by 2002:a05:600c:34d4:b0:416:5192:9c8 with SMTP id
 d20-20020a05600c34d400b00416519209c8mr77613wmq.5.1712422433136; Sat, 06 Apr
 2024 09:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <1f8af726-9ec1-4c93-a126-6672b5647c23@intel.com>
In-Reply-To: <1f8af726-9ec1-4c93-a126-6672b5647c23@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 6 Apr 2024 09:53:16 -0700
Message-ID: <CAKgT0Uf2VYxOseVcenNydAXXA9acgjkePQN4tjyZzJguTWj3mA@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 7:01=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 4/3/24 22:08, Alexander Duyck wrote:
> > This patch set includes the necessary patches to enable basic Tx and Rx
> > over the Meta Platforms Host Network Interface. To do this we introduce=
 a
> > new driver and driver and directories in the form of
> > "drivers/net/ethernet/meta/fbnic".
> >
> > Due to submission limits the general plan to submit a minimal driver fo=
r
> > now almost equivalent to a UEFI driver in functionality, and then follo=
w up
> > over the coming weeks enabling additional offloads and more features fo=
r
> > the device.
> >
> > The general plan is to look at adding support for ethtool, statistics, =
and
> > start work on offloads in the next set of patches.
> >
> > ---
> >
> > Alexander Duyck (15):
> >        PCI: Add Meta Platforms vendor ID
> >        eth: fbnic: add scaffolding for Meta's NIC driver
> >        eth: fbnic: Allocate core device specific structures and devlink=
 interface
> >        eth: fbnic: Add register init to set PCIe/Ethernet device config
> >        eth: fbnic: add message parsing for FW messages
> >        eth: fbnic: add FW communication mechanism
> >        eth: fbnic: allocate a netdevice and napi vectors with queues
> >        eth: fbnic: implement Tx queue alloc/start/stop/free
> >        eth: fbnic: implement Rx queue alloc/start/stop/free
> >        eth: fbnic: Add initial messaging to notify FW of our presence
> >        eth: fbnic: Enable Ethernet link setup
> >        eth: fbnic: add basic Tx handling
> >        eth: fbnic: add basic Rx handling
> >        eth: fbnic: add L2 address programming
> >        eth: fbnic: write the TCAM tables used for RSS control and Rx to=
 host
> >
> >
> >   MAINTAINERS                                   |    7 +
> >   drivers/net/ethernet/Kconfig                  |    1 +
> >   drivers/net/ethernet/Makefile                 |    1 +
> >   drivers/net/ethernet/meta/Kconfig             |   29 +
> >   drivers/net/ethernet/meta/Makefile            |    6 +
> >   drivers/net/ethernet/meta/fbnic/Makefile      |   18 +
> >   drivers/net/ethernet/meta/fbnic/fbnic.h       |  148 ++
> >   drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  912 ++++++++
> >   .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   86 +
> >   .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
> >   drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  823 ++++++++
> >   drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  133 ++
> >   drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  251 +++
> >   drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 1025 +++++++++
> >   drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   83 +
> >   .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  470 +++++
> >   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   59 +
> >   drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  633 ++++++
> >   drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  709 +++++++
> >   drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
> >   drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
> >   drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
> >   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1873 ++++++++++++++++=
+
> >   drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  125 ++
> >   include/linux/pci_ids.h                       |    2 +
> >   25 files changed, 8292 insertions(+)
>
> Even if this is just a basic scaffolding for what will come, it's hard
> to believe that no patch was co-developed, or should be marked as
> authored-by some other developer.
>
> [...]

I don't want to come across as snarky, but you must be new to Intel?
If nothing else you might ask a few people there  about the history of
the fm10k drivers. I think I did most of the Linux and FreeBSD fm10k
drivers in about 2 to 3 years. Typically getting basic Tx and Rx up
and running on a driver only takes a few weeks, and it is pretty
straight forward when you are implementing the QEMU at the same time
to test it on. From my experience driver development really goes by
the pareto principle where getting basic Tx/Rx up and running is
usually a quick task. What takes forever is enabling all the other
offloads and functions.

As far as this driver goes I would say this is something similar, only
this time I have worked on a Linux and UEFI driver, both of which I am
hoping to get upstreamed. With that said I can go through the bits for
the yet to be upstreamed parts that weren't done by me.

We had tried to bring a few people onto the team early on, none of
which are with the team anymore but a couple are still with the
company so I can reach out to them and see if they are okay with the
Co-autthor attribution before I submit those patches. I have a few
people who worked on the ptp and debugfs, one that enabled Tx offloads
and the ethtool ring configuration, and another had just started work
on the UEFI driver before he left. In addition there was an Intern who
did most of the work on the ethtool loopback test.

When the layoffs hit in late 2022 the team was basically reduced to
just myself and a firmware developer. Neither of us really strayed too
much into the other's code. Basically I defined the mailbox interface
and messages and went on our separate ways from there. In the last 6
months our team started hiring again. The new hires are currently
working in areas that aren't in this set such as devlink firmware
update, ethtool register dump, and various other interactions with the
firmware.

