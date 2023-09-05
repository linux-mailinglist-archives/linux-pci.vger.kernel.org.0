Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93013792D86
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 20:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjIESop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjIESon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 14:44:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDACE4
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 11:44:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5009d4a4897so4847242e87.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Sep 2023 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1693939397; x=1694544197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfYnmYbnlw/oOdEXRRJF1VOqzdakA8jCVvd4ZjMv2EM=;
        b=GzKoQODVSeqGzroH0R1N7OloJKzQwEniXzrD/hXT0oqdibIWZ75b8VdmnCqNO8KR93
         xLUL/hHqpKMWxjvpvsNSGKiXt8UujcAtzZ6TsiRLNdA13iXN44NAHGajbo4lR3i65IIk
         kYklsGMyNV6sAngXgTJbM6FBAJsVyfgTOsx7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693939397; x=1694544197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfYnmYbnlw/oOdEXRRJF1VOqzdakA8jCVvd4ZjMv2EM=;
        b=MZnCx7AAgH0bQmUAoVCOm5sIW0VYvbALhvtoHRxCV0uwYM+igB6jHkEim+NXzXXNkE
         XEOcSFpxoi4UTb5Qv37nFTxKYXm6lrfrLitytdbdIF7Y+Tbq9TjyBve+shpD2jBw6y2C
         HtSnvdQNqKIBBbUXkvSasJCJ66OHEobTIBKfW6fIXAUcPwVyaQKv3prlLcZlpl2/ZnRg
         lqlWZVTnkEpjtnrVJK/BZMuzi7/oaWB4xyI4Mb1ghXuUqtGSs471q4IzWGxXIE25MDxF
         /uclKexk1i4YPJXpqNjzby9ctI7XTbX5rxZHp/CvZWHtXf7eT/FmMO/Vrry5oBwmFpea
         NANg==
X-Gm-Message-State: AOJu0YweeN09xbLBvVXh7U/x8jbfhFoptkONtTpnSnv2LMSoBKIBpoTd
        Ux0WifeKm4oFrrU9eVIS3ncprg26toBt7/BnPsjRj4zzL0ri6maamA==
X-Google-Smtp-Source: AGHT+IHRpYJwtBkvQItpDOzpsoiC8Dj7/UWfHFdTNS2CIKeWgrIXNYkWJnDsvCEq1d6lrwFV0p0pXAjnk5zgzKOzDrQ=
X-Received: by 2002:ac2:5925:0:b0:500:b828:7a04 with SMTP id
 v5-20020ac25925000000b00500b8287a04mr259335lfi.18.1693931329871; Tue, 05 Sep
 2023 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <878r9sga1t.fsf@kernel.org>
In-Reply-To: <878r9sga1t.fsf@kernel.org>
From:   Ross Lagerwall <ross.lagerwall@cloud.com>
Date:   Tue, 5 Sep 2023 17:28:38 +0100
Message-ID: <CAG7k0Epk6KJvoDJKVc86sc_ems3DTbKvPLouBzOoVvn1tZwQ=w@mail.gmail.com>
Subject: Re: [regression v6.5-rc1] PCI: comm "swapper/0" leaking memory
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 30, 2023 at 10:21=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
> [CAUTION - EXTERNAL EMAIL] DO NOT reply, click links, or open attachments=
 unless you have verified the sender and know the content is safe.
>
> Hi,
>
> I noticed that starting from v6.5-rc1 my ath11k tests reported several
> memory leaks from swapper/0:
>
> unreferenced object 0xffff88810a02b7a8 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     80 b8 02 0a 81 88 ff ff b8 72 07 00 00 c9 ff ff  .........r......
>     c8 b7 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
> unreferenced object 0xffff88810a02b880 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     58 b9 02 0a 81 88 ff ff a8 b7 02 0a 81 88 ff ff  X...............
>     a0 b8 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
> unreferenced object 0xffff88810a02b958 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     30 ba 02 0a 81 88 ff ff 80 b8 02 0a 81 88 ff ff  0...............
>     78 b9 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  x...............
>   backtrace:
> unreferenced object 0xffff88810a02ba30 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     08 bb 02 0a 81 88 ff ff 58 b9 02 0a 81 88 ff ff  ........X.......
>     50 ba 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  P...............
>   backtrace:
> unreferenced object 0xffff88810a02bb08 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     e0 bb 02 0a 81 88 ff ff 30 ba 02 0a 81 88 ff ff  ........0.......
>     28 bb 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  (...............
>   backtrace:
>
> I can easily reproduce this by doing a simple insmod and rmmod of ath11k
> and it's dependencies (mac80211, MHI etc). I can reliability reproduce
> the leaks but I only see them once after a boot, I need to reboot the
> host to see the leaks again. v6.4 has no leaks.
>
> I did a bisect and found the commit below. I verified reverting the
> commit makes the leaks go away.
>
> commit e54223275ba1bc6f704a6bab015fcd2ae4f72572
> Author:     Ross Lagerwall <ross.lagerwall@citrix.com>
> AuthorDate: Thu May 25 16:32:48 2023 +0100
> Commit:     Bjorn Helgaas <bhelgaas@google.com>
> CommitDate: Fri Jun 9 15:06:16 2023 -0500
>
>     PCI: Release resource invalidated by coalescing
>
> Kalle
>

Hi Kalle,

I can't reproduce the leak by loading/unloading the ath11k module. I suspec=
t
that the leak is always there when PCI resources are coalesced but
kmemleak doesn't notice until ath11k is loaded.

Can you please try the following to confirm it fixes it?

Ross

8<-----------------------

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8bac3ce02609..907c873473e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -998,6 +998,7 @@ static int pci_register_host_bridge(struct
pci_host_bridge *bridge)
         res =3D window->res;
         if (!res->flags && !res->start && !res->end) {
             release_resource(res);
+            resource_list_destroy_entry(window);
             continue;
         }
