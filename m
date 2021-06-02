Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFB3995AE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 23:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhFBWBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 18:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFBWBZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 18:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB9A613DA;
        Wed,  2 Jun 2021 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622671181;
        bh=bETJlYwL27WQfIWfeCtO150YT2blRYJ4wdMZmnk5xdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D77ZnOpi1/eM0jCOjylBDpSQVK4FmUj2dLe+dIDcOmk4OYF0O6jUQq5zrx+XsOBj9
         vOG1nBMdCZedHEa6JnncEZKv4yhNhrYxM6QMLDwyN5dNFmXTTZ6zAVycjAgrkub/TN
         HK/XsPwr/sHfsZLFhF1RMF8IDtpc9+As1PFAp4HAYCxQ1tgz18mGEmopftnPfrKpbc
         A4RVpS0O0tMoAZfBWwnVzBvESF6veZydiyh8Z0KurhIhrVCiU3fD9y7J4qPavp587B
         8XE6fyML3Yh+29EwfwtgoraKtxaWe4aoIxjYUjjHiAdqsFEe4mL/881+RAcSGR3ueA
         Q8t/xoGqVA1uQ==
Date:   Wed, 2 Jun 2021 23:59:36 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXT] Re: pci mvebu issue (memory controller)
Message-ID: <20210602235936.4dac5537@thinkpad>
In-Reply-To: <20210602211335.oe6r35ctkdtc52ic@pali>
References: <20210602203917.qmxi7tcjktg6jxva@pali>
        <20210602210101.GA2046447@bjorn-Precision-5520>
        <20210602211335.oe6r35ctkdtc52ic@pali>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2 Jun 2021 23:13:35 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> > If the NICs are ordinary PCIe endpoints there must be *something* to
> > terminate the other end of the link.  Maybe it has some sort of
> > non-standard programming interface, but from a PCIe topology point of
> > view, it's a root port.
> >=20
> > I don't think I can contribute anything to the stuff below.  It sounds
> > like there's some confusion about how to handle these root ports that
> > aren't exactly root ports.  That's really up to uboot and the mvebu
> > driver to figure out. =20
>=20
> Yes, I understand, it is non-standard and since beginning I'm also
> confused how this stuff work at all... And this is also reason why
> kernel emulates those root ports (via virtual PCIe bridge devices) to
> present "standard" topology.
>=20
> Remaining question is: should really kernel filter that "memory
> controller" device and do not show it in linux PCIe device hierarchy?
>=20

Bjorn,

this discussion has gone a little too complex.

The basic issue which Pali tries to solve can be recapitulated:
- there is a "memory controller" device on the "virtual" bus
- Linux' pci-mvebu driver hides this device
- we don't know what is the purpose of this device; it is visible even
  if there is no PCIe device connected
- Pali wants to know what is the purpose of this "memory controller"
  and whether this device should be hidden by Linux and U-Boot, as it
  currently is, or if the controller driver should expose this device

Marek
