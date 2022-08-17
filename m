Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3838597062
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiHQODb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbiHQOCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C669A96B
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660744929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pt7BDtIMM3FtA0HcC2AXZKv8xyOB8ntdc2I9DoZlSjw=;
        b=AdEI9OBO/6uGI5xVE/bJHMQ8Vcp3+ss0UAhjGEFSbjchkDcLeI/BSZANGp2dVWxe2X2t78
        AlEeEG+RH1IxjNAro1499lAg1KzamMSrJXWg8FtUBwpjsRp3zOUITG03q8sS0rR+sfOgz6
        1MhSrVZsocVYs1q1IG6FKndk2b/mDUk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-0tCQ_98dNKWzbFOV5zt3jQ-1; Wed, 17 Aug 2022 10:02:07 -0400
X-MC-Unique: 0tCQ_98dNKWzbFOV5zt3jQ-1
Received: by mail-io1-f69.google.com with SMTP id z30-20020a05660217de00b00688bd42dc1dso2611393iox.15
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 07:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=Pt7BDtIMM3FtA0HcC2AXZKv8xyOB8ntdc2I9DoZlSjw=;
        b=7tgBT9LK1s+V88Qfi3PQ57BcP4+4NdqyF0hGropp2HnH0vSNNxbrmjAj7FV6bYohNC
         eKsmH1U2wBqqWKmsIf7csIVB5KSe1BbFpIwTvEQc8ku96UE/DWBCujixuZ4HSZbTPTzs
         FtZ1yEnbmg2wxqM7JxaTwzTkSE5r5Ilq5MKx6tzFS8aG2s6gQ3r/60pKBcvU4KP5CATd
         jsUwTlOIOVDHFrjfGC6z5+jpHF1tkXWEnPhDLL90SBoDKHu0jKbRVu7N3zwuZIspvxfD
         X9+c6cR08BXtgkbyb4kGHTWKWkQzT6/Fo0vsKaRQH3P3ZOfBTXzDsvQOT47TKr+f7jGz
         ntxA==
X-Gm-Message-State: ACgBeo3YeJy6RbH3pTVKsnnMNIlL79cadY6VGvm3EZc3RRy5/znPClbm
        Ij3I+ajM2k/R1GioEQcJSqzapDd4nWzTs7ke77wkYaUwzLTNHgAphWhmeWOXqrK/lXStD3BR0HT
        7C7dfrLONELOGrozcdvMd
X-Received: by 2002:a05:6602:14c2:b0:67d:ae1:1c23 with SMTP id b2-20020a05660214c200b0067d0ae11c23mr10996733iow.212.1660744924806;
        Wed, 17 Aug 2022 07:02:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bGd0JIkKE6JDPsmRO7YZrbm3YU8lrNbz8b/j2FgnreXtiopIU1h0WEkWjStJNGqcDXUPU0Q==
X-Received: by 2002:a05:6602:14c2:b0:67d:ae1:1c23 with SMTP id b2-20020a05660214c200b0067d0ae11c23mr10996720iow.212.1660744924533;
        Wed, 17 Aug 2022 07:02:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s10-20020a056602168a00b00684690536d7sm7676106iow.35.2022.08.17.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:02:04 -0700 (PDT)
Date:   Wed, 17 Aug 2022 08:02:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Expose resource resizing through sysfs
Message-ID: <20220817080202.1a0c29cf.alex.williamson@redhat.com>
In-Reply-To: <a15fe381-1f41-2c92-2ef1-0b4eb30a5142@amd.com>
References: <166067824399.1885802.12557332818208187324.stgit@omen>
        <a15fe381-1f41-2c92-2ef1-0b4eb30a5142@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Aug 2022 12:10:44 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 16.08.22 um 21:39 schrieb Alex Williamson:
> > We have a couple graphics drivers making use of PCIe Resizable BARs
> > now, but I've been trying to figure out how we can make use of such
> > features for devices assigned to a VM.  This is a proposal for a
> > rather basic interface in sysfs such that we have the ability to
> > pre-enable larger BARs before we bind devices to vfio-pci and
> > attach them to a VM. =20
>=20
> Ah, yes please.
>=20
> I was considering doing this myself just for testing while adding the=20
> rebar support for the GFX drivers, but then just implementing it on the=20
> GFX side was simpler.
>=20
> I would just add a warning that resizing BARs can easily crash the=20
> system even when no driver directly claimed the resource or PCIe device.
>=20
> It literally took me weeks to figure out that I need to kick out the EFI=
=20
> framebuffer driver before trying to resize the BAR or otherwise I just=20
> get a hung system.

Good point, I think maybe we can avoid crashing the system though if we
use the new aperture support to remove conflicting drivers from all VGA
class devices, similar to d17378062079 ("vfio/pci: Remove console
drivers").  A note in the ABI documentation about removing console
drivers from the device when resizing resources would definitely be in
order.

> > Along the way I found a double-free in the error path of creating
> > resource attributes, that can certainly be pulled separately (1/).
> >
> > I'm using an RTX6000 for testing, which unexpectedly only supports
> > REBAR with smaller than default sizes, which led me to question
> > why we have such heavy requirements for shrinking resources (2/). =20
>=20
> Oh, that's easy. You got tons of ARM boards with less than 512MiB of=20
> address space per root PCIe complex.
>=20
> If you want to get a GPU working on those you need to decrease the
> BAR size or otherwise you won't be able to fit 256MiB VRAM BAR +
> register BAR into the same hole for the PCIe root complex.
>=20
> An alternative explanation is that at least AMD produced some boards=20
> with a messed up resize configuration word. But on those you only got=20
> 256MiB, 512MiB and 1GiB potential BAR sizes IIRC.

An aspect of shrinking BARs that maybe I'm not giving enough
consideration to is that we might be shrinking a BAR on one device in
order to release MMIO space from a bridge aperture, that we might then
use to expand a BAR elsewhere.  The RTX6000 case only frees a rather
modest amount of MMIO space, but I could imagine more substantial
configurations.  Maybe this justifies resizing the bridge aperture even
in the shrinking case?

> Anyway, with an appropriate warning added to the sysfs documentation
> the patch #2 and #3 are Acked-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>

Thanks!

Alex

