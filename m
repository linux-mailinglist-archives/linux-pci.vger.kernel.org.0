Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1392F6E5AFA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDRHw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDRHwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:52:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362CE44;
        Tue, 18 Apr 2023 00:52:02 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a42e7c5c1cso278737a34.1;
        Tue, 18 Apr 2023 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681804318; x=1684396318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XKhV+MHr8awDXVQkhnmJAIOVO3SkBSAcDrv3qZeqRM=;
        b=rrkaalIeM9kzkvkcOzG9Cmmyv7VvFDvJKRqUG7Q3CftIrvvz2WwXHtRrLix0+a8hFE
         yCgJjUa5UNYL+Mt7eRS1xwHDxbMEtzGO9m8qTfpwIMpeFb5ConrK88WZWNkz0GrK3ydM
         Pda0Rq0N3W9xkkTS/7mXn5ELspTCAQjAqgzE+rUgh8Y/VHcDy6DOneeHsHyj5xy0TURO
         ess8N0k7sIfnISioHvoFzKJ5y/gbEt5HXw2+dsFWzQEhvVdHWUuWM7Mp3ejzEofHKz5N
         s7FMD645r+DSiXJJLQN0c7GU5liY2co+Hi+L8os9E99RNCEuxWvOIuzb3nmeI/DIe7g9
         YOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804318; x=1684396318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XKhV+MHr8awDXVQkhnmJAIOVO3SkBSAcDrv3qZeqRM=;
        b=Kj9QUtZ9T8Zb2nGV9HXg1KPFAus4Hqn4JLeMDX++DRex8CzPZoYKSSxEUj6sKDOrA+
         sfkxesJojeH0XUtiKCsXunS0wU//aS60RMIb7H3Rp7E6iNVCSbHRfbL+618V1esyLSbL
         Z8TaXIKTKUfhaiwYH023+TrXZ9ICauaxddVAG9TTsrxB3scTogvHStMMmcDhzEAyPZEF
         GB3bWVMsltKE27g6hrXfkWgpLkl0edNo7eL/4uOQFmxUVDDGiTR1/IDX/KgqVUMz2G1e
         VGl3wu5tpv2DRKAYPe1ZJv0i1uOj8qmeZT/K4EO/XWRfmGP9S9cHn3oaYzvnyfLkbBPQ
         EfaA==
X-Gm-Message-State: AAQBX9dbVR90Y5IdQGdnJe+cU1MDYJ6ZGPSUOb67bDNICQ6jUHQ+wFNU
        sdw17YcefrPcSVNr+foxZiySBHhfZdax5R6F1do=
X-Google-Smtp-Source: AKy350Zf3sU1nYlYoPeOkzMHw/dQgTtJBMd+Y2Opy7BQqFfpE+zvN8yJAMYfsfPRC6Nae8Yrf/jpNP/3BUrfesjrWtA=
X-Received: by 2002:a05:6830:1486:b0:6a4:3385:7a6f with SMTP id
 s6-20020a056830148600b006a433857a6fmr412331otq.4.1681804317971; Tue, 18 Apr
 2023 00:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com> <ea29e339-6f61-5bbb-7290-03df629d5b11@kernel.org>
In-Reply-To: <ea29e339-6f61-5bbb-7290-03df629d5b11@kernel.org>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 18 Apr 2023 09:51:21 +0200
Message-ID: <CAAEEuhpj4TZNrPEPn7LuGOHHoYt1FbCEGH1d9g+8iKMeoBA+=Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] PCI: rockchip: Fix RK3399 PCIe endpoint
 controller driver
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 2:09=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 4/17/23 18:26, Rick Wertenbroek wrote:
> > This is a series of patches that fixes the PCIe endpoint controller dri=
ver
> > for the Rockchip RK3399 SoC. The driver was introduced in commit
> > cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controlle=
r")
> > The original driver had issues and would not allow for the RK3399 to
> > operate in PCIe endpoint mode correctly. This patch series fixes that s=
o
> > that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> > endpoint. This is v4 of the patch series and addresses the comments rec=
eived
> > during the review of the v3 [1]. The changes to the v3 are minor and no=
ne of
> > them change the logic of the driver.
> >
> > Thank you in advance for reviewing this patch series and hopefully
> > getting this merged. Having a functional PCIe endpoint controller
> > driver for the RK3399 would allow to develop further PCIe endpoint
> > functions through the Linux PCIe endpoint framework using this SoC.
> >
> > [1] https://lore.kernel.org/linux-pci/20230404082426.3880812-1-rick.wer=
tenbroek@gmail.com/
> >
> > Summary of changes to V3 :
> >
> > * Set the fields in the standard order in the dtsi and removed unnecess=
ary
> >   change in associated documentation, thanks to Krzysztof for pointing =
this out.
> > * Added comment to explain how MSI-X capabilities advertisement was rem=
oved.
> > * Changed Damien Le Moal <damien.lemoal@opensource.wdc.com> address to =
his
> >   kernel.org address Damien Le Moal <dlemoal@kernel.org> in tags.
> > * [minor] Simplified code where a power of 2 was applied followed by a =
ilog2
> >   operation.
> > * [minor] Small code changes, replaced constant variable by macro, spli=
t
> >   remaining long lines.
>
> I retested this series, all good. So my Tested-by tag stands.
>
> Lorenzo, Krzysztof, Bjorn,
>
> Let's please get this series queued for 6.4 ASAP as otherwise the rockchi=
p EP
> controller is unusable.
>
> Also please note that working with Rick off-list, we found out that more =
fixes
> are in fact needed for the PCI address mapping (ATU programming) on top o=
f this
> series. But the problems detected are subtle and harder to trigger. The f=
ixes
> needed involve changes to the EPC core API so we are still working on the=
 best
> way to do that. We'll work on another series on top of this one for addre=
ssing
> these issues.
>
>

Thank you Damien for taking the time testing and reviewing this, it is
highly appreciated.
I just sent a v5 [1] addressing your comments and added the tags.

Best regards,
Rick

[1] https://lore.kernel.org/linux-pci/20230418074700.1083505-1-rick.wertenb=
roek@gmail.com/
