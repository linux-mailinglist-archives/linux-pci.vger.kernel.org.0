Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31876D659F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDDOmz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDDOmy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 10:42:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3142E51;
        Tue,  4 Apr 2023 07:42:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r14so18689191oiw.12;
        Tue, 04 Apr 2023 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680619373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za5BO/JgKy56P0P/Z8yk+aMunnq2fdjXd9ztVhDZs+E=;
        b=S/XoFNDUa4RahS6B4V+VsVOf16zucDqkJ+QMdZlpXWLfiNtquZ4Q7Ow7PAJ6f0xhVC
         4gY05G4PwrVh94KhtkQh6wXmUzH7lDGaz2wZeVmQfSAdXhFKk5PRZtJH8a/qDrM0xHiZ
         RNt7Q6WGzJeTbrh0YgdoKyzylFHC8EoIa4W7ekqvnKPqMV3NL6wHIFsCZWJRclQXE5lk
         X/ePKsGsZk5gsbsCfzNFyFUc+WGObK+ai4mH33lR0+uovfqnynNeYXr7JlFTU6Ql65X5
         FbksPoUTrbUNZI72nKeWMwkSRasU9R96IQ+hYwLh9A/ps96VGsYoafia+BCVeM5qEe/O
         fdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680619373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za5BO/JgKy56P0P/Z8yk+aMunnq2fdjXd9ztVhDZs+E=;
        b=ki7yA/P4ZGpvdZEK15Uw3Bsjk3y1LqJXeOR0wEeTsWcSTg+YSoMfFz7VI3sbU/bUOt
         C+6KUWGqIB/lZcU8gLeSs0dPqL5BZiG7UBMB6cWP+NFOoflhBROkrTZ5soAc94ztV6wg
         W5U1WXNyPKrZYnQSe75IxIbZFRiQGWKYfvd5X1ywVoAr0ZsiillzLcg668Op9iwtpwEF
         pa+eUxKj6EQCAc+yYOSWI/0mjvxgGA50neUAppRifpShSaKqvjRrg5rN5+DaHXckTW+c
         UhWoDpQA4NElg0glIO49eL/cssH8CM+HYIdIkxAOgcArHcAD7Sc1O0VPAYjxGUMTwoaB
         slbA==
X-Gm-Message-State: AAQBX9fcAzRjG5VQk8c/Lte0rxKKg/152rfXVAr4oecow3ioaLpuV0j+
        PQlFlmxDW1HZzCzHw2tMgkGpixQYlBOVzkgrm3E=
X-Google-Smtp-Source: AKy350Yif0VDmVk5S4ytwPYSwOTwWcOv3HAhfzuoUQ5lZDzYswoW99NaLv4P5VfBNlyPbniOeS7jNdmYF5wPxuFr1nA=
X-Received: by 2002:a05:6808:6294:b0:389:72d5:f15f with SMTP id
 du20-20020a056808629400b0038972d5f15fmr1093634oib.10.1680619373128; Tue, 04
 Apr 2023 07:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
 <20230404082426.3880812-7-rick.wertenbroek@gmail.com> <d9afc07f-0346-1fe7-907c-261e4c6f92cd@linaro.org>
 <CAAEEuhrnp1QyP498V1wzyLv6KvfRCpNidF9NJpzg+kofWqrJtA@mail.gmail.com> <63d456fa-4db5-96fc-107e-060e59754096@linaro.org>
In-Reply-To: <63d456fa-4db5-96fc-107e-060e59754096@linaro.org>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 4 Apr 2023 16:42:17 +0200
Message-ID: <CAAEEuhopfXnCBzAr2avNKuzZG+7ARisse9jd+ydwPCq1U56Sug@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: PCI: Update the RK3399 example to a
 valid one
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alberto.dassatti@heig-vd.ch, damien.lemoal@opensource.wdc.com,
        xxm@rock-chips.com, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 4, 2023 at 3:29=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2023 10:58, Rick Wertenbroek wrote:
> > On Tue, Apr 4, 2023 at 10:45=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 04/04/2023 10:24, Rick Wertenbroek wrote:
> >>> Update the example in the documentation a valid example.
> >>> The default max-outbound-regions is 32 but the example showed 16.
> >>
> >> This is not reason to be invalid. It is perfectly fine to change defau=
lt
> >> values to desired ones. What is not actually obvious is to change some
> >> value to a default one, instead of removing it...
> >
> > Hello, the example value <0x0 0x80000000 0x0 0x20000>; is plain wrong
> > and will crash the kernel. This is a value that point to an address tha=
t falls
> > in the DDR RAM region but depending on the amount of RAM on the
> > board this address may not even exist (e.g., board with 2GB or less).
>
> We talk about max-outbound-regions.

Okay, sorry, I didn't get that, you are right, there is nothing wrong with =
16.
I'll remove that change and leave it be.

>
> >
> > Also this address requires pointing to where the PCIe controller has th=
e
> > windows from AXI Physical space to PCIe space. This address is
> > allocated when the SoC address map is created so it can only be that
> > one unless rockchip refabs the SoC with another address map.
> >
> > The example never worked with the values given as reported by e.g.,
> > https://stackoverflow.com/questions/73586703/device-tree-issues-with-ro=
ckpro64-pcie-endpoint
> > and here they set it to 0 (base of the DDR, which is a "valid" address
> > as to it exists even on boards with less than 2GB) but it is still wron=
g
> > to do so.
>
> Again, my comment was under max-outbound-regions, not under some other
> pieces. Does this all apply?
>
> Best regards,
> Krzysztof
>

I'll remove the change to the max-outbound-regions, it is not needed.
I'll place the registers as second parameter, both on the dtsi entry and he=
re.
I'll keep the change to the register value because it is necessary along
with the added pinctrl.

This will simplify the patch, avoid unnecessary changes, and make
things clearer.

Sorry for the misunderstanding.
Regards,
Rick
