Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16466BD5F1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 17:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCPQhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCPQgc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 12:36:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E819E7EC7;
        Thu, 16 Mar 2023 09:35:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bi17so1779812oib.3;
        Thu, 16 Mar 2023 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678984525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVIDq1Rt4zjnkd6/VAJXZWtFVjJu9xUQJMx1JEqCASI=;
        b=K2ryXjlB9cHhdb/qV6WfD3/YmVqCLuqs+v1uIQVlbQbuyIuqrrY5QsB4UjwQJMsIpP
         DI2lFYObUOJIBNRTL819r2uHyjcyv2CJHsAmSDtBnPgJxjauU11AzbeGYPcEgF19UdrA
         w+BTX+KOVzSzL1AR9FJDz779d6S5HQtmjY0XVYKeuewhwmyRJHkb418t5bC6qf1QKriH
         KnhJdlMevoCU0l6JaNgQt61c1Bw41DZOdK4Vdk684ObBtgeN/EyrkxohT9VFQDXjnyHN
         9pQ13OYzsh3qkceu1Lv9WqqcRVdpWfw/nST0DQWMg/kUc0l4xEFKRIgOu++VQsZw3DfJ
         35Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVIDq1Rt4zjnkd6/VAJXZWtFVjJu9xUQJMx1JEqCASI=;
        b=NbfZIrl+1q17gWIcfB20sHRrFT3eoSDkxbNptHD+McVtoJEYOMRmpMe5qn6P6pzrg/
         +aXIEz7vhYgqgPZChrTpjQUd/k3pJDmJpV7dkH78yXp/04y8fsIoxQmyFOKlPObViXBU
         0LVGWLyD1nGwKYwB4/flQNCCDL/VJG11kw0Zzvu+rk6lBrYO+lkIwHBm07z1x4PLxvu5
         YQHt/RSfdu3gjMOasuZMdkTJxw6EkKZFkjFB1q6PorfKysbnQJhRMfC2TIY+fY2ACnG7
         L1McVOeIonTSX75HdsoPOVq4yP5m5YL3GjiEOKCMTYl/dhB14RaGu6JyK1aahGtKgHm4
         vswg==
X-Gm-Message-State: AO0yUKX8g7NF6EVF/XZmLqT4qlNT1D8EAuqq38qx9v9gdLwmvSrOT4tq
        HsKv6pbjZtcD/K73bafn3u6UDIm4fXXqpiq5n5G0t56lsuUITA==
X-Google-Smtp-Source: AK7set+gYNRh5UsRzUacNyCSd40EkmC9CVuLIkj8jsHHP2oIEGC/5QzCawnkyHinKUs32F2EpRj0RINHh4JWjtu1Tqw=
X-Received: by 2002:a54:489a:0:b0:386:ce06:8d61 with SMTP id
 r26-20020a54489a000000b00386ce068d61mr4160oic.10.1678984525215; Thu, 16 Mar
 2023 09:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com> <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com> <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
 <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com> <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
 <CAAEEuhoB2LqL=B_BQ0X2T-E+Yt83kPUiv-R9dgU0O-f22ukcWg@mail.gmail.com>
In-Reply-To: <CAAEEuhoB2LqL=B_BQ0X2T-E+Yt83kPUiv-R9dgU0O-f22ukcWg@mail.gmail.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Thu, 16 Mar 2023 17:34:48 +0100
Message-ID: <CAAEEuhp5WTkaPDRLa8frc9Sc43A3HwApW647v-E9Bse6p5Df5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
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

On Thu, Mar 16, 2023 at 1:52=E2=80=AFPM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> On Wed, Mar 15, 2023 at 1:00=E2=80=AFAM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 3/15/23 07:54, Damien Le Moal wrote:
> > > On 3/14/23 23:53, Rick Wertenbroek wrote:
> > >> Hello Damien,
> > >> I also noticed random issues I suspect to be related to link status =
or power
> > >> state, in my case it sometimes happens that the BARs (0-6) in the co=
nfig
> > >> space get reset to 0. This is not due to the driver because the driv=
er never
> > >> ever accesses these registers (@0xfd80'0010 to 0xfd80'0024 TRM
> > >> 17.6.4.1.5-17.6.4.1.10).
> > >> I don't think the host rewrites them because lspci shows the BARs as
> > >> "[virtual]" which means they have been assigned by host but have 0
> > >> value in the endpoint device (when lspci rereads the PCI config head=
er).
> > >> See https://github.com/pciutils/pciutils/blob/master/lspci.c#L422
> > >>
> > >> So I suspect the controller detects something related to link status=
 or
> > >> power state and internally (in hardware) resets those registers. It'=
s not
> > >> the kernel code, it never accesses these regs. The problem occurs
> > >> very randomly, sometimes in a few seconds, sometimes I cannot see
> > >> it for a whole day.
> > >>
> > >> Is this similar to what you are experiencing ?
> > >
> > > Yes. I sometimes get NMIs after starting the function driver, when my=
 function
> > > driver starts probing the bar registers after seeing the host changin=
g one
> > > register. And the link also comes up with 4 lanes or 2 lanes, random.
>
> Hello, I have never had it come up with only 2 lanes, I get 4 consistentl=
y.
> I have it connected through a M.2 to female PCIe 16x (4x electrically
> connected),
> then through a male-to-male PCIe 4x cable with TX/RX swap, then through a
> 16x extender. All three cables are approx 25cm. It seems stable.
>
> > >
> > >> Do you have any idea as to what could make these registers to be res=
et
> > >> (I could not find anything in the TRM, also nothing in the driver se=
ems to
> > >> cause it).
> > >
> > > My thinking is that since we do not have a linkup notifier, the funct=
ion driver
> > > starts setting things up without the link established (e.g. when the =
host is
> > > still powered down). Once the host start booting and pic link is esta=
blished,
> > > things may be reset in the hardware... That is the only thing I can t=
hink of.
>
> This might be worth investigating, I'll look into it, but it seems
> many of the EP
> drivers don't have a Linkup notifier,
> drivers/pci/controller/dwc/pci-dra7xx.c has
> one, but most of the other EP drivers don't have them, so it might not be
> absolutely required.
>
> > >
> > > And yes, there are definitely something going on with the power state=
s too I
> > > think: if I let things idle for a few minutes, everything stops worki=
ng: no
> > > activity seen on the endpoint over the BARs. I tried enabling the sys=
 and client
> > > interrupts to see if I can see power state changes, or if clearing th=
e
> > > interrupts helps (they are masked by default), but no change. And boo=
ting the
> > > host with pci_aspm=3Doff does not help either. Also tried to change a=
ll the
> > > capabilities related to link & power states to "off" (not supported),=
 and no
> > > change either. So currently, I am out of ideas regarding that one.
> > >
> > > I am trying to make progress on my endpoint driver (nvme function) to=
 be sure it
> > > is not a bug there that breaks things. I may still have something bad=
 because
> > > when I enable the BIOS native NVMe driver on the host, either the hos=
t does not
> > > boot, or grub crashes with memory corruptions. Overall, not yet very =
stable and
> > > still trying to sort out the root cause of that.
>
> I am also working on an NVMe driver but I have our NVMe firmware running =
in
> userspace so our endpoint function driver only exposes the BARs as UIO
> mapped memory and has a simple interface to generate IRQs to host / initi=
ate
> DMA transfers.
>
> So that driver does very little in itself and I still have problems
> with the BARs
> getting unmapped (reset to 0) randomly. I hope your patches for monitorin=
g
> the IRQs will shed some light on this. I also observed the BARs getting r=
eset
> with the pcie ep test function driver, so I don't think it necessarily
> is the function
> that is to blame, rather the controller itself (also because none of
> the kernel code
> should / does access the BARs registers @0xfd80'0010).
>
> >
> > By the way, enabling the interrupts to see the error notifications, I d=
o see a
> > lot of retry timeout and other recoverable errors. So the issues I am s=
eeing
> > could be due to my PCI cable setup that is not ideal (bad signal, groun=
d loops,
> > ... ?). Not sure. I do not have a PCI analyzer handy :)

I have enabled the IRQs and messages thanks to your patches but I don't get
messages from the IRQs (it seems no IRQs are fired). My PCIe link seems sta=
ble.
The main issue I face is still that after a random amount of time, the BARs=
 are
reset to 0, I don't have a PCIe analyzer so I cannot chase config space TLP=
s
(e.g., host writing the BAR values to the config header), but I don't think=
 that
the problem comes from a TLP issued from the host. (it might be).

I don't think it's a buffer overflow / out-of-bounds access by kernel
code for two reasons
1) The values in the config space around the BARs is coherent and unchanged
2) The bars are reset to 0 and not a random value

I suspect a hardware reset of those registers issued internally in the
PCIe controller,
I don't know why (it might be a link related event or power state
related event).

I have also experienced very slow behavior with the PCI endpoint test drive=
r,
e.g., pcitest -w 1024 -d would take tens of seconds to complete. It seems t=
o
come from LCRC errors, when I check the "LCRC Error count register"
@0xFD90'0214 I can see it drastically increase between two calls of pcitest
(when I mean drastically it means by 6607 (0x19CF) for example).

The "ECC Correctable Error Count Register" @0xFD90'0218 reads 0 though.

I have tried to shorten the cabling by removing one of the PCIe extenders, =
that
didn't change the issues much.

Any ideas as to why I see a large number of TLPs with LCRC errors in them ?
Do you experience the same ? What are your values in 0xFD90'0214 when
running e.g., pcitest -w 1024 -d (note: you can reset the counter by writin=
g
0xFFFF to it in case it reaches the maximum value of 0xFFFF).




> >
> > I attached the patches I used to enable the EP interrupts. Enabling deb=
ug prints
> > will tell you what is going on. That may give you some hints on your se=
tup ?
> >
> > --
> > Damien Le Moal
> > Western Digital Research
>
> Thank you for these patches. I will try them and see if they give me more=
 info.
>
> Also, I will delay the release of the v3 of my patch series because of
> these issues.
> The v3 only incorporates the changes discussed here in the mailing list s=
o your
> version should be up to date. If you want me to send you the series in
> its current
> state let me know.
>
> But I will need some more debugging, I'll release the v3 when the driver =
is more
> stable. I don't when, I don't have that much time on this project. Thanks=
 for
> your understanding.
>
> Rick
