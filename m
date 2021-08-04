Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D903DFB8D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhHDGt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 02:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhHDGt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 02:49:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DDBC0613D5
        for <linux-pci@vger.kernel.org>; Tue,  3 Aug 2021 23:49:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a26so2670147lfr.11
        for <linux-pci@vger.kernel.org>; Tue, 03 Aug 2021 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Z//ILyS2rYRU1sMmJBk9JjSZ11RdDixpEfZGLDWmq0=;
        b=Kihx5BSYw+f362iZ0soVwUhtauSGKXx21eZss30uVGwKuf8rJxhgZzbYhM/57Gtd6Z
         gmzAjGKJaBmkR6ewnMzCWCHRrUnc1KQAcadmDRw6VpNQSRBRxhWbhrQjMD6syLcRZCDu
         6OyHyMs7kxlKOQIb05RuBRydvJZECmBRcez84mbT4/FJ6y9mUrcZT2cwMKuzMjwZYKKz
         vbuFEvTEd2Qk5dEdJEA+oUJ8GMIS6qZ8074pG1A54+bbTheijuaNN+A9h8z2L1PlnxNy
         X1edVZ21+d3vWt5QgX9vGY5/Qbv6IacTWjKPgmMaql3lenIKgM5HzvtC4+vAwPIvgGjc
         OOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Z//ILyS2rYRU1sMmJBk9JjSZ11RdDixpEfZGLDWmq0=;
        b=uOMuxlJFWR8KmJaD9YNzVV+TgDGxTl+zbdh3QixmzJ6NwVKcUA7zW4luYeY1/10d54
         wYDn9ytrkil5j/Cy4UtyRhNjHFCmwJbHd5S1akjSGUxZ2EJoR4ovMl+XQR5hM1VEryMv
         vpONGs5jWYySsR1tbjGBeVnmPpxivqdUYyWc75nTnYWPPlP3MRAyHQHT2LtK/E3iL5XJ
         r/ri84uSntE/BPFKr7aAvWOYFkbHJNk5uC8C098XSRLQI/1OHHA8PAAtZbpFaxjp56ui
         UUii1pmHSEcpPfCvN+Wl3JrLzw58cAmdKbdLZAIWgCWggoQvYKYNWKn0DN4yQYZkeRku
         wCmQ==
X-Gm-Message-State: AOAM5329zrCaY9uDBeiVHAKsl3J1EimN/k54pJ3kSqUBcjL59nKOzPPH
        aJkxtE8ROK+YWre6bC8r55I=
X-Google-Smtp-Source: ABdhPJwfUAZHh5d7bsE+cvqZGfjG/fgqeXgJyp+cCu0hsY0KCqfmvlznTtf4Y5kxxS8GAOe5mUVHnQ==
X-Received: by 2002:ac2:41c5:: with SMTP id d5mr19612811lfi.313.1628059753626;
        Tue, 03 Aug 2021 23:49:13 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id t67sm107622lff.147.2021.08.03.23.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 23:49:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] PCI: iproc: Fix BCMA probe resource handling
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <20210803215656.3803204-1-robh@kernel.org>
 <20210803215656.3803204-2-robh@kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <54b40b27-76d6-a6d3-2295-7df699956cf4@gmail.com>
Date:   Wed, 4 Aug 2021 08:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210803215656.3803204-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.08.2021 23:56, Rob Herring wrote:
> In commit 7ef1c871da16 ("PCI: iproc: Use
> pci_parse_request_of_pci_ranges()"), calling
> devm_request_pci_bus_resources() was dropped from the common iProc
> probe code, but is still needed for BCMA bus probing. Without it, there
> will be lots of warnings like this:
> 
> pci 0000:00:00.0: BAR 8: no space for [mem size 0x00c00000]
> pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]
> 
> Add back calling devm_request_pci_bus_resources() and adding the
> resources to pci_host_bridge.windows for BCMA bus probe.
> 
> Fixes: 7ef1c871da16 ("PCI: iproc: Use pci_parse_request_of_pci_ranges()")
> Reported-by: Rafał Miłecki <zajec5@gmail.com>
> Cc: Srinath Mannam <srinath.mannam@broadcom.com>
> Cc: Roman Bacik <roman.bacik@broadcom.com>
> Cc: Bharat Gooty <bharat.gooty@broadcom.com>
> Cc: Abhishek Shah <abhishek.shah@broadcom.com>
> Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> Cc: Ray Jui <ray.jui@broadcom.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

It works great again, thank you!

Tested-by: Rafał Miłecki <rafal@milecki.pl>

[    6.624535] pcie_iproc_bcma bcma0:7: host bridge /axi@18000000/pcie@12000 ranges:
[    6.632048] pcie_iproc_bcma bcma0:7:   No bus range found for /axi@18000000/pcie@12000, using [bus 00-ff]
[    6.641661] OF: /axi@18000000/pcie@12000: Missing device_type
[    6.647432] pcie_iproc_bcma bcma0:7: non-prefetchable memory resource required
[    6.783993] pcie_iproc_bcma bcma0:7: link: UP
[    6.788471] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    6.794784] pci_bus 0000:00: root bus resource [bus 00-ff]
[    6.800288] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[    6.807216] pci 0000:00:00.0: [14e4:d612] type 01 class 0x060400
[    6.813242] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    6.822927] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    6.832620] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    6.842387] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x1c may corrupt adjacent RW1C bits
[    6.852162] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    6.861951] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    6.868065] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4c may corrupt adjacent RW1C bits
[    6.878472] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    6.888259] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    6.897947] pci_bus 0000:00: 1-byte config write to 0000:00:00.0 offset 0xc may corrupt adjacent RW1C bits
[    6.907634] PCI: bus0: Fast back to back transfers disabled
[    6.913224] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    6.921255] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    6.931146] pci 0000:01:00.0: [14e4:4365] type 00 class 0x028000
[    6.937212] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    6.944032] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    6.950839] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    6.958167] pci 0000:01:00.0: supports D1 D2
[    6.963074] PCI: bus1: Fast back to back transfers disabled
[    6.968693] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    6.975354] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x08bfffff]
[    6.982159] pci 0000:00:00.0: BAR 9: assigned [mem 0x08c00000-0x08cfffff 64bit pref]
[    6.989931] pci 0000:01:00.0: BAR 2: assigned [mem 0x08000000-0x087fffff 64bit]
[    6.997275] pci 0000:01:00.0: BAR 4: assigned [mem 0x08c00000-0x08cfffff 64bit pref]
[    7.005046] pci 0000:01:00.0: BAR 0: assigned [mem 0x08800000-0x08807fff 64bit]
[    7.012377] pci 0000:00:00.0: PCI bridge to [bus 01]
[    7.017354] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x08bfffff]
[    7.024162] pci 0000:00:00.0:   bridge window [mem 0x08c00000-0x08cfffff 64bit pref]
[    7.032111] pcie_iproc_bcma bcma0:8: host bridge /axi@18000000/pcie@13000 ranges:
[    7.039647] pcie_iproc_bcma bcma0:8:   No bus range found for /axi@18000000/pcie@13000, using [bus 00-ff]
[    7.049252] pcie_iproc_bcma bcma0:8: non-prefetchable memory resource required
[    7.183989] pcie_iproc_bcma bcma0:8: link: UP
[    7.188463] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    7.194776] pci_bus 0001:00: root bus resource [bus 00-ff]
[    7.200280] pci_bus 0001:00: root bus resource [mem 0x20000000-0x27ffffff]
[    7.207206] pci 0001:00:00.0: [14e4:d612] type 01 class 0x060400
[    7.213267] pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
[    7.220014] PCI: bus0: Fast back to back transfers disabled
[    7.225619] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.233772] pci 0001:01:00.0: [14e4:4365] type 00 class 0x028000
[    7.239834] pci 0001:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    7.246659] pci 0001:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    7.253469] pci 0001:01:00.0: reg 0x20: [mem 0x00000000-0x000fffff 64bit pref]
[    7.260805] pci 0001:01:00.0: supports D1 D2
[    7.265717] PCI: bus1: Fast back to back transfers disabled
[    7.271311] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    7.277970] pci 0001:00:00.0: BAR 8: assigned [mem 0x20000000-0x20bfffff]
[    7.284778] pci 0001:00:00.0: BAR 9: assigned [mem 0x20c00000-0x20cfffff 64bit pref]
[    7.292546] pci 0001:01:00.0: BAR 2: assigned [mem 0x20000000-0x207fffff 64bit]
[    7.299887] pci 0001:01:00.0: BAR 4: assigned [mem 0x20c00000-0x20cfffff 64bit pref]
[    7.307670] pci 0001:01:00.0: BAR 0: assigned [mem 0x20800000-0x20807fff 64bit]
[    7.315016] pci 0001:00:00.0: PCI bridge to [bus 01]
[    7.319995] pci 0001:00:00.0:   bridge window [mem 0x20000000-0x20bfffff]
[    7.326807] pci 0001:00:00.0:   bridge window [mem 0x20c00000-0x20cfffff 64bit pref]
[    7.334761] pcie_iproc_bcma bcma0:9: host bridge /axi@18000000/pcie@14000 ranges:
[    7.342279] pcie_iproc_bcma bcma0:9:   No bus range found for /axi@18000000/pcie@14000, using [bus 00-ff]
[    7.351896] pcie_iproc_bcma bcma0:9: non-prefetchable memory resource required
[    7.483989] pcie_iproc_bcma bcma0:9: PHY or data link is INACTIVE!
[    7.490184] pcie_iproc_bcma bcma0:9: no PCIe EP device detected
