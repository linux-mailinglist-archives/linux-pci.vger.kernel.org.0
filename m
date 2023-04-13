Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB36E1084
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDMO67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDMO66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 10:58:58 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6072A8;
        Thu, 13 Apr 2023 07:58:56 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id qh25so4948175qvb.1;
        Thu, 13 Apr 2023 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681397935; x=1683989935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bi0ZXm2Z4hEXGu7AXo9I7wdFqHb+LKKssxUJNJqQof4=;
        b=SE3cEYIfy8hcWC7ZEnRIKIXPAdbW032ZvvJsErhXn+8adREO8f2fLkKFUgp8S8sL3O
         dglAVbWiKYif3OfGZ+ktWe6pDGLHeD4GBi4NX1188rfR+iz2StNFIG346gF1TQh58eL5
         fArzTEmUDjhHsqWsJmUBbUJJbwv480zxAE+vcK9qOECq6Y4bD2DzKHHQ8qoKyGUlWAx6
         YOrUibmkP0Cltdlt9rcX+aWayzE43X5EifeFoJQG6C4S7b2rt8GPDZyjEc/OVfB4zwNc
         lMJN9Fkw1VhPVFSPgZGLlCOqDcvDE/pxrxX8/Sw4DpzuPZtswW/wrTze0TcPFnTWhUAO
         aX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681397935; x=1683989935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bi0ZXm2Z4hEXGu7AXo9I7wdFqHb+LKKssxUJNJqQof4=;
        b=fVN61Xm6ZMTFMpnr8ufzwtHfxLkzfymsDVO2I3fiKftDlOmiCxFUDeK9alaYO6si6z
         s3wLSmc8Rl5HRDAEcuLLPFdESmCqTWQbvhBIyUKGxapDhBMvCzzaPerHlfXvHR0T0FfR
         5Mf7qBYp8NfkXhaEQMxZwFX8XxAJitLGfjzCULz5kORRz0CEYqvF+JY/V57FrGxmR5N7
         Lo0t4IoqzwEZbK5DX/IB/MhOoNOgRfa38HnIBtUBSOMm2rHd+RMYFjpGX8KEfG66TW6u
         jP0Wy/qMjAXYoYLVv/VD3jHVA2w7U85P1NjEapP9y69mUzqAXKtVSRxg076/exBoxNJ+
         yxxQ==
X-Gm-Message-State: AAQBX9fEvjXuItHAVRpFV00w0LuvLth+08PkxIFig04vD/UgGcBMPoKH
        qtX+wkTVjWL/s5+xq+oJVB8=
X-Google-Smtp-Source: AKy350ZPWCS7Da7sP9dwBbn1kRK1VZHZUMhhTx3bnSjdl6WRWMTcZ1GoyQudNKhIZWGVhlp9Qd8HZw==
X-Received: by 2002:a05:6214:20e2:b0:5a5:ba90:3b5f with SMTP id 2-20020a05621420e200b005a5ba903b5fmr3407667qvk.14.1681397935280;
        Thu, 13 Apr 2023 07:58:55 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id b7-20020a0cfb47000000b005ef49a5a3e6sm483173qvq.40.2023.04.13.07.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 07:58:54 -0700 (PDT)
Message-ID: <ff2c73b7-3654-d871-de8b-7180c123f05d@gmail.com>
Date:   Thu, 13 Apr 2023 07:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
To:     Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230413143935.pmbyjk2boxl3rwne@mraw.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/13/2023 7:39 AM, Cyril Brulebois wrote:
> Hi Jim,
> 
> Jim Quinlan <jim2101024@gmail.com> (2023-04-11):
>> […]
>> This property has already been in use by Raspian Linux, but this
>> immplementation adds more details and discerns between (a) and (b)
>    ^^^^^^^^^^^^^^^
>    implementation
> 
>> automatically.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> 
> Sorry, it seems like my initial tests with v1 (applied on top of
> v6.3-rc5-137-gf2afccfefe7b) weren't thorough enough, and I'm seeing the
> same problems with v2 (applied on top of v6.3-rc6-46-gde4664485abb):
>   - same setup as in https://bugzilla.kernel.org/show_bug.cgi?id=217276
>   - the kernel panic is indeed gone;
>   - a USB keyboard connected on that SupaHub PCIe-to-multiple-USB adapter
>     isn't seen by the kernel;
>   - a USB memory stick connected on the same adapter isn't seen by the
>     kernel either;
>   - of course both USB devices are confirmed to work fine if they're
>     plugged directly on the CM4's USB ports.
> 
> Logs with v2:
> 
>      root@cm4:~# dmesg|grep -i pci
>      [    0.610997] PCI: CLS 0 bytes, default 64
>      [    1.664886] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>      [    1.672083] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 ranges:
>      [    1.679125] brcm-pcie fd500000.pcie:   No bus range found for /scb/pcie@7d500000, using [bus 00-ff]
>      [    1.688279] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ffffff -> 0x00f8000000
>      [    1.696463] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x00ffffffff -> 0x0400000000
>      [    1.705282] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
>      [    1.711629] pci_bus 0000:00: root bus resource [bus 00-ff]
>      [    1.717172] pci_bus 0000:00: root bus resource [mem 0x600000000-0x603ffffff] (bus address [0xf8000000-0xfbffffff])
>      [    1.727653] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
>      [    1.733768] pci 0000:00:00.0: PME# supported from D0 D3hot
>      [    1.740235] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>      [    1.855826] brcm-pcie fd500000.pcie: CLKREQ# ignored; no ASPM
>      [    1.863666] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
>      [    1.870115] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
>      [    1.876205] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>      [    1.883177] pci 0000:01:00.0: PME# supported from D0 D3hot
>      [    1.888881] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>      [    1.895581] pci 0000:00:00.0: BAR 14: assigned [mem 0x600000000-0x6000fffff]
>      [    1.902707] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x600001fff 64bit]
>      [    1.910279] pci 0000:00:00.0: PCI bridge to [bus 01]
>      [    1.915293] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x6000fffff]
>      [    1.922412] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>      [    1.928633] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
>      [    1.934609] pcieport 0000:00:00.0: AER: enabled with IRQ 23
>      [    1.940340] pci 0000:01:00.0: enabling device (0000 -> 0002)
>      [    6.946090] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x1801
>      [    6.954026] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0x968 took 4896180 usecs
> 
> Please let me know what I can do to help.

Could you please attach your .config so we can check a few things?
-- 
Florian
