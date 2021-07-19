Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9556C3CEF08
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 00:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhGSVXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384100AbhGSSUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 14:20:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B719C0613DC
        for <linux-pci@vger.kernel.org>; Mon, 19 Jul 2021 11:49:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r80so8091401oie.13
        for <linux-pci@vger.kernel.org>; Mon, 19 Jul 2021 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CuA8yyFaAhYVjmiYNFS6bfZI+tNSOF4B/W6ZoaryjOg=;
        b=s/MryUG7u++tDPlAQu468eIeRIuX3v/ZjlfvX/v/PoNqyEjq3K+REkQkjUhD8Z5djC
         lKqe/Lu2XFuVCgvl0X/Iyih6yXsWNr5+xSETLCjllifklg/utb0pCA/8ahsI3cHJ8VFw
         BZMTWm97Zl9hMZWJGEIaM9/qJLdQ1uUk70uVuUNde+gLr/heBUyHCKIJZ1dYpa0yXO1f
         Bfz++fGh47LxEHjDRaHVpWClHxNMBJLo7+bUVBpygt81tSDyHERO/ixxlwRwPYfmVEWi
         krVxign5Daxpw/1sYgdEy3qrZdx22lecePSZDMKpMy7rWeBvEBKEPZHnPIQLvYyGl21K
         u1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CuA8yyFaAhYVjmiYNFS6bfZI+tNSOF4B/W6ZoaryjOg=;
        b=CToCH4S/0ElpH82uL04xFxK81A2HMTQhMmDqyuQW3UPNftx/3UyF+QqoZz2Vfs+Q8g
         mq7TBw7AeO+MUhu79VRSlAHQoePJ2krcJzqqubxQzussimea5vFL/usA9BoccN+BqHpm
         qDgf/M9qgiy5Bl4+3VMyUWlfMoanebU0RrrFJybT+4Zrg8ThzeegKrZw58HoRzKHpa82
         pomSuMiDvzb5ffdHrc2F59PwbIjmqcFxSBlhYFPhKbFf37DzKcONfWLoHDh7Y+cZekZB
         G/uO43dStan8eZX1BZ7YzDfNUmfAGN/HpFkfBNp3q1Y+2uVAc4gHJt2dZprcGfov0PXW
         2+2g==
X-Gm-Message-State: AOAM53369bWY6lj53DP9Hmd/ZwNjC4g3gEu9q8fD6znmSTNQzVNN5e7Q
        cNk6y5fFZY6s3M+ZSfUnr1Q=
X-Google-Smtp-Source: ABdhPJxgxwnrBcq8W2fJ/RHcTDkDHMWqo8ElmWEWR2iwuL+cOMvLpgyen1MyHu+/ASMipedIPq6OJg==
X-Received: by 2002:aca:c207:: with SMTP id s7mr18552630oif.86.1626721254069;
        Mon, 19 Jul 2021 12:00:54 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id a44sm3516006ooj.12.2021.07.19.12.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:00:53 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
 <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
 <20210719151011.GA25258@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <a70a936d-d031-7199-4ed7-30753b3e7cfa@gmail.com>
Date:   Mon, 19 Jul 2021 14:00:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719151011.GA25258@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/19/2021 10:10 AM, Lukas Wunner wrote:
> On Fri, Jun 25, 2021 at 03:38:41PM -0500, stuart hayes wrote:
>> I have a system that is failing to recover after an EDR event with (or
>> without...) this patch.  It looks like the problem is similar to what this
>> patch is trying to fix, except that on my system, the hotplug port is
>> downstream of the root port that has DPC, so the "link down" event on it is
>> not being ignored.  So the hotplug code disables the slot (which contains an
>> NVMe device on this system) while the nvme driver is trying to use it, which
>> results in a failed recovery and another EDR event, and the kernel ends up
>> with the DPC trigger status bit set in the root port, so everything
>> downstream is gone.
>>
>> I added the hack below so the hotplug code will ignore the "link down"
>> events on the ports downstream of the root port during DPC recovery, and it
>> recovers no problem.  (I'm not proposing this as a correct fix.)
> 
> Could you test if the below patch fixes the issue?
> 
> Note, this is a hack as well, but I can turn it into a proper patch
> if it works as expected.
> 
> Thanks!
> 
> Lukas
> 

That does appear to fix the issue, thanks!  Without your patch, the PCIe 
devices under 64:02.0 disappear (the triggered bit is still set in the 
DPC capability).  With your patch, recovery is successful and all of the 
PCIe devices are still there.

If you are interested, here's the log showing the EDR before and after 
the patch was applied:

> [  180.295300] pcieport 0000:64:02.0: EDR: EDR event received
> [  180.325225] pcieport 0000:64:02.0: DPC: containment event, status:0x1f07 source:0x0000
> [  180.325229] pcieport 0000:64:02.0: DPC: RP PIO error detected
> [  180.325231] pcieport 0000:64:02.0: DPC: rp_pio_status: 0x00000000, rp_pio_mask: 0x00000303
> [  180.325237] pcieport 0000:64:02.0: DPC: RP PIO severity=0x00010000, syserror=0x00000000, exception=0x00000000
> [  180.325240] pcieport 0000:64:02.0: DPC: TLP Header: 0x00000002 0xfc2a3eff 0xbf5fffe0 0x00000000
> [  180.325250] nvme nvme0: frozen state error detected, reset controller
> [  180.343110] nvme nvme1: frozen state error detected, reset controller
> [  180.357158] nvme nvme2: frozen state error detected, reset controller
> [  180.371203] nvme nvme3: frozen state error detected, reset controller
> [  180.385219] mpt3sas_cm0: PCI error: detected callback, state(2)!!
> [  180.534915] pcieport 0000:66:08.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  180.551467] nvme nvme0: restart after slot reset
> [  180.551487] pcieport 0000:68:00.0: pciehp: Slot(211): Link Down
> [  180.551691] pcieport 0000:68:04.0: pciehp: Slot(210): Link Down
> [  180.551727] nvme nvme1: restart after slot reset
> [  180.612127] nvme nvme2: restart after slot reset
> [  180.612153] pcieport 0000:68:0c.0: pciehp: Slot(208): Link Down
> [  180.612422] pcieport 0000:68:14.0: pciehp: Slot(206): Link Down
> [  180.612439] nvme nvme3: restart after slot reset
> [  180.673870] nvme 0000:69:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [  180.675887] nvme nvme0: failed to mark controller CONNECTING
> [  180.675891] nvme nvme0: Removing after probe failure status: -16
> [  180.675893] mpt3sas_cm0: PCI error: slot reset callback!!
> [  180.675946] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (15845080 kB)
> [  180.678894] nvme 0000:6a:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [  180.683932] nvme nvme1: Removing after probe failure status: -19
> [  180.685886] nvme 0000:6c:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [  180.685914] nvme 0000:6e:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [  180.686149] nvme nvme2: Removing after probe failure status: -19
> [  180.686174] nvme nvme3: Removing after probe failure status: -19
> [  180.697896] nvme2n1: detected capacity change from 3125627568 to 0
> [  180.698902] nvme3n1: detected capacity change from 15002931888 to 0
> [  180.698949] nvme1n1: detected capacity change from 1562824368 to 0
> [  180.709893] nvme0n1: detected capacity change from 732585168 to 0
> [  188.331419] mpt3sas_cm0: _base_wait_for_doorbell_ack: failed due to timeout count(5000), int_status(ffffffff)!
> [  188.331433] mpt3sas_cm0: doorbell handshake sending request failed (line=6648)
> [  188.331439] mpt3sas_cm0: _base_get_ioc_facts: handshake failed (r=-14)
> [  188.331506] pcieport 0000:64:02.0: AER: device recovery failed
> [  188.337031] pcieport 0000:64:02.0: EDR: EDR event received
> [  188.369794] pcieport 0000:64:02.0: DPC: containment event, status:0x1f07 source:0x0000
> [  188.369797] pcieport 0000:64:02.0: DPC: RP PIO error detected
> [  188.369799] pcieport 0000:64:02.0: DPC: rp_pio_status: 0x00000000, rp_pio_mask: 0x00000303
> [  188.369802] pcieport 0000:64:02.0: DPC: RP PIO severity=0x00010000, syserror=0x00000000, exception=0x00000000
> [  188.369806] pcieport 0000:64:02.0: DPC: TLP Header: 0x00000001 0xfc003e0f 0xbf30001c 0x00000000
> [  188.369811] pci 0000:69:00.0: AER: can't recover (no error_detected callback)
> [  188.369812] pci 0000:6a:00.0: AER: can't recover (no error_detected callback)
> [  188.369814] pci 0000:6c:00.0: AER: can't recover (no error_detected callback)
> [  188.369815] pci 0000:6e:00.0: AER: can't recover (no error_detected callback)
> [  188.369819] mpt3sas_cm0: PCI error: detected callback, state(2)!!
> [  188.534982] pcieport 0000:64:02.0: AER: device recovery failed
> [  188.546336] mpt3sas_cm0: remove hba_port entry: 00000000d72416cf port: 0 from hba_port list
> [  188.546343] mpt3sas_cm0: mpt3sas_transport_port_remove: removed: sas_addr(0x54cd98f310000108)
> [  188.546346] mpt3sas_cm0: removing handle(0x0002), sas_addr(0x54cd98f310000108)
> [  188.546348] mpt3sas_cm0: enclosure logical id(0x54cd98f310000100), slot(0)
> [  188.558192] pcieport 0000:66:08.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  189.790967] pcieport 0000:77:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  189.791154] pcieport 0000:72:1c.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.791168] pcieport 0000:72:1c.0: pciehp: pciehp_isr: no response from device
> [  189.791453] pcieport 0000:72:18.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.791463] pcieport 0000:72:18.0: pciehp: pciehp_isr: no response from device
> [  189.791695] pcieport 0000:72:14.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.791705] pcieport 0000:72:14.0: pciehp: pciehp_isr: no response from device
> [  189.791875] pcieport 0000:72:10.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.791884] pcieport 0000:72:10.0: pciehp: pciehp_isr: no response from device
> [  189.792158] pcieport 0000:68:1c.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.792168] pcieport 0000:68:1c.0: pciehp: pciehp_isr: no response from device
> [  189.792348] pcieport 0000:68:18.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.792355] pcieport 0000:68:18.0: pciehp: pciehp_isr: no response from device
> [  189.792526] pcieport 0000:68:14.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.792535] pcieport 0000:68:14.0: pciehp: pciehp_isr: no response from device
> [  189.792719] pcieport 0000:68:10.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.792727] pcieport 0000:68:10.0: pciehp: pciehp_isr: no response from device
> [  189.792890] pcieport 0000:68:0c.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.792898] pcieport 0000:68:0c.0: pciehp: pciehp_isr: no response from device
> [  189.793093] pcieport 0000:68:08.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.793110] pcieport 0000:68:08.0: pciehp: pciehp_isr: no response from device
> [  189.793347] pcieport 0000:68:04.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.793356] pcieport 0000:68:04.0: pciehp: pciehp_isr: no response from device
> [  189.793543] pcieport 0000:68:00.0: pciehp: pcie_do_write_cmd: no response from device
> [  189.793553] pcieport 0000:68:00.0: pciehp: pciehp_isr: no response from device
> [  189.793820] pci_bus 0000:69: busn_res: [bus 69] is released
> [  189.794176] pci_bus 0000:6a: busn_res: [bus 6a] is released
> [  189.794367] pci_bus 0000:6b: busn_res: [bus 6b] is released
> [  189.794532] pci_bus 0000:6c: busn_res: [bus 6c] is released
> [  189.794621] pci_bus 0000:6d: busn_res: [bus 6d] is released
> [  189.794758] pci_bus 0000:6e: busn_res: [bus 6e] is released
> [  189.794938] pci_bus 0000:6f: busn_res: [bus 6f] is released
> [  189.795089] pci_bus 0000:70: busn_res: [bus 70] is released
> [  189.795472] pci_bus 0000:68: busn_res: [bus 68-70] is released
> [  189.795649] pci_bus 0000:67: busn_res: [bus 67-70] is released
> [  189.795867] pci_bus 0000:73: busn_res: [bus 73] is released
> [  189.796096] pci_bus 0000:74: busn_res: [bus 74] is released
> [  189.796267] pci_bus 0000:75: busn_res: [bus 75] is released
> [  189.796450] pci_bus 0000:76: busn_res: [bus 76] is released
> [  189.796555] pci_bus 0000:72: busn_res: [bus 72-76] is released
> [  189.796691] pci_bus 0000:71: busn_res: [bus 71-76] is released
> [  189.796802] pci_bus 0000:78: busn_res: [bus 78] is released
> [  189.796962] pci_bus 0000:77: busn_res: [bus 77-78] is released
> [  189.797296] pci_bus 0000:79: busn_res: [bus 79] is released
> [  189.797410] pci_bus 0000:66: busn_res: [bus 66-79] is released

After your patch:

> [  171.943721] pcieport 0000:64:02.0: EDR: EDR event received
> [  171.974078] pcieport 0000:64:02.0: DPC: containment event, status:0x1f07 source:0x0000
> [  171.974084] pcieport 0000:64:02.0: DPC: RP PIO error detected
> [  171.974086] pcieport 0000:64:02.0: DPC: rp_pio_status: 0x00000000, rp_pio_mask: 0x00000303
> [  171.974092] pcieport 0000:64:02.0: DPC: RP PIO severity=0x00010000, syserror=0x00000000, exception=0x00000000
> [  171.974095] pcieport 0000:64:02.0: DPC: TLP Header: 0x00000002 0xfc023eff 0xbf5fffe0 0x00000000
> [  171.974105] nvme nvme0: frozen state error detected, reset controller
> [  171.992269] nvme nvme1: frozen state error detected, reset controller
> [  172.006241] nvme nvme2: frozen state error detected, reset controller
> [  172.020233] nvme nvme3: frozen state error detected, reset controller
> [  172.038237] mpt3sas_cm0: PCI error: detected callback, state(2)!!
> [  172.205497] nvme nvme0: restart after slot reset
> [  172.205747] nvme nvme1: restart after slot reset
> [  172.206196] nvme nvme2: restart after slot reset
> [  172.206627] nvme nvme3: restart after slot reset
> [  172.208281] mpt3sas_cm0: PCI error: slot reset callback!!
> [  172.208361] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (15845080 kB)
...(cutting a lot of mpt3sas informational messages)...
> [  172.368391] mpt3sas_cm0: scan devices: complete
> [  174.553148] nvme nvme1: 8/0/0 default/read/poll queues
> [  174.554573] mpt3sas_cm0: PCI error: resume callback!!
> [  174.554980] pcieport 0000:64:02.0: AER: device recovery successful


