Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88732511D68
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiD0RjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiD0RjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 13:39:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6801DA;
        Wed, 27 Apr 2022 10:35:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651080956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qjO8s/OIZlRIxFj/dKZMzlBxBdMPyHEWF3GHS0EwOs=;
        b=S4J5Jl/unOv5uNbzxkVeP6Egeq+fobdyzB3toH/ywdoE6jq+4/YTl9XHuCC3BWrilA8AxQ
        Ck+cPM/RyhvnYKCCRC5FkxpawDlZ92bbYGEyeFciy50dQZMqKCsBO47OyUauDDenXyHtiF
        NNfpbQe8OJsU49Yv3AE4gBclE7TNjvSVAL0jZKd7EIe6Hi8wQJYRb5hAClfkQwOb2tITlN
        vx4bUZgsruLHBtYRJRYccbiIgCkors5OLaOGrYYyLDSBeHVGGx2B6CA7yaFjvGkYGZslLF
        cxD3dVUYkTFkxBU6k+TirDMnXEO7FJdrdAjctGxqkJkRzSieLvCwuaQiMgZTEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651080956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qjO8s/OIZlRIxFj/dKZMzlBxBdMPyHEWF3GHS0EwOs=;
        b=sQLqi6CUFoNA5lfVUvWcpcYSzF819myOCs4l3uDBObAeCkL1/3/LS+fxlwsj+Jx9DuN8/V
        PsqBLCloII5DjpAg==
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dusty Mabe <dustymabe@redhat.com>, Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, x86@kernel.org, maz@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [tip: irq/urgent] PCI/MSI: Mask MSI-X vectors only on success
In-Reply-To: <Ymj3zzjQ9PwYaX/p@eldamar.lan>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
 <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
 <Ymj3zzjQ9PwYaX/p@eldamar.lan>
Date:   Wed, 27 Apr 2022 19:35:55 +0200
Message-ID: <87v8uuwhs4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27 2022 at 09:59, Salvatore Bonaccorso wrote:
> On Mon, Mar 14, 2022 at 09:29:53PM +0100, Jeremi Piotrowski wrote:
>
> Does someone knows here on current state of the AWS instances using
> the older Xen version which causes the issues?
>
> AFAIU upstream is not planning to revert 83dbf898a2d4 ("PCI/MSI: Mask
> MSI-X vectors only on success") as it fixed a bug. Now several
> downstream distros do carry a revert of this commit, which I believe
> is an unfortunate situation and wonder if this can be addressed
> upstream to deal with the AWS m4.large instance issues.

The problem is that except for a bisect result we've not seen much
information which might help to debug and analyze the problem.

The guest uses MSI-X on that NIC:

 Capabilities: [70] MSI-X: Enable+ Count=3 Masked-

So looking at the commit in question:

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 48e3f4e47b29..6748cf9d7d90 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -722,9 +722,6 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 		goto out_disable;
 	}
 
-	/* Ensure that all table entries are masked. */
-	msix_mask_all(base, tsize);
-
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
 		goto out_disable;
@@ -751,6 +748,16 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
+
+	/*
+	 * Ensure that all table entries are masked to prevent
+	 * stale entries from firing in a crash kernel.
+	 *
+	 * Done late to deal with a broken Marvell NVME device
+	 * which takes the MSI-X mask bits into account even
+	 * when MSI-X is disabled, which prevents MSI delivery.
+	 */
+	msix_mask_all(base, tsize);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);

IOW, it moves the invocation of msix_mask_all() into the success
path.

As the device uses MSI-X this change does not make any difference from a
hardware perspective simply because _all_ MSI-X interrupts are masked
via the CTRL register already. And it does not matter whether the kernel
masks them individually _before_ or _after_ the allocation. At least not
on real hardware and on a sane emulation.

Now this is XEN and neither real hardware nor sane emulation.

It must be a XEN_HVM guest because XEN_PV guests disable PCI/MSI[-X]
completely which makes the invocation of msix_mask_all() a NOP.

If it's not a XEN_HVM guest, then you can stop reading further as I'm
unable to decode why moving a NOP makes a difference. That belongs in to
the realm of voodoo, but then XEN is voodoo at least for me. :)

XEN guests do not use the common PCI mask/unmask machinery which would
unmask the interrupt on request_irq().

So I assume that the following happens:

Guest                     Hypervisor

msix_capabilities_init()
        ....
        alloc_irq()
           xen_magic()  -> alloc_msix_interrupt()
                           request_irq()

        msix_mask_all() -> trap
                             do_magic()
request_irq()
   unmask()
     xen_magic()
       unmask_evtchn()  -> do_more_magic()

So I assume further that msix_mask_all() actually is able to mask the
interrupts in the hardware (ctrl word of the vector table) despite the
hypervisor having allocated and requested the interrupt already.

Nothing in XEN_HVM handles PCI/MSI[-X] mask/unmask in the guest, so I
really have to ask why XEN_HVM does not disable PCI/MSI[-X] masking like
XEN_PV does. I can only assume the answer is voodoo...

Maybe the XEN people have some more enlightened answers to that.

Thanks,

        tglx
