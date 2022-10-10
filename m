Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C545F9B30
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiJJIky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiJJIko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 04:40:44 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCED12D12;
        Mon, 10 Oct 2022 01:40:42 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 40FFE100003;
        Mon, 10 Oct 2022 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665391240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfWJeTWAN+TH6eaAO5f+M3fCHnGC8+BLpOpuXl0+jPg=;
        b=AsmBUcHi4+moi0R2aiLOXeWx3QTuPJJeE2lj0IZjvGq0oUgGI3m+QrVqeemtpde8zXgO0K
        J/fTOgCdW7IqNo+vdQMUMuFvTfC++rldv+o0jd/eHCHYPWrxC6qnppyqd9tpfYY9ExlaDv
        ES/hrCb1NWRTdw0gKSo/eT4KXrkv+tZK3Z45OevOXb8rkZ/FDm51OOFzPdScSqEBBqflnK
        XA7RxI7jFKnyn+hyC7FxCw0HNK7TyJxcLhqHMLs8LgebpMbKZrdDHCT+I4+eay5shCf3RS
        89VeeYwfDHmmcFLgz2xXoD5FuJZwwr+VUQOntMOB6f67Uwo9N2pVq4ALIIo9EA==
Date:   Mon, 10 Oct 2022 10:42:10 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
Message-ID: <20221010104210.68edf825@fixe.home>
In-Reply-To: <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
        <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
        <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
        <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Tue, 13 Sep 2022 12:41:28 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> >> I am not positive what part of what I wrote above is correct and would=
 appreciate
> >> some confirmation of what is correct or incorrect. =20
> >=20
> > There are 2 series devices rely on this patch:
> >=20
> > =C2=A0=C2=A0=C2=A0 1) Xilinx Alveo Accelerator cards (FPGA based device)
> >=20
> > =C2=A0=C2=A0=C2=A0 2) lan9662 PCIe card
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 please see: http=
s://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/=
 =20
>=20
> Thanks.  Please include this information in future versions of the patch =
series.
>=20
> For device 2 I have strongly recommended using pre-boot apply of the over=
lay to the base
> device tree.  I realize that this suggestion is only a partial solution i=
f one wants to
> use hotplug to change system configuration (as opposed to using hotplug o=
nly to replace
> an existing device (eg a broken device) with another instance of the same=
 device).  I
> also realize that this increased the system administration overhead.  On =
the other hand
> an overlay based solution is likely to be fragile and possibly flaky.

Again, applying overlays pre-boot is not an acceptable solution. Some
systems are not based on device-tree (x86 platforms with ACPI based
description, and I'm not even sure this is doable by modifying ACPI
tables). PCI is meant to be plug-and-play, so patching the ACPI
tables or device-tree pre-boot is likely not the correct answer to this
problem.

This would also require two different descriptions of the same card
(for ACPI and device-tree) and would require the final user to create a
specific overlay for its device based on the PCI slots the card is
plugged in.

The solution we proposed (Lizhi and I) allows to overcome these
problems and is way easier to use. Fixing the potential bugs that might
exists in the overlay layer seems a way better idea that just pushing
that away to the bootloader level. Moreover, this kind of devices is
likely to be more common with the increasing popularity of FPGA and a
proper solution must be found.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
