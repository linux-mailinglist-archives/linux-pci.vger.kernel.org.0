Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F82F3589
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 17:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406646AbhALQUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 11:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406153AbhALQUF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 11:20:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB6062222B;
        Tue, 12 Jan 2021 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610468365;
        bh=K15kqN6d8bltmp/D2dIKxt8SX/ubLa2fWzXTMRJ9Wjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HkzBcf6zciDNh2ZRd8Ddz5SlVjzwMvY1lDlQanLlobJyoAUlWcEZnvHWjn4X0pI2j
         33vvpN2uxnIJVAFxzUdWUV2N2XNHTNniw7cdZje3+rVG9t2LhK5AHstB00M8KC58L0
         6DtE9xv59fO4xFsPF5qMJCFOlKhlP35bf+Ho/45ZfdvNxZ1CEz3dNlmM0YJwCh/n3D
         AvclJTvY1dICswABfbwMxlZrsCrwB8z/sUW87QhU+M/+eG2X3R3iSCSzQG7HiizrJO
         EmCYZ47ey6RAvNrOyvTvj0eUfKVdTsZ+6268+eauqQLiri7rzZb1h2rdBBheu/R5WC
         T6IsK09A1Pu+w==
Date:   Tue, 12 Jan 2021 10:19:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?5YiY5LmQ5LmQKOS5kOS6hik=?= <daniel.lll@alibaba-inc.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Xu, Di" <di.x@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 00/16] CXL 2.0 Support
Message-ID: <20210112161923.GA1807814@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f2a6d62-09d8-416f-e972-3e9869c3e1a6@alibaba-inc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 10:55:50PM +0800, 刘乐乐(乐了) wrote:
> Ben,
> 
> Thanks for your hard work. I have compiled this patch(aff2b059786d ,
> cxl-2.0v3) together qemu emulator v3, this is the first time I see a CXL
> device in linux.
> 
> Still I have problems, I can saw the CXL device with `lspci -vvv`  and a
> device /dev/cxl/mem0 . But I can't see the memory in system and lsmem
> command.
> 
> Qemu command line is :
> 
> sudo ./qemu-cxl/build/qemu-system-x86_64 -enable-kvm -smp 8 -drive
> file=/mnt/lele/vm/cxl-centos8-uefi.qcow2,format=qcow2,cache=none -drive if=pflash,format=raw,unit=0,file=/mnt/lele/edk2/usr/share/edk2-ovmf/x64/OVMF_CODE.fd,readonly=on
> -drive if=pflash,format=raw,readonly,unit=1,file=/mnt/lele/edk2/usr/share/edk2-ovmf/x64/OVMF_VARS.fd
> -m 32G -vnc :12 -machine type=pc-q35-4.0,hmat=on,accel=kvm -net nic -net
> tap,ifname=tap1,script=/mnt/lele/vm/qemu-ifup,downscript=no -object memory-backend-file,id=cxl-mem1,share,mem-path=/mnt/lele/cxl-mem.dat,size=512M
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,window-base[0]=0x4c0000000,memdev[0]=cxl-mem1
> -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0 -device
> cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M
> 
> So, what's the further step to show the memory in system memory?

Please use plain text email only.  Your response is valuable, but I
think the linux-kernel and linux-pci mailing lists rejected it because
it was a multi-part message with images and other non-text elements.

If you look at https://lore.kernel.org/linux-cxl/20210112151735.w45qbi37pc3zuucw@intel.com/T/#t,
you can see Ben's v3 00/16 email and his response to your response,
but your response is missing.

See http://vger.kernel.org/majordomo-info.html for details.
