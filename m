Return-Path: <linux-pci+bounces-21807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA4A3BDF4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 13:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE13B709D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624FC1D61BC;
	Wed, 19 Feb 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3WqKKWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B551DF24B;
	Wed, 19 Feb 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967784; cv=none; b=V6X8mUGiinEmAGKoi4+OorL3hFHZnwIdqWqvQFoMN0rwI5nnl3BAVVEvUrHfIxHa4IawlZUReU5sY2cKusWh8hidJ5H/hMcSP/WrIqKdAuCtcTFh+ifH+XUMfrAjScVjrgKfhYZaH7OCyFWpNoQpyOTYP2UP7nMYjdcTVIBQ00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967784; c=relaxed/simple;
	bh=wcPgPvt7xFuou44taFEPq4RZvM4AiyrEyzV2wScCqBE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XVAOtTqSYpMuCId2KLdZw/5y1zTaQ+y1eDWEkvS4ACxPmtjoPsbU6jsxtAgBI7Ii9g4Dr2lMMLJBGBfpSvkphcRe4VUjD+RJU9F+lJQP0Q/gWxskHszyUzLVnM7YhFlx0Ehy1ZfJDAVEJMtglCKwNtMofWhHs4Ibjkg3hmdt3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3WqKKWJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a04so70378611fa.2;
        Wed, 19 Feb 2025 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739967780; x=1740572580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=obLMw1YZNp4QVfdT8ixQobBxsvfZhlM96MKwlYaSHKo=;
        b=R3WqKKWJeoctFSUDse82CvF1qAS37S95aUUMKq054bdFfnMFOBL2sV36lIeI1VpKdB
         dPi2Y65m79rle/3C/v1Gxx0t2X83OnxegbVcN78UIra/KwJLyib5WasdJSzQMR4TrKsf
         HD4rgCWLG6uq260+GwpLFz/Me5UQzMexszzc2SlKXmJ0be5dpaKklumgY3aDNrA4i/kn
         wIH40FJSZKYZifxpU7wzo/UOk8erFu5Svn+PPg49hVE/24iSGfRoaS5YcQQOEK3c3Y5O
         DVzgtnHd00Ao8cY97D+3K6iejykR+q9q1V7RRYHZZ+ysool/oOeeHdIsoZtfmlCBRc7O
         lPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967780; x=1740572580;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obLMw1YZNp4QVfdT8ixQobBxsvfZhlM96MKwlYaSHKo=;
        b=Pyix+s8te+7ZqbvGHl6Ejj721q7UAdiLKhL4b+SNOH4DdIcaNpP2+zGG3UVfOukyd7
         2WaPd5ikYnkGeklI7R7ATPmjtdna6X9CBmd75st90BAw5tCTH1k0VAa6sGnQg7EchW7q
         L8x4rnqD6OUB9gsADg8/5nuJrmS0QVZBnR/+WfsSv/K7cqCkjr4iDF/vAUxVurd/b6cN
         sqc0FNmKJxtfTQJ/V4IMB1jidW0an2qrRqFc1PIu7COUNPEEK9SlUBSxVdfUro+fKsB7
         iHifr8/C2hPljAc87QvbnuJSkV2TXDrCaoieJZc6zRyys6gSrGMEZIzYMU663eXU+LnL
         KoAA==
X-Gm-Message-State: AOJu0Yy8cz1CNweRU8yIYnXrW/w7QZnKDAWNS4jtJR8sP5zZ7gJPCkKf
	nuvnZhFYKfs1556nqVGjvrKX9oaSuAvUjr7Va9BLXD4i8MsAegpX+qhaIPTwdXm80NJ4X0Uiblq
	kFeMnLCU8fTDjHfxXmD1PtYZv6oUWcBM=
X-Gm-Gg: ASbGncsW1KXsFhvp1R4t/AYNBlEIbsh5fKsHS+RDqllS4H9hfAre0qiad1ba7lDV2iK
	AzmzNOMgE4RZw1PrjC9QuHOEOoQ1/pThrxTtm0qd1pdf73ZYyI4zIMQoLzzR6K7IveykIaPRS
X-Google-Smtp-Source: AGHT+IEbloDRf96LKl3Shyqgq2lYsmT2UDmjR+IfoRJZKQQMG4b3p2NeKyCpXjPzTYxNTzZdI2bk97P5PjxERg/gE9E=
X-Received: by 2002:a05:6512:3e23:b0:546:3136:f03d with SMTP id
 2adb3069b0e04-5463136f074mr878474e87.35.1739967779329; Wed, 19 Feb 2025
 04:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Wed, 19 Feb 2025 17:52:47 +0530
X-Gm-Features: AWEUYZkFcgq0ZIxP1LRBGTMevJO9cYiAMOwpXrpvdc1uwSNH49ITMWw-snaxU-Q
Message-ID: <CAMciSVU4vv7=WjVUhuP3PJHdpnYqrgMPCmz-HnijEbhyxk54eQ@mail.gmail.com>
Subject: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, 
	Naveen Kumar P <naveenkumar.parna@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am writing to seek assistance with an issue we are experiencing with
a PCIe device (PLDA Device 5555) connected through PCI Express Root
Port 1 to the host bridge.

We have observed that after booting the system, the Base Address
Register (BAR0) memory of this device gets reset to 0x0 after
approximately one hour or more (the timing is inconsistent). This was
verified using the lspci output and the setpci -s 01:00.0
BASE_ADDRESS_0 command.

To diagnose the issue, we checked the dmesg log, but it did not
provide any relevant information. I then enabled dynamic debugging for
the PCI subsystem (drivers/pci/*) and noticed the following messages
related ACPI hotplug in the dmesg log:

[    0.465144] pci 0000:01:00.0: reg 0x10: [mem 0xb0400000-0xb07fffff]
...
[ 6710.000355] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
[ 7916.250868] perf: interrupt took too long (4072 > 3601), lowering
kernel.perf_event_max_sample_rate to 49000
[ 7984.719647] perf: interrupt took too long (5378 > 5090), lowering
kernel.perf_event_max_sample_rate to 37000
[11051.409115] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
[11755.388727] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
[12223.885715] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
[14303.465636] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
After these messages appear, reading the device BAR memory results in
0x0 instead of the expected value.

I would like to understand the following:

1. What could be causing these hotplug_event debug messages?
2. Why does this result in the BAR memory being reset?
3. How can we resolve this issue?

I have verified that the issue occurs even without loading the driver
for the PLDA Device 5555, so it does not appear to be related to the
device driver.

Any help or guidance on debugging this issue would be greatly appreciated.

Thank you for your assistance.

Best regards,
Naveen

