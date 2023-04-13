Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753726E1011
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDMOfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMOfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 10:35:18 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B47ED8;
        Thu, 13 Apr 2023 07:35:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-183f4efa98aso24209066fac.2;
        Thu, 13 Apr 2023 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681396516; x=1683988516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP1l0y4cD5yKB1hePqZclJ5kk1fyrn0MXx0ITLwG3DY=;
        b=lSjxDXA8pv9ruHAzrKSK+AgBNOx5sPVcSb1NuYft4l06BYSf+lducvV84LnIhGUf+n
         URr/dzeEpv2R4bs+TgLnuMbMwkXEcBBKDMOAQTyoFcpF62Opu8kZ7vxMVoYoh+QIIc9P
         Ke+iVPNT+W7F5Pv0f8A5xdPHZHe2gcNxfJJ2fM5XJ6jqteEznPgHxB5chSpOrf1Sib0m
         aHejbNbD/2Bj5dEJ+p3zv4CpGN6PpilHrPrQP0w0SO1xiqB16zmPzJ5Kc9/P6iIdQ26b
         SJfR4JaqFYoI++TxhE+W5GwdIjiNmBWZGbN8Y8b1dl/2qdRFVor1AJtwxqm9/3eeVUwL
         wSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681396516; x=1683988516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP1l0y4cD5yKB1hePqZclJ5kk1fyrn0MXx0ITLwG3DY=;
        b=MQ/fENaiyOmm0M+COysc8PJ72aqM3ArVBw+oL4A/JAvMEBO3Vmt0fUE9KflBYHCOPu
         piO96+c6uqDpXdx0TB/aT1bJ/Gzzo4P6bUszHQ0fZyMKsSyHpsO3WDB58dh4Rspa3fSY
         mXhxsvi9+V3YDQR0TUMtQTnKS44i29D7o3LZka7fZX/J87bQ6WdQHaJon26sIuXwzUkc
         Tcn0DXcA4bwGwYMurRj5p85YiWvBAuUWjkp5cCBByUGZrAkt3f2DJ46Im+cGLl79pXlG
         VfXEAGSlsvF1kKzRV8hHK2XUNDZvzOY7vAUfX+/e1a+DLORak0ZttWoGxLBE+S0o5TMB
         rvdA==
X-Gm-Message-State: AAQBX9c32bSNBJwLyNUVIh/gMYYgnko0bWHgm69IAGQuZkZiMTTGIMEi
        cxEPjTk95ZSndFmoyNMSYb2M9FEWdCcAyDjHs+8=
X-Google-Smtp-Source: AKy350ZifiwgVFIFHHCxOfDLu7eQ6z0WhZE63KnFK+OlGp74DjjsP6/VEb8ragWGy9qRyK+pT+WNCbaI7yCyE9KpaxY=
X-Received: by 2002:a05:6870:3326:b0:17e:5bc4:9ac9 with SMTP id
 x38-20020a056870332600b0017e5bc49ac9mr1314902oae.10.1681396516540; Thu, 13
 Apr 2023 07:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com> <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com> <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
 <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com> <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
 <CAAEEuhoB2LqL=B_BQ0X2T-E+Yt83kPUiv-R9dgU0O-f22ukcWg@mail.gmail.com>
 <CAAEEuhp5WTkaPDRLa8frc9Sc43A3HwApW647v-E9Bse6p5Df5Q@mail.gmail.com>
 <15208569-b3d7-b9f7-6676-9d9122cac84a@opensource.wdc.com> <ZDgIZmCgLoC/uieX@lpieralisi>
In-Reply-To: <ZDgIZmCgLoC/uieX@lpieralisi>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Thu, 13 Apr 2023 16:34:40 +0200
Message-ID: <CAAEEuhocJpmtAQPCxgnsEbkqe9yyK1-p0ZpwuZBJxHVbMukiYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 3:49=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Fri, Mar 17, 2023 at 07:09:04AM +0900, Damien Le Moal wrote:
> > On 3/17/23 01:34, Rick Wertenbroek wrote:
> > >>> By the way, enabling the interrupts to see the error notifications,=
 I do see a
> > >>> lot of retry timeout and other recoverable errors. So the issues I =
am seeing
> > >>> could be due to my PCI cable setup that is not ideal (bad signal, g=
round loops,
> > >>> ... ?). Not sure. I do not have a PCI analyzer handy :)
> > >
> > > I have enabled the IRQs and messages thanks to your patches but I don=
't get
> > > messages from the IRQs (it seems no IRQs are fired). My PCIe link see=
ms stable.
> > > The main issue I face is still that after a random amount of time, th=
e BARs are
> > > reset to 0, I don't have a PCIe analyzer so I cannot chase config spa=
ce TLPs
> > > (e.g., host writing the BAR values to the config header), but I don't=
 think that
> > > the problem comes from a TLP issued from the host. (it might be).
> >
> > Hmmm... I am getting lots of IRQs, especially the ones signaling "repla=
y timer
> > timed out" and "replay timer rolled over after 4 transmissions of the s=
ame TLP"
> > but also some "phy error detected on receive side"... Need to try to re=
work my
> > cable setup I guess.
> >
> > As for the BARs being reset to 0, I have not checked, but it may be why=
 I see
> > things not working after some inactivity. Will check that. We may be se=
eing the
> > same regarding that.
> >
> > > I don't think it's a buffer overflow / out-of-bounds access by kernel
> > > code for two reasons
> > > 1) The values in the config space around the BARs is coherent and unc=
hanged
> > > 2) The bars are reset to 0 and not a random value
> > >
> > > I suspect a hardware reset of those registers issued internally in th=
e
> > > PCIe controller,
> > > I don't know why (it might be a link related event or power state
> > > related event).
> > >
> > > I have also experienced very slow behavior with the PCI endpoint test=
 driver,
> > > e.g., pcitest -w 1024 -d would take tens of seconds to complete. It s=
eems to
> > > come from LCRC errors, when I check the "LCRC Error count register"
> > > @0xFD90'0214 I can see it drastically increase between two calls of p=
citest
> > > (when I mean drastically it means by 6607 (0x19CF) for example).
> > >
> > > The "ECC Correctable Error Count Register" @0xFD90'0218 reads 0 thoug=
h.
> > >
> > > I have tried to shorten the cabling by removing one of the PCIe exten=
ders, that
> > > didn't change the issues much.
> > >
> > > Any ideas as to why I see a large number of TLPs with LCRC errors in =
them ?
> > > Do you experience the same ? What are your values in 0xFD90'0214 when
> > > running e.g., pcitest -w 1024 -d (note: you can reset the counter by =
writing
> > > 0xFFFF to it in case it reaches the maximum value of 0xFFFF).
> >
> > I have not checked. But I will look at these counters to see what I hav=
e there.
>
> Hi,
>
> checking where are we with this thread and whether there is something to
> consider for v6.4, if testing succeeds.
>
> Thanks,
> Lorenzo

Hello,
Thank you for considering this.

There is a V3 of this patch series [1|, that fixes the issues
encountered with the V2.
The debugging following this thread was discussed off-list with Damien Le M=
oal.
The V3 has been tested successfully by Damien Le Moal [2]

I will submit a V4 next week, since there are minor changes that were
suggested in
the threads for the V3 (mostly minor changes in code style, macros, comment=
s).

I hope it can be considered for v6.4, thank you.

[1] https://lore.kernel.org/linux-pci/29a5ccc3-d2c8-b844-a333-28bc20657942@=
fastmail.com/T/#mc8f2589ff04862175cb0c906b38cb37a90db0e42
[2] https://lore.kernel.org/linux-pci/29a5ccc3-d2c8-b844-a333-28bc20657942@=
fastmail.com/


Notes on what was discovered off-list :

The issues regarding BAR reset were due to power supply issues (PCI cable
jumping host 3V3 supply to SoC 3V3 supply, and are fixed with proper cablin=
g).
a few LCRC errors are normal with PCIe, the number will depend on
signal integrity
at the physical layer (cabling).


Best regards,
Rick
