Return-Path: <linux-pci+bounces-21319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0111A3331E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C3167897
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF2204582;
	Wed, 12 Feb 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Zp/7ORf3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YISDnGxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F11FFC62;
	Wed, 12 Feb 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401335; cv=none; b=Ho9xu/YLNeHfOqY/QHaC8Xo1D8u9m794hPsxG2YB2DlEYx0EzGpeJmPE2BUYR14gNXju9uHv6IherBOBWyCtbcGT8g2yq/BbYzgpgUXkPmQ5d0uOElFRaHQoxtxK5wem5G1Rk4mHs+ewVYIzBQtTn05WWgPw36g1NResLqO0vPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401335; c=relaxed/simple;
	bh=gYV5pNsaziPaRqczJjIyZmNtqifrQLWyFt7m14ynusQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4tW1BZC81I20mcyQWI6CwLc55cXuR8KSQFK3Hb4NqxG6KJbxhbfvDMjpRbGief6p/lbh3f3XwfLXEGw7u9hVbA7YtjSmvt4PblGCBd77gF2JCmrRdzZaawJ58+5DMNy17h1/z7da6RKiWNG89vqagAiE02cRWC3eoDu709QGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Zp/7ORf3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YISDnGxA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 990201140145;
	Wed, 12 Feb 2025 18:02:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Feb 2025 18:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739401332;
	 x=1739487732; bh=mSLUyvLxPqNC6IhIvsE0Cg1/kRtqYX/vKSqEHTV46K4=; b=
	Zp/7ORf31ua3T8ozk53VvAE29KuJJ5eZ3sSXp5kYEpoOvCSvRpd8nTMQCdZzR+37
	1YcHqHYR9PgMLhtCWBjAXwb7xsBZjle55mSGMfn+ZvUkxEMyI6vrvS99RNjjHExn
	skZzWBqFo9OKn1PFQ3vnPeMkKqXOF3I1U9NMEUDp/nhn3bojYAvtO1opTa1aCVMh
	Nn4/lhKK2WttYgaUbZPIl4luNOEy32hbzh7TmgSe8Pdt4XxSxPQLPLn/aQ7lzoWL
	aRbzFt2TA9DmCiSmPJznG5VZIndqUGPpNkrkhDVFi9zrgLHDBKM+3moKSMH1yC0c
	EJZPG3joj63hJQUUT8f/0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739401332; x=1739487732; bh=mSLUyvLxPqNC6IhIvsE0Cg1/kRtqYX/vKSq
	EHTV46K4=; b=YISDnGxA6WgUsrDzv1DAWej34JZ2R4swhetv/bQc+CR+M+hsonW
	2Mw04/1FvzkkZRL0gMavpoO11ADWKV6Gg2x1LcqseW3PeCp/yP1+HW7PUUfzQwna
	JKe2DpYJfl6cwKVnblcAq1aCN4SG6RHBn4NmWSGrBTSUU0NTCg+NB8aYIginR5vT
	IoKQQn18e4pv4zlxdGckoJBNpelzEOxx6ivW5WUfkZj6yvHgHoXvUJSSN+wZW6Um
	lVfixNqsZskRyn9UlzVlMh3QyMf58yximQKhXORxYxAq+Nu+dPyKhr3+H64W1kFw
	VQ3Gmahof5DDdXLwg1BxoEmXKH89xL5ehhg==
X-ME-Sender: <xms:cyitZ6wS1hpg0C1Npkn878Wf3m-fqJlboVy7Uw6ilwLZ6-Ogk1l3mA>
    <xme:cyitZ2SXcmjmITPa0Ymzq3OOLo39-1BwphaXDAUIXeQDjvLUGgcDHK8Rqy0SwHkGY
    taHLrUECFkPWA>
X-ME-Received: <xmr:cyitZ8WlXqy_muD-XnlTi65J6j-BCVjj4aMRfAT6AIMWqioGBSZFvOCBZuqU4iczG27zm0vTxfwwWosQY-QkBqut5onqRG7nmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdej
    necuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoe
    hmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucgg
    tffrrghtthgvrhhnpedvieegfefgieejuedutefhffehjeegjeevuedtgeduteeujeetve
    evudevieffkeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    hrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvlhhgrggrsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjghhrohhsshesshhushgvrdgtohhmpdhrtg
    hpthhtoheprhhoghgvrhdrphgruhestghithhrihigrdgtohhmpdhrtghpthhtohepsgho
    rhhishdrohhsthhrohhvshhkhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhgsug
    esnhgsugdrnhgrmhgvpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihuggvrhdrlhgvvgesmhgvughirghtvghkrdgtohhmpdhrtghpth
    htohepjhgsvghulhhitghhsehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:cyitZwj_ulnQQWj3jqX3PgiaV3jPPywaT3HTNdN_usKHkYWLzwOAdw>
    <xmx:cyitZ8CKY30ytdi5u-GqB1eYGB12mdKwr9xTbQ5HmozN3831jugz0A>
    <xmx:cyitZxIw8bv7d9umQh_YBnCxTh99Q_K9YuNVTr4CD1oThJniT1CngQ>
    <xmx:cyitZzA1FxaRpfG3lQak1LP_aux0L17ko49CMLlz9p0em-a9P7alKg>
    <xmx:dCitZzDY7Je-Lz3fKhkwosJBe71lFQdr60-SS_ul3VTP4YVlfKZUw3uh>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 18:02:08 -0500 (EST)
Date: Thu, 13 Feb 2025 00:02:06 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, Jan Beulich <jbeulich@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Deren Wu <Deren.Wu@mediatek.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Shayne Chen <Shayne.Chen@mediatek.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Avoid FLR for Mediatek MT7922 WiFi
Message-ID: <Z60obmDgwk0VZ75A@mail-itl>
References: <20250212193516.88741-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0tz+zSavbvKwuCEI"
Content-Disposition: inline
In-Reply-To: <20250212193516.88741-1-helgaas@kernel.org>


--0tz+zSavbvKwuCEI
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Feb 2025 00:02:06 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, Jan Beulich <jbeulich@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Deren Wu <Deren.Wu@mediatek.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Shayne Chen <Shayne.Chen@mediatek.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Avoid FLR for Mediatek MT7922 WiFi

On Wed, Feb 12, 2025 at 01:35:16PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> The Mediatek MT7922 WiFi device advertises FLR support, but it apparently
> does not work, and all subsequent config reads return ~0:
>=20
>   pci 0000:01:00.0: [14c3:0616] type 00 class 0x028000 PCIe Endpoint
>   pciback 0000:01:00.0: not ready 65535ms after FLR; giving up
>=20
> After an FLR, pci_dev_wait() waits for the device to become ready.  Prior
> to d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS"),
> it polls PCI_COMMAND until it is something other that PCI_POSSIBLE_ERROR
> (~0).  If it times out, pci_dev_wait() returns -ENOTTY and
> __pci_reset_function_locked() tries the next available reset method.
> Typically this is Secondary Bus Reset, which does work, so the MT7922 is
> eventually usable.
>=20
> After d591f6804e7e, if Configuration Request Retry Status Software
> Visibility (RRS SV) is enabled, pci_dev_wait() polls PCI_VENDOR_ID until =
it
> is something other than the special 0x0001 Vendor ID that indicates a
> completion with RRS status.
>=20
> When RRS SV is enabled, reads of PCI_VENDOR_ID should return either 0x000=
1,
> i.e., the config read was completed with RRS, or a valid Vendor ID.  On t=
he
> MT7922, it seems that all config reads after FLR return ~0 indefinitely.
> When pci_dev_wait() reads PCI_VENDOR_ID and gets 0xffff, it assumes that's
> a valid Vendor ID and the device is now ready, so it returns with success.
>=20
> After pci_dev_wait() returns success, we restore config space and continu=
e.
> Since the MT7922 is not actually ready after the FLR, the restore fails a=
nd
> the device is unusable.
>=20
> We considered changing pci_dev_wait() to continue polling if a
> PCI_VENDOR_ID read returns either 0x0001 or 0xffff.  This "works" as it d=
id
> before d591f6804e7e, although we have to wait for the timeout and then fa=
ll
> back to SBR.  But it doesn't work for SR-IOV VFs, which *always* return
> 0xffff as the Vendor ID.
>=20
> Mark Mediatek MT7922 WiFi devices to avoid the use of FLR completely.  Th=
is
> will cause fallback to another reset method, such as SBR.
>=20
> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration R=
RS")
> Link: https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-25=
82927149
> Link: https://lore.kernel.org/r/Z4pHll_6GX7OUBzQ@mail-itl
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

It works, thanks!

Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>

> ---
>  drivers/pci/quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b84ff7bade82..82b21e34c545 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5522,7 +5522,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,=
 quirk_intel_qat_vf_cap);
>   * AMD Matisse USB 3.0 Host Controller 0x149c
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
> - *
> + * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {
> @@ -5534,6 +5534,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, =
quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> =20
>  /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
>  static void quirk_no_flr_snet(struct pci_dev *dev)
> --=20
> 2.34.1
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--0tz+zSavbvKwuCEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmetKG4ACgkQ24/THMrX
1yxrrQf8DcaaeLNDT4iNQ62TsecJBfBfwazR8kITzW+Ljwe2R5+WlZlSB58A/yN3
MAO8oyedNHISFcJ2YiqrGW/kFPGf3ns7PFfohV6DBYyNTjoj1UNywkWZ0zxXuaxH
YnNLoNJeOZEVW86+MOgJZ67MaQqGbuuv2juS7SPVwteezRykssZLvepfPIonJiNt
vK4WylRTvPH+Kkkf5Ys744gDdSd4virRagaIxrytlbF3BV6n1o5UTuuaYwRfJ/kj
J+jAHvmFBHD2zEa1qCodVG/2GS1BuRD9TZ/dGHLUGH+vTikCUttyplbXpuhwgAoR
Lb6nsNLNMm4iXqwgyfTw306hP01rVQ==
=EIdg
-----END PGP SIGNATURE-----

--0tz+zSavbvKwuCEI--

