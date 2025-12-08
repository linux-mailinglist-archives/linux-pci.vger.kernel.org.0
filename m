Return-Path: <linux-pci+bounces-42797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A85CAE209
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 21:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF95301AD3F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF402FD1B5;
	Mon,  8 Dec 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SEaZZaY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214A22D4DC;
	Mon,  8 Dec 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224117; cv=none; b=mLUNcQH/LqSQZS8Q/zNRRvL1wVp2MyhdBepxG4LRSxccf8ii6lSRqy7ANLAMbal+rhFIRHZpMnQ3acNjncgWMi5398quVAWkfRPEOm/XPkjli2y6eDPQrd3LLPdYtKcSyea+MhF48+OFARDkAYu8G/1HkWh0FqgzU7aOlLb0rK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224117; c=relaxed/simple;
	bh=oCskKbOkupWufgytaRWMSAKqzYH72k5D4NHHZcaN0lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n44q/XigWpY2Mnz+2O6k2+q3Mk9WH2oG6OT4SAXe+6EC2BjAH+F0xeP5vcGiQtVfka7al+NKaHCaBXWwPJweujIud+BP1oUOuC6vGmOOMaRNC22MbhSyoSrlcJyHRbQ7WwCTogiVekeCSY+kYP7yopEnWM+lJ74OeLbV3Y83OFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SEaZZaY/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765224109; x=1765828909; i=w_armin@gmx.de;
	bh=WYBhOdzvWmbOptA2wuOHH1P1xCu+i75Wa13+llk0biU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SEaZZaY/9Q+6rBdM0OErtf7rkp1vOkcnSSOjnMjAMSmMpP7T69tzNau5vhsfQA0H
	 fFTod+GJrdYQlhTHKzhWbl2xsgjKzPW5izosD+LbA6axxIPiIuv6LK+MpfKtY8RGl
	 4xDSxnsnqAFC2upMK8nMl0OJvNMalnpiWB1ImGJmJCIULNM9KGOVwhynkMLuXW4Tx
	 Pweo0BogDbF2rI8+CuU7uj/P8kW6F3ZWv6CA9ozg3nljKE+w9IkmM2pJJflYaV5fL
	 C+DJSak0T4w47ygn7HBf/5wRwaWz0VDqGcYe91bVVJZRzpjERgeDXxqMxCUM9VeEA
	 3EM3P/DZ6g3ie3NUYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1vdizM34EC-00LrCY; Mon, 08
 Dec 2025 21:01:48 +0100
Message-ID: <ab8b770c-08e9-4cf6-bd4f-f36c951fda4c@gmx.de>
Date: Mon, 8 Dec 2025 21:01:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] PCI: ACPI: PM: Rework root bus wakeup notification
 setup and wakeup source registration
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <2395536.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2395536.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+Q3rm7jNUG4fJgunNeiO1vnGELSbXsYXNR0ufi5FZULDaD7POzu
 f0y05jVRPXLQDfEZbuL1xalg+uiRdZ7ufQSIIDsfWueUPdyxGf6FY1mHzO8vb/n2n51XqkO
 9QjqxdgiYCdxofoXz1ilRTWrEUtHTMNuEnstfpS1nvEpKYEOkbL2PgdXYi86ZD2qMIdsneH
 Av8tYouPqAewM7IV76LVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tcTCUhaWPHM=;j9oJbCD8lQfrnVvcGCrzDqFG95H
 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

Am 08.12.25 um 13:09 schrieb Rafael J. Wysocki:

> Hi All,
>
> Patch [1/2] updates the registration of PCI root bus wakeup notification setup
> in order to simplify code in pci_acpi_wake_bus() and to prepare for the other
> change.  This is not expected to affect functionality.
>
> Patch [2/2] modifies the ACPI PM notifier registration to add wakeup sources
> under devices that are going to be affected by wakeup handling instead of
> registering them under ACPI companions of those devices (rationale explained
> in the patch changelog).  This will change the sysfs layout (wakeup source
> devices associated with PCI wakeup are now going to appear under PCI devices
> and the host bridge device), but it is not expected to affect user space
> adversely.
>
> Thanks!

I tested both patches, and the sysfs layout changes as expected:

$ readlink /sys/class/wakeup/wakeup*/device
../../../device:00
../../../device:1a
../../../device:1f
../../../device:20
../../../0000:00:08.1
../../../device:36
../../../device:31
../../../device:32
../../../device:3c
../../../0000:01:00.0
../../../device:3d
../../../PNP0C02:00
../../../0000:02:00.0
../../../device:3e
../../../device:3f
../../../device:46
../../../0000:04:00.0
../../../device:47
../../../0000:05:00.0
../../../device:57
../../../0000:05:08.0
../../../device:59
../../../device:01
../../../0000:05:09.0
../../../device:5b
../../../0000:05:0a.0
../../../device:5d
../../../0000:05:0b.0
../../../device:5f
../../../0000:05:0c.0
../../../device:74
../../../0000:05:0d.0
../../../device:5a
../../../device:3a
../../../device:5c
../../../device:60
../../../device:75
../../../LNXVIDEO:00
../../../device:22
../../../PNP0C02:02
../../../device:25
../../../device:2b
../../../device:24
../../../device:37
../../../0000:00:01.1
../../../PNP0A08:00
../../../LNXPWRBN:00
../../../AMDI0010:00
../../../AMDI0030:00
../../../00:02
../../../alarmtimer.0.auto
../../../PNP0C0C:00
../../../0000:0b:00.0
../../../AMDIF031:00
../../../PNP0C14:00
../../../device:0a
../../../PNP0C14:01
../../../PNP0C14:02
../../../PNP0C14:03
../../../0000:0e:00.3
../../../0000:0e:00.4
../../../0000:0f:00.0
../../../5-2
../../../1-5.3
../../hidpp_battery_0
../../../device:44
../../../0000:00:02.1
../../../device:76
../../../device:0b

turns into:

$ readlink /sys/class/wakeup/wakeup*/device
../../../0000:00:00.0
../../../0000:00:04.0
../../../0000:00:08.0
../../../0000:00:08.1
../../../0000:00:08.1
../../../0000:00:08.3
../../../0000:00:14.0
../../../0000:00:14.3
../../../0000:01:00.0
../../../0000:01:00.0
../../../0000:02:00.0
../../../0000:00:00.2
../../../0000:02:00.0
../../../0000:03:00.0
../../../0000:03:00.1
../../../0000:04:00.0
../../../0000:04:00.0
../../../0000:05:00.0
../../../0000:05:00.0
../../../0000:05:08.0
../../../0000:05:08.0
../../../0000:05:09.0
../../../0000:00:01.0
../../../0000:05:09.0
../../../0000:05:0a.0
../../../0000:05:0a.0
../../../0000:05:0b.0
../../../0000:05:0b.0
../../../0000:05:0c.0
../../../0000:05:0c.0
../../../0000:05:0d.0
../../../0000:05:0d.0
../../../0000:08:00.0
../../../0000:00:01.1
../../../0000:09:00.0
../../../0000:0b:00.0
../../../0000:0c:00.0
../../../0000:0e:00.0
../../../0000:0e:00.1
../../../0000:0e:00.2
../../../0000:0e:00.3
../../../0000:0e:00.4
../../../0000:0e:00.6
../../../0000:0f:00.0
../../../0000:00:01.1
../../../pci0000:00
../../../LNXPWRBN:00
../../../AMDI0010:00
../../../AMDI0030:00
../../../00:02
../../../alarmtimer.0.auto
../../../PNP0C0C:00
../../../0000:0b:00.0
../../../AMDIF031:00
../../../PNP0C14:00
../../../0000:00:02.0
../../../PNP0C14:01
../../../PNP0C14:02
../../../PNP0C14:03
../../../0000:0e:00.3
../../../0000:0e:00.4
../../../0000:0f:00.0
../../../5-2
../../../1-5.3
../../hidpp_battery_0
../../../0000:00:02.1
../../../0000:00:02.1
../../../0000:00:02.2
../../../0000:00:03.0

The remaining ACPI devices are likely caused by device drivers based upon struct acpi_driver.
I was unable to test the wakeup itself since suspend is currently broken due to issues with
cpuidle, but i suspect that this has nothing to do with the patch series.

So for the whole series:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>


