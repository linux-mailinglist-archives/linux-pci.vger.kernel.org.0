Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADF6636AB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 02:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAJB01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 20:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjAJB00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 20:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C74395E0;
        Mon,  9 Jan 2023 17:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 093D0B810A8;
        Tue, 10 Jan 2023 01:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53197C433D2;
        Tue, 10 Jan 2023 01:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673313982;
        bh=S4EjMdqwK9j3qxqv4TxOuEjQbd4l+HYkEkscPvxhnXA=;
        h=Date:From:To:Cc:Subject:From;
        b=bglkjI67W+3YLskfKubFfMmA5UgWkqkO5U3eaKMW2JEbvfPNJwJp2EPRS2XZ+ViqA
         ayv+1BqCIPtEhByPn39JDS2ZgC6K5+kurJ/4mJ3HlOxTlXQFvQbRYDVo00aff79A8B
         AWhPuV/yj44m84MeTBoT9jpI83ac3SSGaZpi9nfc4IyTbuShaBnv4GDQoAw1+XoFBm
         3XJqImpLN4/sYfolV15iLXJzDq0bKHgklR+gkigMOpfhpF9OrDUGKIZOQ2x7xCYqDf
         76T9PeP1uPUFT+h6CnESEFkVt2hvXQIVUexY7kDm1WDCnjhWgcdk08jmbs8m9eJZl5
         mPQYx/2w91ioA==
Date:   Mon, 9 Jan 2023 19:26:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Frederick Zhang <frederick888@tsundere.moe>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: [Bug 216863] ThinkPad X1 Extreme Gen 5: PCIe Bus Error:
 severity=Corrected, type=Data Link Layer, (Transmitter ID) after resuming
 from sleep
Message-ID: <20230110012620.GA1460882@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=216863

Frederick reports:

> I recently purchased a Thunderbolt 4 dock (CalDigit TS4) and started
> having millions of these warnings in my logs after resuming from sleep.
> I previously didn't have any Thunderbolt peripherals. The device is a
> ThinkPad X1 Extreme Gen 5 (BIOS 1.12 N3JET28W, EC 1.08 N3JHT21W).
> 
> Dec 29 18:51:05 FredArch systemd[1]: Starting System Suspend...
> Dec 29 18:51:05 FredArch systemd-sleep[31007]: Entering sleep state 'suspend'...
> Dec 29 18:51:05 FredArch kernel: PM: suspend entry (s2idle)
> Dec 29 18:51:07 FredArch kernel: Filesystems sync: 1.566 seconds
> Dec 29 18:52:30 FredArch kernel: Freezing user space processes ... (elapsed 0.001 seconds) done.
> Dec 29 18:52:30 FredArch kernel: OOM killer disabled.
> Dec 29 18:52:30 FredArch kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> Dec 29 18:52:30 FredArch kernel: printk: Suspending console(s) (use no_console_suspend to debug)
> Dec 29 18:52:30 FredArch kernel: ACPI: EC: interrupt blocked
> Dec 29 18:52:30 FredArch kernel: ACPI: EC: interrupt unblocked
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:21:01.0
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:   device [8086:1136] error status/mask=00001100/00002000
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [ 8] Rollover
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [12] Timeout
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0: AER:   Error of this Agent is reported first
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:23:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:23:00.0:   device [8086:0b26] error status/mask=00001000/00002000
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:23:00.0:    [12] Timeout
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:00:1d.0: AER: Corrected error received: 0000:21:01.0
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:   device [8086:1136] error status/mask=00001100/00002000
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [ 8] Rollover
> Dec 29 18:52:30 FredArch kernel: pcieport 0000:21:01.0:    [12] Timeout

And disabling ASPM seems to have some effect:

> It happened every time after resuming from sleep. pcie_aspm=off solved
> the issue for me.

But also broke other stuff:

> I just realised that pcie_aspm=off broke most of my dock's functions. I
> still had Ethernet but wake-on-lan stopped working. The dock's
> Thunderbolt ports, USB Type-A/C data ports, SD card slots all stopped
> working too (no logs at all after plugging in things).
> 
> Then I tested pcie_aspm.policy=performance. The dock started working
> again but the warning logs were also back.
> 
> Also tried applying quirk_disable_aspm_l0s_l1 on the Thunderbolt bridges
> but unfortunately I still had the logs.
