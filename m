Return-Path: <linux-pci+bounces-23444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E8A5CABA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F183B10EA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A525F964;
	Tue, 11 Mar 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZTDGfmp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39D25BAD4;
	Tue, 11 Mar 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710249; cv=none; b=qrTmXlYAhO52oiIO+RrYw5UwMXkFS3/Yl5PP/MUwrVmxeY+LyqFEpf/fDlEzOSryAntCndIJLMVmmAXzlMIvHybElqCoEaQVGoL7oDJFfCVxJKQTionUCsTxDM4RDyl7GUq9YQHz5NeajJlN9cExsIRIRNhSLLE2xS2BM3YkSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710249; c=relaxed/simple;
	bh=nXe3R0re1wgRRhxOhMXY7RwYTb3+jmhO3ZG8W4xPmZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QwrEd+9UKfn+dsz6BTeu1a0hfvGmpyBQMe1ahoOKhxo5Rni+VkGXVBArLhEvu7JGxJ73r1Q96geeuu3WzyyIHgZ+KSIYIg6XqSfYwnlcQhaCTCIEGH86CZJ0TxI2jID9yxA1WTNhg/t4Wp/8cIQDDdAUwissgzubp+rVgrsiono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZTDGfmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCC7C4CEE9;
	Tue, 11 Mar 2025 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741710248;
	bh=nXe3R0re1wgRRhxOhMXY7RwYTb3+jmhO3ZG8W4xPmZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lZTDGfmpWe8BmEyupmTO7IFBO/BWxrrAhLr80XbWppijBKIjNAiF7FN7uDfNZW5Bh
	 lxXWesoFTKnDpIkXLeetF35ddBMnoZutK9hsXT3IZn5GaXFn+EoiKa3VAR6xsENtdM
	 falIngzJXuUsslfHQlBvh4plDy8pyySblVi8d1H3wVv13CR14SIvVceDY4+Z0YZ8WA
	 yMnasmqvZ2CKHb5gAyF8I8VWe8eqU6+LEVuvdKZSpHvF7hg58G9A5YyGIF+hn2InPs
	 HAXM2oXEHreWefdos5P9BOviiYPH+CwTxU2ZJbh3RbPIAER0wo9h4hOZ1kP/M9hXjL
	 yAk0fHEg6zFhA==
Date: Tue, 11 Mar 2025 11:24:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <20250311162407.GA630741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1qwHf5no6B2eCX1U7NGe-BoJYFLTHPkbM=_XpgrMAE2dw@mail.gmail.com>

On Sun, Mar 09, 2025 at 11:10:58PM +0000, Luís Mendes wrote:
> All logs presented were obtained from a SolidRun A388 ClearFog Base,
> if more detailed PCI logs are needed I have the other machine, the
> Armada Duo that has 2 PCIe slots and handles an AMD RX 550 GPU. Just
> let me know.
> 
> - Complete dmesg log, booted with "pci=nomsi"  is available here:
> https://pastebin.com/wDj0NGFN
> - Complete output of "sudo lspci -vv" is available here:
> https://pastebin.com/f4yHRhLr
> - Contents of /proc/interrupts is available here: https://pastebin.com/ejDUuhbJ
> - Output of "grep -r . /proc/irq/" is available here:
> https://pastebin.com/4jvFBBhy

Thank you very much for these.

It looks like the only PCI device is 01:00.0: [1ac1:089a], a Coral
Edge TPU, and I don't see any evidence of a driver for it or any IRQ
usage.  Do you have any other PCI device you could try there?
Something with a driver that uses interrupts?

Not critical right now, but I'm puzzled by this part of the dmesg log:

  mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
  mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
  mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
  mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
  mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
  pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address [0x00080000-0x00081fff])
  pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
  pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address [0x00044000-0x00045fff])
  pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address [0x00048000-0x00049fff])
  pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]

The first four mvebu-pcie lines make good sense and match the
first four pci_bus lines.  But I don't know where the
[mem 0xe0000000-0xe7ffffff] aperture came from.  It should be
described in the devicetree, but I don't see it mentioned in the
/soc/pcie ranges.

Can you include the devicetree as well?

