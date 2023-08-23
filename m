Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106197852A4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjHWIZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjHWIWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 04:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AD610E5
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692778882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2oaSMHcvqCziX2gO1IwQweHiiwucxeoyE3Pu01d/lk=;
        b=Tj5VXicRLZ3DzN3TMHALJ/aKynVfg2KX3O0TZHhW087EbAHpyb0VKlcuagXuaHad9HJGHr
        QGEM1dK8GxsVns1yF5lq5I0W5M+297+FMQoq2YnuGvjvzwMdMVKOshVWWZmhaJnmPigIsv
        l8yQwPixHYTq/h8TLO9a4ouyBSpP80A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-MMK6eiWaNCy2nGMwaQ81gw-1; Wed, 23 Aug 2023 04:21:21 -0400
X-MC-Unique: MMK6eiWaNCy2nGMwaQ81gw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b752bc74fso5744551a91.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 01:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778879; x=1693383679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2oaSMHcvqCziX2gO1IwQweHiiwucxeoyE3Pu01d/lk=;
        b=P4Q03BLpztGwU4MPycR5EKwK8va2L6ElqPn/TpVc3oRP6DdXClCUkpaYUnOTPLfawT
         uhHoyI9dCWOUKAOEccptqI90YM4y8HcP1OzPKgawiGQ+QGWniHR0zHYCJ5IalgwKUkUC
         +v7ZHnAfwMEAOkGByhoErzKGg74WyvqAR2aWnb0Tnr7RPxRgi/q0aEG40UDTrQ2LMhFA
         GkcTOT7SUV2psIPdELloZcCPyGrFx5OcIZamU7V9MHs43Txo8VRzzcFBnKJ+jcX94jyZ
         59Axh7IWb2iYFXmpMGg3+0WT3lY4QlJGfnjRk5g6phRXvAPZQQ2SVsnoeeOSrMtw3qXE
         tV4Q==
X-Gm-Message-State: AOJu0YyEZaln91TmV6+juzKt9aRLoyypEoar2QH7WDg8b7xPkHhXjIrv
        tsBje339D5o6pUjHDwCQuVA+cCfEmmbX4V98+EyAmvj7gFoef0Ohw/0XTp1Ni6dsRVDJ0mDARaG
        CuNLD7qjsiUBnKjWCZiRKf6B+yrnOsCbNXSBJYKKep/RWZA==
X-Received: by 2002:a17:90b:396:b0:26b:49de:13bd with SMTP id ga22-20020a17090b039600b0026b49de13bdmr8555265pjb.36.1692778879355;
        Wed, 23 Aug 2023 01:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2AOpuxpUJRRzJJlV3nnAX5OBFVvXSzcpjdc536DBn27Tjre2yixkzE6HTRX8vc8jIbWNoRGGfw9Pz4M+wnyA=
X-Received: by 2002:a17:90b:396:b0:26b:49de:13bd with SMTP id
 ga22-20020a17090b039600b0026b49de13bdmr8555256pjb.36.1692778879042; Wed, 23
 Aug 2023 01:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com> <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com> <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com> <20230823075649.GS3465@black.fi.intel.com>
In-Reply-To: <20230823075649.GS3465@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Wed, 23 Aug 2023 10:20:52 +0200
Message-ID: <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 9:56=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> So directly after resume the PCIe link (tunnel) from the Thunderbolt host=
 router
> PCIe downstream port does not get re-established and this brings down
> the whole device hierarchy behind that port. The delay just made it take
> longer but the actual problem is not the delay but why the tunnel is not
> re-established properly.

If you want to compare it to a "fast" resume (~5 sec, before commit
e8b908146d44), here's dmesg:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984726

Even when the resume is fast, it takes a few extra seconds before the
devices on the dock are usable in the OS. For example, my USB mouse
connected to the dock doesn't work immediately, I have to wait a few
more seconds. The ethernet on the dock also reconnects only after a
few extra seconds.

> Next question is that what's the Thunderbolt firmware version? You can
> check it throughs sysfs: /sys/bus/thunderbolt/devices/0-0/nvm_version

$ sudo cat /sys/bus/thunderbolt/devices/0-0/nvm_version
20.0

Here's whole `fwupdmgr get-devices` output, if that helps:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984728

Before reporting this bug, I updated the firmware on the Dock itself
to the latest version (had to use Windows for that). The dock should
have now this firmware:
https://pcsupport.lenovo.com/us/en/downloads/DS506176
Which is:
    Tool package V1.0.25
    TBT FW: C44
    PD FW: 1.38.07
    DP hub: 3.13.005
    Audio: 04-0E-87_Rev_0087
according to the Readme file. That seems to match the "44" version in
the fwupdmgr output.

> I
> see the BIOS you have seems to be quite recent (06/12/2023) so that
> probably should be good enough.

Lenovo seems to support it through LVFS, so that's what I use for
updating the BIOS. Version 0.1.54 was updated quite recently and it
seems to be also the latest version they have on their website.

