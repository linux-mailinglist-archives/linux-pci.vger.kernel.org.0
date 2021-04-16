Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDC362A4D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 23:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbhDPV1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhDPV1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 17:27:35 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ABCC061574;
        Fri, 16 Apr 2021 14:27:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id gv2so4865925qvb.8;
        Fri, 16 Apr 2021 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=qnIWecU4j0go3BHki/tPX89ICgmbfzbrXzKLY+iWOac=;
        b=PhDBZAzo+OIHeHKPUkiWebd2RIRE8h8B3dLA1tcUMxGsYd1ao5o99BL9jDla3voE9Y
         GPrLd+bUmEtL5Yk6emTGq2QA+qjodIhVTE5gLa8+vGwH+nqQiXqR5PTrNRb7megwHdKn
         Wy9vXZS5Sm4Ta5Zkbx3QfxiAas3oyIsb/c1ikDetmr7ImtGSBYSrROdswWOEGxzN4OK/
         0tDo7I6b4S8YsPrY8Bq/+YVu2x7RMm/LIm/Y5NiS/zm5t/vCRaPTSryG0Re/JDsrjUbG
         RL8lzHi9gtqu2COx+wLHUWnLJ1pKupIZsi9gTJPZNhnIAMrKyEgcA3tHthGlMk2qXO2B
         YjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=qnIWecU4j0go3BHki/tPX89ICgmbfzbrXzKLY+iWOac=;
        b=D7t4FGUSdaCk1GUwEdmgslFVhjyMcfMqTM5ag/6YnPCWDHEsFqXyhhuodqD+fHi5mS
         8x+3Xz2s94Z+EEY1LYLJmUwA1AbYn7ESVAMTZyRVXbLWOGwAvOaT5uGUakxKZk5mnju7
         CIpEPw8Ia4H82ENvQukmYtdepoDfZ1NSW+MDEetDedgHw/v1NUnGnzw4ms74Erm1Z/Ct
         YeOknntbws/xoMG5f0gH46yTitEeXR475TRmsegNnHWWA/JMRq6NuVY+sqXQtNtU1m1d
         RdZplT9ddaDcu2IYC1ayG58R8DcQFllE42n6df/qriY7AS9+gy1OH8/mt7vlXyqkPjzR
         S97Q==
X-Gm-Message-State: AOAM531VHiBekJzpEB9LkwUxRUxEgz7K8ch9TxP+ndxa8roV2Vxum/I9
        0MdLBEqqKiFq/eeb2Ou5iMo=
X-Google-Smtp-Source: ABdhPJxiaMQSF5aQnwptHbIMI7IyFwQxTjUhS8gbDjqudrYedippV2ExrK8pQT0GQ6TQ9sjUaHt5/g==
X-Received: by 2002:ad4:522b:: with SMTP id r11mr10787069qvq.6.1618608429096;
        Fri, 16 Apr 2021 14:27:09 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id l4sm5081376qkd.105.2021.04.16.14.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:27:08 -0700 (PDT)
Message-ID: <bd3767f61d0a604918e9886ae6da2eadc8dde310.camel@gmail.com>
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
Date:   Fri, 16 Apr 2021 18:27:03 -0300
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

