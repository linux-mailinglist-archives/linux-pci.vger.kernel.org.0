Return-Path: <linux-pci+bounces-42175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7BDC8C678
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 01:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24103AEEDE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 00:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE05695;
	Thu, 27 Nov 2025 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="o+D1zHLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AC946C;
	Thu, 27 Nov 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764202102; cv=none; b=QkKyHVsAxAgDVrj0yyinL0amSmBYEGNJhPu1J2LwZD0RHsmCXecgheJWXsndOmzGwzOjRnzWGBH5EREzAMfdndScbk9GMnd3zc+85P0NeKZWADpJjY+xXjBtG8IY93vDj9LgD8JHzb9WwwqaLLS/oczIQoN8AYrMk1fMvbEK3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764202102; c=relaxed/simple;
	bh=vF2jJF51ar6bsXa6t7/iihINwHwWmBQcPf/CzXd6qnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jC7vgr+GMn8DVdJ4KH0eUbmrSu/Pn6xCVWUUAK/pnkpUD4ufWOrbjwK0lbiVg1iT3mp+EsYlbOgySp1S9cnpFBjRgrYTlYvdx93+DWnBIssisVjjZTpZhYzVWJO3J/4KnjMEkpUKt8kdqabs2ZWLG7NfMPVAmMPnAjVgpt6Dvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=o+D1zHLe; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764202087; x=1764806887; i=spasswolf@web.de;
	bh=vF2jJF51ar6bsXa6t7/iihINwHwWmBQcPf/CzXd6qnY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o+D1zHLeKQHf9xPt/X3i+CfJuTIWAu0ueS2cTBAgzFP5PB29iDBJf0QJvca6vCpu
	 /zQj2qyCLWZ+2zt1d7Vnm1vdIM+F1eRnHXncaNzdu6pfpOKpNrj5K1U+hHwssRP0J
	 XGAfMrtVIAJysJORhEHZKjD+07PKCIY6P6n7JlDRngf6gag2kPGRk0zYxKfIg0tua
	 NPHrZR223GZ88PyuknCxJVfmlR4CjU+fHOuAossw/tFNTBZRQKnSfCDoBmc9NV8yh
	 tSSWxKS+C+d6YyKzk71c0tBg/y6U4oa3aGHjkTt1+U/Z6m3oE91hpDulSF1KG6ciZ
	 PBBA+z9FTMml9tQdzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1vzgFT1ui8-00aUBi; Thu, 27
 Nov 2025 01:08:07 +0100
Message-ID: <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in
 ACPICA
From: Bert Karwatzki <spasswolf@web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello (AMD) (kernel.org)"	 <superm1@kernel.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, 	acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>,
 spasswolf@web.de
Date: Thu, 27 Nov 2025 01:08:05 +0100
In-Reply-To: <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
References: <20251006120944.7880-1-spasswolf@web.de>
	 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
	 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
	 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
	 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
	 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
	 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
	 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
	 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
	 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
	 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
	 <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
	 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
	 <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
	 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
	 <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
	 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de>
	 <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AKT8oFDXjqvXIO66/lY6MH6t8J+WgkfgqQRwdse9knBK+N9If8M
 BELvrLT9C1XdpGsbLS+45ON3fCZ+MrEhvDygHo3ELqNOapB29CU9fxO9UYzUcFx5IWxSI2i
 lTZm30uF1RqhWcBaZs1YRZf/dU+PTtHAItEru5oSztrI/vLWooHNSX+VBrd1Nigcp/Al3a2
 JyAz3gf0Oerco8c3URX5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tL3u4n7RGtY=;7D1xbhkGvhqeso3oJucNy8vfnY0
 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
 Qd4UlFPPEPeX0L+CA=

Am Dienstag, dem 25.11.2025 um 20:46 +0100 schrieb Rafael J. Wysocki:
>=20
>=20
> What may be happening, but this is just a theory, is that the
> interpreter aborts the evaluation of a method due to an internal
> timeout, essentially the control_state->control.loop_timeout check in
> acpi_ds_exec_end_control_op() and that leads to a subsequent hard
> failure like a deadlock.
>=20
> This may be tested by increasing the ACPI_MAX_LOOP_TIMEOUT value, but
> I'm not sure it's practical to try that.

I don't think this the case here because ACPI_MAX_LOOP_TIMEOUT defaults to=
=20
30s and the walk loop until the crash only lasts ~2s.

Bert Karwatzki

