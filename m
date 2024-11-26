Return-Path: <linux-pci+bounces-17376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B79D9F72
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 00:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30BBB21D73
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2701C4A1E;
	Tue, 26 Nov 2024 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PFfKSUrv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F81B87D0
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732662509; cv=none; b=c799fVZDEi1D/IYbqjeNGXaVnEc9AmvfyDFcWdwSfm/pzYYf1aU9NccrgBPAgaX/J+98bPZ+IKsXDutcxbFLuboYKQCDZvpcG/B90iWSCVlEx+9CPcRdp/DG3lf2hPKDI/VbGgkf/gArleez5CuQ4vec/IbJbvCHGIbR2YmtjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732662509; c=relaxed/simple;
	bh=/+t9KPbcXjgev5Gig7K7++xUudZNgf9nR+eZgSnQNBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1uFBlVSKFBUi4bHyIhb/MY4A3SKaYPG4W2toIV26ik1Flh7FcXzN5GCYpEDaPxw9DwI91qpeCWUQpthkYt1JrLP8ciQOVfKB/+WJ014pms4Rbs5zIxALFLMNIROl3Sf5F/UtCbpQY0MPW2fKwVOucQy8wbgUfImFCoy5MRDgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PFfKSUrv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64FC73F763
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732662499;
	bh=n22n74xQxi06U2fnWKCPx8H9DzQimf9y0itz/2dvSus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PFfKSUrvFTUswPxH5AD8D38rn7LnOm7B3dIrPxZyi60iWZwD6/N2maAztMd9oczeQ
	 31lxOpiUiGqwreiZQa332vHWtrOZegDEFy8RysfCg32NomwacCgAOkHehQ3NmVPXzU
	 baL8M5ABd4xhvseb8nZFfy79NE6bSaNLtdOmJCPnzSET6KggQBcvsY2N1821XqAWu9
	 AFjluLsNjewNqIW5c3ckE7E6JLmzaBUfzERduUA4xhaDcIWYapeCIYY+fBxJsl2a+x
	 4cPZZ7Am43obo1SkMnABBtA/lneUjNDVua9v1+wIpzKuvCOeMYSsKCpkAM2TF0ycO9
	 clO7NpvX/d9IQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5cfc992ac2eso1813404a12.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 15:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732662499; x=1733267299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n22n74xQxi06U2fnWKCPx8H9DzQimf9y0itz/2dvSus=;
        b=Pbe+SQkzxLJE6LldKbHaqlE+1z2VmIbspzO4jgxBURC1hJDvLcuONAlty0ERq0ITQt
         2PPq3jzrl0vgGZ5fHstOIcLJR44ezCEi0SHeIBWNVktXLFJw8n9TWVFRSDehYyK+N0Zx
         4e6VwL/zhU/MEDd7Qy0rVCzmlezmmB59z+0iZdqSTp4A3WydOBOZapKbvJgsWn1pQRZc
         JpMyT23MH5Zh2Kw0s2c6V01VMd5EUfNGWhSNCXx5xnbG0oTYOqDSZUZeBeCMHJBsoN/L
         Z5n5SU3hHrk8A6e9Nk9beCBFFwcfRAOUTTu3LaoSu1zgN0xNevoIcael9FjRRi2zgKsI
         6Aaw==
X-Gm-Message-State: AOJu0YxuJgdiAdPS4sBh/sFFK/Zf+PSzjCrchXMkKYVvLldznNENYfJJ
	O4ddvp9XoRpJzFvlE9o1vCtTvaRiFOnjJatz9cgPd6nX4Kauo30hEsrLxEmst/CKdwYA3okNnNk
	PH8sNA2WGjZTUDJckWYdDsy0AQaecWqKOsGHLHf0TeJ6A1KOVWIqz3q+mmA3PYstdxCQTOm9mGe
	BNS8B+VyYTG1xPFcynk6BHtniEdMtM7co/yr3dqgpe6yTOACia
X-Gm-Gg: ASbGnctxti7d1cRjjo+kuS+y8+NqnKrVJhl7hjjOWmEoyH0jGbPMD6YCViNxXRnMJIn
	hn/xG4kyaFFJ5ZBHlLEas55IqOg8HMg==
X-Received: by 2002:a05:6402:3547:b0:5ce:d6db:25e5 with SMTP id 4fb4d7f45d1cf-5d080be852amr900622a12.18.1732662498768;
        Tue, 26 Nov 2024 15:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGleh0dGEd0VsgsAR1JhEsZy1A7IzvkL/TNaje1mmcJHGtyvKaLLmCFQ7RfUcahcM0w2hm8W0v6jaGxUAh2PAE=
X-Received: by 2002:a05:6402:3547:b0:5ce:d6db:25e5 with SMTP id
 4fb4d7f45d1cf-5d080be852amr900608a12.18.1732662498423; Tue, 26 Nov 2024
 15:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
 <20241126103427.42d21193.alex.williamson@redhat.com> <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
 <20241126154145.638dba46.alex.williamson@redhat.com>
In-Reply-To: <20241126154145.638dba46.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 26 Nov 2024 17:08:07 -0600
Message-ID: <CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If the slowness is confined to the guest kernel boot, can you share the l=
og of that boot with timestamps?

It is confined to the guest. On hand, I have this log section from a
past guest boot:

[    3.965790] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
conventional PCI endpoint
[    3.967800] pci 0000:00:01.0: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[    3.974590] pci 0000:00:01.0: BAR 0 [mem 0x81c8e000-0x81c8efff]
[    3.980780] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.984128] pci 0000:00:01.0:   bridge window [mem 0x81a00000-0x81bfffff=
]
[    3.985915] pci 0000:00:01.0:   bridge window [mem
0x38e800000000-0x38efffffffff 64bit pref]
[    3.988884] pci 0000:00:01.1: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[    3.992771] pci 0000:00:01.1: BAR 0 [mem 0x81c8d000-0x81c8dfff]
[    3.999361] pci 0000:00:01.1: PCI bridge to [bus 02]
[    4.000276] pci 0000:00:01.1:   bridge window [mem 0x81800000-0x819fffff=
]
[    4.001849] pci 0000:00:01.1:   bridge window [mem
0x38f000000000-0x38f7ffffffff 64bit pref]
[    4.009442] pci 0000:00:01.2: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[    4.012772] pci 0000:00:01.2: BAR 0 [mem 0x81c8c000-0x81c8cfff]
[    4.016781] pci 0000:00:01.2: PCI bridge to [bus 03]
[    4.020299] pci 0000:00:01.2:   bridge window [mem 0x81600000-0x817fffff=
]
[    4.021780] pci 0000:00:01.2:   bridge window [mem
0x38f800000000-0x38ffffffffff 64bit pref]
[    4.024680] pci 0000:00:01.3: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[    4.027299] pci 0000:00:01.3: BAR 0 [mem 0x81c8b000-0x81c8bfff]
[    4.036781] pci 0000:00:01.3: PCI bridge to [bus 04]
[    4.037646] pci 0000:00:01.3:   bridge window [mem 0x81400000-0x815fffff=
]
[    4.040806] pci 0000:00:01.3:   bridge window [mem
0x390000000000-0x3907ffffffff 64bit pref]
[    4.046317] pci 0000:00:01.4: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[    4.049673] pci 0000:00:01.4: BAR 0 [mem 0x81c8a000-0x81c8afff]
[    4.053625] pci 0000:00:01.4: PCI bridge to [bus 05]
[    4.056830] pci 0000:00:01.4:   bridge window [mem 0x81200000-0x813fffff=
]
[    4.059022] pci 0000:00:01.4:   bridge window [mem
0x390800000000-0x390fffffffff 64bit pref]
[    4.061614] pci 0000:00:01.5: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[    7.616784] pci 0000:00:01.5: BAR 0 [mem 0x81c89000-0x81c89fff]
[   14.140789] pci 0000:00:01.5: PCI bridge to [bus 06]
[   14.142240] pci 0000:00:01.5:   bridge window [mem 0x81000000-0x811fffff=
]
[   17.432805] pci 0000:00:01.5:   bridge window [mem
0x380000000000-0x382002ffffff 64bit pref]
[   17.436775] pci 0000:00:01.6: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   20.656786] pci 0000:00:01.6: BAR 0 [mem 0x81c88000-0x81c88fff]
[   27.044792] pci 0000:00:01.6: PCI bridge to [bus 07]
[   27.048775] pci 0000:00:01.6:   bridge window [mem 0x80e00000-0x80ffffff=
]
[   30.240811] pci 0000:00:01.6:   bridge window [mem
0x384000000000-0x386002ffffff 64bit pref]
[   30.244777] pci 0000:00:01.7: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   33.676789] pci 0000:00:01.7: BAR 0 [mem 0x81c87000-0x81c87fff]
[   40.524791] pci 0000:00:01.7: PCI bridge to [bus 08]
[   40.526249] pci 0000:00:01.7:   bridge window [mem 0x80c00000-0x80dfffff=
]
[   43.876807] pci 0000:00:01.7:   bridge window [mem
0x388000000000-0x38a002ffffff 64bit pref]
[   43.880776] pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   47.184786] pci 0000:00:02.0: BAR 0 [mem 0x81c86000-0x81c86fff]
[   53.796794] pci 0000:00:02.0: PCI bridge to [bus 09]
[   53.798349] pci 0000:00:02.0:   bridge window [mem 0x80a00000-0x80bfffff=
]
[   57.104809] pci 0000:00:02.0:   bridge window [mem
0x38c000000000-0x38e002ffffff 64bit pref]
[   57.109300] pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   57.112270] pci 0000:00:02.1: BAR 0 [mem 0x81c85000-0x81c85fff]
[   57.115960] pci 0000:00:02.1: PCI bridge to [bus 0a]
[   57.116535] pci 0000:00:02.1:   bridge window [mem 0x80800000-0x809fffff=
]
[   57.121443] pci 0000:00:02.1:   bridge window [mem
0x391000000000-0x3917ffffffff 64bit pref]
[   57.123113] pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   57.125263] pci 0000:00:02.2: BAR 0 [mem 0x81c84000-0x81c84fff]
[   57.128168] pci 0000:00:02.2: PCI bridge to [bus 0b]
[   57.128713] pci 0000:00:02.2:   bridge window [mem 0x80600000-0x807fffff=
]
[   57.129619] pci 0000:00:02.2:   bridge window [mem
0x391800000000-0x391fffffffff 64bit pref]
[   57.133671] pci 0000:00:02.3: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   57.135884] pci 0000:00:02.3: BAR 0 [mem 0x81c83000-0x81c83fff]
[   57.138198] pci 0000:00:02.3: PCI bridge to [bus 0c]
[   57.138749] pci 0000:00:02.3:   bridge window [mem 0x80400000-0x805fffff=
]
[   57.139975] pci 0000:00:02.3:   bridge window [mem
0x392000000000-0x3927ffffffff 64bit pref]
[   57.141558] pci 0000:00:02.4: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   57.146325] pci 0000:00:02.4: BAR 0 [mem 0x81c82000-0x81c82fff]
[   57.148744] pci 0000:00:02.4: PCI bridge to [bus 0d]
[   57.148795] pci 0000:00:02.4:   bridge window [mem 0x80200000-0x803fffff=
]
[   57.149992] pci 0000:00:02.4:   bridge window [mem
0x392800000000-0x392fffffffff 64bit pref]
[   57.151660] pci 0000:00:02.5: [1b36:000c] type 01 class 0x060400
PCIe Root Port
[   57.157365] pci 0000:00:02.5: BAR 0 [mem 0x81c81000-0x81c81fff]
[   57.159859] pci 0000:00:02.5: PCI bridge to [bus 0e]
[   57.160374] pci 0000:00:02.5:   bridge window [mem 0x80000000-0x801fffff=
]
[   57.161268] pci 0000:00:02.5:   bridge window [mem
0x393000000000-0x3937ffffffff 64bit pref]
[   57.176995] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
conventional PCI endpoint
[   57.178146] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by
ICH6 ACPI/GPIO/TCO
[   57.179162] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
conventional PCI endpoint
[   57.186370] pci 0000:00:1f.2: BAR 4 [io  0x6040-0x605f]
[   57.187830] pci 0000:00:1f.2: BAR 5 [mem 0x81c80000-0x81c80fff]
[   57.189464] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
conventional PCI endpoint
[   57.197117] pci 0000:00:1f.3: BAR 4 [io  0x6000-0x603f]
[   57.199155] acpiphp: Slot [0] registered
[   57.199695] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
PCIe Endpoint
[   57.202062] pci 0000:01:00.0: BAR 1 [mem 0x81a00000-0x81a00fff]
[   57.205640] pci 0000:01:00.0: BAR 4 [mem
0x38e800000000-0x38e800003fff 64bit pref]
[   57.213753] pci 0000:01:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[   57.215477] pci 0000:00:01.0: PCI bridge to [bus 01]
[   57.216661] acpiphp: Slot [0-2] registered
[   57.216846] pci 0000:02:00.0: [1b36:000d] type 00 class 0x0c0330
PCIe Endpoint
[   57.218123] pci 0000:02:00.0: BAR 0 [mem 0x81800000-0x81803fff 64bit]
[   57.221585] pci 0000:00:01.1: PCI bridge to [bus 02]
[   57.225522] acpiphp: Slot [0-3] registered
[   57.226056] pci 0000:03:00.0: [1af4:1043] type 00 class 0x078000
PCIe Endpoint
[   57.228576] pci 0000:03:00.0: BAR 1 [mem 0x81600000-0x81600fff]
[   57.231435] pci 0000:03:00.0: BAR 4 [mem
0x38f800000000-0x38f800003fff 64bit pref]
[   57.236846] pci 0000:00:01.2: PCI bridge to [bus 03]
[   57.238158] acpiphp: Slot [0-4] registered
[   57.238682] pci 0000:04:00.0: [1af4:1042] type 00 class 0x010000
PCIe Endpoint
[   57.241207] pci 0000:04:00.0: BAR 1 [mem 0x81400000-0x81400fff]
[   57.245502] pci 0000:04:00.0: BAR 4 [mem
0x390000000000-0x390000003fff 64bit pref]
[   57.257182] pci 0000:00:01.3: PCI bridge to [bus 04]
[   57.258719] acpiphp: Slot [0-5] registered
[   57.259247] pci 0000:05:00.0: [1af4:1042] type 00 class 0x010000
PCIe Endpoint
[   57.261991] pci 0000:05:00.0: BAR 1 [mem 0x81200000-0x81200fff]
[   57.268026] pci 0000:05:00.0: BAR 4 [mem
0x390800000000-0x390800003fff 64bit pref]
[   57.270867] pci 0000:00:01.4: PCI bridge to [bus 05]
[   57.272119] acpiphp: Slot [0-6] registered
[   57.272653] pci 0000:06:00.0: [10de:2330] type 00 class 0x030200
PCIe Endpoint
[   60.512788] pci 0000:06:00.0: BAR 0 [mem
0x382002000000-0x382002ffffff 64bit pref]
[   63.740786] pci 0000:06:00.0: BAR 2 [mem
0x380000000000-0x381fffffffff 64bit pref]
[   66.956785] pci 0000:06:00.0: BAR 4 [mem
0x382000000000-0x382001ffffff 64bit pref]
[   70.188836] pci 0000:06:00.0: Max Payload Size set to 128 (was 256, max =
256)

I could get full output if you need more than just the PCI section,
but this is what I've mainly been saving since it is the slow part. (I
would have to re-run the tests, which I probably won't be able to do
until next week though, since our H100 is in use by someone else right
now.)

Thanks,


On Tue, Nov 26, 2024 at 4:41=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 26 Nov 2024 16:18:26 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
> > > The BAR space is walked, faulted, and mapped.  I'm sure you're at
> > > least experiencing scaling issues of that with 128GB BARs.
> >
> > The part that is strange to me is that I don't see the initialization
> > slowdown at all when the GPUs are hotplugged after boot completes.
> > Isn't what you describe here also happening during the hotplugging
> > process, or is it different in some way?
>
> The only thing that comes to mind would be if you're using a vIOMMU and
> it's configured in non-passthrough mode so the BARs aren't added to the
> DMA address space after the vIOMMU is enabled during boot.  But your
> virt-install command doesn't show a vIOMMU configuration for the VM.
>
> If the slowness is confined to the guest kernel boot, can you share the
> log of that boot with timestamps?  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering
Email:mitchell.augustin@canonical.com
Location:United States of America


canonical.com
ubuntu.com

