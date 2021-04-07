Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FD356B2B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbhDGL1k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 07:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhDGL1k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 07:27:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1D266102A;
        Wed,  7 Apr 2021 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617794851;
        bh=Oc+4fiOadZVriRmtYF2X6D50TYJGSbWqaPmJNsL0qLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcZ+rPjZz3fSPP2eQqqw4sfVrloxYvRvcvxmPhw8cGgSVABR5U0zrDA6YdQO63iaR
         WC6RrIIcDA3iQ5ZGUO5F90z5ukGGtCUExsRfsH0Plbbe9/DUeaqV8+xope8ueDd84X
         712Y08fenbQ7hrGjDYBPgNMYOMkKrSL/qSbWNzr63qNSOTlyYV37PQfLM3aGoIIxxn
         t4PJA6lzDIb5zfnF63QX8J/B7ISDKgUQyTrr/70fjA+d5rVvEPYm8/E4mKDe19bbRA
         zudGmSuAJtbi/Zso1I0own9s8EtIG02uI6E6V6xz7hqQ3S6mKkLoNt1Hd7EG3y+aL4
         Qwr3KX6hkQYyQ==
Date:   Wed, 7 Apr 2021 12:27:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210407112713.GB5510@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
 <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 06, 2021 at 02:25:49PM -0400, Jim Quinlan wrote:

> I'm a little confused -- here is how I remember the chronology of the
> "DT bindings" commit reviews, please correct me if I'm wrong:

> o JimQ submitted a pullreq for using voltage regulators in the same
> style as the existing "rockport" PCIe driver.
> o After some deliberation, RobH preferred that the voltage regulators
> should go into the PCIe subnode device's DT node.
> o JimQ put the voltage regulators in the subnode device's DT node.
> o MarkB didn't like the fact that the code did a global search for the
> regulator since it could not provide the owning struct device* handle.
> o RobH relented, and said that if it is just two specific and standard
> voltage regulators, perhaps they can go in the parent DT node after
> all.
> o JimQ put the regulators back in the PCIe node.
> o MarkB now wants the regulators to go back into the child node again?

...having pointed out a couple of times now that there's no physical
requirement that the supplies be shared between slots never mind with
the controller.  Also note that as I've said depending on what the
actual requirements of the controller node are you might want to have
the regulators in both places, and further note that the driver does not
have to actively use everything in the binding document (although if
it's not using something that turns out to be a requirement it's likely
to run into hardware where that causes bugs at some point).

Frankly I'm not clear why you're trying to handle powering on PCI slots
in a specific driver, surely PCI devices are PCI devices regardless of
the controller?

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBtlxAACgkQJNaLcl1U
h9AVggf+KlMNZIoTcOq/oLb3wKm6+ONJs3mMv2sDmONFmlTeFHAMuy2gNTI9//f7
J7oWgDx/7VcL3Fn3ODnM+rBsCYXxWIi8oeryGPmn4Z7eF2RkPR3gfNYz5sCopQD8
jXlpB0wv+wwEuj2jmiFNnLUWDDA4U4mK4oo4Genm/9a9Rm0QN3e1lX0c8ku/Fg5Z
sc+2kh5IZr8da5JrJPoMTIKx2DgsESM/vOC0ZtnVsPDqTGLTa/NtPSp+gX9l2jif
4ff65/knyAyc4mhni/5vFBNkhmNpE7qpiOFZkelDDNRQIUp2vEtsezt1mrUsIFli
shZcnBD1K3uwGQhIrLwsSnesnX7SVQ==
=SqjM
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
