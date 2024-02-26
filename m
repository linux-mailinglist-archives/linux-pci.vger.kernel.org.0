Return-Path: <linux-pci+bounces-4051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A85868047
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 20:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88E82863AB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89C12FB13;
	Mon, 26 Feb 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj8zdIjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531912F5A0;
	Mon, 26 Feb 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974109; cv=none; b=PVKhhpsAUcD35MM5Dqduz3iEc+f+05/MO+r5QLiORIe1OYXmUUPESf06RzMuvvMsk8NaopuqI4/B6WLGRcIyA71BsDutxtH19HJ1IVfdyFPUnxDgPGa/0lITWl/HzmVsw7OIuFn8C99FtFzls3t77Np0Lkeh5AuyoetMzJysn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974109; c=relaxed/simple;
	bh=9j0M+ymeUq7RxwTggM61y9yRYx+xKOLcvoURJI6KkkY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID; b=ulm7ZCcRF2lcYAzVs2dsZ8o6z2DdgsKBN0zROum74zYz6FMVqXcuv7JRsGGTkQdXpGOoR9Q246QGjZPDeUA0aGIhRXHpCVbqkxt0Km7muOs2UNOZl0rs1Kci82haRp+2pwUIo3hqQcP7OmMn377PvMydFcNd55uMJBxQH06Gwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj8zdIjV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so517716366b.0;
        Mon, 26 Feb 2024 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974104; x=1709578904; darn=vger.kernel.org;
        h=message-id:in-reply-to:date:subject:cc:to:from:user-agent
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=G8LMK8OmvNm1GCisv4uIp/0KVo3ky6Fv9X1ollGhF9w=;
        b=Cj8zdIjV+JJw3Mw6SRnTbQxwX8N7JhsWBrgYi64p9rirAwX5MxNq0nQ9Gt+s/HVMvC
         B3zH/ArkDg/xHPqxWp6ck553hxnub6Wdx1OB0rHZJRqvOjBdMQ05frdMHz9zVS6c/pIQ
         r3bQjtndRhACyRcNoP9BHKlqeVcAC6oWHPUvl4o1HfNkT0XY2sfYrslStSRZp9bCW1kN
         PN+ru22fLqOA/hGjDFnOFukB1jv4j9Rp2fN1iE8KfROXkQTX8IS926KIPPjKrAwS0luj
         cdYEp0vZvPV/Q2/8K4gS09tXhcUwMzgl67CSWUxNbLrXPod7A1CSYEWuvbFPQiO7Rmyr
         PLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974104; x=1709578904;
        h=message-id:in-reply-to:date:subject:cc:to:from:user-agent
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8LMK8OmvNm1GCisv4uIp/0KVo3ky6Fv9X1ollGhF9w=;
        b=a3oyBjbTHvoq5IeTa/5d0aq/pYiu7YasB5/p0riHJmvQooJFxcrK+2w/DBVHZ9lQxM
         VCoOVMsnLBQC64XHlB+nd85inEikHvEGq6XjIbGkrBFdLqAbx2309k+CU4s+vTAI9TT6
         T8NDAa8k/YaqjVUnJwNufRf5bqScwNUrekJKWWOY3ZfWFPoNYSMDK3agFK4vptyow3Ra
         8Tos2bd+F0gs5rEpW/osdg0954jiIgRtOlHac4wZaLhdIxKPWkU/UpkxBgDkmQ4wvvQT
         jq/s1FICp4aQhAszNrsKcXQiBmMSJsXIlwa9ToXT1MdN222GnbWdtnjsFobl9fY4fp7K
         F4qg==
X-Forwarded-Encrypted: i=1; AJvYcCXMY7nm31d5ORFbWmwFnC12ObYSP/glpvvofZDggqv7wFRUJEUFgzzicmNTLawF6sMYkHk60M3j7u3hUYk4fsE0DQ6p4Pu7oJ4aC8IFNKJqy2QplRmfXdSUewpoz5D/uV5cY36SqfjSqnWb+lxV7e7gYbip+9RVMXERyIax/m3EdmPn8fI/GWSfwNk8foGFtIiZdO8uVY3hCQE34pRkVy4=
X-Gm-Message-State: AOJu0Yzp5AxhRoO+MpFOeIvCqJVMNt1QhaHGpHdV2tB96kkjhK8dyAzT
	UznLKbKINSvw5VIhU/mTroWBWrnf14Fi64FW7LjlYUFrQ6EIL/T5qQtxuxRQSoQ=
X-Google-Smtp-Source: AGHT+IGdEIaZLKD3wdEPtPOUU82YFpEJuuWamhrWmTEfl2I1OvXx/SEnakxHT/t6WNjdl4uFzBp7ig==
X-Received: by 2002:a17:906:fcb7:b0:a43:5499:6ac8 with SMTP id qw23-20020a170906fcb700b00a4354996ac8mr3114712ejb.20.1708974103706;
        Mon, 26 Feb 2024 11:01:43 -0800 (PST)
Received: from bhlegrsu ([2a02:908:2525:6ea0:3aea:4843:afab:a903])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906455200b00a3f2d8d3782sm21618ejq.180.2024.02.26.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:01:43 -0800 (PST)
References: <20240224210409.112333-1-wafgo01@gmail.com>
 <20240225160926.GA58532@thinkpad>
 <20240225203917.GA4678@bhlegrsu.conti.de> <20240226094530.GA2778@thinkpad>
User-agent: mu4e 1.8.14; emacs 29.0.92
From: Wadim Mueller <wafgo01@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham
 I
 <kishon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie
 <mie@igel.co.jp>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Date: Mon, 26 Feb 2024 19:47:30 +0100
In-reply-to: <20240226094530.GA2778@thinkpad>
Message-ID: <rq85odwmqryrr4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--text follows this line--
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Sun, Feb 25, 2024 at 09:39:17PM +0100, Wadim Mueller wrote:
>> On Sun, Feb 25, 2024 at 09:39:26PM +0530, Manivannan Sadhasivam wrote:
>> > On Sat, Feb 24, 2024 at 10:03:59PM +0100, Wadim Mueller wrote:
>> > > Hello,
>> > >=20
>> > > This series adds support for the Block Passthrough PCI(e) Endpoint f=
unctionality.
>> > > PCI Block Device Passthrough allows one Linux Device running in EP m=
ode to expose its Block devices to the PCI(e) host (RC). The device can exp=
ort either the full disk or just certain partitions.
>> > > Also an export in readonly mode is possible. This is useful if you w=
ant to share the same blockdevice between different SoCs, providing each So=
C its own partition(s).
>> > >=20
>> > >=20
>> > > Block Passthrough
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > The PCI Block Passthrough can be a useful feature if you have multip=
le SoCs in your system connected
>> > > through a PCI(e) link, one running in RC mode, the other in EP mode.
>> > > If the block devices are connected to one SoC (SoC2 in EP Mode from =
the diagramm below) and you want to access
>> > > those from the other SoC (SoC1 in RC mode below), without having any=
 direct connection to
>> > > those block devices (e.g. if you want to share an NVMe between two S=
oCs). An simple example of such a configurationis is shown below:
>> > >=20
>> > >=20
>> > >                                                            +--------=
-----+
>> > >                                                            |        =
     |
>> > >                                                            |   SD Ca=
rd   |
>> > >                                                            |        =
     |
>> > >                                                            +------^-=
-----+
>> > >                                                                   |
>> > >                                                                   |
>> > >     +--------------------------+                +-----------------v-=
---------------+
>> > >     |                          |      PCI(e)    |                   =
               |
>> > >     |         SoC1 (RC)        |<-------------->|            SoC2 (E=
P)             |
>> > >     | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLO=
CK_PASSTHROUGH)|
>> > >     |                          |                |                   =
               |
>> > >     +--------------------------+                +-----------------^-=
---------------+
>> > >                                                                   |
>> > >                                                                   |
>> > >                                                            +------v-=
-----+
>> > >                                                            |        =
     |
>> > >                                                            |    NVMe=
     |
>> > >                                                            |        =
     |
>> > >                                                            +--------=
-----+
>> > >=20
>> > >=20
>> > > This is to a certain extent a similar functionality which NBD expose=
s over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framewor=
k.
>> > >=20
>> > > The Endpoint Function driver creates parallel Queues which run on se=
perate CPU Cores using percpu structures. The number of parallel queues is =
limited
>> > > by the number of CPUs on the EP device. The actual number of queues =
is configurable (as all other features of the driver) through CONFIGFS.
>> > >=20
>> > > A documentation about the functional description as well as a user g=
uide showing how both drivers can be configured is part of this series.
>> > >=20
>> > > Test setup
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >=20
>> > > This series has been tested on an NXP S32G2 SoC running in Endpoint =
mode with a direct connection to an ARM64 host machine.
>> > >=20
>> > > A performance measurement on the described setup shows good performa=
nce metrics. The S32G2 SoC has a 2xGen3 link which has a maximum Bandwidth =
of ~2GiB/s.
>> > > With the explained setup a Read Datarate of 1.3GiB/s (with DMA ... w=
ithout DMA the speed saturated at ~200MiB/s) was achieved using an 512GiB K=
ingston NVMe
>> > > when accessing the NVMe from the ARM64 (SoC1) Host. The local Read D=
atarate accessing the NVMe dirctly from the S32G2 (SoC2) was around 1.5GiB.
>> > >=20
>> > > The measurement was done through the FIO tool [1] with 4kiB Blocks.
>> > >=20
>> > > [1] https://linux.die.net/man/1/fio
>> > >=20
>> >=20
>> > Thanks for the proposal! We are planning to add virtio function suppor=
t to
>> > endpoint subsystem to cover usecases like this. I think your usecase c=
an be
>> > satisfied using vitio-blk. Maybe you can add the virtio-blk endpoint f=
unction
>> > support once we have the infra in place. Thoughts?
>> >=20
>> > - Mani
>> >
>>=20
>> Hi Mani,
>> I initially had the plan to implement the virtio-blk as an endpoint
>> function driver instead of a self baked driver.=20
>>=20
>> This for sure is more elegant as we could reuse the
>> virtio-blk pci driver instead of implementing a new one (as I did)=20
>>=20
>> But I initially had some concerns about the feasibility, especially
>> that the virtio-blk pci driver is expecting immediate responses to some
>> register writes which I would not be able to satisfy, simply because we
>> do not have any kind of interrupt/event which would be triggered on the
>> EP side when the RC is accessing some BAR Registers (at least there is
>> no machanism I know of). As virtio is made mainly for Hypervisor <->
>
> Right. There is a limitation currently w.r.t triggering doorbell from the=
 host
> to endpoint. But I believe that could be addressed later by repurposing t=
he
> endpoint MSI controller [1].
>
>> As virtio is made mainly for Hypervisor <->
>> Guest communication I was afraid that a Hypersisor is able to Trap every
>> Register access from the Guest and act accordingly, which I would not be
>> able to do. I hope this make sense to you.
>>=20
>
> I'm not worrying about the hypervisor right now. Here the endpoint is exp=
osing
> the virtio devices and host is consuming it. There is no virtualization p=
lay
> here. I talked about this in the last plumbers [2].
>

Okay, I understand this. The hypervisor was more of an example. I will
try to explain.

I am currently reading through the virtio spec [1].
In chapter 4.1.4.5.1 there is the following statement:

"The device MUST reset ISR status to 0 on driver read."

So I was wondering, how we, as an PCI EP Device, supposed to clear a
register when the driver reads the same register? I mean how do we detect a
register read?
If you are a hypervisor its easy to do so, because you can intercept
every memory access made my the guest (the same applies if you build
custom HW for this purpose). But for us as an EP device its
difficult to detect this, even with MSIs and Doorbell Registers in
place.

Modifying the virtio layer to write to some doorbell register after
reading the ISR status register would be possible, but kind of ugly.


[1] https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.=
pdf

>> But to make a long story short, yes I agree with you that virtio-blk
>> would satisfy my usecase, and I generally think it would be a better
>> solution, I just did not know that you are working on some
>> infrastructure for that. And yes I would like to implement the endpoint
>> function driver for virtio-blk. Is there already an development tree you
>> use to work on the infrastructre I could have a look at?
>>=20
>
> Shunsuke has a WIP branch [3], that I plan to co-work in the coming days.
> You can use it as a reference in the meantime.
>
> - Mani
>
> [1] https://lore.kernel.org/all/20230911220920.1817033-1-Frank.Li@nxp.com/
> [2] https://www.youtube.com/watch?v=3D1tqOTge0eq0
> [3] https://github.com/ShunsukeMie/linux-virtio-rdma/tree/v6.6-rc1-epf-vc=
on
>
>> - Wadim
>>=20
>>=20
>>=20
>> > > Wadim Mueller (3):
>> > >   PCI: Add PCI Endpoint function driver for Block-device passthrough
>> > >   PCI: Add PCI driver for a PCI EP remote Blockdevice
>> > >   Documentation: PCI: Add documentation for the PCI Block Passthrough
>> > >=20
>> > >  .../function/binding/pci-block-passthru.rst   |   24 +
>> > >  Documentation/PCI/endpoint/index.rst          |    3 +
>> > >  .../pci-endpoint-block-passthru-function.rst  |  331 ++++
>> > >  .../pci-endpoint-block-passthru-howto.rst     |  158 ++
>> > >  MAINTAINERS                                   |    8 +
>> > >  drivers/block/Kconfig                         |   14 +
>> > >  drivers/block/Makefile                        |    1 +
>> > >  drivers/block/pci-remote-disk.c               | 1047 +++++++++++++
>> > >  drivers/pci/endpoint/functions/Kconfig        |   12 +
>> > >  drivers/pci/endpoint/functions/Makefile       |    1 +
>> > >  .../functions/pci-epf-block-passthru.c        | 1393 ++++++++++++++=
+++
>> > >  include/linux/pci-epf-block-passthru.h        |   77 +
>> > >  12 files changed, 3069 insertions(+)
>> > >  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-=
block-passthru.rst
>> > >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-pa=
ssthru-function.rst
>> > >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-pa=
ssthru-howto.rst
>> > >  create mode 100644 drivers/block/pci-remote-disk.c
>> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-pas=
sthru.c
>> > >  create mode 100644 include/linux/pci-epf-block-passthru.h
>> > >=20
>> > > --=20
>> > > 2.25.1
>> > >=20
>> >=20
>> > --=20
>> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D


