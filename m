Return-Path: <linux-pci+bounces-24304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC8A6B3C6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 05:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B116DF61
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 04:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B34C1E9B16;
	Fri, 21 Mar 2025 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX+BSGAu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB78836
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532184; cv=none; b=NMgokRpQY/r1VQE7KD0PZy+Z7JyE15MMQrVepnESUvSSDKF4MzQXp1DyC2nKqH9Q0/RW3my/bz/0MjUe/n4iqks2vF8AXpbWwxL+3RhG+eFcfpp9Yxi/SOxq0BoPsJEm+BMFyVr7X/TkRIzqbSkRUPuNs0EATHcGyKjYT2wosJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532184; c=relaxed/simple;
	bh=/J/l2xndIYzwBh3TqfFRxLFB3IOJWbXnrMRVsBmO9EQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aDMt1SOnkY1GdNBKrMewMWBRk66QAX0u9M5JqQT8oIoxHEr5siceg0vdI9z5y5N0Rw1pxhL4VWscsb5cR1mUGl+wOlbtGeOWbZySY/a32ApZaoQ7F32rZ5mkpJzD/9cX7eR2OF5ebnez9SHQrltcbZGbwmwN/KMVKhg1lCDey8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IX+BSGAu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22401f4d35aso32181895ad.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 21:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742532180; x=1743136980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jaHeJ6qSwJ3u/x/VdsUMlK82s8mbA82yyCP5yyeo3Fc=;
        b=IX+BSGAuyK0faO/55sbuhOf5a6TMPLuOcU+ylFUZ5MObFrKbh/NGSgkYoGdnyxwJvU
         LVpSpPw/G4qLGhrSDXcl1sCkjaqGkiasx3V10nryp0ohrgpWKTN2UdwYkbzE6ntLbbfh
         PU+lRYeIaft0Inp7UFL5Mozo+xuA3LJr9FBvDJpZb63FMi3ac0vb0W7L0g+jqG5ckwyD
         NMyTnQWaVyXmA2ClNVbqeevl/1TyxKHJKQjLsPBAsvaD9NX1zHK2Qa26Tzw+7g30C0OV
         0zWH3nrblffaRxQZUP0HKUmFRIc6lJO6GsrmkzayA0p/VUXL7jGniXSeFLNBfJ2+sbhf
         xyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532180; x=1743136980;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaHeJ6qSwJ3u/x/VdsUMlK82s8mbA82yyCP5yyeo3Fc=;
        b=SuQ1QUOzP1RmWaXUTaE9zDfs/V/9iXrXIrn/zmnIHzVEZv2n7PoPl81VxyY40c7dQn
         cZczNWBWhbE2pGKhqFKIkd8vJX+ckfi+ZJYMy+hlbuHkVAbh/DvoCTURRaz36JjFYIKj
         F+ncdeMzkTGcBZcICDY16OJRcx8GN78u9yDw2wLV+qRbYr6rmiSVI6ydRkxt0N6ZXdC6
         FW0KofJdmhHm9WUgvDierjH24cRacDWxizHE+nm/OiwT8qBI25NommuTa04BeGVmrV8p
         J3JrAHo4eJAlcXl2GagBlRFtQTdQEfh8IZkNQI5NWqIt4z5DoTi2GI0begfxiMaM4fVZ
         0VAw==
X-Forwarded-Encrypted: i=1; AJvYcCXgsFzJhofsViBaCkSeERNGFyNVpqILPdgM35c6BSKsU/Rlcmm7O5+mp+PCTxxrkPwDi9rH0+entcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGN97sBo8L6ha0Qsa+fFZPcbjlofQcEmTwnCIoKFDysO2ctKAG
	vDiSt/bpcS5SpI28WcycVh6f+wBcybQ/9EM121k9ldMhPoBjDP4e2AcEDLCZ2g==
X-Gm-Gg: ASbGncufJt0eu66AbdFOWbL61wCaztC1LAsnzuby1+BpnsHp4KTKVzceWqGccKJA+aA
	4hR/RlnxlZfmwv6ylwEytkUBEB5bsxztNUENsg9BzpBZOh0ALIAza2mhv0HgCpr2VZH8FgYrAeQ
	HrlPOqvsnwAGsBhfTlq2b7HHj/JaP4BkAD0+9Aq7tMPxjTbjgC9Sd9yp0U+TsgLHen4o7CoVesX
	ZDBFXzDW+7CjkFpsk1NS5KdXJmFKnz53IU4T+1BA2QRH8ysBPvlIYDwXuO1Ev2y21XoI4T1Jusq
	funn35lIy/sOjxEZ7yhgkYqcAdkprNVaErYBXk4NJaGh
X-Google-Smtp-Source: AGHT+IFCZZBsBpT+JgPon/LLEbu72ysiHsPxVJfQnDNrm7RkPGl69Wa7QQ0PvDzg1cJp1vKd8UOSxQ==
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id d9443c01a7336-22780e38317mr26158175ad.51.1742532180528;
        Thu, 20 Mar 2025 21:43:00 -0700 (PDT)
Received: from ?IPv6:::1? ([2409:40f4:3109:f8b2:8000::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da38asm6929485ad.186.2025.03.20.21.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 21:43:00 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wei Fang <wei.fang@nxp.com>,
 devnull+manivannan.sadhasivam.linaro.org@kernel.org
CC: bartosz.golaszewski@linaro.org, bhelgaas@google.com, brgl@bgdev.pl,
 conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/5=5D_PCI/pwrctrl=3A_Skip_scanning_fo?=
 =?US-ASCII?Q?r_the_device_further_if_pwrctrl_device_is_created?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250321025940.2103854-1-wei.fang@nxp.com>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org> <20250321025940.2103854-1-wei.fang@nxp.com>
Message-ID: <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On March 21, 2025 8:29:40 AM GMT+05:30, Wei Fang <wei=2Efang@nxp=2Ecom> wr=
ote:
>@@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_=
bus *bus, int devfn)
> 	struct pci_dev *dev;
> 	u32 l;
>=20
>-	pci_pwrctrl_create_device(bus, devfn);
>+	/*
>+	 * Create pwrctrl device (if required) for the PCI device to handle the
>+	 * power state=2E If the pwrctrl device is created, then skip scanning
>+	 * further as the pwrctrl core will rescan the bus after powering on
>+	 * the device=2E
>+	 */
>+	if (pci_pwrctrl_create_device(bus, devfn))
>+		return NULL;
>
>Hi Manivannan,
>
>The current patch logic is that if the pcie device node is found to have
>the "xxx-supply" property, the scan will be skipped, and then the pwrctrl
>driver will rescan and enable the regulators=2E However, after merging th=
is
>patch, there is a problem on our platform=2E The =2Eprobe() of our device
>driver will not be called=2E The reason is that CONFIG_PCI_PWRCTL_SLOT is
>not enabled at all in our configuration file, and the compatible string
>of the device is also not added to the pwrctrl driver=2E

Hmm=2E So I guess the controller driver itself is enabling the supplies I =
believe (which I failed to spot)=2E May I know what platforms are affected?

> I think other
>platforms should also have similar problems, which undoubtedly make these
>platforms be unstable=2E This patch has been applied, and I am not famili=
ar
>with this=2E Can you fix this problem? I mean that those platforms that d=
o
>not use pwrctrl can avoid skipping the scan=2E

Sure=2E It makes sense to add a check to see if the pwrctrl driver is enab=
led or not=2E If it is not enabled, then the pwrctrl device creation could =
be skipped=2E I'll send a patch once I'm infront of my computer=2E

But in the long run, we would like to move all platforms to use pwrctrl in=
stead of fiddling the power supplies in the controller driver (well that wa=
s the motivation to introduce it in the first place)=2E

Once you share the platform details, I'll try to migrate it to use pwrctrl=
=2E Also, please note that we are going to enable pwrctrl in ARM64 defconfi=
g very soon=2E So I'll try to fix the affected platforms before that happen=
s=2E

- Mani

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

