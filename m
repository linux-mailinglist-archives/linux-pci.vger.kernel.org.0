Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87657C500
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGUHI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGUHI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 03:08:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3077A4E;
        Thu, 21 Jul 2022 00:08:55 -0700 (PDT)
Received: from mail-oi1-f171.google.com ([209.85.167.171]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6DOg-1o7nXJ33o8-006jZU; Thu, 21 Jul 2022 09:08:53 +0200
Received: by mail-oi1-f171.google.com with SMTP id n206so892922oia.6;
        Thu, 21 Jul 2022 00:08:53 -0700 (PDT)
X-Gm-Message-State: AJIora/6vUDb1PeQbx59q0h1bgPnkSZimdddhuprsG/aCI0bOiLo5meu
        8YCPa0horuO1m+5R2Yhe7V934S+6fTntb5CtTMk=
X-Google-Smtp-Source: AGRyM1v+odWduFrFFJeiRzgTsqetnRIRebzlh0VM+scMiYoVZko9IL5QdoNAc0bk1qIjkxiy/D4D3vzSAK4r7FcXEDY=
X-Received: by 2002:a05:6808:23cb:b0:339:f8b4:ecae with SMTP id
 bq11-20020a05680823cb00b00339f8b4ecaemr3937025oib.188.1658387332349; Thu, 21
 Jul 2022 00:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220719215108.1583108-1-helgaas@kernel.org>
In-Reply-To: <20220719215108.1583108-1-helgaas@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jul 2022 09:08:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pbA7hSNgKw+yjBmXHGuwc_Y1tNJ7=vD5wiPn+rE1a8w@mail.gmail.com>
Message-ID: <CAK8P3a0pbA7hSNgKw+yjBmXHGuwc_Y1tNJ7=vD5wiPn+rE1a8w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Convert to new *_PM_OPS macros
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z2623rrrgkPASP5C2ZFI1n4BRGHsMz7/ASwncv5Qv2/QP7F1Ecc
 IDtbv9UUGyXRKubaAOzkPn2q4mF7QqTuiXI1Tvh+9UkTViyYzhw866FrILfJL+FbX6264qu
 fODteRk3KYzdpxL+Z0Jn1a0BFXztpwGCO3n3VFMkAoZQ/+C/N3YfbASz8uJpoJPqYAl5/aQ
 cion8CecWAD9W+aqOHHSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5vjoARo5n2Y=:1btSfPP4QaFxPCvPVSdFH6
 MXi4k114+PI3NTgeBigguzGM0R+I3qJYpIMa7NjTj+jjTrrx9FCumyp7A8gOvoY/obWkHHYWM
 t10BXmEXKQcbEEog5aNeb1XJkXbRG8YCfNWp/aJdAI0kQhFZbvVz5n6lwNgSs2W938KhQ9gxd
 MjAyjIVBIyPZk4QyRm3yQpT3i3Sx3e2kmHZuS4RpL2TUTiHJwfOLFgw+I5LuMW73O0L9DOOtW
 gCTnmCOXhA/IyOmeFUBBGXMlQfY+OxbPOz5hHojjXK9fSrq9w3JvIsXR+LV+oeNh/ZM77+Pnu
 HJIqlJYH74SBgOBjatnGPeShaV2i5axWL6q0PawPBasTW7MRo9j8LY2scukqAKFSxRDuVmsNc
 O/3pBmKTFJcHBEmWON1wI4fY0HDPy450OYbUNEe89M6X9ZP1cMkchUwxYXaipRV/kBhsaP8BU
 QfqinFuyUjTlIMrND+YH6hZ6ApkegrKv5BFmkYo8uTAnEjq6Lu9KHOmKyiw0jBvSdnClY71GP
 WG67Oi8kMoEt0/fRxIhNqlPdglOaAJ6uYp7rClFWsKMCGeqBicUhp5pWC7WQbd2cld4m7D46F
 EFyEy+2zFUiX1Y32aoDu4PnCa2pIUhP47KY3HZdBiDkKUm2HQihCGWvYxFajXxWZ1aUJsxa4C
 6GtJDomwqcyRPGH0wXf+uPJoKyg1XB59kN8pKesIUlCBSusdkR7TLs/T7CrTiMOR9ri6DIYun
 yZgdyqAw7jZFFstbZJ4OT6nK8RJieiX414w9jXtPATyGijD3f7suouQZeFISaOYpYBNUPPZcT
 ke8wnLsLflA4NAQKjfBO4yDI2J9r5+WyXFz83489j4GDmay2BzkgoZ8xuOUVBZWCWIxIgO9NN
 BxSXmGwSAa8ntO3Y3YuQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 11:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Replace SET_*_PM_OPS with *_PM_OPS, which which have the advantage that the
> compiler always sees the PM callbacks as referenced, so they don't need to
> be wrapped with "#ifdef CONFIG_PM_SLEEP" or tagged with "__maybe_unused" to
> avoid "defined but not used" warnings.
>
> See 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I did some additional testing, using an arm allmodconfig kernel with CONFIG_PM
and/or CONFIG_PM_SLEEP disabled to ensure this does not cause any
unexpected regressions. Everything seems to work as intended.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
