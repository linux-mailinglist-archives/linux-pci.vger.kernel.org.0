Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A75524E5D
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 15:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354316AbiELNfd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 09:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiELNfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 09:35:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE662380CD;
        Thu, 12 May 2022 06:35:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 137so4618323pgb.5;
        Thu, 12 May 2022 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eVexviibFE9k7seKsPhQiFZXzQDM3R9OHbyKQzrT/w=;
        b=p2T4rQb2RBzcB/BBUEpDTWXPWHK0XrE3Y9iUcRiSSIKGMgOGA8yNrhJFmsFL/ARXef
         UhpBFqcQp1yPFf39RBv760dy17zpxoweYXfRZ6o+GKF4LCx3Frdm7BVBvg35jGmOI9SZ
         Aq7KtpzvjTUIvRTlO02GTf3xnXZkZEQBFKIJqe63Tuh/ZvBB1YzMgmCRm8ZXB2u9SbqA
         e7f8IR3ndCbrJEOYQbg0C3TvmsMq+gVvk7aCASfnBTsTQOeUpywnj8VV+iLsawPy8FI+
         Pzwvawn+VelddN0nnjHG++w0TrdLGc+0pHp7pazngQ1AvotldUmrT8yeWaRN5SKJ3JaR
         xBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eVexviibFE9k7seKsPhQiFZXzQDM3R9OHbyKQzrT/w=;
        b=vWEI7LAdsvKeSQCpX32tdYSH8uLFpnHNcFW8FNbJZ1cxykbKmD+HpPRexd4ujHFie4
         4WoFxM2+KwuF/3HYF5d+qBdZ58byjltAII2j83W+COPmPFFrk7iK3R4UG8t0XPMMjQcH
         XwoJXFhOQL1IgOe93QqsnE2eXAwt3hGK6jA0X2i7Mu/huBzXARr2kfITB8Qa84ZRevY9
         y9qYJL/prjopmw2Y8dedANRRgRVYOxPwWruJdOC/fyqc4gRcD+BBYf8AnSQvNHIjS8xm
         ZMho3ZjJjRG99q35hxzefvMzlE/HEaq7oxKmrZhqIz1RcPA63oE5i5jB0j2HYP6nzCXd
         FTfQ==
X-Gm-Message-State: AOAM530ww+4lSpdIdUyB4h2qNhpaAOMpzCp5mlsVD0+S8LsvyLbPcV52
        gEHvb+20lCFtGHihgQAaBa0SJLiily0=
X-Google-Smtp-Source: ABdhPJwaV5A+qsr8ybe6jgk/xUu/TB/DSlk+YjwiOJNmkZ4KCES6jPSXhdXQY1gtyLpQHOMWNOgYYg==
X-Received: by 2002:a63:84c7:0:b0:3da:ec43:1b with SMTP id k190-20020a6384c7000000b003daec43001bmr10775617pgd.443.1652362531674;
        Thu, 12 May 2022 06:35:31 -0700 (PDT)
Received: from [100.127.84.93] ([2620:10d:c090:400::4:ae4])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b0050dc7628197sm3693755pfv.113.2022.05.12.06.35.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 06:35:30 -0700 (PDT)
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Len Brown <lenb@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-team@fb.com, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] : Revert "ACPI: Remove side effect of partly creating a node in acpi_get_node()"
Date:   Thu, 12 May 2022 06:35:28 -0700
X-Mailer: MailMate (1.14r5852)
Message-ID: <5B32F505-FE75-460F-A157-065F0BE965AB@gmail.com>
In-Reply-To: <20220512111525.0000570e@Huawei.com>
References: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
 <CAJZ5v0jHDNBqCfmgyLUOs7yUZaEjQ96m5HVZKHP3x7_uamH5zQ@mail.gmail.com>
 <7A00774E-13F2-4FB4-9979-D7827C92F5B8@gmail.com>
 <CAJZ5v0hSJExYtxEZuw-+ZUf1YoZesOtS+x9UbdoBNXtTKPiYxg@mail.gmail.com>
 <20220512111525.0000570e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12 May 2022, at 3:15, Jonathan Cameron wrote:

> On Wed, 11 May 2022 19:44:14 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> On Wed, May 11, 2022 at 7:42 PM Jonathan Lemon <jonathan.lemon@gmail.c=
om> wrote:
>>>
>>> On 11 May 2022, at 10:33, Rafael J. Wysocki wrote:
>>>
>>>> On Wed, May 11, 2022 at 7:24 PM Jonathan Lemon <jonathan.lemon@gmail=
=2Ecom> wrote:
>>>>>
>>>>> This reverts commit a62d07e0006a3a3ce77041ca07f3c488ec880790.
>>>>>
>>>>> The change calls pxm_to_node(), which ends up returning -1
>>>>> (NUMA_NO_NODE) on some systems for the pci bus, as opposed
>>>>> to the prior call to acpi_map_pxm_to_node(), which returns 0.
>>>>>
>>>>> The default numa node is then inherited by all pci devices, and is
>>>>> visible in /sys/bus/pci/devices/*/numa_node
>>>>>
>>>>> The prior behavior shows:
>>>>>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
>>>>>      122 0
>>>>>
>>>>> While the new behavior has:
>>>>>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
>>>>>        1 0
>
> Curious, which device is turning up in node 0?

Oddly enough, the NVME drive:

01:00.0 Non-Volatile memory controller: SK hynix PC401 NVMe Solid State D=
rive 256GB (prog-if 02 [NVM Express])
        Subsystem: SK hynix PC401 NVMe Solid State Drive 256GB
        NUMA node: 0

These are single-socket Skylake DE platforms.


>>>>>
>>>>> While arguably NUMA_NO_NODE is correct on single-socket systems whi=
ch
>>>>> have only one numa domain, this breaks scripts that attempt to read=
 the
>>>>> NIC numa_node and pass that to numactl in order to pin memory alloc=
ation
>>>>> when running applications (like iperf).  E.g.:
>>>>>
>>>>>   # numactl -p -1 iperf3
>>>>>   libnuma: Warning: node argument -1 is out of range
>>>>>   <-1> is invalid
>>>>>
>>>>> Reverting this change restores the prior behavior.
>>>>
>>>> Well, that's not a recent commit and it fixed a real and serious iss=
ue.
>>>>
>>>> Isn't there a way to fix this other than reverting it?
>>>
>>> The userspace behavior changed - is there another way to fix things
>>> so that a valid numa_node is returned?
>>
>> Well, that's my question.

This also could be a BIOS issue that wasn=E2=80=99t noticed until the pla=
tforms were
updated to a newer kernel.
=E2=80=94
Jonathan


> As Rafael noted, we don't want to change the internal kernel representa=
tion because
> previous kernel behavior resulting in several paths where you could
> get NULL pointer de-references, but maybe we could special case
> it at the userspace boundary.
>
> e.g. override dev_to_node() return value here
> https://elixir.bootlin.com/linux/v5.18-rc6/source/drivers/pci/pci-sysfs=
=2Ec#L358
>
> What's problematic is we missed this being being an issue until now and=
 hence
> have shipping kernels with both behaviors.
>
> +CC Bjorn and linux-pci
>
> Jonathan
