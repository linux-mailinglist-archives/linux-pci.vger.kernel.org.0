Return-Path: <linux-pci+bounces-37649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E228BC063E
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 771EE4F3727
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1FB23D7DA;
	Tue,  7 Oct 2025 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="O8fkMZJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218523D7EB;
	Tue,  7 Oct 2025 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819880; cv=none; b=ACS3z4TEY8mPTkCBbY3u55Pnw95RKVr86Yui1Bq8pE3cin2H0zo7upSkpdi2lvMlxYvvZFAqH1+EzMxOW2BRGKGsI7S5uQGUzS9esnOdlSAVlHtaFOCkb1+ZnHtqBpDVCCQjsbJSbPodYssWEC4gpw7JWiwlKtvF8AAT+ZNInrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819880; c=relaxed/simple;
	bh=GtbhvKiArLsYQIx3MfRsDS+EuExg22K9a2ED8U/fIoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3ab9JT9CohxaJouONd5InU7+70cPwnEIZ1ZVpL8nlfgdsnheeuPNYIGUQGVAj3vtt4a24MZ9dSUUq5nqgyDx42cRnoBLaUKxbyP/IAeeEDUQ0g2hnPXSSOGNPMiovZ9Xk1xW3Nfvm1p9V93QRRPBsBSolgq4cD0cVLCryv504g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=O8fkMZJ9; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759819832; x=1760424632; i=spasswolf@web.de;
	bh=hMv2KA500eT5A2cLBEJygRRyPv5VC2X953xjqw/qJNg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O8fkMZJ9iKSTLRbKEjVrQJYeyqxGIZG/OkmsO4QTCNmzIczsdh8pYQ5jsaZd90v9
	 O+73Yu5QME1Bft9jEUqifhgN6QMdZ8FbJ01K3rZc23YcKgDzAyTApnYs7G/Arifmc
	 txmD09y/UoL4GX/wCY/8ZfOa/j6aofbcCBcFgYR1T1krj/lprCkeONiG0nuP8+LT+
	 1e2WgdpZaCQHaREo+pLQLan+UePvUt+aNmhVXE64Df5JzgkHnM0EU+vArWDAFZsdq
	 3qXRU6XjuluvZbEInTGY0J1/yGZ7j2qQOdZS/WoGcYU1kaE+xUVwA1lBdivVeQLX+
	 D+UpsLS4dk/WXzRHUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGKA-1ulgqU07l0-00VCMN; Tue, 07
 Oct 2025 08:50:32 +0200
Message-ID: <93d21bb6887310d331fa67a3766e47af9669dfc3.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Mario Limonciello
	 <superm1@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	spasswolf@web.de
Date: Tue, 07 Oct 2025 08:50:30 +0200
In-Reply-To: <e60d2cf59666b6f670996bac80cb948acb1d7b5c.camel@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
		 <232324a9-e82d-40b3-b88b-538947411a24@amd.com>
	 <e60d2cf59666b6f670996bac80cb948acb1d7b5c.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P2lTxUYjpSJLpmPegmqbkcyB6sbH+UfSUmWzVDV9JBVg0nVP1n/
 4H6Fk4fTK58n9InB522qyqur+nTI1XA/dDROjtVjyqHKcqj8W+3D2Jyfm0mLVFiCZSUjI5A
 Dq8UH/Fz5BPV5irPojc8TuSv5pS3OWW2fNpyUx1MCzPUMsninR4iLgSGs++3WrCQ5iy8Ccr
 rU1NZuRNoGfd26MWYN/VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dpnenm5dL5I=;6Bd1JKSW2d9/a+Z1liuNly437rD
 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

Am Montag, dem 06.10.2025 um 18:22 +0200 schrieb Bert Karwatzki:
>=20
> >=20
> Even versions that did crash can be stable for 24h of uptime so I think =
this=C2=A0
> will take too long.
> I think I've already chased down the crash to this part of rpm_resume()
> (I'm currently doing a testrun with more dev_info()s in this part):
>=20
>  skip_parent:
>=20
> 	if (!strcmp(dev_name(dev), "0000:00:01.1"))
> 		dev_info(dev, "%s %d\n", __func__, __LINE__); // this is the last repo=
rted line in netconsole
> 	if (dev->power.no_callbacks)
> 		goto no_callback;	/* Assume success. */
>=20
> 	__update_runtime_status(dev, RPM_RESUMING);
>=20
> 	callback =3D RPM_GET_CALLBACK(dev, runtime_resume);
>=20
> 	dev_pm_disable_wake_irq_check(dev, false);
> 	retval =3D rpm_callback(callback, dev);
> 	if (retval) {
> 		__update_runtime_status(dev, RPM_SUSPENDED);
> 		pm_runtime_cancel_pending(dev);
> 		dev_pm_enable_wake_irq_check(dev, false);
> 	} else {
>  no_callback:
>=20
>=20
> Bert Karwatzki

The testrun is already finished the crash occured after 10h and ~700 GPP0 =
notifies,
the part of rpm_resume() above was monitored like this:

 skip_parent:

	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__);
	if (dev->power.no_callbacks)
		goto no_callback;	/* Assume success. */

	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__);
	__update_runtime_status(dev, RPM_RESUMING);

	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__);
	callback =3D RPM_GET_CALLBACK(dev, runtime_resume);

	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d callback =3D %px\n", __func__, __LINE__, (void *) c=
allback);
	dev_pm_disable_wake_irq_check(dev, false);
	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__);   // This is the last repo=
rted line!
	retval =3D rpm_callback(callback, dev);
	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__);
	if (retval) {
		if (!strcmp(dev_name(dev), "0000:00:01.1"))
			dev_info(dev, "%s %d\n", __func__, __LINE__);
		__update_runtime_status(dev, RPM_SUSPENDED);
		pm_runtime_cancel_pending(dev);
		dev_pm_enable_wake_irq_check(dev, false);
	} else {
 no_callback:

The result is that in the case of the crash rpm_callback() didn't return, =
so
I'll continue the investigation in rpm_callback().

The whole calltrace is:
acpiphp_check_bridge()->pm_runtime_get_sync()->__pm_runtime_resume()->rpm_=
resume()->rpm_callback()

Bert Karwatzki

