Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D855135A2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbiD1NvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344676AbiD1NvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 09:51:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41F49C87;
        Thu, 28 Apr 2022 06:48:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651153684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BRKdot5ttusBTKgjdBbqkbA/kf9Xlr83fTRIj0wkH84=;
        b=TDVC34fSnSPxzYcINftwPpx5/duIBp2zqhZ+Np9mWNUL0oYWvhRdoBf/AVJSgjszCnJAKk
        JtpIG2eGXh/BwJUdms03bJ3whjcZbsDcYN2eBeZY3OK2dOE5+DfZe7JezcpDL02cJsylP/
        XREMKrt+eKlYFQ7HDhiYz41wRLWtQUanqgtU6N1RYVOCu6epwNlfRYvUYCseb0bJIe6p0U
        uBqhjBhwWauqzZTyd5a7ZAFXdWimCnd67tZxj36aixFyahABpZxiytU2fc7ngNCxlCmiP0
        HbtJe41fB/HMZx6AlVlRgyREuJ2Ge7F5gZXpzOPwKADXmTTPVjAnu06Kj7JkOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651153684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BRKdot5ttusBTKgjdBbqkbA/kf9Xlr83fTRIj0wkH84=;
        b=iSex9BtdxA9VVKGTdcZeKTKYsnoSP0JqXGxVekCncx0EzMDri3nZItgkjhutaLCMDFCwLr
        BfAMf7EIz+w2j8Aw==
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
In-Reply-To: <87v8uuwhs4.ffs@tglx>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
 <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
 <Ymj3zzjQ9PwYaX/p@eldamar.lan> <87v8uuwhs4.ffs@tglx>
Date:   Thu, 28 Apr 2022 15:48:03 +0200
Message-ID: <87wnf9uxnw.ffs@tglx>
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

On Wed, Apr 27 2022 at 19:35, Thomas Gleixner wrote:
> On Wed, Apr 27 2022 at 09:59, Salvatore Bonaccorso wrote:
> XEN guests do not use the common PCI mask/unmask machinery which would
> unmask the interrupt on request_irq().
>
> So I assume that the following happens:
>
> Guest                     Hypervisor
>
> msix_capabilities_init()
>         ....
>         alloc_irq()
>            xen_magic()  -> alloc_msix_interrupt()
>                            request_irq()
>
>         msix_mask_all() -> trap
>                              do_magic()
> request_irq()
>    unmask()
>      xen_magic()
>        unmask_evtchn()  -> do_more_magic()
>
> So I assume further that msix_mask_all() actually is able to mask the
> interrupts in the hardware (ctrl word of the vector table) despite the
> hypervisor having allocated and requested the interrupt already.
>
> Nothing in XEN_HVM handles PCI/MSI[-X] mask/unmask in the guest, so I
> really have to ask why XEN_HVM does not disable PCI/MSI[-X] masking like
> XEN_PV does. I can only assume the answer is voodoo...
>
> Maybe the XEN people have some more enlightened answers to that.

So I was talking to Juergen about this and he agrees, that for the case
where a XEN HVM guest uses the PIRQ/Eventchannel mechanism PCI/MSI[-X]
masking should be disabled like it is done for XEN PV.

Why the hypervisor grants the mask write is still mysterious, but I
leave that to the folks who can master the XEN voodoo.

I'll send out a patch in minute.

Thanks,

        tglx
