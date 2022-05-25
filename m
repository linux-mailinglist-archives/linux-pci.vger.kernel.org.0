Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB00B53409E
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 17:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiEYPqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiEYPqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 11:46:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FE13D4F;
        Wed, 25 May 2022 08:46:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so2029497pjh.0;
        Wed, 25 May 2022 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=DBX0l584xDMl/Ef/FGlK2tWkFKGbgMNoeEk7074fjeg=;
        b=Oo0YWmwEh28DfaENHh9KTeje2wuGU88LQG5grV0Jt46DqXFmjVE54S+AsQYJferP11
         MFV/bGDeq9Po8SyJ6J54OTGLHu2kKS0w4MZ2EAxDyWlYwAijKtvr53dn3V7nlndP0ufC
         ZKQy7tZU+GqHUVHvukY26lVrnVyIHCFVCb5W7CeYMfGt57ClAtFuF+KnaZBh0M0bJmGH
         DOBbowHQ9gLTvZxIoIQo31704thY6ZUGd+YTFdzpPyFXTTf4+e6T9GyhwlBM0nNaMtZW
         T/1nEupZd7dkr8QmVpPK+8Iqei2NwK2pPy9bkqlGPltquxm3n/+3eqZG/JJiypkthbBR
         t3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DBX0l584xDMl/Ef/FGlK2tWkFKGbgMNoeEk7074fjeg=;
        b=uWN4GjcyiO9xJDVYVlolFgGqvxxx88abqk/6WvyCtWGyp2YU6op7SSweXGjsJE7Usl
         cSCrA8EOrQ7GAM1X0YpswnDhrwpHKtKH33bNQUYhUocPlo2CpQfJtRHDsj9oVrPtBR2b
         ctMeaFnnQH/BZgYKvI9W+S52+FA6SSxGBe9ETsmrbQm4nOJbotTF6UyX/sYfaaBQvPsr
         e56+e3UW+Yh0EdrUddl6VOiOErKCVv4eRattDN5sQ/4NED6iQWLJtE9+ee7SuLL9igzw
         hUIgsgj47uQZ2yQlqod6qXfxtPW25pSxbEzUe3FXBfqRGqJBqgMY0f3YXPijcxy8UkVL
         KSww==
X-Gm-Message-State: AOAM530J/h0axYogxkL5GIkx/m7bjQB9LdYxPed8GKQbDmyrOizZQJwX
        z2uXoFA9kw6sqjE6DDO+hl9h3+Xwvdf0tNEf
X-Google-Smtp-Source: ABdhPJxG5GBW5VYSoq0okEwpk2Gx+15It0mHlPomu7qC5qgMZjjgpNf4fQ9Sw7Ds0TY6rO0En5OSHg==
X-Received: by 2002:a17:903:248:b0:155:e8c6:8770 with SMTP id j8-20020a170903024800b00155e8c68770mr32148403plh.129.1653493571118;
        Wed, 25 May 2022 08:46:11 -0700 (PDT)
Received: from [0.0.0.0] ([192.109.233.222])
        by smtp.gmail.com with ESMTPSA id o26-20020a629a1a000000b0050dc76281b4sm12041397pfe.142.2022.05.25.08.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:46:10 -0700 (PDT)
Message-ID: <3c80a21f-865a-83a1-1abe-dd7180002d55@gmail.com>
Date:   Wed, 25 May 2022 23:46:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RESEND PATCH v5] PCI: Make sure the bus bridge powered on when
 scanning bus
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220524205842.GA269611@bhelgaas>
From:   Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20220524205842.GA269611@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2022/5/25 4:58, Bjorn Helgaas 写道:
> On Tue, May 17, 2022 at 08:43:19PM +0800, Yicong Yang wrote:
>> When the bus bridge is runtime suspended, we'll fail to rescan
>> the devices through sysfs as we cannot access the configuration
>> space correctly when the bridge is in D3hot.
> Is the "D3hot" above a typo?  I think devices are supposed to respond
> to config accesses when in D3hot.  PCIe r6.0, sec 5.3.1.4.1:
>
>   Configuration and Message requests are the only TLPs accepted by a
>   Function in the D3Hot state. ...


It's right that we can access the bridge's configuration space
when it's in D3hot. But we need to access the configuration space of
downstream devices in a rescan, which is inaccessible in the upstream
bridge's D3hot state. So the "D3hot" state in the commit is qualified
to the *bridge*.


>
>   Functions that are in D3Hot are permitted to be transitioned by
>   software (writing to their PMCSR PowerState field) to the D0active
>   state or the D0uninitialized state. Functions that are in D3Hot must
>   respond to Configuration Space accesses as long as power and clock
>   are supplied so that they can be returned to D0 by software.
>
>> It can be reproduced like:
>>
>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>>
>> 0000:80:00.0 is a Root Port and it is runtime-suspended, so
>> 0000:81:00.1 is unreachable after a rescan.
>>
>> Power up the bridge when scanning the child bus and allow it to
>> suspend again by adding pm_runtime_get_sync()/pm_runtime_put()
>> in pci_scan_child_bus_extend().
>>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/pci/probe.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 17a969942d37..b108e72b6586 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>  	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>>  	unsigned int start = bus->busn_res.start;
>>  	unsigned int devfn, fn, cmax, max = start;
>> +	struct pci_dev *bridge = bus->self;
>>  	struct pci_dev *dev;
>>  	int nr_devs;
>>  
>>  	dev_dbg(&bus->dev, "scanning bus\n");
>>  
>> +	/*
>> +	 * Make sure the bus bridge is powered on, otherwise we may not be
>> +	 * able to scan the devices as we may fail to access the configuration
>> +	 * space of subordinates.
>> +	 */
>> +	if (bridge)
>> +		pm_runtime_get_sync(&bridge->dev);
>> +
>>  	/* Go find them, Rover! */
>>  	for (devfn = 0; devfn < 256; devfn += 8) {
>>  		nr_devs = pci_scan_slot(bus, devfn);
>> @@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>  		}
>>  	}
>>  
>> +	if (bridge)
>> +		pm_runtime_put(&bridge->dev);
>> +
>>  	/*
>>  	 * We've scanned the bus and so we know all about what's on
>>  	 * the other side of any bridges that may be on this bus plus
>> -- 
>> 2.24.0
>>
