Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F193629C6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbhDPU6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbhDPU6b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:58:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2DBC061574;
        Fri, 16 Apr 2021 13:58:06 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o5so30335179qkb.0;
        Fri, 16 Apr 2021 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=qnIWecU4j0go3BHki/tPX89ICgmbfzbrXzKLY+iWOac=;
        b=pz/bSOQmz9g+p6n0hHD1XQp4RAoq2j/Dj0uYmko1vHfn5u7RxBa80ABt2yiEG25v68
         haJilWm4NQoEiFZmf6ZCbgXgD0WEvFImh7UxgbDrysgLT0RyxcXbeAQsfenuXFUhxMZ0
         kqgYHnrvKY1kb9ACeLaIhxNJTlueR0VDBoK5nyTA7AWNFEcOVXwKX/bhRfyDzO5BDxYu
         iyyzTYTkUbhk8xG+XjJB0unQDDTTmiCESPhkYjks9+OV4j3FvRjcw8FUhL+gaUffJ1XI
         Ix5RU/RXzOdSgrB+BelgyWuXjivn2djucxlh6gW5fRKzGgkoysyHferoLsZxEue8M1RI
         O/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=qnIWecU4j0go3BHki/tPX89ICgmbfzbrXzKLY+iWOac=;
        b=m589olun8jgQ7LV6pwltR65I4dYsSpTih87CCIIid0ogIa0FvJHrzFEARdA2J/VFYq
         m+qvf7HETq77/z8P0jObY0Mkwr9OszSL4Vpzfwi8anDSHG8jfxHyGOE1ofsKVoKVPdR2
         JpfMDxTBpRPJQSQPq1IAVbWfyaxK5/nr8npWQ3ikDuhRi+jTqy4bN+Wz0QvuD65EgBNT
         8ykPf0e2udle4InyL3iPYJVwwPB/yNx6D0i/8keL7CY17r0Q90KBoiHoMri21zkPk+8A
         n1xRQIrR219fejD9GQTVLqCeJqHNfZ2tRJc+VBvCZPQTBkMs/sXVONJqWeuOMsIFSpCX
         UgwQ==
X-Gm-Message-State: AOAM530Lebemi5nzWTma+PcqkqIQpnzStr46S4LDhoGmlVW+0nEh3XzK
        CtiZZu6XFnpHgucPPwS0nHz7r14K1m4=
X-Google-Smtp-Source: ABdhPJxFhinlHNn02trTin40jfBumlNTfk5ie7OrDNyXW4/JI/YC1pS+0OjO1mDC9iZf7UePRpjcKg==
X-Received: by 2002:a37:d4e:: with SMTP id 75mr1110422qkn.457.1618606685688;
        Fri, 16 Apr 2021 13:58:05 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id n15sm4860020qkk.109.2021.04.16.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:58:05 -0700 (PDT)
Message-ID: <7b089cd48b90f2445c7cb80da1ce8638607c46fc.camel@gmail.com>
Subject: Re: [PATCH 1/1] of/pci: Add IORESOURCE_MEM_64 to resource flags for
 64-bit memory addresses
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Fri, 16 Apr 2021 17:57:59 -0300
In-Reply-To: <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
References: <20210415180050.373791-1-leobras.c@gmail.com>
         <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rob, thanks for this feedback!

On Thu, 2021-04-15 at 13:59 -0500, Rob Herring wrote:
> +PPC and PCI lists
> 
> On Thu, Apr 15, 2021 at 1:01 PM Leonardo Bras <leobras.c@gmail.com> wrote:
> > 
> > Many other resource flag parsers already add this flag when the input
> > has bits 24 & 25 set, so update this one to do the same.
> 
> Many others? Looks like sparc and powerpc to me. 
> 

s390 also does that, but it look like it comes from a device-tree.

> Those would be the
> ones I worry about breaking. Sparc doesn't use of/address.c so it's
> fine. Powerpc version of the flags code was only fixed in 2019, so I
> don't think powerpc will care either.

In powerpc I reach this function with this stack, while configuring a
virtio-net device for a qemu/KVM pseries guest:

pci_process_bridge_OF_ranges+0xac/0x2d4
pSeries_discover_phbs+0xc4/0x158
discover_phbs+0x40/0x60
do_one_initcall+0x60/0x2d0
kernel_init_freeable+0x308/0x3a8
kernel_init+0x2c/0x168
ret_from_kernel_thread+0x5c/0x70

For this, both MMIO32 and MMIO64 resources will have flags 0x200.

> 
> I noticed both sparc and powerpc set PCI_BASE_ADDRESS_MEM_TYPE_64 in
> the flags. AFAICT, that's not set anywhere outside of arch code. So
> never for riscv, arm and arm64 at least. That leads me to
> pci_std_update_resource() which is where the PCI code sets BARs and
> just copies the flags in PCI_BASE_ADDRESS_MEM_MASK ignoring
> IORESOURCE_* flags. So it seems like 64-bit is still not handled and
> neither is prefetch.
> 

I am not sure if you mean here:
a) it's ok to add IORESOURCE_MEM_64 here, because it does not affect
anything else, or
b) it should be using PCI_BASE_ADDRESS_MEM_TYPE_64 
(or IORESOURCE_MEM_64 | PCI_BASE_ADDRESS_MEM_TYPE_64) instead, since
it's how it's added in powerpc/sparc, and else there is no point.

Again, thanks for helping!

Best regards,
Leonardo Bras

