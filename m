Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC31513BC0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351204AbiD1Sq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 14:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348158AbiD1Sq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 14:46:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187ABF511;
        Thu, 28 Apr 2022 11:43:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y21so6549194edo.2;
        Thu, 28 Apr 2022 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zI+9j94q19l63yFihh0+ZsjTI2C5NOx2hP5jr2k4x9k=;
        b=WK6kihR8b3wSbEull4x65571g240iY3fBAfiTXsaZDlpj/xdgiElV/P43tUu9yXSVX
         hWkKZvrStyCqJIayhO18QI89R8AHdCsLMnVVefiMboCPUg9jwW8UI371XTLloEYzpnBa
         B0GUhQiLmGId/z5djVFsZ7AFAUgOKJDiPHULAklgepOzju10xb0RTX4BA1BeUnJ/S377
         TjafnXdVqpgpA3pC8zc1MJup7/P2VeO9LxoimierGf1yWwgM8XqY65KnT+hRZSeagjyb
         oxpyI9c1YV+pNkCdzr9uu3mIs5PfLCToQJgYckJ8Hywf72cLHHacgZsutwe5E7PxhHXF
         hUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zI+9j94q19l63yFihh0+ZsjTI2C5NOx2hP5jr2k4x9k=;
        b=6rwKrNuSL0XXu0nYcWhXHUxkiJdS2bOd1jVGDf3qfKXkJZAt1lr0w5qDT1PZgbv8M2
         z5nwnb92MWy6YKsBRTRFUgit321njLjbuC4dIX+ae9rCQM0jMvzlqJKMi7t1PeTayKwr
         O5pRZHw+PObWpVMNA3M+9A79AVUoIMs6ffCtCaNsAhaRMJ6J/pXcyu19RBc5FOROfCPX
         Ivg2olImHdHjHoMnYxXK9mllPBsZ2ukYuoIzklOLR6xIbUIPbRHoJ/IiOLCIrzcR6YpY
         TCLKTz/EkaR0+vb9jRLIjeTcByibZsIez7LeSMOUplorU2uEHrEaZL6AJmWijEIvm6D3
         RCTg==
X-Gm-Message-State: AOAM533e7emqyzaBYTne6YYBnvz2WYPjTaC41HrEeAK2VNkYaBhr5D2I
        Jo5VXboGAbfeCWf36SRCMoY=
X-Google-Smtp-Source: ABdhPJx/YPYe4JPKWoxoRcaMVgX4E0nnzI2Yu9Okc03Ig2cnSUmTTSqOuZdSRJVF91tk7qq1rWWdDg==
X-Received: by 2002:aa7:d954:0:b0:425:f621:f77f with SMTP id l20-20020aa7d954000000b00425f621f77fmr18775972eds.363.1651171390413;
        Thu, 28 Apr 2022 11:43:10 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709060b5100b006f38cf075cbsm273241ejg.104.2022.04.28.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 11:43:09 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Thu, 28 Apr 2022 20:43:07 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Dusty Mabe <dustymabe@redhat.com>, Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, x86@kernel.org, maz@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Noah Meyerhans <noahm@debian.org>
Subject: Re: [tip: irq/urgent] PCI/MSI: Mask MSI-X vectors only on success
Message-ID: <YmrgO09bqePgiJJd@eldamar.lan>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
 <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
 <Ymj3zzjQ9PwYaX/p@eldamar.lan>
 <87v8uuwhs4.ffs@tglx>
 <87wnf9uxnw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnf9uxnw.ffs@tglx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Thu, Apr 28, 2022 at 03:48:03PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 27 2022 at 19:35, Thomas Gleixner wrote:
> > On Wed, Apr 27 2022 at 09:59, Salvatore Bonaccorso wrote:
> > XEN guests do not use the common PCI mask/unmask machinery which would
> > unmask the interrupt on request_irq().
> >
> > So I assume that the following happens:
> >
> > Guest                     Hypervisor
> >
> > msix_capabilities_init()
> >         ....
> >         alloc_irq()
> >            xen_magic()  -> alloc_msix_interrupt()
> >                            request_irq()
> >
> >         msix_mask_all() -> trap
> >                              do_magic()
> > request_irq()
> >    unmask()
> >      xen_magic()
> >        unmask_evtchn()  -> do_more_magic()
> >
> > So I assume further that msix_mask_all() actually is able to mask the
> > interrupts in the hardware (ctrl word of the vector table) despite the
> > hypervisor having allocated and requested the interrupt already.
> >
> > Nothing in XEN_HVM handles PCI/MSI[-X] mask/unmask in the guest, so I
> > really have to ask why XEN_HVM does not disable PCI/MSI[-X] masking like
> > XEN_PV does. I can only assume the answer is voodoo...
> >
> > Maybe the XEN people have some more enlightened answers to that.
> 
> So I was talking to Juergen about this and he agrees, that for the case
> where a XEN HVM guest uses the PIRQ/Eventchannel mechanism PCI/MSI[-X]
> masking should be disabled like it is done for XEN PV.
> 
> Why the hypervisor grants the mask write is still mysterious, but I
> leave that to the folks who can master the XEN voodoo.
> 
> I'll send out a patch in minute.

Thank you. We are having Noah Meyerhans now testing the patch and he
will report back if it works (Cc'ed here now).

Regards,
Salvatore
