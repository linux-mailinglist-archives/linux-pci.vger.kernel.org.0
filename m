Return-Path: <linux-pci+bounces-18255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537FB9EE462
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFBB163DF0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9720B1F7;
	Thu, 12 Dec 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5ZG62YZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4610F2
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000176; cv=none; b=jB4/wdk/hNeGMjqpMQgzjUmkBUd4pcwHsh7pvTOiskds4t09hZX528x98eoFKUhm+PkasT8KEiz71VVZ88R+xW2N1V9eKnaDz4ibRfgPaZQs4s6tQyYnI7mSy8PaCYPb0+iJsbGjkjJhyolvs2U/kth9JTMuLvMQn27Hku6LWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000176; c=relaxed/simple;
	bh=7Bj6zBbR1rPHQvsSOuLOKBNyiBtc6c9k6fUNqYm2/r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H80/O4pBLUHzNPdpOUjRzN0kM7TgAgENevvHzgCqHMwzrwhKNdzC9WWit0ie06in8IoYVxpwX0MACAZSeGAAythh3UyZoIP/9ncLP7DRECmXhB8sUmxr9P4njOnP+06kHurI2qH33f0hLRoCnLTxsWV22f2sqzkysWoUfC/eYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5ZG62YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E2C4CECE;
	Thu, 12 Dec 2024 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734000176;
	bh=7Bj6zBbR1rPHQvsSOuLOKBNyiBtc6c9k6fUNqYm2/r4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u5ZG62YZ6VK1eB1akKbDWHsztpnf7u3HX6HZyWbTOTFxRuSnfe2PT0fNSsHKezkaE
	 bT6PmRk/1JmMtfKCutrPDqUwOaDIKEpzHQFGw+kKNXLD4O114AhVwsmjkHXQga4R0f
	 APz9G2SxsDBUGCyA+dp3KWzRMPzHHiK/bBdn7Y3jTwqXiY5NvgOc77cI7Mk7QIU71c
	 a+qbUu0AkJbz/uUNndtyn+g+tgYKdsoX/pn3nCI1P0lC+T0u964uYLi3U+OjiPTAkJ
	 vFt+A80z4b4W+TSQqCW92ahzzI84ZrrA/LRI3XFryLeNanXoDFsfiO8+2y2a0Y0+9/
	 hRQYNPzjY+JJw==
Message-ID: <795166be-d5cc-4c9f-99a6-567000a4a2a4@kernel.org>
Date: Thu, 12 Dec 2024 19:42:53 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
 <CAAEEuhotOFTYc27n8wsnPtJ1fW2GHk5zRp3EeytjH=EZ2gxd5Q@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAEEuhotOFTYc27n8wsnPtJ1fW2GHk5zRp3EeytjH=EZ2gxd5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 19:16, Rick Wertenbroek wrote:
> Hello,
> I have tested the NVMe endpoint function extensively on two extra
> platforms to run on, the FriendlyElec CM3588+NAS Kit [1] and NanoPC T6
> [2] (with PCIe x1, x2, and x4 links).
> 
> Besides testing with Linux based hosts (Ubuntu 20.04, 23.10, 24.04), I
> also tested that the NVMe device is recognized by a Windows 10
> Enterprise host and can be formatted and used as a regular disk. I
> also tested on MacOS Monterey on a Macbook Pro 2016 (Intel based) host
> through a M.2 to USB-C adapter [3], the drive is recognized and
> usable.
> 
> The USB-C adapter is based on the ASM2464PD chipset [4] which does
> USB4/Thunderbolt to PCIe/NVMe, I tested with PCI over Thunderbolt with
> the MacOS host, so the host sees the NVMe endpoint function directly
> as a PCI device and the NVMe drive is seen as such. This works well.
> 
> The only test case that did not work is when I tested the ASM2464PD
> chipset NVMe to regular USB functionality, where the chipset is the
> host, and presents itself to the PC as a "usb-storage" class device,
> but this didn't work because the ASM2464PD never enabled the NVMe
> controller (CC.EN bit in BAR0), the PCI Link between the ASM2464PD and
> endpoint function gets up however, and to the host PC the USB device
> is recognized ("usb-storage" class, like a USB stick, e.g., /dev/sda),
> but it cannot be read (shows as 0B block device). As I cannot debug
> the chipset itself I don't know why the NVMe endpoint doesn't get
> enabled. This might very well be a quirk in the ASM2464PD chipset and
> is a very specific use case so I don't think it indicates any major
> issues with the endpoint function, but I report it here for the sake
> of completion.
> 
> I have tested with different storage backend devices for actual
> storage (USB, eMMC, and NVMe (PCIe x1, x2) on the NAS kit).
> 
> In summary, over PCI the endpoint function works well with all three
> Linux/MacOS/Windows hosts.
> 
> Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> (I don't know if this applies as I co-developed the endpoint function
> with Damien)

I think it does apply since I only tested with Linux hosts. Thanks a lot for all
the extra testing !

Sending v4 with the build failure fixed and doc typos fixed.

> 
> Best regards,
> Rick
> 
> [1] https://wiki.friendlyelec.com/wiki/index.php/CM3588
> [2] https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6
> [3] https://www.aliexpress.com/item/1005006316029054.html
> [4] https://www.asmedia.com.tw/product/802zX91Yw3tsFgm4/C64ZX59yu4sY1GW5/ASM2464PD
> 


-- 
Damien Le Moal
Western Digital Research

