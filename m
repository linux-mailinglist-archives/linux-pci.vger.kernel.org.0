Return-Path: <linux-pci+bounces-37933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B67EBD5540
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17374FCD55
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2D26E6F6;
	Mon, 13 Oct 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ea0H0SUR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45392236FD;
	Mon, 13 Oct 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373012; cv=none; b=G+5JHtOrE4t43DP+QchTAtbONE7v46XkCizJUwj85fNbpbig2nLO9y4p2Ujm9lmhKAYRvpW/LdB4ftU9inNtZ3DzTwUEi8mxsWWAmfMuOqVuS/I86NQPaB46ngTdL5ui4tJD4ipJoHu/eR/QrJepDbhvIbdnH9WcPWFnaZfDrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373012; c=relaxed/simple;
	bh=45x2Jb4bOksiYc+/gQKshlBk0WTvXWQ0lxteCKoIgwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krdHYVhFXduheLUVCnzCFGKcUlo060VZUF1ZbxS2soxS4CvXZpGXd2k8sq8dAcVehv52G1DX8ssCBtL5qVIx4o7Y643W50BeJ+z6NJ2bnHLDQETdON2jdMB4KKv8HkAae0272f1ZC8FzLiCuOdcgEyCgYxe++8KvYkpH0aVR83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ea0H0SUR; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760372988; x=1760977788; i=spasswolf@web.de;
	bh=nqMyNCBrL+BlSohWKUpwCMTnwvgKLIa0I7oU0sG2VfE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ea0H0SURKVpCNhu8yHfSl6Utd505xo6U+lCaCKtLD/TmSC4qc6YSZIGVBeRK0TAL
	 LIwmjjJI/OYuLO6HPZaKgQ8VInZ+GzU7/WDFqkicE37BY156qL41xUuhi325QZd2G
	 Cb5d1IIOpgVe7IWioTYQLLSZD1gasuJP1tKvHjxmy1GdbTbSZ2dYOWwt3K6rAhbSF
	 1iYeGcFB6q0OtD9/IJxt3v2DqISKhV4PcGshG+rPShlfDECLa79IHMWJf3EMVaqgh
	 0OD/z8do1dSRCCdfkEJNd78wW2QrF1SE/8l6I2e4wL5l4kFfLsDft0U19G84Wauay
	 sH7OnA3tgXER5pt+yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIyeG-1up9qo21ko-00R4KJ; Mon, 13
 Oct 2025 18:29:48 +0200
Message-ID: <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: Mario Limonciello <superm1@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, 	spasswolf@web.de
Date: Mon, 13 Oct 2025 18:29:46 +0200
In-Reply-To: <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
References: <20251006120944.7880-1-spasswolf@web.de>
	 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:43GG+RGVT3i3a/y83/W1ei+fO9suSrJwpqVV1suZxFJViRLeSqz
 xkBmfjtGrawI3i77v66zpjlxaTET2VHe0liHMuANDp46wTq5VsbFu4dkdOSEjIBBuBdyzW+
 GtT6/7XQzzqmO97rSNUkJ1gNA363HI/h1ag0hmN3qQa2OS/y9nRRV8xLNzVnnHXEQNSCP2o
 kuRJnuuqodWaC4/haH2Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LoPZVms++YQ=;gATdQA/iUlFHEQDdx2TUmwSgu67
 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
 DqH4Q==

Am Dienstag, dem 07.10.2025 um 16:33 -0500 schrieb Mario Limonciello:
>=20
> Can you still reproduce with amd_iommu=3Doff?

Reproducing this is at all is very difficult, so I'll try to find the exac=
t spot
where things break (i.e. when the pci bus breaks and no more message are t=
ransmitted
via netconsole) first. The current state of this search is that the crash =
occurs in
pci_pm_runtime_resume(), before pci_fixup_device() is called:

static int pci_pm_runtime_resume(struct device *dev)
{
	struct pci_dev *pci_dev =3D to_pci_dev(dev);
	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
	pci_power_t prev_state =3D pci_dev->current_state;
	int error =3D 0;
	// dev_info(dev, "%s =3D %px\n", __func__, (void *) pci_pm_runtime_resume=
); // remove this so we don't get too much delay
										  // This was still printed in the case of a crash
										  // so the crash must happen below

	/*
	 * Restoring config space is necessary even if the device is not bound
	 * to a driver because although we left it in D0, it may have gone to
	 * D3cold when the bridge above it runtime suspended.
	 */
	pci_pm_default_resume_early(pci_dev);
	if (!strcmp(dev_name(dev), "0000:00:01.1")) // This is the current test.
		dev_info(dev, "%s %d\n", __func__, __LINE__);
	pci_resume_ptm(pci_dev);

	if (!pci_dev->driver)
		return 0;

	//if (!strcmp(dev_name(dev), "0000:00:01.1"))         // This was not pri=
nted when 6.17.0-rc6-next-20250917-gpudebug-00036-g4f7b4067c9ce
	//	dev_info(dev, "%s %d\n", __func__, __LINE__); // crashed, so the crash=
 must happen above
	pci_fixup_device(pci_fixup_resume_early, pci_dev);
	pci_pm_default_resume(pci_dev);

	if (prev_state =3D=3D PCI_D3cold)
		pci_pm_bridge_power_up_actions(pci_dev);

	if (pm && pm->runtime_resume)
		error =3D pm->runtime_resume(dev);

	return error;
}


Bert Karwatzki

