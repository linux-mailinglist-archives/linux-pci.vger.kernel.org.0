Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CB6BCFEB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCPMx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 08:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPMx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 08:53:27 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A82234D7;
        Thu, 16 Mar 2023 05:53:25 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id be16so1293195oib.0;
        Thu, 16 Mar 2023 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678971205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti3+/+O/mizRCYD6mJqQ9hW5peGLssPgu/LkZnsMASU=;
        b=JqU31zkHGu3ptAj9SlVRIUKZOv+itjg1RCjjVUlbvP/Ckfz2yNmItTRqLDiHNUzFBe
         U1K4kQwYZce/cY18NBc9DrOrnbzzTGlyCnMb/UbiYl3Y8MhtYMc4bF3lcsNLJdMJu3+q
         epPfgeuV3fAexV+8mRMYrXcVOtVpyfjLiQB1lEFJlN2o9h0i/GjTzoEt7p/ZTkKCun39
         hwXEj4UDbO2sBTbyF/An7M+xNP3Mbflve/fG/ARz41vvRnxcz1n0Uxk+BJ6zv9fkPhcE
         4oxvsB6mmUoFxf+4SZfEs7Oto+afHRxvgRLTRikP+w6j4JmMwcJZVv3Ex1B83LVLweTW
         50ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678971205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti3+/+O/mizRCYD6mJqQ9hW5peGLssPgu/LkZnsMASU=;
        b=oAvA2e53MX5uUjrFoUWQ6H/v+/jMW4L0V2XAQPQIxugAiyOBD6ghA/OAj9F+cyzZ+K
         u7U6hSTGAoe88KXDCkAYri09kI1LzJwF/oaMj+9WCZkqAGc/PQ7pmgw5tISu0zfUtMi2
         kl0PBR0wA/L3hshY0MHXu83m2poM/yZVUqFKbwQbEvgRt5+vNUnSj/8sWYMZwaMT240l
         gBfum++fL62JaPGzY4IVqJWxA0fUZNM4YTNYSBZPWYWwSkQE2AvvnfrqxOnq3csx4kpw
         Z2FDFZ+h+e+S6l+tQ4eBihe6bLUF9siFSujTWBuWjy5qNiBOHuTqehWVmYUZJGS5LTMP
         Ytlg==
X-Gm-Message-State: AO0yUKUMqrc4y8IWa+EmA6bOGzOCLEyA6JT8r7uU7Htiqt839SLXFzn8
        aTEpEDVCXIp0e0J0XxhQfLJ5fguMagk021KGjtE=
X-Google-Smtp-Source: AK7set9dWfwo7U4qmaHBStrTqQn7i/IJd9cr8lIzLT0RjtSxZKwFMzDm73eMdiD2f1s0u9V2YNi2R3uy/djkKyapVuo=
X-Received: by 2002:a05:6808:29a:b0:386:9864:5064 with SMTP id
 z26-20020a056808029a00b0038698645064mr1739501oic.10.1678971205044; Thu, 16
 Mar 2023 05:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com> <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com> <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
 <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com> <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
In-Reply-To: <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Thu, 16 Mar 2023 13:52:49 +0100
Message-ID: <CAAEEuhoB2LqL=B_BQ0X2T-E+Yt83kPUiv-R9dgU0O-f22ukcWg@mail.gmail.com>
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

On Wed, Mar 15, 2023 at 1:00=E2=80=AFAM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/15/23 07:54, Damien Le Moal wrote:
> > On 3/14/23 23:53, Rick Wertenbroek wrote:
> >> Hello Damien,
> >> I also noticed random issues I suspect to be related to link status or=
 power
> >> state, in my case it sometimes happens that the BARs (0-6) in the conf=
ig
> >> space get reset to 0. This is not due to the driver because the driver=
 never
> >> ever accesses these registers (@0xfd80'0010 to 0xfd80'0024 TRM
> >> 17.6.4.1.5-17.6.4.1.10).
> >> I don't think the host rewrites them because lspci shows the BARs as
> >> "[virtual]" which means they have been assigned by host but have 0
> >> value in the endpoint device (when lspci rereads the PCI config header=
).
> >> See https://github.com/pciutils/pciutils/blob/master/lspci.c#L422
> >>
> >> So I suspect the controller detects something related to link status o=
r
> >> power state and internally (in hardware) resets those registers. It's =
not
> >> the kernel code, it never accesses these regs. The problem occurs
> >> very randomly, sometimes in a few seconds, sometimes I cannot see
> >> it for a whole day.
> >>
> >> Is this similar to what you are experiencing ?
> >
> > Yes. I sometimes get NMIs after starting the function driver, when my f=
unction
> > driver starts probing the bar registers after seeing the host changing =
one
> > register. And the link also comes up with 4 lanes or 2 lanes, random.

Hello, I have never had it come up with only 2 lanes, I get 4 consistently.
I have it connected through a M.2 to female PCIe 16x (4x electrically
connected),
then through a male-to-male PCIe 4x cable with TX/RX swap, then through a
16x extender. All three cables are approx 25cm. It seems stable.

> >
> >> Do you have any idea as to what could make these registers to be reset
> >> (I could not find anything in the TRM, also nothing in the driver seem=
s to
> >> cause it).
> >
> > My thinking is that since we do not have a linkup notifier, the functio=
n driver
> > starts setting things up without the link established (e.g. when the ho=
st is
> > still powered down). Once the host start booting and pic link is establ=
ished,
> > things may be reset in the hardware... That is the only thing I can thi=
nk of.

This might be worth investigating, I'll look into it, but it seems
many of the EP
drivers don't have a Linkup notifier,
drivers/pci/controller/dwc/pci-dra7xx.c has
one, but most of the other EP drivers don't have them, so it might not be
absolutely required.

> >
> > And yes, there are definitely something going on with the power states =
too I
> > think: if I let things idle for a few minutes, everything stops working=
: no
> > activity seen on the endpoint over the BARs. I tried enabling the sys a=
nd client
> > interrupts to see if I can see power state changes, or if clearing the
> > interrupts helps (they are masked by default), but no change. And booti=
ng the
> > host with pci_aspm=3Doff does not help either. Also tried to change all=
 the
> > capabilities related to link & power states to "off" (not supported), a=
nd no
> > change either. So currently, I am out of ideas regarding that one.
> >
> > I am trying to make progress on my endpoint driver (nvme function) to b=
e sure it
> > is not a bug there that breaks things. I may still have something bad b=
ecause
> > when I enable the BIOS native NVMe driver on the host, either the host =
does not
> > boot, or grub crashes with memory corruptions. Overall, not yet very st=
able and
> > still trying to sort out the root cause of that.

I am also working on an NVMe driver but I have our NVMe firmware running in
userspace so our endpoint function driver only exposes the BARs as UIO
mapped memory and has a simple interface to generate IRQs to host / initiat=
e
DMA transfers.

So that driver does very little in itself and I still have problems
with the BARs
getting unmapped (reset to 0) randomly. I hope your patches for monitoring
the IRQs will shed some light on this. I also observed the BARs getting res=
et
with the pcie ep test function driver, so I don't think it necessarily
is the function
that is to blame, rather the controller itself (also because none of
the kernel code
should / does access the BARs registers @0xfd80'0010).

>
> By the way, enabling the interrupts to see the error notifications, I do =
see a
> lot of retry timeout and other recoverable errors. So the issues I am see=
ing
> could be due to my PCI cable setup that is not ideal (bad signal, ground =
loops,
> ... ?). Not sure. I do not have a PCI analyzer handy :)
>
> I attached the patches I used to enable the EP interrupts. Enabling debug=
 prints
> will tell you what is going on. That may give you some hints on your setu=
p ?
>
> --
> Damien Le Moal
> Western Digital Research

Thank you for these patches. I will try them and see if they give me more i=
nfo.

Also, I will delay the release of the v3 of my patch series because of
these issues.
The v3 only incorporates the changes discussed here in the mailing list so =
your
version should be up to date. If you want me to send you the series in
its current
state let me know.

But I will need some more debugging, I'll release the v3 when the driver is=
 more
stable. I don't when, I don't have that much time on this project. Thanks f=
or
your understanding.

Rick
