Return-Path: <linux-pci+bounces-44688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50AD1BC5E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 01:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF360303437B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FEB4A3E;
	Wed, 14 Jan 2026 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QJfkPxMW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B17261D
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348908; cv=none; b=K9GpNgFOLpIhRZL/3q7cOC5474qrb0vCZ4kSePhGiSn8plmcTLKjJR3BvbyldJo93EDbXZ+A80ZO54C5LBC4SNsoIiHknncVo/vmJNxFWLpDvz590ZQTx1fMtayplJUXQkBZIw2aG8SzFqUb1a9npS2DVipWEBM54N+6+Kp8qPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348908; c=relaxed/simple;
	bh=Ho1BfWIWSaDoSB00bc3LEcJx7MORlE1Ev3jy7XSmMAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKPhWr6vDL+kWuXh1QmXhAvaqsb9S7SQVRQUouetx45F5oSbZFek/04ks4DQcOLcFmU/MquZ9GcxdRsN7fmNeG6imHQEUm/wowPX58Huc217fGg9oGpiyIvgIbLFNOCAIgd7XVfLNWTMshcm0GQ+7ANRqOUes/tPZ9RUI5Lv514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QJfkPxMW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A74243F7BA
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 00:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768348887;
	bh=Pzj6dhLLsRrNQ9CsAtWRjOyg4R38YdvId0cKXqUwPR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=QJfkPxMWW2k1zFOP8QPeohYqt8G/mOXzqMLZxq5LxCM465wDUS/1knJc8Q2JOMeTc
	 37voBiHUbquLQsCOMEadONbZREIe2WylBuI5cjg+KtQxc2u2VzOIzeFQLyepu5XltX
	 A2DQReWRRB0dYrOeEFODaYMfIoNtidLLPTFEHX67Bhh8/L5EcHkY5HRAfD+4givNQB
	 dLFw8WHF+AFlswAvcKaZy6cPYP9fmIcZM+VOvZjSfpN82VHgEiHRVRCMmqLD27Wu3F
	 TAt89jfx1lbbNXSuQfY4JEFLM4v9EF0J9RGBMB+zQn4NTJPKwNB01PIDAr0t3APSpS
	 +CE/4r2CzY8jB9HYGJnLGFY0j95454Vk/I7dqWh0QgS3owKKBaJ6O4XjPTKVmusPqU
	 TnSsN9TWzux0CMYWlYikwyR36PTPp4n50NvGTYnL1CNFul7Qxm5LZ0W/2qdoLR0prG
	 JMI8UP3sE48gOwncQyO4Hw85a5uSS90xwdlzhmDvRWZQD+wZ5eYHw3cSGc8akELluP
	 ERK1iLsLtD5Na3XO6wXctiaEq9A7Gwi55ZnkTL+VVQacGJC1pwPwQoXSX0lmkInOOF
	 CvcmTSzkpJsGRWBCRVwGsZtd3+ur3SS/elT4Vvw8x+o2vcW4gHQTnnqLdzQybeuzg4
	 cwpZ2ulO2wT0f3nC+eA2vQ6A=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6455711052dso12836934d50.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 16:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768348886; x=1768953686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzj6dhLLsRrNQ9CsAtWRjOyg4R38YdvId0cKXqUwPR4=;
        b=UTBgSjSqfxhKhB/5abBQsMcd8zCt1pHHhLscj0R/pP1Le5WotLW0IqQay0j/S1RfzQ
         4RuCDlrqMP+OEYju6LIW/YbBdFBKmgU3nvwPhprAHI3W55W32VmBJRjdPPDhpKNwUIYo
         xa/6lNMk39LYMv4J6wH71u6vpCbyOjxCv2Bsh0GQg2MgrsGr1gEnlyJ9K0aaOTFi4SdD
         Qx5b9bT6bD3Sf3NfRT6/1MI+ID2ylu9pRFXbqISzSDwqivD6qZ7m5YFGL384+eL9GAw8
         vbY4fm2Glb+0Xf+0QIKUIyB5E+0rhbFaHh/V1/InsE8dUQejJAj4kA2QNI3pl0D2LhtI
         YKXg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dl5Wn2vzOXPa/0bbzGO4tB9gf+tyarM+PeDt3QyWi0oYLPbOyPY16nNwJYlUaeVHYGJJ2oVqmus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC47PbnFm3Gws1DCexPUL3JgLpW3hnpvwzsYhSN/fD4Frrq8/d
	qS8xtOEbJcpIPj/dyphZhzWdv5QGHcqUpQNQ8+/q3KOCfFQOZMMcC6AHr4lQD7xCa1GgcLm32md
	dKZ4/M7jdfxYDsB10NRhbKPisit+tJmsPSdmAUHpXVipmhZfTKqxiJ5ZMZfowccVvoLK1d4KYCi
	8Fn+u+Z7Vdp9Jn0+i5e6xbzE7VVXj1AHL8vIOVPVNuYqzSMshAiFPj
X-Gm-Gg: AY/fxX70pyGf2j6nseSw4eN7kF4VofbqwTVvq6v0pzYX+Ih5WMOw7oXY4scMpzZ9qdR
	YmcBkzckc8d1jT09eB9WZ5xkVO8MNGV3JC994WB30WxXKQKLZ8rk5ri+QxG6PqDRNCFirNAJ9Bz
	kZ2BLp9H+0y0XMkc+gDf5QLFte0ujcL0Ih35y2gkQ5vYCdkXvOPILJ7qFMCTSogNiBiA==
X-Received: by 2002:a05:690e:1898:b0:63f:b366:98c9 with SMTP id 956f58d0204a3-64903b45c7fmr225270d50.46.1768348886453;
        Tue, 13 Jan 2026 16:01:26 -0800 (PST)
X-Received: by 2002:a05:690e:1898:b0:63f:b366:98c9 with SMTP id
 956f58d0204a3-64903b45c7fmr225240d50.46.1768348885879; Tue, 13 Jan 2026
 16:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113205626.127337-1-superm1@kernel.org>
In-Reply-To: <20260113205626.127337-1-superm1@kernel.org>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Wed, 14 Jan 2026 13:01:15 +1300
X-Gm-Features: AZwV_Qgut8vZ3V5IgeIQYdApt1JfiHCm5RNXfTMDO8UOCrtrVLZ9htkIDBsZiFg
Message-ID: <CAKAwkKsCLn4+jVLZWAuqEMzSaZFPYOoMMtbRsXRYYhQ6BOX4ng@mail.gmail.com>
Subject: Re: [PATCH] PCI: Enable Bus Master in pci_power_up()
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org, 
	kengyu@lexical.tw, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 09:56, Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> commit 4d4c10f763d78 ("PCI: Explicitly put devices into D0 when
> initializing") addressed the issue of devices not being explicitly
> initialized to D0 during system startup, resolving mismatches between
> firmware and OS states.
>
> However, this change affected devices lacking runtime PM, as noted in
> commit 907a7a2e5bf40 ("PCI/PM: Set up runtime PM even for devices without
> PCI PM").
>
> Matthew however reports that there is additional problems specifically on
> AWS NVME hardware that can't handle a kexec since these changes were
> introduced.
>
> During a kexec reboot ever since commit 4fc9bbf98fd66 ("PCI: Disable Bus
> Master only on kexec reboot") bus mastering will be turned off, and this
> is a different flow than is observed for shutdown/reboot.  The problem
> appears to be that because the device is actually in D0 during the
> startup routine, clearing bus mastering as part of pci_device_shutdown()
> leads to a mismatch during the next kernel boot.
>
> I'd hypothesize that the firmware on this platform normally sets bus
> mastering as part of startup and the difference in kexec behavior lead to
> an incongruity.
>
> Set bus mastering when the device powers up to fix the mismatch.
>
> Cc: kengyu@lexical.tw
> Reported-by: Matthew Ruffell <matthew.ruffell@canonical.com>
> Closes: https://lore.kernel.org/linux-pci/CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com/
> Fixes: 4d4c10f763d78 ("PCI: Explicitly put devices into D0 when initializing")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> NOTE:
> This could also be addressed by disabling the clearing of bus mastering across
> a kexec reboot if that is preferred.
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31f..c0c0b5c9bf838 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
>                 return -EIO;
>         }
>
> +       pci_set_master(dev);
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         if (PCI_POSSIBLE_ERROR(pmcsr)) {
>                 pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
> --
> 2.43.0
>

Tested on a AWS c5.metal system, with git-tag v6.19-rc5 and this patch applied.
Kexec works great, and the system comes up properly.

Thank you Mario.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

