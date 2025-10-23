Return-Path: <linux-pci+bounces-39172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8BC02758
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2019E35A21E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5BE26ED3A;
	Thu, 23 Oct 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPOj2ISn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9626E143
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237126; cv=none; b=lZKHqMYGk+nNiUpoL4V3tsHUD7wo7G/kakYbD+8a0lYJ6NJ7ZUoWFCFB5ItWZ+N8x9kZxi/BilneGFhcfpQOtoomdAXZBLwYxwKektotZ8mAjr8h+IF2raagrqzgR/CGiFs4CrRjQ6IjvcqOOEEhlkuCegGKnKiKECp+aysLaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237126; c=relaxed/simple;
	bh=78weOO8Ux2KH5nxBXBMycmrZ0njLHapCj22wQXG6s3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc8WmOvBI1u5dCsqRr/VvdzF1T86wgO92zR9TgjNaLoQecmb7WLmzAfMswKbLEvW5yXIs5vykK6IxeJEYAzbsjYeX+w2TP1ykiQZ8t/HvqkwjEEtUwnZAwngSDZISxC1sb0n92LOibcAZfeteB7hovIVAF8M3zFCr43GcXtH4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPOj2ISn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592f1988a2dso1846350e87.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761237123; x=1761841923; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYfGw1tMl9yOFknFdOBqe6dPAFpDn53Uc6QGIFFot64=;
        b=CPOj2ISnBOnl4iCLFjfOJucUjxSETQ6CbG9YSwqBFSEtUTBKLWXy1+l5lRnxaCN+vH
         5uAUmszSCO+dvRy/VltRs7a5vL4NA9TH53ib6KPH/mIZRTptY/FlisIt9/uLWoaZpoqz
         361PvGn55/JcW0isPzu7mKYsQkRjhJLoiO9MWai5bCUA29N3QOxNidyWB+WL2SvM1q0L
         joWZijH0p0d6BdXVHP6/tp/LUxDExuctyAjCAzQ3Yoqeb8rBtix6+bYdI3KpjsQIE6r3
         ek/c48hGWOxpMbmGsZUKtVPm/xdT9PE+bto7m926fVmtZjrpul23esgn5BJ5rHgRqIkL
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237123; x=1761841923;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYfGw1tMl9yOFknFdOBqe6dPAFpDn53Uc6QGIFFot64=;
        b=fXG0KaDpybCDVB4IABW/peX+kVShk2H5BLjxs9xReQaPi5xEeiVZBBEKrmI1FwZ1N8
         jGc8a6lV21QG0NdIjSvvgXWl+oFzG39UELXf8ghnA9X0crmk1a5Xvn2NyeIjwG1Zn/ii
         sgRUUw7URzIJBOuYjKHGW5EwayT+LTNWztbvDusFeTfHvPpS6LV9xU7Wp5ZyWSn6xFAY
         QwJbysQypACKFUklu2h6a7ZJd+5begeKj8W9/uzr4sImQnhvLzXAnCu1zTpy6c00iWRZ
         ufGT0uCw3Ka6A9pNDnHL1d4rAVzZNHbIXWY0v8O9sZbwjcO+Mb3tvw+y14+u0rQnma5U
         4iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ixbediakuf5b9pDHD864szHtR5jrexOsO9wXHrI76yt30neX077jKD6DDOAeEBdQgThWrNLZUT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeLlzxSdxSqoVbl7yFZoAdqBkW8KZDMSgqCeFYLboJyXcQ9J0
	jPpePJmNJLEa2YKU3IRflgG6gbjAD40/qaQg2sqa/WFiSIx3WJIlq1zL
X-Gm-Gg: ASbGncubEenSWJS4t0fxMqe63Rqm2+XPWLPl878YxIl7gSgLfEaCsix7tqT8ewMrp3H
	gjAmj7kuFX0z+EcTlPQOz+oJUHZeB7QSLJJSmCIu46LIZOD/NxH2sCmZC2/51h8kAGDgZMeBTvl
	wJdFk4vS9NJ+FAx/KoI158ervJ+GaWx6Zu1YfCab7I/gjtyK27Rhnyzl37XjIeXwS6uwd0TnWsO
	/cvQ4SjOgTDgU+Em4n7N9SHoJYHDzu/jwwgoqPlesXP9DISQ22zi34sqJDaVEEsLAjrdrMdBMB8
	ruWf/WR9ybvFYB8QAGPEfE4MxCYKb1vccHFMXAvCVtLT7qCdpQpuIrvVwbzxvsrU2BiL9qPW5Fe
	hiMaBiO04no7v5iFE1gDKdFofZX3hnsqymDkgHkJCIojIqhJWhzUwtz2blOzuG7UvmUz8abTvOP
	aql1txdQgW5pTsU3VB
X-Google-Smtp-Source: AGHT+IFKo/4nyXPNKUqA7IAS5KBLXbS3dKQTgE6kBFLo6yQ7yPWiD+r65VS0c92Ld+0Cdijp698faQ==
X-Received: by 2002:a05:6512:12c4:b0:57a:8eb7:1ea2 with SMTP id 2adb3069b0e04-592dc07e150mr2493948e87.27.1761237122517;
        Thu, 23 Oct 2025 09:32:02 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2d367sm828133e87.103.2025.10.23.09.32.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Oct 2025 09:32:01 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:31:54 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023183154.1e807af6.michal.pecio@gmail.com>
In-Reply-To: <20251023160906.GA730672@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
	<20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/L/dcs+e8mHMeXY=3blTIATs"

--MP_/L/dcs+e8mHMeXY=3blTIATs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 05:01:07PM +0200, Michal Pecio wrote:
> > On Thu, 23 Oct 2025 09:59:35 -0400, Yazen Ghannam wrote:  
> > > Thanks Michal.
> > > 
> > > I don't see anything obviously wrong.  
> > 
> > Which code is responsible for setting up those bitmaps which
> > are counted by topology_init_possible_cpus()?
> > 
> > I guess I could add some printks there and reboot.
> >   
> 
> The kernel seems to think there are 6 CPUs on your system:
> 
> [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs

I thought this is because I have NR_CPUS set to 6, as this config
originally came from the X6 machine, but I am not sure.

> 
> We don't seem them enabled, but they may still get APIC IDs. If so, then
> the IDs would be beyond the core shift of 2.
> 
> APIC IDs b'0 00 -> CPU0 on logical package 0
> 	 b'0 01 -> CPU1 on logical package 0
> 	 b'0 10 -> CPU2 on logical package 0
> 	 b'0 11 -> CPU3 on logical package 0
> 	 b'1 00 -> CPU0 on logical package 1
> 	 b'1 01 -> CPU1 on logical package 1
> 
> 
> Please try booting with "possible_cpus=4".

OK, will try it next time I'm rebooting.

> The "number of possible CPUs" comes from the ACPI Multiple APIC
> Description Table (MADT). This has the signature "APIC".
> 
> Can you please provide the disassembly of this table?

Interesting, it looks like there are indeed 6 LAPICs there.
BIOS bug? Attaching apic.dsl.

> Can you please share the dmesg output from that system? And the ACPI
> table too?

Will try later but I don't recall any anomalies there.
I remember checking the topology output and it made sense:
1 package, 1 die, 6 cores, 6 threads.

--MP_/L/dcs+e8mHMeXY=3blTIATs
Content-Type: text/x-dsl
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=apic.dsl

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20211217 (64-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembly of apic.dat, Thu Oct 23 18:19:16 2025
 *
 * ACPI Data Table [APIC]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
[004h 0004   4]                 Table Length : 0000007C
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : F5
[00Ah 0010   6]                       Oem ID : "080912"
[010h 0016   8]                 Oem Table ID : "APIC1703"
[018h 0024   4]                 Oem Revision : 20120809
[01Ch 0028   4]              Asl Compiler ID : "MSFT"
[020h 0032   4]        Asl Compiler Revision : 00000097

[024h 0036   4]           Local Apic Address : FEE00000
[028h 0040   4]        Flags (decoded below) : 00000001
                         PC-AT Compatibility : 1

[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
[02Dh 0045   1]                       Length : 08
[02Eh 0046   1]                 Processor ID : 01
[02Fh 0047   1]                Local Apic ID : 00
[030h 0048   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[034h 0052   1]                Subtable Type : 00 [Processor Local APIC]
[035h 0053   1]                       Length : 08
[036h 0054   1]                 Processor ID : 02
[037h 0055   1]                Local Apic ID : 01
[038h 0056   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[03Ch 0060   1]                Subtable Type : 00 [Processor Local APIC]
[03Dh 0061   1]                       Length : 08
[03Eh 0062   1]                 Processor ID : 03
[03Fh 0063   1]                Local Apic ID : 02
[040h 0064   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[044h 0068   1]                Subtable Type : 00 [Processor Local APIC]
[045h 0069   1]                       Length : 08
[046h 0070   1]                 Processor ID : 04
[047h 0071   1]                Local Apic ID : 03
[048h 0072   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[04Ch 0076   1]                Subtable Type : 00 [Processor Local APIC]
[04Dh 0077   1]                       Length : 08
[04Eh 0078   1]                 Processor ID : 05
[04Fh 0079   1]                Local Apic ID : 84
[050h 0080   4]        Flags (decoded below) : 00000000
                           Processor Enabled : 0
                      Runtime Online Capable : 0

[054h 0084   1]                Subtable Type : 00 [Processor Local APIC]
[055h 0085   1]                       Length : 08
[056h 0086   1]                 Processor ID : 06
[057h 0087   1]                Local Apic ID : 85
[058h 0088   4]        Flags (decoded below) : 00000000
                           Processor Enabled : 0
                      Runtime Online Capable : 0

[05Ch 0092   1]                Subtable Type : 01 [I/O APIC]
[05Dh 0093   1]                       Length : 0C
[05Eh 0094   1]                  I/O Apic ID : 04
[05Fh 0095   1]                     Reserved : 00
[060h 0096   4]                      Address : FEC00000
[064h 0100   4]                    Interrupt : 00000000

[068h 0104   1]                Subtable Type : 02 [Interrupt Source Override]
[069h 0105   1]                       Length : 0A
[06Ah 0106   1]                          Bus : 00
[06Bh 0107   1]                       Source : 00
[06Ch 0108   4]                    Interrupt : 00000002
[070h 0112   2]        Flags (decoded below) : 0000
                                    Polarity : 0
                                Trigger Mode : 0

[072h 0114   1]                Subtable Type : 02 [Interrupt Source Override]
[073h 0115   1]                       Length : 0A
[074h 0116   1]                          Bus : 00
[075h 0117   1]                       Source : 09
[076h 0118   4]                    Interrupt : 00000009
[07Ah 0122   2]        Flags (decoded below) : 000F
                                    Polarity : 3
                                Trigger Mode : 3

Raw Table Data: Length 124 (0x7C)

    0000: 41 50 49 43 7C 00 00 00 01 F5 30 38 30 39 31 32  // APIC|.....080912
    0010: 41 50 49 43 31 37 30 33 09 08 12 20 4D 53 46 54  // APIC1703... MSFT
    0020: 97 00 00 00 00 00 E0 FE 01 00 00 00 00 08 01 00  // ................
    0030: 01 00 00 00 00 08 02 01 01 00 00 00 00 08 03 02  // ................
    0040: 01 00 00 00 00 08 04 03 01 00 00 00 00 08 05 84  // ................
    0050: 00 00 00 00 00 08 06 85 00 00 00 00 01 0C 04 00  // ................
    0060: 00 00 C0 FE 00 00 00 00 02 0A 00 00 02 00 00 00  // ................
    0070: 00 00 02 0A 00 09 09 00 00 00 0F 00              // ............

--MP_/L/dcs+e8mHMeXY=3blTIATs--

