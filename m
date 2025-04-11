Return-Path: <linux-pci+bounces-25690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F293A8667E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 21:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF074C1DE8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00A27F4DB;
	Fri, 11 Apr 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="k2c1bts5"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C027F4CF;
	Fri, 11 Apr 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400242; cv=none; b=A+2Os8eXCrPb+dpwJIOpYQKqWHAs5vDB+sFhv4dcv87LMfEYHi2AjG/mzda6OLqJLaymxKhSKGW+M7Uf6J5ebvXosC3aK/9/uUhyZozsi7fJizMP9JvR+gCYo0VHXcobKMu3wwGTJkwtq3cxfMs6vjSL3BRa26lIOQIZ75eEpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400242; c=relaxed/simple;
	bh=twXvR3D12tBJbtQo+qf/To0dHLrK8MG6BVSfsEKZTWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR+Gz2dRQplS/30jI1MCjTJbXWTdVTicT6HlpRoWL9U2am7knf8K0CA17ZUNojYB4P5QWbUZ5vQ8Ityot3zJqWQ+SmEOHWUAWNXQS/vamzBbUJPT0X2qkwWye1KnlxTtgKuu08n3z+/tHYUxzxgvdPaX6f1e+APiG0SsWD1Z0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=k2c1bts5; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1744400235; bh=twXvR3D12tBJbtQo+qf/To0dHLrK8MG6BVSfsEKZTWQ=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=k2c1bts52CWhE2RnEVZLqXPPtZJeaLK22fPJGcMt9shLJb4o6B5L6t/GMNRHfR5Hn
	 uUBLx7i2i0IXpZv1pmGgUVknueHUYm082h8xBDZEORc7tywf0v4F4Yncbu4UEuksAq
	 HmhZMLxd0brovkDOZKFy2bnf0kRt+RBmvRKUDwjQ=
Date: Fri, 11 Apr 2025 21:37:15 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
Message-ID: <nb4knp52jylojmj3jsvvgq2dsbn3srruxmkqfuto2k3hv3fnqs@6rkqgdved6gi>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net>
 <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
 <6612c4d2-2533-98ef-7c89-f61d80c3e3e2@linux.intel.com>
 <5eb8fd42-b288-4ecb-ae0e-177904cc0a14@roeck-us.net>
 <c34c6dc2-5ab2-1a81-3ba4-b3bc2c016945@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c34c6dc2-5ab2-1a81-3ba4-b3bc2c016945@linux.intel.com>

Hello Ilpo,

On Tue, Apr 01, 2025 at 08:38:48PM +0300, Ilpo Järvinen wrote:
> That log wasn't taken from a bad case but it doesn't matter anymore as I 
> could test this with qemu myself, thanks for providing enough to make it 
> easy to reproduce & test it locally :-).
> 
> The problem is caused by assign+release cycle being destructive on start 
> aligned resources because successful assigment overwrites the start field. 
> I'll send a patch to fix the problem once I've given it a bit more thought
> as this resource fitting code is somewhat complex.

BTW, same thing here on a different SoC:

https://lore.kernel.org/lkml/hrcsm2bo4ysqj2ggejndlou32cdc7yiknnm5nrlcoz4d64wall@7te4dfqsoe3y/T/#u

There are kernel logs there, too, although I don't have dynamic debug enabled
in the kernel.

Interestingly, bisect pointed me initially to a different commit. Reverting
it helped, but just on one board (QuartzPro64).

And this is iomem:

0010f000-0010f0ff : 10f000.sram sram@10f000
00200000-e2bbffff : System RAM
  02010000-0474ffff : Kernel code
  04750000-0498ffff : reserved
  04990000-0508ffff : Kernel data
  daa00000-e29fffff : reserved
e2bc0000-ecbbffff : reserved
  e2bc0000-ecbbffff : reserved
ecbc0000-efffffff : System RAM
  ecbc7000-ecbdffff : reserved
f0000000-f00fffff : a40000000.pcie config
f0200000-f0ffffff : pcie@fe150000
  f0200000-f020ffff : 0000:00:00.0
  f0300000-f03fffff : PCI Bus 0000:01
    f0300000-f0303fff : 0000:01:00.0
      f0300000-f0303fff : nvme
    f0304000-f03040ff : 0000:01:00.0
      f0304000-f03040ff : nvme
f2000000-f20fffff : a40800000.pcie config
f2200000-f2ffffff : pcie@fe170000
  f2200000-f27fffff : PCI Bus 0002:21
    f2200000-f220ffff : 0002:21:00.0
    f2400000-f27fffff : 0002:21:00.0
  f2800000-f280ffff : 0002:20:00.0
f3000000-f30fffff : a40c00000.pcie config
f3200000-f3ffffff : pcie@fe180000
  f3200000-f320ffff : 0003:30:00.0
  f3300000-f33fffff : PCI Bus 0003:31
    f3300000-f3303fff : 0003:31:00.0
    f3304000-f3304fff : 0003:31:00.0
      f3304000-f3304fff : r8169
fb000000-fb1fffff : fb000000.gpu gpu@fb000000
fc00c100-fc3fffff : fc000000.usb usb@fc000000
fc400000-fc407fff : usb@fc400000
  fc400000-fc407fff : xhci-hcd.10.auto usb@fc400000
fc40c100-fc7fffff : fc400000.usb usb@fc400000
fc800000-fc83ffff : fc800000.usb usb@fc800000
fc840000-fc87ffff : fc840000.usb usb@fc840000
fc880000-fc8bffff : fc880000.usb usb@fc880000
fc8c0000-fc8fffff : fc8c0000.usb usb@fc8c0000
fc900000-fc900dff : fc900000.iommu
fc910000-fc910dff : fc900000.iommu
fd600000-fd6fffff : fd600000.sram sram@fd600000
fd8a0000-fd8a00ff : fd8a0000.gpio gpio@fd8a0000
fdb50000-fdb507ff : fdb50000.video-codec video-codec@fdb50000
fdb50800-fdb5083f : fdb50800.iommu iommu@fdb50800
fdb80000-fdb8017f : fdb80000.rga rga@fdb80000
fdba0000-fdba07ff : fdba0000.video-codec video-codec@fdba0000
fdba0800-fdba083f : fdba0800.iommu iommu@fdba0800
fdba4800-fdba483f : fdba4800.iommu iommu@fdba4800
fdba8800-fdba883f : fdba8800.iommu iommu@fdba8800
fdbac800-fdbac83f : fdbac800.iommu iommu@fdbac800
fdc70000-fdc707ff : fdc70000.video-codec video-codec@fdc70000
fdd90000-fdd941ff : fdd90000.vop vop
fdd95000-fdd95fff : fdd90000.vop gamma-lut
fdd97e00-fdd97eff : fdd97e00.iommu iommu@fdd97e00
fdd97f00-fdd97fff : fdd97e00.iommu iommu@fdd97e00
fddf0000-fddf0fff : fddf0000.i2s i2s@fddf0000
fddf4000-fddf4fff : fddf4000.i2s i2s@fddf4000
fde80000-fde9ffff : fde80000.hdmi hdmi@fde80000
fdea0000-fdebffff : fdea0000.hdmi hdmi@fdea0000
fdee0000-fdee5fff : fdee0000.hdmi_receiver hdmi_receiver@fdee0000
fe060000-fe06ffff : fe060000.dfi dfi@fe060000
fe150000-fe15ffff : a40000000.pcie apb
fe170000-fe17ffff : a40800000.pcie apb
fe180000-fe18ffff : a40c00000.pcie apb
fe1b0000-fe1bffff : fe1b0000.ethernet ethernet@fe1b0000
fe210000-fe210fff : fe210000.sata sata@fe210000
fe2c0000-fe2c3fff : fe2c0000.mmc mmc@fe2c0000
fe2e0000-fe2effff : fe2e0000.mmc mmc@fe2e0000
fe470000-fe470fff : fe470000.i2s i2s@fe470000
fe600000-fe60ffff : GICD
fe680000-fe77ffff : GICR
fea10000-fea13fff : dma-controller@fea10000
  fea10000-fea13fff : fea10000.dma-controller dma-controller@fea10000
fea30000-fea33fff : dma-controller@fea30000
  fea30000-fea33fff : fea30000.dma-controller dma-controller@fea30000
feaa0000-feaa0fff : feaa0000.i2c i2c@feaa0000
feaf0000-feaf00ff : feaf0000.watchdog watchdog@feaf0000
feb20000-feb20fff : feb20000.spi spi@feb20000
feb50000-feb500ff : serial
fec00000-fec003ff : fec00000.tsadc tsadc@fec00000
fec10000-fec1ffff : fec10000.adc adc@fec10000
fec20000-fec200ff : fec20000.gpio gpio@fec20000
fec30000-fec300ff : fec30000.gpio gpio@fec30000
fec40000-fec400ff : fec40000.gpio gpio@fec40000
fec50000-fec500ff : fec50000.gpio gpio@fec50000
fec90000-fec90fff : fec90000.i2c i2c@fec90000
fed10000-fed13fff : dma-controller@fed10000
  fed10000-fed13fff : fed10000.dma-controller dma-controller@fed10000
fed60000-fed61fff : fed60000.phy phy@fed60000
fed70000-fed71fff : fed70000.phy phy@fed70000
fed80000-fed8ffff : fed80000.phy phy@fed80000
fed90000-fed9ffff : fed90000.phy phy@fed90000
fee00000-fee000ff : fee00000.phy phy@fee00000
fee10000-fee100ff : fee10000.phy phy@fee10000
fee20000-fee200ff : fee20000.phy phy@fee20000
fee80000-fee9ffff : fee80000.phy phy@fee80000
ff001000-ff0effff : ff001000.sram sram@ff001000
100000000-3fbffffff : System RAM
  3ec000000-3fbffffff : reserved
3fc500000-3ffefffff : System RAM
4f0000000-4ffffffff : System RAM
  4fc611000-4fc6d0fff : reserved
  4fc6d1000-4fded1fff : reserved
  4fded2000-4fdf91fff : reserved
  4fdf93000-4fdf96fff : reserved
  4fdf97000-4fdfabfff : reserved
  4fdfac000-4fe051fff : reserved
  4fe052000-4ffffffff : reserved
900000000-93fffffff : pcie@fe150000
  900000000-93fffffff : 0000:00:00.0
980000000-9bfffffff : pcie@fe170000
9c0000000-9ffffffff : pcie@fe180000
a40000000-a403fffff : a40000000.pcie dbi
a40800000-a40bfffff : a40800000.pcie dbi
a40c00000-a40ffffff : a40c00000.pcie dbi

Thank you,
	o.

> -- 
>  i.


