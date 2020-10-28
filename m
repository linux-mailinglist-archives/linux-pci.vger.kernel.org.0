Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C6F29DF9F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgJ1WKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730483AbgJ1WKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 18:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8xnFOFFJaHLUOxxzEQxUXczDp2GypBZ0BZHMFTtshA=;
        b=i/1fNDcO8+ewywBxofrJ3uiGa5p923W/iHwe+q8u0SRAx5bxnRB1pQO7wMYgMK+IBvbjbB
        yVRESqwpM3Gsi7TcaU/VpKqB6bQGASvsWtEN5JWGtICcff7r0SyIO6UXLpygWA8goI3jvh
        R0tnFMgld2owk4Pfx6QHGpCaMjJuQqc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-vYH8u1E_NFesVvpwVomZiA-1; Wed, 28 Oct 2020 11:08:40 -0400
X-MC-Unique: vYH8u1E_NFesVvpwVomZiA-1
Received: by mail-il1-f197.google.com with SMTP id b6so3732288ilm.6
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 08:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=e8xnFOFFJaHLUOxxzEQxUXczDp2GypBZ0BZHMFTtshA=;
        b=axuYTWbZan99wve6xJHJhTkMdyLWjXfZjNFwWMjPGAaBYMA956J5YKRy21eqfzjPZi
         Ref5iCx5Z2CxmXtvy0bq+7k7VcAYHSFlXcNPP2P+BzRlcCts0mTEVpu+ZySabEOEjkvK
         cpz7DrIWldIpwvW042ERaJxWEMgUrxO93OqaC5jjJLckbZCWgaDeKTAjIdJl6k/NKqXc
         XGymxCSbZp9p7HYGcuaDnJRTqIdLX1E9r+7qMkFIr30CnapyXFUfcNpGMXgZTeBR586p
         0IMGlsAhuRVEHH+FWuIFkj2tc/qseWq9sFHKQhJ/RFYbgfZGleDoXz/Nbz27bRRyrO1g
         iGDA==
X-Gm-Message-State: AOAM530s5NgKk+EdEbtteKPl6lQ9F5UTsZM0fz+c5bPGS+7adiIGimey
        lGfHwL8t03X4IQGzJy+rki5ncvftxQmAgLQtLZHqmT/9/l1pL2eZAKnQDSbOhfbOtd3rIFP6bdr
        4gjP9JgHg7+cuwrMlFh/J
X-Received: by 2002:a92:d3ce:: with SMTP id c14mr5787343ilh.157.1603897718796;
        Wed, 28 Oct 2020 08:08:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXIihC/u1Na4cd/nHaASyURWk00ICQX3yJr1URYfAKlTho/LF8HkvGID2SJkby1NRzicM7FA==
X-Received: by 2002:a92:d3ce:: with SMTP id c14mr5787312ilh.157.1603897718181;
        Wed, 28 Oct 2020 08:08:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l78sm2985291ild.30.2020.10.28.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:08:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A23CC181CED; Wed, 28 Oct 2020 16:08:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201028144209.GA315566@bjorn-Precision-5520>
References: <20201028144209.GA315566@bjorn-Precision-5520>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Oct 2020 16:08:35 +0100
Message-ID: <87pn52mlqk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>> > Bjorn Helgaas <helgaas@kernel.org> writes:
>> >
>> >> [+cc vtolkm]
>> >>
>> >> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
>> >>> Hi everyone
>> >>>=20
>> >>> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
>> >>> having some trouble getting the PCI bus to work correctly. Specifica=
lly,
>> >>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), w=
ith
>> >>> the resource request fix[0] applied on top.
>> >>>=20
>> >>> The kernel boots fine, and the patch in [0] makes the PCI devices sh=
ow
>> >>> up. But I'm still getting initialisation errors like these:
>> >>>=20
>> >>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=
=3D 0xffffffff)
>> >>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x00000=
0 !=3D 0xffffffff)
>> >>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=
=3D 0xffffffff)
>> >>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x00000=
0 !=3D 0xffffffff)
>> >>>=20
>> >>> and the WiFi drivers fail to initialise with what appears to me to be
>> >>> errors related to the bus rather than to the drivers themselves:
>> >>>=20
>> >>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by=
 this driver
>> >>> [    3.517049] ath: phy0: Unable to initialize hardware; initializat=
ion status: -95
>> >>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>> >>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
>> >>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed wit=
h rc=3D134
>> >>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
>> >>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state fro=
m D3hot to D0 (config space inaccessible)
>> >>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -=
110
>> >>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -=
110
>> >>>=20
>> >>> lspci looks OK, though:
>> >>>=20
>> >>> # lspci
>> >>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 0=
4)
>> >>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 0=
4)
>> >>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 0=
4)
>> >>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network=
 Adapter (PCI-Express) (rev 01)
>> >>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac W=
ireless Network Adapter (rev ff)
>> >>>=20
>> >>> Does anyone have any clue what could be going on here? Is this a bug=
, or
>> >>> did I miss something in my config or other initialisation? I've tried
>> >>> with both the stock u-boot distributed with the board, and with an
>> >>> upstream u-boot from latest master; doesn't seem to make any differe=
nt.
>> >>
>> >> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
>> >> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but I
>> >> don't think we have a fix yet.
>> >
>> > Yes! Turning that off does indeed help! Thanks a bunch :)
>> >
>> > You mention that bisecting this would be helpful - I can try that
>> > tomorrow; any idea when this was last working?
>>=20
>> OK, so I tried to bisect this, but, erm, I couldn't find a working
>> revision to start from? I went all the way back to 4.10 (which is the
>> first version to include the device tree file for the Omnia), and even
>> on that, the wireless cards were failing to initialise with ASPM
>> enabled...
>
> I have no personal experience with this device; all I know is that the
> bugzilla suggests that it worked in v5.4, which isn't much help.
>
> Possibly the apparent regression was really a .config change, i.e.,
> CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and it
> "worked" but got enabled later and it started failing?

Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
default and only turns it on for specific targets. So I guess that it's
most likely that this has never worked...

> Maybe the debug patch below would be worth trying to see if it makes
> any difference?  If it *does* help, try omitting the first hunk to see
> if we just need to apply the quirk_enable_clear_retrain_link() quirk.

Tried, doesn't help...

-Toke

