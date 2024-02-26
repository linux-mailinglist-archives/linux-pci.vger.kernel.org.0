Return-Path: <linux-pci+bounces-3997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F886708C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD38B2BE8A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71022EF6;
	Mon, 26 Feb 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB9M2pEY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30030817
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940739; cv=none; b=RzQhRZeiu6EF6JpnfRRDdH8TD5ahyepCju+rUAxnLdIN0jYZzGfXkeUgZoCA97AbCcGOXQZo552pT0Z9hC+esDxQb4+zcuuL3lagT6hnvLh+toKWUPEzd9vsOvi7nxJLyBgVy5cqLYeVE5tZilmY39Gkr81YVjYxIugDr0zQ8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940739; c=relaxed/simple;
	bh=UKGeuGL4yIVcITrKfL8y8e9ey+C67RqmPaEtrVyDjMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYQu1SJB4TfDkpy35IqxzOoqujCd3UxmLGTAXjp28XVdfburJB2VbEXF2CCSpcq6gjLqLdh42MWX7pu+CONsm5piy0Cdx3qNDpfCJEV2soeqIphq/5lvls580Li+Su5bQIH4bA3Aaa2wVPrr0awkVALSYJJ9Dug0wY54MFiHWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cB9M2pEY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so1701819b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708940737; x=1709545537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sHy902ePgHndMGk5vbn4XQy6mpWY8JgyR/RL2u0FDHM=;
        b=cB9M2pEY9QuoTTcvG9yIYaiP5m2b/kgiNrvlg8RcnQwaVr+psI85mEegSF/fYwX+eW
         YB+x2jS94qG3Lq1KuDlj9OXZUEnS2talwqRPPZSbcR0Sgrbc0hKcEnEgg5t72FVkxxkz
         KeWnWdrQLai3v2l2Fhn9yOQHTvCGNQtUp5IuK3sDoJl0ph3m1t2LfH5I75730Dy0EVu3
         Z18Ntuu59XYnsapT8qoJQPd8DQkCE4L7iWxbVdM+5UKuge83194klS1r/5DndtZ+Sn9W
         2bF38TWuiuyPIcaMfupKnuSMHcthUuDUr3EOtovZ1InhklQuCFtFgrZOqTSbX1OKTBXr
         h31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940737; x=1709545537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHy902ePgHndMGk5vbn4XQy6mpWY8JgyR/RL2u0FDHM=;
        b=q4S6Efat/g7riegDYhJVkwcJA0ffaQC3gz4/Kh1ztTvvQOdzawBxD2qY26MTHOPOHH
         Tqt0pAvppVVj0kQphsXNRINmdqi+sYj1JTPvwnSwJT57ReKWv2CZc9M7OSnK7H9n04TR
         wP6Og8BVi4wyS5wvXtusopJkQ9BZuZdskKBH2493FdaS0dZWoO0dWWjB7X2pw/EhH8Vu
         hnmouq+D3Bro200h1PADpoDaSKULSAo7byKBOnGFrIIceWttW75yj8axHZOFgZZQ+p4e
         4ouitgkYnpsx7oaAwevoIGcDhGczP1OIM8ran1c6CwbeJtfJmFHbVeJqTT52wqtt7Wd/
         xFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjcgbOiXPsqEnQHuxRsGU+opRsH6xeXS+HChKrhj5rKHHvktb3FeDacIv1A0koiDaC0EKmMBaZeWA4vMbIxfok8Z2ukotRw3kr
X-Gm-Message-State: AOJu0YzcQTn6lAnhKToc8jR010fTJXs2JTuZmFPZmrJVJxMQCvBxyRvz
	FBRx2ZYe33oV6hUWVzYQzeSLjzVLRBcTBaUwyP4ZOBDn/Sgaj6BU5BNbjjA1/w==
X-Google-Smtp-Source: AGHT+IFXlaNw0JCugkNOQ0EpFfmvZyXGMlTCC0o4iE2RH+aWxXtSPiLWMdPNi2mgamRjo21u5P7FKA==
X-Received: by 2002:a05:6a00:6c87:b0:6e3:2727:42a0 with SMTP id jc7-20020a056a006c8700b006e3272742a0mr8879728pfb.10.1708940737069;
        Mon, 26 Feb 2024 01:45:37 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id b17-20020a631b11000000b005d67862799asm3516108pgb.44.2024.02.26.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:45:36 -0800 (PST)
Date: Mon, 26 Feb 2024 15:15:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Message-ID: <20240226094530.GA2778@thinkpad>
References: <20240224210409.112333-1-wafgo01@gmail.com>
 <20240225160926.GA58532@thinkpad>
 <20240225203917.GA4678@bhlegrsu.conti.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225203917.GA4678@bhlegrsu.conti.de>

On Sun, Feb 25, 2024 at 09:39:17PM +0100, Wadim Mueller wrote:
> On Sun, Feb 25, 2024 at 09:39:26PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Feb 24, 2024 at 10:03:59PM +0100, Wadim Mueller wrote:
> > > Hello,
> > > 
> > > This series adds support for the Block Passthrough PCI(e) Endpoint functionality.
> > > PCI Block Device Passthrough allows one Linux Device running in EP mode to expose its Block devices to the PCI(e) host (RC). The device can export either the full disk or just certain partitions.
> > > Also an export in readonly mode is possible. This is useful if you want to share the same blockdevice between different SoCs, providing each SoC its own partition(s).
> > > 
> > > 
> > > Block Passthrough
> > > ==================
> > > The PCI Block Passthrough can be a useful feature if you have multiple SoCs in your system connected
> > > through a PCI(e) link, one running in RC mode, the other in EP mode.
> > > If the block devices are connected to one SoC (SoC2 in EP Mode from the diagramm below) and you want to access
> > > those from the other SoC (SoC1 in RC mode below), without having any direct connection to
> > > those block devices (e.g. if you want to share an NVMe between two SoCs). An simple example of such a configurationis is shown below:
> > > 
> > > 
> > >                                                            +-------------+
> > >                                                            |             |
> > >                                                            |   SD Card   |
> > >                                                            |             |
> > >                                                            +------^------+
> > >                                                                   |
> > >                                                                   |
> > >     +--------------------------+                +-----------------v----------------+
> > >     |                          |      PCI(e)    |                                  |
> > >     |         SoC1 (RC)        |<-------------->|            SoC2 (EP)             |
> > >     | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)|
> > >     |                          |                |                                  |
> > >     +--------------------------+                +-----------------^----------------+
> > >                                                                   |
> > >                                                                   |
> > >                                                            +------v------+
> > >                                                            |             |
> > >                                                            |    NVMe     |
> > >                                                            |             |
> > >                                                            +-------------+
> > > 
> > > 
> > > This is to a certain extent a similar functionality which NBD exposes over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framework.
> > > 
> > > The Endpoint Function driver creates parallel Queues which run on seperate CPU Cores using percpu structures. The number of parallel queues is limited
> > > by the number of CPUs on the EP device. The actual number of queues is configurable (as all other features of the driver) through CONFIGFS.
> > > 
> > > A documentation about the functional description as well as a user guide showing how both drivers can be configured is part of this series.
> > > 
> > > Test setup
> > > ==========
> > > 
> > > This series has been tested on an NXP S32G2 SoC running in Endpoint mode with a direct connection to an ARM64 host machine.
> > > 
> > > A performance measurement on the described setup shows good performance metrics. The S32G2 SoC has a 2xGen3 link which has a maximum Bandwidth of ~2GiB/s.
> > > With the explained setup a Read Datarate of 1.3GiB/s (with DMA ... without DMA the speed saturated at ~200MiB/s) was achieved using an 512GiB Kingston NVMe
> > > when accessing the NVMe from the ARM64 (SoC1) Host. The local Read Datarate accessing the NVMe dirctly from the S32G2 (SoC2) was around 1.5GiB.
> > > 
> > > The measurement was done through the FIO tool [1] with 4kiB Blocks.
> > > 
> > > [1] https://linux.die.net/man/1/fio
> > > 
> > 
> > Thanks for the proposal! We are planning to add virtio function support to
> > endpoint subsystem to cover usecases like this. I think your usecase can be
> > satisfied using vitio-blk. Maybe you can add the virtio-blk endpoint function
> > support once we have the infra in place. Thoughts?
> > 
> > - Mani
> >
> 
> Hi Mani,
> I initially had the plan to implement the virtio-blk as an endpoint
> function driver instead of a self baked driver. 
> 
> This for sure is more elegant as we could reuse the
> virtio-blk pci driver instead of implementing a new one (as I did) 
> 
> But I initially had some concerns about the feasibility, especially
> that the virtio-blk pci driver is expecting immediate responses to some
> register writes which I would not be able to satisfy, simply because we
> do not have any kind of interrupt/event which would be triggered on the
> EP side when the RC is accessing some BAR Registers (at least there is
> no machanism I know of). As virtio is made mainly for Hypervisor <->

Right. There is a limitation currently w.r.t triggering doorbell from the host
to endpoint. But I believe that could be addressed later by repurposing the
endpoint MSI controller [1].

> As virtio is made mainly for Hypervisor <->
> Guest communication I was afraid that a Hypersisor is able to Trap every
> Register access from the Guest and act accordingly, which I would not be
> able to do. I hope this make sense to you.
> 

I'm not worrying about the hypervisor right now. Here the endpoint is exposing
the virtio devices and host is consuming it. There is no virtualization play
here. I talked about this in the last plumbers [2].

> But to make a long story short, yes I agree with you that virtio-blk
> would satisfy my usecase, and I generally think it would be a better
> solution, I just did not know that you are working on some
> infrastructure for that. And yes I would like to implement the endpoint
> function driver for virtio-blk. Is there already an development tree you
> use to work on the infrastructre I could have a look at?
> 

Shunsuke has a WIP branch [3], that I plan to co-work in the coming days.
You can use it as a reference in the meantime.

- Mani

[1] https://lore.kernel.org/all/20230911220920.1817033-1-Frank.Li@nxp.com/
[2] https://www.youtube.com/watch?v=1tqOTge0eq0
[3] https://github.com/ShunsukeMie/linux-virtio-rdma/tree/v6.6-rc1-epf-vcon

> - Wadim
> 
> 
> 
> > > Wadim Mueller (3):
> > >   PCI: Add PCI Endpoint function driver for Block-device passthrough
> > >   PCI: Add PCI driver for a PCI EP remote Blockdevice
> > >   Documentation: PCI: Add documentation for the PCI Block Passthrough
> > > 
> > >  .../function/binding/pci-block-passthru.rst   |   24 +
> > >  Documentation/PCI/endpoint/index.rst          |    3 +
> > >  .../pci-endpoint-block-passthru-function.rst  |  331 ++++
> > >  .../pci-endpoint-block-passthru-howto.rst     |  158 ++
> > >  MAINTAINERS                                   |    8 +
> > >  drivers/block/Kconfig                         |   14 +
> > >  drivers/block/Makefile                        |    1 +
> > >  drivers/block/pci-remote-disk.c               | 1047 +++++++++++++
> > >  drivers/pci/endpoint/functions/Kconfig        |   12 +
> > >  drivers/pci/endpoint/functions/Makefile       |    1 +
> > >  .../functions/pci-epf-block-passthru.c        | 1393 +++++++++++++++++
> > >  include/linux/pci-epf-block-passthru.h        |   77 +
> > >  12 files changed, 3069 insertions(+)
> > >  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
> > >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
> > >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
> > >  create mode 100644 drivers/block/pci-remote-disk.c
> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-passthru.c
> > >  create mode 100644 include/linux/pci-epf-block-passthru.h
> > > 
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

