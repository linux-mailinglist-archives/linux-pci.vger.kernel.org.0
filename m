Return-Path: <linux-pci+bounces-15338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E18869B0965
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A21F22967
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3617DFFC;
	Fri, 25 Oct 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKVfhebQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9189170A31;
	Fri, 25 Oct 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872741; cv=none; b=ne7bOt+nKHN/V40Sc6ifOsNHy8406vCtc4UUGC5nsSCdqxeulgiLxG9Odd1w5q4vZV3OeaOxfRtogcDciI/t+WciKCKHhfR6bgN/N0MzznckKF619TSCbADCDhmkYJukfgrVnYdXsSNk+oc03WzZWZa74Is8N9ifHRgBr6d1Bqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872741; c=relaxed/simple;
	bh=aTh4qbVhNfvKtyy5tWAikgkoGoiAaV1WwpiwXCG6zgU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TQSsw/TYepvC9EyzjmIdM8ngppAGqu90l4XxxTpy3lX+LsvdYKHH5KGB43lF6DLpNE8KClnSY8QzjXJxrWsvN1wL4WckrS5JU40PoC8cgOwijGpxHD4hO7jXjPfiyoaWO+zgGXu+3q0G44QOvVYJyZWyTmvQOCulyU+4AQ6gWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKVfhebQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729872739; x=1761408739;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aTh4qbVhNfvKtyy5tWAikgkoGoiAaV1WwpiwXCG6zgU=;
  b=ZKVfhebQMRb1jMd2QDgM7y6qTW/afFyst6Jm4LeuPnDqneTXlEHpqOcT
   VmVEq+UfY9kycRSe4y1vftMJA4UG0WrV5Wh4/as0BV3ZeMceLDewgjiVW
   uykfBSKFEk43QLb2mm59ia5aBHCJAJ3CxbFq+1ZTAb3q37ni4k5wbwwZL
   DFUqcUnfqfiDXaxLyStTFRdzvM3MWOKLLNa9M3EI2PeT5AMdFxuGz7WA1
   dwG9n8L/T2zTQDSx5BixSkQr0m4A4roAmCiwv3t+SkZOlCiUEpfm92MuT
   5cppavTDjj6GZm4YaUPdKgwnBY1VlaY3Kl89Jsj3rDx1i/9SfwFdZFsGW
   Q==;
X-CSE-ConnectionGUID: esgDjNCJTnmF8zLnozHyjg==
X-CSE-MsgGUID: JxBewegHQdqCrkH1tP+f/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29323741"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29323741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:12:18 -0700
X-CSE-ConnectionGUID: AKL1ldGjQLWIt5hcBTtlcw==
X-CSE-MsgGUID: mM8sUPJQQ/yX6s0Nqw+zQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85541780"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:12:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 19:11:59 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, 
    Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, 
    "David S. Miller" <davem@davemloft.net>, 
    Boris Brezillon <bbrezillon@kernel.org>, 
    Arnaud Ebalard <arno@natisbad.org>, Srujana Challa <schalla@marvell.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
    Kalle Valo <kvalo@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
    Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
    Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Kevin Cernekee <cernekee@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
    Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, 
    David Lechner <dlechner@baylibre.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Jie Wang <jie.wang@intel.com>, Tero Kristo <tero.kristo@linux.intel.com>, 
    Adam Guerin <adam.guerin@intel.com>, 
    Shashank Gupta <shashank.gupta@intel.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Bharat Bhushan <bbhushan2@marvell.com>, 
    Nithin Dabilpuram <ndabilpuram@marvell.com>, 
    Johannes Berg <johannes.berg@intel.com>, 
    Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
    Gregory Greenman <gregory.greenman@intel.com>, 
    Benjamin Berg <benjamin.berg@intel.com>, 
    Yedidya Benshimol <yedidya.ben.shimol@intel.com>, 
    Breno Leitao <leitao@debian.org>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-ide@vger.kernel.org, qat-linux@intel.com, 
    linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org, 
    ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
In-Reply-To: <415402ba495b402b67ae9ece0ca96ab3ea5ee823.camel@redhat.com>
Message-ID: <a3e6808f-195c-7174-64f9-a4392d7a02f0@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com>  <20241025145959.185373-7-pstanner@redhat.com>  <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com> <415402ba495b402b67ae9ece0ca96ab3ea5ee823.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2035259113-1729872719=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2035259113-1729872719=:946
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Oct 2024, Philipp Stanner wrote:

> On Fri, 2024-10-25 at 18:31 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 25 Oct 2024, Philipp Stanner wrote:
> >=20
> > > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > > Deprecate
> > > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> > >=20
> > > Replace these functions with their successors, pcim_iomap() and
> > > pcim_request_all_regions().
> > >=20
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > Acked-by: Kalle Valo <kvalo@kernel.org>
> > > ---
> > > =C2=A0drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------=
---
> > > ---
> > > =C2=A01 file changed, 4 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > index 3b9943eb6934..4b41613ad89d 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > @@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct
> > > pci_dev *pdev,
> > > =C2=A0=09struct iwl_trans_pcie *trans_pcie, **priv;
> > > =C2=A0=09struct iwl_trans *trans;
> > > =C2=A0=09int ret, addr_size;
> > > -=09void __iomem * const *table;
> > > =C2=A0=09u32 bar0;
> > > =C2=A0
> > > =C2=A0=09/* reassign our BAR 0 if invalid due to possible runtime
> > > PM races */
> > > @@ -3659,22 +3658,15 @@ struct iwl_trans
> > > *iwl_trans_pcie_alloc(struct pci_dev *pdev,
> > > =C2=A0=09=09}
> > > =C2=A0=09}
> > > =C2=A0
> > > -=09ret =3D pcim_iomap_regions_request_all(pdev, BIT(0),
> > > DRV_NAME);
> > > +=09ret =3D pcim_request_all_regions(pdev, DRV_NAME);
> > > =C2=A0=09if (ret) {
> > > -=09=09dev_err(&pdev->dev,
> > > "pcim_iomap_regions_request_all failed\n");
> > > +=09=09dev_err(&pdev->dev, "pcim_request_all_regions
> > > failed\n");
> > > =C2=A0=09=09goto out_no_pci;
> > > =C2=A0=09}
> > > =C2=A0
> > > -=09table =3D pcim_iomap_table(pdev);
> > > -=09if (!table) {
> > > -=09=09dev_err(&pdev->dev, "pcim_iomap_table failed\n");
> > > -=09=09ret =3D -ENOMEM;
> > > -=09=09goto out_no_pci;
> > > -=09}
> > > -
> > > -=09trans_pcie->hw_base =3D table[0];
> > > +=09trans_pcie->hw_base =3D pcim_iomap(pdev, 0, 0);
> > > =C2=A0=09if (!trans_pcie->hw_base) {
> > > -=09=09dev_err(&pdev->dev, "couldn't find IO mem in first
> > > BAR\n");
> > > +=09=09dev_err(&pdev->dev, "pcim_iomap failed\n");
> >=20
> > This seems a step backwards as a human readable English error message
> > was=20
> > replaced with a reference to a function name.
>=20
> I think it's still an improvement because "couldn't find IO mem in
> first BAR" is a nonsensical statement. What the author probably meant
> was: "Couldn't find first BAR's IO mem in magic pci_iomap_table" ;)

Well, that's just spelling things on a too low level too. It's irrelevant
detail to the _user_ that kernel used some "magic table". Similarly, it's=
=20
irrelevant to the user that function called pcim_iomap failed.

> The reason I just wrote "pcim_iomap failed\n" is that this seems to be
> this driver's style for those messages. See the dev_err() above, there
> they also just state that this or that function failed.

The problem in using function names is they have obvious meaning for=20
developers/coders but dev_err() is presented to user with varying level
of knowledge about kernel internals/code.

While users might be able to derive some information from the function=20
name, it would be simply better to explain on higher level what failed=20
which is what I think the original message tried to do even if it was
a bit clumsy. There is zero need to know about kernel internals to=20
interpret that message (arguably one needs to know some PCI to understand=
=20
BAR, though).

(Developers can find the internals by looking up the error message from
the code so it doesn't take away something from developers.)

--=20
 i.

> I am indifferent about the message, though. Whatever the maintainer
> prefers is fine.

--8323328-2035259113-1729872719=:946--

