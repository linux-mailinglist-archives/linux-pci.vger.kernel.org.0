Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60303117267
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 18:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIRFQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 12:05:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbfLIRFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 12:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575911115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YU2tYXsp2GBBsr4G0U6n0fc7yLb4kMLHpVFrZEia0zU=;
        b=Go7As8l/HmAnviyCrmAZEd2BKMR3y2e+qmE5e7lGK2GpD+ZdN6uOUTuC/TNCHZaOhshph9
        NNySYBfwPtcTL3lBUVYxecYoy164HDwXDJGC8CRen73v82WrBFgrYJTqCQRt4vf6R/SzHB
        0E/I49BZFclDr5QKX15SMJAEFb9vdzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-PdEyLpJ7Md-RN-yy8qvTJQ-1; Mon, 09 Dec 2019 12:05:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E427106B1DD;
        Mon,  9 Dec 2019 17:05:10 +0000 (UTC)
Received: from x1.home (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B05D60C84;
        Mon,  9 Dec 2019 17:05:09 +0000 (UTC)
Date:   Mon, 9 Dec 2019 10:05:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pci@vger.kernel.org
Subject: Re: [Question] rk3399 vfio-pci/sr-iov support
Message-ID: <20191209100509.5cb950ac@x1.home>
In-Reply-To: <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com>
References: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
        <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PdEyLpJ7Md-RN-yy8qvTJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 9 Dec 2019 14:07:02 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 09/12/2019 1:28 pm, Peter Geis wrote:
> > Good Morning,
> > 
> > I'm back with more pcie fun on the rk3399.
> > I'm trying to get pcie passthrough working for a vm on the rk3399, and
> > have encountered some roadblocks.
> > 
> > First, vfio-pci doesn't work on the rk3399, as the pcie controller
> > doesn't bind explicitly to a iommu.
> > [37528.138212] vfio-pci 0000:01:00.0: assign IRQ: got 226
> > [37528.138254] vfio-pci: probe of 0000:01:00.0 failed with error -22
> > 
> > # find /sys/kernel/iommu_groups/ -type l
> > /sys/kernel/iommu_groups/1/devices/ff8f0000.vop
> > /sys/kernel/iommu_groups/2/devices/ff900000.vop
> > 
> > # virsh start openwrt
> > error: Failed to start domain openwrt
> > error: internal error: Process exited prior to exec: libvirt:  error :
> > internal error: Invalid device 0000:01:00.0 iommu_group file
> > /sys/bus/pci/devices/0000:01:00.0/iommu_group is not a symlink  
> 
> That much I can help with somewhat: the major impediment is that RK3399 
> doesn't have an IOMMU in front of PCIe. As far as I'm aware your only 
> option is to resort to the "here be dragons" CONFIG_VFIO_NOIOMMU mode 
> (which I don't know an awful lot about beyond that it's a thing).

And it's a thing that's really only useful if your motivation is to run
something like DPDK in the host and you're not concerned about
isolation between userspace drivers and the host kernel, and you don't
mind tainting the kernel.  It's not useful for things like assigning a
device to a VM as we can't readily do that without an IOMMU for
translation.  Thanks,

Alex

