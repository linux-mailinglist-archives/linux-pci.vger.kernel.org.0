Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551D654D06
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 08:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWHx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 02:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLWHxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 02:53:25 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BE25EA8;
        Thu, 22 Dec 2022 23:53:23 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so4274052pjj.4;
        Thu, 22 Dec 2022 23:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81VexVpAcjDCmAALpz8wgfQD8TVd/Z+mY8NAO8iTqkc=;
        b=Uaqy+bNcd5CMmbUBcBEonf0UGpk+EQzQbSF6Lliq7VhoKMU9Cnoi22+vTnhfTa+r+0
         StnBWpHJLV0NZVgx2Mm5EjGbPz/ee5p9PJ9dLtvrsmtwesbTifLHI8VkHkmqSOwrqgCf
         bSuZaGMYIeh/4Uq8iq6sqmgAFYK4uMZZ8U/gTlFDhEM36azjk+mAQBt/BuzCQUMwhumf
         xIud18l2zBDwyhPEYlu/bgVWxl5aWx94QWNR+Onkv3unstg4boqP5XcMMox1atgbMY1T
         jz88fBXviwoAp7HQP67zEv8u/1yOoqSVDMxSvdbnjo/wE2jHstjOOx6eebEi9SljF2up
         8OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81VexVpAcjDCmAALpz8wgfQD8TVd/Z+mY8NAO8iTqkc=;
        b=dU5bryhZLQAgd7zjNxpCqkLa4ZVx6Waz8PSmF0m9H2UnxJpVM558/UkhFJ/VTYJ/Ho
         MVq3wO7Iwg1fEnvLZvP+KJKySANMUc8U1/YYS3jfP081dJGzXkiR44jjpkW4QITLVHnP
         vYJ9hLLeiEax3kwRrGRiUWXsGfD//Ok5C8U5K7msHuounJAn/HAkVxtsDRyj63FCz6i0
         k/dAv624q0dVx09M7Zr/O4AbWtieO61epx1p3m8TiN+0sZ5uLaheE5sN8YqS8ADvEGnv
         rO3aOuOxJK7Wk1GCKwoFcsx5Ky6P9/MzNH8srtErVRFDHUM0QxH7lgLtCaCkVAZQ1f5L
         9KqQ==
X-Gm-Message-State: AFqh2ko2ysg5HgzcD2xx31EdGKpf5R8RDZAYPKXU6kHYXzfZElrrgjHx
        ONTyRTHRuxjRzfi8clo2Jn+WHiFLzTEznhvHw+w=
X-Google-Smtp-Source: AMrXdXtPvT1liLOEruABbZPWJ9MTLWvWBEZ8I92R6qsb9K+9qIVyeT2MJtO6bZTqJxrNWkCWVshG+Zotohtv4ajLmAs=
X-Received: by 2002:a17:903:2685:b0:182:6c84:7ff4 with SMTP id
 jf5-20020a170903268500b001826c847ff4mr435464plb.25.1671782003527; Thu, 22 Dec
 2022 23:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com> <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
In-Reply-To: <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Fri, 23 Dec 2022 15:53:12 +0800
Message-ID: <CAEm4hYUeigWxcDVGpg05P-5Qkh=6bArmtPqVqxR6Yw4wod3WBA@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     nirmal.patel@linux.intel.com, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Derrick <jonathan.derrick@linux.dev> =E4=BA=8E2022=E5=B9=B412=E6=
=9C=8822=E6=97=A5=E5=91=A8=E5=9B=9B 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 12/22/22 12:26 AM, korantwork@gmail.com wrote:
> > From: Xinghui Li <korantli@tencent.com>
> >
> > Commit ee81ee84f873("PCI: vmd: Disable MSI-X remapping when possible")
> > disable the vmd MSI-X remapping for optimizing pci performance.However,
> > this feature severely negatively optimized performance in multi-disk
> > situations.
> >
> > In FIO 4K random test, we test 1 disk in the 1 CPU
> >
> > when disable MSI-X remapping:
> > read: IOPS=3D1183k, BW=3D4622MiB/s (4847MB/s)(1354GiB/300001msec)
> > READ: bw=3D4622MiB/s (4847MB/s), 4622MiB/s-4622MiB/s (4847MB/s-4847MB/s=
),
> > io=3D1354GiB (1454GB), run=3D300001-300001msec
> >
> > When not disable MSI-X remapping:
> > read: IOPS=3D1171k, BW=3D4572MiB/s (4795MB/s)(1340GiB/300001msec)
> > READ: bw=3D4572MiB/s (4795MB/s), 4572MiB/s-4572MiB/s (4795MB/s-4795MB/s=
),
> > io=3D1340GiB (1438GB), run=3D300001-300001msec
> >
> > However, the bypass mode could increase the interrupts costs in CPU.
> > We test 12 disks in the 6 CPU,
> Well the bypass mode was made to improve performance where you have >4
> drives so this is pretty surprising. With bypass mode disabled, VMD will
> intercept and forward interrupts, increasing costs.

We also find the more drives we tested, the more severe the
performance degradation.
When we tested 8 drives in 6 CPU, there is about 30% drop.

> I think Nirmal would want to to understand if there's some other factor
> going on here.

I also agree with this. The tested server is None io-scheduler.
We tested the same server. Tested drives are Samsung Gen-4 nvme.
Is there anything else you worried effecting test results?
