Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626F929D2DF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgJ1VhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbgJ1VhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ieKfFfqFnN+m7eiFTYtg/05VZ570w2kYMSRpQ5oFNQ=;
        b=GSYYGONGOoXlPTpLlh+Q2piGxzkI6whM7DjUf4Nn+DDNWWx80bxPeCKbHKhhFy/rcaLZw8
        b0T0oAcdXdQ8VsZ1z06aa0g1CPUe+ea0ivkEekT43vcGpwjGshjZS20C/NRBJ439pGaE1b
        w4AWa92gxyIVpJQgBzYKyoUJruavHZc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-eU_4mMnoOKmNkxCMEu8u8g-1; Wed, 28 Oct 2020 09:36:17 -0400
X-MC-Unique: eU_4mMnoOKmNkxCMEu8u8g-1
Received: by mail-io1-f69.google.com with SMTP id a2so3317602iod.13
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 06:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2ieKfFfqFnN+m7eiFTYtg/05VZ570w2kYMSRpQ5oFNQ=;
        b=T4oUAGSacUkUoj7I5EtN7IcpEAs1OIKEvSmo5x281QvqEQSVLF3UTo4C3LEY6ZMonl
         /ffwPLgLuoyOUMdFyYykBx+Ej0XERJeDMVy+OSsoun4kQxSnOQPP5gCneFkX5925tTg0
         UtnuZQIcCsWKNRvuSXhG5jeM2KjRwtIavW5yg8p0EHXY30d+EzXDwZKs67014BiAXAIg
         weJyQhALy5yUTGMP2BD10F3/lph3zK6J5VOuoOWJHElBLzeRpEup0XkCt1PLKQDF10+t
         P/LwCzKtVvL3UMc5IgydQJo017qsaLTlwYX1X7jCecAUfaOcTCgWXxFcxh6zi/PLKTNS
         KTpw==
X-Gm-Message-State: AOAM532OnltRZNh7IB8Xr2dZqyDWf0kkrFqv+/F13wBxfed7RQlqn1Qz
        A1rfE+Kb9sVp7dn7M1OtWTHhD4SOzks3VxCnJgC5s6pnngQfEJaLBYU4vzX3ao4cOGaUoQJhnJ7
        ZhpEyFzXw5K8Wr34rRnE2
X-Received: by 2002:a92:d104:: with SMTP id a4mr6163024ilb.231.1603892176655;
        Wed, 28 Oct 2020 06:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmRo3zYrjdZWgoMbi/XfF4AaqZxe95A22njWBaMCMRSP3zTeMMowpni0WPCRMLWI3eslRMrw==
X-Received: by 2002:a92:d104:: with SMTP id a4mr6163006ilb.231.1603892176391;
        Wed, 28 Oct 2020 06:36:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l17sm2363709iol.30.2020.10.28.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:36:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C9F40181CED; Wed, 28 Oct 2020 14:36:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <87ft5zwl8u.fsf@toke.dk>
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <87ft5zwl8u.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Oct 2020 14:36:13 +0100
Message-ID: <87y2jqmq0i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> [+cc vtolkm]
>>
>> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>>> Hi everyone
>>>=20
>>> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
>>> having some trouble getting the PCI bus to work correctly. Specifically,
>>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
>>> the resource request fix[0] applied on top.
>>>=20
>>> The kernel boots fine, and the patch in [0] makes the PCI devices show
>>> up. But I'm still getting initialisation errors like these:
>>>=20
>>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D=
 0xffffffff)
>>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
>>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D=
 0xffffffff)
>>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
>>>=20
>>> and the WiFi drivers fail to initialise with what appears to me to be
>>> errors related to the bus rather than to the drivers themselves:
>>>=20
>>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by th=
is driver
>>> [    3.517049] ath: phy0: Unable to initialize hardware; initialization=
 status: -95
>>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
>>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with r=
c=3D134
>>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
>>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D=
3hot to D0 (config space inaccessible)
>>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
>>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
>>>=20
>>> lspci looks OK, though:
>>>=20
>>> # lspci
>>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Ad=
apter (PCI-Express) (rev 01)
>>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wire=
less Network Adapter (rev ff)
>>>=20
>>> Does anyone have any clue what could be going on here? Is this a bug, or
>>> did I miss something in my config or other initialisation? I've tried
>>> with both the stock u-boot distributed with the board, and with an
>>> upstream u-boot from latest master; doesn't seem to make any different.
>>
>> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
>> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but I
>> don't think we have a fix yet.
>
> Yes! Turning that off does indeed help! Thanks a bunch :)
>
> You mention that bisecting this would be helpful - I can try that
> tomorrow; any idea when this was last working?

OK, so I tried to bisect this, but, erm, I couldn't find a working
revision to start from? I went all the way back to 4.10 (which is the
first version to include the device tree file for the Omnia), and even
on that, the wireless cards were failing to initialise with ASPM
enabled...

Happy to run other tests, but I think I'm going to need some pointers -
the PCI subsystem is not my home turf :)

-Toke

