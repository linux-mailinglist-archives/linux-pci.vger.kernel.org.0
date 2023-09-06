Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1379343A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjIFDwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 23:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIFDwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 23:52:19 -0400
X-Greylist: delayed 114877 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 20:52:14 PDT
Received: from out-215.mta1.migadu.com (out-215.mta1.migadu.com [IPv6:2001:41d0:203:375::d7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA71A1;
        Tue,  5 Sep 2023 20:52:14 -0700 (PDT)
Message-ID: <a6337007-b6fa-2ce9-d0cd-46465b540205@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693972331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXh4IcnbpZdjMU5qCoBqZ2FlGW44f3JEdHzsIEyRCYA=;
        b=nxLw4KNzHkXxfO+wrsgAduaff8bs2XSK2nF4XWj3cl8EnKpR5VWhLYatbcqlzrZd6sbq9i
        xK1/QOSVkI2H2UXyB+cbEfr19S5BTfGnTVmuIz7rMlj7lNlG75g6ADcfdGdAjTx+J6MydS
        XmsEJm2tFaeFX4zuiYwyqM4pB+CnJ6E=
Date:   Wed, 6 Sep 2023 11:51:59 +0800
MIME-Version: 1.0
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to select
 the primary video adapter at boot time
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <20230905085243.4b22725e.alex.williamson@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20230905085243.4b22725e.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/9/5 22:52, Alex Williamson wrote:
> On Tue,  5 Sep 2023 03:57:15 +0800
> Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> On a machine with multiple GPUs, a Linux user has no control over which
>> one is primary at boot time. This series tries to solve above mentioned
>> problem by introduced the ->be_primary() function stub. The specific
>> device drivers can provide an implementation to hook up with this stub by
>> calling the vga_client_register() function.
>>
>> Once the driver bound the device successfully, VGAARB will call back to
>> the device driver. To query if the device drivers want to be primary or
>> not. Device drivers can just pass NULL if have no such needs.
>>
>> Please note that:
>>
>> 1) The ARM64, Loongarch, Mips servers have a lot PCIe slot, and I would
>>     like to mount at least three video cards.
>>
>> 2) Typically, those non-86 machines don't have a good UEFI firmware
>>     support, which doesn't support select primary GPU as firmware stage.
>>     Even on x86, there are old UEFI firmwares which already made undesired
>>     decision for you.
>>
>> 3) This series is attempt to solve the remain problems at the driver level,
>>     while another series[1] of me is target to solve the majority of the
>>     problems at device level.
>>
>> Tested (limited) on x86 with four video card mounted, Intel UHD Graphics
>> 630 is the default boot VGA, successfully override by ast2400 with
>> ast.modeset=10 append at the kernel cmd line.
>>
>> $ lspci | grep VGA
>>
>>   00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]
> In all my previous experiments with VGA routing and IGD I found that
> IGD can't actually release VGA routing and Intel confirmed the hardware
> doesn't have the ability to do so.

Which model of the IGD you are using? even for the IGD in Atom D2550,
the legacy 128KB VGA memory range can be tuned to be mapped to IGD
or to the DMI Interface. See the 1.7.3.2 section of the N2000 datasheet[1].

If a specific model of Intel has a bug in the VGA routing hardware logic unit,
I would like to ignore it. Or switch to the UEFI firmware on such hardware.

It is the hardware engineer's responsibility, I will not worry about it.
Thanks for you tell this.

[1] https://www.intel.com/content/dam/doc/datasheet/atom-d2000-n2000-vol-2-datasheet.pdf


>   It will always be primary from a
> VGA routing perspective.  Was this actually tested with non-UEFI?


As you already said, the generous Intel already have confirmed that the hardware defect.
So probably this is a good chance to switch to UEFI to solve the problem. Then, no
testing for legacy is needed.


> I suspect it might only work in UEFI mode where we probably don't
> actually have a dependency on VGA routing.  This is essentially why
> vfio requires UEFI ROMs when assigning GPUs to VMs, VGA routing is too
> broken to use on Intel systems with IGD.  Thanks,

Thanks for you tell me this.

To be honest, I have only tested my patch on machines with UEFI firmware.
Since UEFI because the main stream, but if this patch is really useful for
majority machine, I'm satisfied. The results is not too bad.

Thanks.

> Alex
>
