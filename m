Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9502C4721
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgKYR5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 12:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgKYR5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 12:57:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BAC0613D4;
        Wed, 25 Nov 2020 09:57:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so2758638wrb.9;
        Wed, 25 Nov 2020 09:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q76sCAQCkbjrxEHa/bTijZbpnPeUzggOKoo+w3D3/HM=;
        b=n5OYgJGV8H6PWOguZUEL23o87v2w0KJvjoG+jc6amL3kRcDtzk7+LbgjCFg1o/F6fk
         HoDsjw3QlIZgPqSgRLIFMZT/fZj2ZeZ1kHmrCDJZaBzMyVQs1oceX+nE2qOE0BFGlDlJ
         SEm/EbxKf+NwYil3vkaegA6yob0vnH5DHRgr9SCKvYyKPZ9bPE2BVb7PeeZgRgxxumY1
         ++cVG5nhbtkE8Ci9uDNH8Zi/cqUgQ3/0/RnWc5uLtWLK8SAYbrRiZVSQp1jcixmYqYZ6
         xSRqJAcQDdLWUVn6mOcCJ9+DIJ10ntsKBLGvvJxS09K/w5L8wfp5YKg0/KnBkoM1tyUB
         W0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q76sCAQCkbjrxEHa/bTijZbpnPeUzggOKoo+w3D3/HM=;
        b=h5iPK+T6s7Kh3jFMnxzfrBNDRYAfHELhj0QPbvBcWgdsghabnnlTbXMXz0itdClU74
         C7VD1ihAIjkO31f5SBmeuiuY9kKm+zwnHVPg8Mk9x9u0XaS1zB+ur8B1TxG+c9fXLrN6
         5MSM75meptcBwrePjIEG5tQ0oKPKqEAWDmsKmgY848s1tF93pPOM8hRT/gxeVE6E8nl5
         ahCFyIuB89MxK8fdXHsDFhEoYGegLuA1kAPPrGNBYq9gpj2Br9ty1Vrk1oNGVGHOFFr2
         nNsXLlvWa5KYEVvMZR6H8djI/dThoLBV8sZ9BlV/DHlB6hIsYciFSzxfiuhJuse6wQqk
         e6OQ==
X-Gm-Message-State: AOAM531VoTxKj9yERQ9vm9ddGimQFjH67yAYweQaQKZfCJQXsL/j9pma
        w8ByiDDIiobjXnjsk9dwKZ4=
X-Google-Smtp-Source: ABdhPJwa7NIE+RcUsUdPvZObLxpIFG/9Y9a3ASL99KFq/0C/ef7BT+f2k2yWIftSiz0/aTmv6RRD9A==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr5468292wrs.178.1606327032727;
        Wed, 25 Nov 2020 09:57:12 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 6sm7363753wrn.72.2020.11.25.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:57:11 -0800 (PST)
Date:   Wed, 25 Nov 2020 18:57:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/6] Enhancements to Tegra194 PCIe driver
Message-ID: <20201125175709.GA1274379@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-1-vidyas@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:31PM +0530, Vidya Sagar wrote:
> This series of patches do some enhancements and some bug fixes to the
> Tegra194 PCIe platform driver like
> - Fix Vendor-ID corruption
> - Map DBI space correctly
> - Update DWC IP version
> - Continue with uninitialization sequence even if parts fail
> - Check return value of tegra_pcie_init_controller()
>=20
> V4:
> * Added a new patch to address link-up issues with some of the cards
>=20
> V3:
> * Addressed Bjorn's review comments
> * Split earlier patch-4 into two
>   - Continue with the uninitialization sequence even if some parts fail
>   - Check return value of tegra_pcie_init_controller() and exit according=
ly
>=20
> V2:
> * Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'
>=20
> Vidya Sagar (6):
>   PCI: tegra: Fix ASPM-L1SS advertisement disable code
>   PCI: tegra: Map configuration space as nGnRnE
>   PCI: tegra: Set DesignWare IP version
>   PCI: tegra: Continue unconfig sequence even if parts fail
>   PCI: tegra: Check return value of tegra_pcie_init_controller()
>   PCI: tegra: Disable LTSSM during L2 entry
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 78 +++++++++++-----------
>  1 file changed, 39 insertions(+), 39 deletions(-)

I was going to test this series, but then I noticed that PCI is causing
a crash on linux-next (as of fairly recently). So I tried applying this
on top of v5.10-rc1, but that gives me the following:

	[    3.595161] ahci 0001:01:00.0: version 3.0
	[    3.595726] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
	[    4.609923] ahci 0001:01:00.0: controller reset failed (0xffffffff)
	[    4.610343] ahci: probe of 0001:01:00.0 failed with error -5

So the device enumerates fine, but it's not able to reset the SATA
controller. That said, this seems to happen regardless of this patch
series, so plain v5.10-rc1 also shows the above.

Given the above, I think we should hold off on applying this series
until we've fixed PCI on linux-next and made sure that SATA also works
properly, otherwise we don't have a known good baseline to test this
against.

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl++mvIACgkQ3SOs138+
s6EVyA//ZYXqrHEduwNS64esp1K3n48t+o8TCFlc26DLQCic8L/f8Ee8RbhoEbBn
lOliWwSmJZQYKU23LH061nTmJu/cWfoGOAPaWLegGwd+fKo+EZgw9IA0ofbWBYDd
Mbty8mDQ4+SXw/QwatP3LES9riqBqNoeJAQ7ZaT1HpdK1DNR75kHMs5DZnayLO55
re/aTEX5kV+qIW/+E5PKAwoU27r/3kf+GwuKkSHGjIWtOUhYCqmLWolCpielF1Br
2TelZqoQz+BBVAHmW9Z1ecdOfPtUZuubx0pGcboW7uNUEi5P++a2TZg7WiMPYjX6
WJboe62zo12+46le9alchetsgfN4Nlo5VuOlM/EqCJ7+wCcsifFoTIK+EvuNLX2a
nd6TlJPLFsdzv4jFoRfgdRiBASjMFTXSmBqSYFd741jF5XZaIkL8dVWVN92k7BZf
b7BZAkDP+qiCizwsBQF0klJb/qzeZS4IYn5zEZj25mQ+mgqEDy85bk2puvlPqeXM
l+Koqd4YpqPo53HFxGUdF4nSVlfjDzIfVEyordGskZcB/a8KXaJdCGEcRngRPGqQ
h176Hzgo+uG8YGod4bwkQE992XEhkSl8oB/nvXCatFRq/inZOjP1Ni5juGfyhsTI
USuJLwSc75rq8zX0vHdr2ZrazFx0i3nVxLF370nxBFoBFUs/okU=
=ddHn
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
