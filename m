Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3BC455FDD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhKRPxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 10:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232738AbhKRPxl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 10:53:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A9BD61B6F;
        Thu, 18 Nov 2021 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637250641;
        bh=elgJ2bP07VrCK8IonkaoD83tPBnzisTdxG/oaHiVdjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBMzxTZGTSwY4q0BCXXYyKSG4vvPw6PTE5MrpI3jE9QFZHOKYX1EldxXpiK5S3P2e
         ybzmYPCdGHfPAnOkHJi2T51glbVaF4JF4Ipd0rRXNBBDzY0E1jPIQaLATuTKBEfQfT
         hNPlQLp+KtmilUYDavNkssIEtjoECXSYPm+AIQAkF2/Zylpcd2OL5Fj2lNCfu9WIXO
         gNlaE5nIAZwQmzHwYSIItxEPcm0+cBqvjPbBfy1uQJJsxZ5mHP+ixg+lNq+JxmUp0r
         PAeqTEC2Unx9oKQ1XHTeSjjpilPCd8x1BLoQGeYFkq1dDrh3jz+hxSv8c57Hay9Pg7
         kq5f6mERG53zA==
Received: by pali.im (Postfix)
        id B2FB5799; Thu, 18 Nov 2021 16:50:38 +0100 (CET)
Date:   Thu, 18 Nov 2021 16:50:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev
 regulators
Message-ID: <20211118155038.3x4bwgubbnuxv3dy@pali>
References: <20211110221456.11977-1-jim2101024@gmail.com>
 <20211110221456.11977-6-jim2101024@gmail.com>
 <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
 <CA+-6iNxfrOQtH1JDEjAdSZQkENoaw1tUDTfVc5+G7P6BAbSc6g@mail.gmail.com>
 <CAL_JsqJno4ROQD38buz8Z-tU5aaQL5b_d1R0-D+c9UwnMKYNOw@mail.gmail.com>
 <20211116205337.ui5sjrsmkef4a53k@pali>
 <CA+-6iNxz2RSmJ9C1dfjEOPmuTxELPDiGzsWoL-8KkH8FGjN3nA@mail.gmail.com>
 <20211117154512.aelgnqhcnw3gqu5s@pali>
 <CA+-6iNwUORmdLy9ii748K4JfZQ8J-N48r-q7QO1P9XAZR2W2qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwUORmdLy9ii748K4JfZQ8J-N48r-q7QO1P9XAZR2W2qw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 November 2021 10:36:00 Jim Quinlan wrote:
> On Wed, Nov 17, 2021 at 10:45 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Wednesday 17 November 2021 10:14:19 Jim Quinlan wrote:
> > > On Tue, Nov 16, 2021 at 3:53 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > Yes, I was looking at it... main power (12V/3.3V) and AUX power (3.3V)
> > > > needs to be supplied at the "correct" time during establishing link
> > > > procedure. I wrote it in my RFC email:
> > > > https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
> > > Hello Pali,
> > >
> > > I really like your proposal although I would like to get my patchset
> > > first :-) :-)
> > >
> > > Suppose you came up with a patchset for your ideas-- would that include
> > > changes to existing RC drivers to use the proposed framework?  If so,
> > > I am wary that it would
> > > break at least a few of them.  Or would you just present the framework
> > > and allow the
> > > RC drivers' authors to opt-in, one by one?
> >
> > My idea is to add new "framework" to allow drivers implement new
> > callbacks for this "framework". There would be no change in drivers
> > which do not provide these callbacks to ensure that nothing is going to
> > be broken. I'm planning to implement these callbacks only for RC drivers
> > for which I have hardware and can properly test to not introduce any
> > regression. For other existing RC drivers it is up to other authors +
> > testers. But to decrease future maintenance cost of all RC drivers I
> > expect that new drivers would not implement any ad-hoc solution in their
> > "probe" function and instead implement these new callbacks. That is my
> > idea.
> >
> > > At any rate, if you want someone to test some of your ideas I can work
> > > with you.
> >
> > Perfect! If you have any concerns or you see any issues, please reply
> > that my RFC email. So I can collect feedback.
> >
> > Also I sent draft for updating DTS schema for PCIe devices:
> > https://github.com/devicetree-org/dt-schema/pull/64
> 
> Hi Pali,
> I don't see any mention or placement of the regulator nodes for power;

I put in above pull request draft only existing attributes (from
pci.txt), I have not introduce anything new yet.

> do you agree with where
> I proposed we place them, ie in the first bridge under the root-complex,  e.g.
> 
>             pcie0: pcie@7d500000 {                                /*
> root complex */
>                     compatible = "brcm,bcm2711-pcie";
>                     reg = <0x0 0x7d500000 0x9310>;
> 
>                     /* PCIe bridge */
>                     pci@0,0 {
>                             #address-cells = <3>;
>                             #size-cells = <2>;
>                             reg = <0x0 0x0 0x0 0x0 0x0>;
>                             compatible = "pciclass,0604";
>                             device_type = "pci";
>                             vpcie3v3-supply = <&vreg7>;     /*
> <------------- HERE  */

This node 'pci@0,0' describes PCIe Root Port. So yes, it is place where
power regulators belongs. I agree with you.

(Note: I would suggest to use /* PCIe Root Port */ comment instead of
/* PCIe bridge */. As PCIe bridge is ambiguous name which could mean
also other devices.)

>                             ranges;
> 
>                             pci-ep@0,0 {        /* PCIe endpoint */
>                                     assigned-addresses =
>                                         <0x82010000 0x0 0xf8000000 0x6
> 0x00000000 0x0 0x2000>;
>                                     reg = <0x0 0x0 0x0 0x0 0x0>;
>                                     compatible = "pci14e4,1688";
>                                     #address-cells = <3>;
>                                     #size-cells = <2>;
> 
>                                     ranges;
>                             };
>                     };
>             };
> 
> 
> Regards,
> Jim
