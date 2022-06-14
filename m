Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5B054B50D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiFNPrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbiFNPrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 11:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6684F13F93
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655221669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3D5rXBFggKZyiDmUUePVR2BksUY/F8xwEAjtaxtYb8=;
        b=G/RDSnI7/j1r9uo/0cbVwoYGA7NlGM/El87MQ9VacvYb1hUkeUN2CrPiOPr+WVZ6MXDyfN
        uKJ/XVRyHtKvnA+7IUge9DQrSM/J2DP78UCcmJ2jXvC98Wb96UK/y61O1UP67EunSJjjXQ
        ao2Fc0qhwwoeE53gJ+GoRVOf4luR25k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-SxZIQYLSM3iknXmsU5JRcQ-1; Tue, 14 Jun 2022 11:47:47 -0400
X-MC-Unique: SxZIQYLSM3iknXmsU5JRcQ-1
Received: by mail-ej1-f72.google.com with SMTP id h16-20020a1709070b1000b00713a3941a27so2958155ejl.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 08:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c3D5rXBFggKZyiDmUUePVR2BksUY/F8xwEAjtaxtYb8=;
        b=X42+A4pprrAv1zCOMyeLDDkw8IgJwism4Zv1VSaMFbtqy46Dw1jn3hJsfAOt6WFA02
         Cl8AZz+DrIEPJRtlG7KQZNFIirhrzcaamFVGs2oDBtEwz3dMf9L+hOo4d5BFBtJrAyfN
         IbEhotJSgxubWuxcUBl+MuaBT70x5uqzlNCULHBjhXcIHt7ioAEdi5bV5xBGWw7QDZYp
         kE1vzwHhEQvvBvWWynxBi47ge7ZTPM4Y7xkC264JK0L4vM3cep6nfG5HEsbYQ9zE3XDa
         tRkxK+oHdbPbTyogYv6+gKF6xfPFrCrZAXLDsuXcoeKYsbhDR6whr090K55nwOHJZp1/
         VbzQ==
X-Gm-Message-State: AJIora/hng5vj4yZyBYRiQq4a61VoS5GZgcOyuvCYbkh8OMYyNY/1I3Z
        jFhBUUON9HvPdzJQGbuA4mZL7tZXW7vFH4XwXvcZqtQWIX56g5VKwy0aISVx1PDrjtGomO5ZWCs
        Npqfqe1oZEb2iPAeIA0HE
X-Received: by 2002:a17:907:9496:b0:711:f459:664 with SMTP id dm22-20020a170907949600b00711f4590664mr4822927ejc.704.1655221665112;
        Tue, 14 Jun 2022 08:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uL7b2WJ9GqE48Lc8Oa55SIbLe3r72HnMhv92SlzzeuVVgeUFDg0m6ZrYBmGVWItHxA6UV0/w==
X-Received: by 2002:a17:907:9496:b0:711:f459:664 with SMTP id dm22-20020a170907949600b00711f4590664mr4822894ejc.704.1655221664848;
        Tue, 14 Jun 2022 08:47:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u26-20020a170906951a00b00709e786c7b2sm5142116ejx.213.2022.06.14.08.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:47:44 -0700 (PDT)
Message-ID: <5c8923df-3d89-c7be-690d-fbef2c53eeb6@redhat.com>
Date:   Tue, 14 Jun 2022 17:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20220614151708.GA756100@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220614151708.GA756100@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/14/22 17:17, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2022 at 10:15:29AM +0200, Hans de Goede wrote:
>> On 6/14/22 01:15, Bjorn Helgaas wrote:
>>> On Sun, Jun 12, 2022 at 04:43:25PM +0200, Hans de Goede wrote:
>>>> Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
>>>> instead of clipping from arch_remove_reservations(), has a number of
>>>> unforseen consequences.
>>>>
>>>> If there is an e820 reservation in the middle of a bridge window, then
>>>> the smallest of the 2 remaining parts of the window will be also clipped
>>>> off. Where as the previous code would clip regions requested by devices,
>>>> rather then the entire window, leaving regions which were either entirely
>>>> above or below a reservation in the middle of the window alone.
>>>>
>>>> E.g. on the Steam Deck this leads to this log message:
>>>>
>>>> acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]
>>>>
>>>> which then gets followed by these log messages:
>>>>
>>>> pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
>>>> pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window
>>>>
>>>> and many more of these. Ultimately this leads to the Steam Deck
>>>> no longer booting properly, so revert the change.
>>>>
>>>> Note this is not a clean revert, this revert keeps the later change
>>>> to make the clipping dependent on a new pci_use_e820 bool, moving
>>>> the checking of this bool to arch_remove_reservations().
>>>
>>> 4c5e242d3e93 was definitely a mistake (my fault).  My intent was to
>>> mainly to improve logging of the clipping, but I didn't implement it
>>> well.
>>>
>>> That said, I'd like to understand the connection between the messages
>>> you mention and the failure.  There are four bridges whose MMIO
>>> windows were in the [mem 0x80000000-0x9fffffff] area that we clipped
>>> out.  The log shows that we moved all those windows and the devices in
>>> them to the [mem 0xa0100000-0xf7ffffff] area that remained after
>>> clipping.
>>>
>>> So I think this *should* have worked even though we moved things
>>> around unnecessarily.  What am I missing?
>>
>> I don't know? My guess is that maybe the ACPI table do MMIO accesses
>> somewhere to hardcoded addresses and moving things breaks the ACPI
>> tables.
> 
> This would be a firmware defect, IMHO.  There is a mechanism (_DSM for
> preserving PCI Boot Configurations) for the firmware to tell us about
> things that can't be moved.
> 
>>> The E820 map reports [mem 0xa0000000-0xa00fffff] in the middle of the
>>> _CRS, and we currently trim that out.  We think this is a firmware
>>> defect, so it's likely to break in 2023 if we stop clipping by
>>> default.  I'm concerned that there may be other things in _CRS that we
>>> need to avoid, but firmware isn't telling us about them.
>>>
>>> Or there's some dependency in the devices that we moved on their
>>> original addresses, e.g., firmware on the device latched the address
>>> and didn't notice the reassignment.
>>
>> Right this is the most likely cause I believe.
> 
> This would be another defect, in the device this time.  If we can
> identify the device, possibly we could quirk around it.
> 
> Either one will be back to bite us in the future if we support
> rebalancing resources to make room for hot-added devices.  I *think*
> Windows already supports this kind of rebalancing.  Anyway, this is
> why we need to dig a little deeper to figure out exactly what's going
> wrong here.

Have you looked at the log of the failed boot in the Steam Deck kernel
bugzilla? Everything there seems to work just fine and then the system
just hangs. I think that maybe it cannot find its root disk, so maybe
an NVME issue ?

I'm afraid that if we cannot figure out the exact root cause from
the failed boot log there is not much more we can do. Unless you
have an idea how to debug this further and want to ask the reporter
for more info?

Regards,

Hans

