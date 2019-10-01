Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFAC42C8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfJAVg0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 17:36:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42068 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfJAVgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 17:36:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id c10so12904293otd.9;
        Tue, 01 Oct 2019 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DScLBuYNMomTfF9E2WDmfHDBerwYWf96njCU9HqGGhc=;
        b=KeYi0UB+7u6MHCFYw50DUyqf9p9mDNKVS+aEk8I+bFgEulqJFetnll9VvodCCnrhkh
         RLz7wkaNQEfT3kK7ZVMfGViD9DDhgRU2gVffvAdukn6OVgbEitR+tRq2IGJcltcG1VeW
         Y/xMm0DeY7vASciZswqo1rweSC8alJpcGrAG0ZN1FdFJ97cjVuieVOMd0riPNUY4CyIS
         3CgUpx6Pnj3zcB+bf3dD/Fws8eK91zphXjyO8XAnvH6LX5KedRXnHQE9ydSlpGUje4n4
         5nHv5cFT4VCk4TXpdLcGv9pYEMEz0LMsH07vDc6nTBIfxnccUi0y29QYLKjvClcPSuhD
         lp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DScLBuYNMomTfF9E2WDmfHDBerwYWf96njCU9HqGGhc=;
        b=a6L3+cJdUvbn31VOElde7tT8oj+Ldq0qmlT7PEEW42aWsojatoKkbtB3E1KoQtnXQD
         vFrYfN0eOszbQIAC0s0uUXiX3fa/TA3R5A32fkcVDsMj8SFaSnVxNSHpB/fGJVZJ0Ito
         j4xiY2eZngCj54kAkWExvYBWtbv4p2wQGOJJZVSBgX+YgaVYI1hpqeuJu1uGej8JMF6h
         yL5s0NER+WPFNy4mHKD0tLjh2EAR1Rl0D4TK0AnWDTm2MiVVsOKRArvK1a8d4W8Dzs4X
         Ys3pMDTLqkrDWRJYjs4G15cUz0k5icGhn5uQ5g0NV+cAw6iZOn1Lu/f1EJ3g/IYaZ5Bi
         lgZw==
X-Gm-Message-State: APjAAAVhzjidbu1U6UamnT+39uSnzlyXrZvxvumu/JT0UjWGaqrMx/lS
        EQ2DhPXtF3AR/uW+2UuXJdA=
X-Google-Smtp-Source: APXvYqxqMmACY4eAFBh69a1f1ZhgR8xIEWVojxC+3odUJ51o+BwxIDlpNdwx8dtgJvFNu+z1Fh5FSw==
X-Received: by 2002:a9d:6642:: with SMTP id q2mr87331otm.250.1569965784571;
        Tue, 01 Oct 2019 14:36:24 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id i47sm5337543ota.1.2019.10.01.14.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 14:36:23 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
 <20191001211419.11245-4-stuart.w.hayes@gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <b37c8640-9f48-8d0d-9e2e-80920c1e19e7@gmail.com>
Date:   Tue, 1 Oct 2019 16:36:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191001211419.11245-4-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/1/19 4:14 PM, Stuart Hayes wrote:
> Some systems have in-band presence detection disabled for hot-plug PCI slots,
> but do not report this in the slot capabilities 2 (SLTCAP2) register.  On
> these systems, presence detect can become active well after the link is
> reported to be active, which can cause the slots to be disabled after a
> device is connected.
> 
> Add a dmi table to flag these systems as having in-band presence disabled.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>   drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1282641c6458..1dd01e752587 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -14,6 +14,7 @@
>   
>   #define dev_fmt(fmt) "pciehp: " fmt
>   
> +#include <linux/dmi.h>
>   #include <linux/kernel.h>
>   #include <linux/types.h>
>   #include <linux/jiffies.h>
> @@ -26,6 +27,16 @@
>   #include "../pci.h"
>   #include "pciehp.h"
>   
> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
> +	{
> +		.ident = "Dell System",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
> +		},
> +	},
> +	{}
> +};
> +

I'm not sure that all Dell systems that were ever made or will be made 
have in-band presence disabled on all their hotplug slots.

This was a problem with the NVMe hot-swap bays on 14G servers. I can't 
guarantee that any other slot or machine will need this workaround. The 
best way I found to implement this is to check for the PCI-ID of the 
switches behind the port.

Alex
