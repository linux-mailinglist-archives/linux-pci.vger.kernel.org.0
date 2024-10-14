Return-Path: <linux-pci+bounces-14443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1261B99C752
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E50B2484C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0618453C;
	Mon, 14 Oct 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElZoaXLt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CB183CA2
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902482; cv=none; b=rcOUvV27sD/NHCyoqyuokHkFMSSS5bS3rGR4ocZvjow6GDIOmeVdavUmUgCMRDS7EZNcoCUi9GMd4JDp8IJ5p97j+x33La/lOq7hUtgn8ilcFVlzH1OH9n83lrr0xpe13OmM9gOJU5n89lmT6I74VYzLcgs0Vdb2EqFl+9HXfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902482; c=relaxed/simple;
	bh=B9CmGqSiB0qg80nzJv8rM8Wv+9unf2VSkjZ7TkKL7rg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MswvTAEJdLRKhWz8vw+hvfByZBtYXIEwTXi1O72UD5JOgQh4M9B5okEiAY3AQlEug0navTJaIjUJ0sJN0UihFKirKMN6iIyYN+glUs6S2g/Ox+RyiZQ7m68n/YXvUc4ndS4Vk9fpbh5+zEcBxknCpz4H6oGUc5OCPQbOa1yrYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElZoaXLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC83C4CEC3;
	Mon, 14 Oct 2024 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728902482;
	bh=B9CmGqSiB0qg80nzJv8rM8Wv+9unf2VSkjZ7TkKL7rg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ElZoaXLt/T7F0mSPpWzd6vA/w6/0LR/Z5wYJ7JqL66xEGSs4AHCFkvfzVziOMssvh
	 GyuzvJ0BsvJWN4EnokWdtzlnGMWOp/GUt+HSED0lv8SjnExhuVcfqfvtps5mxbrAER
	 DBWnpYpvdP2RIU/7/hsBGWJiffvd/cSTHMYXZGhyE73sr4t2S7oun9vdm88Bgqt6sC
	 +X0gWw8cx99OOpsfOHhKNfzty6hM0Q54LHYNAgWaOuZ9D/MFhvWDI2QxFXdiFOdFKt
	 go4z9picDkPzPIAGmqel6zJyjGfjf6mGtMzwtEBdijo4EzjS9/546X3DAFSFKioV+G
	 Y6w/4JS20XJvg==
Message-ID: <79e57ebb-eef7-48b1-b337-845d2ef6ff49@kernel.org>
Date: Mon, 14 Oct 2024 19:41:18 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-5-dlemoal@kernel.org> <20241014084424.GC23780@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241014084424.GC23780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 17:44, Christoph Hellwig wrote:
> For one please keep nvme target code in drivers/nvme/  PCI endpoint is
> just another transport and should not have device class logic.
> 
> But I also really fail to understand the architecture of the whole
> thing.  It is a target driver and should in no way tie into the NVMe
> host code, the host code runs on the other side of the PCIe wire.

Nope, it is not a target driver. It is a PCI endpoint driver which turns the
host running it into a PCIe NVMe device. But the NVMe part implementation is
minimal. Instead I use an endpoint local fabrics host controller which is itself
connected to whatever target you want (loop, tcp, ...).

Overall, it looks like this:

         +-----------------------------------+
         | PCIe Host Machine (Root-Complex)  |
         | (BIOS, Grub, Linux, Windows, ...) |
         |                                   |
         |       +------------------+        |
         |       | NVMe PCIe driver |        |
         +-------+------------------+--------+
                           |
                 PCIe bus  |
                           |
        +----+---------------------------+-----+
        |    | PCIe NVMe endpoint driver |     |
	|    | (Handles BAR registers,   |     |
	|    | doorbells, IRQs, SQs, CQs |     |
	|    | and DMA transfers)        |     |
        |    +---------------------------+     |
        |                  |                   |
        |    +---------------------------+     |
        |    |     NVMe fabrics host     |     |
        |    +---------------------------+     |
        |                  |                   |
        |    +---------------------------+     |
        |    |     NVMe fabrics target   |     |
        |    |      (loop, TCP, ...)     |     |
        |    +---------------------------+     |
        |                                      |
        | PCIe Endpoint Machine (e.g. Rock 5B) |
        +--------------------------------------+

The nvme target can be anything that can be supported with the PCI Endpoint
Machine. With a small board like the Rock 5B, it is loop (file and block
device), TCP target or NVMe passtrhough (using the PCIe Gen2 M.2 E-Key slot).

Unless I am mistaken, if I use a PCI transport as the base for the endpoint
driver, I would be able to connect only to a PCIe nvme device as the backend, no
? With the above design, I can use anything support by nvmf as backend and that
is exposed to the root-complex host through the nvme endpoint PCIe driver.
To do that, the PCI endpoint driver mostly need only to create the fabrics host
with nvmf_create_ctrl(), which connects to the target and then the nvme endpoint
driver can execute the nvme commands with __nvme_submit_sync_cmd().
Only some admin commands need special handling (e.g. create sq/cq).

-- 
Damien Le Moal
Western Digital Research

