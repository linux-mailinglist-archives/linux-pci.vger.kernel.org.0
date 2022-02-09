Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ACB4AF61A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiBIQIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiBIQIO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF20AC0613C9
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644422896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y+3D1mmDP+so7K35HmtJtJnfLKa5XZgyYtLZiIRCfU=;
        b=LfeaPp9JDVMGL6GWsUeuC955pRKJu2tTgTL39A43aGh+cKeDy+sgnnUKDJDf/LDpxBV1zh
        UL5UBrAkZtGcHnzVy5sxQqIclG23DuQ1QGVan9ZygV8dgZsaQ7qHi1gvxgVZmGwmQhkOXN
        4xxMCiplzdu/GtpsDWlAgC/BOAIwZT8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-PWH-lFdwOl-4h9ZugTL3XQ-1; Wed, 09 Feb 2022 11:08:15 -0500
X-MC-Unique: PWH-lFdwOl-4h9ZugTL3XQ-1
Received: by mail-ed1-f72.google.com with SMTP id u24-20020a50d518000000b0040f8cef2463so1601060edi.21
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 08:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0y+3D1mmDP+so7K35HmtJtJnfLKa5XZgyYtLZiIRCfU=;
        b=QAdbyCYBJPOkkH33lunHuCjSDBFjCv6CBrodLf85zfRbNsqwA1qLqJz2RO5I2UbNYv
         0DgK6wQdp8BQugn7t/7TF7m0KvCpRS9fkxt9/zkVKMndqmz99GTq7fm4I8ZCxOMO3obL
         0e1hUJ+oisQ5biONtGxu/FXkWjZSRkxNsv6bar39BRAaBU0dviak3eRsssxQHwBJS4YK
         KaibuTZV7hZgBiStnnEOb5auiL1SFkYBYomSu8LpKdjcP/piBmxRLJ17nosPOq8R1mQr
         jDimJzALckW8DTEav+hIaOfgohc0IlfAa6/SNYrDtzPG0xjWySMPKNDapHa3F/Ry5GnJ
         mmRA==
X-Gm-Message-State: AOAM533L3uzjdluBZEDBiCk+y/IDhBRovTYYR7Ew0DH+DfhAAztRB/GW
        BkmZC7CeEXp6AxisGV8t6iMBBNASQT5/QuINTMj6HUVjHLXIUqeQwCRzVVNxp7Yo072X33XoyLw
        ztXoKuuvqun6Wh7TenGTx
X-Received: by 2002:a17:906:15ca:: with SMTP id l10mr2696377ejd.435.1644422894516;
        Wed, 09 Feb 2022 08:08:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb6OkuwjdrgsvxBGJbTCnOXgla4rTIAOurtFalLqWz1KjOzLrxrYsGyj6nNlH9UONmPYU0kQ==
X-Received: by 2002:a17:906:15ca:: with SMTP id l10mr2696358ejd.435.1644422894330;
        Wed, 09 Feb 2022 08:08:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id va16sm4817409ejb.173.2022.02.09.08.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:08:13 -0800 (PST)
Message-ID: <2f01e99d-e830-d03c-3a9d-30b95726cc2c@redhat.com>
Date:   Wed, 9 Feb 2022 17:08:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com> <YgKcl9YX4HfjqZxS@lahna>
 <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com> <YgPlQ6UK3+4/yzLk@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YgPlQ6UK3+4/yzLk@lahna>
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

On 2/9/22 17:01, Mika Westerberg wrote:
> Hi Hans,
> 
> Thanks for looking into this!
> 
> On Wed, Feb 09, 2022 at 04:12:32PM +0100, Hans de Goede wrote:
>> An alternative, much more elaborate fix would be to:
>>
>> 1. Add E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW types to
>>    enum e820_type and modify the 2 places which check for type == reserved
>>    to treat these both as reserved too, so as to not have any functional
>>    changes there
>>
>> 2. Modify the code building e820 tables from the EFI memmap to use
>>    E820_TYPE_MMIO for MMIO EFI memmap entries and make e820_nomerge()
>>    treat E820_TYPE_MMIO as non mergable to retain these as is
>>
>> 3. Modify pci_acpi_root_prepare_resources() to compare ACPI provided
>>    bridge mmio windows against E820_TYPE_MMIO e820_Table entries and
>>    if there is an exact match (as is the case on the Yoga C940)
>>    then change the e820 type to E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
>>
>>    This means that we are now very narrowly treating EFI MMIO marked
>>    regions special, in the special case where they are a 1:1 map
>>    to an ACPI PCI bridge window resource.
>>
>>    Note since we treat both E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
>>    identical to the old RESERVED everywhere there is no functional change
>>    here.
>>
>> 4. Modify arch/x86/kernel/resource.c: remove_e820_regions() to skip
>>    e820 table entries with a type of E820_TYPE_MMIO_PCI_BRIDGE_WINDOW,
>>    this would actually be a functional change and should fix the
>>    issues we are trying to fix.
>>
>> Note an alternative would be to skip having the extra E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
>> type and to skip step 3. above. That would boil down to doing the same
>> as your original patch in a somewhat cleaner manner.
> 
> I agree and my vote goes for this last alternative (e.g skipping step 3).
> That would also make it slightly easier to follow the logic if someone
> in the future needs to investigate possible issues around this, I think.

As mentioned in my email from 10 seconds ago I think a better simpler
fix would be to just do:

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..18656f823764 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -28,6 +28,10 @@ static void remove_e820_regions(struct resource *avail)
 	int i;
 	struct e820_entry *entry;
 
+	/* Only remove E820 reservations on classic BIOS boot */
+	if (efi_enabled(EFI_MEMMAP))
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 

I'm curious what you think of that?

Regards,

Hans

