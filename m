Return-Path: <linux-pci+bounces-42674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A57CA5FBA
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 04:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4253231D57FA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81D2FF65B;
	Fri,  5 Dec 2025 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Gjg7wl7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C32FF157
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904025; cv=none; b=tNS/jILgDYO26n5HW18G1dPNUBVyHnmeAsUEHONDST08/Dq4X6ICPgiR2NTU5r4yOGEyc4KUYn3waCe/JS4Un4ivAFS2Dj22HzviuE3KEJVpqrwTIk+HLiPbSD4ThLoXMtV+mAZC4ZHrIGeq0GVHz6KgEGhOhxfSGDh2iXaZ44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904025; c=relaxed/simple;
	bh=J7qK93jDCmDdXBYLygNUIhlDBdfdCb2E7GYVrf0pphA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfDzkPQnBVgdUvHimUQC+wJ6FiXd7O6LRhfF0g/H8gn/gWftY/H5GcSwe/GIkkSIEPG5ZBXhR0PaDKUh6NSUubt0Y+41a5GAiwwxBd9CeyBobOVQXeFcOQfAzv6XbfsP509hfbnrJ4jOZD9EZcOmPER70LPlR5cVndcocEapmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Gjg7wl7H; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E4C5403F1
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 03:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764904019;
	bh=voWGcpl38dsCqkHvQP+Zw8fJD5i1k81SKpFBAP9jrao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Gjg7wl7HmJJPYoHahuXiuBinLqAPmdpw1Dtz66ILhz076p5QJqk0Xg6EziqsG9iT5
	 ACPs2wAyYU2mhcKjnT77gRD2dos9yN0BRHYHq69O69tNP6sy0dK1GcQMt2lPHtW/Uw
	 eVd6ZS31t/uu6Cygux8MM0OxG+yIL4xRobFJTzCzgtuamiMdrm0qSsrmCaxRzVGKCe
	 v7IYkZxqm5gW8WrbJtOXSQdC0NLErzYbyIeLc2+RxbHt9OFWdl8lZU35/aBTzN9UWZ
	 Ne4xKVyNcQjBVDlIWQcNRre7bXQCfV4dAhA6gJLFDB8YPdim87fCubBNd3c4T06Wj0
	 6iejDdQZJJBESuv2sAHjJaeC7Q6OFncoqzLgPvyLwR+d2da3A++KTb4llG3RMH1GBC
	 u7vIDmPLDuAv6+HlBczNnJwBmzRAO2piU+V1eM2x/rgn+KXcCbu+PGUX00LMUPXJ09
	 SJS6+UipqyVk9/DCxiZZoGhmh1y8so2m7TfPUU3lHnrOmLQM9mZJTEIxZW8ppD9N6n
	 O6aXZgPXfX6Vz1jXAfPtZEAb5R/A5QTzgD2sCl0/v1yyU54VUzlVRMFB0hLz/pda8P
	 5mp1zznb5wqJ9Z/nICzCeqMUHK1jbLS0lAjVQA8sGwHn0rA6TcOF67DcqJzYUedoHw
	 kfHzL3Tj9hEFJiu9tRq0BDEg=
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-787c609417aso19779427b3.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 19:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764904018; x=1765508818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voWGcpl38dsCqkHvQP+Zw8fJD5i1k81SKpFBAP9jrao=;
        b=nsklfuFzkjcQkUHIOq3sF5gU/VD0vow2B5yXx2DirFy6lklW9KmTgawFGMP7DYCQi+
         pCrQ+Ayq8P84OoSTpUtX792ec/HIAO+vuBkpJlf4xh5nWLD4JN/ZNgm5BSxWxAmxCOOE
         xoTUJJuuHbUBB/IUDLLFnQyNMFxk5yugv2zRvugW/WqO5mxwR7HijEB+s9M2cndogzQW
         wN5eAfqSO03itrsZRGfATe46px7dLa0igtw/G7BvzqFcMbE/ftw+np7P/vh8cMSyaoIC
         Gk2ob3zfDBDn5KAvP2JjhvSe/BgiZOpH1sM6HKGWQoWn2I/yQ+X0kirAL0phJYvN+CNS
         Dqcw==
X-Forwarded-Encrypted: i=1; AJvYcCUs5J1H803Uq3FhK+OTnWNzdOGGVectxg9AhqTagGVa9RKKpCwuPqHfmskKDPaQkpjDAaH5d0CLs/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQa40pLVUb1vHQWJllmZbVnrrwWVWTRQE0QhAt261pVxzs/v6
	GPP0OqDnxHUW1KSCOjqb796g+UUCbdnCIQCGji4RVsL9RES6gKDudoOvm38cezH7s4vYjtBJmt2
	s4wtYqnuncYvgCptRmbiOUUKgQftHi+ga0BIrncWgKyee2zdGTS0YenePFW25esw1dY9rQ+laz8
	8dUULBO4adlkdXia3p4t+3ZfhAwgAG8qWZfbDNuLdG2KAZrEjnE+rL
X-Gm-Gg: ASbGnct4VVO7c7ItBLmmKykyZIBQigxoS1JaRQszjdP+t9bJEF2fCqPJTTFg+fr4OxM
	xmJoosqzDVJzVD/Br2fUIESL2ta50Xygsj4XMX8A+XKF5Ef2PA4vUpx5+R9AbYuWuZGXiAf5/UU
	DrrzVQzPMOtcKIr1MoSr+Bqv4YOTAx2K9Sh8a0YXrBxAULvqexBTDwc39hzDsNtGLMHw==
X-Received: by 2002:a05:690c:480b:b0:786:6f81:eb21 with SMTP id 00721157ae682-78c0bf046c2mr66792717b3.21.1764904018359;
        Thu, 04 Dec 2025 19:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9EMu7VwQTY4Fo45m8IAVuRY6N37i00dwV+NFmi4HcpZP9Y69cGAPOJb5mmpo6wElquXthzHHBkI9o9Z8wVs4=
X-Received: by 2002:a05:690c:480b:b0:786:6f81:eb21 with SMTP id
 00721157ae682-78c0bf046c2mr66792567b3.21.1764904017872; Thu, 04 Dec 2025
 19:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com> <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
 <222da706-19c5-485c-be90-2ebda20c1142@amd.com>
In-Reply-To: <222da706-19c5-485c-be90-2ebda20c1142@amd.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Fri, 5 Dec 2025 16:06:47 +1300
X-Gm-Features: AWmQ_bl0V-YaZswPxAV3rPSoJEDjMQw6Ypn5slmhHW_GWI6up1fBUTtnHC-fiyU
Message-ID: <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mario,

Again, thank you for your prompt response.

> That's at least what it seems like.  And I guess trying to set D0
> without bus mastering enabling is causing a problem.
>
> Could you try adding a pci_set_master() call to pci_power_up()?  This is
> what I have in mind (only compile tested):
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..68661e333032 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
>                  return -EIO;
>          }
>
> +       pci_set_master(dev);
>          pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>          if (PCI_POSSIBLE_ERROR(pmcsr)) {
>                  pci_err(dev, "Unable to change power state from %s to
> D0, device inaccessible\n",

I built a test kernel, using the very same git hash as yesterday,
51ab33fc0a8bef9454849371ef897a1241911b37
with this pci_set_master(dev) applied, and yes, kexec succeeds and the
system boots normally.

Would you do a global pci_set_master(dev) like this, or would you gate
it behind a check to see if the system is being kexec'd?

I then patched pci_device_shutdown() with the below patch to capture
state information of each NVME device, and then halted the system.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..ac5dc8a466d2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -510,6 +510,8 @@ static void pci_device_shutdown(struct device *dev)
        if (drv && drv->shutdown)
                drv->shutdown(pci_dev);

+       printk(KERN_WARNING "mruffell: vendor: %x, device: %x, state:
%x\n", pci_dev->vendor, pci_dev->device, pci_dev->current_state);
+       pci_warn(pci_dev, "mruffell: Current PCI device.");
        /*
         * If this is a kexec reboot, turn off Bus Master bit on the
         * device to tell it to not continue to do DMA. Don't touch

Full log in pastebin: https://paste.ubuntu.com/p/QBGVbNh2Bs/

Everything was in state 0 / PCI_D0.

The nvme device itself:

[  295.721701] mruffell: vendor: 1d0f, device: 61, state: 0
[  295.740647] nvme 0000:90:00.0: mruffell: Current PCI device.

This would indeed pass the check in pci_device_shutdown, and clear the
bus master bit.

     if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
             pci_clear_master(pci_dev);

I then reverted "907a7a2 PCI/PM: Set up runtime PM even for devices
without PCI PM" and
"4d4c10f PCI: Explicitly put devices into D0 when initializing"  and
then halted the system again:

Full log in pastebin: https://paste.ubuntu.com/p/VRrJHjmnxN/

The nvme was still in state 0 / PCI_D0:


> I have a relatively ignorant question.  Can you reproduce with kdump and
> a crash too?
>
> I don't actually know if you configure kdump and then crash the kernel
> (say magic sys-rq key), does pci_device_shutdown() get called in order
> to do the kexec?  Or because the kernel is already in a crash state is
> there just a jump into the crash kernel image location?

I will

