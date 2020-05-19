Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50A1D9D9A
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgESRMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 13:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 13:12:06 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 May 2020 10:12:06 PDT
Received: from galileo.doth.eu (unknown [IPv6:2a01:4f8:a0:9e00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDFC08C5C0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 10:12:06 -0700 (PDT)
From:   Klaus Doth <kdlnx@doth.eu>
Subject: Possible bug in drivers/misc/cardreader/rtsx_pcr.c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, helgaas@kernel.org,
        linux-pci@vger.kernel.org
Autocrypt: addr=kdlnx@doth.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
Date:   Tue, 19 May 2020 19:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


As per the info from kernelnewbies IRC, I'm sending this also to the PCI
list.


There seems to be a bug in the power saving functions of the drivers
forthe RTS5260 PCIe Card Reader. Reading a card basically works, however
the first command issued to the card after the chip goes into power
saving fails. Due to the command timeout of 10 seconds inside the code,
every new access takes 10 seconds before it is processed.

It applies to at least PCI ID 10ec:5260 (rev 01), in case there are
several revsions of the chip.

I tested this on Kernel 5.3.0, 5.6.2, on a default Ubuntu 19.10, and a
custom Gentoo installation. Both versions, Ubuntu using 5.3.0 kernel,
and Gentoo using Kernel 5.6.2 have the same issue on both several Dell
Precision 7530 and 7540 laptops.


How to reproduce:

1) Insert SD-Card

2) Wait for one second or more where there is no access to the card

3) dd if=/dev/mmblk0p1 of=/dev/null

4) The dd command will hang for 10 seconds without transfering a single
byte, and then resume. After resuming, full (correct) transfer speed is
reached, until repeating from 2). The card can stay inserted for
repeated reproduction of issue.



The issue in detail:

If the rtsx_pci_idle_work() function is called, most of the time (like
90% or more), the next call to rtsx_pci_dma_transfer (i.e. reading or
writing to the card) runs into its timeout and fails.

After that, the next command always succeeds and data transfer from and
to the card is resumed and works correctly, until the next
rtsx_pic_idle_work() call is issued. After that the same timeout happens
again.

It does not matter if reading or writing occurs using a file system or
direct access to the block device using dd or similar.

After some testing it looks like something how the driver or the chip
itself handle leaving the power saving mode is wrong.

If I modify the rtsx_comm_pm_full_on() function and add msleep(1);
directly after the rtsx_disable_aspm(pcr); call, leaving power save
always works, and the card does not fail on the first command after
power saving mode.

This is likely not the proper solution to the issue, however I hope it
might help the current developer in identifying the correct solution. It
looks like something needs a little more time to wake up before issuing
a new DMA access.


If I can help further in any way in debugging this issue, let me know.



Attached are the changed function in rtsx_pcr.c, and kernel logs with
and without the modification:


--------------------------------------------------------------------------

Changed funcion in rtsx_pcr.c (lines 139 - 151)

static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
{
        struct rtsx_cr_option *option = &pcr->option;

        rtsx_disable_aspm(pcr);
+      msleep(1);

        if (option->ltr_enabled)
                rtsx_set_ltr_latency(pcr, option->ltr_active_latency);

        if (rtsx_check_dev_flag(pcr, LTR_L1SS_PWR_GATE_EN))
                rtsx_set_l1off_sub_cfg_d0(pcr, 1);
}


--------------------------------------------------------------------------

Kernel 5.6.2 without modification:

Apr  5 21:38:25 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 4
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: Switch card clock to 50MHz
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: Internal SSC clock:
100MHz (cur_clock = 100)
Apr  5 21:38:25 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_read_long_data: SD/MMC CMD 18, arg = 0x00002000
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff054000,
Len: 0x1000
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff055000,
Len: 0x1000
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff056000,
Len: 0x1000
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff057000,
Len: 0x1000
Apr  5 21:38:25 - kernel: rtsx_pci 0000:6f:00.0: --> rtsx_pci_idle_work
--- waiting for 10 seconds here
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: Timeout
(rtsx_pci_dma_transfer 538)
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 11
01 04 08 00 1f 00 08
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 10
0c 00 00 0b 00 7f 00
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 02
00 00 68 00 00 00 00
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04
41 00 04 0f 00 f0 00
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): 94
1f 52 ff 94 bb 66 aa
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9
aa aa aa 24 00 04 04
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: Timeout
(rtsx_pci_send_cmd 401)
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 11
01 04 08 00 1f 00 08
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 10
ff ff ff ff ff 7f 00
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 02
00 00 08 00 00 00 00
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04
41 00 04 0f 00 f0 00
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): 94
1f 52 ff 94 bb 66 aa
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9
aa aa aa 24 00 04 04
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
rtsx_pci_send_cmd error (err = -110)
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: CMD 18
0x00002000 error(-110)
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: Switch card clock to 50MHz
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: Internal SSC clock:
100MHz (cur_clock = 100)
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_send_cmd_get_rsp: SD/MMC CMD 13, arg = 0xe6240000
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0]
= 0x00400900
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 4
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: Switch card clock to 50MHz
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: Internal SSC clock:
100MHz (cur_clock = 100)
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_read_long_data: SD/MMC CMD 18, arg = 0x00002000
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff050000,
Len: 0x1000
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff051000,
Len: 0x1000
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff052000,
Len: 0x1000
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xff053000,
Len: 0x1000
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
Apr  5 21:38:35 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0]
= 0x00000b00
Apr  5 21:38:35 - kernel: rtsx_pci 0000:6f:00.0: --> rtsx_pci_idle_work

--------------------------------------------------------------------------

Kernel 5.6.2 with msleep(1); like described above:

For testing i tried to read some bytes from the SD card using DD. dd is
called every 2 seconds, and reads 10 bytes from the SD card. The delay
between the reads is inserted, to allow the driver to go into power
saving and issue a rtsx_pci_idle_work and trigger the issue.

The 2 seconds delay between rtsx_pci_idle_work and the next log entry
are therefore not from the issue itself, but from the way I read data.
Access in file system mode, dd and everything else does not experience
any noticeable delay anymore.


Apr  5 21:42:46 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 4
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: Switch card clock to 50MHz
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: Internal SSC clock:
100MHz (cur_clock = 100)
Apr  5 21:42:46 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_read_long_data: SD/MMC CMD 18, arg = 0x00002000
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffbbc000,
Len: 0x1000
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffbbd000,
Len: 0x1000
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffbbe000,
Len: 0x1000
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffbbf000,
Len: 0x1000
Apr  5 21:42:46 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
Apr  5 21:42:46 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0]
= 0x00000b00
Apr  5 21:42:46 - kernel: rtsx_pci 0000:6f:00.0: --> rtsx_pci_idle_work
-- no delay anymore
Apr  5 21:42:48 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 4
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: Switch card clock to 50MHz
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: Internal SSC clock:
100MHz (cur_clock = 100)
Apr  5 21:42:48 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_read_long_data: SD/MMC CMD 18, arg = 0x00002000
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffc3c000,
Len: 0x1000
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffc3d000,
Len: 0x1000
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffc3e000,
Len: 0x1000
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: DMA addr: 0xffc3f000,
Len: 0x1000
Apr  5 21:42:48 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
Apr  5 21:42:48 - kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0]
= 0x00000b00
Apr  5 21:42:48 - kernel: rtsx_pci 0000:6f:00.0: --> rtsx_pci_idle_work










