Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B348878E9B1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHaJnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjHaJnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 05:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94DCCED;
        Thu, 31 Aug 2023 02:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF6D63502;
        Thu, 31 Aug 2023 09:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4D4C433C7;
        Thu, 31 Aug 2023 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693474984;
        bh=avSgZWMqI/UwLukj4GGSxxGERqgCYoJMEQ3aHYIN6I4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cOaQDSl8irWyaEvVhpfBjHoxS51YJJAV9ww/L/2c4hURu7P4xZkBw1fElxP1I/2VY
         3CnNWbQH7q/Rss//oOn9Cc71uQyejiZtALxXwFjST0PcpMZU4QKXPrBByej1ozJeNO
         dD2eF6T8M5NanEMQwRZfgorjnk7UbhHsAPTtk+ycYqWa4uHIzVojFF79En/1+124Au
         rguWyvBYUL1zwAZ4p1/ofNHESW+ZKpKXevl0m7IZIpQgXUhq52MGO8ukIXJVz5QEK+
         tgGabQowZrGp4QZZU7xlCcKabTXBGqotWS2zAgOspEcNoB1Y6PqhgPZLKmXLinyp1m
         f7Hw1e9XP0vGA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99bf1f632b8so68484166b.1;
        Thu, 31 Aug 2023 02:43:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvJUVhoYipeu/C3FdFg109pI2HlqYrOmKoZFHhlMpbovqSzT/k
        9oVztztOI3dwfV1zbPPjXK3g4fYJ0l4PnntBAN4=
X-Google-Smtp-Source: AGHT+IGB/PPfnX7fFwCgEaUCeRbh/qQRu5L1vsYuQ4+PNdm7gPz3x1vbD41UmxnUOFOQbFVtwSqF3ckrHmqOWTXYFKo=
X-Received: by 2002:a17:906:300a:b0:9a1:f81f:d0df with SMTP id
 10-20020a170906300a00b009a1f81fd0dfmr3447526ejz.69.1693474982925; Thu, 31 Aug
 2023 02:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com> <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com> <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
 <62a7b292-ea1e-fb88-79cb-e7968d350a5e@flygoat.com>
In-Reply-To: <62a7b292-ea1e-fb88-79cb-e7968d350a5e@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 31 Aug 2023 17:42:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4DRFrsWOusyVPo5U_F-fwcfUUktGe31x9S3=E7vci=pQ@mail.gmail.com>
Message-ID: <CAAhV-H4DRFrsWOusyVPo5U_F-fwcfUUktGe31x9S3=E7vci=pQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 31, 2023 at 4:58=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> =E5=9C=A8 2023/8/31 14:22, Huacai Chen =E5=86=99=E9=81=93:
>
> [...]
> > But it is worth to try, and you can walk the children to set mrrs when
> > the quirk runs on bridges, I think.
> No, this will break hotplug, I had managed to get hotplug work on 2K1000.
> Also we have no guarantee on order of discovering devices.
> >> but the old quirk should run on every single device.
> > Your current patch has a drawback that both quirks will run for MIPS,
> > and their order is random (though it may cause nothing, but not
> > elegant).
> Actually loongson_mrrs_quirk is declared by DECLARE_PCI_FIXUP_EARLY but
> loongson_old_mrrs_quirk is declared by DECLARE_PCI_FIXUP_ENABLE,
> which means loongson_old_mrrs_quirk always runs after loongson_mrrs_quirk=
 as
> expected.
Then I think it is better to put this quirk in arch/mips/loongson64/,
just as pci_fixup_radeon().

Huacai
>
> Thanks
> - Jiaxun
>
> [...]
