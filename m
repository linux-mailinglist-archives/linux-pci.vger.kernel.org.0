Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD63C1B71
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhGHWbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHWbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 18:31:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D947C061574;
        Thu,  8 Jul 2021 15:28:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q184so4335095ljq.0;
        Thu, 08 Jul 2021 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=AqbpJ/vzfCUi++Lrt9i6vX2WjRS/QO6GgOjj5ClJ7wo=;
        b=IR4hD0JMJHJdJKQjb4R/xJQmLr/oFmlzz2nUoYApYcOcb9S+QmFX2WS0jN4scM+QsP
         8S4WVT5dBDJCKusXGiftTsdaHs283M4m6lLlCkUl9v8NLi9Ggehc6bX4U9K+B0ZGOtOZ
         57M1Xot91So4IKp85WRWAKVs2VZfsdT5PXODFuHeiiz5WIdZBdaYlOvL7h4soZwkchS+
         vLklbE4eYnox+e5HwfmkNbImxxrT1ZmlDWQeBvrAuISTAtTKqRJS1yaqPM9ce+hypFFi
         Viy5nP8rJc8hX+q4XlpbdRJ27r9jHMpMok/QmiR4Ph6KSu9txYt5pP2C+J1oebOD5ope
         EQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=AqbpJ/vzfCUi++Lrt9i6vX2WjRS/QO6GgOjj5ClJ7wo=;
        b=JTAJjLMsLQi4/TnGImZVprXuW6aiNF7kEm8L/KPtZWqpCdH/mxD50oM39IzNUjQLK7
         bjinBpZYLoi/TuA4W+khJSoutNssDLwQOEbULzkmEDDPEuxUZsU3gDkRouZgdvSHQs0y
         OoREGmSsEec/QSjkL3YRxhF9IW0B82vFBJXRqrSITV9YOdRWHbLmeBjYmYgZzO1tUNGn
         LQx/q3L8BdGA3i2Oh0qNbvxHynhGek1AABqgb93vJpuNKCKDw3EhSkeTVs5KyrgWni35
         JpCD1a9sAL6rHsFFK27+f6wepj8rsvUMs0hIWHjtFKcDxwe2EowfoEMvJhsGQtgW9spc
         MW6g==
X-Gm-Message-State: AOAM530yVTXrQ8TDAN5fbweo0fQkfFntzQWOnmy0cQQ/UCrqC7rDRlkb
        ioNG8MdLLlOeE7xwl1ze4AA=
X-Google-Smtp-Source: ABdhPJw+WCaKvBBipNv2bVZHQtDkxTm0ja9OtDsNpIwdc9Rztn64vX21tBpzp1cqd2VMOaXorxJ1vg==
X-Received: by 2002:a2e:81c8:: with SMTP id s8mr6659564ljg.324.1625783316721;
        Thu, 08 Jul 2021 15:28:36 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id a15sm362883ljn.26.2021.07.08.15.28.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 08 Jul 2021 15:28:36 -0700 (PDT)
Message-ID: <60E77EBF.2020605@gmail.com>
Date:   Fri, 09 Jul 2021 01:39:59 +0300
From:   Nikolai Zhubr <zhubr.2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Handle PIRQ routing tables with no router
 device given
References: <alpine.DEB.2.21.2107061320570.1711@angie.orcam.me.uk> <60E726E2.2050104@gmail.com> <alpine.DEB.2.21.2107082226040.6599@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2107082226040.6599@angie.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

08.07.2021 23:45, Maciej W. Rozycki:
>   Have you tried contacting Nvidia about your ALI chipset?  Back in the day
> I tried to avoid undocumented stuff and Intel was reasonably open about
> most of their chipsets.

Well, being neither their customer nor a kernel developer, I'm not sure 
my request would be considered serious. Anyway, probably I'll give it a 
try a bit later when I have an opportunity to dismount this board for 
more comfortable testing. I was also going to try to modify its BIOS to 
remove some unwanted behaviour unrelated to IRQs, and it might happen 
that I also discover something about PCI handling along with (It is just 
64k size, after all, and I have a 8086 debugger)


Thank you,

Regards,
Nikolai


>    Maciej
>

