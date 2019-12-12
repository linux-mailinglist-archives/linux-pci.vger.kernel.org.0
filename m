Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00A11D7F7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 21:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfLLUja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 15:39:30 -0500
Received: from foss.arm.com ([217.140.110.172]:60094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfLLUja (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 15:39:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44702328;
        Thu, 12 Dec 2019 12:39:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 855263F718;
        Thu, 12 Dec 2019 12:39:28 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:39:27 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [REGRESSION] PCI v5.5-rc1 breaks google kevin
Message-ID: <20191212203925.GH24359@e119886-lin.cambridge.arm.com>
References: <58ce5534-64bd-4b4b-bd60-ed4e0c71b20f@gmail.com>
 <166f0016-7061-be5c-660d-0499f74e8697@arm.com>
 <20191212005254.GE24359@e119886-lin.cambridge.arm.com>
 <CAFqH_50pJVQT3uqtpVgqn4ijfdPMzHoE1ns_KARH+_cKe+3NRg@mail.gmail.com>
 <792cf6ab-26c4-40a4-90b0-a99e620548f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <792cf6ab-26c4-40a4-90b0-a99e620548f4@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 12, 2019 at 07:40:06PM +0100, Vicente Bergas wrote:
> On Thursday, December 12, 2019 3:16:25 PM CET, Enric Balletbo Serra wrote:
> > Hi Vicente,
> > 
> > Missatge de Andrew Murray <andrew.murray@arm.com> del dia dj., 12 de
> > des. 2019 a les 1:53:
> > > 
> > > On Thu, Dec 12, 2019 at 12:12:56AM +0000, Robin Murphy wrote:
> > > > Hi Vicente,
> > > > 
> > > > On 2019-12-11 11:38 pm, Vicente Bergas wrote:
> > > > > Hi,
> > > > > since v5.5-rc1 the google kevin chromebook does not boot.
> > > > > Git bisect reports 5e0c21c75e8c PCI/ASPM: Remove pcie_aspm_enabled()
> > > > > unnecessary locking
> > > > > as the first bad commit.
> > > > > 
> > > > > In order to revert it from v5.5-rc1 i had to also revert
> > > > > some dependencies:
> > > > > 5e0c21c75e8c08375a69710527e4a921b897cb7e
> > > > > aff5d0552da4055da3faa27ee4252e48bb1f5821
> > > > > 35efea32b26f9aacc99bf07e0d2cdfba2028b099
> > > > > 687aaf386aeb551130f31705ce40d1341047a936
> > > > > 72ea91afbfb08619696ccde610ee4d0d29cf4a1d
> > > > > 87e90283c94c76ee11d379ab5a0973382bbd0baf
> > > > > After reverting all of this, still no luck.
> > > > > So, either the results of git bisect are not to be trusted, or
> > > > > there are more bad commits.
> > > > > 
> > > > > By "does not boot" i mean that the display fails to start and
> > > > > the display is the only output device, so debugging is quite difficult.
> > > > 
> > 
> > Another issue that is affecting current mainline for kevin is fixed
> > with [1]. As usual, I have a tracking branch for 5.5 for different
> > Chromebooks with some not yet merged patches that makes things work
> > while are not fixed [2]. For kevin only the mentioned ASoC patch [1]
> > and the pcie fix [3] should be needed. Other than that display is
> > working for me on Kevin.
> > 
> > Cheers,
> >  Enric
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.5&id=4bf2e385aa59c2fae5f880aa25cfd2b470109093
> > [2] https://gitlab.collabora.com/eballetbo/linux/commits/topic/chromeos/somewhat-stable-5.5
> > [3]  https://lkml.org/lkml/2019/12/11/199
> > 
> > > > Assuming it's a manifestation of the same PCI breakage that Enric and
> > > > Lorenzo figured out, there's a proposed fix here:
> > > > https://lkml.org/lkml/2019/12/11/199
> > > 
> > > It's likely that any PCI driver that uses PCI IO with that controller will
> > > suffer the same fate.
> > > 
> > > Vicente - can you try the patch that has been proposed and verify it fixes
> > > the issue for you?
> > > 
> > > Thanks,
> > > 
> > > Andrew Murray
> > > 
> > > > 
> > > > Robin.
> > > > 
> > > > > v5.5-rc1 as is (reverting no commits at all) works fine when
> > > > > disabling PCI:
> > > > > # CONFIG_PCI is not set
> > > > > 
> > > > > Regards,
> > > > >   Vicente.
> 
> Hi Robin, Andrew and Enric,
> thank you all for the quick responses!
> I can confirm that patch [3] fixes the issue reported in this email and
> that [1] fixes the other issue reported on the other email.

Pleased to hear this is working for you now.

Are you happy to give a tested-by tag for [3]?

Thanks,

Andrew Murray

> 
> Regards,
>  Vicenç.
> 
