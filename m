Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8022BE0C
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 06:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfE1EBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 00:01:37 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50822 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfE1EBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 00:01:37 -0400
Received: by mail-it1-f195.google.com with SMTP id a186so2083412itg.0;
        Mon, 27 May 2019 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjUv3nPJ7HnSKnPAy37kFrlpSs1ndqPhpkQ4GDIU1O0=;
        b=dYxqyHL+477TUHLXPK+2QfGw9r+JCnOqa53WiAbkxKKaEMeuwCy/UPmSB6nmb1Yj0u
         KYlMf472gcxrD/BVM+E2Fw1j8twcWAr6KH847JOZEM7CdQjxVZqk+UwHwcydvYTQihHw
         1eVUzMCebp70Z3chp9dNlI37XG0C+K6IbUIlCjUErvNo30/rcTpaPWU2X/hepgupxX9v
         eg0qbdtPpVcsCP0ubWSPUBAR9tvlRdwNEOj571H0dbSa9GGc8KLVlmOjHMACTls76zB2
         M/vkSGTkAXLQRonpLVck6/RXxbouWdn+7Hq+OiYEo5bSBMlgnTHA8YBIL2QwuOFKzivq
         aOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjUv3nPJ7HnSKnPAy37kFrlpSs1ndqPhpkQ4GDIU1O0=;
        b=j6JRXss75a6aDllzdaQy+UElvPZLmp+LrMlAfKwDljyiF7tSGEk3VCV9NGnQ2W171j
         qQNNDFHkxqsyQk8XSwjRTMDUjhYKIJbgaQgkWTQm2mcyp9roeyX7ASh3WGzaeQHBGCEu
         TM++F2OOQu0EWgn4Y4pipS5hnjxHwt62tEtlwNm+yTEQMCCWlgCK+R/dpI6r7C8HR1Bw
         d71E/uCyJjrne2pkCaDTks6hr9SyoSpzfX5MYv7WKhBumPsHXYL3WZmmJYOljaH6he8d
         BMx9EiuMlpUC/qmiQS23G1Pgju8Gb8UATUW0x+t6VLpEwpmLb5fURtLk+mVG7fSHWr9n
         WBUw==
X-Gm-Message-State: APjAAAX4ykW2D14htVs8OKLsOytv23wrDdpd6oW/jQk61rdBMowAeQ72
        EcPQTHQHYe5JUdrQ6uxKNPBrO02SlCuWQn31DWs=
X-Google-Smtp-Source: APXvYqy1mxn99so8vKfCz+Sf4gW32dGBxlzGt3ZTO7PZqd3wa9GEtU6jcUUCHFFmtBRz/O38JAC4wzmV/MuC9K94Zcw=
X-Received: by 2002:a24:190e:: with SMTP id b14mr1588278itb.15.1559016096130;
 Mon, 27 May 2019 21:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190527225521.5884-1-shawn@anastas.io>
In-Reply-To: <20190527225521.5884-1-shawn@anastas.io>
From:   Oliver <oohall@gmail.com>
Date:   Tue, 28 May 2019 14:01:24 +1000
Message-ID: <CAOSf1CFFyz0YNqdpd5r44MaBV449yoK3WOMBZ1mpgZ=judNfDQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/3] Allow custom PCI resource alignment on pseries
To:     Shawn Anastasio <shawn@anastas.io>
Cc:     linux-pci@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 28, 2019 at 8:56 AM Shawn Anastasio <shawn@anastas.io> wrote:
>
> Hello all,
>
> This patch set implements support for user-specified PCI resource
> alignment on the pseries platform for hotplugged PCI devices.
> Currently on pseries, PCI resource alignments specified with the
> pci=resource_alignment commandline argument are ignored, since
> the firmware is in charge of managing the PCI resources. In the
> case of hotplugged devices, though, the kernel is in charge of
> configuring the resources and should obey alignment requirements.

Are you using hotplug to work around SLOF (the OF we use under qemu)
not aligning BARs to 64K? It looks like there is a commit in SLOF to
fix that (https://git.qemu.org/?p=SLOF.git;a=commit;f=board-qemu/slof/pci-phb.fs;h=1903174472f8800caf50c959b304501b4c01153c).

> The current behavior of ignoring the alignment for hotplugged devices
> results in sub-page BARs landing between page boundaries and
> becoming un-mappable from userspace via the VFIO framework.
> This issue was observed on a pseries KVM guest with hotplugged
> ivshmem devices.

> With these changes, users can specify an appropriate
> pci=resource_alignment argument on boot for devices they wish to use
> with VFIO.
>
> In the future, this could be extended to provide page-aligned
> resources by default for hotplugged devices, similar to what is done
> on powernv by commit 382746376993 ("powerpc/powernv: Override
> pcibios_default_alignment() to force PCI devices to be page aligned").

Can we make aligning the BARs to PAGE_SIZE the default behaviour? The
BAR assignment process is complex enough as-is so I'd rather we didn't
add another platform hack into the mix.

> Feedback is appreciated.
>
> Thanks,
> Shawn
>
> Shawn Anastasio (3):
>   PCI: Introduce pcibios_ignore_alignment_request
>   powerpc/64: Enable pcibios_after_init hook on ppc64
>   powerpc/pseries: Allow user-specified PCI resource alignment after
>     init
>
>  arch/powerpc/include/asm/machdep.h     |  6 ++++--
>  arch/powerpc/kernel/pci-common.c       |  9 +++++++++
>  arch/powerpc/kernel/pci_64.c           |  4 ++++
>  arch/powerpc/platforms/pseries/setup.c | 22 ++++++++++++++++++++++
>  drivers/pci/pci.c                      |  9 +++++++--
>  5 files changed, 46 insertions(+), 4 deletions(-)
>
> --
> 2.20.1
>
