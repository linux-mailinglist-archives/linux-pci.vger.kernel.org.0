Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BEF4F99E0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiDHPwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiDHPwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 11:52:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A99CA0D0
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 08:50:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u14so9043180pjj.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Apr 2022 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=EECD+Me6/Huy4Qn5FMgGm7o7wAzxnDwetNqFWGOrV6A=;
        b=YggnnolWi023lk90yBu/tFpzYvuhEO/YiTkjlD9l4jo765VdHRvWKIacsDBzBUaJ9d
         eXV+ZcPxibevfcNrhnLQ7L6fjUF/T2X//YlikBzwBWWvu6cZvjuy3j6Y/XPIS3EMf8ps
         pY1P7KCJosQfOnLhrHVIVZZwlu027/mdUPdFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=EECD+Me6/Huy4Qn5FMgGm7o7wAzxnDwetNqFWGOrV6A=;
        b=rvbqBzdOoW4edwUQyErZM3C6TymiFxIuCpzdsEMTSoPUQx6rChAtnl3/LgZQrHMOEk
         e74xiGtS9RLAQSy1XOXgKJVzM4rEQ2nrax5/43TkFkaOS/4dbk6oTYvfibBRSDnrBCUH
         TLuHwB+1KekxvjZpSWcdNNXoOfEf9rzngiK3If+zGBgG2JH+B6Y4Nq3XwWLPVJVLwtEH
         MvvPt5/D+XU7tbQ6l6ECMK2BLYmOlwd3Q68+OkmiwQMbLnGXskpjaLQCJ4KD7sjoJVrt
         vUBVTHr6/IRlIV+Cc9LpcyMtozk6uLszumxbN4Jq07iUHyTGYFHNqqtP/qQTQfsYRwoV
         Tsag==
X-Gm-Message-State: AOAM533TybB7yHHmY2CF5PZ7eShy0zjk5o4hVeAG3ohCzD/4MIVCSg6f
        kagO4sC33+z6oLcgt+BWWbDMeA==
X-Google-Smtp-Source: ABdhPJxw/RmcZOj0b5L0AITFoynrTExtTzTA4Jq0x688TceLroThWO9GswHNOnr79NeltB65YO/jxQ==
X-Received: by 2002:a17:90b:4d87:b0:1c9:7f58:e5ca with SMTP id oj7-20020a17090b4d8700b001c97f58e5camr21963191pjb.154.1649433026723;
        Fri, 08 Apr 2022 08:50:26 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm22115695pga.77.2022.04.08.08.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 08:50:26 -0700 (PDT)
Date:   Fri, 08 Apr 2022 08:50:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Stevens <stevensd@chromium.org>
CC:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: sysfs: add bypass for config read admin check
User-Agent: K-9 Mail for Android
In-Reply-To: <20220406111751.GA132418@bhelgaas>
References: <20220406111751.GA132418@bhelgaas>
Message-ID: <C36237FA-F23D-4C52-BCB5-1D05D86ED9F4@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On April 6, 2022 4:17:51 AM PDT, Bjorn Helgaas <helgaas@kernel=2Eorg> wrot=
e:
>[+cc Kees]
>
>On Wed, Apr 06, 2022 at 04:11:31PM +0900, David Stevens wrote:
>> From: David Stevens <stevensd@chromium=2Eorg>
>>=20
>> Add a moduleparam that can be set to bypass the check that limits users
>> without CAP_SYS_ADMIN to only being able to read the first 64 bytes of
>> the config space=2E This allows systems without problematic hardware to=
 be
>> configured to allow users without CAP_SYS_ADMIN to read PCI
>> capabilities=2E
>
>Can you expand this a bit to explain the purpose of this?  I guess it
>makes "lspci -v" work without having to be root?  How much of a
>problem is that?  Is there some specific use case that needs this
>change?  Maybe there's some way to address that without having to add
>a new parameter that bypasses CAP_SYS_ADMIN=2E

Yeah, this doesn't seem right to me=2E There are tons of ways in userspace=
 to deal with these permissions (e=2Eg=2E sudo with lspci, suid wrapper, et=
c)=2E

-Kees


>
>> Signed-off-by: David Stevens <stevensd@chromium=2Eorg>
>> ---
>>  drivers/pci/pci-sysfs=2Ec | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/pci/pci-sysfs=2Ec b/drivers/pci/pci-sysfs=2Ec
>> index 602f0fb0b007=2E=2E162423b3c052 100644
>> --- a/drivers/pci/pci-sysfs=2Ec
>> +++ b/drivers/pci/pci-sysfs=2Ec
>> @@ -28,10 +28,17 @@
>>  #include <linux/pm_runtime=2Eh>
>>  #include <linux/msi=2Eh>
>>  #include <linux/of=2Eh>
>> +#include <linux/moduleparam=2Eh>
>>  #include "pci=2Eh"
>> =20
>>  static int sysfs_initialized;	/* =3D 0 */
>> =20
>> +static bool allow_unsafe_config_reads;
>> +module_param_named(allow_unsafe_config_reads,
>> +		   allow_unsafe_config_reads, bool, 0644);
>> +MODULE_PARM_DESC(allow_unsafe_config_reads,
>> +		 "Enable full read access to config space without CAP_SYS_ADMIN=2E")=
;
>> +
>>  /* show configuration fields */
>>  #define pci_config_attr(field, format_string)				\
>>  static ssize_t								\
>> @@ -696,7 +703,8 @@ static ssize_t pci_read_config(struct file *filp, s=
truct kobject *kobj,
>>  	u8 *data =3D (u8 *) buf;
>> =20
>>  	/* Several chips lock up trying to read undefined config space */
>> -	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
>> +	if (allow_unsafe_config_reads ||
>> +	    file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
>>  		size =3D dev->cfg_size;
>>  	else if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_CARDBUS)
>>  		size =3D 128;
>> --=20
>> 2=2E35=2E1=2E1094=2Eg7c7d902a7c-goog
>>=20

--=20
Kees Cook
