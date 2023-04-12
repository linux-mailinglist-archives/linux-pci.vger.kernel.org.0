Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42226DFF5A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDLUEI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDLUDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 16:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086791B7
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681329780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bR2cbxOjmone/j1+D7K5ccO/FntY4lz/A5NalZ9BZsc=;
        b=FTXpooi+L6O6LfblY70ahU8j+69sLMlUX4hnlDyBsVnllUwju9UentTD7zg9jMSZMaClHY
        OgY8cpIssoPafcofUImHr5pEd3xAIPGZXfas4Xsq02F3HrQ3uehZdSG80zJl98sQ0OhnJy
        DG2dmJhIC2/0xO0P5d2WIPc/+jM0E5Q=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-6jC9yjskNNWfXdXVl0YqyA-1; Wed, 12 Apr 2023 16:02:58 -0400
X-MC-Unique: 6jC9yjskNNWfXdXVl0YqyA-1
Received: by mail-il1-f198.google.com with SMTP id l4-20020a056e02066400b00326ce9ccbadso15421571ilt.5
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 13:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329778; x=1683921778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR2cbxOjmone/j1+D7K5ccO/FntY4lz/A5NalZ9BZsc=;
        b=hacn7uRQYo/igLWQq1JP1NZLrlVfR0/noBv9810f2GdN2pRLtiEcDaoX7H9DyQXs51
         CU6cLrg36Np6oTxkWWFqK9O9kPWcbqYsqtNGuSTsdM1C+p2YGSlTj9gi+7tbJ6DGizss
         CcMqvG9zYpdDtfR03ncS/MIDHqBwUmMOMkZX2P53brbSSuN4U3xU7rSOQ6SFWPLyAJz2
         wjCbT/r+8aWD7JTsSofDE+g1WBTbW54I8wmWz+GFzPv8X39jppdk2lLLpUQ/6OPpD7/+
         lWH+obH+Lc6OPfGcFChxG3GTYqwdof5d984UapERGFI4YnMRdlJJiWIXhrvJeJNtPryk
         YogA==
X-Gm-Message-State: AAQBX9eEKU5NS3SOY9GCAENLQnP4ZvqC56HNElTzo9JDXUfQyYoTqSSA
        OfeG/yfrpzRuSfPp9/5IuUDi50oMfjKsncSV7cBpuEHYjzww7V+i0VJO/lAIDqtbA59RqaZ7hRf
        Cns71Njbg2Bq1lWdIuj0S
X-Received: by 2002:a6b:ef19:0:b0:759:1e9e:6daa with SMTP id k25-20020a6bef19000000b007591e9e6daamr2246408ioh.10.1681329777986;
        Wed, 12 Apr 2023 13:02:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350aKStQ+NoDuKO/UYKiCILy2msupf23iUICywYz0nbgTfwOegEDS3y5X9nQ/Z7ri5HnyFRQVsA==
X-Received: by 2002:a6b:ef19:0:b0:759:1e9e:6daa with SMTP id k25-20020a6bef19000000b007591e9e6daamr2246392ioh.10.1681329777709;
        Wed, 12 Apr 2023 13:02:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c12-20020a5ea80c000000b0075c47fb539asm11723ioa.0.2023.04.12.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:02:57 -0700 (PDT)
Date:   Wed, 12 Apr 2023 14:02:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        abhsahu@nvidia.com, zhguo@redhat.com,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [RFC PATCH] PCI: Extend D3hot delay for NVIDIA HDA controllers
Message-ID: <20230412140255.50c507dd.alex.williamson@redhat.com>
In-Reply-To: <29f51464-55f1-8ff5-db75-df93693e8d4f@nvidia.com>
References: <168004421186.935858.12296629041962399467.stgit@omen>
        <20230406215049.GA3741554@bhelgaas>
        <20230406160110.121cdc14.alex.williamson@redhat.com>
        <29f51464-55f1-8ff5-db75-df93693e8d4f@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Apr 2023 00:40:17 +0530
"Tarun Gupta (SW-GPU)" <targupta@nvidia.com> wrote:

> On 4/7/2023 3:31 AM, Alex Williamson wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, 6 Apr 2023 16:50:49 -0500
> > Bjorn Helgaas<helgaas@kernel.org>  wrote:
> >  
> >> [+cc Sajid, author of 3e347969a577]
> >>
> >> On Tue, Mar 28, 2023 at 04:59:30PM -0600, Alex Williamson wrote:  
> >>> Assignment of NVIDIA Ampere-based GPUs have seen a regression since the
> >>> below referenced commit, where the reduced D3hot transition delay appears
> >>> to introduce a small window where a D3hot->D0 transition followed by a bus
> >>> reset can wedge the device.  The entire device is subsequently unavailable,
> >>> returning -1 on config space read and is unrecoverable without a host reset.
> >>>
> >>> This has been observed with RTX A2000 and A5000 GPU and audio functions
> >>> assigned to a Windows VM, where shutdown of the VM places the devices in
> >>> D3hot prior to vfio-pci performing a bus reset when userspace releases the
> >>> devices.  The issue has roughly a 2-3% chance of occurring per shutdown.
> >>>
> >>> Restoring the HDA controller d3hot_delay to the effective value before the
> >>> below commit has been shown to resolve the issue.  
> >> Interesting.  This sounds like it was a hassle to track down.  I guess
> >> we knew there was some risk in reducing those delays.
> >>
> >> Did you by chance notice whether the actual delay when the device gets
> >> wedged is sufficient per spec?
> >>
> >> If there's a case where the usleep_range() doesn't quite wait the
> >> spec-mandated time, we should adjust that in case we have the same
> >> problem with other devices.  
> > That would have been a good test, unfortunately I didn't check and
> > don't currently have access to the system anymore.  Perhaps this is
> > something the NVIDIA folks can check as they're investigating the scope
> > of affected hardware.  Thanks,
> >
> > Alex
> >  
> >>> I'm looking for input from NVIDIA whether this issue is unique to
> >>> Ampere-based HDA controllers or should be assumed to linger in both older
> >>> and newer controllers as well.  Currently we've not been able to reproduce
> >>> the issue other than on Ampere HDA controllers, however the implementation
> >>> here includes all NVIDIA HDA controllers based on PCI vendor and device
> >>> class.  
> 
> Hi, I believe it is safe to include this patch for all HDA controllers and not
> limit to only Ampere-based HDA controllers. This patch looks fine to me.
> 
> Haven't explicitly tested whether usleep_range() performs as mandated, but
> from our testing it doesn't seem to be the problem. On the same platform,
> the problem reproduces on certain GPU configs but doesn't reproduce on other.

Thanks, Tarun.  Feel free to also send an explicit Acked-by: or
Reviewed-by: if you'd like.

Bjorn, I can resend this as a non-RFC if you prefer, the only change
would be deleting "I'm looking for input..." through to the Cc:s.
Thanks,

Alex

> >>>
> >>> If we were to limit the quirk to Ampere HDA controllers, I think that would
> >>> include:
> >>>
> >>> 1aef        GA102 High Definition Audio Controller
> >>> 228b        GA104 High Definition Audio Controller
> >>> 228e        GA106 High Definition Audio Controller
> >>>
> >>> Cc: Abhishek Sahu<abhsahu@nvidia.com>
> >>> Cc: Tarun Gupta<targupta@nvidia.com>
> >>> Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
> >>> Reported-by: Zhiyi Guo<zhguo@redhat.com>
> >>> Signed-off-by: Alex Williamson<alex.williamson@redhat.com>
> >>> ---
> >>>   drivers/pci/quirks.c |   13 +++++++++++++
> >>>   1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>> index 44cab813bf95..f4e2a88729fd 100644
> >>> --- a/drivers/pci/quirks.c
> >>> +++ b/drivers/pci/quirks.c
> >>> @@ -1939,6 +1939,19 @@ static void quirk_radeon_pm(struct pci_dev *dev)
> >>>   }
> >>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
> >>>
> >>> +/*
> >>> + * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
> >>> + * reset is performed too soon after transition to D0, extend d3hot_delay
> >>> + * to previous effective default for all NVIDIA HDA controllers.
> >>> + */
> >>> +static void quirk_nvidia_hda_pm(struct pci_dev *dev)
> >>> +{
> >>> +   quirk_d3hot_delay(dev, 20);
> >>> +}
> >>> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> >>> +                         PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
> >>> +                         quirk_nvidia_hda_pm);
> >>> +
> >>>   /*
> >>>    * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
> >>>    *https://bugzilla.kernel.org/show_bug.cgi?id=205587
> >>>
> >>>  

