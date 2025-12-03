Return-Path: <linux-pci+bounces-42574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81945C9F585
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 6F1D130057A3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328AD30216F;
	Wed,  3 Dec 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="KTF0GJ5E"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DD302149;
	Wed,  3 Dec 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773317; cv=none; b=aMPP7vwgcsYMpA58Hpzo4I3AJ6KpjW75Fmcaup6j+uVljVzSER1O5kpQ07twjdOtMIy4LOoMtGp8DCOlYy3gLJm/oHlpQa7C7G1asM338dbZypKJ4/0ilqZgyZ1bv2uG/JHmqF9qXCyMsPoG+EXCJFMquijfpwoZEPcIrTha4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773317; c=relaxed/simple;
	bh=SmbjA0OctpO7e6pM9pBOEA/aTMempFn7GsG3Ntex2b0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BJMeyarp3WE5Uw3lBGqx83VNWDtujEXWIgKTk6bApQ7bw8QutgKOjLP1mA5bHr4QaAlJu01tzJrBALJxWXX1w9AFyJxbufgQdja8B2RGDOUkGEw+MKYZyptUD1XCJM/cO3clih9B06I9Jy7nWtV2YHosBVQPUsVz5G58KJrjiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=KTF0GJ5E; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S9KSfTorsR7QHOU5P1AkPAT7IyIg4S+ldiFj9+6W7ko=; b=KTF0GJ5Ey6a0oKez6wao5tDVSB
	Rge+8f2OCx3uOEY8CTaxGOPdTa8Edi8NygopZdoaqOUPAUA/deGYcG0t0CzCQYqYkdgoKsEX2D8lr
	ZyfEAJiNwyhthFOd5j/ZgDu79kYZcxSO2otsxOJSlvcFvSddY08lycNVLJyTTDRDTrtn5dOTb11+h
	JSjyjLyoyibqQjgv7nlTudzGSW4/JyNZZZASdRN3aCOiBMRMVveYVOHml94cYOiRV+v5ePejNliVL
	Dddgs1l4mpXs0tp0WxBaBCDDtWhDGal9+713HKfuXFPVOBlKFMvV5ZEjWY8BsfslJjoeDP9qxPtIp
	JiSF0CkA==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <20251203142743.GD2580184@black.igk.intel.com>
Date: Wed, 3 Dec 2025 15:48:26 +0100
Cc: Lukas Wunner <lukas@wunner.de>,
 Brian Norris <briannorris@chromium.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Riccardo Mottola <riccardo.mottola@libero.it>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5E42CF4-7D6B-4081-AD59-CAC09FCB1890@exactco.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas> <aS9f-K_MN0uYUCYx@google.com>
 <aS_BYeSApI2XuPcD@wunner.de> <20251203142743.GD2580184@black.igk.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 3. Dec 2025, at 15:27, Mika Westerberg =
<mika.westerberg@linux.intel.com> wrote:

=E2=80=A6

>> A Thunderbolt controller exposes a PCIe switch.  Daisy-chained
>> Thunderbolt devices are thus visible to the OS as nested switches.
>> If we followed the approach you're suggesting, users would have to
>> manually allow runtime PM on every Switch Upstream and Downstream =
Port
>> as well as the Root Port and they'd have to do that upon hotplugging
>> a device.  Yes, yes, users could add a udev rule to allow runtime PM
>> automatically by default, but that's exactly the policy we have =
hardcoded
>> in the kernel right now, so why the change?
>>=20
>> I expect massive power regressions for users (not least Chromebook
>> users) if we made that change.
>>=20
>> The discrete Thunderbolt controller in my machine consumes 1.5W
>> when nothing is attached.  Some laptops have multiple of these.
>> Recent CPUs with integrated Thunderbolt/USB4 may fail to transition
>> the package to a low power state unless the Thunderbolt ports go
>> to D3hot.
>>=20
>> So I don't think this approach is a viable option.
>=20
> I agree.  If this is limited to some older RISC machines (based on the
> $subject) perhaps this could be solved by adding udev rules to block
> runtime PM on those certain ports?

Let=E2=80=99s not overcomplicate it for now. All we have are a couple of =
old Unix
RISC workstations. Let=E2=80=99s see if we can somehow fix them for real =
first.

Given the feedback that D3Hot =E2=80=9Cshould=E2=80=9D more often work I =
went ahead
and changed the patch in T2/Linux removing the 2015 check and all arch
except SPARC and let our prosumer enthusiast users find out if something
else breaks first to gather more data points.

I=E2=80=99ll try to find time to debug the SPARC64 Sun Blade 1K issue, =
but I have
some other TODO first, so it might be January for more work on that.

Maybe we should push a patch to only disable this for SPARC64 to stable
In the meantime?

=
https://svn.exactcode.de/t2/trunk/package/kernel/linux/hotfix-legacy-pci-b=
ridge-d3.patch

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2b53219fda3b..869d204a70a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3067,10 +3067,9 @@ bool pci_bridge_d3_possible(struct pci_dev =
*bridge)
 			return false;
=20
 		/*
-		 * Out of caution, we only allow PCIe ports from 2015 or =
newer
-		 * into D3 on x86.
+		 * It should be safe to put PCIe ports to D3.
 		 */
-		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=3D =
2015)
+		if (!IS_ENABLED(CONFIG_SPARC64))
 			return true;
 		break;
 	}

	Ren=C3=A9

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe


