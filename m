Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020F832D975
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 19:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhCDSaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 13:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234603AbhCDS3u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 13:29:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5489A64F60;
        Thu,  4 Mar 2021 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614882549;
        bh=9e6Mgs7GsNfUWeTNex9JV65Iiwbpw8eLNnrDFxGu+Jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uxmlN0sKvvVsRP3Igs5AFUIsSb5yAvfKIaecPYTqkQH21ZmHSUCDfdE3YQMvX4Hv7
         zpJL1kpzhNMjzZRAmus8GtWbdnEG+ahUtHG/NiSpMq7IC00VAlXrzXV/oKampIOBS8
         Wz6BAWFbguF5b/CK1XCYxjytjdt2BjmYFmfhrhd2gbtiBaQTdJZQubyuXznKtBnQgw
         ShAQRft0XTzhKuYd+PAyfx1GE3Ybsskt9uRkHe7DvbvZSDXiWJdgoklbCPVvw+D2NT
         qnE+svTrdPzrk049w8IUlKF/8A+TbqEOB4ZtZnKcLyxcwuyRAKHKlvb81V7nkC3m7k
         Xj7AK9gPjexMA==
Date:   Thu, 4 Mar 2021 12:29:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXT] Re: pci mvebu issue (memory controller)
Message-ID: <20210304182908.GA858065@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219174406.2kioa4ikeippgwou@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 19, 2021 at 06:44:06PM +0100, Pali Rohár wrote:
> On Wednesday 10 February 2021 13:59:41 Stefan Chulski wrote:
> > > > (sending this e-mail again because previously I sent it to Thomas' old
> > > > e-mail address at free-electrons)
> > > 
> > > Thanks. Turns out I still receive e-mail sent to @free-electrons.com, so I had
> > > seen your previous e-mail but didn't had the chance to reply.
> > > 
> > > > we have enountered an issue with pci-mvebu driver and would like your
> > > > opinion, since you are the author of commit
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pu
> > > > b_scm_linux_kernel_git_torvalds_linux.git_commit_-3Fid-
> > > 3Df4ac99011e542
> > > >
> > > d06ea2bda10063502583c6d7991&d=DwIFaQ&c=nKjWec2b6R0mOyPaz7xtfQ&
> > > r=DDQ3dK
> > > > wkTIxKAl6_Bs7GMx4zhJArrXKN2mDMOXGh7lg&m=lENmudbu2hlK44mVm-
> > > e8bgdi9Rm2AC
> > > > DXN8QY0frgcuY&s=7109I-
> > > xvpx1wW532pxvk1W8s_XeG77VQf2iP7QzhEao&e=
> > > >
> > > > After upgrading to new version of U-Boot on a Armada XP / 38x device,
> > > > some WiFi cards stopped working in kernel. Ath10k driver, for example,
> > > > could not load firmware into the card.
> > > >
> > > > We discovered that the issue is caused by U-Boot:
> > > > - when U-Boot's pci_mvebu driver was converted to driver model API,
> > > >   U-Boot started to configure PCIe registers not only for the newtork
> > > >   adapter, but also for the Marvell Memory Controller (that you are
> > > >   mentioning in your commit).
> > > > - Since pci-mvebu driver in Linux is ignoring the Marvell Memory
> > > >   Controller device, and U-Boot configures its registers (BARs and what
> > > >   not), after kernel boots, the registers of this device are
> > > >   incompatible with kernel, or something, and this causes problems for
> > > >   the real PCIe device.
> > > > - Stefan Roese has temporarily solved this issue with U-Boot commit
> > > >   https://urldefense.proofpoint.com/v2/url?u=https-
> > > 3A__gitlab.denx.de_u-2Dboot_custodians_u-2Dboot-2Dmarvell_-
> > > 2D_commit_6a2fa284aee2981be2c7661b3757ce112de8d528&d=DwIFaQ&c=n
> > > KjWec2b6R0mOyPaz7xtfQ&r=DDQ3dKwkTIxKAl6_Bs7GMx4zhJArrXKN2mDM
> > > OXGh7lg&m=lENmudbu2hlK44mVm-
> > > e8bgdi9Rm2ACDXN8QY0frgcuY&s=B0eKBkblEygPGYvKDdMuwzzYhDg5Jlh_Q4
> > > eXHlIL-oc&e=
> > > >   which basically just masks the Memory Controller's existence.
> > > >
> > > > - in Linux commit f4ac99011e54 ("pci: mvebu: no longer fake the slot
> > > >   location of downstream devices") you mention that:
> > > >
> > > >    * On slot 0, a "Marvell Memory controller", identical on all PCIe
> > > >      interfaces, and which isn't useful when the Marvell SoC is the PCIe
> > > >      root complex (i.e, the normal case when we run Linux on the Marvell
> > > >      SoC).
> > > >
> > > > What we are wondering is:
> > > > - what does the Marvell Memory controller really do? Can it be used to
> > > >   configure something? It clearly does something, because if it is
> > > >   configured in U-Boot somehow but not in kernel, problems can occur.
> > > > - is the best solution really just to ignore this device?
> > > > - should U-Boot also start doing what commit f4ac99011e54 does? I.e.
> > > >   to make sure that the real device is in slot 0, and Marvell Memory
> > > >   Controller in slot 1.
> > > > - why is Linux ignoring this device? It isn't even listed in lspci
> > > >   output.
> > > 
> > > To be honest, I don't have much details about what this device does, and my
> > > memory is unclear on whether I really ever had any details. I vaguely
> > > remember that this is a device that made sense when the Marvell PCIe
> > > controller is used as an endpoint, and in such a situation this device also the
> > > root complex to "see" the physical memory of the Marvell SoC. And
> > > therefore in a situation where the Marvell PCIe controller is the root
> > > complex, seeing this device didn't make sense.
> > > 
> > > In addition, I /think/ it was causing problems with the MBus windows
> > > allocation. Indeed, if this device is visible, then we will try to allocate MBus
> > > windows for its different BARs, and those windows are in limited number.
> > > 
> > > I know this isn't a very helpful answer, but the documentation on this is
> > > pretty much nonexistent, and I don't remember ever having very solid and
> > > convincing answers.
> > > 
> > > I've added in Cc Stefan Chulski, from Marvell, who has recently posted
> > > patches on the PPv2 driver. I don't know if he will have details about PCIe,
> > > but perhaps he will be able to ask internally at Marvell.
> > > 
> > > Best regards,
> > 
> > I not familiar with Armada XP PCIe. But I can check internally at Marvell.
> > 
> > Best Regards,
> > Stefan.
> > 
> 
> Stefan: If you get any information internally in Marvell, please let us know!
> 
> Bjorn: What do you think, should Linux kernel completely hide some PCIe
> devices from /sys hierarchy and also from 'lspci' output? Or should
> kernel preserve even non-functional / unknown PCIe devices visible in
> 'lspci' output?

In general I don't think the kernel should hide PCI devices.  The PCI
core has no way of knowing whether devices are non-functional, and
"unknown" doesn't really mean anything because a driver could be
loaded later.

But if a device is in use by firmware, or if exposing it causes some
problem, it might make sense to hide it.

In your case, the problem description is "... the registers of this
device are incompatible with kernel, or something, and this causes
problems for the real PCIe device ..."

That's not much to go on.  Someone with more knowledge of the actual
problem would have to weigh in on whether hiding a device is the best
approach.

With more details we might see what the conflict between the devices
is.  E.g., maybe we assign the same resources to both, or maybe we
don't assign a bridge window to reach the WiFi card.

Bjorn
