Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAB3DF5E8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbhHCTpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbhHCTpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 15:45:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E6C061757;
        Tue,  3 Aug 2021 12:45:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o10so540250ljp.0;
        Tue, 03 Aug 2021 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Cay6YoFmsYm9bibxR7vQIY5pPorcz17c0wVTjuRKmHs=;
        b=RRab0EaMy7zLl1WbA/6mfrh3crcjKXT/sjXctHY/syJ9pWpTvKDPP92kMLmL9mbNn8
         anzlgRnpJVoZM0e6hB+sWNCHqouAgOXjDWViyc17ex0BRRQekhuYqcmJQqv6LEO8NjCy
         uHIgtCDEJ7sBWBvBh4mryAQpdKi1D92yr+emxOp14wi0ub5t1kShh6J+48ZxefV75rRY
         WkxY3zJGqtVpPtUhhU/q4EpQGq3bsR0nFTitgDgYirA3NTkcsoxXp+sCH0rpGXk0y6tc
         BallIt4LoskmLbj+T306y/Zfep2E9G2txH5ol7SqjMaNAx1gU2lDz0SAhFXGEeWUwtUU
         ayhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Cay6YoFmsYm9bibxR7vQIY5pPorcz17c0wVTjuRKmHs=;
        b=Ks/3oxQ8VioFaEI01Q9d9gEzOQNb27zGdOh/ZdBPClbTdQQNTEThQ0QV07qtxCQBbB
         AeP0L6yQw3ywdywyG41B8p0EPJdp5ux2tGiBzWH+70NJrdkjZlHkB0h2Il9QUPfwoUnO
         /7CeZO5Bg3VW3nEZC10G98BJqUL2LZd90xhzN3vPNz+6fvZF5/7AkZMNZRTVt5F+O6Nh
         pYStbJixVIUlyrOfaJYiIFK58n4oxCuu3vd2b6d2bA0mmqaDI9bdU6wb0LAADkhiAwuA
         qCYImgktwELs7Ja9OnTbaMBUAXcqX+eAFQ9DP6KoV2EoeXxZCngujcxhnB9+qcV5UNCD
         gceg==
X-Gm-Message-State: AOAM5301n4ypFUIXyrKDEhGu9ctYQei7FvGqrSIpjHgXdhkcwcjfcjXx
        Vw6Tt43Reto5O+PccI0ujkiMEeMVNAzvCA==
X-Google-Smtp-Source: ABdhPJx6I4Que/YnCUl+zljAXoQOI2dN8649XErBhyE1ulWwbcazisHNxTL0RYkJtqS+jpGD8+jILg==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr15522229ljk.508.1628019935926;
        Tue, 03 Aug 2021 12:45:35 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id p5sm1331668lfo.254.2021.08.03.12.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 12:45:35 -0700 (PDT)
To:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: PCI DT regressions affecting Northstar (iproc driver)
Message-ID: <440bd70a-81c4-357d-9fb5-1f45fca17148@gmail.com>
Date:   Tue, 3 Aug 2021 21:45:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I normally stick to LTS kernel releases and I just late-found 2
regressions while switching from 5.4 to the 5.10.

The whole thing is about Broadcom's Northstar platform and a bit quirky
iproc PCI driver (precisely: pcie-iproc-bcma part). The iproc PCI driver
supports both: platform device (based on DT) and bcma device.

Northstar support uses a mix of DT and bcma. The later is a bus with
EEPROM containing platform devices info. Its history is decades old and
that design comes from pre-DT times. In any case:
1. Northstar PCI controllers are bcma devices with minimalistic DT nodes
2. Everything worked great with 5.4 and quite OK with 5.8

Reference:
* arch/arm/boot/dts/bcm5301x.dtsi
* drivers/pci/controller/pcie-iproc-bcma.c

Could you look at those problems and check if it's possible to fix them
in some easy way (without a big refactoring) please?

**********

The first regression results in "no space for" and "failed to assign"
info-errors like:
[    1.353173] pci 0000:00:00.0: BAR 8: no space for [mem size 0x00c00000]
[    1.359816] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]

They don't seem to cause any real harm, PCI devices are still visible.

It is caused by the:

commit 7ef1c871da16125ae58db13716fe82795dcbe3e8
Author: Rob Herring <robh@kernel.org>
Date:   Mon Oct 28 11:32:38 2019 -0500

     PCI: iproc: Use pci_parse_request_of_pci_ranges()

     Convert the iProc host bridge to use the common
     pci_parse_request_of_pci_ranges().

     There's no need to assign the resources to a temporary list, so just use
     bridge->windows directly.

     Signed-off-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
     Reviewed-by: Andrew Murray <andrew.murray@arm.com>
     Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
     Cc: Bjorn Helgaas <bhelgaas@google.com>
     Cc: Ray Jui <rjui@broadcom.com>
     Cc: Scott Branden <sbranden@broadcom.com>
     Cc: bcm-kernel-feedback-list@broadcom.com

**********

The second regression results in "No bus range found for" errors like:
[    1.096377] pcie_iproc_bcma bcma0:7: host bridge /axi@18000000/pcie@12000 ranges:
[    1.103954] pcie_iproc_bcma bcma0:7:   No bus range found for /axi@18000000/pcie@12000, using [bus 00-ff]

It results in not registering PCI bus at all.

Forwardtrace for that error:

iproc_pcie_bcma_probe()
devm_pci_alloc_host_bridge()
devm_of_pci_bridge_init()
pci_parse_request_of_pci_ranges()
devm_of_pci_get_host_bridge_resources()
of_pci_range_parser_init()
parser_init()
return -ENOENT;

It is caused by the :

commit 669cbc708122fc7a02282058a09f096200cee090
Author: Rob Herring <robh@kernel.org>
Date:   Tue Jul 21 20:25:13 2020 -0600

     PCI: Move DT resource setup into devm_pci_alloc_host_bridge()

     Now that pci_parse_request_of_pci_ranges() callers just setup
     pci_host_bridge.windows and dma_ranges directly and don't need the bus
     range returned, we can just initialize them when allocating the
     pci_host_bridge struct.

     With this, pci_parse_request_of_pci_ranges() becomes a static function.

     Link: https://lore.kernel.org/r/20200722022514.1283916-19-robh@kernel.org
     Signed-off-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
     Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
     Cc: Bjorn Helgaas <bhelgaas@google.com>

**********

7ef1c871da16~1
[    1.160172] pcie_iproc_bcma bcma0:7: link: UP
[    1.164661] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    1.170978] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[    1.177873] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.185835] pci 0000:00:00.0: [14e4:d612] type 01 class 0x060400
[    1.191878] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.201562] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.211257] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    1.221023] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    1.230796] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.240592] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.246702] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4c may corrupt adjacent RW1C bits
[    1.257090] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.266871] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.276557] pci_bus 0000:00: 1-byte config write to 0000:00:00.0 offset 0xc may corrupt adjacent RW1C bits
[    1.286238] PCI: bus0: Fast back to back transfers disabled
[    1.291828] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.299848] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.309740] pci 0000:01:00.0: [14e4:4365] type 00 class 0x028000
[    1.315818] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.322633] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.329441] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    1.336773] pci 0000:01:00.0: supports D1 D2
[    1.341625] PCI: bus1: Fast back to back transfers disabled
[    1.347223] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.353870] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.360532] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x08bfffff]
[    1.367341] pci 0000:00:00.0: BAR 9: assigned [mem 0x08c00000-0x08cfffff 64bit pref]
[    1.375118] pci 0000:01:00.0: BAR 2: assigned [mem 0x08000000-0x087fffff 64bit]
[    1.382459] pci 0000:01:00.0: BAR 4: assigned [mem 0x08c00000-0x08cfffff 64bit pref]
[    1.390237] pci 0000:01:00.0: BAR 0: assigned [mem 0x08800000-0x08807fff 64bit]
[    1.397566] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.402545] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x08bfffff]
[    1.409343] pci 0000:00:00.0:   bridge window [mem 0x08c00000-0x08cfffff 64bit pref]
[    1.540170] pcie_iproc_bcma bcma0:8: link: UP
[    1.544652] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    1.550967] pci_bus 0001:00: root bus resource [mem 0x20000000-0x27ffffff]
[    1.557861] pci_bus 0001:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.565826] pci 0001:00:00.0: [14e4:d612] type 01 class 0x060400
[    1.571915] pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
[    1.578596] PCI: bus0: Fast back to back transfers disabled
[    1.584208] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.592378] pci 0001:01:00.0: [14e4:4365] type 00 class 0x028000
[    1.598442] pci 0001:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.605276] pci 0001:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.612092] pci 0001:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    1.619420] pci 0001:01:00.0: supports D1 D2
[    1.624263] PCI: bus1: Fast back to back transfers disabled
[    1.629861] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    1.636525] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[    1.643175] pci 0001:00:00.0: BAR 8: assigned [mem 0x20000000-0x20bfffff]
[    1.649978] pci 0001:00:00.0: BAR 9: assigned [mem 0x20c00000-0x20cfffff 64bit pref]
[    1.657753] pci 0001:01:00.0: BAR 2: assigned [mem 0x20000000-0x207fffff 64bit]
[    1.665092] pci 0001:01:00.0: BAR 4: assigned [mem 0x20c00000-0x20cfffff 64bit pref]
[    1.672865] pci 0001:01:00.0: BAR 0: assigned [mem 0x20800000-0x20807fff 64bit]
[    1.680200] pci 0001:00:00.0: PCI bridge to [bus 01]
[    1.685175] pci 0001:00:00.0:   bridge window [mem 0x20000000-0x20bfffff]
[    1.691987] pci 0001:00:00.0:   bridge window [mem 0x20c00000-0x20cfffff 64bit pref]
[    1.820168] pcie_iproc_bcma bcma0:9: PHY or data link is INACTIVE!
[    1.826370] pcie_iproc_bcma bcma0:9: no PCIe EP device detected
[    1.832308] pcie_iproc_bcma bcma0:9: PCIe controller setup failed

7ef1c871da16
[    1.159737] pcie_iproc_bcma bcma0:7: link: UP
[    1.164214] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    1.170517] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.178474] pci 0000:00:00.0: [14e4:d612] type 01 class 0x060400
[    1.184517] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.194207] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.203900] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    1.213667] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    1.223440] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.233236] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.239347] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4c may corrupt adjacent RW1C bits
[    1.249724] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.259512] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.269202] pci_bus 0000:00: 1-byte config write to 0000:00:00.0 offset 0xc may corrupt adjacent RW1C bits
[    1.278882] PCI: bus0: Fast back to back transfers disabled
[    1.284473] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.292498] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.302387] pci 0000:01:00.0: [14e4:4365] type 00 class 0x028000
[    1.308449] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.315276] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.322091] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    1.329420] pci 0000:01:00.0: supports D1 D2
[    1.334283] PCI: bus1: Fast back to back transfers disabled
[    1.339889] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.346523] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.353173] pci 0000:00:00.0: BAR 8: no space for [mem size 0x00c00000]
[    1.359816] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]
[    1.366790] pci 0000:00:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[    1.374386] pci 0000:00:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[    1.382325] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00800000 64bit]
[    1.389470] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00800000 64bit]
[    1.396971] pci 0000:01:00.0: BAR 4: no space for [mem size 0x00100000 64bit pref]
[    1.404559] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x00100000 64bit pref]
[    1.412497] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00008000 64bit]
[    1.419646] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00008000 64bit]
[    1.427146] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.549735] pcie_iproc_bcma bcma0:8: link: UP
[    1.554214] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    1.560519] pci_bus 0001:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.568474] pci 0001:00:00.0: [14e4:d612] type 01 class 0x060400
[    1.574563] pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
[    1.581269] PCI: bus0: Fast back to back transfers disabled
[    1.586865] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.595034] pci 0001:01:00.0: [14e4:4365] type 00 class 0x028000
[    1.601111] pci 0001:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.607925] pci 0001:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.614747] pci 0001:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    1.622081] pci 0001:01:00.0: supports D1 D2
[    1.626921] PCI: bus1: Fast back to back transfers disabled
[    1.632533] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    1.639170] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[    1.645828] pci 0001:00:00.0: BAR 8: no space for [mem size 0x00c00000]
[    1.652462] pci 0001:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]
[    1.659435] pci 0001:00:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[    1.667030] pci 0001:00:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[    1.674970] pci 0001:01:00.0: BAR 2: no space for [mem size 0x00800000 64bit]
[    1.682122] pci 0001:01:00.0: BAR 2: failed to assign [mem size 0x00800000 64bit]
[    1.689620] pci 0001:01:00.0: BAR 4: no space for [mem size 0x00100000 64bit pref]
[    1.697206] pci 0001:01:00.0: BAR 4: failed to assign [mem size 0x00100000 64bit pref]
[    1.705143] pci 0001:01:00.0: BAR 0: no space for [mem size 0x00008000 64bit]
[    1.712305] pci 0001:01:00.0: BAR 0: failed to assign [mem size 0x00008000 64bit]
[    1.719813] pci 0001:00:00.0: PCI bridge to [bus 01]
[    1.849735] pcie_iproc_bcma bcma0:9: PHY or data link is INACTIVE!
[    1.855938] pcie_iproc_bcma bcma0:9: no PCIe EP device detected
[    1.861884] pcie_iproc_bcma bcma0:9: PCIe controller setup failed

669cbc708122~1
[    1.208125] pcie_iproc_bcma bcma0:7: link: UP
[    1.212626] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    1.218951] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.226912] pci 0000:00:00.0: [14e4:d612] type 01 class 0x060400
[    1.232962] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.242662] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.252360] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    1.262136] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    1.271918] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.281724] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.287837] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4c may corrupt adjacent RW1C bits
[    1.298272] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.308040] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.317743] pci_bus 0000:00: 1-byte config write to 0000:00:00.0 offset 0xc may corrupt adjacent RW1C bits
[    1.327435] PCI: bus0: Fast back to back transfers disabled
[    1.333033] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.341064] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    1.350969] pci 0000:01:00.0: [14e4:4365] type 00 class 0x028000
[    1.357038] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.363872] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.370703] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    1.378031] pci 0000:01:00.0: supports D1 D2
[    1.408606] PCI: bus1: Fast back to back transfers disabled
[    1.414208] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.420891] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.427540] pci 0000:00:00.0: BAR 8: no space for [mem size 0x00c00000]
[    1.434188] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]
[    1.441180] pci 0000:00:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[    1.448774] pci 0000:00:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[    1.456713] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00800000 64bit]
[    1.463877] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00800000 64bit]
[    1.471386] pci 0000:01:00.0: BAR 4: no space for [mem size 0x00100000 64bit pref]
[    1.478984] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x00100000 64bit pref]
[    1.486921] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00008000 64bit]
[    1.494075] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00008000 64bit]
[    1.501581] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.618123] pcie_iproc_bcma bcma0:8: link: UP
[    1.622607] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    1.628926] pci_bus 0001:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.636887] pci 0001:00:00.0: [14e4:d612] type 01 class 0x060400
[    1.642985] pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
[    1.649708] PCI: bus0: Fast back to back transfers disabled
[    1.655304] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.663478] pci 0001:01:00.0: [14e4:4365] type 00 class 0x028000
[    1.669567] pci 0001:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.676382] pci 0001:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.683215] pci 0001:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    1.690560] pci 0001:01:00.0: supports D1 D2
[    1.718605] PCI: bus1: Fast back to back transfers disabled
[    1.724202] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    1.730884] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[    1.737533] pci 0001:00:00.0: BAR 8: no space for [mem size 0x00c00000]
[    1.744178] pci 0001:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]
[    1.751172] pci 0001:00:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[    1.758767] pci 0001:00:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[    1.766708] pci 0001:01:00.0: BAR 2: no space for [mem size 0x00800000 64bit]
[    1.773869] pci 0001:01:00.0: BAR 2: failed to assign [mem size 0x00800000 64bit]
[    1.781378] pci 0001:01:00.0: BAR 4: no space for [mem size 0x00100000 64bit pref]
[    1.788985] pci 0001:01:00.0: BAR 4: failed to assign [mem size 0x00100000 64bit pref]
[    1.796923] pci 0001:01:00.0: BAR 0: no space for [mem size 0x00008000 64bit]
[    1.804082] pci 0001:01:00.0: BAR 0: failed to assign [mem size 0x00008000 64bit]
[    1.811593] pci 0001:00:00.0: PCI bridge to [bus 01]
[    1.928122] pcie_iproc_bcma bcma0:9: PHY or data link is INACTIVE!
[    1.934324] pcie_iproc_bcma bcma0:9: no PCIe EP device detected
[    1.940271] pcie_iproc_bcma bcma0:9: PCIe controller setup failed

669cbc708122
[    1.096377] pcie_iproc_bcma bcma0:7: host bridge /axi@18000000/pcie@12000 ranges:
[    1.103954] pcie_iproc_bcma bcma0:7:   No bus range found for /axi@18000000/pcie@12000, using [bus 00-ff]
[    1.113593] pcie_iproc_bcma: probe of bcma0:7 failed with error -12
[    1.120019] pcie_iproc_bcma bcma0:8: host bridge /axi@18000000/pcie@13000 ranges:
[    1.127538] pcie_iproc_bcma bcma0:8:   No bus range found for /axi@18000000/pcie@13000, using [bus 00-ff]
[    1.137172] pcie_iproc_bcma: probe of bcma0:8 failed with error -12
[    1.258092] pcie_iproc_bcma bcma0:9: PHY or data link is INACTIVE!
[    1.264296] pcie_iproc_bcma bcma0:9: no PCIe EP device detected
[    1.270250] pcie_iproc_bcma bcma0:9: PCIe controller setup failed
