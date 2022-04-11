Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101D4FC788
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 00:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiDKWVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348407AbiDKWVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 18:21:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CACE25297
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 15:18:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u2so108499pgq.10
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2okWBbdd+GCs1sDsnu9Mv4+fwXILXXZWcR79ZDoHwQU=;
        b=biqaWyePuAawU6jsYMqM8KuJsCVep6+RaaiKpRwaLecLEq0UdoYKojzKiE8Ii9zaqx
         BkqUEDg182qKNnBLFHBJbN+zAiAlN32U9IhDU8Frw489GSQGtyHawxpKHI4JfYYyTTqX
         uI/1UQrGlmaU2KhdCMFVBFpXmmmVUDvPxcu4odFK5W/BCgVr2iWxFmOLfD+1cHmM21Rq
         fCVIbHGUWR6vcnfdpY2RMQfc59qXjWEH2dWUHuSXhEH+7pe1bPl7iITmQYc+9OaqN2c0
         Oz7kQe6mHVMzj/W3uxAm+6gaD3vmsVe6CjAiO87gLcFvCQ4rJeUxaHVQGJ06N2Eege4V
         Ym/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2okWBbdd+GCs1sDsnu9Mv4+fwXILXXZWcR79ZDoHwQU=;
        b=eAMZnd0YxJjgIgedKBP0N4kJpYe6tKg40989KPFry/MZtSw8QRgimN2XuJIZdQgUEK
         8W1Y30wWzwYo6g6utdwxXpwxvWBgdS2dcMZFPWHBdeaLOAULjaE79ImokLWkz4b1OJtO
         pg7+oezP8CLjta7a9p59zNqzu2QVuyebuPZ9Y9vLHOmFxAtlcIQfbrqID/jU9QqfWCps
         E0X0gEETwOok3x2lTU2C13BMrQxoHwDfshrhVMW5Q8ykZb8KHijcP1cX7VQ3IBBrjHi8
         kADPbbVrQB1kNwy9zleOUXKBxsJgRWg37dACHBfjPtYyMgJKgp9ZKMnXd8L05u5jr6f8
         wYLQ==
X-Gm-Message-State: AOAM530vH4VcjeAsecQ4LSzphusVGCieMuCGXST/RsvySA3yf6tXews0
        a2c++moY4POzzbbxKRxnMXPK46E/8TDslmNBYeoLEg==
X-Google-Smtp-Source: ABdhPJzhNxZba8YXbYkY7VjRyY1TXOTWFfxQZBtgQ1b2sZYIp64yuu8OX+YzhonvjuA8EmIzXjHFX2DfMKubrejWNE0=
X-Received: by 2002:a63:6d06:0:b0:39d:6cba:9058 with SMTP id
 i6-20020a636d06000000b0039d6cba9058mr3574443pgc.440.1649715528764; Mon, 11
 Apr 2022 15:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU0McZxj_74DC0wCUyHq-NaT14URnvUP+kvudz7YLQq7fg@mail.gmail.com> <AS8PR04MB86766041887E97E22B0AC8C48CE99@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86766041887E97E22B0AC8C48CE99@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 11 Apr 2022 15:18:37 -0700
Message-ID: <CAJ+vNU3urzdR3i-VTWGfmJdW78guyG3EoHMcdNHn8kKjrFkZXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add the iMX8MP PCIe support
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 7, 2022 at 8:14 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: 2022=E5=B9=B44=E6=9C=888=E6=97=A5 4:42
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> > <l.stach@pengutronix.de>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>; bhelgaas@google.com; Lorenz=
o
> > Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; S=
hawn
> > Guo <shawnguo@kernel.org>; Vinod Koul <vkoul@kernel.org>; Alexander Ste=
in
> > <alexander.stein@ew.tq-group.com>; linux-phy@lists.infradead.org; Devic=
e
> > Tree Mailing List <devicetree@vger.kernel.org>; linux-pci@vger.kernel.o=
rg;
> > Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>; open lis=
t
> > <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> > dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2 0/7] Add the iMX8MP PCIe support
> >
> > On Mon, Mar 7, 2022 at 1:18 AM Richard Zhu <hongxing.zhu@nxp.com>
> > wrote:
> > >
> > > Based on the i.MX8MP GPC and blk-ctrl patch-set[1] issued by Lucas an=
d
> > > the following commits.
> > >   - one codes refine patch-set[5].
> > >   - two Fixes[2],[3].
> > >   - one binding commit[4].
> > >   - some dts changes in Shawn's git if you want to test PCIe on i.MX8=
MM
> > EVK.
> > >     b4d36c10bf17 arm64: dts: imx8mm-evk: Add the pcie support on
> > imx8mm evk board
> > >     aaeba6a8e226 arm64: dts: imx8mm: Add the pcie support
> > >     cfc5078432ca arm64: dts: imx8mm: Add the pcie phy support
> > >
> > > Sorry about that there may be some conflictions when do the codes mer=
ge.
> > > I'm waiting for the ack now, and will re-base them in a proper sequen=
ce later.
> > >
> > > This series patches add the i.MX8MP PCIe support and tested on i.MX8M=
M
> > > EVK and i.MX8MP EVk boards. The PCIe NVME works fine on both boards.
> > >
> > > - i.MX8MP PCIe PHY has two resets refer to the i.MX8MM PCIe PHY.
> > >   Add one more PHY reset for i.MX8MP PCIe PHY accordingly.
> > > - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
> > >   And share as much as possible codes with i.MX8MM PCIe PHY.
> > > - Add the i.MX8MP PCIe support in binding document, DTS files, and PC=
Ie
> > >   driver.
> > >
> > > Main changes v1-->v2:
> > > - It's my fault forget including Vinod, re-send v2 after include Vino=
d
> > >   and linux-phy@lists.infradead.org.
> > > - List the basements of this patch-set. The branch, codes changes and=
 so on.
> > > - Clean up some useless register and bit definitions in #3 patch.
> > >
> > > [1]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fp
> > >
> > atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F2022022820
> > 1
> > >
> > 731.3330192-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongx
> > ing.
> > >
> > zhu%40nxp.com%7C19e85ae119bc47d3397e08da18d71007%7C686ea1d3bc
> > 2b4c6fa92
> > >
> > cd99c5c301635%7C0%7C1%7C637849609225124527%7CUnknown%7CTWF
> > pbGZsb3d8eyJ
> > >
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C3000
> > >
> > &amp;sdata=3DnamjBp1ZpawS9s25%2FwS8aOnd2A7rHTK2rQRwG4V0Dt8%3D&
> > amp;reserv
> > > ed=3D0
> > > [2]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fp
> > >
> > atchwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F1646289275-17813-
> > 1
> > >
> > -git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D04%7C01%7Chongxi
> > ng.
> > >
> > zhu%40nxp.com%7C19e85ae119bc47d3397e08da18d71007%7C686ea1d3bc
> > 2b4c6fa92
> > >
> > cd99c5c301635%7C0%7C1%7C637849609225124527%7CUnknown%7CTWF
> > pbGZsb3d8eyJ
> > >
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C3000
> > >
> > &amp;sdata=3DdWr1ui7eIc92iWzvo8VKPXTkNel3NR9yNxD5CyHIuV0%3D&amp;r
> > eserved
> > > =3D0
> > > [3]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fp
> > >
> > atchwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F1645672013-8949-1
> > -
> > >
> > git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D04%7C01%7Chongxi
> > ng.z
> > >
> > hu%40nxp.com%7C19e85ae119bc47d3397e08da18d71007%7C686ea1d3bc2
> > b4c6fa92c
> > >
> > d99c5c301635%7C0%7C1%7C637849609225124527%7CUnknown%7CTWFp
> > bGZsb3d8eyJW
> > >
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> > 000&
> > >
> > amp;sdata=3DFCis4KE9KZqS8Ou6I0KTQu%2FayWSm%2Ftj%2Bcrd68EThsNs%3D
> > &amp;res
> > > erved=3D0
> > > [4]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fp
> > >
> > atchwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F1646293805-18248-
> > 1
> > >
> > -git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D04%7C01%7Chongxi
> > ng.
> > >
> > zhu%40nxp.com%7C19e85ae119bc47d3397e08da18d71007%7C686ea1d3bc
> > 2b4c6fa92
> > >
> > cd99c5c301635%7C0%7C1%7C637849609225124527%7CUnknown%7CTWF
> > pbGZsb3d8eyJ
> > >
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C3000
> > >
> > &amp;sdata=3DsbYuLpfBFUImVi7YLe%2FCYvQNxleK2tnHKfr%2FByoAJsA%3D&am
> > p;rese
> > > rved=3D0
> > > [5]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fp
> > >
> > atchwork.ozlabs.org%2Fproject%2Flinux-pci%2Fcover%2F1645760667-10510-
> > 1
> > >
> > -git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D04%7C01%7Chongxi
> > ng.
> > >
> > zhu%40nxp.com%7C19e85ae119bc47d3397e08da18d71007%7C686ea1d3bc
> > 2b4c6fa92
> > >
> > cd99c5c301635%7C0%7C1%7C637849609225124527%7CUnknown%7CTWF
> > pbGZsb3d8eyJ
> > >
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C3000
> > >
> > &amp;sdata=3DtRZQBUN4CleGFFbxqNn4W1kUwCgATERggfa8qEQyc9E%3D&am
> > p;reserved
> > > =3D0
> > >
> > > NOTE:
> > > Based git
> > > <git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git>
> > > Based branch <pci/imx6>
> > >
> > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   1 +
> > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   4 +-
> > > arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  55
> > ++++++++++++++++++++++
> > > arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46
> > ++++++++++++++++++-
> > > drivers/pci/controller/dwc/pci-imx6.c                        |  19
> > +++++++-
> > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 205
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > ++++-----------------
> > > drivers/reset/reset-imx7.c                                   |   1 +
> > > 7 files changed, 286 insertions(+), 45 deletions(-)
> > >
> > > [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST support
> > > [PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding [PATCH v2
> > > 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY [PATCH v2 4/7]
> > > dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible [PATCH v2 5/7]
> > > arm64: dts: imx8mp: add the iMX8MP PCIe support [PATCH v2 6/7] arm64:
> > > dts: imx8mp-evk: Add PCIe support [PATCH v2 7/7] PCI: imx6: Add the
> > > iMX8MP PCIe support
> > >
> >
> > Richard,
> >
> > Thanks for working on this!
> >
> > Do you plan on submitting another version soon? I've tried to test this=
 with an
> > imx8mp board I'm bringing up and while the host controller enumerates I=
 fail
> > to get a link to a device. It's very likely I am missing something as t=
his series
> > depends on the IMX8MP blk-ctrl and gpc series which I also can't cleanl=
y apply.
> > Lucas just submitted a 'consolidated i.MX8MP HSIO/MEDIA/HDMI blk-ctrl
> > series' [1] yet I can't find a repo/branch that applies to either.
> >

Richard,

I found that I had an issue with PERST# on my board which was causing
the link failure so I was able to get this series to work after
figuring out which patches were needed.

> > Perhaps you have a git repo somewhere I can look at while we wait for
> > imx8mp blk-ctl/gpc to settle and you to submit a v3?
> Hi Tim:
> Thanks for your kindly help to do the tests.
> I had listed the dependencies in the cover-letter log.
> Alexander and I used to test this series commits based on the V5.17 kerne=
l.
>
> Lucas had provided some review comments and suggestions about the PLL bit=
s
>  manipulations of HSIOMIX in i.MX8MP PCIe PHY driver #3 of this series.
> And he suggested to let the HSIOMIX blk-ctrl make this PLL as a real cloc=
k,
>  and used by i.MX8MP PCIe PHY driver later.
>
> Although I have some confusions, it's better let's wating for the blk-ctr=
l
> settle down and get clear discussion with Lucas later.
> How do you think about that?
>

Yes, I agree.

Please Cc me on your next submission and I can test with the
imx8mp-venice-gw74xx board which uses an external REFCLK and does not
support CLKREQ.

Best Regards,

Tim

> Best Regards
> Richard Zhu
> >
> > Best Regards,
> >
> > Tim
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chw
> > ork.kernel.org%2Fproject%2Flinux-arm-kernel%2Flist%2F%3Fseries%3D62958
> > 6&amp;data=3D04%7C01%7Chongxing.zhu%40nxp.com%7C19e85ae119bc47d3
> > 397e08da18d71007%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7
> > C637849609225124527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda
> > ta=3DSUCCWtnCtTSCONfSoixOPgpMO4dnsBTW20x9qRdw4Fw%3D&amp;reserve
> > d=3D0
