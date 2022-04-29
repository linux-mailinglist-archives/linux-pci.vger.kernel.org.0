Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBE514270
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiD2Gkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 02:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiD2Gkw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 02:40:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC68B8982;
        Thu, 28 Apr 2022 23:37:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d6so7928073ede.8;
        Thu, 28 Apr 2022 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nCh6oNjAx5FSblxx+ha1zviQ3WYAVbuqIr2sZ2uR4I4=;
        b=iHgEG3TivvCfzr52JvRgNAZju6J95yv92A2qoKNoJMXpUMbwf9Kc39zMa3n4qUnk2L
         A2klT0lUGRgnXnD8WbpULxdkEojyi3XscpGE+CqbZ7Bj7BnqviQXWRrDtqSxWul6LTqi
         2HROOAwn1q/uNuAE6NB/pkUtTDf9G1VJhkaKy9ov4/oqylfUUZZcY6PD3h13SOMFHgqU
         4zq5Cwl1Snm5q+rLMbeuNcuNULvA71Xr/XD0+/bP4bnTQLwA4CJ4P7cr0xHtsRt3isBQ
         cHLn1jr5cl4wTa2e0fZvGnfD44XUm7/tvaS8NvQOlZotNo9ODdaysiz7zDsD/Dok680F
         286g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nCh6oNjAx5FSblxx+ha1zviQ3WYAVbuqIr2sZ2uR4I4=;
        b=zzAKdnixOUD/0GYf6xtbsfevPKvvmNbGUj6BPC0eIqXxlPnuANtbCQrjMQJXFKh2IN
         hboTC5RJlBwcxDuef8uAPHrSUWMFiJMNb2caHS7AvEFVOE5kMqvVrLaAXfShDrNgBXh6
         g/dQWLEzGa+qJ4YjKHnsla6fJE4WrYvT8wqnr07eBS+/52Nr0UZCRMTWqXVxZVKSv5HE
         J3WOyR3xPq2+cOUTueHD/v4rkPfBC398qgK3MadMpzyBArXxgCHUdPlClE6HiFIAaZSJ
         GGk1OJHhddhqQobqMW2eIkIQXYGYnyhq6IH0T9FWvr5Q688Qiq4MalfFudIhf5/WWqzG
         OpmA==
X-Gm-Message-State: AOAM5312tQF4iiQTMHStPGWHymas4TXZ6mZV1OUo0bgUMvhfuzD/MHjj
        448i3u4bD/LhxmcwqTW30gw=
X-Google-Smtp-Source: ABdhPJwMWErbg5tUE6ecjecll6VEyFASIGhMqJeTjGGGjDBTNnu0r84VpI9YskE7O58vNjFpZn67dA==
X-Received: by 2002:aa7:d9d9:0:b0:425:fcc7:d132 with SMTP id v25-20020aa7d9d9000000b00425fcc7d132mr17610649eds.89.1651214253014;
        Thu, 28 Apr 2022 23:37:33 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7d40f000000b0042617ba63b9sm2577858edq.67.2022.04.28.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 23:37:31 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Fri, 29 Apr 2022 08:37:30 +0200
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
Message-ID: <YmuHqi5K/P8QWYyO@eldamar.lan>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
 <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
 <Ymj3zzjQ9PwYaX/p@eldamar.lan>
 <87v8uuwhs4.ffs@tglx>
 <87wnf9uxnw.ffs@tglx>
 <YmrgO09bqePgiJJd@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmrgO09bqePgiJJd@eldamar.lan>
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

On Thu, Apr 28, 2022 at 08:43:10PM +0200, Salvatore Bonaccorso wrote:
> Hi Thomas,
> 
> On Thu, Apr 28, 2022 at 03:48:03PM +0200, Thomas Gleixner wrote:
> > On Wed, Apr 27 2022 at 19:35, Thomas Gleixner wrote:
> > > On Wed, Apr 27 2022 at 09:59, Salvatore Bonaccorso wrote:
> > > XEN guests do not use the common PCI mask/unmask machinery which would
> > > unmask the interrupt on request_irq().
> > >
> > > So I assume that the following happens:
> > >
> > > Guest                     Hypervisor
> > >
> > > msix_capabilities_init()
> > >         ....
> > >         alloc_irq()
> > >            xen_magic()  -> alloc_msix_interrupt()
> > >                            request_irq()
> > >
> > >         msix_mask_all() -> trap
> > >                              do_magic()
> > > request_irq()
> > >    unmask()
> > >      xen_magic()
> > >        unmask_evtchn()  -> do_more_magic()
> > >
> > > So I assume further that msix_mask_all() actually is able to mask the
> > > interrupts in the hardware (ctrl word of the vector table) despite the
> > > hypervisor having allocated and requested the interrupt already.
> > >
> > > Nothing in XEN_HVM handles PCI/MSI[-X] mask/unmask in the guest, so I
> > > really have to ask why XEN_HVM does not disable PCI/MSI[-X] masking like
> > > XEN_PV does. I can only assume the answer is voodoo...
> > >
> > > Maybe the XEN people have some more enlightened answers to that.
> > 
> > So I was talking to Juergen about this and he agrees, that for the case
> > where a XEN HVM guest uses the PIRQ/Eventchannel mechanism PCI/MSI[-X]
> > masking should be disabled like it is done for XEN PV.
> > 
> > Why the hypervisor grants the mask write is still mysterious, but I
> > leave that to the folks who can master the XEN voodoo.
> > 
> > I'll send out a patch in minute.
> 
> Thank you. We are having Noah Meyerhans now testing the patch and he
> will report back if it works (Cc'ed here now).

To confirm: Noah tested the patch on various different Xen (and other
VM configurations) and works well.

Regards,
Salvatore
