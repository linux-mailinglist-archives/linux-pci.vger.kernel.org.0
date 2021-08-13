Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3E3EBB25
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhHMROu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 13:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHMROt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 13:14:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A34BD60F91;
        Fri, 13 Aug 2021 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628874862;
        bh=UlNx6t9wDdCzNBUeeQkKsk3UMK+ySyiMK9wkVVRViOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wrf32i+/N/BS/OpId5bdmh+Noe8tSpadACMCv6jgegli28xX8jc0G9ozeVKrTtObP
         jUHmXOcRaw2Ckp3rDBOQbdKTmtPbwprJtAEEU5sJCu38GJsFYX2+/ZyDrXy2fawOK/
         T1PXyiN+g4vZyoQqfHupxZ8D8aFSpq8VoJMnqcSptad+f3FInT9Z0uyaVrn/N8PStv
         rFIUDIVHE3r5RxRuvdHscdvz6ALS+qcCR0C4Wk6p7t4GmkiHo3soJfgXY5Zuxg1zj/
         grHSPso4juqBQKJp9ODc75mwuPqjwMYlTH2IYzkuJVpmu4zg1tqNTJAPh3wh+Vhper
         EFNj2hJLu7cfg==
Date:   Fri, 13 Aug 2021 12:14:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: CXL Hot and Warm Reset Testing
Message-ID: <20210813171421.GA2593219@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB2534D383B0226498DD7F2005BDFA9@DM5PR12MB2534.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Amey (working on PCI resets), linux-pci]

On Fri, Aug 13, 2021 at 05:01:32PM +0000, Vikram Sethi wrote:
> Hi Dan, 
> 
> > -----Original Message-----
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > On Wed, Aug 11, 2021 at 9:42 AM Chris Browy <cbrowy@avery-design.com>
> > wrote:
> > 
> > /sys/bus/pci/devices/$device/reset is a method to trigger PCI
> > device reset, but I do not expect that will ever gain CXL specific
> > knowledge.
> > 
> CXL reset may need some thought, specially for devices that don't
> expose FLR but do expose CXL reset (while former does not affect
> CXL.cache/mem, the latter wipes out CXL.cache/mem state in the
> device and there is discoverability as to whether or not memory
> contents can be cleared as part of CXL reset). We may need a way of
> triggering CXL reset from userspace, and if the existing
> /sys/bus/pci/devices/$device/reset won't have knowledge of CXL
> reset, there still should be a prioritized order in the kernel in
> which CXL reset is attempted before more drastic resets like SBR.
> IIRC CXL reset can also impact all functions that use CXL.cache/mem,
> but not legacy PCIe functions on the device which do not use
> CXL.cache/mem (there is discoverability as to which functions are
> not impacted by CXL reset). 
> 
> Thanks,
> Vikram
