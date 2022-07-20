Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE557B5A6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiGTLhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbiGTLhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 07:37:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80425EA6;
        Wed, 20 Jul 2022 04:37:05 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N8onQ-1nPrbt0cp4-015t42; Wed, 20 Jul 2022 13:37:03 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31e560aa854so58569257b3.6;
        Wed, 20 Jul 2022 04:37:02 -0700 (PDT)
X-Gm-Message-State: AJIora8z8yEmCHyo9sbV7I9Dw4M09OZPsBEhzQOOuYdtoYglJv5y1X8A
        T9SDWfH+suMKxAYKPCtcCdX8ziW468X3Q6ZEj54=
X-Google-Smtp-Source: AGRyM1sKPSahdmCu+qEUeKZXmC18+OtHgEhy4GWMB2DnCCJ6zsqq+8kDkucSRV8xeM5zDGKpT0NdUElbXHEITHvOsHs=
X-Received: by 2002:a81:6dce:0:b0:31e:5a3b:d3a2 with SMTP id
 i197-20020a816dce000000b0031e5a3bd3a2mr8532088ywc.495.1658317021746; Wed, 20
 Jul 2022 04:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
In-Reply-To: <20220718202843.6766-1-maukka@ext.kapsi.fi>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jul 2022 13:36:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0i3NWhbJGsCM0Eg7JPetnd_mgvEBhJ-3Vzu=ggm8v36w@mail.gmail.com>
Message-ID: <CAK8P3a0i3NWhbJGsCM0Eg7JPetnd_mgvEBhJ-3Vzu=ggm8v36w@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: mvebu: add support for orion soc
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AMR1ZC4GWmRHB88H75CbIvf9GY2S4dM5EVX6AxfQbofzyegrWlT
 b4aECQw+a8kysEPj/z2p3CGgppbUkU9W+UU91ch8uwQuIJIrwrg4mja5IjmV2OsGW3r3StS
 3ehCZcG3sc7MfeX/+D3oXS3F1zG9fEUqdegj7NeH0AsslAludI1qWOHyspgGzs2AxxqP1k8
 LHFLlSbawZEmDo5prJX9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TVoKnYn9ioI=:Mz75K8mP34pTRgWbwXJnrD
 VGb5nzs2QRg/rbxpGq7Wk3sERYOzDQ7tayREXA5fr4nU7CknEn6ZZx8fMaTdEu81VpmZDVlmQ
 POPAE7Ul7Dm87aJ3xgbwaiTh+OiIzi6w5n+i9qVGO81DL4tqvXoJcBrJ6kA2WTMYBNXvdKgGQ
 TywFMuH3bBRYTOII5QQVVdyesjTKg4jz6j3RD+oojLwk/TlClL3AwVwDwWIvIR6Vt1Xgy2VSS
 y8wdhnPXHh7nZ4H1l810ZdVaBlS2mFSm9+D0vFlgnY16zG8pIAYMcbc3D9fO155INTFbDmnM7
 ySVTOLv1IgcLIvQI2jGsi+VQUH5cc7KBiJVE8U95KHTFDq69hFiXzLaJSxRTyFcZWWjx9DH/U
 +hrc40dzRtRtX9/itnSY2fWmO9IkvDJIux4UkVJI0FwOXgJM18t9fCkQbNF9F5IRhqy1iv2wq
 APXCDSNdodEW4pNn8kimepBs4GWfrN5cz862ooI92nA7AeR0b2oNj9wHhkKlCGk97CKIZjRrE
 Ro6cLtY+r3PuVU0dDFzByctBNSugs5yVwy2ZalnNZeZeXBM7XlHjJHqDeg+ptz+gx8yytKhiF
 ePLQjIrEovQwOBHMREX39rWGUYmRJxXEfbQMx72qcYBgcSIJMgnHy0stxxLgKktRB6nNecsvw
 LfTioxOP8dFDxabNuHYq5Lom+0taLUHj5JlldFD5haO1NI/4qgzrK/9Tw7PpDErP2f81z70wz
 NnhQNGIBG+N1FqGikMk/ZkboUw7HGk6s/BJtQDdpIsltNmes78LnsnWLm/OFo8tl/NNH+lsxU
 n0qp5f8DcEYnd8Ejmn2UIa9j8oS322KWHlri+Dh3AGBStKYHB4nJTDTNZ5anXIksa/y+ZGZFp
 Bm1DWQrG9z5QR7WmMkScfeIkvg47/Xm6J4OA2MXaE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 10:28 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:
>
> Hello all!
>
> Working in close co-operation with Pali we made an initial attempt at bringing
> support for orion PCIe into mvebu PCIe driver. Currently the address of
> workaround memory range is hard coded and based on compatible string only. As
> Pali describes in another thread, we were not able to figure out what's the
> correct way to configure a configuration space. That discussion is here:
> https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/T/#u
>
> I tested this with D-Link DNS-323 rev A1 and it's working. As usual, all
> comments and feedback is welcome.

Hi Mauri,

I've managed to dig out my old series for reworking the orion5x PCI/PCIe
support, to the point where the two drivers are completely independent.

Please have a look at
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=orion-pci-cleanup

to see if this helps you at all. I see now that your DNS-323 only supports
PCIe but not PCI, so maybe it's not all that helpful for your machine,
but it should help for converting the other ones that do use legacy
PCI and want to base DT support on top of this work.

      Arnd
