Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B506C35E619
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhDMSNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244280AbhDMSNr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 14:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81921613C4;
        Tue, 13 Apr 2021 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618337606;
        bh=xGOm6sfcvV/xbsRxqQLrriUeRevtMO454HWufQdgJME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iTYhpLB8MNVs/qyJP8F5o4oz9a09rZl0Bi2Gf+KdFMST6OF4FMOP4lN93912JOQtb
         RSXnWiIHgdAThw4dCKUTNT4TOGas34MQ0Q6DGoNNasXIjtkElkaUbOB86LC4JBd7bq
         NoO9pHcdLZtuccriWfIqtlPqxebSLsnGyQc7P64ZhJCiOlztv92HThHN6jCCW21EFa
         NIrBqSoF4cyS4y0ktSH6+6SmLUiDvRwUl3rRY+zONqJ5xZpA/yLY+Pek0NvyE2oVL2
         oisYuqZ6RxDsFySDO2PB0eU/unlP5L1ytKdMOVuubW0myVsKNRxwuNExflAuCF28CB
         MqzX6nrvc7xLg==
Received: by mail-ed1-f45.google.com with SMTP id bx20so19337379edb.12;
        Tue, 13 Apr 2021 11:13:26 -0700 (PDT)
X-Gm-Message-State: AOAM531krwsbifqc3Oh0p23j8QHF+dqXLoR99CFtV3Szp88tkfQMKio2
        UtiuiCNrf0bNop7VxJD3/DaLc3++z+6syHC0Sw==
X-Google-Smtp-Source: ABdhPJzhN4/MeaIm5HqmdBdro7MpnNTQ9h58ymxpWFCaKDyNV4VU5185jVvkmgLAi0iKphtHU8gJjEbf3ABQ07p87Us=
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr37161577edd.258.1618337605094;
 Tue, 13 Apr 2021 11:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <d840687e-bfd7-71b4-e8f0-37c971d3d414@nvidia.com>
In-Reply-To: <d840687e-bfd7-71b4-e8f0-37c971d3d414@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Apr 2021 13:13:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJn+6affnTbF7qS3QUe=trACwKm7rPfJNLL0fF2aMydg@mail.gmail.com>
Message-ID: <CAL_JsqLJn+6affnTbF7qS3QUe=trACwKm7rPfJNLL0fF2aMydg@mail.gmail.com>
Subject: Re: Device driver location for the PCIe root port's DMA engine
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 12:01 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Hi
> I'm starting this mail to seek advice on the best approach to be taken
> to add support for the driver of the PCIe root port's DMA engine.
> To give some background, Tegra194's PCIe IPs are dual-mode PCIe IPs i.e.
> they work either in the root port mode or in the endpoint mode based on
> the boot time configuration.
> Since the PCIe hardware IP as such is the same for both (RP and EP)
> modes, the DMA engine sub-system of the PCIe IP is also made available
> to both modes of operation.
> Typically, the DMA engine is seen only in the endpoint mode, and that
> DMA engine=E2=80=99s configuration registers are made available to the ho=
st
> through one of its BARs.
> In the situation that we have here, where there is a DMA engine present
> as part of the root port, the DMA engine isn=E2=80=99t a typical general-=
purpose
> DMA engine in the sense that it can=E2=80=99t have both source and destin=
ation
> addresses targeting external memory addresses.
> RP=E2=80=99s DMA engine, while doing a write operation,
> would always fetch data (i.e. source) from local memory and write it to
> the remote memory over PCIe link (i.e. destination would be the BAR of
> an endpoint)
> whereas while doing a read operation,
> would always fetch/read data (i.e. source) from a remote memory over the
> PCIe link and write it to the local memory.
>
> I see that there are at least two ways we can have a driver for this DMA
> engine.
> a) DMA engine driver as one of the port service drivers
>         Since the DMA engine is a part of the root port hardware itself
> (although it is not part of the standard capabilities of the root port),
> it is one of the options to have the driver for the DMA engine go as one
> of the port service drivers (along with AER, PME, hot-plug, etc...).
> Based on Vendor-ID and Device-ID matching runtime, either it gets
> binded/enabled (like in the case of Tegra194) or it doesn't.
> b) DMA engine driver as a platform driver
>         The DMA engine hardware can be described as a sub-node under the =
PCIe
> controller's node in the device tree and a separate platform driver can
> be written to work with it.

DT expects PCI bridge child nodes to be a PCI device. We've already
broken that with the interrupt controller child nodes, but I don't
really want to add more.

> I=E2=80=99m inclined to have the DMA engine driver as a port service driv=
er as
> it makes it cleaner and also in line with the design philosophy (the way
> I understood it) of the port service drivers.
> Please let me know your thoughts on this.

What is the actual usecase and benefit for using the DMA engine with
the RP? The only one I've come up with is the hardware designers think
having DMA is better than not having DMA so they include that option
on the DWC controller.

Rob
