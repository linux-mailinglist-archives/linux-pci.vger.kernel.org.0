Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC8587829
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiHBHrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiHBHrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 03:47:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB31313B9
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 00:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1261BCE1AF9
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 07:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D11BC43140
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659426429;
        bh=xuUxu/0MpKUe5SJAqos8owXbYZ3ogZ/J1/KxWwR33xU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CmqGYEPjfBbYbUKkNKV2+9y1JZe0Rn0rig/LThPnuxW4SaAz9e1ukinp0jGEuAGux
         cNoM1yY4rEXdZOa9PiwRqCFq075YQymRAATrvBPDPABTzH6qkBBaVnkWBCAlzEqUFA
         l84d++Ej7ilZrmn8+ly+qEadXc/kDVGUvkekERH9XHGjjsPrkU7Pi3hmhK4HzT8v2a
         dGyvV3SryTx+iGvx1SrOtHtzUPNpxUDvYYvsGe/kP3BJzqNREPjUuVpdYonkzHEkZb
         s60o2ME39m8SEz4e6HnGukijAnVlv/OVkjCFYZwO/dFEOA8+Uy0C9siLotlPC1o5VK
         rF36rF+o+vf7A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10ea9ef5838so10930635fac.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Aug 2022 00:47:09 -0700 (PDT)
X-Gm-Message-State: AJIora++UUCnVBU8M+pXN/d6nXEozYtEXmmHP4sSNAkUHLYTwHe0lZzf
        ShuaGzgkJbkXqVMksYhoFCF7iRD/uATNjNKt6cQ=
X-Google-Smtp-Source: AGRyM1sKIEX38qbGEzivnpC35ZeuuluIo+0nD3GOWdH7hDs8IoWXRm4oAesZu4udekx588nxPgKHe1+VmUMIXN8RTlI=
X-Received: by 2002:a05:6870:b403:b0:10e:7914:adb with SMTP id
 x3-20020a056870b40300b0010e79140adbmr9040142oap.126.1659426428305; Tue, 02
 Aug 2022 00:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
In-Reply-To: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 Aug 2022 09:46:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFWN80TENuP-0E09LEqrqqL2zoS3SDCeQE7aMZuBPA53Q@mail.gmail.com>
Message-ID: <CAMj1kXFWN80TENuP-0E09LEqrqqL2zoS3SDCeQE7aMZuBPA53Q@mail.gmail.com>
Subject: Re: arm64 PCI resource allocation issue
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ben,

On Tue, 2 Aug 2022 at 06:13, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Hi Folks !
>
> It's been a while ... (please extend the CC list as needed)
>
> I'd like to re-open an ancient issue because it's still biting us
> (AWS).
>
> A few years back, I updated the PCIe resource allocation code to be a
> bit more in line with what other architectures do. That said, once
> thing we couldn't agree on was to do like x86 and default to preserving
> the firmware provided resources by default.
>
> On x86, the kernel "allocates" (claims) the resources (unless it finds
> something obviously wrong), then allocates anything left unallocated.
>
> On arm64, we use to just re-allocate everything. I changed this to
> first use some more common code for doing all that, but also to have
> the option to claim existing resources if _DSM tells us to preserve
> them for a given host brigde.
>
> I still think this is the wrong way to go and that we should preserve
> the UEFI resources by default unless told not to :-)
>

+1

Using _DSM #5 also prevents, e.g., the AMD GPU driver from resizing
its BARs, which is unfortunate. And the CXL stuff that is layered on
top of PCIe is going to get trickier when the OS is free to reassign
resources, so I expect _DSM #5 to be used more widely in that context.

So are there any other reasons to avoid _DSM #5 in your case?

> The case back then was that there existed some (how many ? there was
> one real example if I remember correctly) bogus firwmares that came out
> of UEFI with too small windows. We could just quirk those ....
>

Agreed. We could add another hint at the firmware level that the PCIe
resources have been assigned, and as far as the firmware is concerned,
no changes are needed. This would be weaker than _DSM #5 (which means
'resource allocations *must* be honored for some unspecified reason,
which is similar to 'probe-only' on DT, i.e., any problems will not be
fixed)

> The reason I'm bringing this back is that re-allocating resources for
> system devices cause problems.
>
> The most obvious one today that is affecting EC2 instances is that the
> UART address specified in SPCR is no longer valid, causing issues
> ranging from the console not working to MMIO to what becomes "random
> addresses". Typically today this is "worked around" by using
> console=ttyS0 to force selection of the first detected PCI UART,
> because the match against SPCR is based on address and it won't match,
> but there's always the underlying risk that things like earlycon starts
> poking at now-incorrect addresses until 8250 takes over.
>
> This is the most obvious problem. Any other "system" device that
> happens to be PCIe based (anything detected early, via device-tree,
> ACPI or otherwise) is at risk of a similar issue. On x86 that could be
> catastrophic because near everything looks like a PCI device, on arm64
> we seem to have been getting away with it a bit more easily ... so far.
>

So what is the reason you are avoiding _DSM #5?

> The alternative here would be to use ad-hock kludges for such system
> devices, to "register" the addresses early, and have some kind of hook
> in the PCI code that keeps track of them as they get remapped.
>

Yeah, we did this for the EFI framebuffer but this doesn't really
scale IMHO so I would prefer to avoid that.

> If we want this, I would propose (happy to provide the implementation
> but let's discuss the design first) something along the line of a
> generic mechanism to "register" such a system device, which would add
> it to a list. That list would be scanned on PCI device discovery for
> BAR address matches, and the pci_dev/BAR# added to the entry (that or
> put a pointer to the entry into pci_dev for speed/efficiency).
>

This means that bus numbers cannot be reassigned, which I don't think
we rely on today. To positively identify a PCI device, you'll need
some kind of path notation to avoid relying on the bus numbers
assigned by the firmware (this could happen for hot-pluggable root
ports where no bus range has been reserved by the firmware)

> The difficulty is how is that update propagated:
>
> This is of course fiddly. For example, the serial info is passed via
> two different ways, one being earlycon (and probably the easiest to
> track), the other one an ASCII string passed to
> add_preferred_console(), which would require more significant hackery
> (the code dealing with console mathing is a gothic horror).
>
> Also if such a system device is in continuous use during the boot
> process (UART ?) it needs to be "updated" as soon as possible after the
> BARs (and parent BARs) have been also updated (in fact this is
> generally why PCI debug dies horribly when using PCI based UARTs).
> Maybe an (optional) callback that earlycon can add ?
>
> Additionally, this would only work if such system devices are
> "registered" before they get remapped...
>
> Another approach would be to have pci_dev keep a copy of the original
> resources (at least for the primary BARs) and provide an accessor for
> use by things like earlycon or 8250 to compare against these, though
> that doesn't solve the problem of promptly "updating" drivers for
> system devices.
>
> Opinions ?
>

I don't think working around it like this is going to be maintainable
in the long term. I would much rather move to a model where the OS
[conditionally] preserves the bus and BAR assignments, perhaps in a
more fine-grained way than _DSM #5? Or at least more permissive.

The last time this came up in the PCI firmware SIG, we did discuss
_DSM #5 at intermediate levels of the resource tree IIRC, which could
be one way around this. But I'd still prefer a model where the
resource assignments are guaranteed to be preserved if they meet some
kind of agreed standard between the OS and the firmware.
