Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0CD3EB6C1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbhHMOdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240638AbhHMOdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 10:33:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 635FD60F36;
        Fri, 13 Aug 2021 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865191;
        bh=qvwL98T6cFe2Y5vJWvp7Ip3FI+1vuxrallktmBOzxPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtCOoTooXnFazv9toErMswqnyTuGT8vAb2T2Urk8jDe6T7wSPcMSSQr3ovy6y4CSU
         jBq6j5lgRZ+xyapnrUnlh8W50nwaUK8ut7dbjWXXFfAt5qXis/q+iZKvI1fwxAA+Ev
         k4y2S0/9ny9IcbOHP74G4fowSuazoOyLurcxK1Hoyu5iSvZ6AFQ15pd+ENXrnIep1Z
         IlN+95iGwpxivc76a6qlRIuxvYtqGvuXuqVc35S1TbfvnmAzF1mvRblRcu4WQLimap
         9VfzOB5EVVEtDg0LanY6kPGJJvHBVGef69qcgIjbM0LLaXdh3BLprPL327nCImuQhI
         JlMHieBQg7HoQ==
Date:   Fri, 13 Aug 2021 15:32:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference
 in probe
Message-ID: <20210813143250.GA5209@sirena.org.uk>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <20210813135412.GA7722@kadam>
 <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 03:01:10PM +0100, Robin Murphy wrote:

> Indeed I've thought before that it would be nice if regulators worked like
> GPIOs, where the absence of an optional one does give you NULL, and most of
> the API is also NULL-safe. Probably a pretty big job though...

It also encourages *really* bad practice with error handling, and in
general there are few use cases for optional regulators where there's
not some other actions that need to be taken in the case where the
supply isn't there (elimintating some operating points or features,
reconfiguring power internally and so on).  If we genuninely don't need
to do anything special one wonders why we're trying to turn the power on
in the first place.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWgpEACgkQJNaLcl1U
h9AFSAf+JfSBsijmhQEBvXaLJeAoZdPUWetw39rGAJkXJoXq1TDlPVwIyY6YsI7f
qhFuXZUU4IB1aUamDPTaGSznNZvr4qcwBWQWgERCbcaeGvVKsKs6KSBFhkWeRsJy
bjb2cBok90u+J+1M/nkshvcBs5CGy//o5dOoGkbpPDc8Q8uMjSIn/VaUi1YGezKn
ZMS+zy//JJg0Rnt2R5/z9ITFrczy6JoN/beCYqX+NQ4inOGIInr6Qh4zSduCrGFU
yUrKwixOg/6ziNCT9lCnCZfRSHiy2Vi3EwY6kw9A3ZGRy4/YC/DJq5xZr/POU0BH
Mn7sQqyXaDzxJ57fKC4yDTAJZ0b3cQ==
=hknS
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
