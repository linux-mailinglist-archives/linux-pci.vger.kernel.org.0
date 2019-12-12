Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7931D11CF85
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 15:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfLLOQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 09:16:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43143 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfLLOQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2019 09:16:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so1683591qke.10;
        Thu, 12 Dec 2019 06:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GBGCKakEwAi+SxuWUfOkadj0n7loMWnfnQvA8ShRvQ=;
        b=syayC1RvNDxvD18+kTX/JNogom/aWz14yGuOHeDLj5KjomPtSd37PoGodtbiCvOpdE
         vGIaVlQeTXfMsf9yVKonxDTBX2DP2xlnGPfieK+nH8CDudRSroy1R7g3EVhDc/DfhJ24
         FzrwYjcvm7+7WFEo6oRj4dM8wmPiCC4wedPnKXsxCGCk7S4dIWZF0fodt1DxRPkW9T9l
         CZc/iztXwUpiJe86KApaizcy2cEnJa8T7CFnVOiAfJBtiTZXw8Iu5hXIB/fNwqN+qQEy
         k+VIRKMpPtu/KpcQrMOb3nzGuE9cgLSMypnGsqstWYmxBlvVj99j8AVObaopHS+/5ajL
         vQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GBGCKakEwAi+SxuWUfOkadj0n7loMWnfnQvA8ShRvQ=;
        b=FcD0waKJ0qi6DOPilTKmIu+/tqxHjYML2lY91lfg9L85xQxxBNJl2P/NS77UKlQ+4K
         5aGxI8GhYw6QOiNg0iFLVg7j6j2yz6ZsYVAlY49gRnmQTjlI2l+T9Txz2zPMbWoZbmt2
         GrX06NV/PED0j9b8kG2tTAup2UhVfpybhrOOrPcc3Mw27xhbOyHLSyci5oslL3HQL39U
         IRAiBlA/v50sTC5jvXcwd7EuWTtRXQ7o4g0U9699OkGYcUH1PPhupoIs/XSzi3JF711/
         r+IY9bx/akLy+es4ePxinZI5Tll7P2TcZoYobdl/nsbfpbF4MB1w4DraL43GPYzz8AuA
         aejQ==
X-Gm-Message-State: APjAAAW0l6bOAVpqBEi7rzT0dJxkVKxzKYmr0lfkuJpHDS/0BM3vHPy3
        KFmorYS0qxuNeNETQmIV/xpPRQRkDfbqxrWBgSg=
X-Google-Smtp-Source: APXvYqy3LZbmIJZqWEtZQRAxI8xuryqKsLm5wgMvxsNC8rWduFKgN8bZg4xqtDDT3Ra7L0z4cOoXyw9CsE4XvMKt3OQ=
X-Received: by 2002:a37:a642:: with SMTP id p63mr8470433qke.85.1576160197345;
 Thu, 12 Dec 2019 06:16:37 -0800 (PST)
MIME-Version: 1.0
References: <58ce5534-64bd-4b4b-bd60-ed4e0c71b20f@gmail.com>
 <166f0016-7061-be5c-660d-0499f74e8697@arm.com> <20191212005254.GE24359@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191212005254.GE24359@e119886-lin.cambridge.arm.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 12 Dec 2019 15:16:25 +0100
Message-ID: <CAFqH_50pJVQT3uqtpVgqn4ijfdPMzHoE1ns_KARH+_cKe+3NRg@mail.gmail.com>
Subject: Re: [REGRESSION] PCI v5.5-rc1 breaks google kevin
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vicente Bergas <vicencb@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vicente,

Missatge de Andrew Murray <andrew.murray@arm.com> del dia dj., 12 de
des. 2019 a les 1:53:
>
> On Thu, Dec 12, 2019 at 12:12:56AM +0000, Robin Murphy wrote:
> > Hi Vicente,
> >
> > On 2019-12-11 11:38 pm, Vicente Bergas wrote:
> > > Hi,
> > > since v5.5-rc1 the google kevin chromebook does not boot.
> > > Git bisect reports 5e0c21c75e8c PCI/ASPM: Remove pcie_aspm_enabled()
> > > unnecessary locking
> > > as the first bad commit.
> > >
> > > In order to revert it from v5.5-rc1 i had to also revert some dependencies:
> > > 5e0c21c75e8c08375a69710527e4a921b897cb7e
> > > aff5d0552da4055da3faa27ee4252e48bb1f5821
> > > 35efea32b26f9aacc99bf07e0d2cdfba2028b099
> > > 687aaf386aeb551130f31705ce40d1341047a936
> > > 72ea91afbfb08619696ccde610ee4d0d29cf4a1d
> > > 87e90283c94c76ee11d379ab5a0973382bbd0baf
> > > After reverting all of this, still no luck.
> > > So, either the results of git bisect are not to be trusted, or
> > > there are more bad commits.
> > >
> > > By "does not boot" i mean that the display fails to start and
> > > the display is the only output device, so debugging is quite difficult.
> >

Another issue that is affecting current mainline for kevin is fixed
with [1]. As usual, I have a tracking branch for 5.5 for different
Chromebooks with some not yet merged patches that makes things work
while are not fixed [2]. For kevin only the mentioned ASoC patch [1]
and the pcie fix [3] should be needed. Other than that display is
working for me on Kevin.

Cheers,
 Enric

[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.5&id=4bf2e385aa59c2fae5f880aa25cfd2b470109093
[2] https://gitlab.collabora.com/eballetbo/linux/commits/topic/chromeos/somewhat-stable-5.5
[3]  https://lkml.org/lkml/2019/12/11/199

> > Assuming it's a manifestation of the same PCI breakage that Enric and
> > Lorenzo figured out, there's a proposed fix here:
> > https://lkml.org/lkml/2019/12/11/199
>
> It's likely that any PCI driver that uses PCI IO with that controller will
> suffer the same fate.
>
> Vicente - can you try the patch that has been proposed and verify it fixes
> the issue for you?
>
> Thanks,
>
> Andrew Murray
>
> >
> > Robin.
> >
> > > v5.5-rc1 as is (reverting no commits at all) works fine when disabling PCI:
> > > # CONFIG_PCI is not set
> > >
> > > Regards,
> > >   Vicente.
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
