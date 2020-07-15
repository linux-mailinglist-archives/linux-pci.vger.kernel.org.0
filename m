Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D34221431
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGOSXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgGOSXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 14:23:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE96C061755;
        Wed, 15 Jul 2020 11:23:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n22so233877ejy.3;
        Wed, 15 Jul 2020 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1O8hMul/CJLSbV1N5c3JTA54EIaO3M+DVJ+l+X2WwY=;
        b=uONZHPpirU56iDmZf7UJPLf4XCv8SFTwAJCeF0ZahyHBh2Q1OZwv9p7PFDP0YsAK9v
         HWH1Qz9J+uEzZpnVXgmqPR6piZHgQeVFyzB5DWgE8/05Sh9s0hQ3THroLvv1ldx81Cu7
         78P78TU2pwfpEdKUXHZvo0/9asBMkzKlr4RaEigWa8zdpf2fGph1xxnFye4ImwlgoLKk
         HHX2/CW+BCqHhB/xZwEtYAlJNpMSq++rA2wRCULjRheyqx7teTCOWEKoH8n4hckjvd0C
         zwws5WFYH1YmucevJN7vUlkYZPrzwo4u5LIkLoNE6Avj0ZWE8bo/Olu7CZyVvEn/yAg+
         hY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1O8hMul/CJLSbV1N5c3JTA54EIaO3M+DVJ+l+X2WwY=;
        b=N+T3Pf07ChXnCRXfLt41uV7lpG7XAiGmNKGOOMo/pMjwhO+a9+uCXGzTwxQHCA1c6V
         Pji6CPDyXKZIOa92c/6gvqNVGvdAjYhis58P3K3aPWyhKvWaP7jqPnm7gxhb/fk2Tvly
         ONEY9thiSMeMuTjsLIEEA9D4dznXA3rDi4t7M/zVbTTstAy5sUOMtZOQBXeuLOKxe7al
         rBWO4gJtnZ0VnwufOy2T8pniasOjmZzv/85q4jHjZqhNsgAyEXjCBGlgo4gKfhuZG57p
         tjRKxwMX4xcBcipvF3oLXPy38vLIiDy4pEUB/3zCKJmPSbKcV/SLmxSMx4YMJTk6VZwf
         XdOw==
X-Gm-Message-State: AOAM530v8mZBSd4WaKFCU/MbIK0XmclJ7mZmOlnlSWRcNoWvg4cnWLsp
        uoBGWYF0yrzdwtILbXVEBE98BI89L3w=
X-Google-Smtp-Source: ABdhPJwlaflYv2TqUtLyq5VbaHKn8hR3K68nDNQ9YAiP4xnxsgqI9AEw9CvyJigjI4uMFC5edDMJuQ==
X-Received: by 2002:a17:906:c943:: with SMTP id fw3mr232794ejb.55.1594837379427;
        Wed, 15 Jul 2020 11:22:59 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:99de:6366:d65c:d599? (p200300ea8f23570099de6366d65cd599.dip0.t-ipconnect.de. [2003:ea:8f23:5700:99de:6366:d65c:d599])
        by smtp.googlemail.com with ESMTPSA id ai4sm2756085ejc.91.2020.07.15.11.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:22:58 -0700 (PDT)
Subject: Re: PCI: Disable not requested resource types in pci_enable_resources
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200710210924.GA80868@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <eeae5c45-a718-71d8-04e8-4042eaed54de@gmail.com>
Date:   Wed, 15 Jul 2020 20:22:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710210924.GA80868@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10.07.2020 23:09, Bjorn Helgaas wrote:
> On Thu, May 28, 2020 at 08:47:12PM +0200, Heiner Kallweit wrote:
>> Currently, if both resource types are enabled before the call, the mask
>> value doesn't matter. Means as of today I wouldn't be able to e.g.
>> disable PCI_COMMAND_IO. At least my interpretation is that mask defines
>> which resource types are enabled after the call. Therefore change the
>> behavior to disable not requested resource types.
>>
>> At least on my x86 devices this change doesn't have side effects.
> 
> Does this have a practical benefit?  If it fixes a bug or if there's
> something useful we can do because of this patch, I'll push it higher
> up the priority list.
> 
There's no big benefit. The current behavior just doesn't seem to be
consistent, and I don't see why we have a function pci_enable_device_mem().
Also after calling this function IO resources can be active.
So why not remove this function and use pci_enable_device() always.

Small benefit is that the change allows to guarantee that IO resources
are disabled after calling pci_enable_device_mem().
This might help to avoid using IO resources mistakenly in a driver.

>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/setup-res.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index d21fa04fa..6ef458c10 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -459,8 +459,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>>  	int i;
>>  	struct resource *r;
>>  
>> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> -	old_cmd = cmd;
>> +	pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>> +	cmd = old_cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
>>  
>>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>>  		if (!(mask & (1 << i)))
>> -- 
>> 2.26.2
>>

