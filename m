Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B7758455
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGRSPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGRSPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 14:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8E10B;
        Tue, 18 Jul 2023 11:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA25F616A9;
        Tue, 18 Jul 2023 18:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC62C433C9;
        Tue, 18 Jul 2023 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689704133;
        bh=kHxVNW1fF7PzuKK1ys+0NZi4M8XowaLr/7P8gkpdlJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ORusedm981Yj/+87SN8Dfy42m31DyCLpq9HqWv4ho+Z3KBXkCG5zYt1xECLY1h9UQ
         FK8vM0+EOYl5JwIpVu6RsM/AW4ce1jHotCKLzfgoHQA5B0jwIuuLBO+20iCwv6yRBB
         xEHN+GcJVpJsJ2xIOl9HVkaf5Q+lZWrS240/Pm8AYISW3D6gXZsNhNFT8y+hOOBBau
         4ZFn3HOxn1BW0KJ+rk7XjsQ/UVxw10DAtsJyjQdzwivZXy2vkJZYZghTLZEONKu5yL
         f6HbAnlhAW7VKw0PlwjWKZVskPOIKLloGmkTcS1tUVN7GMWjs+7h9Ca83jjkNCGDxT
         TbK6CaPd77Ysg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso94633341fa.1;
        Tue, 18 Jul 2023 11:15:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ1xDyG+BZSL9+Y0Zvg6B1XIfcRf2pai3q0M6ISSQ+MD2GS8+9K
        yVCDPhMP7+40Pbv1owLz51/1Flr3TXZIAYuSGw==
X-Google-Smtp-Source: APBJJlETguQ1GeiGzi5H2NtBXJoWqk6KyqjpW8Bc6IS6lJOA4xgoNinovssDBzEvIoFur6Atchxk6+cTA5VSi5CZrA8=
X-Received: by 2002:a2e:9901:0:b0:2b8:6f78:ffa0 with SMTP id
 v1-20020a2e9901000000b002b86f78ffa0mr7549480lji.18.1689704131164; Tue, 18 Jul
 2023 11:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
 <20230629225631.GA446944@bhelgaas> <20230629235226.GA92592-robh@kernel.org> <9f39fc3d-ae40-e5b1-8d40-8c27fc4e1022@amd.com>
In-Reply-To: <9f39fc3d-ae40-e5b1-8d40-8c27fc4e1022@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jul 2023 12:15:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzGted2tYHM7uKZRYDHypz4P6KMXGDuYLgpYsJcUyU8Q@mail.gmail.com>
Message-ID: <CAL_JsqLzGted2tYHM7uKZRYDHypz4P6KMXGDuYLgpYsJcUyU8Q@mail.gmail.com>
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 12:25=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrot=
e:
>
>
> On 6/29/23 16:52, Rob Herring wrote:
> >>> +                   rp[i].child_addr[0] =3D j;
> >>> +   ret =3D of_changeset_add_empty_prop(ocs, np, "dynamic");
> >> It seems slightly confusing to use a "dynamic" property here when we
> >> also have the OF_DYNAMIC dynamic flag above.  I think they have
> >> different meanings, don't they?
> > Hum, what's the property for? It's new in this version. Any DT property
> > needs to be documented, but I don't see why we need it.
>
> This is mentioned in my previous reply for V9
>
> https://lore.kernel.org/lkml/af9b6bb3-a98d-4fb6-b51e-b48bca61dada@amd.com=
/
>
> As we discussed before, "interrupt-map" was intended to be used here.
>
> And after thinking it more, it may not work for the cases where ppnode
>
> is not dynamically generated and it does not have "interrupt-map".
>
> For example the IBM ppc system, its device tree has nodes for pci bridge
>
> and it does not have "interrupt-map".

How do you know? I ask because usually the only way I have visibility
there is when I break something. In traditional OpenFirmware, which
IBM PPC is, all PCI devices have a DT node because it's the firmware
telling the OS "these are the devices I discovered and this is how I
configured them".

> Based on previous discussions, OF_DYNAMIC should not be used here.

For the same reasons, I don't think the behavior should change based
on being dynamic. Now maybe the behavior when it's an ACPI system with
DT overlays has to change, but that's a problem for later. I don't yet
know if we'd handle that here somehow or elsewhere so that this node
looks like a normal DT system.

This should all work the same whether we've generated the nodes or
they were already present in the FDT when we booted.

> So I think adding "dynamic" might be a way to identify the dynamically
>
> added node. Or we can introduce a new flag e.g OF_IRQ_SWIZZLING.

I hope not. The flags tend to be hacks.

Rob
