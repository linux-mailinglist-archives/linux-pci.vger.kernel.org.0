Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED2CAAA76
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfIER7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 13:59:47 -0400
Received: from alpha.anastas.io ([104.248.188.109]:57561 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIER7q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 13:59:46 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id C6A667E74E;
        Thu,  5 Sep 2019 12:59:45 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1567706386; bh=61aoJjKj3xjkVn+bS+/OtYdskRw6zpPaF6JEETWOzDE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mN1ifW4BHAXGjac5ZRUWGNdSopsnL4mwoPJqqWjcEvGEzcyB1MgFhc6/6+gy6PV9O
         Ej9ehnE+ob6gIS3x6AYep8eol0GsMsNyqNcc8cZx2mQD82knj1kuT5X5Rz62u/GiR8
         2ahln/ww1d4ajrsxzlSBksEXpM3DgmRn84rx6G/WGJPv3HTuDdq/sbkCUMUIAmfdrD
         fjZgvGNGAIFp3zfqlOtvCqrjqNP1QAIEeykN9xkK3DxH1Tlzs4Tdkml4ErA4FFPoPE
         37yxGGLry2bTOHxsmJHxwq3WSDzF6PT4GB2jSRUeShAVJdtY9XHtUlOjZ3bRcXquvG
         xSX9j/7fXvNMw==
Subject: Re: [PATCH 0/2] Fix IOMMU setup for hotplugged devices on pseries
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, oohall@gmail.com, sbobroff@linux.ibm.com
References: <20190905042215.3974-1-shawn@anastas.io>
 <7a41184c-9b30-8d91-9d78-9d60c8d128ef@ozlabs.ru>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <7fb9fb72-2afd-451c-1411-54c7bb865d56@anastas.io>
Date:   Thu, 5 Sep 2019 12:59:44 -0500
MIME-Version: 1.0
In-Reply-To: <7a41184c-9b30-8d91-9d78-9d60c8d128ef@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/19 4:08 AM, Alexey Kardashevskiy wrot>
> I just tried hotplugging 3 virtio-net devices into a guest system with 
> v5.2 kernel and it seems working (i.e. BARs mapped, a driver is bound):
>
> 
> root@le-dbg:~# lspci -v | egrep -i '(virtio|Memory)'
> 00:00.0 Ethernet controller: Red Hat, Inc Virtio network device
>          Memory at 200080040000 (32-bit, non-prefetchable) [size=4K]
>          Memory at 210000000000 (64-bit, prefetchable) [size=16K]
>          Kernel driver in use: virtio-pci
> 00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
>          Memory at 200080041000 (32-bit, non-prefetchable) [size=4K]
>          Memory at 210000004000 (64-bit, prefetchable) [size=16K]
>          Kernel driver in use: virtio-pci
> 00:02.0 Ethernet controller: Red Hat, Inc Virtio network device
>          Memory at 200080042000 (32-bit, non-prefetchable) [size=4K]
>          Memory at 210000008000 (64-bit, prefetchable) [size=16K]
>          Kernel driver in use: virtio-pci
> 
> Can you explain in detail what you are doing exactly and what is failing 
> and what qemu/guest kernel/guest distro is used? Thanks,

Sure. I'm on host kernel 5.2.8, guest on 5.3-rc7 (also tested on 5.1.16)
and I'm hotplugging ivshmem devices to a separate spapr-pci-host-bridge
defined as follows:

-device spapr-pci-host-bridge,index=1,id=pci.1

Device hotplug and BAR assignment does work, but IOMMU group assignment
seems to fail. This is evidenced by the kernel log which shows the
following message for the first device but not the second:

[  136.849448] pci 0001:00:00.0: Adding to iommu group 1

Trying to bind the second device to vfio-pci as a result of this
fails:

[  471.691948] vfio-pci: probe of 0001:00:01.0 failed with error -22

I traced that failure to a call to iommu_group_get() which returns
NULL for the second device. I then traced that back to the ordering
issue I described.

For your second and third virtio-net devices, was the
"Adding to iommu group N" kernel message printed?
