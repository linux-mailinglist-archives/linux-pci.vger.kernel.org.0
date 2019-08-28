Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C399F8C8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfH1DdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 23:33:11 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:59041 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfH1DdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 23:33:11 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5EB7E10309CE5;
        Wed, 28 Aug 2019 05:33:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 197E81D5BB5; Wed, 28 Aug 2019 05:33:09 +0200 (CEST)
Date:   Wed, 28 Aug 2019 05:33:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Simplify PCIe hotplug indicator control
Message-ID: <20190828033309.e65mmunihlyrzzgz@wunner.de>
References: <20190819160643.27998-1-efremov@linux.com>
 <2f4c857e-a7cc-58da-8be5-cba581c56d9f@linux.com>
 <20190827223254.GC9987@google.com>
 <20190827225319.GE9987@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827225319.GE9987@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 05:53:19PM -0500, Bjorn Helgaas wrote:
> Unrelated, but if anybody is looking at pciehp, is there value in
> having pciehp split across five files?
> 
>   drivers/pci/hotplug/pciehp.h
>   drivers/pci/hotplug/pciehp_core.c
>   drivers/pci/hotplug/pciehp_ctrl.c
>   drivers/pci/hotplug/pciehp_hpc.c
>   drivers/pci/hotplug/pciehp_pci.c
> 
> To me, it just makes things harder because when I'm browsing for
> something in pciehp and I don't know the exact name of it, I have to
> guess which file it's in, and I'm invariably wrong.
> 
> It seems like it would be much simpler if everything were in a single
> pciehp.c file.  Then we could also get rid of the header and make
> several more things static.

I wouldn't go so far as to say there's *value* in the split.

It's a historic artefact, it's been like that since pciehp was
introduced back in 2004:
https://git.kernel.org/tglx/history/c/c16b4b14d980

I was hesitant to change it so far, in particular because it makes
it harder to backport stable patches.

That said, I did think about rearranging things to reduce the number
of files and non-static declarations or to give the files better names.
I wasn't thinking of squashing everything into one file, it would
probably be quite large and not make things simpler.

The general logic is that everything touching the registers is in
pciehp_hpc.c.  You won't (or shouldn't) find register access in any
of the other files.

pciehp_ctrl.c is the control logic, reaction to events, etc.
Though portions of the control logic are also in pciehp_hpc.c,
in particular the interrupt servicing.

pciehp_core.c contains the interface to the PCI hotplug core and
the probe/remove/PM routines.

pciehp_pci.c contains bringup/teardown of the slot.

One thing that I think deserves changing is this comment at the
top of each file:

"Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>"

We now use MAINTAINERS to do this.  Kristen took over maintainership
in 2005 with commit 8cf4c19523b7 but by 2009 she had stepped down per
commit be3652b8a253.  So providing her address is no longer accurate.
And I imagine Greg is no longer as familiar with the driver as it has
changed considerably since 2004.  He'd probably have to defer to others
who have done work on it recently (such as me).

Thanks,

Lukas
