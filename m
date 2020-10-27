Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59C29C801
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902155AbgJ0S7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 14:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2901077AbgJ0S7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 14:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqHR5XfRB6RDKMShlQIL/Peb7CzCxkUpZSojOGYzZK8=;
        b=JBLFvRbYO+9/124UYxelxso8Phu/iEjTruBHRmQLFILQmXF8pktCNtCR5eDcT6bNoPtuQP
        VOMORkkivNkwA2r8fA7WuAAfzP0ZxplC9oIvA7+TRYNCTen6LgmfJn5AdLibzLO14bD2+S
        L95IiXwhuf6RA0lSlvq76CqYvF79ASc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-U_rusfgaP92uc8gBsRgfjQ-1; Tue, 27 Oct 2020 14:59:08 -0400
X-MC-Unique: U_rusfgaP92uc8gBsRgfjQ-1
Received: by mail-qt1-f198.google.com with SMTP id c4so1404771qtx.20
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 11:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sqHR5XfRB6RDKMShlQIL/Peb7CzCxkUpZSojOGYzZK8=;
        b=VxdhpjAHOsJWUipgeL3spUGt6/IYNWXXVjRAMOezsdCPsXfie6prwzO5Z/fZRIy03F
         kS9+UOakgGV7H77txcSRH1Et/0Upthz0/t8/M8p3uUn+FTAgiuGbbhvhvNudHuwqCHFJ
         CkBEkC5iTcVWSfYvK0xNFKbwvrzsDAEiqaMwRU155qdbx/gC1aplaFRd9LX+gqrlmLIe
         594mfskADIZYTL8IGAHUQ3Oi0eMEp9a65tVuearOfCoAGIAwDzp+NyDLhIhLaoglYS3u
         RSeZGme1oX3DpBxDN7BH3gOiXaYN+JzdD1Y8LK0li8IkDR0zOwkLDlORj82UNkoX/LVC
         78pw==
X-Gm-Message-State: AOAM530mu95GPTcN1Zzv1WCoyxcuxe8x4Qig7Oh4F2l0H4ruTPf9lwWA
        Kxs2CZpjvYrXpp2OICyLKMsWqzKzpVhDNA7vsoEO6s7aa6LtXxbNFbwewkCcky4qRvzRt+GzuU6
        j+ee+qFFusA9PFw11G6sd
X-Received: by 2002:ac8:7b33:: with SMTP id l19mr3624642qtu.304.1603825147920;
        Tue, 27 Oct 2020 11:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2f3Dh5PYwE5lSVUtfCdHnJ0grzfDl+oFlnGpKZ5u9KrAf6mwimu0AVVQ05ZYhZn5ORUhk+g==
X-Received: by 2002:ac8:7b33:: with SMTP id l19mr3624617qtu.304.1603825147620;
        Tue, 27 Oct 2020 11:59:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a10sm1324489qkc.79.2020.10.27.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:59:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 24DE5181CED; Tue, 27 Oct 2020 19:59:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     vtolkm@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com>
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 19:59:05 +0100
Message-ID: <87d013wl52.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@googlem=
ail.com> writes:

> On 27/10/2020 18:20, Bjorn Helgaas wrote:
>> [+cc vtolkm]
>>
>> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>>> Hi everyone
>>>
>>> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
>>> having some trouble getting the PCI bus to work correctly. Specifically,
>>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
>>> the resource request fix[0] applied on top.
>>>
>>> The kernel boots fine, and the patch in [0] makes the PCI devices show
>>> up. But I'm still getting initialisation errors like these:
>>>
>>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D=
 0xffffffff)
>>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
>>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D=
 0xffffffff)
>>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
>>>
>>> and the WiFi drivers fail to initialise with what appears to me to be
>>> errors related to the bus rather than to the drivers themselves:
>>>
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
>>>
>>> lspci looks OK, though:
>>>
>>> # lspci
>>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Ad=
apter (PCI-Express) (rev 01)
>>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wire=
less Network Adapter (rev ff)
>>>
>>> Does anyone have any clue what could be going on here? Is this a bug, or
>>> did I miss something in my config or other initialisation? I've tried
>>> with both the stock u-boot distributed with the board, and with an
>>> upstream u-boot from latest master; doesn't seem to make any different.
>> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
>> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but I
>> don't think we have a fix yet.
>>
>
> Got the same device working with > 5.10.0-rc1-next-20201027-to-dirty <=20
> but ASPM turned off, as mentioned in the cited bug report.

Yup, indeed that helped!

> Note: related issues - workaround compile ath and cfg80211 as modules
>
> (1) https://bugzilla.kernel.org/show_bug.cgi?id=3D209863
> (2) https://bugzilla.kernel.org/show_bug.cgi?id=3D209855
> (3) https://bugzilla.kernel.org/show_bug.cgi?id=3D209853

Yeah, I had noticed the regdb failure but put off debugging that until
the PCI issue was resolved. So guess that's next on my list - thanks for
the pointer (although I'd rather avoid the module approach as booting
the kernel directly from my build box over tftp is quite convenient...
Let's see if there isn't another way to fix this)

-Toke

