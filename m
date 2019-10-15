Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33AD7257
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfJOJa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 05:30:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17714 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfJOJa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 05:30:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da591d50001>; Tue, 15 Oct 2019 02:31:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2019 02:30:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Oct 2019 02:30:57 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 09:30:56 +0000
Received: from localhost (172.20.13.39) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct 2019 09:30:56
 +0000
Date:   Tue, 15 Oct 2019 11:30:53 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Sinan Kaya <okaya@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191015093053.GA5778@ulmo>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571131861; bh=8v8ugr2D5zllf/iqL4g8xZaW3g59ivDtGCtLnlcULhE=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=Iq99xBDIFhy1lHVs9sy0bbdIcZdIAFWEp5l6YEbjxj1r04uxYLlgE4riMngdk+YqI
         ueQmlksDr6NSWW1gDH4MDSuxUcvzIRBsN4NuhnKUhtImz5rp2Qpui2qKx+Zqs0cAR1
         LDvHsDfntlyvGQMm56EGbLAvuolMYxUM32Z7SUdLWCEP6qoTHRbL9cuFMoQNAeNeAS
         2ydqmudULrQODBROtkXA0ls3qdRyELUBixZNqmfcw7pZ+FAOeUvH0nlAJVNak//qUv
         SzfB+TLSH805Rs+i7WYfDR29kCpMv8Uzip0SVd/+NheCKBD8GJVu/B+ew2iYqZzCv0
         LAXIEZedEU7lA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 01:21:31PM -0700, Sinan Kaya wrote:
> On 10/14/2019 1:20 AM, Thierry Reding wrote:
> > I think this makes sense, so:
> >=20
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> >=20
> > However, it looks like Sinan has researched this extensively in the past
> > and gave a presentation on this at Plumbers in 2017:
> >=20
> > 	https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4732/=
original/crs.pdf
> >=20
> > Adding Sinan to see if he has any concerns about this, since resume time
> > is explicitly mentioned in the above slides.
>=20
>=20
> Thanks for including me. Let me catch up here.
>=20
> pci_dev_wait() is supposed to handle this case via pci_pm_reset().
>=20
> /**
>  * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
>  * @dev: Device to reset.
>  * @probe: If set, only check if the device can be reset this way.
>  */
>=20
> Do you know if your execution path hits this function? We might have
> missed a use case.
>=20

I see only a couple of callers of pci_device_is_present() in the tree,
this being from next-20191015:

	$ git grep -n pci_device_is_present
	drivers/net/ethernet/broadcom/tg3.c:9070:       if (!pci_device_is_present=
(tp->pdev))drivers/net/ethernet/broadcom/tg3.c:11785:      if (pci_device_i=
s_present(tp->pdev)) {
	drivers/net/ethernet/intel/igb/igb_main.c:8838: if (!pci_device_is_present=
(pdev))
	drivers/nvme/host/pci.c:2866:   if (!pci_device_is_present(pdev)) {
	drivers/pci/hotplug/acpiphp_glue.c:650:         alive =3D pci_device_is_pr=
esent(dev);
	drivers/pci/pci.c:935:      !pci_device_is_present(dev)) {
	drivers/pci/pci.c:5902:bool pci_device_is_present(struct pci_dev *pdev)
	drivers/pci/pci.c:5910:EXPORT_SYMBOL_GPL(pci_device_is_present);
	drivers/thunderbolt/nhi.c:939:  if (!pci_device_is_present(pdev)) {
	include/linux/pci.h:1206:bool pci_device_is_present(struct pci_dev *pdev);

The NVME driver has the call in the ->remove() callback, so I don't
think it's relevant here. Both TG3 and IGB ethernet drivers seem to call
this during resume and so does Thunderbolt.

Vidya, can you clarify for which device you're seeing the issues? Sounds
like adding a call to pci_pm_reset() (via pci_reset_function()) at some
point.

Sinan, it looks as if pci_pm_reset() (or any of its callers) is not used
very widely. Is that just because most drivers haven't had a need for it
yet? Or am I missing some core functionality that calls this for every
device anyway?

Thierry

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2lkcoACgkQ3SOs138+
s6Eauw//RZxfFJjo83n6r143u1Wa+4sn3tc3MT1b4nhEAtksz/UnBhzuVGQ96YTE
EpEStYMNlvw+PNevtc77dV+11D5mWSIp94cO5rYVAgsqJ0BeB7Dk/y90gnbglsWL
UJ1w0K0ny2amzlW/6VSsnFwCdrMi4ZU0FhdM2n0T3yvrWllHJ7eo9B+5aocHbB7u
xNtpzzHYYHr2mETQCmvFWBvLj54sEgFde0V7/U00ZCFFps1eL8qRxiOfRD3VcQUw
8qXqI2Mfxtpug9Z1MIELWGHqDNbDwtYUjbgyraYEmE1TKrMPSpdtyv9Atz2PVFwc
LOYJvEm/NFm7z2YcSZDYsc/7AUsfb0XfRd68ZQ4CIQ9y3TMSWStGB9KxRQV6sbJu
powtTS9ck8owdQxyw78WvzoQycR85dB//N2aLV3rBwswxGUtxUfs7b7P+nVDnrs9
/wTFKnAoQf0rhjxp8Pbahnn8KnISNLQbovj1x8eQ4454N3o0g0YsC029gj49jibD
7t6F9bDR6Xdq9WyJvIX07c1BXZMLgmpMCo87KYaQ0YZhIlIuKZ3PDLSHcOdX2RMC
zahhIVuTDR6S1/rcZGEgDiqd5hF41b031835dZ8QrBQ9ZBugZOb7zL1vRSSAmzHs
2foRqwA8ZautV8cg38FpwykJ8dJKTeDX658k2oVitcYdL+6Nh4A=
=pgKv
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
