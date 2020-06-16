Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957B61FBC88
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgFPRNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 13:13:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35347 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgFPRN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2020 13:13:29 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ian.may@canonical.com>)
        id 1jlF9L-0000DB-RU
        for linux-pci@vger.kernel.org; Tue, 16 Jun 2020 17:13:27 +0000
Received: by mail-qt1-f199.google.com with SMTP id l26so17274620qtr.14
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2020 10:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ulzfz4eBKOqWRFZsEkPCP353t+waPJ8/kbkJwaQzZ8M=;
        b=iREMpDeMmSPCxrIaCChajsC0Ht5IrcFbhy8A6xKvgLtXPRA6dmHO1mBMfDbPcZNz2y
         CRinbUvT+jPnRGYrXccKPh4wHoRgNPnOb2ll600q5Z9CINlU+zJ38HuP/lHVMO3fFFuz
         TltMcoglNgy5JDCeIdOGMs6vlq1+4WH3IgazkTYYH4TfEKYhFEX9GxPBR0KZH1hoRrAR
         sjzp3OS9+d5WunZeNla3d67CqRwNFP5CoZZCs6l4r/XO4oHKC50PAcoal5NQV8szAS5n
         10VNhyPz/O5Vc0KytBP0/IoEv5l9TrMGji0lSkfk6HPz7kAlLqPNyT/PBKcqDEYAXIWn
         4AnA==
X-Gm-Message-State: AOAM530XBCirr+y0hBnK//6QikvheCBv2B378EQOTF7aDiPObRlxT2e1
        +AHuvcS3272tAsXNNhiJ2vqHJusBwpow4GqdR8n3Et3zrv4MeH1YKifFu4Gp5hsbb4neD+LCiws
        wPR2iRq8eMPCfc8Gw9UTpgLA74OYcH1cIkzIpMQ==
X-Received: by 2002:ac8:176f:: with SMTP id u44mr23473061qtk.0.1592327606736;
        Tue, 16 Jun 2020 10:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIrQeBmiY2i2q8vUw8Z7YAxeIGSaGbkPAa/BdO9krD7sebzuV/riUdmbb6KfJ3nvpnjTC7Lg==
X-Received: by 2002:ac8:176f:: with SMTP id u44mr23473030qtk.0.1592327606284;
        Tue, 16 Jun 2020 10:13:26 -0700 (PDT)
Received: from ?IPv6:2001:67c:1562:8007::aac:44bb? ([2001:67c:1562:8007::aac:44bb])
        by smtp.gmail.com with ESMTPSA id c191sm14409931qke.114.2020.06.16.10.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:13:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCIe hotplug interrupt and AER deadlock with
 reset_lock and device_lock
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org
References: <20200615143250.438252-1-ian.may@canonical.com>
 <20200615143250.438252-2-ian.may@canonical.com>
 <20200615185650.mzxndbw7ghvh5qiv@wunner.de>
From:   Ian May <ian.may@canonical.com>
Message-ID: <0598848d-47ab-f436-04ea-7ef1f348905b@canonical.com>
Date:   Tue, 16 Jun 2020 12:13:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615185650.mzxndbw7ghvh5qiv@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thanks for the quick reply!  I like your solution and have confirmed it
solves the first deadlock we see between the Hotplug interrupt and AER
recovery.

Thanks,
Ian

On 6/15/20 1:56 PM, Lukas Wunner wrote:
> On Mon, Jun 15, 2020 at 09:32:49AM -0500, Ian May wrote:
>> Currently when a hotplug interrupt and AER recovery triggers simultaneously
>> the following deadlock can occur.
>>
>>         Hotplug				       AER
>> ----------------------------       ---------------------------
>> device_lock(&dev->dev)		   down_write(&ctrl->reset_lock)
>> down_read(&ctrl->reset_lock)       device_lock(&dev->dev)
>>
>> This patch adds a reset_lock and reset_unlock hotplug_slot_op.
>> This would allow the controller reset_lock/reset_unlock to be moved
>> from pciehp_reset_slot to pci_slot_reset function allowing the controller
>> reset_lock to be acquired before the device lock allowing for both hotplug
>> and AER to grab the reset_lock and device lock in proper order.
> I've posted a patch to address such issues on Mar 31, just haven't
> gotten around to respin it with a proper commit message:
>
> https://lore.kernel.org/linux-pci/20200331130139.46oxbade6rcbaicb@wunner.de/
>
> I've solved it by moving the reset lock into struct pci_slot.
> I think that's simpler than adding two callbacks.
>
> Do you think the AER deadlock could be fixed based on my approach?
>
> Thanks,
>
> Lukas

