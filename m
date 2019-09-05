Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F26A9DC7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfIEJIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 05:08:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40402 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732160AbfIEJIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 05:08:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id y10so980881pll.7
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2019 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ghHRvQPVPbervCmbxcj9ka6t6kqgJGcJ0N1C9QEazv0=;
        b=0z4xt+c7UhZ3WIZd0Lo1oEbNZK/Qp0TdkdYnv+TvMItGrucMc0skqhRM6tasUaqfPS
         uHg0q90isJIsxHLEMhg/WMNiIJ37kBscPCSxpfSj2PFq2eIRCH0I9KCrG++SJKhP7hyl
         GUB+1vuKBHn90Hl3VkrsE3w26JGa3iZ2ecmMpmf9VgCIr0HcDvAcLG0RBp+5g8R1MSdB
         XTqC0MRjt+Qf8Q1OPKtB8kA7VpPTEy5ioHi5A0GY+JIsxVYDoLtA1hfotJGuVe0ez7Tz
         HkGt0cIpHDIJHxtXS1CT8ZKm3o8rlrxuXt0ZjHaUSuRr0v+Y7T1XiZuAfiGj710/Qk2P
         9TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghHRvQPVPbervCmbxcj9ka6t6kqgJGcJ0N1C9QEazv0=;
        b=VehcWm07k8OUN1PSIMlkXslmViGM9NVyncOdY3UTDDFS22E9WMooB1YZ1K6dILn1p+
         3PX+Ate98YVLf8TKlnGKpnGwHaNpdh2DU0m5Hk34pa9sewEgAdsYOMfhOp6bMzSQbs4P
         AYtiupRCqxSAkb7wedDl6FBxm+kAtjshEdzwlCi3n2IZcUpukl9IBFpEIHyq7sbCt2AN
         QIHNXJnvDaE2uh7Pt8kl85zjHEUvXEHvhGwwHZjBa8EqyV3G+oAmUKH8q1qrfOWEaVCy
         7N8W1Y/KFZBKorKLmjjgO6bKtoGd5shiHqcgSiQTla7CkzVQUsCJrlC9NvKWimCqpMjf
         d1zg==
X-Gm-Message-State: APjAAAUI1L0F81alJ7cucsrAP2sZzDrJij4Cxmv/92kSBPxPy/5fNpEz
        kdk6FUfyHB3/xnO5Y8jMMIlyb8Ixazo=
X-Google-Smtp-Source: APXvYqxDe7RmUKZdRmOXfm85qGSMv0TNu4nPbOm/7M3aDQGBmOcx2bC0nYxjTuFwB1j6CM2+HZhJwg==
X-Received: by 2002:a17:902:e493:: with SMTP id cj19mr2228022plb.292.1567674509883;
        Thu, 05 Sep 2019 02:08:29 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id s186sm2029034pfb.126.2019.09.05.02.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 02:08:29 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix IOMMU setup for hotplugged devices on pseries
To:     Shawn Anastasio <shawn@anastas.io>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        sbobroff@linux.ibm.com, oohall@gmail.com
References: <20190905042215.3974-1-shawn@anastas.io>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7a41184c-9b30-8d91-9d78-9d60c8d128ef@ozlabs.ru>
Date:   Thu, 5 Sep 2019 19:08:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905042215.3974-1-shawn@anastas.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 05/09/2019 14:22, Shawn Anastasio wrote:
> On pseries QEMU guests, IOMMU setup for hotplugged PCI devices is currently
> broken for all but the first device on a given bus. The culprit is an ordering
> issue in the pseries hotplug path (via pci_rescan_bus()) which results in IOMMU
> group assigment occuring before device registration in sysfs. This triggers
> the following check in arch/powerpc/kernel/iommu.c:
> 
> /*
>   * The sysfs entries should be populated before
>   * binding IOMMU group. If sysfs entries isn't
>   * ready, we simply bail.
>   */
> if (!device_is_registered(dev))
> 	return -ENOENT;
> 
> This fails for hotplugged devices since the pcibios_add_device() call in the
> pseries hotplug path (in pci_device_add()) occurs before device_add().
> Since the IOMMU groups are set up in pcibios_add_device(), this means that a
> sysfs entry will not yet be present and it will fail.

I just tried hotplugging 3 virtio-net devices into a guest system with 
v5.2 kernel and it seems working (i.e. BARs mapped, a driver is bound):


root@le-dbg:~# lspci -v | egrep -i '(virtio|Memory)'
00:00.0 Ethernet controller: Red Hat, Inc Virtio network device
         Memory at 200080040000 (32-bit, non-prefetchable) [size=4K]
         Memory at 210000000000 (64-bit, prefetchable) [size=16K]
         Kernel driver in use: virtio-pci
00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
         Memory at 200080041000 (32-bit, non-prefetchable) [size=4K]
         Memory at 210000004000 (64-bit, prefetchable) [size=16K]
         Kernel driver in use: virtio-pci
00:02.0 Ethernet controller: Red Hat, Inc Virtio network device
         Memory at 200080042000 (32-bit, non-prefetchable) [size=4K]
         Memory at 210000008000 (64-bit, prefetchable) [size=16K]
         Kernel driver in use: virtio-pci

Can you explain in detail what you are doing exactly and what is failing 
and what qemu/guest kernel/guest distro is used? Thanks,


> 
> There is a special case that allows the first hotplugged device on a bus to
> succeed, though. The powerpc pcibios_add_device() implementation will skip
> initializing the device if bus setup is not yet complete.
> Later, the pci core will call pcibios_fixup_bus() which will perform setup
> for the first (and only) device on the bus and since it has already been
> registered in sysfs, the IOMMU setup will succeed.
> 
> My current solution is to introduce another pcibios function, pcibios_fixup_dev,
> which is called after device_add() in pci_device_add(). Then in powerpc code,
> pcibios_setup_device() was moved from pcibios_add_device() to this new function
> which will occur after sysfs registration so IOMMU assignment will succeed.
> 
> I added a new pcibios function rather than moving the pcibios_add_device() call
> to after the device_add() call in pci_add_device() because there are other
> architectures that use it and it wasn't immediately clear to me whether moving
> it would break them.
> 
> If anybody has more insight or a better way to fix this, please let me know.
> 
> Shawn Anastasio (2):
>    PCI: Introduce pcibios_fixup_dev()
>    powerpc/pci: Fix IOMMU setup for hotplugged devices on pseries
> 
>   arch/powerpc/kernel/pci-common.c | 13 ++++++-------
>   drivers/pci/probe.c              | 14 ++++++++++++++
>   include/linux/pci.h              |  1 +
>   3 files changed, 21 insertions(+), 7 deletions(-)
> 

-- 
Alexey
