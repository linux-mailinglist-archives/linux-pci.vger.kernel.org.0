Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D583434D4BD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhC2QUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhC2QT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 12:19:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B86A961581;
        Mon, 29 Mar 2021 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617034799;
        bh=dGnCcl2HoA3NAkBzINwsXE0G5XK/4b9V3Ban3IDHg88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkLzbe3QDGc1oMRtw5aruwVpi0ycj9OCNunY6J0QBr2Fi89tQ5rXRo6/qIc9yhr4A
         TnsIqf7T1wqbC8GALzht716qBrUD2OnJcTQVwDcx9NsUMC6FC0dBpcmeN7j4hteSQD
         LBym5ykEJkdE5oQ+MqvHGCGFpg95zqSM2sV4uYVwBseyRBvnk+yrBVjPfCY1tki9ir
         rOlR53NOOSLz/5pnqlaZUcwEnIGeWXt9XCfEARQqX/7rL6k45NUhlKyB2m8bYTTVCz
         4jvuSIvfqYdU/vlhzd+83qmcwM+uqtd3c6/gLsOfBukBRd4cu+YH9/DPatU8KQ8nH5
         ky7No+8Au3lQA==
Date:   Mon, 29 Mar 2021 17:19:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
Message-ID: <20210329161948.GF5166@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <20210326191906.43567-3-jim2101024@gmail.com>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 26, 2021 at 03:19:00PM -0400, Jim Quinlan wrote:

> Control of EP regulators by the RC is needed because of the chicken-and-egg
> situation: although the regulator is "owned" by the EP and would be best
> handled on its driver, the EP cannot be discovered and probed unless its
> regulator is already turned on.

Ideally the driver core would have a way for buses to register devices
pre physical enumeration and give drivers a callback that could be used
to do whatever is needed to trigger enumeration, letting the bus then
match newly physically enumerated devices with the software enumerated
struct devices.  Soundwire has something in this area for a bus level
solution.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBh/iMACgkQJNaLcl1U
h9CvUQf/S+WYaVzUIqvnb0K6nY7Y7Tu7+dSYNItIsI9PpgGSQjVigAJvpvWuMQc1
0KS2Py/C77GDOsx0pEBX5hoLAU98BjvW+sjJTRCU2hjICoPtwEMrvVsmM7XzzFk1
rL1PXwJUgmlEzmknREWDe6VGAR5ddIke+9VdS5CBw2+d7HFviUb6bIyKBWPnm97+
El8J6IK37KCBy56NGGg3fqPwjFEZxy4oKyO7tklbqUi2qjweSsMR188Pw490LIYQ
54DjSMJY5ZoiLSkA+qJiB2vuCl7+Vtc6eQfsm4gio+rYxdYIduu685jrAfrYxopT
He2MtwZwq1ks96Kt7R/FFDtZm7xCRQ==
=0N2B
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
