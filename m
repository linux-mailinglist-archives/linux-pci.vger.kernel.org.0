Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3534C29C7E2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 19:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371290AbgJ0S46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 14:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371274AbgJ0S45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 14:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBSJVhA2Zel/E62KeQH/FdekJKUmbLTIRq7px0z8tiw=;
        b=OKVICALCvmEelVQZbPoaqW2Or4Yey6YHK6eHlJr13/MVqQJ9Fzgo2pR4vPudJ46m6935Ze
        AHgx2+cNOztIGOW++XLkQXfWyV49g/gbz048KpEUCafgdp1RENtl0sIzeVJ2M3VqrCyOP/
        7LcQOAoj09qRibmAnkZYjDDKj/+U8TE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-YJTbtYkNOO6FqrpPMOIdPg-1; Tue, 27 Oct 2020 14:56:53 -0400
X-MC-Unique: YJTbtYkNOO6FqrpPMOIdPg-1
Received: by mail-qt1-f197.google.com with SMTP id d1so1405399qtq.12
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 11:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lBSJVhA2Zel/E62KeQH/FdekJKUmbLTIRq7px0z8tiw=;
        b=JSXHgNpdHClfgW+Kj/+0YcwCfxaanyobLWDextRIgnh0pem6sOPebgsG6H/cxsQo7Q
         MnvgY1ghzsz/qbBiVDj6WQX8zjg4Z4UJcujit22LKrW73pKnsz7QnWaAIxIFNSAwrLt+
         3O9or39VcHu2wkqU33+G/FszP6bZn68cM/sAYRveSRIS9+aZRJu7cSljfGC4uhl2JldI
         w5d8XaD7ADlnfP+W0SeFJ8BWib2NnoAp9eAlIf85KEqntZo9zvQpZmhKcXe9pNMknyGc
         Zv6fOVfwyJ0zt3plO3FTuFFzpwYaAkiAtD058Une+8Xvci9m5uqjfF0c5PSKJTv3vIWw
         yIZA==
X-Gm-Message-State: AOAM530y/0UhZfC0PnrIUDEHdiJ7Q5QX9CwL56GU/G1qyw+2ybwyqXEJ
        mkbx0xrsRw+81f9K0sokLvj7419YN87Dv8M3BHQFMDsIBkN3Z6sgFe+107W+fkkc2uA7OMsaS2v
        2IoVf3H3dgrrTmcwL1zM7
X-Received: by 2002:a37:9a89:: with SMTP id c131mr3534080qke.80.1603825012771;
        Tue, 27 Oct 2020 11:56:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjZw2rDKqKGl1d9nzrBxtBxMtWco4J79derwyZr5901QtbIDiWrSHhzg3yloWraFq/slfHeQ==
X-Received: by 2002:a37:9a89:: with SMTP id c131mr3534023qke.80.1603825012044;
        Tue, 27 Oct 2020 11:56:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 19sm1337452qkf.93.2020.10.27.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:56:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5B925181CED; Tue, 27 Oct 2020 19:56:49 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201027172006.GA186901@bjorn-Precision-5520>
References: <20201027172006.GA186901@bjorn-Precision-5520>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 19:56:49 +0100
Message-ID: <87ft5zwl8u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc vtolkm]
>
> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Hi everyone
>>=20
>> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
>> having some trouble getting the PCI bus to work correctly. Specifically,
>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
>> the resource request fix[0] applied on top.
>>=20
>> The kernel boots fine, and the patch in [0] makes the PCI devices show
>> up. But I'm still getting initialisation errors like these:
>>=20
>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D =
0xffffffff)
>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D =
0xffffffff)
>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
>>=20
>> and the WiFi drivers fail to initialise with what appears to me to be
>> errors related to the bus rather than to the drivers themselves:
>>=20
>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by thi=
s driver
>> [    3.517049] ath: phy0: Unable to initialize hardware; initialization =
status: -95
>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=
=3D134
>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D3=
hot to D0 (config space inaccessible)
>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
>>=20
>> lspci looks OK, though:
>>=20
>> # lspci
>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Ada=
pter (PCI-Express) (rev 01)
>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wirel=
ess Network Adapter (rev ff)
>>=20
>> Does anyone have any clue what could be going on here? Is this a bug, or
>> did I miss something in my config or other initialisation? I've tried
>> with both the stock u-boot distributed with the board, and with an
>> upstream u-boot from latest master; doesn't seem to make any different.
>
> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but I
> don't think we have a fix yet.

Yes! Turning that off does indeed help! Thanks a bunch :)

You mention that bisecting this would be helpful - I can try that
tomorrow; any idea when this was last working?

-Toke

