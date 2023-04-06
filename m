Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD26DA57A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 00:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbjDFWCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjDFWCN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 18:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD925AF2B
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680818474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZgWSpLB+yTdG51PaN84d5D/45oHufcOZ1TMbFdiLV8=;
        b=P/oqnRKvM0ceKAAH363amgb+i2BEj0VXkYB/n4CPS5Xgxq5H7OQg/ZFyP8JcxbZQga2vEB
        BXfYEPo0aKzcIzwQUEooJNUGzi2hh9GIo6r7MoVrUN7rxGtGmdOal45dacfsfbadaTBHZE
        +SBFi6uXKyNQhCftr6ZeqQY+WO/tEZA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-vBUBIAS4NaKyECWNlTwnSA-1; Thu, 06 Apr 2023 18:01:13 -0400
X-MC-Unique: vBUBIAS4NaKyECWNlTwnSA-1
Received: by mail-il1-f200.google.com with SMTP id d12-20020a056e020bec00b00325e125fbe5so26626455ilu.12
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 15:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818473; x=1683410473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZgWSpLB+yTdG51PaN84d5D/45oHufcOZ1TMbFdiLV8=;
        b=wBAagmPGfaCStYOuyNDZ3EsQZSyN6bWX9pW/hJiwakSIQM/nb/vgTtBEa1Gh6reaX9
         xUoECnywY7P5NScHwjZY2uRGnkt9/Gg4S0ZI4k8hvtoUkdgLC+jKxPt2BsAMo6atDJ/y
         XwY4piGJrRjlwBxiKp7uEss2EztihsICYsGrS1w72Kz96ndGZ99ZNWWPqcDrAS5w+zce
         sNzILZzlqDAytCtuEbIAT+jTPhdHMXoLtJCzviCSLwIDVxRXrws8+BfA0IEEs6bVXuMe
         xUf7rwrMsdDjWTo0QTO/3Lh683U8uI6umxxqlUX+Ex0Bks/mNZHrqdFii/K2koQHdRyl
         ZEbA==
X-Gm-Message-State: AAQBX9fw5hugB+JYKfJDesdZ1aUr4XFxPaCljY6SrhmSqbUsaNEcyUi/
        bcm+8sOjqDmsPk0ln6wkM/g1r6Sw3qtOd2Xlte/gilT4RdSxv/iw6UiBlDbgyBPss/6I9ZZuwJQ
        fpPEIkpfRPEPc1dSdZHta
X-Received: by 2002:a5e:990a:0:b0:74c:822c:a6ac with SMTP id t10-20020a5e990a000000b0074c822ca6acmr152863ioj.15.1680818472728;
        Thu, 06 Apr 2023 15:01:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZhiyIQZSywXTEH4GEFSyZKA2VQCHUgNelwIKTGRoHMb9y8wbZFEao+L8eIFSb+1Fd4fg0eBA==
X-Received: by 2002:a5e:990a:0:b0:74c:822c:a6ac with SMTP id t10-20020a5e990a000000b0074c822ca6acmr152841ioj.15.1680818472420;
        Thu, 06 Apr 2023 15:01:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i35-20020a023b63000000b0040610ade715sm646501jaf.83.2023.04.06.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:01:11 -0700 (PDT)
Date:   Thu, 6 Apr 2023 16:01:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, abhsahu@nvidia.com, targupta@nvidia.com,
        zhguo@redhat.com, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [RFC PATCH] PCI: Extend D3hot delay for NVIDIA HDA controllers
Message-ID: <20230406160110.121cdc14.alex.williamson@redhat.com>
In-Reply-To: <20230406215049.GA3741554@bhelgaas>
References: <168004421186.935858.12296629041962399467.stgit@omen>
        <20230406215049.GA3741554@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Apr 2023 16:50:49 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Sajid, author of 3e347969a577]
> 
> On Tue, Mar 28, 2023 at 04:59:30PM -0600, Alex Williamson wrote:
> > Assignment of NVIDIA Ampere-based GPUs have seen a regression since the
> > below referenced commit, where the reduced D3hot transition delay appears
> > to introduce a small window where a D3hot->D0 transition followed by a bus
> > reset can wedge the device.  The entire device is subsequently unavailable,
> > returning -1 on config space read and is unrecoverable without a host reset.
> > 
> > This has been observed with RTX A2000 and A5000 GPU and audio functions
> > assigned to a Windows VM, where shutdown of the VM places the devices in
> > D3hot prior to vfio-pci performing a bus reset when userspace releases the
> > devices.  The issue has roughly a 2-3% chance of occurring per shutdown.
> > 
> > Restoring the HDA controller d3hot_delay to the effective value before the
> > below commit has been shown to resolve the issue.  
> 
> Interesting.  This sounds like it was a hassle to track down.  I guess
> we knew there was some risk in reducing those delays.
> 
> Did you by chance notice whether the actual delay when the device gets
> wedged is sufficient per spec?
> 
> If there's a case where the usleep_range() doesn't quite wait the
> spec-mandated time, we should adjust that in case we have the same
> problem with other devices.

That would have been a good test, unfortunately I didn't check and
don't currently have access to the system anymore.  Perhaps this is
something the NVIDIA folks can check as they're investigating the scope
of affected hardware.  Thanks,

Alex

> > I'm looking for input from NVIDIA whether this issue is unique to
> > Ampere-based HDA controllers or should be assumed to linger in both older
> > and newer controllers as well.  Currently we've not been able to reproduce
> > the issue other than on Ampere HDA controllers, however the implementation
> > here includes all NVIDIA HDA controllers based on PCI vendor and device
> > class.
> > 
> > If we were to limit the quirk to Ampere HDA controllers, I think that would
> > include:
> > 
> > 1aef	GA102 High Definition Audio Controller
> > 228b	GA104 High Definition Audio Controller
> > 228e	GA106 High Definition Audio Controller
> > 
> > Cc: Abhishek Sahu <abhsahu@nvidia.com>
> > Cc: Tarun Gupta <targupta@nvidia.com>
> > Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
> > Reported-by: Zhiyi Guo <zhguo@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/quirks.c |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44cab813bf95..f4e2a88729fd 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -1939,6 +1939,19 @@ static void quirk_radeon_pm(struct pci_dev *dev)
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
> >  
> > +/*
> > + * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
> > + * reset is performed too soon after transition to D0, extend d3hot_delay
> > + * to previous effective default for all NVIDIA HDA controllers.
> > + */
> > +static void quirk_nvidia_hda_pm(struct pci_dev *dev)
> > +{
> > +	quirk_d3hot_delay(dev, 20);
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > +			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
> > +			      quirk_nvidia_hda_pm);
> > +
> >  /*
> >   * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
> >   * https://bugzilla.kernel.org/show_bug.cgi?id=205587
> > 
> >   
> 

