Return-Path: <linux-pci+bounces-18481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D39F29DA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC26B1667EC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD31C54A5;
	Mon, 16 Dec 2024 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpZIMh0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C01BC064
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329269; cv=none; b=VqD/rHjmab/CIwRwk+XIbSjNi6d6h5mf5IyD6hJp2LFloR/A41TlpL083hJzVlYlsS5gpyI4YIYvLJoYIE9dRSIpZE3EoXM4Ee5cKyXmTBis44XmfjldAQPKpxhmH4ao56+zyLMlOaRAkEC/HaNtzSldfLV1ZE2rUEPyP1077pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329269; c=relaxed/simple;
	bh=JYZl0hdNG4BMCMt12qhHwTv7Y4jJwHE1NKsHSx+SZqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIL66/Enj+Xwgnx81uZjfO08SO/6PE2WZPYWsLrGLDSMm/e2KgMNc6wdOloLLyCO07gDgswFwAA/XLhSWdhKewBlvrCZswBJnGcJZn+11YcUVQDdBY0lCDzXqa5cvNTFDbo6Rjp3GXm0ssiBcCMGYVLQLX6U06MdexHQv2PvbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpZIMh0V; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728eccf836bso3073202b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 22:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734329267; x=1734934067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIvW1ykJTcaYnpCPQyrHZU54o0w1qCWSM5T8sY84ePU=;
        b=NpZIMh0VxyP1aScPubOp4R90/jdPXCEpFRdppiYYrQ+5X7uDVMdnE7vehrPMmNI1c4
         +LxpsPXRT+QYuYUZh2ElFacRTiqg0Owr0kmWGNNy5fiXbIjFB2Yvy6ZfaoHaZKyA6Ow0
         OoSKNZf/MgIrh+16YwuPRk3APMOytBe+Ne77wMZCXnnIADaSIQYYqG8dtS9o3jtiUogK
         rWStq/Zk+9aiDwE5veQQYeOLstjyj5lm9OEkhcT8hPiNeE6KE7kZ16dyPCkKdY9DgJJv
         Kf67RE0A1pnLxd6RTaQ6PZNnAs+gmGpXjVztrMHG3pRijDyjZBSTJ6rEUY65wFwXRBQm
         jn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734329267; x=1734934067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIvW1ykJTcaYnpCPQyrHZU54o0w1qCWSM5T8sY84ePU=;
        b=FN7i+JAe6zVCmAMs8dRIN9SyEyTsZlpa0iWC01gXHjseoyfEKy5JI5h9z+Y15NpAcv
         6uzfnejZ9SyYjXI6MP+ifbK6llf5FzbUeXHRQamekSwDdUL4B1ox1mhn8GRFguRF5dZ9
         mc5nLCh1o/cgLPJdXkN8cu8IexAJw6SoSsttYrBToXN52iTk1s8vgryrNmrUO0DlQ4zi
         AKX4tjt8jP5d9LGx+gHr+pCQtDkhfffEKpWcgFGH+/9DecO/t8K5kPCgWgzNYDAJB8/W
         HctQStO46+TD0LR/n0dMJCEEq/c6uSBlnISQETHfrIeSqeyPn09gQibUDZcNbkGZ6jnF
         fS4A==
X-Forwarded-Encrypted: i=1; AJvYcCVBsjjGbNbGFgLiKsZqCvYswC7fBf25W4o9cmT2XSwyaiViISuh1btI22wSNoRTKuMaRoKTB4Sxi8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5M2uhyFOFlwIw+kEfOJnA3bU+qid7vHVOC4A342012OIQo1p1
	19abyakQf2+Zw5TEYtPpiAzccuSD9UN9Xs/U/nrObM6a1oqG8hLpagqpga1zBA==
X-Gm-Gg: ASbGnctuYodvHGgzGwyMt8LUOCakkJL/noFl+Unjrp/JYV7n4M99ewlvRj13cQnodJ4
	OpDgRXD7Qn1VpgSKu3TneFemYFH6HQiZ3W5Wg66F3njs7H9qSkTA/j9aQe8gXvfrli7fN7c0Ioo
	ilWXYzLKkLOaBFEq0Y9Xcc/+5lWLKbNgCtCsfjbSWO2zMtxiJx9s7OQi/quIeUzRgVvLfqBaw2j
	fUTIxNnDjgqTVW3X6Najr2fSlkgHzZDzo3EZ0ujfwaxBXIiR7pQDVX3kjLr2a3fxAw=
X-Google-Smtp-Source: AGHT+IEjmzOBuhULciZZypBNXLa+4xbf0eH7uAdC5EchG0aKhsBzJYAEf4T7Tg8zJxUpyKp2a5+GfQ==
X-Received: by 2002:a05:6a00:b46:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-7290c2702e3mr17481504b3a.21.1734329266704;
        Sun, 15 Dec 2024 22:07:46 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad7845sm4040968b3a.68.2024.12.15.22.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 22:07:46 -0800 (PST)
Date: Mon, 16 Dec 2024 11:37:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 00/18] NVMe PCI endpoint target driver
Message-ID: <20241216060741.q66ivjcbnmgiffat@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>

On Thu, Dec 12, 2024 at 08:34:22PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.
> 
> The first 4 patches of this series move and cleanup some nvme code that
> will be reused in following patches.
> 
> Patch 5 introduces the PCI transport type to allow setting up ports for
> the new PCI target controller driver. Patch 6 to 9 are improvements of
> the target core code to allow creating the PCI controller and processing
> its nvme commands without the need to rely on fabrics commands like the
> connect command to create the admin and I/O queues.
> 
> Patch 10 relaxes the SGL check in nvmet_req_init() to allow for PCI
> admin commands (which must use PRPs).
> 
> Patches 11 to 15 improve the set/get feature support of the target code
> to get closer to achieving NVMe specification compliance. These patches
> though do not implement support for some mandatory features.
> 
> Patch 16 is the main patch which introduces the NVMe PCI endpoint target
> driver. This patch commit message provides and overview of the driver
> design and operation.
> 
> Finally, patch 17 documents the NVMe PCI endpoint target driver and
> provides a user guide explaning how to setup an NVMe PCI endpoint
> device.
> 
> The patches are base on Linus 6.13-rc2 tree.
> 
> This driver has been extensively tested using a Radxa Rock5B board
> (RK3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
> board. However, this board does not support DMA channels for the PCI
> endpoint controller, leading to very poor performance.
> 
> Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
> with a null-blk block device loop target, performance was measured using
> fio as follows:
> 
>  +----------------------------------+------------------------+
>  | Workload                         | IOPS (BW)              |
>  +----------------------------------+------------------------+
>  | Rand read, 4KB, QD=1, 1 job      | 14.3k IOPS             |
>  | Rand read, 4KB, QD=32, 1 job     | 80.8k IOPS             |
>  | Rand read, 4KB, QD=32, 4 jobs    | 131k IOPS              |
>  | Rand read, 128KB, QD=32, 1 job   | 16.7k IOPS (2.18 GB/s) |
>  | Rand read, 128KB, QD=32, 4 jobs  | 17.4k IOPS (2.27 GB/s) |
>  | Rand read, 512KB, QD=32, 1 job   | 5380 IOPS (2.82 GB/s)  |
>  | Rand read, 512KB, QD=32, 4 jobs  | 5206 IOPS (2.27 GB/s)  |
>  | Rand write, 128KB, QD=32, 1 job  | 9617 IOPS (1.26 GB/s)  |
>  | Rand write, 128KB, QD=32, 4 jobs | 8405 IOPS (1.10 GB/s)  |
>  +----------------------------------+------------------------+
> 
> These results use the default MDTS of the NVMe enpoint driver of 512 KB.
> 
> This driver is not intended for production use but rather to be a
> playground for learning NVMe and exploring/testing new NVMe features
> while providing reasonably good performance.
> 

Damien, thanks for the work! Please wait for my review comments before posting
next version. And sorry about the delay.

- Mani

> Changes from v3:
>  - Added patch 1 which was missing from v3 and caused the 0day build
>    failure
>  - Corrected a few typos in the documentation (patch 18)
>  - Added Christoph's review tag and Rick's tested tag
> 
> Changes from v2:
>  - Changed all preparatory patches before patch 16 to move more NVMe
>    generic code out of the PCI endpoint target driver and into the
>    target core.
>  - Changed patch 16 to use directly a target controller instead of a
>    host controller. Many aspects of the command management and DMA
>    transfer management have also been simplified, leading to higher
>    performance.
>  - Change the documentation patch to match the above changes
> 
> Changes from v1:
>  - Added review tag to patch 1
>  - Modified patch 4 to:
>    - Add Rick's copyright notice
>    - Improve admin command handling (set_features command) to handle the
>      number of queues feature (among others) to enable Windows host
>    - Improved SQ and CQ work items handling
> 
> Damien Le Moal (18):
>   nvme: Move opcode string helper functions declarations
>   nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
>   nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
>   nvmet: Introduce nvmet_get_cmd_effects_admin()
>   nvmet: Add drvdata field to struct nvmet_ctrl
>   nvme: Add PCI transport type
>   nvmet: Improve nvmet_alloc_ctrl() interface and implementation
>   nvmet: Introduce nvmet_req_transfer_len()
>   nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
>   nvmet: Add support for I/O queue management admin commands
>   nvmet: Do not require SGL for PCI target controller commands
>   nvmet: Introduce get/set_feature controller operations
>   nvmet: Implement host identifier set feature support
>   nvmet: Implement interrupt coalescing feature support
>   nvmet: Implement interrupt config feature support
>   nvmet: Implement arbitration feature support
>   nvmet: New NVMe PCI endpoint target driver
>   Documentation: Document the NVMe PCI endpoint target driver
> 
>  Documentation/PCI/endpoint/index.rst          |    1 +
>  .../PCI/endpoint/pci-nvme-function.rst        |   14 +
>  Documentation/nvme/index.rst                  |   12 +
>  .../nvme/nvme-pci-endpoint-target.rst         |  365 +++
>  Documentation/subsystem-apis.rst              |    1 +
>  drivers/nvme/host/nvme.h                      |   39 -
>  drivers/nvme/target/Kconfig                   |   10 +
>  drivers/nvme/target/Makefile                  |    2 +
>  drivers/nvme/target/admin-cmd.c               |  388 ++-
>  drivers/nvme/target/configfs.c                |   49 +
>  drivers/nvme/target/core.c                    |  266 +-
>  drivers/nvme/target/discovery.c               |   17 +
>  drivers/nvme/target/fabrics-cmd-auth.c        |   14 +-
>  drivers/nvme/target/fabrics-cmd.c             |  101 +-
>  drivers/nvme/target/nvmet.h                   |  110 +-
>  drivers/nvme/target/pci-ep.c                  | 2626 +++++++++++++++++
>  include/linux/nvme.h                          |   42 +
>  17 files changed, 3897 insertions(+), 160 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
>  create mode 100644 Documentation/nvme/index.rst
>  create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
>  create mode 100644 drivers/nvme/target/pci-ep.c
> 
> 
> base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

