Return-Path: <linux-pci+bounces-3985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB2862CE2
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 21:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1BB1C21186
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97917997;
	Sun, 25 Feb 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWwN08Nl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE0D2FE;
	Sun, 25 Feb 2024 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708893562; cv=none; b=MicigFZlOn3vk0xdy2kltyz4j1FIieGCER8IHCrd1cuGE1yhlRro0XCFUZNqYMjQN90nwo9YV5J10RZJK3HmPmeal3YWEsBztN4DcWoVJrq6al5mzd4P6x9FypXA4lZaG8vFh/P13W30jxiLbiKuiVXHFP2vtc5I4bqXYB4lHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708893562; c=relaxed/simple;
	bh=5EN/yKNU81PtFf6tvQJh71XpD/XYpS/ePIcyFbrR5XY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpS/gCVbg31cdCrmCHJvrYTL3b8jGcV44+BePuhCx7+LIU+7xXSWE9y9HHMMgyjJv8oDNR/70M97mr+bm7cjWJIArXR0Nd9YiEPqsbUoKfeu60zKvhNj8ngWF2QGdFR7b5IDbZ3VjP+h599sUghxLSb3U2c8UaqAUBiDTQB5FO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWwN08Nl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e75e30d36so475313366b.1;
        Sun, 25 Feb 2024 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708893559; x=1709498359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9JoULKHtWSwPeUYkzOnkXwPrzHWypX1iQARjIU+FggE=;
        b=OWwN08NlPIJPjZ8erTFermoJ9i6kPQaNyMlJ/jUCQWZfzyupvIuavDFpYZl/Bdb9U2
         fy3iXT6GtnOvSAvigBHz2LgOuWBnlndca2DXLzkQ6FtF7ydBW5jslRCgBoVznfHgsB6k
         P7r+GERalIX0ch9leX5ebGHeTW+Q7N1xXeufrIAGv6yjru88VJ6Ey6RBEKctLbTu0PPE
         uJTxyjj7L7AD209lh92DaZ8Fq67W0qxqB4DkkYDWq+zcJsdmZorhhQ6oEkB2K0TyclIO
         wb8tDsUimPk0aqL55O+isKczaSKpkhMojF4ztVua8oC8uCsL/je4kV7S6ODeYvwAu7AR
         MvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708893559; x=1709498359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JoULKHtWSwPeUYkzOnkXwPrzHWypX1iQARjIU+FggE=;
        b=CPHmFGqFezC86rO/wM+njXLFnwVWxK2IXt5kOC8qW9RaOrTFIjKEsREMWFn+hJltNi
         qLND1CALqAPMQ0TvxCxznQkdMiwW0Aol7VZn4ku9bS/zS+V3s3s+bCZ2guDlmhxDAkNu
         GiHsfrGFfLRkYNpDgzmMYUrz5AMoC+g8BfQQ2CZ+SG0aF2hZAOOqGzgjjqX/moyNZ4El
         fw+5yJhMZoOvX53hA3odUSvA4X02lyRWmSe2UvO7qD3NPfsdxJWSbsnvRrblMaoVAtZT
         6xl3xOYNsBOgxAdakZ6WjTA23qXgtDi0H07beqyN1o01CNucKv2NFn58Ssrz46FiDWnC
         ti1g==
X-Forwarded-Encrypted: i=1; AJvYcCWhS6j3+fWEP0yCiK4yqPrkpdeH39xNQ2mB1DGoqqPsISUb8UiuPQtUCauHsMwP2XY6bXZdUl06TT3HyT0GkdpwUMsfLEPLQIs734JPi90SHEioGXNNqJCGIsFCA+OZeCBIzpHxSXGmlRi+gbUxDFpbM3elIdKSexsHZGaNRbRZWVwxMOlPwJhOl3dcc8KDNY4rAv1gXHtA6sj+9IcZPJA=
X-Gm-Message-State: AOJu0YwaUIF8HZ1ufwjT+/ILYpdPwmAYeo2QSFMsJcVcQJpzpUMfPicr
	OqyLpQRiDCsPS3NkCSQy2ft1rhpP6mZTVl+vzZX/S2VvD3LqtLTXZd0dsnhiOSc=
X-Google-Smtp-Source: AGHT+IHHhfR3vl5a/K2tkoxrkoOFfn5RYcuhD0Rzj60dk8q/gZV6fIu//iVJgH6ytZCgdlIdyC4ftg==
X-Received: by 2002:a17:906:fcb7:b0:a43:5499:6ac8 with SMTP id qw23-20020a170906fcb700b00a4354996ac8mr487054ejb.20.1708893558554;
        Sun, 25 Feb 2024 12:39:18 -0800 (PST)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0:4f31:d36d:f841:198e])
        by smtp.gmail.com with ESMTPSA id jw4-20020a17090776a400b00a434cae86ebsm323331ejc.219.2024.02.25.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:39:18 -0800 (PST)
From: Wadim Mueller <wafgo01@gmail.com>
X-Google-Original-From: Wadim Mueller <wadim.mueller@continental.com>
Date: Sun, 25 Feb 2024 21:39:17 +0100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Message-ID: <20240225203917.GA4678@bhlegrsu.conti.de>
References: <20240224210409.112333-1-wafgo01@gmail.com>
 <20240225160926.GA58532@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225160926.GA58532@thinkpad>

On Sun, Feb 25, 2024 at 09:39:26PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Feb 24, 2024 at 10:03:59PM +0100, Wadim Mueller wrote:
> > Hello,
> > 
> > This series adds support for the Block Passthrough PCI(e) Endpoint functionality.
> > PCI Block Device Passthrough allows one Linux Device running in EP mode to expose its Block devices to the PCI(e) host (RC). The device can export either the full disk or just certain partitions.
> > Also an export in readonly mode is possible. This is useful if you want to share the same blockdevice between different SoCs, providing each SoC its own partition(s).
> > 
> > 
> > Block Passthrough
> > ==================
> > The PCI Block Passthrough can be a useful feature if you have multiple SoCs in your system connected
> > through a PCI(e) link, one running in RC mode, the other in EP mode.
> > If the block devices are connected to one SoC (SoC2 in EP Mode from the diagramm below) and you want to access
> > those from the other SoC (SoC1 in RC mode below), without having any direct connection to
> > those block devices (e.g. if you want to share an NVMe between two SoCs). An simple example of such a configurationis is shown below:
> > 
> > 
> >                                                            +-------------+
> >                                                            |             |
> >                                                            |   SD Card   |
> >                                                            |             |
> >                                                            +------^------+
> >                                                                   |
> >                                                                   |
> >     +--------------------------+                +-----------------v----------------+
> >     |                          |      PCI(e)    |                                  |
> >     |         SoC1 (RC)        |<-------------->|            SoC2 (EP)             |
> >     | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)|
> >     |                          |                |                                  |
> >     +--------------------------+                +-----------------^----------------+
> >                                                                   |
> >                                                                   |
> >                                                            +------v------+
> >                                                            |             |
> >                                                            |    NVMe     |
> >                                                            |             |
> >                                                            +-------------+
> > 
> > 
> > This is to a certain extent a similar functionality which NBD exposes over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framework.
> > 
> > The Endpoint Function driver creates parallel Queues which run on seperate CPU Cores using percpu structures. The number of parallel queues is limited
> > by the number of CPUs on the EP device. The actual number of queues is configurable (as all other features of the driver) through CONFIGFS.
> > 
> > A documentation about the functional description as well as a user guide showing how both drivers can be configured is part of this series.
> > 
> > Test setup
> > ==========
> > 
> > This series has been tested on an NXP S32G2 SoC running in Endpoint mode with a direct connection to an ARM64 host machine.
> > 
> > A performance measurement on the described setup shows good performance metrics. The S32G2 SoC has a 2xGen3 link which has a maximum Bandwidth of ~2GiB/s.
> > With the explained setup a Read Datarate of 1.3GiB/s (with DMA ... without DMA the speed saturated at ~200MiB/s) was achieved using an 512GiB Kingston NVMe
> > when accessing the NVMe from the ARM64 (SoC1) Host. The local Read Datarate accessing the NVMe dirctly from the S32G2 (SoC2) was around 1.5GiB.
> > 
> > The measurement was done through the FIO tool [1] with 4kiB Blocks.
> > 
> > [1] https://linux.die.net/man/1/fio
> > 
> 
> Thanks for the proposal! We are planning to add virtio function support to
> endpoint subsystem to cover usecases like this. I think your usecase can be
> satisfied using vitio-blk. Maybe you can add the virtio-blk endpoint function
> support once we have the infra in place. Thoughts?
> 
> - Mani
>

Hi Mani,
I initially had the plan to implement the virtio-blk as an endpoint
function driver instead of a self baked driver. 

This for sure is more elegant as we could reuse the
virtio-blk pci driver instead of implementing a new one (as I did) 

But I initially had some concerns about the feasibility, especially
that the virtio-blk pci driver is expecting immediate responses to some
register writes which I would not be able to satisfy, simply because we
do not have any kind of interrupt/event which would be triggered on the
EP side when the RC is accessing some BAR Registers (at least there is
no machanism I know of). As virtio is made mainly for Hypervisor <->
Guest communication I was afraid that a Hypersisor is able to Trap every
Register access from the Guest and act accordingly, which I would not be
able to do. I hope this make sense to you.

But to make a long story short, yes I agree with you that virtio-blk
would satisfy my usecase, and I generally think it would be a better
solution, I just did not know that you are working on some
infrastructure for that. And yes I would like to implement the endpoint
function driver for virtio-blk. Is there already an development tree you
use to work on the infrastructre I could have a look at?

- Wadim



> > Wadim Mueller (3):
> >   PCI: Add PCI Endpoint function driver for Block-device passthrough
> >   PCI: Add PCI driver for a PCI EP remote Blockdevice
> >   Documentation: PCI: Add documentation for the PCI Block Passthrough
> > 
> >  .../function/binding/pci-block-passthru.rst   |   24 +
> >  Documentation/PCI/endpoint/index.rst          |    3 +
> >  .../pci-endpoint-block-passthru-function.rst  |  331 ++++
> >  .../pci-endpoint-block-passthru-howto.rst     |  158 ++
> >  MAINTAINERS                                   |    8 +
> >  drivers/block/Kconfig                         |   14 +
> >  drivers/block/Makefile                        |    1 +
> >  drivers/block/pci-remote-disk.c               | 1047 +++++++++++++
> >  drivers/pci/endpoint/functions/Kconfig        |   12 +
> >  drivers/pci/endpoint/functions/Makefile       |    1 +
> >  .../functions/pci-epf-block-passthru.c        | 1393 +++++++++++++++++
> >  include/linux/pci-epf-block-passthru.h        |   77 +
> >  12 files changed, 3069 insertions(+)
> >  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
> >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
> >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
> >  create mode 100644 drivers/block/pci-remote-disk.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-passthru.c
> >  create mode 100644 include/linux/pci-epf-block-passthru.h
> > 
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

