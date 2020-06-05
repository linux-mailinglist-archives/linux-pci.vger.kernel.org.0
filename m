Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2011EFE95
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFERMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 13:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgFERMs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jun 2020 13:12:48 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E902077D;
        Fri,  5 Jun 2020 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591377167;
        bh=QXbftL2gglLukvDMxKCq8Z23Y28iI+DF1e2aAMUl0B0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n0EVdK/BsUW7EHAekrcDyWf/O1A67u7EZXXKoCWlYA8NsLLWg/vhwHiK1pYZac/X3
         dyZ8dHjsfabGnO6Nxu1/T+ojqzI2vgjFT8oQEhiQhDorg+S12awL/EI18of70GjXT2
         3OUfDd2l3dBol1/doICKWPqO1+tVTD2tho8VKvWs=
Date:   Fri, 5 Jun 2020 12:12:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Hsu <saraon640529@gmail.com>
Cc:     Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, bhelgaas@google.com,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] gpio:asm28xx-18xx: new driver
Message-ID: <20200605171244.GA1140813@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601073604.26289-1-saraon640529@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lee in case he can shed light on the MFD question below]

On Mon, Jun 01, 2020 at 03:36:04PM +0800, Richard Hsu wrote:
> Hi Bjorn Helgaas,
>  1. What are the other functions and where is the other driver?
>  >PCI bus and GPIO can be considered as two functions independently.
>  And the driver is located at drivers/gpio/gpio-amd8111.c

I'm obviously missing the point here; sorry for being slow.

drivers/gpio/gpio-amd8111.c uses for_each_pci_dev() to look for
PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS [1022:746b] devices.
drivers/i2c/busses/i2c-amd756.c claims that same device using the
normal PCI probe mechanism.

In this case both i2c-amd756 and gpio-amd8111 want to use the same
device, so there's at least a reason why gpio-amd8111 uses the
non-standard mechanism.

Your driver looks for PCI_VENDOR_ID_ASMEDIA devices: [1b21:2824],
[1b21:2812], [1b21:2806], [1b21:1824], etc).  But I haven't found a
second driver that needs to claim these devices.

I can't tell what any of these devices are (other than that they seem
to have some GPIO).  You might want to add them to the Linux PCI
database at https://pci-ids.ucw.cz/read/PC/1b21 .  If you do, then
"lspci" will show the correct names for them.

You mention below that these devices are PCIe bridges.  If that's the
case, they would be claimed by the "pcieport" driver in the PCI core
(drivers/pci/pcie/portdrv_pci.c).  If you collect the output of "sudo
lspci -vvxxxx", it would tell us whether the pcieport driver will
claim it.

If it does, then we have a problem because the PCIe port services
(AER, PME, DPC, etc) currently require pcieport.  If you want the AER,
PME, etc functionality in addition to GPIO, then we have to figure out
how to coordinate things.

>  2.We end up with multiple drivers controlling the device without
> any coordination between them?
>  >Yes,because two functions are independently in the device,and
> the main driver for PCI bus function is more important.We wish
> they can't be affected and coordinated between two drivers
> as much as possible.If main driver is affected,it is more
> serious.
>  In our case,we have gpio registers on pci configuration space
> of asm28xx pci-e bridge(with main pci bus driver).If we want
> to use it by another driver that use gpio subsystem /sys/class/
> gpio/(sysfs interface).I find the driver(gpio-amd8111.c) that
> meet our request.Sorry! i am not best friend with git,and
> reply mail in the same way. 
> 
> 
> Hi Bartosz Golaszewski,
>  Thank you.And i have studied PCI MFD device in drivers/mfd.

I'm not familiar with drivers/mfd.  It looks like it might be useful
for cases where a single PCI function implements multiple sorts of
functionality.

But if the problem is that you have a single function that is a PCIe
switch port and also implements some GPIOs, I doubt drivers/mfd will
help.  In that case, both the existing pcieport driver and your new
gpio-asm28xx-18xx driver would need to operate the same function, and
we'd have to make some significant changes to both of them to fit into
the MFD framework.

Long-term, I think it would be good to move the pcieport things
directly into the PCI core instead of being a separate driver.  We've
tripped over this problem before with things like performance counters
in PCIe ports.

> Maybe,it is not what i am looking for.This type of device
> include core and miscellaneous function drivers.And function
> drivers export resources(io/mem/dma) to sysfs.Fist,we can't
> implement another pci bus driver as core driver,and secondly,
> it don't use gpio subsystem with /sys/class/gpio/(sysfs
> interface).
>  So,you will review this driver and upstream to mainline
> kernel?
