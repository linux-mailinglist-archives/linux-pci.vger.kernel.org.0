Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5058761D85
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGYPlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjGYPlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 11:41:14 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED61FCF;
        Tue, 25 Jul 2023 08:41:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-444f9c0b2a4so1969247137.1;
        Tue, 25 Jul 2023 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690299673; x=1690904473;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmkK+30yGQXibPyT5/Ct9RQIv6+C83i5MSHGoAU54A8=;
        b=j/kPUbLAHKIy7l16YnLesrhJaJv0YE2O3MSVif2RI60DqAU8n/K3bbBju+XoKI+7hW
         4GcYp3IOdWjh8Yvc9nf4OgHNxl3Yc+AonsWnyDCtOKoWbnT4/SQqoYdiy+z1Aupiu0ir
         R3p/05sRxdBuj21BVljNBg/qnn2Aum5N9da+/aTn151hRTGS/jIT+j1MEBCi9yvsUbVz
         26zj+gTsfUCQTucTujw0ILwroRb6P1tOfk/oNPFpv4gPF7z4U8qUvRMU0DBffGdAEjhO
         dt31nJYn+FMcKsBFa3Z8Xs2YKlkWmeK30JaTycuTY7/SFQYR7hacWjl2QtAnLEIQd5wN
         ZAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299673; x=1690904473;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmkK+30yGQXibPyT5/Ct9RQIv6+C83i5MSHGoAU54A8=;
        b=L0HU2ZHu4ZRO7p5w0ghWt4s6CA66kwOsgxjjUnM1qC1PFcLqq5l6WN/txmNWbDO/Vx
         wKhFpGX8aIyx9mwm4YjUt11oWeu4LDvVvr9rACHbwqwtYfxtarHy8RCxT1QJXyaou/gl
         EcNfX3cYKwAArP6IMiFgrZhDtMvavHUGxF96Rv4DpCpKXaqB68lyipCCgoN6bSbUbOYo
         nd5UyRuN+46q9Et+fNPkxMPP7BN5mx7x+4EkqmOpuXGSm3T4X25GmlUc3sjlX/9m6x6b
         lNB57N5XAe7FatAc3P/+nYgcboqPfKJDHfNJpK/6tpdG4IhVd8uj/F86BqCOimJhCPVG
         qm7g==
X-Gm-Message-State: ABy/qLbWXE9wNDRPgmnosfB1n6okzjUb89UEamYZaAqjEQKCCIzcRrB0
        G5Q/S6edkvbAUQSRIxpvSYmTuT2akUAmYjg=
X-Google-Smtp-Source: APBJJlFiKd26kkurVXyDJLvJhwiAGgciTXIG20Ilv9aMQptI69PlmjaXbIgSZ6Cm2hi30KjOeI6Fdg==
X-Received: by 2002:a67:fa46:0:b0:443:7a85:8fbd with SMTP id j6-20020a67fa46000000b004437a858fbdmr4680934vsq.32.1690299672839;
        Tue, 25 Jul 2023 08:41:12 -0700 (PDT)
Received: from [120.7.1.38] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id x10-20020a0c8e8a000000b0063762ab2f90sm4431033qvb.83.2023.07.25.08.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:41:12 -0700 (PDT)
Subject: Re: [RFC 0/3] acpipcihp: fix kernel crash on 2nd resume
From:   Woody Suwalski <terraluna977@gmail.com>
To:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        Woody Suwalski <terraluna977@gmail.com>
References: <20230725113938.2277420-1-imammedo@redhat.com>
 <88a06e12-600a-a4bd-f216-44753965ce48@gmail.com>
Message-ID: <7bbe2e5f-411c-6936-5d4b-c128795fb5d4@gmail.com>
Date:   Tue, 25 Jul 2023 11:41:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101 Firefox/91.0
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <88a06e12-600a-a4bd-f216-44753965ce48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Woody Suwalski wrote:
> Igor Mammedov wrote:
>> Changelog:
>>    * split out debug patch into a separate one with extra printk added
>>    * fixed inverte bus->self check (probably a reason why it didn't 
>> work before)
>>
>>
>> 1/3 debug patch
>> 2/3 offending patch
>> 3/3 potential fix
>>    I added more files to trace, add following to kernel CLI
>>     dyndbg="file drivers/pci/access.c +p; file 
>> drivers/pci/hotplug/acpiphp_glue.c +p; file drivers/pci/bus.c +p; 
>> file drivers/pci/pci.c +p; file drivers/pci/setup-bus.c +p; file 
>> drivers/acpi/bus.c +p" ignore_loglevel
>>
>> should be applied on top of
>>     e8afd0d9fccc PCI: pciehp: Cancel bringup sequence if card is not 
>> present
>>
>> apply a patch one by one and run testcase + capture dmesg after each 
>> patch
>> one shpould endup with 3 dmesg to ananlyse
>>   1st - old behaviour - no crash
>>   2nd - crash
>>   3rd - no crash hopefully
>>
>> Igor Mammedov (3):
>>    acpiphp: extra debug hack
>>    PCI: acpiphp: Reassign resources on bridge if necessary
>>    acpipcihp: use __pci_bus_assign_resources() if bus doesn't have 
>> bridge
>>
>>   drivers/pci/hotplug/acpiphp_glue.c | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
> Actually applying patch1 is already creating the crash (why???), hence 
> I have added also dmesg-6.5-0.txt which shows a working condition 
> based on git e8afd0d9fccc level (acpiphp_glue in kernel 6.4)
>
> Patch3 did not fix the issue, it seems that the culprit is somewhere 
> else triggered by  "benign" patch1 :-(
>
> Also note about the trigger description in patch3: the dmesg trace on 
> Inspiron laptop is collected after the first wake from suspend to ram. 
> The consecutive  attempt to sleep results in a frozen system.
>
> Thanks, Woody
>
I think that in patch1 there is a problem in your debug statement 
acpi_handle_debug(...slot_name...) - it is masking the "old" issue.
when I commented out that line in hotplug_event(), it has worked ok (as 
was expected). I will redo the testing in ~2 hours...

Woody

