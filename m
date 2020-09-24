Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20F277ABA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIXUwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 16:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXUwV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 16:52:21 -0400
Received: from [192.168.0.112] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69820221EB;
        Thu, 24 Sep 2020 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600980741;
        bh=gpYwhhHOWSPDy2kWnKAkCOCRuZ4/XrJdwfuUWgRVLYM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tYemBO+jPNMAnoBQmRHA77lZCUB2oMjZIjBHD6Dj1NpIhojgPmm5lXaZEbhAWmG3p
         C9FhSt/bidQK/rtoM63jmIG+myMxFpFf/5pBinnXhOKdqHUOjfvpRmiGX77WonSfSq
         EIS7ctCVvXg6yEcw/29zE+N9UjlEDy0+AnfYXn24=
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com>
 <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
 <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com>
 <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
 <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
Date:   Thu, 24 Sep 2020 16:52:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/24/2020 12:06 AM, Kuppuswamy, Sathyanarayanan wrote:
> For problem description, please check the following details
> 
> Current pcie_do_recovery() implementation has following two issues:
> 
> 1. Fatal (DPC) error recovery is currently broken for non-hotplug
> capable devices. Current fatal error recovery implementation relies
> on PCIe hotplug (pciehp) handler for detaching and re-enumerating
> the affected devices/drivers. pciehp handler listens for DLLSC state
> changes and handles device/driver detachment on DLLSC_LINK_DOWN event
> and re-enumeration on DLLSC_LINK_UP event. So when dealing with
> non-hotplug capable devices, recovery code does not restore the state
> of the affected devices correctly. Correct implementation should
> restore the device state and call report_slot_reset() function after
> resetting the link to restore the state of the device/driver.
> 

So, this is a matter of moving the save/restore logic from the hotplug
driver into common code so that DPC slot reset takes advantage of it?

If that's direction we are going, this is fine change IMO.

> You can find fatal non-hotplug related issues reported in following links:
> 
> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
> 
> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> 
> 
> 2. For non-fatal errors if report_error_detected() or
> report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET then
> current pcie_do_recovery() implementation does not do the requested
> explicit device reset, instead just calls the report_slot_reset() on all
> affected devices. Notifying about the reset via report_slot_reset()
> without doing the actual device reset is incorrect.
> 

This makes sens too. There seems to be an ordering issue per your
description.

> To fix above issues, use PCI_ERS_RESULT_NEED_RESET as error state after
> successful reset_link() operation. This will ensure ->slot_reset() be
> called after reset_link() operation for fatal errors. 

You lost me here. Why do we want to do secondary bus reset on top of
DPC reset?

> Also call
> pci_bus_reset() to do slot/bus reset() before triggering device specific
> ->slot_reset() callback. Also, using pci_bus_reset() will restore the state
> of the devices after performing the reset operation.
> 
> Even though using pci_bus_reset() will do redundant reset operation after
> ->reset_link() for fatal errors, it should should affect the functional
> behavior.

