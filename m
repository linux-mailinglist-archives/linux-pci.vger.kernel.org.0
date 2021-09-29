Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1241CCAF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbhI2TgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 15:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhI2TgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 15:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632944082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxuKdylI4Kc+hb/mDh3ZB4LmRsjDB8aW0nScGqqBiwE=;
        b=SmnLKtHnBDTSxoBeZkTQJ3805ReYXO7b8ByzXa5STldBntmYoJFxTmq++sHPpulAKK4L1q
        BjQPhpQrHSsaUAjgSHH88Xx+EOFoKDYvNR0vExYzeti5EciBIo4p3PDREYYMx9Wht8g5DF
        ErSPAeJa+7DyyYO6khn+gTz7tMSgIQA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-ophZJmE3MJOWCyAnY29zzQ-1; Wed, 29 Sep 2021 15:34:41 -0400
X-MC-Unique: ophZJmE3MJOWCyAnY29zzQ-1
Received: by mail-ot1-f71.google.com with SMTP id x27-20020a9d705b000000b005470c0ed087so2611489otj.10
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 12:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxuKdylI4Kc+hb/mDh3ZB4LmRsjDB8aW0nScGqqBiwE=;
        b=Tutmpx4EeTXjpvHStLfOSJEh3YPqkX/YPiTHq17Dkz1Zjq1qZ+Vy/1cr9Roja3xskh
         u4csCizkm4NbvPQJpGZT26SblDpSgDnOcAiDcr1VLzUfxUzX1XkYW52FkFJ0eVX8E6Ha
         sFOnaRpr/6PKI8SskI9ASbpZw4QX4ogVtA6VULbB+htReshXYdzGSGQzueckO5F5HcSx
         TqcKuufD6MHxKOsTHoFc0IW2lWrUA6aCihNApH2eFQ6/1wEDhxt2CvhCA79e5Ul1mLcC
         aKTVT57nMblp0M+U15OzDwSWq4z9XB8+evS/SrorJ2Nc0u8fUBhvfYsaBrGvRGRJUT7y
         848g==
X-Gm-Message-State: AOAM533PGd1viElOc042O//E2bDOtZNgx5XR3na5rXyxQ6u7bym1dvt1
        a4vppIpfBmGCVIRBNgiCv59aSeNeb9xHtaqq7yHQY62W4o8dIS9zYzn0jMBn9+XmXX+CojTuK+b
        Ibmmxi7IV7MrlSGVx/E5z
X-Received: by 2002:a54:4f15:: with SMTP id e21mr1327257oiy.71.1632944080746;
        Wed, 29 Sep 2021 12:34:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkMfOfplEiFRrC+MUxJdC9lr9zsjxMgYm4tI6Dzp81jPpCnh5uO2gG2SFpLOe9/KNIEL2Y4Q==
X-Received: by 2002:a54:4f15:: with SMTP id e21mr1327237oiy.71.1632944080429;
        Wed, 29 Sep 2021 12:34:40 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id d68sm125797otb.55.2021.09.29.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:34:38 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:34:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Jaundrew <david@jaundrew.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Message-ID: <20210929133437.36d0a892.alex.williamson@redhat.com>
In-Reply-To: <20210929185029.GA790241@bhelgaas>
References: <20210929122612.02e54434.alex.williamson@redhat.com>
        <20210929185029.GA790241@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 Sep 2021 13:50:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Sep 29, 2021 at 12:26:12PM -0600, Alex Williamson wrote:
> > On Tue, 28 Sep 2021 20:59:02 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > [+cc Alex, Krzysztof, AMD folks]
> > > 
> > > On Tue, Sep 28, 2021 at 05:16:49PM -0700, David Jaundrew wrote:  
> > > > This patch fixes another FLR bug for the Starship/Matisse controller:
> > > > 
> > > > AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> > > > 
> > > > This patch allows functions on the same Starship/Matisse device (such as
> > > > USB controller,sound card) to properly pass through to a guest OS using
> > > > vfio-pc. Without this patch, the virtual machine does not boot and
> > > > eventually times out.    
> > > 
> > > Apparently yet another AMD device that advertises FLR support, but it
> > > doesn't work?
> > > 
> > > I don't have a problem avoiding the FLR, but I *would* like some
> > > indication that:
> > > 
> > >   - This is a known erratum and AMD has some plan to fix this in
> > >     future devices so we don't have to trip over them all
> > >     individually, and
> > > 
> > >   - This is not a security issue.  Part of the reason VFIO resets
> > >     pass-through devices is to avoid leaking state from one guest to
> > >     another.  If reset doesn't work, that makes me wonder, especially
> > >     since this is a cryptographic coprocessor that sounds like it
> > >     might be full of secrets.  So I *assume* VFIO will use a different
> > >     type of reset instead of FLR, but I'm just double-checking.  
> > 
> > It depends on what's available, chances are not good that we have
> > another means of function level reset, so this probably means it's
> > exposed as-is.  I agree, not great for a device managing something to
> > do with cryptography.  It's potentially a better security measure to
> > let the device wedge itself.  Thanks,  
> 
> OK, I think that means I need to ignore this patch until we have some
> evidence that it's actually safe to allow VFIO to pass the device
> through to another guest.
> 
> And I guess we are making the assumption that the audio, USB, and
> ethernet controllers [1] are safe to hand off between guests?  I don't
> know enough about those controllers to even have an opinion about
> that.  Surely there is config space and MMIO space that could leak
> data between guests?

The expectation is that there's a lot less potential for such devices.
If we were to try to restrict assignment to absolutely secure devices
we'd probably rule out anything that's not a VF and then start
excluding things from there.  Even with proper resets, there's a
potential that a user could muck with non-volatile device state (ex.
option ROMs).
 
> Is there anything that tracks whether the device has been reset after
> being passed through to a guest?  For example, I assume the following
> would be safe if we could tell the reset had been done:
> 
>   - Pass through to guest A
>   - Guest A exits
>   - User resets all devices on bus (including this one)
>   - Pass through to guest B

Yes, we do track whether a device has been reset, but rather by the
kernel more so than userspace as the latter might just invite userspace
to exploit an mmap post-reset in order to insert a payload.

Our tracking is more for the purpose of trying to do a bus reset once
all of the devices affected are released from userspace.  For example
if the multi-function set includes this crypto device, the usb
controller, and audio controller, once the user releases the last of
those, if any of them still require a reset we'd perform a bus reset.
However, if these devices are actually in separate IOMMU groups (reset
scope is not accounted for in grouping), then the user could release the
crypto device and it could be re-assigned to a new user and we never
get a chance to reset the bus.  I don't know what grouping looks like
among these devices.  Thanks,

Alex

