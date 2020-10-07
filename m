Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C12859D2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgJGHsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 03:48:30 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D4C061755;
        Wed,  7 Oct 2020 00:48:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l17so1109349edq.12;
        Wed, 07 Oct 2020 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIxS3a1/Usr8Ax4oAxdfAOqWyGV3Kir87fjE4KL3SWA=;
        b=Zkp2OT1dBxSRUm4UBunol1MkXZDcFD/RX1FhRudN2vPdQItuQfLLBD3IMuvchLOMGo
         2l3/52w502E1A9Vumv8M3LN2i/KKNZKr9OFE/7GUmTIW3iU7/MCyGd2/1x9X/BhT4QqT
         bhkaqv5wjJIYoxKxZt1b9KCCcbf+Q0s0hIlWSClE3lzP2+pDq15tkVXZv4agKtxnA2b+
         F4q6R2X7yWm+3XPDnoKFp1lMjcoOwdYbLiFvkFzrga9MwWiOjjcRTCd8+nYbDLu1IGia
         yIPZbwRBcdrcONxBt9ekMT0Q7X3NJnFTCo77i8W6IQ/Bg9l/85Di3yFpNJZbmrT8XGCn
         sgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIxS3a1/Usr8Ax4oAxdfAOqWyGV3Kir87fjE4KL3SWA=;
        b=Ljo3/a/+jyhGOok6Lj6PRkctxPCJUVR97Gl84H1SZDOywveAPFhAgRJtmF1ExX3MLR
         AAPS4IqwfkcSyWqYkmJteNmZethl1VBI2T0CVx1XOIeOu6zHZSJCfAywIX3wP31XMQE7
         9m+/y77QFp8lnAGOEKrv+9XAxO2XBkFzNfpkoYpr3U3x6Qni0Mvo3wwyO4D51YJxN3Pe
         vYIgqBFg4YYRv22xsa6oRtDVWahmmGKuYh0sh58fZmods5WWsnzMo03j7/T/ILgx89sA
         Axwr42mwXD9TBS5VVlc1WQ6KTrmQ/6Iop6cvZGuiaWw7KVok2ZUwmSNGH7a5kGxF4scz
         91kg==
X-Gm-Message-State: AOAM531YZ58Rws49P2aCNOtr78O/Fz7T5FBLMlBEtaehJxWLILgJj+D6
        j9MeU/wSMv3DV7AaeK/iD3wOqEWBZxn6Iu7FQmA=
X-Google-Smtp-Source: ABdhPJwsp4gWugt5zYoY/WqXwmjYqS76upRymp0LRLz2XkAXOwb1wEAWa9UTuA6na/2PbKPQ0dVTqSmOh4Y6FDI5ZkY=
X-Received: by 2002:a50:b063:: with SMTP id i90mr2229989edd.187.1602056909027;
 Wed, 07 Oct 2020 00:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201003075514.32935-1-haifeng.zhao@intel.com>
 <20201003075514.32935-4-haifeng.zhao@intel.com> <20201004191329.GA27962@wunner.de>
In-Reply-To: <20201004191329.GA27962@wunner.de>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 7 Oct 2020 15:48:17 +0800
Message-ID: <CAKF3qh1coHqCHqpa_f8Mh4Ere+_xE2qACoNSyo2wYiOboYiNjQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas,

On Mon, Oct 5, 2020 at 3:13 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sat, Oct 03, 2020 at 03:55:12AM -0400, Ethan Zhao wrote:
> > When root port has DPC capability and it is enabled, then triggered by
> > errors, DPC DLLSC and PDC etc interrupts will be sent to DPC driver, pciehp
> > drivers almost at the same time.
>
> Do the DLLSC and PDC events occur as a result of handling the error
> or do they occur independently?
They could happen independently if links were recovered then the card
was removed.
They could happen as a result of handling the errors the same time.

So don't assume DLLSC and PDC all occur at the same time.

>
> If the latter, I don't see how we can tell whether the card in the
> slot is still the same.
If PDC happens, the card in the slot might not be the same.  so
hot-removal /hot -plugin handling follows the PDC event.
>
> If the former, holding the hotplug slot's reset_lock and doing something
> along the lines of pciehp_reset_slot() (or calling it directly) might
> solve the race.

DPC reset is done by hardware, only AER calls pciehp_reset_slot() as recovery
handling initiated by software.

Thanks,
Ethan
>
> Thanks,
>
> Lukas
