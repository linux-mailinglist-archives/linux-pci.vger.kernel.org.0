Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B129CB4D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 22:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374147AbgJ0Vet (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 17:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374098AbgJ0Vei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 17:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603834474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0l4M8Gcg0G2v1bjvfJLLVTms9U8WWDzqEsERQPtXk/Y=;
        b=DK2B8uyT47F4aWL4jzcdfFg3gB2glyyi5KQNPcDtPu/655UCqfCQ3dihwAbgb4hLZUIpDW
        7OG21GUBjLq67nss0qd/eqt/xQnGW+fmerTtSRXch25yYu7IpCK/Lp9avGrMcutvZbNKdI
        kXZgO6gqdv898HoB5cNaO1nP6B1VH+A=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-B3rgbWR_OF-acXLlTgdgIQ-1; Tue, 27 Oct 2020 17:31:23 -0400
X-MC-Unique: B3rgbWR_OF-acXLlTgdgIQ-1
Received: by mail-io1-f72.google.com with SMTP id e21so1919932iod.5
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 14:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0l4M8Gcg0G2v1bjvfJLLVTms9U8WWDzqEsERQPtXk/Y=;
        b=VmSdIMo33MtiCp8SRpRBVDNBtvWoiCsLtCJ7QdT24KjJIC745+TJ2VW0ukTgmCQza/
         WsKuRthQJbB+1RjiFeDVfg1cl5HZgWaUhF69pUE+xoTg53aQwfgQX5YQlmWPDTV9aTKy
         70p89V6t4Aa8fkI1kZeGqnqxrZQkjqOH5QXO8JG9Qq5JEoq+41U+K/meX51olToQ54po
         BLhU9kZZdgvVcWXfjefRmrnvYnXUpz61iQzBmCh9JpVnNFaHZ5A6Wouw2ltlGXunU+GY
         0H3o8/+Yj4qA1rZxNNRH62l6TnepSWATAoZxVZe2gxd9ZWQ8xQFJfVO76S5vyw2yA1Je
         Iilw==
X-Gm-Message-State: AOAM532nYejlOsekiPPrWJ548C48HuIhDwZFSv7DJVRNwQ3OW57+L6cP
        S+hC3MLTZORUxjLU8057S3oWMYSeL8zMGI0km5UbNMMuyqn35VlrM5hhDjv6aheAYrsZhzcepyK
        duwcDn9dzGg2B01XW5Q4y
X-Received: by 2002:a5d:8908:: with SMTP id b8mr3723953ion.96.1603834282604;
        Tue, 27 Oct 2020 14:31:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUo3Kv513N0RMyE8+QzXi4LWGkiUPZSLGFCZC/gF39lM/CKkz3YhTCc2Ptjs9eXkdgxi+hAA==
X-Received: by 2002:a5d:8908:: with SMTP id b8mr3723934ion.96.1603834282224;
        Tue, 27 Oct 2020 14:31:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v15sm1471273ile.37.2020.10.27.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 14:31:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE503181CED; Tue, 27 Oct 2020 22:31:19 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     vtolkm@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com> <87d013wl52.fsf@toke.dk>
 <874kmfwhdb.fsf@toke.dk> <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 22:31:19 +0100
Message-ID: <87y2jruziw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@googlem=
ail.com> writes:

> On 27/10/2020 21:20, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>
>>>> Note: related issues - workaround compile ath and cfg80211 as modules
>>>>
>>>> (1) https://bugzilla.kernel.org/show_bug.cgi?id=3D209863
>>>> (2) https://bugzilla.kernel.org/show_bug.cgi?id=3D209855
>>>> (3) https://bugzilla.kernel.org/show_bug.cgi?id=3D209853
>>> Yeah, I had noticed the regdb failure but put off debugging that until
>>> the PCI issue was resolved. So guess that's next on my list - thanks for
>>> the pointer (although I'd rather avoid the module approach as booting
>>> the kernel directly from my build box over tftp is quite convenient...
>>> Let's see if there isn't another way to fix this)
>> To follow up on this, everything seems to work just fine (ath10k init at
>> boot + regulatory db load) if I simply set:
>>
>> CONFIG_EXTRA_FIRMWARE=3D"ath10k/QCA988X/hw2.0/board.bin ath10k/QCA988X/h=
w2.0/firmware-5.bin regulatory.db regulatory.db.p7s"
>>
>> -Toke
>>
>
> That works on my node only for the regulatory files but not the ath10=20
> firmware with kconfig:
>
>  =C2=A0Symbol: EXTRA_FIRMWARE_DIR [=3D/srv/fw]
>  =C2=A0Type=C2=A0 : string
>  =C2=A0Defined at drivers/base/firmware_loader/Kconfig:63
>  =C2=A0=C2=A0 Prompt: Firmware blobs root directory
>  =C2=A0=C2=A0 Depends on: FW_LOADER [=3Dy] && EXTRA_FIRMWARE [=3Dregulato=
ry.db=20
> regulatory.db.p7s board.bin firmware-5.bin]!=3D
>  =C2=A0=C2=A0 Location:
>  =C2=A0=C2=A0=C2=A0 -> Device Drivers
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Generic Driver Options
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware loader
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware loadi=
ng facility (FW_LOADER [=3Dy])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Bu=
ild named firmware blobs into the kernel binary=20
> (EXTRA_FIRMWARE [=3Dregulatory.db regulatory.db.p7s board.bin=20
> firmware-5.bin])

I think that's because you're missing the path prefix
(ath10k/QCA988X/hw2.0/) from board.bin and firmware-5.bin?
request_firmware() uses the full path...

-Toke

