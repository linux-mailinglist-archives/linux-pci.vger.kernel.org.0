Return-Path: <linux-pci+bounces-42689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25CCA711C
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 11:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9F78300960E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0D4A02;
	Fri,  5 Dec 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="nv/mKlJT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CC2E9EAD;
	Fri,  5 Dec 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929147; cv=none; b=gHlLSXVnI+OuuFRdFlkicjF7H4DB33TmRGWGKv1apFTCkbIlLG9IeOzEGJ1Dr7/lyU3eBd/V+Tk59KMfY9B+mFolDZ1kUgmgoWgF0/jM7SDRcAal6hJbLiNh2Ml9jddtJEvatXpq4tJwMIw2HKSOeeZztUvLv82Vxi+REYV3mbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929147; c=relaxed/simple;
	bh=ib/gXzDeZgu4FUShYtzIvwmGMZaUQaAKTv4WQMFhflg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qhKq5yWpn8ufbC+fTaMkpzsK97udD4xwxyY9hV7clC1q1+nqVCMr8revI3cMy/FP9o0IR7bmKc8z6wFcgUWwEseVih3ElXtlGGPb5W/C3khutnYU+6aKn/cKD3PzkkF75wa4qni+gqt3C7oQfJDYmewJtE6VKDdcvNG0TlI2Yss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=nv/mKlJT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764929118; x=1765533918; i=spasswolf@web.de;
	bh=Hu6ZisbcUmOSh32SfFnw6/u6mGFtMWRMVLqKx6Oixhk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nv/mKlJTVdpyMmUt6XrVsZ5Z4nlrLg5fxLg5vRHsiNYJ71WmaQRDdTId/SFmY3Lb
	 b7+VXPd3EEUHFRp8f0r4dm3oGXCe0h0puYuwaXEzzclkeaYk/q32lXnl9Q2tgnNdG
	 jiTsaR6qmB2VeX8MFPrz0AJHf34dLDujKIGfqCqXfx7xIx+7jtF2mYdLc9/ojG/Cm
	 tlAahidXv/25kkoN7OFNIKbANYPv0cHLbexCxmi5AMd1xE5PxkA4/l6V4dq6nzazb
	 MrjIg0ItaNMAAAqGqo0rcMBkX1e3txusGeYc4asUHTObUX6JZT76Dx7xVA1TRWtrV
	 X16OWyAUKhaOnK1bwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1wJHlB43aW-00zaBK; Fri, 05
 Dec 2025 11:05:18 +0100
Message-ID: <ec99725df78fdd0fd9d4398d00fdebb84cb38ee6.camel@web.de>
Subject: Re: Crash during resume of pcie bridge due to incorrect error
 handling
From: Bert Karwatzki <spasswolf@web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello (AMD) (kernel.org)"	 <superm1@kernel.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, 	acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>,
 spasswolf@web.de, Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 05 Dec 2025 11:05:16 +0100
In-Reply-To: <CAJZ5v0gfRmr=q=SYLSWO9px6uUq5ZPQxJ=peo7JHDP926niB8A@mail.gmail.com>
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
	 <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de>
	 <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
	 <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de>
	 <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
	 <a3e1729912a94d10d7dd211efe837d4d6c7a3eaf.camel@web.de>
	 <CAJZ5v0gfRmr=q=SYLSWO9px6uUq5ZPQxJ=peo7JHDP926niB8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjVvLQ27gkGkBmOxjgnqXswS31xITpv9Bf5mEjTER9fvGdTnTgJ
 4rPM7VtgbeYYEw+Hbq2oliMThIVDBuRIKt0lckXxrlVEEzCN4WCtWjTeBpicgL/shz6d508
 kdpyb/hmj8s5WgXJzzgC6ZPJLB3ALN+5OxCztujqESCu5eGrmGGwFaNZ+z41x5QfUcArlq8
 vDMxiptlCxSJYusSDJROQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TiwFSIs0SZU=;53jxBV5lnLkdJ56QKVlcNiW9yfc
 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

I've got good and bad news on this. The good news first:

I was able to get through a failed resume without a crash with the followi=
ng
changes to the pci resume process:

1: pci_pm_bridge_power_up_actions() returns -ENODV when pci_bridge_wait_fo=
r_secondary()
returns an error (pci_walk_bus_debug() is just pci_walk_bus() with added p=
rintk()s),
and also sets state to PCI_D3cold on failure:

static int pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
{
	int ret;

	dev_info(&pci_dev->dev, "%s %d\n", __func__, __LINE__);
	ret =3D pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
	dev_info(&pci_dev->dev, "%s %d: ret =3D %d\n", __func__, __LINE__, ret);
	if (ret) {
		/*
		 * The downstream link failed to come up, so mark the
		 * devices below as disconnected to make sure we don't
		 * attempt to resume them.
		 */
		pci_walk_bus_debug(pci_dev->subordinate, pci_dev_set_disconnected,
			     NULL);
		pci_update_current_state(pci_dev, PCI_D3cold);
		dev_info(&pci_dev->dev, "%s: bridge failed to power up\n", __func__);
		return -ENODEV;
	}

	/*
	 * When powering on a bridge from D3cold, the whole hierarchy may be
	 * powered on into D0uninitialized state, resume them to give them a
	 * chance to suspend again
	 */
	pci_resume_bus(pci_dev->subordinate);
	return 0;
}

2. pci_pm_runtime_resume() has an early exit if pci_pm_bridge_power_up_act=
ions() fails:


static int pci_pm_runtime_resume(struct device *dev)
{
	struct pci_dev *pci_dev =3D to_pci_dev(dev);
	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
	pci_power_t prev_state =3D pci_dev->current_state;
	int error =3D 0;

	/*
	 * Restoring config space is necessary even if the device is not bound
	 * to a driver because although we left it in D0, it may have gone to
	 * D3cold when the bridge above it runtime suspended.
	 */
	pci_pm_default_resume_early(pci_dev);
	pci_resume_ptm(pci_dev);

	if (!pci_dev->driver)
		return 0;

	pci_fixup_device(pci_fixup_resume_early, pci_dev);
	pci_pm_default_resume(pci_dev);

	if (prev_state =3D=3D PCI_D3cold) {
		error =3D pci_pm_bridge_power_up_actions(pci_dev);
		if (error)
			return error;
	}
	[...]
}

3. acpiphp_check_bridge() has an early exit if pm_runtime_get_sync()
returns an error (pm_runtime_get_sync() basically returns the result of
pci_pm_runtime_resume() which is called as a callback in rpm_resume())

static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
{
	struct acpiphp_slot *slot;
	int ret;

	/* Bail out if the bridge is going away. */
	if (bridge->is_going_away)
		return;

	if (bridge->pci_dev) {
		ret =3D pm_runtime_get_sync(&bridge->pci_dev->dev);
		if (ret < 0) {
			dev_info(&bridge->pci_dev->dev, "%s: pm_runtime_get_sync() failed with =
ret =3D %d\n", __func__, ret);
			return;
		}
	}

With these changes I get the following messages in dmesg when acpi_power_o=
n_list() fails
for the pci bridge:

2025-12-05T01:58:53.260991+01:00 lisa kernel: [ T1772] acpi_power_on_list_=
debug 649: result =3D -19
2025-12-05T01:58:53.260993+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_default_resume_early 567
2025-12-05T01:58:53.260994+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_bridge_power_up_actions 576
2025-12-05T01:58:54.282032+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: broken device, retraining non-functional downstream link at 2.5GT/s
2025-12-05T01:58:55.282033+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: retraining failed
2025-12-05T01:58:55.282053+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: Data Link Layer Link Active not set in 1000 msec
2025-12-05T01:58:55.282055+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_bridge_power_up_actions 578: ret =3D -25
2025-12-05T01:58:55.282057+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282058+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282060+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282063+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282065+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 1.0
2025-12-05T01:58:55.282067+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282070+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282073+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282101+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282103+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 1.0
2025-12-05T01:58:55.282105+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282107+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282109+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282111+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282113+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282115+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282116+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282118+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282120+01:00 lisa kernel: [ T1772] __pci_walk_bus_debu=
g: ret =3D 0
2025-12-05T01:58:55.282122+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 1.1: ret =3D 0
2025-12-05T01:58:55.282124+01:00 lisa kernel: [ T1772] __pci_walk_bus_debu=
g: ret =3D 0
2025-12-05T01:58:55.282126+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 1.1: ret =3D 0
2025-12-05T01:58:55.282128+01:00 lisa kernel: [ T1772] __pci_walk_bus_debu=
g: ret =3D 0
2025-12-05T01:58:55.282130+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_bridge_power_up_actions: bridge failed to power up
2025-12-05T01:58:55.282131+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 916 retval =3D -19
2025-12-05T01:58:55.282133+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 922
2025-12-05T01:58:55.282135+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 937
2025-12-05T01:58:55.282137+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 947
2025-12-05T01:58:55.282138+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 950
2025-12-05T01:58:55.282140+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -19
2025-12-05T01:58:55.282141+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:58:55.523974+01:00 lisa kernel: [T192257] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:21.896980+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:21.896986+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:22.141965+01:00 lisa kernel: [T192400] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:51.903964+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:51.903974+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:52.153973+01:00 lisa kernel: [T192554] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:21.915965+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:21.915971+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:22.161971+01:00 lisa kernel: [T192706] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:51.922981+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:51.922988+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:52.175975+01:00 lisa kernel: [T192899] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:52.931997+01:00 lisa kernel: [T180476] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:52.932008+01:00 lisa kernel: [T180476] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:01:21.933961+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:21.933965+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:22.172962+01:00 lisa kernel: [T193054] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:23.001998+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:23.002009+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:01:51.942980+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:51.942986+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:52.188969+01:00 lisa kernel: [T193209] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:52.958995+01:00 lisa kernel: [T188262] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:52.959009+01:00 lisa kernel: [T188262] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:02:21.951971+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:21.951980+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:22.205974+01:00 lisa kernel: [T193359] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:23.117988+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:23.118000+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:02:51.963970+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:51.963976+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:52.209969+01:00 lisa kernel: [T193512] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:53.465055+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:53.465074+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:02:57.133996+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:57.134006+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
These lines continue, all further resumes fail but no crash occurs.

The complete debug code used is here (it's rather messy though):
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume?ref_type=3Dheads
I've not tested yet, If the fix above also works on a pure v6.14 without a=
ll the debug patches.


The bad news is I've encountered another version of the crash. (at least 9=
0% of these crashes occur after=C2=A0
acpi_power_on() fails as above, but at least 2 crashes happened on suspend=
) Now a third version has appeared
which occured after an SMU resume failure in amdgpu (up to now SMU failure=
 have appeared but they did not
result in a crash like this)

2025-12-04T12:52:19.589753+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: SMU i=
s resuming...#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-12-04T12:52:19.589753+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: smu d=
river if version =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw =
program =3D 0,
version =3D 0x003b3100 (59.49.0)#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:000=
0:03:00.0
2025-12-04T12:52:19.589753+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: SMU d=
river if version not matched#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03=
:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: SMU: =
response:0xFFFFFFFF for index:6 param:0x00000000 message:EnableAllSmuFeatu=
res?#012
SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: Faile=
d to enable requested dpm features!#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:=
0000:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: Faile=
d to setup smc hw!#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: resum=
e of IP block <smu> failed -121#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000=
:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: amdgp=
u_device_ip_resume failed (-121).#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:00=
00:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: pci_pm_runtim=
e_resume 1380 error =3D -121 state =3D 0x0#012 SUBSYSTEM=3Dpci#012 DEVICE=
=3D+pci:0000:03:00.0

=46rom here on the system hangs for quite a long time (9s!) while these er=
ror messages appear on netconsole:

2025-12-04T12:52:20.870639+01:00 C0;INFO: NMI handler (perf_event_nmi_hand=
ler) took too long to run: 122.609 msecs
2025-12-04T12:52:21.072400+01:00 C0;perf: interrupt took too long (958843 =
> 2500), lowering kernel.perf_event_max_sample_rate to 1000
2025-12-04T12:52:21.879308+01:00 C5;INFO: NMI handler (perf_event_nmi_hand=
ler) took too long to run: 138.016 msecs
2025-12-04T12:52:23.493066+01:00 C13;INFO: NMI handler (perf_event_nmi_han=
dler) took too long to run: 162.351 msecs
2025-12-04T12:52:23.694900+01:00 C13;perf: interrupt took too long (126845=
5 > 1198553), lowering kernel.perf_event_max_sample_rate to 1000
2025-12-04T12:52:26.318173+01:00 C11;INFO: NMI handler (perf_event_nmi_han=
dler) took too long to run: 182.852 msecs
2025-12-04T12:52:28.940844+01:00 C0;perf: interrupt took too long (2079549=
 > 1585568), lowering kernel.perf_event_max_sample_rate to 1000
[crash, no further messages]

So perhaps acpi_php_check_bridge() is not the only place where a returned =
error
is incorrectly ignored.

Bert Karwatzki

