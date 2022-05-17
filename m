Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA35297B0
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 05:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiEQDLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 23:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiEQDLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 23:11:08 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297C12D1D;
        Mon, 16 May 2022 20:11:07 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id w124so17476162vsb.8;
        Mon, 16 May 2022 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1+fugqBpqtqqh5aHIZh6bBKu4zGDa2KCu9C7g+A3u3Q=;
        b=E41KZbr8oKS7K72sXm9gOI4SH4jUPr15Ixxt6rBesDhaJ//No8SVOWfO4APdwV/5Zj
         7xiM0aOCeV9IosSbE3g7imRe2H3SFJr4WHd8Y0tj5XKBDB7xqhPe/1EsNHhbfKc99LWi
         JMrIi9f+7MR80DP6NFVb9mXFHkDXNN1/qf1chBpHntH3MohhzNs9/8GRvk88k1JRgiHD
         4aV4BHCsTSmlPhge0ql50qj204wLsFOxxSUZluAa6/uO4sMVceX+5aqrlw87o44/zcMg
         MVSR+Vb9llHTvQ+x+F0fMDQAmTL9QplxzHy5S1EicDz38EaEuEibjheK0M8AHkkEVbSs
         eQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1+fugqBpqtqqh5aHIZh6bBKu4zGDa2KCu9C7g+A3u3Q=;
        b=nK6iLNCkAVoAw15/349mIKKghmiRDdBqiXpVe2fc8exosC4BPSq70hJ2mZ0NpCYyQb
         ty0dJ8vxJ2lc71yzfwqXBjMxbJsTepiUpOdbFYhSjpKG733U3Nirm8ZaUEw3WiLaftUR
         /BA2LKf3HSXvvDGlOsYNMeKe1r22SfN2rTqKUz7/ZHgwPLYw/kTEPTNNIN+M7lUeyVmH
         9tbKK5ApY7xVHXluH55zWBzKvntC0sBZ/HsJdMp1vWd7fQ3yFKZwR16kjoAV6E07Zg8T
         McLPysn4trCnFVQqTVvBLi3CxjE9sWb/T0fp7s19onu+rbofiEuSgpfVMcGzU0HhUjSu
         iNew==
X-Gm-Message-State: AOAM530YOu9F1CobFPnMzZzgeFmlYMUJ42kvEiO949xecDdaFxrj9QK1
        yx/ajIGGz0mJFxJ1pnUmvC9yHuPyCH0=
X-Google-Smtp-Source: ABdhPJwqAxDL7Df44Ph3sjITzFA8ZTsSBqMe9izo7I52jQ6eb7IwOnWdakbQPI6q8daeA71Wvj+W3A==
X-Received: by 2002:a05:6102:3bc4:b0:32d:7d2f:992f with SMTP id a4-20020a0561023bc400b0032d7d2f992fmr7233226vsv.78.1652757066199;
        Mon, 16 May 2022 20:11:06 -0700 (PDT)
Received: from [192.168.1.140] ([65.35.200.237])
        by smtp.gmail.com with ESMTPSA id i2-20020a9f3042000000b0036273c68563sm1593297uab.3.2022.05.16.20.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:11:05 -0700 (PDT)
Message-ID: <d356acbe-daff-1c66-6511-aab97a171c82@gmail.com>
Date:   Mon, 16 May 2022 23:11:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] of: always populate a root node
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <20220427094502.456111-2-clement.leger@bootlin.com>
 <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/22 08:45, Rob Herring wrote:
> On Wed, Apr 27, 2022 at 11:45:00AM +0200, Clément Léger wrote:
>> When enabling CONFIG_OF on a platform where of_root is not populated by
>> firmware, we end up without a root node. In order to apply overlays and
>> create subnodes of the root node, we need one. This commit creates an
>> empty root node if not present.
> 
> The existing unittest essentially does the same thing for running the 
> tests on non-DT systems. It should be modified to use this support 
> instead. Maybe that's just removing the unittest code that set of_root.
> 
> I expect Frank will have some comments.

My preference would be for unflatten_and_copy_device_tree() to
use a compiled in FDT that only contains a root node, in the
case that no valid device tree is found (in other words,
"if (!initial_boot_params)".

unflatten_and_copy_device_tree() calls unittest_unflatten_overlay_base()
after unflattening the device tree passed into the booting kernel.  This
step is needed for a specific portion of the unittests.

I'm still looking at the bigger picture of using overlays for the PCIe
card, so more comments will be coming about that bigger picture.

-Frank

> 
>> Co-developed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>> ---
>>  drivers/of/base.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index e7d92b67cb8a..6b8584c39f73 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -177,6 +177,19 @@ void __init of_core_init(void)
>>  		pr_err("failed to register existing nodes\n");
>>  		return;
>>  	}
>> +
>> +	if (!of_root) {
>> +		of_root = kzalloc(sizeof(*of_root), GFP_KERNEL);
>> +		if (!of_root) {
>> +			mutex_unlock(&of_mutex);
>> +			pr_err("failed to create root node\n");
>> +			return;
>> +		}
>> +
>> +		of_root->full_name = "/";
>> +		of_node_init(of_root);
>> +	}
>> +
>>  	for_each_of_allnodes(np) {
>>  		__of_attach_node_sysfs(np);
>>  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>> @@ -185,8 +198,7 @@ void __init of_core_init(void)
>>  	mutex_unlock(&of_mutex);
>>  
>>  	/* Symlink in /proc as required by userspace ABI */
>> -	if (of_root)
>> -		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>> +	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>>  }
>>  
>>  static struct property *__of_find_property(const struct device_node *np,
>> -- 
>> 2.34.1
>>
>>

