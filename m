Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01D334987F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 18:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYRoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCYRny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 13:43:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4BC06175F
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 10:43:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e7so3351740edu.10
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tou3h9jnBqeaQGEPmPurXQuY6E2+g7FGdoVck2muf4Q=;
        b=hnpu95FThTFSu1cIpbhwYwf625S3TgCZvUsfx9bIM6JBEpdS1bCpgCciHKGpNGcJcf
         g6TAGM2Kf3J5By5zYfoxrOPKZDWRg5t/ECtMLmm4mDCK+6M18QD4DWnLxXI7/NV8p65+
         RdVQR991tTHPfwNt4D6H8yWujSsZU+AXFrMuyR8dRcSZehFNS+GAHLeN8m8pNewKNcjy
         jcOvJsm5AKl7OBaaVhIF3J2qpLEQzUBSun//UazAeWiPtqCD4hRA+Tko53v0HCEvGQBh
         EKCXkenDE951yN0Q91yoGrrt3bILEJdW3hVdnpTwXbTBqhJbjY6ukb8TQFML2KEDiMtS
         F7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tou3h9jnBqeaQGEPmPurXQuY6E2+g7FGdoVck2muf4Q=;
        b=FqTSJ1Gg1dR9t8uLGS6smel87KByP6aRHy8xeypbSF36KhU0v24LE9/SplugsVHByO
         oplpO1XpwTOuyx2s2SUYnC5CzTBYhw71OqxHixgTe+rFYDcJKNY800I5iQZYcIcPzcmm
         VLKkAo15RzXC2wRQu8+64XxhYVMXQf6RnR8WZ1BtdyoJkT3Vz15JqkjqbH5m6om1uc5A
         l+qXMPYWGzcpfx+QSD3eBBqXn9EGiHNU7zs2T2g7iguBC4P5arQsfd2q/sVpmDku/QT5
         Wf+5AH+5d9jyiyX1ui+Ls45AY6GlyKS8a0IiO5corqVhMULXW8ND5ZyED1J/GuC+xz1G
         KlcQ==
X-Gm-Message-State: AOAM532tOJKPtDdOCq2EQXhxIUhKOgqKPl+8OqIERN+UaTuLfWsjLoQY
        JEGD/n6fmrKGQw1RaWbHg3AbsCA9UFshotfko5Ghyw==
X-Google-Smtp-Source: ABdhPJzDjN0uH+pfe/CI7t1H7ZO4vfoquVXWi1vDbfzNIi4DeUdtOcjW5Qre8hqNZzQZQ3qMdqrFhubJT2q5qe4/oQI=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr10398289edw.348.1616694232248;
 Thu, 25 Mar 2021 10:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YFwzw3VK0okr+taA@kroah.com>
In-Reply-To: <YFwzw3VK0okr+taA@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Mar 2021 10:43:41 -0700
Message-ID: <CAPcyv4huzgpCvT+MVjpVPRE+ZcxPaqB2jqVMt7nJuP0hpzQ82A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config regions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 11:55 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > configuration cycles. It assumes one initiator at a time is
> > reading/writing the data registers.
>
> That sounds like a horrible protocol for a multi-processor system.
> Where is it described and who can we go complain to for creating such a
> mess?

It appears it was added to the PCIE specification in March of last
year, I don't attend those meetings. I only learned about it since the
CXL specification adopted it.

>
> > If userspace reads from the response
> > data payload it may steal data that a kernel driver was expecting to
> > read. If userspace writes to the request payload it may corrupt the
> > request a driver was trying to send.
>
> Fun!  So you want to keep root in userspace from doing this?  I thought
> we already do that today?

The only limitation I found was temporary locking via
pci_cfg_access_lock(), and some limitations on max config offset, not
permanent access disable.

>
> > Introduce pci_{request,release}_config_region() for a driver to exclude
> > the possibility of userspace induced corruption while accessing the DOE
> > mailbox. Likely there are other configuration state assumptions that a
> > driver may want to assert are under its exclusive control, so this
> > capability is not limited to any specific configuration range.
>
> As you do not have a user for these functions, it's hard to see how they
> would be used.  We also really can't add new apis with no in-tree users,
> so do you have a patch series that requires this functionality
> somewhere?

Whoops, I buried the lead here. This is in reaction to / support of
Jonathan's efforts to use this mailbox to retrieve a blob of memory
characteristics data from CXL devices called the CDAT [1]. That blob
is used to populate / extend ACPI SRAT/HMAT/SLIT data for CXL attached
memory. So while I was reviewing his patches it occurred to me that
the b0rked nature of this interface relative to pci-sysfs needed to be
addressed. This should wait to go in with his series.

[1]: https://lore.kernel.org/linux-acpi/20210310180306.1588376-2-Jonathan.Cameron@huawei.com/

>
> > Since writes are targeted and are already prepared for failure the
> > entire request is failed. The same can not be done for reads as the
> > device completely disappears from lspci output if any configuration
> > register in the request is exclusive. Instead skip the actual
> > configuration cycle on a per-access basis and return all f's as if the
> > read had failed.
>
> returning all ff is a huge hint to many drivers that the device is gone,
> not that it just failed.  So what happens to code that thinks that and
> then tears stuff down as if the device has been removed?

This is limited to the pci_user_* family of accessors, kernel drivers
should be unaffected. The protection for kernel drivers colliding is
the same as request_mem_region() coordination.

Userspace drivers will of course be horribly confused, but those
should not be binding to devices that are claimed by a kernel driver
in the first place.

> Trying to protect drivers from userspace here feels odd, what userspace
> tools are trying to access these devices while they are under
> "exclusive" control from the kernel?  lspci not running as root should
> not be doing anything crazy, but if you want to run it as root,
> shouldn't you be allowed to access it properly?

The main concern is unwanted userspace reads. An inopportune "hexdump
/sys/bus/pci/devices/$device/config" will end up reading the DOE
payload register and advancing the device state machine surprising the
kernel iterator that might be reading the payload.

If root really wants to read that portion of config space it can also
unload the driver similar to the policy for /dev/mem colliding with
exclusive device-mmio... although that raises the question how would
root know. At least for exclusive /dev/mem /proc/iomem can show who is
claiming that resource.

If userspace needs to submit DOE requests then that should probably be
a proper generic driver to submit requests, not raw pci config access.

> What hardware has this problem that we need to claim exclusive ownership
> over that differs from the old hardware we used to have that would do
> crazy things when reading from from userspace?  We had this problem a
> long time ago and lived with it, what changed now?

All I can infer from the comments in drivers/pci/access.c is "bad
things happens on some devices if you allow reads past a certain
offset", but no concern for reads for offsets less than
pdev->cfg_size. I think what's changed is that this is the first time
Linux has had to worry about an awkward polled I/O data transfer
protocol over config cycles.

To make matters worse there appears to be a proliferation of protocols
being layered on top of DOE. In addition to CXL Table Access for CDAT
retrieval [2] I'm aware of CXL Compliance Testing [3], Integrity and
Data Encryption (IDE) [4], and Component Measurement and
Authentication (CMA) [5].

I've not read those, but I worry security_locked_down() may want to
prevent even root userspace mucking with "security" interfaces. So
that *might* be a reason to ensure exclusive kernel access beyond the
basic sanity of the kernel being able to have uninterrupted request /
response sessions with this mailbox

[2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
[3]: https://www.computeexpresslink.org/download-the-specification
[4]: https://members.pcisig.com/wg/PCI-SIG/document/15149
[5]: https://members.pcisig.com/wg/PCI-SIG/document/14236
