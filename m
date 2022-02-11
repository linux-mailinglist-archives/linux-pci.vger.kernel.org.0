Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2114B207D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348132AbiBKIqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 03:46:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348121AbiBKIqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 03:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B1EE67
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 00:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644569161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIGJSGdDR+e/0lqDusmjI7J0UIItqFB5EseqZJ+/itg=;
        b=JWBBVROHNDyDfUEi5eAEEopZINg2s1HncjBe0675uzx9nZdArY2kqmyW+TUBaiSSRo+lLU
        FE0P/ZBJ32V9N7pjdgeOhXhGED0I/Du1iLPKMyxGebFqbNY6kWxqOBMJgweOdGfI10InBj
        JPFP51oRizc8wLb7tvSxBU4beQ+ebVY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-IsXI8w6UNXOXgKhO4wFLRQ-1; Fri, 11 Feb 2022 03:46:00 -0500
X-MC-Unique: IsXI8w6UNXOXgKhO4wFLRQ-1
Received: by mail-ej1-f69.google.com with SMTP id la22-20020a170907781600b006a7884de505so3799651ejc.7
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 00:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NIGJSGdDR+e/0lqDusmjI7J0UIItqFB5EseqZJ+/itg=;
        b=ihErpbW9PZJc90OvR+BlqZKKzfcflw9ZxHtsNCHqHiW/y1aanveQI8DUi0K2UMpCuC
         1/SSmTrWdmLn3RktUpNoQ5T6W4PshCuo4BA/yB8DBU+PSQ8jt3rYKEA0Q/uU/KjHin95
         pZscQxZtEgzMSRO73rC+V7ggRzkCzhxvlyJKs+PEzoMeH8G/Jb76TnUa6lF3X6Lu40Fr
         NyS++TC6byEjN3hi9a6JsImd65eJsJ2D1o6vebhgGcgvLjcYyEei7P/udqRelke4J489
         6NtQoVwGepNIHgkMPRCwZDNfWpMH58wi2cUKWVU/oQ/P+SuIM3xX/LzwI/d/exctU1QP
         qUEA==
X-Gm-Message-State: AOAM53335Zm9Q9UqB/zJX2o250aV44vcSCVATDnMfAcougvXBNEQ7FWj
        pkc3u1QY+AuqNQ66J01kM4cDr3t1UHQj8yo59eV4q2EXehR8OL4MtPKfe6j+zaW/6NFyWO0H0SO
        2epjE/mVDpRorfb+EUK2L
X-Received: by 2002:a17:907:168a:: with SMTP id hc10mr466714ejc.283.1644569159073;
        Fri, 11 Feb 2022 00:45:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQtGaHy5U9JGMvxdUhyHS51vk9smJiabHDR4QMkXJw//KX0Gh6ttUq7C+QmDdzvWmB7pzNDQ==
X-Received: by 2002:a17:907:168a:: with SMTP id hc10mr466695ejc.283.1644569158862;
        Fri, 11 Feb 2022 00:45:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id v5sm10859303edb.15.2022.02.11.00.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 00:45:58 -0800 (PST)
Message-ID: <d8c31b9a-49fd-e10b-34ef-751fe1262513@redhat.com>
Date:   Fri, 11 Feb 2022 09:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 8/9] platform/x86: amd-gmux: drop the use of
 `pci_is_thunderbolt_attached`
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        <platform-driver-x86@vger.kernel.org>
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Alexander.Deucher@amd.com
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-9-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220210224329.2793-9-mario.limonciello@amd.com>
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

On 2/10/22 23:43, Mario Limonciello wrote:
> Currently `pci_is_thunderbolt_attached` is used to indicate a device
> is connected externally.
> 
> The PCI core now marks such devices as removable and downstream drivers
> can use this instead.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, this looks good to me. I assume that this whole series
will be merged in one go through another tree (e.g. the PCI tree),
so here is my ack for merging this patch through another tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 04232fbc7d56..ffac15b9befd 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>  
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -	return pci_is_thunderbolt_attached(to_pci_dev(dev));
> +	return dev_is_removable(dev);
>  }
>  
>  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> 

