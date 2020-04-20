Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7991F1B1124
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDTQIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDTQIk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 12:08:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81306C061A0F
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 09:08:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so8459189lfc.5
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NL3IEwcfzNQpHmXPpfrLIKWyab3iYaw/7gQEiU+sf+M=;
        b=czKwoRDJdYo2K9jc/Bu4C6/Iv+Jc+T9L3xnSK1VPB8pCKP2Jqe02WP/XIrV+cLTqHe
         45z9qsvugomaaXxlBZKo1HWUkBm1EeWYVfql4iAwQ5G8tbU0TUjtf39PF01XeqnUrIYL
         CN5gYCVEoinRdadcSvhf4j5AmfWwb7fMT6sDZ+XH/XB4enysEQqqjfpgYwKB4UBU5DxF
         gRZ2ewZvM5CRelCDpedWoqwvwVu1pushq5v5MKpmRRakreumGcWQQLMVRJqPn7Z3FNZq
         DjKJwezAZ5gdB8ekpQ7q50H5nBAblHnSbmNBOCWZX9Ckh0bk8RNc4RJiDRjXERJ1pHIX
         g+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NL3IEwcfzNQpHmXPpfrLIKWyab3iYaw/7gQEiU+sf+M=;
        b=MdzVTfuHAb85UaFDGMFmcExX9LzBMwALHog3YWf8g4OmfsKKUlg/NY1i5KDsOxrWmR
         tXH/DkbeuM1bm3aOgLiTknPTr8Fz1Jkpa9MM3wef9G2588QgrRJR1cirwArGLFIuGgx6
         HevWCQIk+8pnM5CPEqWwZJpBUN+EvFawfZccjxrTEc7rruWC92M16kUHKVYMVfAHz29G
         k6H/D0uXIdzTDsOzKkTGBd5OMoIpzdpD4V+x0hVMMs6M3wuuTX5XGH43W5c/4ZM+AAiA
         6YZJy/bOXUrD2zeG55sHI4lNIJ5HSdP/4/z1ZfbDBvU4+ZuLEhNFQZtZWSMLAGZFQmIL
         AE5A==
X-Gm-Message-State: AGi0PuZRveR/bC0OwuUpjTsyG3/+VvNTfj7dozixYaAOgJCR9YiCOXEi
        qk0rQ8NTm55d470Jpms8ZfIG3xQdWE3yPWCrmR8azg==
X-Google-Smtp-Source: APiQypKB4wP6bv3movpA3yXEyiywpA4vIc8NpmSfY2rAPduF5WboKyncgZPcIL771EReYQDwKZ0+cny7Gib+g3VLc7k=
X-Received: by 2002:a19:550a:: with SMTP id n10mr11048932lfe.143.1587398918866;
 Mon, 20 Apr 2020 09:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
 <20200418122123.10157ddd@why> <CY4PR12MB1271277CEE4F1FE06B71DDE8DAD60@CY4PR12MB1271.namprd12.prod.outlook.com>
 <8a03b55223b118c6fc605d7204e01460@kernel.org>
In-Reply-To: <8a03b55223b118c6fc605d7204e01460@kernel.org>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 20 Apr 2020 09:08:27 -0700
Message-ID: <CABEDWGxLKB68iknXtK8-4ke3wGW-6RKBnDEh6rFbBekLyawVOw@mail.gmail.com>
Subject: Re: [PATCH] genirq/msi: Check null pointer before copying struct msi_msg
To:     Marc Zyngier <maz@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, tglx@linutronix.de,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-04-18 16:19, Gustavo Pimentel wrote:
> > Hi Marc and Alan,
> >
> >> I'm not convinced by this. If you know that, by construction, these
> >> interrupts are not associated with an underlying MSI, why calling
> >> get_cached_msi_msg() the first place?
> >>
> >> There seem to be some assumptions in the DW EDMA driver that the
> >> signaling would be MSI based, so maybe someone from Synopsys
> >> (Gustavo?)
> >> could clarify that. From my own perspective, running on an endpoint
> >> device means that it is *generating* interrupts, and I'm not sure what
> >> the MSIs represent here.
> >
> > Giving a little context to this topic.
> >
> > The eDMA IP present on the Synopsys DesignWare PCIe Endpoints can be
> > configured and triggered *remotely* as well *locally*.
> > For the sake of simplicity let's assume for now the eDMA was
> > implemented
> > on the EP and that is the IP that we want to configure and use.
> >
> > When I say *remotely* I mean that this IP can be configurable through
> > the
> > RC/CPU side, however, for that, it requires the eDMA registers to be
> > exposed through a PCIe BAR on the EP. This will allow setting the SAR,
> > DAR and other settings, also need(s) the interrupt(s) address(es) to be
> > set as well (MSI or MSI-X only) so that it can signal through PCIe (to
> > the RC and consecutively the associated EP driver) if the data transfer
> > has been completed, aborted or if the Linked List consumer algorithm
> > has
> > passed in some linked element marked with a watermark.
> >
> > It was based on this case that the eDMA driver was exclusively
> > developed.
> >
> > However, Alan, wants to expand a little more this, by being able to use
> > this driver on the EP side (through
> > pcitest/pci_endpoint_test/pci_epf_test) so that he can configure this
> > IP
> > *locally*.
> > In fact, when doing this, he doesn't need to configure the interrupt
> > address (MSI or MSI-X), because this IP provides a local interrupt line
> > so that be connected to other blocks on the EP side.
>
> Right, so this confirms my hunch that the driver is being used in
> a way that doesn't reflect the expected use case. Rather than
> papering over the problem by hacking the core code, I'd rather see
> the eDMA driver be updated to support both host and endpoint cases.
> This probably boils down to a PCI vs non-PCI set of helpers.
>
> Alan, could you confirm whether we got it right?

Thanks Marc and Gustavo. I appreciate all your comments and feedback.

You both got it right. As Gustavo mentioned, I am trying to expand dw-edma
for additional use cases.

First new use case is for integration of dw-edma with pci-epf-test so the latter
can initiate dma transfers locally from endpoint memory to host memory over the
PCIe bus in response to a user command issued from the host-side command
prompt using the pcitest utility. When the locally-initiated dma
transfer completes
in this use case on the endpoint side, dw-edma issues an interrupt to the local
CPU on the endpoint side by way of a legacy interrupt and pci-epf-test issues
an interrupt toward the remote host CPU across the PCIe bus by way of legacy,
MSI, or possibly MSI-X interrupt.

Second new use case is for integration of dw-edma with pci_endpoint_test
running on the host CPU so the latter can initiate dma transfers locally from
host-side in response to a user command issued from the host-side command
prompt using the pcitest utility. This use case is for host systems that have
Synopsys DesignWare PCI eDMA hardware on the host side. When the
locally-initiated dma transfer completes in this use case on the host-side,
dw-edma issues a legacy interrupt to its local host CPU and pci-epf-test running
on the endpoint side issues a legacy, MSI, or possibly MSI-X interrupt
across the
PCIe bus toward the host CPU.

When both the host and endpoint sides have the Synopsys DesignWare PCI
eDMA hardware, more use cases become possible in which eDMA controllers
from both systems can be engaged to move data. Embedded DMA controllers
from other PCIe IP vendors may also be supported with additional dmaengine
drivers under the Linux PCI Endpoint Framework with pci-epf-test, pcitest, and
pci_endpoint_test suite as well as new PCI endpoint function drivers for such
applications that require dma, for example nvme or virtio_net endpoint function
drivers.

I submitted a recent patch [1] and [2] which Gustavo ACk'd to decouple dw-edma
from struct pci_dev. This enabled me to exercise dw-edma on some riscv host
and endpoint systems that I work with.

I will submit another patch to decouple dw-edma from struct msi_msg such
that it would only call get_cached_msi_msg() on the host-side in its original
use case with remotely initiated dma transfers using the BAR access method.

The crash that I reported in __get_cached_msi_msg() is probably worth fixing
too. It seems to be low impact since get_cached_msi_msg() seems to be called
infrequently by a few callers.

Regards,
Alan Mikhak

[1] https://patchwork.kernel.org/patch/11489607/
[2] https://patchwork.kernel.org/patch/11491757/

>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
