Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A4D2EA11C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhADXt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhADXt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 18:49:59 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5DC061793;
        Mon,  4 Jan 2021 15:49:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a12so68564224lfl.6;
        Mon, 04 Jan 2021 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PShG+Qq5k6+r7xZ57pS5cb6jJ0Jc6yi+01TS3XP6TuE=;
        b=DT/jVhiwVD3jnpjsqsiXYuiyejNvoi+gLghVKeCYwIw4HlKXseU8BIedZ/+WTiH0Z3
         zLihUpXowY1SqcEnevolZI/3PjpzwfzXPHyReDHrOKNC/vN2vzNUm2QsCEZ6IK+nkMFp
         OzHpJLNodEaje91dc8uRiEYaPVP7lSzliRuutacJDIMv1nSsxUmT5d52Xi5mmcRZEiB9
         GKFrBek0aNqC1BaE/N+/jL090jPPad5S+9I4xGrzj8I1tf62yHO/PdQ/rj09SCYXsv2y
         GDZFSxtj4fxKP8iDLpVkBsTmknZGDt+hkxBsoxMorbRq6b00HlGeT6qg46GWvFSlmXOk
         2shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PShG+Qq5k6+r7xZ57pS5cb6jJ0Jc6yi+01TS3XP6TuE=;
        b=VnprkOc9+UPLcQoLGOedgQ7Pqg+KRcPa2UuR6If12fXehyR7mronlYKVEotDcLef2o
         UiRAjMGhraHDBXy2gV0EfV6wGdI3syV91xpF+UKURYsO/gxk9/T/zLnv5AdW02QoZim0
         qW5YghU3mO+G2X8VCJmmd7Mdv4Nk2h0AaZhDz1cAVE5ZRBGxVFRCaKE7ctFOzdlfY1aK
         32eSxXQAFnhl+f2CJvBTxmmK7ZVzV0Ue/BkrR7Y4F7PoQ8hz+xJ+LqA+qsthzdbudusK
         gFcb1HnNW6yO+pPUn59SkDlHhQi7Ae+nK1h+5LbtqQlR9MopPkjcQVQ/zfk8tI/snaNM
         efpw==
X-Gm-Message-State: AOAM530M188qLCPeQSDQXo/NEX+Og04PFup/OrzFB46InJiyUNeAhb/X
        F+qcj6TjEVeKj/kBbR5IXEq+neeCk3w=
X-Google-Smtp-Source: ABdhPJzUCidGv3A54yVnGy+7OtJq2DPpzGM856R6srNtJHFhTo4SCuuG9fSaWHPRMj9AxaRTh9xwoA==
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr81142010wrp.35.1609792375150;
        Mon, 04 Jan 2021 12:32:55 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:7409:b966:5a79:f8df? (p200300ea8f0655007409b9665a79f8df.dip0.t-ipconnect.de. [2003:ea:8f06:5500:7409:b966:5a79:f8df])
        by smtp.googlemail.com with ESMTPSA id c10sm97895791wrb.92.2021.01.04.12.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 12:32:54 -0800 (PST)
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
 <20201231040735.GA2075@wunner.de>
 <4eb10092-e3f9-c9be-2dec-e6de8aeedf97@gmail.com>
 <20210104173944.GA31187@wunner.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a827d419-3c3f-5534-c2c5-63cd6ab49b8c@gmail.com>
Date:   Mon, 4 Jan 2021 21:32:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210104173944.GA31187@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04.01.2021 18:39, Lukas Wunner wrote:
> On Thu, Dec 31, 2020 at 10:38:12AM +0100, Heiner Kallweit wrote:
>> On 31.12.2020 05:07, Lukas Wunner wrote:
>>> FWIW, if platform_pci_power_manageable() returns true, it can probably
>>> be assumed that allowing runtime PM by default is okay.  So as a first
>>> step, you may want to call that instead of adding a new callback.
>>
>> I don't think that's sufficient. Most likely all the broken old systems
>> return true for platform_pci_power_manageable().
> 
> platform_pci_power_manageable() is not a global flag, but rather
> a per-device flag whether the platform is capable of power-managing
> that device.  E.g. for the ACPI platform, it indicates that objects
> such as _PS0 or _PS3 are present in the device's namespace.
> 
> My point is that if the platform can power-manage a device,
> then it ought to be safe to enable runtime PM by default for it.
> 
Not sure about that. Just that the BIOS claims it can power-manage
the device, doesn't rule out that it's broken and fails to do so.

> If you insist on a "big hammer" approach by turning on runtime PM
> by default for everything, you risk regressions.  You can avoid
> that by going for a smart approach which enables runtime PM in
> cases when it's safe.
> 
> Thanks,
> 
> Lukas
> 
Heiner
