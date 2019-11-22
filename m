Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF388107163
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKVLbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:31:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28266 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbfKVLbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 06:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574422266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fk7+9wRBOnitbINGrkgws0BRV6i2F3wIBf4jxMH1Ew8=;
        b=NaDvEDEpL0bB1tol1YWLahh8y0V0XZZnFPlwlLhwpUNjSOReaH2FX2NeYjuqF2wMpQkz54
        3GuglkNHUwvlUN/k/wDdBz3iDFfiUUXn1Ck2Zyd5dzdZeGcIZIxykL8zpXKE3bmz93yBL5
        zkbuyJOzd4lac4nBkwnTrzP/LnCKlpY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-YA9X_Hj9MyqbT6CKm4SAeQ-1; Fri, 22 Nov 2019 06:31:04 -0500
Received: by mail-qv1-f72.google.com with SMTP id w7so4465472qvs.15
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 03:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aur9rsWegbHLh3oY6ky2CGYiseXs+N84XUMnQYfdl6g=;
        b=bWg8TZ+1DReHHIxc7FstzMgvB4+peS335GD9jkTfINfwSxJ3pJOeqw/Bnk3NulmPKp
         nPs5n9VMZAMXT+CwTMZHKmqd7/ssmlx+MVrT/ukuNvy0K62+gbocnQ6mrFA8O9rWJO9G
         3ghto0kojy+CBcBQXGnLNIxKY5Il6xK+8BkDNBrihWG3qkx4Cod1rJBR3s8w+7rIhuST
         PwEEyGgK1Fjp35Kb/iu8rKpT4n5eHoyfw6xWYdwPG/nmm3RaFbZVlfg75OEnFjhjkA8f
         yBHShtw0gkqcX7sltlrmRP9/MnvXhuN5ABMTLOZOi3t58sT8w/g4QkPYCxauuRTJt55d
         CyKQ==
X-Gm-Message-State: APjAAAV0ifozDRxYipNtNeKdi1cuD89rhf3202EpZk2qZGxLGHbTtZXy
        /xMsbU4IyyB2qgNpUMKRYzh309ZrVSvAU+KYGDspUPomhLcava02Bxv6YQfg38Ka81nmfXJdusk
        C+uvtXK1+zKgxBnlOW2KzPly13VMSENwCUWgP
X-Received: by 2002:ac8:5557:: with SMTP id o23mr13894113qtr.378.1574422264298;
        Fri, 22 Nov 2019 03:31:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4tUnanEcz7OF5qm09oSIPeTrgesqROQcAYMdb3VQX3IrvgvC0XjOQgTAq+ByslNwLSUis/BX58JFkAfiwgdw=
X-Received: by 2002:ac8:5557:: with SMTP id o23mr13894072qtr.378.1574422264060;
 Fri, 22 Nov 2019 03:31:04 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <CACO55tvFeTFo3gGdL02gnWMMk+AHPPb=hntkre0ZcA6WvKcV1A@mail.gmail.com>
 <CACO55tvkQyYYnCs71_nJuNFm4f8kkvBqje8WeZGph7X+2zO3aA@mail.gmail.com> <CAJZ5v0jNq77xPXxeYeq_JJBCfekVPVPOye1mZwpQi=+=MKSS7w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jNq77xPXxeYeq_JJBCfekVPVPOye1mZwpQi=+=MKSS7w@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 22 Nov 2019 12:30:52 +0100
Message-ID: <CACO55tue979AjxXO0MsOMVzUYvVaLh3rMDVg43=kqz=-OpW3Jw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: YA9X_Hj9MyqbT6CKm4SAeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 10:07 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Fri, Nov 22, 2019 at 1:13 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > so while trying to test with d3cold disabled, I noticed that I run
> > into the exact same error.
>
> Does this mean that you disabled d3cold on the GPU via sysfs (the
> "d3cold_allowed" attribute was 0) and the original problem still
> occurred in that configuration?
>

yes. In my previous testing I was poking into the PCI registers of the
bridge controller and the GPU directly and that never caused any
issues as long as I limited it to putting the devices into D3hot.

> > And I verified that the
> > \_SB.PCI0.PEG0.PG00._STA returns 1, which indicates it should still be
> > turned on.
>
> I don't really understand this comment, so can you explain it a bit to
> me, please?
>

that's the ACPI method to fetch the "status" of the power resource, it
should return 0 when the device was powered off (the GPU) and 1
otherwise.

