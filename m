Return-Path: <linux-pci+bounces-18246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDB9EE3F1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B77F160451
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354221EC4D0;
	Thu, 12 Dec 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSsWCZT2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428820E6E8
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998626; cv=none; b=XBdtUs8YDcCiO91kmkN+eneyo4qk1wf/1HCi/Rr7kodmpTt0Je3g1WR48aB/yrP2hoeMffV2tLd0cl7Rsiqwk4H9Jl78v7OBalBn2TDppFyOv5WN+vSRnvgH+mY/WecMh3wNGPW5LtRXZuVU1amgg7AzI5fseyFtj75RcvMoqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998626; c=relaxed/simple;
	bh=j6sNSSpKZ3LKKYS3NHkAfIesC05rsXqB571iPrdFdr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsjrQztojze8XECVHapCSLnTSkv72ok3V06Uzlsk7HOus3rNLw+yRGrpn9jtvmALD/20YBy+L3MYvWa67mpk8awdfqXKBaw/TRoBWiX1+ZEHbCiZCxpJkTwYhxqlvCjit/ybPWDtP9U4w1M4ppyda10XRwJUJNxlgbiQua/SdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSsWCZT2; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e39779a268bso334150276.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998623; x=1734603423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j6sNSSpKZ3LKKYS3NHkAfIesC05rsXqB571iPrdFdr8=;
        b=jSsWCZT2ubEWqVsyhXW2500C/TKUFPzdQXqK+4nf76ekBGei4Xfco0UxRgG5YpLybM
         dYFij3QUFg5bNCwDIOo8vO5FXKFsGxLiYVMRimTrh5EPK6TN+2H4irs2ZuQcVfDXbiU5
         E7O/eQa1QHllVI9cL7v2lx/5lJhjhFkZTkNudK9IJQQqjJzDw3y7f1k+MaZxXHIX/qjx
         tNIELWsf6r2KPUcp2zxuubWxXBmz3caIKp38fQXH+xaOgkzpUANZB+qdLHwbLsbVFTWr
         se9bYe8haKv5ZCXQ+autgWh1vmOKhCtaGVwrcu/FibwR7m00P0VcMSPtjE0SB/BBOAYU
         FLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998623; x=1734603423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6sNSSpKZ3LKKYS3NHkAfIesC05rsXqB571iPrdFdr8=;
        b=librAGMpnfCK6cxriJRSykdRD0Gu9Mt5uYLcCNlKa7+MjrgcfWKu/hTDCn3PWZsyXO
         dQf1ZHFUN/yBvaRYnuH19fAqjXnbteoEhGIlhirOuAdkCutHgtN/FLyzhqjf8Lj35+qX
         6FM2lcqsycJ2djs2m1xwstf41u0BvNLSlMqZv2drZCHFRxRPseXyFtC9iIkKJkCVWKdF
         eVRHAKdcLiXk/eg4YvcBE5jdPnim+CuUy4hzEXNPoW4QxEiIUUili/Lll/Yqiny/3Z2l
         cmHBH0Vfq26B2gp9GRXgASJgVE6TlaqcMXwfiNawznA6jlrJmu0blRLX51pN0zn/hFhM
         4X+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRS2ltHdWWi0+q7va3G6Yp0YPUuoOruTf475bBg/qoZRibKE2+8I1a1D61v7nk+7/iVjHBnISO0qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQHdDahwA5Ki89qkfd5pG7sSUwN+JvdbPDCsMuyWepLej3ljw
	6aEBe6PtZUbN0hs41W6golKwWsid6IIEfNHFZ3ZBuzkjVtGky2ndDNlxqtvKfBtcBUcVKBn0Ce3
	j2cBgQee5xUr70TWFlKecCaFokzQ=
X-Gm-Gg: ASbGnctbejyaBowUU9hBrWMV7Qs3sTChxOMMVtcmW8tYS7LKNNnBDnNqdnqKRbvOkKv
	DY9BCiyq5sisL2hZlla0nw+ebE2UQxs17EDX92OA=
X-Google-Smtp-Source: AGHT+IFQ0mnoL4s3ntbi4EPBBc/tu7a6QOuEiTV3ORYuJ4Ti5V51Ij6T2l2YWjVzp70tafOWDPy1U2td8emRHbbjmWs=
X-Received: by 2002:a25:8284:0:b0:e38:81cc:f95 with SMTP id
 3f1490d57ef6-e3dc9270f8amr1913454276.10.1733998623325; Thu, 12 Dec 2024
 02:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210093408.105867-1-dlemoal@kernel.org>
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 12 Dec 2024 11:16:26 +0100
Message-ID: <CAAEEuhotOFTYc27n8wsnPtJ1fW2GHk5zRp3EeytjH=EZ2gxd5Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,
I have tested the NVMe endpoint function extensively on two extra
platforms to run on, the FriendlyElec CM3588+NAS Kit [1] and NanoPC T6
[2] (with PCIe x1, x2, and x4 links).

Besides testing with Linux based hosts (Ubuntu 20.04, 23.10, 24.04), I
also tested that the NVMe device is recognized by a Windows 10
Enterprise host and can be formatted and used as a regular disk. I
also tested on MacOS Monterey on a Macbook Pro 2016 (Intel based) host
through a M.2 to USB-C adapter [3], the drive is recognized and
usable.

The USB-C adapter is based on the ASM2464PD chipset [4] which does
USB4/Thunderbolt to PCIe/NVMe, I tested with PCI over Thunderbolt with
the MacOS host, so the host sees the NVMe endpoint function directly
as a PCI device and the NVMe drive is seen as such. This works well.

The only test case that did not work is when I tested the ASM2464PD
chipset NVMe to regular USB functionality, where the chipset is the
host, and presents itself to the PC as a "usb-storage" class device,
but this didn't work because the ASM2464PD never enabled the NVMe
controller (CC.EN bit in BAR0), the PCI Link between the ASM2464PD and
endpoint function gets up however, and to the host PC the USB device
is recognized ("usb-storage" class, like a USB stick, e.g., /dev/sda),
but it cannot be read (shows as 0B block device). As I cannot debug
the chipset itself I don't know why the NVMe endpoint doesn't get
enabled. This might very well be a quirk in the ASM2464PD chipset and
is a very specific use case so I don't think it indicates any major
issues with the endpoint function, but I report it here for the sake
of completion.

I have tested with different storage backend devices for actual
storage (USB, eMMC, and NVMe (PCIe x1, x2) on the NAS kit).

In summary, over PCI the endpoint function works well with all three
Linux/MacOS/Windows hosts.

Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
(I don't know if this applies as I co-developed the endpoint function
with Damien)

Best regards,
Rick

[1] https://wiki.friendlyelec.com/wiki/index.php/CM3588
[2] https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6
[3] https://www.aliexpress.com/item/1005006316029054.html
[4] https://www.asmedia.com.tw/product/802zX91Yw3tsFgm4/C64ZX59yu4sY1GW5/ASM2464PD

