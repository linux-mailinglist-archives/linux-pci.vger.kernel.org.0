Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE47E967B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 06:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjKMFne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 00:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMFne (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 00:43:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F461709
        for <linux-pci@vger.kernel.org>; Sun, 12 Nov 2023 21:43:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40a48775c58so20282225e9.3
        for <linux-pci@vger.kernel.org>; Sun, 12 Nov 2023 21:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699854208; x=1700459008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhHN7O93waVt11wa6SX8/dSGCmxRKEMMr4q4LYfCtPI=;
        b=rN9C/fkyjq/ZbyPzOSrukDffU26AdPkoSiKZgXWhnMHpHVY86OikDypOlZXFF3ImI3
         83MieGr6r6pFT/a9VpleIaRwBmgZGyEgnPuuZIdCDi7t/Vkha5l035Otoo38U8EHseAP
         a5REbRLQOUHXB7RBroq3R6EPqi7uDVRTd2NnFyBX9hM0u5ZeYl3072fW87cR+01xKhG5
         hd+uqn57v3E5tQVE4QyKk4vzWGg6t7IOELd5CUjvFkvKoN5pNGwMnL2ulnZd2IMytzNl
         PUvXZJIyp/F9fs2khPPR3eH+G4N1wEppZRckAAavVeII04D+L69BO96PFuGDTbTC+PjT
         V4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699854208; x=1700459008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhHN7O93waVt11wa6SX8/dSGCmxRKEMMr4q4LYfCtPI=;
        b=jqGlqBhWl5N4DK+479Z4al6KlmCGP+B5TCKf66tsqcsd/INHYuiLjVxoSx0wGawNVd
         uukVHvylG1yNgvR+9uqutsZaJoqLX8BFo653G8okufXy6I/jr5Hls9kEx7iZAxI5ykm4
         lopO59+BG1iADhjjnVAkvf2qIK1/vAuGX4/gWg0cVt/gvvZgpOvDdmJ/0ShXvjSVUZVD
         M0rBFl/DPVXYo8MOvB+adKEOkyZy3GHSV0mF98T1Jjr2HC9sbdrAigNEhhgrh2UVerVK
         Uw93UPKyt+nkfBXRFKnFehR+g2Bsheta/xn2uA9qYr3ge3k7Ff3h2ccEedMU+ojaPVw6
         UpOQ==
X-Gm-Message-State: AOJu0Yw06owgIgqlGMyM8K4V8JWdy+tY/y7UaTInDpzH6MXmg+gHEP0t
        N9bT/+LtvNMg2czaLoJLjSyQ5w==
X-Google-Smtp-Source: AGHT+IETQgYjc0LVkzBsM+Fe+jtpGKe/99W2fGyK3xlMw1EPH56T3INTRwrxOPb+IFOsEZlJ6jIlZg==
X-Received: by 2002:a05:600c:524c:b0:3fd:2e89:31bd with SMTP id fc12-20020a05600c524c00b003fd2e8931bdmr4795155wmb.14.1699854208249;
        Sun, 12 Nov 2023 21:43:28 -0800 (PST)
Received: from vermeer ([2a01:cb1d:81a9:dd00:a3fd:7e78:12c3:f74b])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003fef5e76f2csm8667754wms.0.2023.11.12.21.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 21:43:27 -0800 (PST)
Date:   Mon, 13 Nov 2023 06:43:25 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     linux-coco@lists.linux.dev, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: TDISP enablement
Message-ID: <ZVG3fREeTQqvHLb/@vermeer>
References: <e05eafd8-04b3-4953-8bca-dc321c1a60b9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05eafd8-04b3-4953-8bca-dc321c1a60b9@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexey,

On Wed, Nov 01, 2023 at 09:56:11AM +1100, Alexey Kardashevskiy wrote:
> Hi everyone,
> 
> Here is followup after the Dan's community call we had weeks ago.
> 
> Our (AMD) goal at the moment is TDISP to pass through SRIOV VFs to
> confidential VMs without trusting the HV and with enabled IDE (encryption)
> and IOMMU (performance, compared to current SWIOTLB). I am aware of other
> uses and vendors and I spend hours unsuccessfully trying to generalize all
> this in a meaningful way.
> 
> The AMD SEV TIO verbs can be simplified as:
> 
> - device_connect - starts CMA/SPDM session, returns measurements/certs, runs
> IDE_KM to program the keys;
> - device_reclaim - undo the connect;
> - tdi_bind - transition the TDI to TDISP's LOCKED and RUN states, generates
> interface report;

From a VF to TVM use case, I think tdi_bind should only transition to
LOCKED, but not RUN. RUN should only be reached once the TVM approves
the device, and afaiu this is a host call.

> - tdi_unbind - undo the bind;
> - tdi_info - read measurements/certs/interface report;
> - tdi_validate - unlock TDI's MMIO and IOMMU (or invalidate, depends on the
> parameters).

That's equivalent to the TVM accepting the TDI, and this should
transition the TDI from LOCKED to RUN.


> The first 4 called by the host OS, the last two by the TVM ("Trusted VM").
> These are implemented in the AMD PSP (platform processor).
> There are CMA/SPDM, IDE_KV, TDISP in use.
> 
> Now, my strawman code does this on the host (I simplified a bit):
> - after PCI discovery but before probing: walk through all TDISP-capable
> (TEE-IO in PCIe caps) endpoint devices and call device_connect;

Would the host call device_connect unconditionally for all TEE-IO device
probed on the host? Wouldn't you want to do so only before the first
tdi_bind for a TDI that belongs to the physical device?


> - when drivers probe - it is all set up and the device measurements are
> visible to the driver;
> - when constructing a TVM, tdi_bind is called;

Here as well, the tdi_bind could be asynchronous to e.g. support hot
plugging TDIs into TVMs.


> 
> and then in the TVM:
> - after PCI discovery but before probing: walk through all TDIs (which will
> have TEE IO bit set) and call tdi_info, verify the report, if ok - call
> tdi_validate;

By verify you mean verify the reported MMIO ranges? With support from
the TSM?
We discussed that a few times, but the device measurements and
attestation report should also be attested, i.e. run against a relying
party. The kernel may not be the right place for that, and I'm proposing
for the guest kernel to rely on a user space component and offload the
attestation part to it. This userspace component would then
synchronously return to the guest kernel with an attestation result.

> - when drivers probe - it is all set up and the driver decides if/which DMA
> mode to use (SWIOTLB or direct), or panic().
> 

When would it panic?

> Uff. Too long already. Sorry. Now, go to the problems:
> 
> If the user wants only CMA/SPDM, 

By user here, you mean the user controlling the host? Or the TVM
user/owner? I assume the former.

> the Lukas'es patched will do that without
> the PSP. This may co-exist with the AMD PSP (if the endpoint allows multiple
> sessions).
> 
> If the user wants only IDE, the AMD PSP's device_connect needs to be called
> and the host OS does not get to know the IDE keys. Other vendors allow
> programming IDE keys to the RC on the baremetal, and this also may co-exist
> with a TSM running outside of Linux - the host still manages trafic classes
> and streams.
> 
> If the user wants TDISP for VMs, this assumes the user does not trust the
> host OS and therefore the TSM (which is trusted) has to do CMA/SPDM and IDE.
> 
> The TSM code is not Linux and not shared among vendors. CMA/SPDM and IDE
> seem capable of co-existing, TDISP does not.

Which makes sense, TDISP is not designed to be used outside of the
TEE-IO VFs assigned to TVM use case.

> 
> However there are common bits.
> - certificates/measurements/reports blobs: storing, presenting to the
> userspace (results of device_connect and tdi_bind);
> - place where we want to authenticate the device and enable IDE
> (device_connect);
> - place where we want to bind TDI to a TVM (tdi_bind).
> 
> I've tried to address this with my (poorly named) drivers/pci/pcie/tdisp.ko
> and a hack for VFIO PCI device to call tdi_bind.
> 
> The next steps:
> - expose blobs via configfs (like Dan did configfs-tsm);
> - s/tdisp.ko/coco.ko/;
> - ask the audience - what is missing to make it reusable for other vendors
> and uses?

The connect-bind-run flow is similar to the one we have defined for
RISC-V [1]. There we are defining the TEE-IO flows for RISC-V in
details, but nothing there is architectural and could somehow apply to
other architectures.

Cheers,
Samuel.

[1] https://github.com/riscv-non-isa/riscv-ap-tee-io/blob/main/specification/07-theory_operations.adoc
