Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706BD421DC8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 07:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhJEFE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 01:04:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35600
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhJEFE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 01:04:26 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9AE33402E1
        for <linux-pci@vger.kernel.org>; Tue,  5 Oct 2021 05:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633410152;
        bh=4sv1HPCgRHpn4yyOFITBxjMLxNIHOvFNMiBGKmMcH4k=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=vvalc3mvXOQ3g1yrOrBn8g0EqBaCQlMxOr85d8lNUBE3JwoVtDMhaINKTSXW6tUwG
         1yeQWAHACG4Xn/6kGiEMdnEk+r6zE6QOw7jIAk/+zhUgjwwzYSDjLFXreygVjIDa5O
         vExidkOjIqaE7lddhb5tGqSUYJVrctx0RMwBqi2BXwVTyKkPSUm3wxjT1chfbqGnSS
         aAUmGANzz4vDlX2CDuVkVhK0MoOJx0em05z6H8r0dnotrsyi8lUpYYDJl8khOkrLtM
         xMDCIqS0CDdKXghrrEJ7hLk9WpT45kXawhQWxw8kmno8L0qLjT3IIMVh5EulC8S8Nc
         llUqsXnxj/Otg==
Received: by mail-pj1-f71.google.com with SMTP id m6-20020a17090a7f8600b0019f0e6d9b81so847854pjl.7
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 22:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4sv1HPCgRHpn4yyOFITBxjMLxNIHOvFNMiBGKmMcH4k=;
        b=eKIbGT5RBXSZ4ZEcgbsC0hImqLB00N0BPlXcrDQalTmRc5uVmFFEvaX4/26RVaeE5T
         Ovd6JPh8u/vOPJPGIC7FiiVXmgLdRAx6N8g3U0r3pK4rLrsSEzbBBZm0t5xmTfBPw2ra
         mlN+Rgcty8jl4cs9s4erMuZFy9fyct91C71wpoDdcEkd9ET0pQS6mKFsLYTX9ru4qmju
         lqw4F5eQGH09CipKSfBZvK40k9a4ESY8QhKc2wI0t+tgd8NS/oQmHE+UkvyBmCqw1aqv
         UZ3dqqEcCSnrhqf9gxdHHuRjHxYI1MaBwA7doGu1jWJhX/58W7mN3BLw4CDGrQFKV4se
         qNrg==
X-Gm-Message-State: AOAM530we2mWr3N8OzLcm9jwFjrnQ1CHou9CHFHdPlLhZi4tFDogUjOp
        nRFPyHSuOZWA9dY1G6c88ipQErZJKvI5hX52+ltxIhuHnqWMcX3N3UY4aSF2gz5ozWuHEF3QzZP
        v3q0btQba5a0ZgBzkMMKQeznkYzrwkkHGMQsa1g==
X-Received: by 2002:a63:f80a:: with SMTP id n10mr13873453pgh.303.1633410151084;
        Mon, 04 Oct 2021 22:02:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhJ2fHJ+dmvfkCeHi0hcYcdtJHYxmYJcUqsJ34pBYhVK4O+ZYTX3mcaGYC7tek2r//0a/SZA==
X-Received: by 2002:a63:f80a:: with SMTP id n10mr13873440pgh.303.1633410150715;
        Mon, 04 Oct 2021 22:02:30 -0700 (PDT)
Received: from [192.168.1.107] (125-237-197-94-fibre.sparkbb.co.nz. [125.237.197.94])
        by smtp.gmail.com with ESMTPSA id b23sm16272954pfi.135.2021.10.04.22.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 22:02:30 -0700 (PDT)
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
 <20210914104301.48270518.alex.williamson@redhat.com>
 <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
 <20210915103235.097202d2.alex.williamson@redhat.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Message-ID: <2fadf33d-8487-94c2-4460-2a20fdb2ea12@canonical.com>
Date:   Tue, 5 Oct 2021 18:02:24 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915103235.097202d2.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

Have you had an opportunity to have a look at this a bit deeper?

On 16/09/21 4:32 am, Alex Williamson wrote:
> 
> Adding debugging to the vfio-pci interrupt handler, it's correctly
> deferring the interrupt as the GPU device is not identifying itself as
> the source of the interrupt via the status register.  In fact, setting
> the disable INTx bit in the GPU command register while the interrupt
> storm occurs does not stop the interrupts.
> 
> The interrupt storm does seem to be related to the bus resets, but I
> can't figure out yet how multiple devices per switch factors into the
> issue.  Serializing all bus resets via a mutex doesn't seem to change
> the behavior.
> 
> I'm still investigating, but if anyone knows how to get access to the
> Broadcom datasheet or errata for this switch, please let me know.

We have managed to obtain a recent errata for this switch, and it 
doesn't
 mention any interrupt storms with nested switches. What would 
I be looking for
 in the errata? I cannot share our copy, sorry.



Is there anything that we can do to help?



Thanks,

Matthew
