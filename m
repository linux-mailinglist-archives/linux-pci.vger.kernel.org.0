Return-Path: <linux-pci+bounces-17378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD19D9FE0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 01:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0832D165A92
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 00:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF12907;
	Wed, 27 Nov 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFeOFgyH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6DA23
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665743; cv=none; b=LHnNaygEFLvE5Ze1/AREfHbaYqgozA3A77sxNkTNkBfUYBBq1QK728bGx6docwshY001v9idufw/eAuC9GxHtOLUUw6TrEQZRgMWO3VQVhiY+FhOdNgBAdv3l3y0kDVCclRYijM7AIjzh9DDzg6i5MIzXcqUVKE3dFoBwJdw21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665743; c=relaxed/simple;
	bh=5EfFIpjBL6GQO86b+MIHhdpr651u2PRiWcke8LHcLkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfy8SfebKAr8VtzBTgD4STgPAeR9RRbzrBAtdUo78iXqDITCkO/X55yhSMGfQtGaBitdaBEJuSI42T2+/+gdLxwqn7RSgKDr87eN50K7IvF4uRXusYmgDszZZ3teEWDya8d0bFVx5290ixg5lYJgO3joorNY8fCV9VQQ8t8EUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFeOFgyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732665740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JHGiTJF9sqdLs+kPtAMc0toUPm/G8N7ZOqBvI+OpZg=;
	b=CFeOFgyHU8VwBIJ/tlDSBHjJ/yDhpkk+ih0KmLZ+Ku/fZpt4JHy98/QMb815piRDC7p7to
	lYW2AI+AAXApt6GG+Q/0RraVcBG1mHLWrzLrC4FhsNXDS/A2Ibd2WO2z534gorZ2RI/DLC
	sBcHEgZtlt9QLVVSMlFinRx+pLsL3RQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-CFoxF1IwOBermTQl5dJN5w-1; Tue, 26 Nov 2024 19:02:17 -0500
X-MC-Unique: CFoxF1IwOBermTQl5dJN5w-1
X-Mimecast-MFC-AGG-ID: CFoxF1IwOBermTQl5dJN5w
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8418358cca3so8020939f.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 16:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732665737; x=1733270537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JHGiTJF9sqdLs+kPtAMc0toUPm/G8N7ZOqBvI+OpZg=;
        b=TAa3j1GSj+67G0yBBACdyPET95D95zvUsN6xTardgDuPfNyRdKr0KBkTGlbhJLZXkA
         9TOIyNt+HFYf4mBzx7Fggrz6PMqCBhgCUObSa5B6C3LKCPwBmx4jLWmz/DbGh25EZVk7
         Yawm1SRQ1o+ZVLllkQ2cJm2gv9XC3yw5OiWSX1XGX4moofuNltlFPzZQNAHNeNdg/IIH
         vhvkoyAenUJW0GIDyADt5VqNOB4U16O4GPUTLs8xa/PkS+HImP0ncm8pP0+XhanC3Hw3
         p6RbhL+p7Au6jNQryA34Ky/9R95OgspQOSZvXOPkfuKYhe9/Qq//Yyb0fH+yB9QM0ymZ
         5JFQ==
X-Gm-Message-State: AOJu0Yx//A3MoPUDaPmrjLgJ1gLjH70wEzYXUuHJKyZpvS1sYm8ysYKG
	TqDarzP0HB5nUa72SM52DNKYOhp7otGF3WB5u8Zuio0II3YzlH4Khs/DI5s7uoeodKtNxUld337
	XilHjcTl4pqkP6/JZ7vc9BsmkmACr9U6Kg26uJ8TflECDQTpmDfTWWYYeCg==
X-Gm-Gg: ASbGncsR8Ng0+64+cVPdszgyyTmcvGmBvu2MoOyJCaTyrXwKvBZc8RZZZtIc5zKCr3/
	n9eQqAaCU6kb5TIs8PplLFVLhONr4iB7q1p4WCy4XYl1E753YWVGvzoHwlkjlbwgxd8BWtxgL5o
	5tTSYqXytVnUCX/tNejALIlqI/sUgpehXO0cGXMLxQcbFPcXvS/aJKAihz218tVaqRHrl3np3Fy
	23F5iikeZpAcA4bblQbmHYSTcTc8Iwdqzn8G/Rxu8KDfQ1ex7EM7w==
X-Received: by 2002:a05:6e02:1a81:b0:3a7:bceb:d577 with SMTP id e9e14a558f8ab-3a7c55fac98mr2947385ab.7.1732665736844;
        Tue, 26 Nov 2024 16:02:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYcPCFogrst+wIj2d4EYn1vrebbcMVf5/QFfqIkSnG9CMYAPyaoNMrC0j31rSnTgHU/SC3vQ==
X-Received: by 2002:a05:6e02:1a81:b0:3a7:bceb:d577 with SMTP id e9e14a558f8ab-3a7c55fac98mr2947225ab.7.1732665736316;
        Tue, 26 Nov 2024 16:02:16 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e210b73ff2sm808136173.123.2024.11.26.16.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:02:15 -0800 (PST)
Date: Tue, 26 Nov 2024 17:02:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241126170214.5717003f.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
	<20241126154145.638dba46.alex.williamson@redhat.com>
	<CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 17:08:07 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> > If the slowness is confined to the guest kernel boot, can you share the log of that boot with timestamps?  
> 
> It is confined to the guest. On hand, I have this log section from a
> past guest boot:
> 
> [    3.965790] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
> conventional PCI endpoint
> [    3.967800] pci 0000:00:01.0: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [    3.974590] pci 0000:00:01.0: BAR 0 [mem 0x81c8e000-0x81c8efff]
> [    3.980780] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    3.984128] pci 0000:00:01.0:   bridge window [mem 0x81a00000-0x81bfffff]
> [    3.985915] pci 0000:00:01.0:   bridge window [mem
> 0x38e800000000-0x38efffffffff 64bit pref]
> [    3.988884] pci 0000:00:01.1: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [    3.992771] pci 0000:00:01.1: BAR 0 [mem 0x81c8d000-0x81c8dfff]
> [    3.999361] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    4.000276] pci 0000:00:01.1:   bridge window [mem 0x81800000-0x819fffff]
> [    4.001849] pci 0000:00:01.1:   bridge window [mem
> 0x38f000000000-0x38f7ffffffff 64bit pref]
> [    4.009442] pci 0000:00:01.2: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [    4.012772] pci 0000:00:01.2: BAR 0 [mem 0x81c8c000-0x81c8cfff]
> [    4.016781] pci 0000:00:01.2: PCI bridge to [bus 03]
> [    4.020299] pci 0000:00:01.2:   bridge window [mem 0x81600000-0x817fffff]
> [    4.021780] pci 0000:00:01.2:   bridge window [mem
> 0x38f800000000-0x38ffffffffff 64bit pref]
> [    4.024680] pci 0000:00:01.3: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [    4.027299] pci 0000:00:01.3: BAR 0 [mem 0x81c8b000-0x81c8bfff]
> [    4.036781] pci 0000:00:01.3: PCI bridge to [bus 04]
> [    4.037646] pci 0000:00:01.3:   bridge window [mem 0x81400000-0x815fffff]
> [    4.040806] pci 0000:00:01.3:   bridge window [mem
> 0x390000000000-0x3907ffffffff 64bit pref]
> [    4.046317] pci 0000:00:01.4: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [    4.049673] pci 0000:00:01.4: BAR 0 [mem 0x81c8a000-0x81c8afff]
> [    4.053625] pci 0000:00:01.4: PCI bridge to [bus 05]
> [    4.056830] pci 0000:00:01.4:   bridge window [mem 0x81200000-0x813fffff]
> [    4.059022] pci 0000:00:01.4:   bridge window [mem
> 0x390800000000-0x390fffffffff 64bit pref]
> [    4.061614] pci 0000:00:01.5: [1b36:000c] type 01 class 0x060400
> PCIe Root Port

The above line is printed from pci_setup_device() which calls

pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);

That alone calls __pci_read_base() three separate times, each time
disabling and re-enabling decode on the bridge.

> [    7.616784] pci 0000:00:01.5: BAR 0 [mem 0x81c89000-0x81c89fff]

I think this is printed at the end of the first call to
__pci_read_base(), so nearly 3.5s once through.  Twice again for about
another 7s puts us at 14+s below.

> [   14.140789] pci 0000:00:01.5: PCI bridge to [bus 06]
> [   14.142240] pci 0000:00:01.5:   bridge window [mem 0x81000000-0x811fffff]
> [   17.432805] pci 0000:00:01.5:   bridge window [mem
> 0x380000000000-0x382002ffffff 64bit pref]

I think the prefetchable window on the bridge gets disabled and
re-enabled here, that's another.

So that's 4 times per calling pci_setup_device() on the bridge that
we're re-mapping the device's 128G BAR back into the VM address space,
that's 12-14s, times 4 GPUs and we're already approaching a minute.

> [   17.436775] pci 0000:00:01.6: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   20.656786] pci 0000:00:01.6: BAR 0 [mem 0x81c88000-0x81c88fff]
> [   27.044792] pci 0000:00:01.6: PCI bridge to [bus 07]
> [   27.048775] pci 0000:00:01.6:   bridge window [mem 0x80e00000-0x80ffffff]
> [   30.240811] pci 0000:00:01.6:   bridge window [mem
> 0x384000000000-0x386002ffffff 64bit pref]
> [   30.244777] pci 0000:00:01.7: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   33.676789] pci 0000:00:01.7: BAR 0 [mem 0x81c87000-0x81c87fff]
> [   40.524791] pci 0000:00:01.7: PCI bridge to [bus 08]
> [   40.526249] pci 0000:00:01.7:   bridge window [mem 0x80c00000-0x80dfffff]
> [   43.876807] pci 0000:00:01.7:   bridge window [mem
> 0x388000000000-0x38a002ffffff 64bit pref]
> [   43.880776] pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   47.184786] pci 0000:00:02.0: BAR 0 [mem 0x81c86000-0x81c86fff]
> [   53.796794] pci 0000:00:02.0: PCI bridge to [bus 09]
> [   53.798349] pci 0000:00:02.0:   bridge window [mem 0x80a00000-0x80bfffff]
> [   57.104809] pci 0000:00:02.0:   bridge window [mem
> 0x38c000000000-0x38e002ffffff 64bit pref]
> [   57.109300] pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   57.112270] pci 0000:00:02.1: BAR 0 [mem 0x81c85000-0x81c85fff]
> [   57.115960] pci 0000:00:02.1: PCI bridge to [bus 0a]
> [   57.116535] pci 0000:00:02.1:   bridge window [mem 0x80800000-0x809fffff]
> [   57.121443] pci 0000:00:02.1:   bridge window [mem
> 0x391000000000-0x3917ffffffff 64bit pref]
> [   57.123113] pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   57.125263] pci 0000:00:02.2: BAR 0 [mem 0x81c84000-0x81c84fff]
> [   57.128168] pci 0000:00:02.2: PCI bridge to [bus 0b]
> [   57.128713] pci 0000:00:02.2:   bridge window [mem 0x80600000-0x807fffff]
> [   57.129619] pci 0000:00:02.2:   bridge window [mem
> 0x391800000000-0x391fffffffff 64bit pref]
> [   57.133671] pci 0000:00:02.3: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   57.135884] pci 0000:00:02.3: BAR 0 [mem 0x81c83000-0x81c83fff]
> [   57.138198] pci 0000:00:02.3: PCI bridge to [bus 0c]
> [   57.138749] pci 0000:00:02.3:   bridge window [mem 0x80400000-0x805fffff]
> [   57.139975] pci 0000:00:02.3:   bridge window [mem
> 0x392000000000-0x3927ffffffff 64bit pref]
> [   57.141558] pci 0000:00:02.4: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   57.146325] pci 0000:00:02.4: BAR 0 [mem 0x81c82000-0x81c82fff]
> [   57.148744] pci 0000:00:02.4: PCI bridge to [bus 0d]
> [   57.148795] pci 0000:00:02.4:   bridge window [mem 0x80200000-0x803fffff]
> [   57.149992] pci 0000:00:02.4:   bridge window [mem
> 0x392800000000-0x392fffffffff 64bit pref]
> [   57.151660] pci 0000:00:02.5: [1b36:000c] type 01 class 0x060400
> PCIe Root Port
> [   57.157365] pci 0000:00:02.5: BAR 0 [mem 0x81c81000-0x81c81fff]
> [   57.159859] pci 0000:00:02.5: PCI bridge to [bus 0e]
> [   57.160374] pci 0000:00:02.5:   bridge window [mem 0x80000000-0x801fffff]
> [   57.161268] pci 0000:00:02.5:   bridge window [mem
> 0x393000000000-0x3937ffffffff 64bit pref]
> [   57.176995] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
> conventional PCI endpoint
> [   57.178146] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by
> ICH6 ACPI/GPIO/TCO
> [   57.179162] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
> conventional PCI endpoint
> [   57.186370] pci 0000:00:1f.2: BAR 4 [io  0x6040-0x605f]
> [   57.187830] pci 0000:00:1f.2: BAR 5 [mem 0x81c80000-0x81c80fff]
> [   57.189464] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
> conventional PCI endpoint
> [   57.197117] pci 0000:00:1f.3: BAR 4 [io  0x6000-0x603f]
> [   57.199155] acpiphp: Slot [0] registered
> [   57.199695] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
> PCIe Endpoint
> [   57.202062] pci 0000:01:00.0: BAR 1 [mem 0x81a00000-0x81a00fff]
> [   57.205640] pci 0000:01:00.0: BAR 4 [mem
> 0x38e800000000-0x38e800003fff 64bit pref]
> [   57.213753] pci 0000:01:00.0: ROM [mem 0xfff80000-0xffffffff pref]
> [   57.215477] pci 0000:00:01.0: PCI bridge to [bus 01]
> [   57.216661] acpiphp: Slot [0-2] registered
> [   57.216846] pci 0000:02:00.0: [1b36:000d] type 00 class 0x0c0330
> PCIe Endpoint
> [   57.218123] pci 0000:02:00.0: BAR 0 [mem 0x81800000-0x81803fff 64bit]
> [   57.221585] pci 0000:00:01.1: PCI bridge to [bus 02]
> [   57.225522] acpiphp: Slot [0-3] registered
> [   57.226056] pci 0000:03:00.0: [1af4:1043] type 00 class 0x078000
> PCIe Endpoint
> [   57.228576] pci 0000:03:00.0: BAR 1 [mem 0x81600000-0x81600fff]
> [   57.231435] pci 0000:03:00.0: BAR 4 [mem
> 0x38f800000000-0x38f800003fff 64bit pref]
> [   57.236846] pci 0000:00:01.2: PCI bridge to [bus 03]
> [   57.238158] acpiphp: Slot [0-4] registered
> [   57.238682] pci 0000:04:00.0: [1af4:1042] type 00 class 0x010000
> PCIe Endpoint
> [   57.241207] pci 0000:04:00.0: BAR 1 [mem 0x81400000-0x81400fff]
> [   57.245502] pci 0000:04:00.0: BAR 4 [mem
> 0x390000000000-0x390000003fff 64bit pref]
> [   57.257182] pci 0000:00:01.3: PCI bridge to [bus 04]
> [   57.258719] acpiphp: Slot [0-5] registered
> [   57.259247] pci 0000:05:00.0: [1af4:1042] type 00 class 0x010000
> PCIe Endpoint
> [   57.261991] pci 0000:05:00.0: BAR 1 [mem 0x81200000-0x81200fff]
> [   57.268026] pci 0000:05:00.0: BAR 4 [mem
> 0x390800000000-0x390800003fff 64bit pref]
> [   57.270867] pci 0000:00:01.4: PCI bridge to [bus 05]
> [   57.272119] acpiphp: Slot [0-6] registered
> [   57.272653] pci 0000:06:00.0: [10de:2330] type 00 class 0x030200
> PCIe Endpoint
> [   60.512788] pci 0000:06:00.0: BAR 0 [mem
> 0x382002000000-0x382002ffffff 64bit pref]

Now we've gotten to the device and it looks like one...

> [   63.740786] pci 0000:06:00.0: BAR 2 [mem
> 0x380000000000-0x381fffffffff 64bit pref]

two...

> [   66.956785] pci 0000:06:00.0: BAR 4 [mem
> 0x382000000000-0x382001ffffff 64bit pref]

three more disables at the command register.  So we're really being
bitten that we toggle decode-enable/memory enable around reading each
BAR size.  I'd expect though that these latter three would still be
required during hotplug.  Do you have similar logs from that operation?

> [   70.188836] pci 0000:06:00.0: Max Payload Size set to 128 (was 256, max 256)

Looks like there might even be one more before we get here.  Thanks,

Alex


