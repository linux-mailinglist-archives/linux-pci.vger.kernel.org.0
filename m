Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1403DF4F3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJUSTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 14:19:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37258 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfJUSTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 14:19:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id i16so11896454oie.4;
        Mon, 21 Oct 2019 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GhRRKX0fxrsZsxuGGvSqETLa9jJ6bP3uK2nviMUaww8=;
        b=dce21xf3wyCRXQ6e5Tq/YbqDUOR1ILOJCmTNPC6DLdfR32wZK+ceOx2QuGlRM+BhuZ
         62JDTgvaCFyBrGOrC1m2pRwPEkLkbBV0m3L1zxtCS1hDV5y6UCfWcN9LCTqcbbyh3UEt
         t61Q8dS3YoGxtBbGEbkTHiJYkxeomTxFrTDQYjwgt8nHdMM3sYQweKFVzFUbKiENuhJe
         5YhxU1DcWk7LBzAoM7sso5lLUdlxQMJ7sy6tkuN3zMwf2ygG9PWQerdNP7Y+IHB/BgSn
         Gk7dXeW3DgxafGXgq6EbvnHzNIP1jvkOMjVn/zjt8RSkF8zGEHPEskmxIbJOFUuG0KWO
         9B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhRRKX0fxrsZsxuGGvSqETLa9jJ6bP3uK2nviMUaww8=;
        b=kZXP/VAHN4G52hYirYVTziDzWk4uWHYPEbp4gplbnxILM7UIccSYe66sv8CHBvhWrm
         mHppL+yRlJZ2XpfFfir87u5w6p5tWeDQ16CD+tjw+XQou1gB8DkzxS6XN7llxk1qKm0+
         BdD1jH8whbxxSfdNHz7yJgcijTi/SoeNyuO8JTvSfpZDWILqZ4Ku0ltR0bNrEzVrVDsi
         bXWqDrCD9qFu2AhyMPyOZkBJAj6cF0+bGNtJOnCd0/fF7TZR2F9ui2hOySaT9jj/xjps
         WvdXaZv8cNgbUvZld11XrYIFzSRN2fJqFWlU0H2RttRju/GPr87le4e+LCgOHOz7NPD3
         B27Q==
X-Gm-Message-State: APjAAAX2OXwlbsWvu8G5vWWtop2hDXbYGJ1gch7vADUxK8slu1f3eiU2
        7H+iJmPL1PrqWK60b41Dq3w=
X-Google-Smtp-Source: APXvYqw+dmlB6g/B6OjNDClm1dwW3Ewl8TIrKVG8Rkn/D5hzQbkJJc8ZUPzperBrsW07E0rICGUBUg==
X-Received: by 2002:aca:4155:: with SMTP id o82mr18894534oia.103.1571681954130;
        Mon, 21 Oct 2019 11:19:14 -0700 (PDT)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id t82sm4002463oie.12.2019.10.21.11.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:19:13 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-4-stuart.w.hayes@gmail.com>
 <20191021134729.GL2819@lahna.fi.intel.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <f4ace3ab-1b39-8a82-4cb6-a7a5d3bfbc72@gmail.com>
Date:   Mon, 21 Oct 2019 13:19:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191021134729.GL2819@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/21/19 8:47 AM, Mika Westerberg wrote:
> On Thu, Oct 17, 2019 at 03:32:56PM -0400, Stuart Hayes wrote:
>> Some systems have in-band presence detection disabled for hot-plug PCI
>> slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
>> On these systems, presence detect can become active well after the link is
>> reported to be active, which can cause the slots to be disabled after a
>> device is connected.
>>
>> Add a dmi table to flag these systems as having in-band presence disabled.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 02eb811a014f..4d377a2a62ce 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -14,6 +14,7 @@
>>  
>>  #define dev_fmt(fmt) "pciehp: " fmt
>>  
>> +#include <linux/dmi.h>
>>  #include <linux/kernel.h>
>>  #include <linux/types.h>
>>  #include <linux/jiffies.h>
>> @@ -26,6 +27,16 @@
>>  #include "../pci.h"
>>  #include "pciehp.h"
>>  
>> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
>> +	{
>> +		.ident = "Dell System",
>> +		.matches = {
>> +			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
> 
> Sorry if this has been discussed previously already but isn't this going
> to apply on all Dell systems, not just the affected ones? Is this the
> intention?
> 

Yes, that is the intention. Applying this just makes the hotplug code wait for 
the presence detect bit to be set before proceeding, which ideally wouldn't hurt 
anything--for devices that don't have inband presence detect disabled, presence
detect should already be up when the code in patch 2/3 starts to wait for it.

The only issue should be with broken hotplug implementations that don't ever 
bring presence detect active (these apparently exist)--but even those would still 
work, they would just take an extra second to come up.

On the other hand, a number of Dell systems have (and will have) NVMe 
implementations that have inband presence detect disabled (but they won't have
the new bit implemented to report that), and they don't work correctly without 
this.
