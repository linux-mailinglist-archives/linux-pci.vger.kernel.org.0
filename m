Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247275F55BD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJENns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJENnk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 09:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9051E72E
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664977418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgvJzk0HSeNU5c+PX6hPIJN5iPotVJttn7B4QegNpok=;
        b=bP5iBIDdxwXs4qhTIf1gjAIuyQ7bEvaqoHlK/1opeIafByKR4Mv7lODhbcrDKeDVbnpGDP
        GdKjWOHVnhGgFUzVjFbiPBu3ewIm5rsRq6EPycrvHlpVJDCyix2De6nl/0JtAktllJyBLb
        1ef7Yz39Ntn1808ri7iOWBfWK3heOwI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-248-RN4iIuiXNFSTyB1G6SuB0Q-1; Wed, 05 Oct 2022 09:43:37 -0400
X-MC-Unique: RN4iIuiXNFSTyB1G6SuB0Q-1
Received: by mail-ed1-f71.google.com with SMTP id z16-20020a05640235d000b0045485e4a5e0so13540587edc.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Oct 2022 06:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KgvJzk0HSeNU5c+PX6hPIJN5iPotVJttn7B4QegNpok=;
        b=gX2KTNEDZ49cwhhSEyMKx95ZwEiqhlcdWHunYpeCx/uHtM0ieyBdvWoVrH4ZJ0vbz7
         g5NUIrStfGAQqtvjPmQDrqEw+ZQmJFrM2f6cluz9CJDLgMNAVqDjk1rHyJVtPlWglC60
         KJ9nuFInoMmSCM4TdPLY9xXo2cXly1/c6KaJ4gyc0R52cPgAcroYt94y3Nd5arffbtEs
         yGDQVWoA96Yu9JWpf/GxChucHnoQytNFCsTV621glrej/RQcFinfQZiPwaHpcuNw6WLv
         x0lOyUYKKvuAmiaJ2Ec0lxA/gceCOCUTLSA23hlOAYqeYrs53qLcTICOs6cXz839G52L
         6hAg==
X-Gm-Message-State: ACrzQf3bwGwDpYWUZXSmgU4cIwu7OGK5cuNY0kyofbWqxY8GvulXqsi0
        FqjbkihTzGXHsb1oM6+HXA1P11WYxoIeK2nb7gvJ95OT3D/5DLxA4dWVEXMFjCIZ3mMQg9WM96J
        hHq+lVdxmitZjz3R1M7uT
X-Received: by 2002:a17:907:7b9e:b0:783:10cb:2826 with SMTP id ne30-20020a1709077b9e00b0078310cb2826mr24044288ejc.208.1664977415882;
        Wed, 05 Oct 2022 06:43:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tBRvPVsfcv/fFsVz0y9DaZQLCuLAmvTv+qbMXaHCyxk1hQ4IAgkl3M5vEQM/vXo55Boql+Q==
X-Received: by 2002:a17:907:7b9e:b0:783:10cb:2826 with SMTP id ne30-20020a1709077b9e00b0078310cb2826mr24044272ejc.208.1664977415693;
        Wed, 05 Oct 2022 06:43:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r5-20020aa7d585000000b00459148fbb3csm3801469edq.86.2022.10.05.06.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 06:43:35 -0700 (PDT)
Message-ID: <e779bcf1-f99d-6b3e-1e9b-42b046f0950f@redhat.com>
Date:   Wed, 5 Oct 2022 15:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: pci=no_e820 required for Clevo laptop
Content-Language: en-US, nl
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linuxkernelml@undead.fr
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <5d8ae0a2-1c0c-11ab-a33c-9b57bd087733@undead.fr>
 <Yz2Hm99xHaJmdN6g@rocinante>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yz2Hm99xHaJmdN6g@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/5/22 15:33, Krzysztof Wilczyński wrote:
> (+CC Bjorn and Hans directly for visibility)
> 
> Hi Florent,
> 
> I am sorry that you are having issues!
> 
>> As per
>> https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt,
>> I am sending you this email to inform you that I need to set "pci=no_e820"
>> parameter to get the SSD and touchpad working.
>>
>> ---------------------------------------------------------------------
>>
>> Dmidecode:
>>
>> BIOS Information
>>     Vendor: INSYDE Corp.
>>     Version: 1.07.02TPCS
>>     Release Date: 08/19/2020
>>
>>     BIOS Revision: 7.2
>>     Firmware Revision: 7.2
>> Handle 0x0001, DMI type 1, 27 bytes
>> System Information
>>     Manufacturer: PC Specialist LTD
>>     Product Name: NL4x_NL5xLU
>> Base Board Information
>>     Manufacturer: CLEVO
>>     Product Name: NL4XLU
>>
>> uname -a
>> Linux topik 5.19.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.19.11-1
>> (2022-09-24) x86_64 GNU/Linux
> 
> We need a little bit more information, if you have the time, to collect
> that will be of great help to us with troubleshooting this.
> 
> Would you be able to collect output from the following:
> 
>   - lspci -vvv
>   - dmesg (preferably since the system started)
> 
> Then, either attach these here as text attachments, or better yet, open
> a bug report against the PCI driver on Kernel's Bugzilla at
> 
>   https://bugzilla.kernel.org/
> 
> and include as much information as possible about your system as you can,
> plus the details mentioned above.  That would help greatly.

Yes if you can file a bug in: https://bugzilla.kernel.org/
with the requested logs attached so that we have those for
future reference, that would be great.

Note we already have one no_e820 DMI quirk for Clevo models,
so these models may just need another quirk, but first we
would like to better understand the problem.

For the existing quirk see: arch/x86/pci/acpi.c around line 180:

        /*
         * Clevo X170KM-G barebones have the same E820 reservation covering
         * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
         * See https://bugzilla.kernel.org/show_bug.cgi?id=214259
         */
        {
                .callback = set_no_e820,
                .ident = "Clevo X170KM-G Barebone",
                .matches = {
                        DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
                },
        },

I'm a bit surprised this is needed for the SSD too though. Usually it
is just the touchpad + hotplugged (Thunderbolt) PCI devices which need this.

BTW please also attach the dmidecode.txt file generated by:

sudo dmidecode > dmidecode.txt

to the bug, since we need those strings to add the quirk. Note this will
also include serial-numbers for your device (if your model uses unique per
model serial numbers) feel free to edit the file and remove those.

Regards,

Hans


