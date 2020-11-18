Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E810A2B8867
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 00:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKRX3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 18:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgKRX3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 18:29:00 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC8C0613D4;
        Wed, 18 Nov 2020 15:29:00 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so5203704ejb.8;
        Wed, 18 Nov 2020 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e0yt+kjbi4dIB9ykfTGW4em90JKmbOqf3Gnqdz/x2fI=;
        b=tgHgZE7AQVnG92dr+Sv6x+j1IwQiNUXoYR2kkspBMQ5TQQQQtS2xSKLp+z+wTu+Pgc
         qove6v58cjZP9cjpuuTku36Vjaiet6J8pPyjGIqMB0w2nCFQPgEUJ1HK12psbF4vCJJ0
         bVEf7WOFiNj0NxSN8IfZTNV3EqNmsnoTrB7UGlQFbN85LIGIGlM9gcj1096ckJSN40Zm
         HzHSpjcF3XokiZMAYIBk0sjEM9faMoTkOdTnZ4cBRxlBmr+Kl0E4VIFzXbF406qTfJJ8
         OHRG7h69b9r1sju1FYJBanpf2nYL0gs2uYBD2DjgOYOT5xRFONRppP80lKbJMh9iHsZD
         J1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0yt+kjbi4dIB9ykfTGW4em90JKmbOqf3Gnqdz/x2fI=;
        b=E1y4NhaJfkAj5ZhPGPgi2J8kmf1z05YM/TepbAYKV7YEenmiCrc/0p+9iaBFVVxErg
         55LnKyTQ7WHG0DVQvqEZo6YTUvRiJ2CGjFw9MvZvO7FBPFO8u2JJnWp0WAec5GibJ+Lk
         5DP7u+vb/fvS2nT3YCV+aoKFjdfDySPevAK2otjlREoxa53s/x2Cjks3BatgvZjYvtkV
         Vx4PbxzLr9An5oQerROtvtxaMGaSN3WH7Sm7U4kFInhs2LKTTU7RSJg0sIdgpd6In6hQ
         MpkBXebsZ6U3GQvA91M5yEodJeK615k6aoXeP9og1ZG3JKrwyi2ypAE3dYtUtjIM3Y95
         gAMQ==
X-Gm-Message-State: AOAM531hLy84lvKlsSruUshPZDSRpc7Ek1iqOWZdEcHfrL/2AP7RNnLZ
        dgcEhJf3XfFfQvu6fyWd2m+xqX8IZ2I=
X-Google-Smtp-Source: ABdhPJwPAiEJGzod731j3l6fabJT0bexhL15PIxBbKfPrj5/BFETl7VO3i/KEhfSS1TgS+spUmk3Ag==
X-Received: by 2002:a17:906:b20c:: with SMTP id p12mr25824082ejz.369.1605742138332;
        Wed, 18 Nov 2020 15:28:58 -0800 (PST)
Received: from [192.168.2.202] (pd9e5ae8d.dip0.t-ipconnect.de. [217.229.174.141])
        by smtp.gmail.com with ESMTPSA id v1sm11282271eds.25.2020.11.18.15.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 15:28:57 -0800 (PST)
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201118174933.GA21165@bjorn-Precision-5520>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <93b274fe-5e01-e19e-7870-e3f980385dc1@gmail.com>
Date:   Thu, 19 Nov 2020 00:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118174933.GA21165@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/20 6:49 PM, Bjorn Helgaas wrote:
> On Sun, Nov 15, 2020 at 10:19:22PM +0100, Maximilian Luz wrote:
>> On 11/15/20 9:27 PM, Bjorn Helgaas wrote:
>>
>> [...]
>>
>>> I think something read from sysfs is a snapshot with no guarantee
>>> about how long it will remain valid, so I don't see a problem with the
>>> value being stale by the time userspace consumes it.
>>
>> I agree on this, and the READ_ONCE won't protect against it. The
>> READ_ONCE would only protect against future changes, e.g. something like
>>
>>      const char *state_names[] = { ... };
>>
>>      // check if state is invalid
>>      if (READ(pci_dev->current_state) >= ARRAY_SIZE(state_names))
>>              return sprintf(..., "invalid");
>>      else    // look state up in table
>>              return sprintf(..., state_names[READ(pci_dev->current_state)])
>>
>> Note that I've explicitly marked the problematic reads here: If those
>> are done separately, the invalidity check may pass, but by the time the
>> state name is looked up, the value may have changed and may be invalid.
>>
>> Note further that if we have something like
>>
>>      pci_power_t state = pci_dev->current_state;
>>
>> the compiler is, in theory, free to replace each access to "state" with
>> a read to pci_dev->current_state. As far as I can tell, the whole point
>> of READ_ONCE is to prevent that and ensure that there is only one read.
>>
>> Note also that something like this could be easily introduced by
>> changing the code in pci_power_name(), as that is likely inlined by the
>> compiler. I'm not entirely sure, but I think that the compiler is allowed
>> to, at least theoretically, split that into two reads here and inlining
>> might be done before further optimization.
>>
>> On the other hand, the changes that could lead to issues above are
>> fairly unlikely to cause them as the compiler will _probably_ read the
>> value only once anyways.
> 
> Well, OK, I see your point.  But I'm not convinced it's worth
> cluttering the code for this.  There must be dozens of similar cases,
> and if we do need to worry about this, I'd like to do it
> systematically for all of drivers/pci/ instead of doing it piecemeal.

Fair enough, that's a valid point.

For full formal correctness, writes to current_state should probably
have also been guarded with WRITE_ONCE to prevent the compiler from
splitting the write instruction in addition to the read with READ_ONCE
in this patch.

Again, that's mostly a point about formal correctness and issues like
that shouldn't happen in practice (or if they would, would probably have
broken other parts of the kernel already).

Looking at other sysfs functions, it seems like most of them would have
the same issues, so it makes sense to drop the READ_ONCE.

> I do think it's probably worth making sure we can't set
> dev->current_state to something that's invalid, and also taking a look
> at the PCI core interfaces that take a pci_power_t, i.e., those in
> include/linux/pci.h, to make sure they do the right thing if a driver
> supplies garbage.

As far as I can tell, those checks should already be there.

Thanks,
Max
