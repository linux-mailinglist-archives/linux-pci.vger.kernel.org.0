Return-Path: <linux-pci+bounces-30750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC9AE9D3D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9626417A148
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCC72635;
	Thu, 26 Jun 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5LNn1Lj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEE1CFBA
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939751; cv=none; b=EmgzcQlHY1J4+VvkmtubPyxk9RqFdMnQk1kFTndpC9AMCfdkN0x/e+8+F3VmyxflaiOQJxvs2pBcCROJHYflLRicQv7rrt5ILYONeYuwjPtFlWLjlDk58tg/hKyWbgAMV1MWs4FtGxOiiqBzCjR5iIPSJa7yvO5VkNmUG4u7d6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939751; c=relaxed/simple;
	bh=UfWI6LO5sEsO66kan/GP+RgUFiIUmaG14RS+lcp3/wg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=csXiMO3FZGzOYu48aXJrd251+WpH4lq9mVPAwKn7YNM7tQCOPIHCNg3+ZYcCOGFNmJa7KajyiirLJCC988HFpSXxHb02N0Ht/7eUMc6KXIAv7zhkZkXiqx+9STIpHbvh/N1fwOFbV4Unui4lJfs/d73nsaleibOo3kG/qdhDylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5LNn1Lj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750939751; x=1782475751;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UfWI6LO5sEsO66kan/GP+RgUFiIUmaG14RS+lcp3/wg=;
  b=c5LNn1LjcEeN3879n1EojHDAl/9VWh0XnDHkbiOFlpOF8QSbjMolsDh8
   QU3vX4QNpLJWx+AUVCbcJgXfAj6a/1zgMUUrNZ7+e3RnST/tbAlSwhLno
   y9Jc89AnfAKKBzcwM8aViz137CftSDQOwBA+/8Kprn5IfhZMVXZZSTfja
   t72Elv9SNaHESYHukwcHmv0FTcSLjgo3UGvYDrYy5ErHofAXmxZ1ZvkWg
   CZEYH1w0x6/6/Etd5x8KIBtznSTbzVNbQHaZtGsEW6XDPvCQQlJQmRrHG
   /pWGewyQXpOU7w6P7RCFMTp1EoJU6057ElsNTnowVmmNO592qu46iyDNL
   Q==;
X-CSE-ConnectionGUID: ii3gXa38QWKwht12KMSIgw==
X-CSE-MsgGUID: fVCptgDXSs+scgB4vbEujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="57039806"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="57039806"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 05:09:10 -0700
X-CSE-ConnectionGUID: 6ZnMNixyRgyS6DAQ/D7b6A==
X-CSE-MsgGUID: bZ87JF4nTG6CYtVZbLHwZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="183390423"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 05:09:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Jun 2025 15:09:04 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, mario.limonciello@amd.com, 
    linux-pci@vger.kernel.org, Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH v4] PCI/PM: Skip resuming to D0 if disconnected
In-Reply-To: <b21f3d5a-bc46-4e04-8dcc-657f1146378e@kernel.org>
Message-ID: <30fa6086-12e6-45f2-8dc6-87d9c95ead49@linux.intel.com>
References: <20250623191335.3780832-1-superm1@kernel.org> <aFpSTT_UHakY91_q@wunner.de> <CAJZ5v0gjCdpARy5NzCZ71xb_M0-LU0110F_eGaPZsuCHGWWARg@mail.gmail.com> <b21f3d5a-bc46-4e04-8dcc-657f1146378e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1136960237-1750939744=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1136960237-1750939744=:930
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Mario Limonciello wrote:

> On 6/24/25 5:24 AM, Rafael J. Wysocki wrote:
> > On Tue, Jun 24, 2025 at 9:22=E2=80=AFAM Lukas Wunner <lukas@wunner.de> =
wrote:
> > >=20
> > > [cc +=3D Rafael, Mika]
> > >=20
> > > On Mon, Jun 23, 2025 at 02:13:34PM -0500, Mario Limonciello wrote:
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > >=20
> > > > When a USB4 dock is unplugged the PCIe bridge it's connected to wil=
l
> > > > issue a "Link Down" and "Card not detected event". The PCI core wil=
l
> > > > treat this as a surprise hotplug event and unconfigure all downstre=
am
> > > > devices. This involves setting the device error state to
> > > > `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will
> > > > check.
> > > >=20
> > > > It doesn't make sense to runtime resume disconnected devices to D0 =
and
> > > > report the (expected) error, so bail early.
> > > >=20
> > > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >=20
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > >=20
> > > > ---
> > > > v4:
> > > >   * no info message
> > > > v3:
> > > >   * Adjust text and subject
> > > >   * Add an info message instead
> > > > v2:
> > > >   * Use pci_dev_is_disconnected()
> > > > v1:
> > > > https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@k=
ernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
> > > > ---
> > > >   drivers/pci/pci.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 9e42090fb1089..160a9a482c732 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
> > > >                return -EIO;
> > > >        }
> > > >=20
> > > > +     if (pci_dev_is_disconnected(dev)) {
> > > > +             dev->current_state =3D PCI_D3cold;
> >=20
> > Why not PCI_UNKNOWN?
>=20
> It was following what other situations of failure did:
> * existing error in pci_power_up()
> * error in pci_update_current_state()
> * error in pci_set_low_power_state()
>=20
> I view all of these cases as unrecoverable failures.
>=20
> So perhaps if changing this one to PCI_UNKNOWN those three should those a=
lso
> be PCI_UNKNOWN?
>=20
> Bjorn, Lukas, thoughts?
>=20
> >=20
> > > > +             return -EIO;
> > > > +     }
> > > > +
> > > >        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr)=
;
> > > >        if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > > >                pci_err(dev, "Unable to change power state from %s t=
o D0,
> > > > device inaccessible\n",

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

(I've no opinion on PCI_UNKNOWN or not.)

--=20
 i.

--8323328-1136960237-1750939744=:930--

