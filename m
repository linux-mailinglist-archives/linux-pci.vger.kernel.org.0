Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8126D6639C1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 08:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjAJHNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 02:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjAJHNf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 02:13:35 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4694564B;
        Mon,  9 Jan 2023 23:13:33 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aefa0.dynamic.kabel-deutschland.de [95.90.239.160])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A6C6960293A85;
        Tue, 10 Jan 2023 08:13:30 +0100 (CET)
Message-ID: <db100b8a-b27e-af17-1095-420dca7884e6@molgen.mpg.de>
Date:   Tue, 10 Jan 2023 08:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Bug 216863] ThinkPad X1 Extreme Gen 5: PCIe Bus Error:
 severity=Corrected, type=Data Link Layer, (Transmitter ID) after resuming
 from sleep
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Frederick Zhang <frederick888@tsundere.moe>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
References: <20230110012620.GA1460882@bhelgaas>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230110012620.GA1460882@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Cc: +Mark]

Am 10.01.23 um 02:26 schrieb Bjorn Helgaas:
> https://bugzilla.kernel.org/show_bug.cgi?id=216863
> 
> Frederick reports:
> 
>> I recently purchased a Thunderbolt 4 dock (CalDigit TS4) and started
>> having millions of these warnings in my logs after resuming from sleep.
>> I previously didn't have any Thunderbolt peripherals. The device is a
>> ThinkPad X1 Extreme Gen 5 (BIOS 1.12 N3JET28W, EC 1.08 N3JHT21W).
>>
>> Dec 29 18:51:05 FredArch systemd[1]: Starting System Suspend...
>> Dec 29 18:51:05 FredArch systemd-sleep[31007]: Entering sleep state 'suspend'...
>> Dec 29 18:51:05 FredArch kernel: PM: suspend entry (s2idle)
>> Dec 29 18:51:07 FredArch kernel: Filesystems sync: 1.566 seconds
>> Dec 29 18:52:30 FredArch kernel: Freezing user space processes ... (elapsed 0.001 seconds) done.
>> Dec 29 18:52:30 FredArch kernel: OOM killer disabled.
>> Dec 29 18:52:30 FredArch kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> Dec 29 18:52:30 FredArch kernel: printk: Suspending console(s) (use no_console_suspend to debug)
>> Dec 29 18:52:30 FredArch kernel: ACPI: EC: interrupt blocked
>> Dec 29 18:52:30 FredArch kernel: ACPI: EC: interrupt unblocked
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:21:01.0
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:   device [8086:1136] error status/mask=00001100/00002000
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [ 8] Rollover
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [12] Timeout
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0: AER:   Error of this Agent is reported first
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:23:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:23:00.0:   device [8086:0b26] error status/mask=00001000/00002000
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:23:00.0:    [12] Timeout
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:00:1d.0: AER: Corrected error received: 0000:21:01.0
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:   device [8086:1136] error status/mask=00001100/00002000
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [ 8] Rollover
>> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [12] Timeout
> 
> And disabling ASPM seems to have some effect:
> 
>> It happened every time after resuming from sleep. pcie_aspm=off solved
>> the issue for me.
> 
> But also broke other stuff:
> 
>> I just realised that pcie_aspm=off broke most of my dock's functions. I
>> still had Ethernet but wake-on-lan stopped working. The dock's
>> Thunderbolt ports, USB Type-A/C data ports, SD card slots all stopped
>> working too (no logs at all after plugging in things).
>>
>> Then I tested pcie_aspm.policy=performance. The dock started working
>> again but the warning logs were also back.
>>
>> Also tried applying quirk_disable_aspm_l0s_l1 on the Thunderbolt bridges
>> but unfortunately I still had the logs.
