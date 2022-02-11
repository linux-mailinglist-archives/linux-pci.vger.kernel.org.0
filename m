Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD44B21A4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 10:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiBKJW1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 04:22:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbiBKJW0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 04:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 358511036
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 01:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JATPSfuuIzbUvjucn3mqiTWieLFcGsiKYRvySMK0CuY=;
        b=MJpWt3UCHCojLJ61Oy4FxeI3nWm2lR3SDqgRdLOZuLP2DU9xFQI6WuMHrwvhQ2fhJ3OGKx
        f80iuS1QZtfj7+w5ilVOmkPpP9rInhpVe4lD/vStp1kb+XVqk0GGFOK+OLWhTinSSnJdhc
        HmJUy8TUSrR/YWk+dUb5GwCAG67Xw+U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-5ae5mav_MQilGuw236TL8Q-1; Fri, 11 Feb 2022 04:22:22 -0500
X-MC-Unique: 5ae5mav_MQilGuw236TL8Q-1
Received: by mail-ed1-f71.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so5017603edz.8
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 01:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JATPSfuuIzbUvjucn3mqiTWieLFcGsiKYRvySMK0CuY=;
        b=1tgQQTXdqoxObcwyR89FTrz7SlpWiiLZl2ZPPT4iISnCRkWm4nfwMaNJ9xS8OiGlVS
         ZjkZgkLQ16DcnWUlW50UAmDq6VZIrcf3SNV7dOGJ/4GcDs3rLrvcXOHQzfdnrLfLFiUZ
         rjuRX2D5PU4H2U1c1oxLZrgdEn0zYCEirrnO3AK7eBE6i5O6/my684H5zrJOIyRlrBQD
         NWATlU8v/pZfmSvlh65nVXQCJdbmAlfWf2fgivfnj0HRsUm6sUvn3MrMJjdZ/9SFAE9d
         vBSsS/DdSoG8Thgq6zAT02VH34i9/BmBlWtVBDhogXUPM88FOQAUQVvfL5je5gQ9MZJd
         Yt0A==
X-Gm-Message-State: AOAM533c1cg7iSpoTrGuisSQbgZzIQXrE32IOGzX0JgNKw73LpmSgC4q
        x3Z62FY0kdsxaOZxnvJwr4GM/7u/96z2ywrsfY7i6zPcCDfWcnRyN/bPcmJkg9T8KJWZ23AD3mf
        c8QXXHWPQD4AaXAwbuTu/
X-Received: by 2002:a17:906:9741:: with SMTP id o1mr634464ejy.452.1644571341119;
        Fri, 11 Feb 2022 01:22:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJzLEHrlpWTVVnLCXx+X1wR5IUJlkBcCT7V/xFq7SwXUygMIWI6NCaHgu9RUznaxy1V50DlQ==
X-Received: by 2002:a17:906:9741:: with SMTP id o1mr634448ejy.452.1644571340909;
        Fri, 11 Feb 2022 01:22:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y22sm3647503ejm.225.2022.02.11.01.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 01:22:20 -0800 (PST)
Message-ID: <aa1f140d-0f1b-852c-da8b-75e437537ef2@redhat.com>
Date:   Fri, 11 Feb 2022 10:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 8/9] platform/x86: amd-gmux: drop the use of
 `pci_is_thunderbolt_attached`
Content-Language: en-US
To:     Yehezkel Bernat <yehezkelshb@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Lukas Wunner <lukas@wunner.de>, Alexander.Deucher@amd.com
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-9-mario.limonciello@amd.com>
 <CA+CmpXtah8AeVehExk0+eagyP=DQOPEy18DW3t2rQ0ZjyMk-Rw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CA+CmpXtah8AeVehExk0+eagyP=DQOPEy18DW3t2rQ0ZjyMk-Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/11/22 10:00, Yehezkel Bernat wrote:
> On Fri, Feb 11, 2022 at 12:43 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Currently `pci_is_thunderbolt_attached` is used to indicate a device
>> is connected externally.
>>
>> The PCI core now marks such devices as removable and downstream drivers
>> can use this instead.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/platform/x86/apple-gmux.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index 04232fbc7d56..ffac15b9befd 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>>
>>  static int is_thunderbolt(struct device *dev, void *data)
>>  {
>> -       return pci_is_thunderbolt_attached(to_pci_dev(dev));
>> +       return dev_is_removable(dev);
>>  }
>>
> 
> Maybe it's only me, but isn't it a bit strange to keep this function named
> `is_thunderbolt` while it's actually about being removable?

The comment above the only caller says:

        /*
         * If Thunderbolt is present, the external DP port is not fully
         * switchable. Force its AUX channel to the discrete GPU.
         */
        gmux_data->external_switchable =
                !bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);

So IHMO keeping the name as is is fine.

Regards,

Hans

