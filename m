Return-Path: <linux-pci+bounces-4794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6B87B306
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 21:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A6D1C23274
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B4012E6C;
	Wed, 13 Mar 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepwavedigital-com.20230601.gappssmtp.com header.i=@deepwavedigital-com.20230601.gappssmtp.com header.b="u0g0mA+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4D1A38DB
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362938; cv=none; b=cH2cPCU2II1o7kVtoGp5YwTDuQ4tP2WmEbZRVyfAlG1GsHTnvjmQY04S7hJ7X6MmU9MMrA0M0CJB/+iyd7a+Mm0fiQVs7LaeRVTxVfZlXdDKKs/qj4KJcczXy66aJtkRbeTURM7guy5oBnwXIuwdcP6tKwSmYYzi0P4lSCf+HUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362938; c=relaxed/simple;
	bh=g8LqX2ARWy0wqZE686Gw/0SDGSlqSjio0FqyPtwGq0k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l45SvzoiuHNeHJNXbEQayR0S1aVEZr9kvesafLL+AdEqwd92gFG5c/pCbsxgdOl1v0Utp8kD/svxen6uZ14J+AnXxT7Y+LeOXpDEIqkfhjSXqkWeo0rZh/abc5o80/J7WZcIy4+ntOVxdTJQ3uNVHK8wW26rN8ks31YRcCYdGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deepwavedigital.com; spf=fail smtp.mailfrom=deepwavedigital.com; dkim=pass (2048-bit key) header.d=deepwavedigital-com.20230601.gappssmtp.com header.i=@deepwavedigital-com.20230601.gappssmtp.com header.b=u0g0mA+m; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deepwavedigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=deepwavedigital.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690d7a8f904so11375646d6.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepwavedigital-com.20230601.gappssmtp.com; s=20230601; t=1710362935; x=1710967735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QDDXz+HieILyoM7Fp7IqzIOhB/WAqGcPtWgNk4RLkzI=;
        b=u0g0mA+mIWCzUvWMNCaFbVd7wgVPxz3rIqhiMUDWgVkh/8ki6NDYplIzUzEMN3Np3d
         C4ABgV5QmJeLtWVIVmljOD9/tmj0PiCaLQv36Zlmw2F+tERjMQLSGscMKV8sTaK8Amip
         2S01qSBkiZjZHFBhO1Qz8+F5vr6TIaISFKqxe/2iV68+Nn8GaTnDcFnhBPo74x0lUGtw
         AP7e4gheKxPW4j6wi412SSAI3a20lOfcxsEI2jcVaL8c1xtMZU2GEeEoDush8godPFZL
         1F4xpExURXufbQ0p/r3283jos6DpapRJuEuVTgbNlm8FiqlC2HMuxX/IP7DqXe6TYhq0
         nqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710362935; x=1710967735;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDDXz+HieILyoM7Fp7IqzIOhB/WAqGcPtWgNk4RLkzI=;
        b=kwUjdyr6gpDArZs/jM04u08MuD2zCc/IiT8bUMOeJnrVSiC054EWNCIwxTBrH0ukKQ
         K0ra3f4Wf4wKG9Y2CLgm1MQ0ApmTHkgyGKudE5+fwnLcMJQdghCCM9jVMe47waHsEYBm
         jwimcVqbuPRBQMObGu9+jJbKEQfwyAK+5txGuqCuCGHm4+IFY8jj0DSjyM9Zdbi5nEke
         806DyBKqTTIB0iwsv5k+GHXm0i3ljWwH2xn4fmu0hn947LGrvcBLY9cr3cHZdpOQUlS+
         vRbYdhJujnE+dNuW8hWZAO6QnJPrHa/OIOrt9oW5/A7SrXDvEAnae/yAxKLn7Q4hptrN
         N6Pw==
X-Gm-Message-State: AOJu0Yw2kV8TzcvpWsjcVZngJCM+qSXYvjEqSVJyNyRZ4cNgDkc+aP5E
	Q2ZViFvDLgieeECEIb6RFhNcPqrPbxPdQdkLXmW3Ch80reyhnwaRbJk5R1q4y2kxH9y+cFa/j4v
	FVmZN6B525ehQVLV9lNEI60avtz/LaopXvVdxUA==
X-Google-Smtp-Source: AGHT+IEBbnYq0gGZavS1YtHOEiIcuhJv2Wf2O9AEl6TihiDr6DVf7l9Bqd1QwK8qvQSDxiYqBR0ogL3b244V1T+3f4g=
X-Received: by 2002:a05:6214:2b0a:b0:68f:f859:ee06 with SMTP id
 jx10-20020a0562142b0a00b0068ff859ee06mr1428645qvb.12.1710362935238; Wed, 13
 Mar 2024 13:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Bryant <dan@deepwavedigital.com>
Date: Wed, 13 Mar 2024 16:48:44 -0400
Message-ID: <CAFgx5J181LSmRzrxsW1Mby2nSmAfepsdpzu6+BjHb=6DiiC_Lw@mail.gmail.com>
Subject: [BUG] PCI: of: of_pci_make_dev_node() creates ranges that fail
 address translation
To: Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm using the of_pci_make_dev_node() framework to dynamically create
nodes for the host bridge and attached device, then applying an overlay to
create a simple-bus and children on the endpoint device. The initial problem
is that none of the children create any memory resources.  This is on
a DT-based system, aarch64 hardware.

The overall bus hierarchy is this:

PCIe root port controller -> host bridge -> device -> simple-bus ->
[subdevices].

1. Root port controller is defined by static DT blob.
2. bridge and device of_nodes are created by of_pci_make_dev_node()
3. simple-bus and subdevices are added from a single overlay.

The end result is very similar to the test case in
drivers/of/unittest-data/tests-address.dtsi. I've traced the failure
for this hardware to of_translate_address() always returning
OF_BAD_ADDR for any of the "reg" properties of a subdevice.The
critical difference between the working unit test and the hardware DT
is that the hardware PCIe root port controller has a ranges property
that's not just an identity mapping.

arch/arm64/boot/dts/nvidia/tegra234.dtsi contains the following
definition, note specifically the second ranges entry:

    pcie@14160000 {
        compatible = "nvidia,tegra234-pcie";
        device_type = "pci";
        // ...
        ranges = <0x43000000 0x21 0x40000000 0x21 0x40000000 0x2
0xe8000000>, /* prefetchable memory (11904 MB) */
                <0x02000000 0x0  0x40000000 0x24 0x28000000 0x0
0x08000000>, /* non-prefetchable memory (128 MB) */
                <0x01000000 0x0  0x36100000 0x00 0x36100000 0x0
0x00100000>; /* downstream I/O (1 MB) */
    };

Then when the child bridge is created, a of_node is created with the
following properties:

    pci@0,0 {
            compatible = "pci10de,229c\0pciclass,060400\0pciclass,0604";

            #address-cells = <0x03>;
            #size-cells = <0x02>;
            bus-range = <0x01 0xff>;
            device_type = "pci";

            ranges = <0x82000000 0x24 0x28000000 0x82000000 0x24
0x28000000 0x00 0x200000>;
    };

This ranges entry is a simple passthrough, but it's of the addresses
already translated to the CPU address space, and not the bus address.
This will cause of_translate_address() to fail when it reaches
pcie@14160000 and doesn't match.

As a caveat, I'm currently seeing this on hardware on a downstream
vendor kernel. I'm still working to reproduce on mainline 6.8 (via
qemu, probably?), but I don't yet see anything that would stop this
from being any different there.

Dan

