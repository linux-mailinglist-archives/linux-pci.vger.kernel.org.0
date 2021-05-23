Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA39638DAFF
	for <lists+linux-pci@lfdr.de>; Sun, 23 May 2021 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhEWLFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 May 2021 07:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhEWLFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 May 2021 07:05:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561BC061574;
        Sun, 23 May 2021 04:03:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so18483611pfn.6;
        Sun, 23 May 2021 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9Lt/AIdW6HrrFuSEZPcebw6uiQe1k5wv4Yjw5eCiDSA=;
        b=o/LXRFj1N137rMWJZVD04xNaZdyn41IClD0VDUOUfyQsz+n2l5tELF76mITpZvxrQt
         WwMesJ1N1v5P/kYanMxK7+bIfL6O/mGDHM0ToKwxAL8PPsg9/Iw1sKvLXgkOp755v+yd
         nr/nf3Y220oIMVy5roxxxrwLtIOxVX1W26ceshPhf9tshUGDF7bCl29gKWQeBqkbhfFa
         are3vBf5KcB8GfN+6t5m1ko/LhjPpzf1AidfHmGgK0WduNVcnHQ68gor2O5++/fpsN2s
         6HI5LRGTqsST6BNa2+N3F4s6Wd8I4GOm3cs4fxdDDjW6BZ3804rZb3tMeERJo2ol+y0f
         0cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=9Lt/AIdW6HrrFuSEZPcebw6uiQe1k5wv4Yjw5eCiDSA=;
        b=PZwAAANOOKokhnszWG+O7WSTEznvv4KpufD41JZdq5iVwnm4dzdQ6RxsDYe67SkfJY
         OTwPtNrZ6Nl8wy8AUrZVcZHSwQeJbWmqO/BVrIV+AkzMHjQpiHJjhG9DfPK3FDKzSxk0
         qv+fC6uWwiOTqg6PYmW1PcfQxcca9oW6+1GR87GiBmPG0c1OHy5li2fzb+IeN8A4s60W
         gJ7RUwYFYkmYkWze+OZwxhdxOC0UZRbpXsh2O2V4g3jNEcj87TVW2Ne/dwYRHWL0xfQ2
         jPMCLQ5wfq23blGexnvyNrjbFM45JJGqyxAWtBYJismex9hx0uR43eTdsWvhYclxdps8
         NPvg==
X-Gm-Message-State: AOAM530sivwLdkrwtQd9SW+9afkwFXXi+GSHqo7Sei0pHE21dd54GmWj
        QHqNIzthTiD+DARqmdyETIM=
X-Google-Smtp-Source: ABdhPJxsHyU5CpFgPLpX10jkw6h9MAsYtH8flePtQusfoht55zKY+VvtUG3rEeTURcuLbdbrXtM2+Q==
X-Received: by 2002:a63:1210:: with SMTP id h16mr8084566pgl.189.1621767819261;
        Sun, 23 May 2021 04:03:39 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id w206sm8282820pfc.61.2021.05.23.04.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 04:03:38 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        heiko.stuebner@theobroma-systems.com, leobras.c@gmail.com,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
        <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
Date:   Sun, 23 May 2021 20:03:36 +0900
In-Reply-To: <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com> (Robin Murphy's
        message of "Wed, 19 May 2021 12:27:48 +0100")
Message-ID: <87eedxbtkn.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Robin Murphy <robin.murphy@arm.com> writes:

> [ +linux-pci for visibility ]
>
> On 2021-05-18 10:09, Alexandru Elisei wrote:
>> After doing a git bisect I was able to trace the following error when bo=
oting my
>> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
>> [..]
>> [=C2=A0=C2=A0=C2=A0 0.305183] rockchip-pcie f8000000.pcie: host bridge /=
pcie@f8000000 ranges:
>> [=C2=A0=C2=A0=C2=A0 0.305248] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 MEM 0x00fa000000..0x00fbdfffff ->
>> 0x00fa000000
>> [=C2=A0=C2=A0=C2=A0 0.305285] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 IO 0x00fbe00000..0x00fbefffff ->
>> 0x00fbe00000
>> [=C2=A0=C2=A0=C2=A0 0.306201] rockchip-pcie f8000000.pcie: supply vpcie1=
v8 not found, using dummy
>> regulator
>> [=C2=A0=C2=A0=C2=A0 0.306334] rockchip-pcie f8000000.pcie: supply vpcie0=
v9 not found, using dummy
>> regulator
>> [=C2=A0=C2=A0=C2=A0 0.373705] rockchip-pcie f8000000.pcie: PCI host brid=
ge to bus 0000:00
>> [=C2=A0=C2=A0=C2=A0 0.373730] pci_bus 0000:00: root bus resource [bus 00=
-1f]
>> [=C2=A0=C2=A0=C2=A0 0.373751] pci_bus 0000:00: root bus resource [mem 0x=
fa000000-0xfbdfffff 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.373777] pci_bus 0000:00: root bus resource [io=C2=
=A0 0x0000-0xfffff] (bus
>> address [0xfbe00000-0xfbefffff])
>> [=C2=A0=C2=A0=C2=A0 0.373839] pci 0000:00:00.0: [1d87:0100] type 01 clas=
s 0x060400
>> [=C2=A0=C2=A0=C2=A0 0.373973] pci 0000:00:00.0: supports D1
>> [=C2=A0=C2=A0=C2=A0 0.373992] pci 0000:00:00.0: PME# supported from D0 D=
1 D3hot
>> [=C2=A0=C2=A0=C2=A0 0.378518] pci 0000:00:00.0: bridge configuration inv=
alid ([bus 00-00]),
>> reconfiguring
>> [=C2=A0=C2=A0=C2=A0 0.378765] pci 0000:01:00.0: [144d:a808] type 00 clas=
s 0x010802
>> [=C2=A0=C2=A0=C2=A0 0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x0000000=
0-0x00003fff 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.379051] pci 0000:01:00.0: Max Payload Size set to =
256 (was 128, max 256)
>> [=C2=A0=C2=A0=C2=A0 0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCI=
e bandwidth, limited by
>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 G=
T/s PCIe
>> x4 link)
>> [=C2=A0=C2=A0=C2=A0 0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end=
 is updated to 01
>> [=C2=A0=C2=A0=C2=A0 0.393311] pci 0000:00:00.0: BAR 14: no space for [me=
m size 0x00100000]
>> [=C2=A0=C2=A0=C2=A0 0.393333] pci 0000:00:00.0: BAR 14: failed to assign=
 [mem size 0x00100000]
>> [=C2=A0=C2=A0=C2=A0 0.393356] pci 0000:01:00.0: BAR 0: no space for [mem=
 size 0x00004000 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.393375] pci 0000:01:00.0: BAR 0: failed to assign =
[mem size 0x00004000 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [=C2=A0=C2=A0=C2=A0 0.393839] pcieport 0000:00:00.0: PME: Signaling with=
 IRQ 78
>> [=C2=A0=C2=A0=C2=A0 0.394165] pcieport 0000:00:00.0: AER: enabled with I=
RQ 78
>> [..]
>> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
>> resource flags for
>> 64-bit memory addresses").
>
> FWFW, my hunch is that the host bridge advertising no 32-bit memory
> resource, only only a single 64-bit non-prefetchable one (even though=20
> it's entirely below 4GB) might be a bit weird and tripping something
> up in the resource assignment code. It certainly seems like the thing
> most directly related to the offending commit.
>
> I'd be tempted to try fiddling with that in the DT (i.e. changing
> 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see
> if it makes any difference. Note that even if it helps, though, I
> don't know whether that's the correct fix or just a bodge around a
> corner-case bug somewhere in the resource code.

From digging into this further the failure seems to be due to a mismatch
of flags when allocating resources in pci_bus_alloc_from_region() -

    if ((res->flags ^ r->flags) & type_mask)
            continue;

Though I am also not sure why the failure is only being reported on
RK3399 - does a single 64-bit window have anything to do with it?

Also, I don't understand the motivation for the original commit. It is
not clear what problem it is solving and the discussion thread seems to
suggest that things work fine without it[0].

[0] https://lore.kernel.org/linux-devicetree/CAL_JsqJXKVUFh9KrJjobn-jE-PFKN=
0w-V_i3qkfBrpTah4g8Xw@mail.gmail.com/

[...]

