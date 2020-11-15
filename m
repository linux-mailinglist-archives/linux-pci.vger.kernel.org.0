Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195D72B34F5
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 13:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKOMpZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 07:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKOMpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 07:45:25 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973EC0613D1;
        Sun, 15 Nov 2020 04:45:23 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so15653419wrf.12;
        Sun, 15 Nov 2020 04:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UD5PdOGagx7VYcctZvzUbtmNTDYW+xMH7eNa7mMsWsk=;
        b=DN/0wuKaUI9AH1CmxAp6BQpisOoaM4e1y5fkYpdr/mOxuik7ODUG3YEe05u/ny+0Ir
         et87z9FAnuEbxfE8PQeo1R1Ly8Ast4RFdClNVFGRhUmZ+SgDSAEVXJVu2vmQR8vcRx1E
         rjUqez1g6zjj3AI6SVeKeayuDDaLXfAs4qJXl5It+mjRBnErJEZuhbDD64dFeb9E7cke
         49NvwYDGPtRZ4l2apL+zDBZ+unI3NYYcw5eg4mHcdIXSv/a9cI8zUDd1gAKMz8MLOQcK
         M5396SKLYJnEnuKSmlWj1vQPemgfEG919tUf+B4JCei6O2H9j0FdrDnNzBnVNn7iQboy
         K0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UD5PdOGagx7VYcctZvzUbtmNTDYW+xMH7eNa7mMsWsk=;
        b=Jiq8fWb/mrAZju2y4BoRTb11GNeMO/w1+R+dDKRSA92ehxyre7SNjThu2UhhDaLQo7
         zSou1GatG/Pt+InW/yuk3AMre9ifPKmuhx49mgtIi+LM6obGWwp0WikBU8DEKzSuv3x7
         u1YU+OEPBb0xMJVWUxLspPl84jMj4o1F8cDnPAuQzVqw162dP9gA/SdmKoaYF0AvwulA
         8XObbwp9VnyI+m34s/1/lT/jx2oJettvkOELCZy7Wb4srFZWmKL+4v0akb7H9asE0XXH
         8oVPVXRlKSGdQnH7fzJY8cQhvXXtEwozGnlBmGtTpeegnY8qVFEbglPg7+S18ViWCK89
         1afA==
X-Gm-Message-State: AOAM532WAN49RUIPQkgvE16XbUGqFlm+VXWF7yR0TsM8p847Zci998aD
        gJHi76zfVMyVVvF1KutB7hg33FOkH+g=
X-Google-Smtp-Source: ABdhPJx+qpJdaWkqbtIvulSiHTmuTRUM4cQSM4WI7FPKiFcttq9jPRuXo0fB0Kcf8EzswNShyHB3Zg==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr6979638wrp.176.1605444321535;
        Sun, 15 Nov 2020 04:45:21 -0800 (PST)
Received: from [192.168.2.202] (p5487b28b.dip0.t-ipconnect.de. [84.135.178.139])
        by smtp.gmail.com with ESMTPSA id t11sm12099874wrm.8.2020.11.15.04.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 04:45:20 -0800 (PST)
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201102141520.831630-1-luzmaximilian@gmail.com>
 <X7DF2ZyVnyIFjdC1@rocinante>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <688dcd74-3acc-bc28-7ba3-55fdedbe6e70@gmail.com>
Date:   Sun, 15 Nov 2020 13:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <X7DF2ZyVnyIFjdC1@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/20 7:08 AM, Krzysztof Wilczyński wrote:
> Hi Maximilian,
> 
> On 20-11-02 15:15:20, Maximilian Luz wrote:
>> While most PCI power-states can be queried from user-space via lspci,
>> this has some limits. Specifically, lspci fails to provide an accurate
>> value when the device is in D3cold as it has to resume the device before
>> it can access its power state via the configuration space, leading to it
>> reporting D0 or another on-state. Thus lspci can, for example, not be
>> used to diagnose power-consumption issues for devices that can enter
>> D3cold or to ensure that devices properly enter D3cold at all.
>>
>> To alleviate this issue, introduce a new sysfs device attribute for the
>> PCI power state, showing the current power state as seen by the kernel.
> 
> Very nice!  Thank you for adding this.
> 
> [...]
>> +/* PCI power state */
>> +static ssize_t power_state_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct pci_dev *pci_dev = to_pci_dev(dev);
>> +	pci_power_t state = READ_ONCE(pci_dev->current_state);
>> +
>> +	return sprintf(buf, "%s\n", pci_power_name(state));
>> +}
>> +static DEVICE_ATTR_RO(power_state);
> [...]
> 
> Curious, why did you decide to use the READ_ONCE() macro here?  Some
> other drivers exposing data through sysfs use, but certainly not all.

As far as I can tell current_state is normally guarded by the device
lock, but here we don't hold that lock. I generally prefer to be
explicit about those kinds of access, if only to document that the value
can change here.

In this case it should work fine without it, but this also has the
benefit that if someone were to add a change like

   if (state > x)
           state = y;

later on (here or even in pci_power_name() due to inlining), things
wouldn't break as we explicitly forbid the compiler to load
current_state more than once. Without the READ_ONCE, the compiler would
be theoretically allowed to do two separate reads then (although
arguably unlikely it would end up doing that).

Also there's no downside of marking it as READ_ONCE here as far as I can
tell, as in that context the value will always have to be loaded from
memory.

So in short, mostly personal preference rooted in documentation and
avoiding potential (unlikely) future mishaps.

Regards,
Max
