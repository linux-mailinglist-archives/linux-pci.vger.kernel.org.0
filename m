Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74393C938B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 00:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhGNWGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 18:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhGNWGq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 18:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626300233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTHL4lE41iJsGNnUDsff3tWx/J7qAPHT8cOY5J64apk=;
        b=F+WTWqRgd8HOn/jthYcAkWE70uWmFGgfzNZy7FAyXkvTkBRMDxe68aoWRlzhy1vOq85MtA
        cnfWH991WNAfOoAptI2Gf4o8Zs8n2GnjPXOBb12N+KwKALwz/BIlUo/WS4ilYTBmZA8YG8
        4y0flQy8nSkVDW4aXn15oQ9EQudxi30=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-tmM1z57gNMG5fPnBflLQEQ-1; Wed, 14 Jul 2021 18:03:52 -0400
X-MC-Unique: tmM1z57gNMG5fPnBflLQEQ-1
Received: by mail-oi1-f200.google.com with SMTP id w18-20020a0568080d52b029023e3c1124c9so2119316oik.11
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 15:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTHL4lE41iJsGNnUDsff3tWx/J7qAPHT8cOY5J64apk=;
        b=OGBnbz1VlcDu7NKIQCiWbRgGDJY3y0s0wGWb0jcttPk39vYRhl+S1II+Av4p/awYpa
         tkAPqZY6LnFGsht6Q+JNNlQDtUGyXBmRQiEGQLV5Ly8QUj7LWM+pjenJL7sE2zdxkSJc
         qnX2SYXaakL5K5WgxE4jRNuWOOxHTbQat3n966Ga5itbhbvkGPipUhmNRjQYIAgRhMXa
         7U2grPA5zO6u2svRY8GAcULUfcSZYkp5T5+ccix7p/xp66bMfFTmX335+9ZrDHaT4viX
         RSCQG1fzLENDUpV6VUW5qCIbis5ayVs1aom86SGqF0jD4Xb/sSCXT4TWNaEam9i3FGz0
         dHVQ==
X-Gm-Message-State: AOAM531LjM35VfDtgIEEi2mYEjx/yAwDqNehN5bO68xZ9Spy/A6bRCx+
        Nj2MwWgPhHddAuCqzpr7BMfq4vbbZcBgdhAJefcpWAJOzz34a/QPWePGZBkVWYxE2aavOc2r/Gj
        gTBocGQu0efQcFmuewY9l
X-Received: by 2002:a9d:4911:: with SMTP id e17mr299439otf.38.1626300231688;
        Wed, 14 Jul 2021 15:03:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSjlt9GkTAA2Ymwz5koOsl4nGPIsKs2GSmDw+pixEOFvBioi1LRpkqKwbSxWBG9mQGl/RYOg==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr299423otf.38.1626300231481;
        Wed, 14 Jul 2021 15:03:51 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id h15sm640414oov.41.2021.07.14.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:03:51 -0700 (PDT)
Date:   Wed, 14 Jul 2021 16:03:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ruben <rubenbryon@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [question]: BAR allocation failing
Message-ID: <20210714160350.1bef2778.alex.williamson@redhat.com>
In-Reply-To: <CALdZjm7v3WaaS_ispa20PkjUnLq1t1Zdr29wKw_rZkQYExK-3w@mail.gmail.com>
References: <CALdZjm7v3WaaS_ispa20PkjUnLq1t1Zdr29wKw_rZkQYExK-3w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Jul 2021 00:32:30 +0300
Ruben <rubenbryon@gmail.com> wrote:

> I am experiencing an issue with virtualizing a machine which contains
> 8 NVidia A100 80GB cards.
> As a bare metal host, the machine behaves as expected, the GPUs are
> connected to the host with a PLX chip PEX88096, which connects 2 GPUs
> to 16 lanes on the CPU (using the same NVidia HGX Delta baseboard).
> When passing through all GPUs and NVLink bridges to a VM, a problem
> arises in that the system can only initialize 4-5 of the 8 GPUs.
> 
> The dmesg log shows failed attempts for assiging BAR space to the GPUs
> that are not getting initialized.
> 
> Things that were tried:
> Q35-i440fx with and without UEFI
> Qemu 5.x, Qemu 6.0
> Host Ubuntu 20.04 host with Qemu/libvirt
> Now running proxmox 7 on debian 11, host kernel 5.11.22-2, VM kernel 5.4.0-77
> VM kernel parameters pci=nocrs pci=realloc=on/off
> 
> ------------------------------------
> 
> lspci -v:
> 01:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
>         Memory at db000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at 2000000000 (64-bit, prefetchable) [size=128G]
>         Memory at 1000000000 (64-bit, prefetchable) [size=32M]
> 
> 02:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
>         Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at 4000000000 (64-bit, prefetchable) [size=128G]
>         Memory at 6000000000 (64-bit, prefetchable) [size=32M]
> 
> ...
> 
> 0c:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
>         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at <ignored> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, prefetchable)
> 
> ...
> 
...
> 
> ------------------------------------
> 
> I have (blindly) messed with parameters like pref64-reserve for the
> pcie-root-port but to be frank I have little clue what I'm doing so my
> question would be suggestions on what I can try.
> This server will not be running an 8 GPU VM in production but I have a
> few days left to test before it goes to work. I was hoping to learn
> how to overcome this issue in the future.
> Please be aware that my knowledge regarding virtualization and the
> Linux kernel does not reach far.

Try playing with the QEMU "-global q35-host.pci-hole64-size=" option for
the VM rather than pci=nocrs.  The default 64-bit MMIO hole for
QEMU/q35 is only 32GB.  You might be looking at a value like 2048G to
support this setup, but could maybe get away with 1024G if there's room
in 32-bit space for the 3rd BAR.

Note that assigning bridges usually doesn't make a lot of sense and
NVLink is a proprietary black box, so we don't know how to virtualize
it or what the guest drivers will do with it, you're on your own there.
We generally recommend to use vGPUs for such cases so the host driver
can handle all the NVLink aspects for GPU peer-to-peer.  Thanks,

Alex

