Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E3375C84
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEFVCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 17:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhEFVCR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 17:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF21A610FA;
        Thu,  6 May 2021 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620334879;
        bh=atn5UYpmCJPmVfaNd52jeRUD1ASymmELvozqzIkybIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=siGw+V7Mt/rehpoCL1CGoEe1xmiwIlC92fKqPBmkEbyQtcYNGQIoGuxVv8JfnEZNa
         6a63xSXpc200o/fAWj2Q3DAwBntrdNJthxagLcspGNNl8mhiAsm688+pf5KVWOY7QW
         3j+XdC15qrY81fnibpnr08hhmvj3TBfqr3k8h+EdJmfsOPzTwKACwJqaly0YI3Cnd6
         Qvn+wnca3Ed5WvXBQh+7NVPfXJ6ywSh1YNofXR7XVXWFhKIUY+fKY3RnP9iWZKdVV/
         /zbKJaBg/MdzGML99Nh1Yd1DhR+hTsES5UTfcI6SOIBPr5253j8wVG4lcRoXR6P7Jz
         a2KzfWWwKc+5g==
Date:   Thu, 6 May 2021 16:01:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch
Subject: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator used
 to power up pcie phy
Message-ID: <20210506210117.GA1433800@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7900502879b346e18727f956965ace34a146c0f1.camel@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 06:08:24PM +0200, Lucas Stach wrote:
> Hi Lorenzo,
> 
> have those two patches fallen through some crack? AFAICS they are gone
> from patchwork, but I also can't find them in any branch in the usual
> git repos.

They were marked "accepted" in patchwork but must have fallen through
the cracks.  I reset them to "new" and assigned to Lorenzo.

Neither one follows the subject line capitalization conventions.

The subject line of this patch (1/2) doesn't really make sense.  I
*think* this adds a property ("vph-supply") to indicate which
regulator supplys power to the PHY.

> Am Dienstag, dem 30.03.2021 um 16:08 +0800 schrieb Richard Zhu:
> > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> > sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> > the VREG_BYPASS bits of GPR registers should be cleared from default
> > value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> > turned on.

This commit log doesn't describe the patch, either.  Maybe something
like this:

  dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage

  The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
  Add a "vph-supply" property to indicate which regulator supplies
  power for the PHY.

> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index de4b2baf91e8..d8971ab99274 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -38,6 +38,9 @@ Optional properties:
> >    The regulator will be enabled when initializing the PCIe host and
> >    disabled either as part of the init process or when shutting down the
> >    host.
> > +- vph-supply: Should specify the regulator in charge of VPH one of the three
> > +  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
> > +  supplies.

Just going by examples for other drivers, I think this should say
something like this:

  - vph-supply: Regulator for i.MX8MQ PCIe PHY.  May supply either
    1.8V or 3.3V.

You mentioned "one of the three PCIe PHY powers"; I don't know what
that means, so I don't know whether it's important to include.

I also don't know what "vph" means; if the "ph" is part of "phy", it'd
be nicer to include the "y", so it would be "vphy-supply".

> >  Additional required properties for imx6sx-pcie:
> >  - clock names: Must include the following additional entries:
