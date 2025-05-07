Return-Path: <linux-pci+bounces-27375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B96AAAE323
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939D63B6E90
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A11FF601;
	Wed,  7 May 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcHGpg30"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164114A639
	for <linux-pci@vger.kernel.org>; Wed,  7 May 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628285; cv=none; b=HZAu6SABkReb4VgCXioH2eLLsjPut2ug++vZfCdoUQNl3YoDZ5TkNotiiCcJPtax1OiV0AgD3nhThATxOmWFjQE+Qo6GYTJzxjUwz4oda4DJJh90YWip0Ad81U3+7oy2xYsyoev8h4DJvuxsb4l1X6YekklSsLCRKD7bdavPAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628285; c=relaxed/simple;
	bh=lj634mF8KDjE41oIDTZif1dAkUdEXDLEEq0GQoBOb3U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uLDJ465D4hRlPXr+Jmv7by4xG6HPQmEnPxsLc8QLae4lq8xV2RJfmj11Kr2jy9fmx6UTarJHeLMqSULg/rsrCUGDUvG8oqAUJC0OK4BS1R6EWASxKkn9UL1RyYBS6te6rNhPPHmLxH+4JbUpStfj6TmYWP0j0NrbU5VVd6D8uEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcHGpg30; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6064d4c14ebso1681345eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 07 May 2025 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746628281; x=1747233081; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lj634mF8KDjE41oIDTZif1dAkUdEXDLEEq0GQoBOb3U=;
        b=JcHGpg30DUTpJ+OLGa3XcaLxsiMV282nndq+eVDucC9P5CND49qZXgBNq6hlabICtS
         6212rYATCy4M0/JGG8l08Tsdxwc4vXRUvRqB7hEpwdmEXiiKaSLf72jYBXCsC6Y6XlFV
         H8s5bAwM3OfH50Tyq9XM6Pj1oiuxta/9KUQx0urhEXLqZAEOLiR3NEgP84flClK9oOzU
         VgBhVXI6tHlwRyrKpRE1icRzbTMiYPBXuQ8TvNcPJKwnY/dNSvyFsrbnYwBW6T478d1H
         lAY/lSXLVGnrrhEEGWoCd1nVpcaOf4yoJceDs4qbOXhoyNMj8RGYsFbX2oWhSmEwZLTb
         ir4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746628281; x=1747233081;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj634mF8KDjE41oIDTZif1dAkUdEXDLEEq0GQoBOb3U=;
        b=Tq3Z2LrxN/y26Iyb6ZYMoPcEiIuXmM2UBZA58viIspeVwY/zK7pxbvdgCIP7HmPX2V
         zwcVlPDHj1SA4C/tEFle1gvaf5bukWADgw4juekjXUhlNw0dcmxmjAUapLZmPSHm1Eho
         DeNzh0jViOZKUPAMivis9Vv+i442HFl2FT9icYw1fzL5PL40qECzxnYF2gvcQynYaz68
         eblL03dAFAPrarVEHrejKvCpr+Z+YKn6Hg3pnmgBMOqLX+M8pc1440ozfWziGGkZ86wu
         LZVwgeDD8AyWhqf0dt4gBVZIUHg/hBXIIxwgm4hZPzM2e8WO4qBy6HcQYTUdLMD/Hxmx
         6iPg==
X-Gm-Message-State: AOJu0YzlY8LvJ+seXXOpbW03ddULSNe+oPmpy9f0algXKNvdV1ywV+hD
	lMdJlokF9KCS1lj412G4Q1gt7VHePrZnpYPPm+Cw+0jfbOeUTpQC0ce8gCKK1GtWbi5FY1qlcVz
	xQz98WolqOBPVMlYGIb6GqlKpOcL8gT/Q
X-Gm-Gg: ASbGncsPIz8NTqHVhbszq5OwzO8qP23Mxw2AMBWwbADjGVsgFvqwv+lb0Bsa8zS00XL
	2NeDke6/Y0C3DYXP2D3rCSr9ucO7DCgaUBQyub8E3XNscc2KEghIEi+n42YJihiW8TwjApTO1Hc
	Ze7hJRCidq11a+nwRk5+S7cfcI
X-Google-Smtp-Source: AGHT+IFxkf5JVY533ilFezKjr/N0JZsHPwDFoKg8nlyDY2wgx/snBsk8zMi6HRBCyvFz7cMo/kMLx0Fo4+Uo94yX8gY=
X-Received: by 2002:a05:6820:1a05:b0:606:8671:1b28 with SMTP id
 006d021491bc7-60828d190bbmr2257727eaf.4.1746628281004; Wed, 07 May 2025
 07:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date: Wed, 7 May 2025 20:01:09 +0530
X-Gm-Features: ATxdqUHVs-ixMiZ8mlgry0llvkM1Oq3SKCg1I92tQTtpZf9bgIkcnIhqMM_eS-Q
Message-ID: <CAPY=qRSvmP=rRki+Q+AV3O3sSNO6-ezCeGr-HBjHhFSS-JYc7A@mail.gmail.com>
Subject: PCIe: Unexpected .remove() and .probe() Callback Invocation Without
 Device Removal
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

I=E2=80=99m reaching out for some guidance on a behavior we're observing wi=
th
a Xilinx FPGA based PCIe device on our test systems. This device uses
an out-of-tree driver.

We are seeing that, without any actual physical or hotplug
removal/reinsertion of the PCIe device, the kernel invokes the
pci_driver's .remove() callback followed shortly by the .probe()
callback. This appears to be an unexpected re-enumeration or reset of
the PCIe device.

Below is a snippet of the relevant kernel log captured during one such even=
t.

Apr 30 20:01:05 xilinxtest1 kernel: [6612195.847385] XILINX_FPGA PCI
0000:01:00.0: PME# disabled
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.847410] XILINX_FPGA PCI:
XILINX_FPGA_pci_remove
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.848110] pci 0000:01:00.0:
EDR: Notify handler removed
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.848240] pci 0000:01:00.0:
device released
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876157] pci_bus 0000:00:
scanning bus
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876419] pcieport
0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 0
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876445] pci_bus 0000:01:
scanning bus
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876594] pci 0000:01:00.0:
[1556:5555] type 00 class 0x050000
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876678] pci 0000:01:00.0:
reg 0x10: [mem 0xd0400000-0xd07fffff]
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877426] pci 0000:01:00.0:
EDR: Notify handler installed
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877850] pci_bus 0000:01:
bus scan returning with max=3D01
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877872] pcieport
0000:00:1c.2: scanning [bus 02-02] behind bridge, pass 0
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877898] pci_bus 0000:02:
scanning bus
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877915] pci_bus 0000:02:
bus scan returning with max=3D02
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877932] pcieport
0000:00:1c.3: scanning [bus 03-03] behind bridge, pass 0
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877956] pci_bus 0000:03:
scanning bus
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877965] pci_bus 0000:03:
bus scan returning with max=3D03
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877982] pcieport
0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 1
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878013] pcieport
0000:00:1c.2: scanning [bus 02-02] behind bridge, pass 1
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878043] pcieport
0000:00:1c.3: scanning [bus 03-03] behind bridge, pass 1
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878066] pci_bus 0000:00:
bus scan returning with max=3D03
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878094] pci 0000:01:00.0:
BAR 0: assigned [mem 0xd0400000-0xd07fffff]
Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878204] XILINX_FPGA PCI
0000:01:00.0: runtime IRQ mapping not provided by arch


Our Questions:

What could trigger such a PCIe device re-enumeration without a physical eve=
nt?

Are there any known kernel or platform-level triggers that might cause this=
?

Any debug hooks or sysfs entries we should monitor or enable to catch
the root cause?

Any guidance, insights, or debugging suggestions would be greatly appreciat=
ed.


Thanks,

