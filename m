Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE86117D1E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 02:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLJBXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 20:23:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44264 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLJBX3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 20:23:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so3221239qkb.11
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LLOsXJUguuY43ARhOMf4LcyiwTN1Y1LouDaq9UTc8c=;
        b=l8IHO2F4OBehQ6RAeYuFdapsotQ8TbHCUSczGIhRxnhEq63hJyqhL9pn2DQtqSkF9M
         LM6Rq29oeSkI0g9+nCmMtEx5u6cJlfuqncrzHsNcTs4bH0LG2bnogzxyvf+rFJisHr0W
         ycWJmaanWMACBvkOxa7Z/dsq05RBZaZ00qqr2lcrUNYaw/sXuPSvqpbtuZas91tE89vc
         aQTyA7b0v6dn+AJXYl0Giv+OCgFzcMzuMRYkOpE5cMgmwqxcsdcSnBIOISuxeCwAB9Gi
         UTUhFXM/CjoSrAvlHZ9rPIRKrVLb3cYDf7UGOGfSalXSbv2cfsymq+Xc8sCixLqAC8fK
         Q2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LLOsXJUguuY43ARhOMf4LcyiwTN1Y1LouDaq9UTc8c=;
        b=EhwhAjD7FN2motmEOas7wuz2+lCjRKGp0sU2kKXgOEQi5sEMfvbJuNKhqDsKeQoYTZ
         AWGU8KtYFH6lGD+DhuZKNXVQfzIXn4sN2/cLvQbcVDVMqFcG37aEIeKuyuUqTbMDbYb1
         b2sHwLVmnr80ateUYclaQ8eg67BWXCSiFsFKLnXqYYxyX4IQb6MC2ZiPf7xT8B7jZSVK
         8W3DAbzsFNersjRrtIKZtOYeCe4pTv1IiYAkytMEDRMTPB2tIHnvhjQBRM1oawBRuYxD
         cisXO2Ukop7Ygimt0JhMuBjFRK7PS4kZOf+KtBEZnWf3F2VINH2RS+xstYI2JRvD0ok+
         vh8A==
X-Gm-Message-State: APjAAAXqKOvXdSCYd2VQQ+IxjEketFRALJUVs3ZSOy8FyXXN5kn/HhFZ
        GEk9sRj1aatBR7gXB+Zf7z0qT4V2JC3aEjx2rFo=
X-Google-Smtp-Source: APXvYqzjXWJqiDvR4XrOmnS/wwxe/dqN3HQtt1l0npmtzq6c5YYzy4nb95gspjCoW42IMFsqRnkta9h4meyYzRNee7o=
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr29231855qkj.262.1575941008186;
 Mon, 09 Dec 2019 17:23:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
 <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com> <20191209100509.5cb950ac@x1.home>
In-Reply-To: <20191209100509.5cb950ac@x1.home>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 9 Dec 2019 20:23:18 -0500
Message-ID: <CAMdYzYpVoB4tPWcgOCTbxjCfSpYtWKzG_6ucgasJqZynUrqhcA@mail.gmail.com>
Subject: Re: [Question] rk3399 vfio-pci/sr-iov support
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 9, 2019 at 12:05 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 9 Dec 2019 14:07:02 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
>
> > On 09/12/2019 1:28 pm, Peter Geis wrote:
> > > Good Morning,
> > >
> > > I'm back with more pcie fun on the rk3399.
> > > I'm trying to get pcie passthrough working for a vm on the rk3399, and
> > > have encountered some roadblocks.
> > >
> > > First, vfio-pci doesn't work on the rk3399, as the pcie controller
> > > doesn't bind explicitly to a iommu.
> > > [37528.138212] vfio-pci 0000:01:00.0: assign IRQ: got 226
> > > [37528.138254] vfio-pci: probe of 0000:01:00.0 failed with error -22
> > >
> > > # find /sys/kernel/iommu_groups/ -type l
> > > /sys/kernel/iommu_groups/1/devices/ff8f0000.vop
> > > /sys/kernel/iommu_groups/2/devices/ff900000.vop
> > >
> > > # virsh start openwrt
> > > error: Failed to start domain openwrt
> > > error: internal error: Process exited prior to exec: libvirt:  error :
> > > internal error: Invalid device 0000:01:00.0 iommu_group file
> > > /sys/bus/pci/devices/0000:01:00.0/iommu_group is not a symlink
> >
> > That much I can help with somewhat: the major impediment is that RK3399
> > doesn't have an IOMMU in front of PCIe. As far as I'm aware your only
> > option is to resort to the "here be dragons" CONFIG_VFIO_NOIOMMU mode
> > (which I don't know an awful lot about beyond that it's a thing).
>
> And it's a thing that's really only useful if your motivation is to run
> something like DPDK in the host and you're not concerned about
> isolation between userspace drivers and the host kernel, and you don't
> mind tainting the kernel.  It's not useful for things like assigning a
> device to a VM as we can't readily do that without an IOMMU for
> translation.  Thanks,
>
> Alex

Thanks Robin,

That is an unfortunate limitation, especially considering the device
is supposed to support sr-iov.
I did try getting VFIO_NOIOMMU to work, but qemu does not like it, at
least for pci devices.
>
