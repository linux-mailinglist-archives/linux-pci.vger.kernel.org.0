Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212C47928B1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbjIEQX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354676AbjIEN2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 09:28:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0A12A;
        Tue,  5 Sep 2023 06:28:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2217761f8f.2;
        Tue, 05 Sep 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693920497; x=1694525297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HO60y5WvecntGMap+7ti8637GtVXXtrbirknYBL6Q24=;
        b=g1hnz7vb+vW3A0C/ZQqcZodiLWunPL7/jNkBcL3u6LSluqkVsv9VI2os1hI4D27ycY
         +HCgRIqmRW6Y2aS2XZ1Y4zfBX3Z0vGGpZfuDAOejCIYGT/9y12fWRxxuhXMXH2+bGAWw
         myPzNzA0YQfKfM18lSyohyNWO+bBEaGqA9iGmC9jggU0W0D/OaBOmBXv+vH12AG9Wwvv
         aEwJWB3gkRUSugT3Hy4CJROFW7dvaQotSJ9HgwOHIM9Xy69ri31UgAAQZOQMNjOWgKUa
         pa7ol6P1spV5PB9Om6cnLHsAKNxtrkgYwArBwvYInoYTIR6kF8et5vdILuk0djCxsEIu
         2M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693920497; x=1694525297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO60y5WvecntGMap+7ti8637GtVXXtrbirknYBL6Q24=;
        b=A183kNDpw0vTri8KUlXBVHWFObrxGqciy/uuIyI1s0lJKIzkbEp2YnZZudbCPU9Rac
         EyJhq8kuV7dFvNSR0RAyk3VI5N50fjRUYpPQm14CyoApZzIvLbFtZ3gWevyN89pLjRWK
         Bre1dryIQKrsf8qr+t5a7khZs91K3emfieYMSwKfZ0ANXx0gkMMaBFUsOJBnNFPQexwC
         qb/F7X1396K1bTztVgRctJHfIqlM9xsOT+O7mxIb+qvfgS2GMXUX3YkpvekpxdG1d10R
         IeGswaSmk6YgyT9SfzpgkN3EDDDeP74Cabo9dIDyRBfwH6oJbyaWbCMWX6VKqWespQZ2
         C85Q==
X-Gm-Message-State: AOJu0YxufBDRhZo+zeAYaSuHTbdIqauTFT6YU4GHoYNZC7JAA/1akxpl
        M7y7obWBbo4gpV2N68/RKbg=
X-Google-Smtp-Source: AGHT+IE9N4h9DnLrGBA6w0mD6fm9bBMgaxlwOB4SKAbQC3od7Yg6OmwCuXYoDvsI34rJ37MMdyjrhQ==
X-Received: by 2002:a5d:4408:0:b0:313:f399:6cea with SMTP id z8-20020a5d4408000000b00313f3996ceamr9182865wrq.4.1693920497247;
        Tue, 05 Sep 2023 06:28:17 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id n10-20020adfe78a000000b0031aca6cc69csm17618765wrm.2.2023.09.05.06.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 06:28:16 -0700 (PDT)
Message-ID: <b11fedb4-d577-d007-0ef8-ac62775d9eee@gmail.com>
Date:   Tue, 5 Sep 2023 15:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to select
 the primary video adapter at boot time
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <874jk8j45s.fsf@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <874jk8j45s.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 05.09.23 um 12:38 schrieb Jani Nikula:
> On Tue, 05 Sep 2023, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
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

Well, you rarely find a board which can actually handle a single one :)

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
> The value 10 is incredibly arbitrary, and multiplied as a magic number
> all over the place.

+1

>
>> $ lspci | grep VGA
>>
>>   00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]
>>   01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XTX [Radeon HD 8490 / R5 235X OEM]
>>   04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 30)
>>   05:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 720] (rev a1)
> In this example, all of the GPUs are driven by different drivers. What
> good does a module parameter do if you have multiple GPUs of the same
> model, all driven by the same driver module?

Completely agree. Question is what is the benefit for the end user to 
actually specify this?

If you want the initial console on a different device than implement a 
kernel options for vgaarb and *not* the drivers.

Regards,
Christian.

>
> BR,
> Jani.
>
>> $ sudo dmesg | grep vgaarb
>>
>>   pci 0000:00:02.0: vgaarb: setting as boot VGA device
>>   pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>>   pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>>   pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>>   pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>>   vgaarb: loaded
>>   ast 0000:04:00.0: vgaarb: Override as primary by driver
>>   i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
>>   radeon 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
>>   ast 0000:04:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
>>
>> v2:
>> 	* Add a simple implemment for drm/i915 and drm/ast
>> 	* Pick up all tags (Mario)
>> v3:
>> 	* Fix a mistake for drm/i915 implement
>> 	* Fix patch can not be applied problem because of merge conflect.
>> v4:
>> 	* Focus on solve the real problem.
>>
>> v1,v2 at https://patchwork.freedesktop.org/series/120059/
>>     v3 at https://patchwork.freedesktop.org/series/120562/
>>
>> [1] https://patchwork.freedesktop.org/series/122845/
>>
>> Sui Jingfeng (9):
>>    PCI/VGA: Allowing the user to select the primary video adapter at boot
>>      time
>>    drm/nouveau: Implement .be_primary() callback
>>    drm/radeon: Implement .be_primary() callback
>>    drm/amdgpu: Implement .be_primary() callback
>>    drm/i915: Implement .be_primary() callback
>>    drm/loongson: Implement .be_primary() callback
>>    drm/ast: Register as a VGA client by calling vga_client_register()
>>    drm/hibmc: Register as a VGA client by calling vga_client_register()
>>    drm/gma500: Register as a VGA client by calling vga_client_register()
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 11 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 ++++-
>>   drivers/gpu/drm/ast/ast_drv.c                 | 31 ++++++++++
>>   drivers/gpu/drm/gma500/psb_drv.c              | 57 ++++++++++++++++++-
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 15 +++++
>>   drivers/gpu/drm/i915/display/intel_vga.c      | 15 ++++-
>>   drivers/gpu/drm/loongson/loongson_module.c    |  2 +-
>>   drivers/gpu/drm/loongson/loongson_module.h    |  1 +
>>   drivers/gpu/drm/loongson/lsdc_drv.c           | 10 +++-
>>   drivers/gpu/drm/nouveau/nouveau_vga.c         | 11 +++-
>>   drivers/gpu/drm/radeon/radeon_device.c        | 10 +++-
>>   drivers/pci/vgaarb.c                          | 43 ++++++++++++--
>>   drivers/vfio/pci/vfio_pci_core.c              |  2 +-
>>   include/linux/vgaarb.h                        |  8 ++-
>>   14 files changed, 210 insertions(+), 19 deletions(-)

