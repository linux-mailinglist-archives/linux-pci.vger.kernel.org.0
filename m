Return-Path: <linux-pci+bounces-18662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974EF9F53F1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D192216BA25
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECF1F8926;
	Tue, 17 Dec 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAVp+FVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331801F8697
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456614; cv=none; b=rZw6cGA0kdLPfiGVnap11//Pqk7kO21qmgtBo62Lk5WX+thjObFw6doAxOK3pqqSDH0Jw1dF+1WikZsXzhMP6tj2nHdbEaA5WGs84N8kwPV9ivFuz2J6eIUWNgrHFC3dSFkaT+/IY7jdf7D51rZWGizuR6sdxnGMsumwZB4oP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456614; c=relaxed/simple;
	bh=TQ/uua8yf1w9aNSxFGe9oeN2wvmTHaHwQJxbpLndNkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFahudavsuPiU6t61iD/2BVfw+8XjpZNGZE3XhMIM7C7Jk0ENFXXOizN3XbfDOO7dJL/couMAC2OD8FyNALxc+LTSmUW+onnIlQhvFJPpIxmlqduc4e8W3dbJkD+9s+mv0Jc4EKKB1U5G7cyUTKDW06vobiMqPVNrIJQEIPwzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAVp+FVG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725dbdf380aso4503882b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734456611; x=1735061411; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+xHywUTG3T8nnHJJsLo7+dGNhhCWq/6RXmCxpQah/1c=;
        b=cAVp+FVGRMqjwHQpMSRoPqxaJDQMqZJQzhxIBfSCESW+zzN4Xk+PrYgirhQMWuR0Vx
         QwvRTEdWECwIi2XRKZzFL5l69PHWpZ21Z+xoh2RpMPceQBBRDUhsyHxQgch57uibgEjy
         k5MzP0jXqvwFZCRKm+C06juFg+W6kYD7ZFDGJkclhp0D5I4oVDMO22T8xkAhdwQ5t95a
         bpULBlCCs3QBg+XCKs6P41U1fx0bk/r+EqRzFjHShB++kScya49mBf26bXNL0MOMhTW0
         4QZ6be3/MalTfXTtMWPGR5Q40X6kEYSHN7GVVEXN4Ag8kTBhCREQ1JJN17OYdHUa/rCe
         q5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456611; x=1735061411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xHywUTG3T8nnHJJsLo7+dGNhhCWq/6RXmCxpQah/1c=;
        b=Z7PsLQSmAkbAa1ovKWMHC5meennQ2yA7pcrt/y68mqbZkMnDt2+xJGNjXCON2+9m7t
         D0AliJb8jiq8L4xrewzJAd4cpvc3AG8hk6xZexRAUkC82AtYSetvbPTtkD2CeP7BDPSk
         JLTObLxY18D8t7/FcLQPQ3La8Mdcm27qEJq25Gd9iLOgAUQv7RjLsrNB1pck4lsB0dw7
         vKeqhDl5y34uCv3rYhzAheu9Lewd08yDkSMeapHymUgaspNPc5BkK9qa+b0pCt8sVaIk
         mwm4VOI0UbeiSKqOl8MWjlLmpJjOZCDM5nzfsl5vpWyC4yK91z58VMKKJZse8CXW2bux
         0/rA==
X-Forwarded-Encrypted: i=1; AJvYcCX80oHJ78E+EYYt43+qdolu7vUGMtk1oEfOJhyDv+5U3qfgU/MnillfnE4G3zAt033/hfiW+/XTHVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1gyP3+caSxwHPf91F63dAz4MqED3N/rQfQ9spwXgaj6az0gN
	Ezo+2JLdk6qzP2MyKGXMNyu7bqoaCQwF1fbt28tZpCnkVAYzNVO3cKdYtti8QA==
X-Gm-Gg: ASbGncsLAG2zpwdlFRfZzoy4g6cSpSmMC/uzabHT9EnJAswB1B+RIITqi5xjKDOrTFP
	gA16q/e7rc4wDPR/weaS8HbAvp8jDhWT/MJcREFUGd/gL5MLHt+NoheoLPhTm3I8sT9KScwz1iW
	qfVxlUV7ISM/UQPEdogzSzMchlqybK9Sy+UQMbwhHR1Kiv0WHRyw/L22Jm4GEUAO1vbV3DfL7DL
	SpwB2dQbh5k/nIE+jxVlt+c60qJ4eS/1Ib6Y8/C7IHShI8qsXAfe89ykSFUeNIgmSA4
X-Google-Smtp-Source: AGHT+IF3XHZfgaYRS064am1LyqMRt1Q84Sxubj82WzREVte9dMxf6UXF+0npx3mtRwWsvaiC20TnpQ==
X-Received: by 2002:a05:6a00:3d10:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-7290c272caemr24814659b3a.22.1734456611271;
        Tue, 17 Dec 2024 09:30:11 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5ac5sm7173351b3a.67.2024.12.17.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:10 -0800 (PST)
Date: Tue, 17 Dec 2024 23:00:03 +0530
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
Subject: Re: [PATCH v4 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241217173003.sqz67o24z5co7dck@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-19-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212113440.352958-19-dlemoal@kernel.org>

On Thu, Dec 12, 2024 at 08:34:40PM +0900, Damien Le Moal wrote:
> Add a documentation file
> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> endpoint target driver. This provides an overview of the driver
> requirements, capabilities and limitations. A user guide describing how
> to setup a NVMe PCI endpoint device using this driver is also provided.
> 
> This document is made accessible also from the PCI endpoint
> documentation using a link. Furthermore, since the existing nvme
> documentation was not accessible from the top documentation index, an
> index file is added to Documentation/nvme and this index listed as
> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> API index.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-nvme-function.rst        |  14 +
>  Documentation/nvme/index.rst                  |  12 +
>  .../nvme/nvme-pci-endpoint-target.rst         | 365 ++++++++++++++++++
>  Documentation/subsystem-apis.rst              |   1 +
>  5 files changed, 393 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
>  create mode 100644 Documentation/nvme/index.rst
>  create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 4d2333e7ae06..dd1f62e731c9 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -15,6 +15,7 @@ PCI Endpoint Framework
>     pci-ntb-howto
>     pci-vntb-function
>     pci-vntb-howto
> +   pci-nvme-function
>  
>     function/binding/pci-test
>     function/binding/pci-ntb
> diff --git a/Documentation/PCI/endpoint/pci-nvme-function.rst b/Documentation/PCI/endpoint/pci-nvme-function.rst
> new file mode 100644
> index 000000000000..aedcfedf679b
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-nvme-function.rst
> @@ -0,0 +1,14 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +PCI NVMe Function
> +=================
> +
> +:Author: Damien Le Moal <dlemoal@kernel.org>
> +
> +The PCI NVMe endpoint function implements a PCI NVMe controller using the NVMe
> +subsystem target core code. The driver for this function resides with the NVMe
> +subsystem as drivers/nvme/target/nvmet-pciep.c.
> +
> +See Documentation/nvme/nvme-pci-endpoint-target.rst for more details.
> +
> diff --git a/Documentation/nvme/index.rst b/Documentation/nvme/index.rst
> new file mode 100644
> index 000000000000..13383c760cc7
> --- /dev/null
> +++ b/Documentation/nvme/index.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +NVMe Subsystem
> +==============
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> +
> +   feature-and-quirk-policy
> +   nvme-pci-endpoint-target
> diff --git a/Documentation/nvme/nvme-pci-endpoint-target.rst b/Documentation/nvme/nvme-pci-endpoint-target.rst
> new file mode 100644
> index 000000000000..6a96f05daf01
> --- /dev/null
> +++ b/Documentation/nvme/nvme-pci-endpoint-target.rst
> @@ -0,0 +1,365 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +NVMe PCI Endpoint Target
> +========================
> +
> +:Author: Damien Le Moal <dlemoal@kernel.org>
> +
> +The NVMe PCI endpoint target driver implements a PCIe NVMe controller using a
> +NVMe fabrics target controller using the PCI transport type.
> +
> +Overview
> +========
> +
> +The NVMe PCI endpoint target driver allows exposing a NVMe target controller
> +over a PCIe link, thus implementing an NVMe PCIe device similar to a regular
> +M.2 SSD. The target controller is created in the same manner as when using NVMe
> +over fabrics: the controller represents the interface to an NVMe subsystem
> +using a port. The port transfer type must be configured to be "pci". The
> +subsystem can be configured to have namespaces backed by regular files or block
> +devices, or can use NVMe passthrough to expose an existing physical NVMe device
> +or a NVMe fabrics host controller (e.g. a NVMe TCP host controller).
> +
> +The NVMe PCI endpoint target driver relies as much as possible on the NVMe
> +target core code to parse and execute NVMe commands submitted by the PCI RC
> +host. However, using the PCI endpoint framework API and DMA API, the driver is
> +also responsible for managing all data transfers over the PCI link. This
> +implies that the NVMe PCI endpoint target driver implements several NVMe data
> +structure management and some command parsing.
> +
> +1) The driver manages retrieval of NVMe commands in submission queues using DMA
> +   if supported, or MMIO otherwise. Each command retrieved is then executed
> +   using a work item to maximize performance with the parallel execution of
> +   multiple commands on different CPUs. The driver uses a work item to
> +   constantly poll the doorbell of all submission queues to detect command
> +   submissions from the PCI RC host.
> +
> +2) The driver transfers completion queues entries of completed commands to the
> +   PCI RC host using MMIO copy of the entries in the host completion queue.
> +   After posting completion entries in a completion queue, the driver uses the
> +   PCI endpoint framework API to raise an interrupt to the host to signal the
> +   commands completion.
> +
> +3) For any command that has a data buffer, the NVMe PCI endpoint target driver
> +   parses the command PRPs or SGLs lists to create a list of PCI address
> +   segments representing the mapping of the command data buffer on the host.
> +   The command data buffer is transferred over the PCI link using this list of
> +   PCI address segments using DMA, if supported. If DMA is not supported, MMIO
> +   is used, which results in poor performance. For write commands, the command
> +   data buffer is transferred from the host into a local memory buffer before
> +   executing the command using the target core code. For read commands, a local
> +   memory buffer is allocated to execute the command and the content of that
> +   buffer is transferred to the host once the command completes.
> +
> +Controller Capabilities
> +-----------------------
> +
> +The NVMe capabilities exposed to the PCI RC host through the BAR 0 registers
> +are almost identical to the capabilities of the NVMe target controller
> +implemented by the target core code. There are some exceptions.
> +
> +1) The NVMe PCI endpoint target driver always sets the controller capability
> +   CQR bit to request "Contiguous Queues Required". This is to facilitate the
> +   mapping of a queue PCI address range to the local CPU address space.
> +
> +2) The doorbell stride (DSTRB) is always set to be 4B
> +
> +3) Since the PCI endpoint framework does not provide a way to handle PCI level
> +   resets, the controller capability NSSR bit (NVM Subsystem Reset Supported)
> +   is always cleared.
> +
> +4) The boot partition support (BPS), Persistent Memory Region Supported (PMRS)
> +   and Controller Memory Buffer Supported (CMBS) capabilities are never reported.
> +
> +Supported Features
> +------------------
> +
> +The NVMe PCI endpoint target driver implements support for both PRPs and SGLs.
> +The driver also implements IRQ vector coalescing and submission queue
> +arbitration burst.
> +
> +The maximum number of queues and the maximum data transfer size (MDTS) are
> +configurable through configfs before starting the controller. To avoid issues
> +with excessive local memory usage for executing commands, MDTS defaults to 512
> +KB and is limited to a maximum of 2 MB (arbitrary limit).
> +
> +Mimimum number of PCI Address Mapping Windows Required
> +------------------------------------------------------
> +
> +Most PCI endpoint controllers provide a limited number of mapping windows for
> +mapping a PCI address range to local CPU memory addresses. The NVMe PCI
> +endpoint target controllers uses mapping windows for the following.
> +
> +1) One memory window for raising MSI or MSI-X interrupts
> +2) One memory window for MMIO transfers
> +3) One memory window for each completion queue
> +
> +Given the highly asynchronous nature of the NVMe PCI endpoint target driver
> +operation, the memory windows as described above will generally not be used
> +simultaneously, but that may happen. So a safe maximum number of completion
> +queues that can be supported is equal to the total number of memory mapping
> +windows of the PCI endpoint controller minus two. E.g. for an endpoint PCI
> +controller with 32 outbound memory windows available, up to 30 completion
> +queues can be safely operated without any risk of getting PCI address mapping
> +errors due to the lack of memory windows.
> +
> +Maximum Number of Queue Pairs
> +-----------------------------
> +
> +Upon binding of the NVMe PCI endpoint target driver to the PCI endpoint
> +controller, BAR 0 is allocated with enough space to accommodate the admin queue
> +and multiple I/O queues. The maximum of number of I/O queues pairs that can be
> +supported is limited by several factors.
> +
> +1) The NVMe target core code limits the maximum number of I/O queues to the
> +   number of online CPUs.
> +2) The total number of queue pairs, including the admin queue, cannot exceed
> +   the number of MSI-X or MSI vectors available.
> +3) The total number of completion queues must not exceed the total number of
> +   PCI mapping windows minus 2 (see above).
> +
> +The NVMe endpoint function driver allows configuring the maximum number of
> +queue pairs through configfs.
> +
> +Limitations and NVMe Specification Non-Compliance
> +-------------------------------------------------
> +
> +Similar to the NVMe target core code, the NVMe PCI endpoint target driver does
> +not support multiple submission queues using the same completion queue. All
> +submission queues must specify a unique completion queue.
> +
> +
> +User Guide
> +==========
> +
> +This section describes the hardware requirements and how to setup an NVMe PCI
> +endpoint target device.
> +
> +Kernel Requirements
> +-------------------
> +
> +The kernel must be compiled with the configuration options CONFIG_PCI_ENDPOINT,
> +CONFIG_PCI_ENDPOINT_CONFIGFS, and CONFIG_NVME_TARGET_PCI_EP enabled.
> +CONFIG_PCI, CONFIG_BLK_DEV_NVME and CONFIG_NVME_TARGET must also be enabled
> +(obviously).
> +
> +In addition to this, at least one PCI endpoint controller driver should be
> +available for the endpoint hardware used.
> +
> +To facilitate testing, enabling the null-blk driver (CONFIG_BLK_DEV_NULL_BLK)
> +is also recommended. With this, a simple setup using a null_blk block device
> +as a subsystem namespace can be used.
> +
> +Hardware Requirements
> +---------------------
> +
> +To use the NVMe PCI endpoint target driver, at least one endpoint controller
> +device is required.
> +
> +To find the list of endpoint controller devices in the system::
> +
> +       # ls /sys/class/pci_epc/
> +        a40000000.pcie-ep
> +
> +If PCI_ENDPOINT_CONFIGFS is enabled::
> +
> +       # ls /sys/kernel/config/pci_ep/controllers
> +        a40000000.pcie-ep
> +
> +The endpoint board must of course also be connected to a host with a PCI cable
> +with RX-TX signal swapped. If the host PCI slot used does not have
> +plug-and-play capabilities, the host should be powered off when the NVMe PCI
> +endpoint device is configured.
> +
> +NVMe Endpoint Device
> +--------------------
> +
> +Creating an NVMe endpoint device is a two step process. First, an NVMe target
> +subsystem and port must be defined. Second, the NVMe PCI endpoint device must be
> +setup and bound to the subsystem and port created.
> +
> +Creating a NVMe Subsystem and Port
> +----------------------------------
> +
> +Details about how to configure a NVMe target subsystem and port are outside the
> +scope of this document. The following only provides a simple example of a port
> +and subsystem with a single namespace backed by a null_blk device.
> +
> +First, make sure that configfs is enabled::
> +
> +       # mount -t configfs none /sys/kernel/config
> +
> +Next, create a null_blk device (default settings give a 250 GB device without
> +memory backing). The block device created will be /dev/nullb0 by default::
> +
> +        # modprobe null_blk
> +        # ls /dev/nullb0
> +        /dev/nullb0
> +
> +The NVMe target core driver must be loaded::
> +
> +        # modprobe nvmet
> +        # lsmod | grep nvmet
> +        nvmet                 118784  0
> +        nvme_core             131072  1 nvmet
> +
> +Now, create a subsystem and a port that we will use to create a PCI target
> +controller when setting up the NVMe PCI endpoint target device. In this
> +example, the port is created with a maximum of 4 I/O queue pairs::
> +
> +        # cd /sys/kernel/config/nvmet/subsystems
> +        # mkdir nvmepf.0.nqn
> +        # echo -n "Linux-nvmet-pciep" > nvmepf.0.nqn/attr_model
> +        # echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
> +        # echo "0x1b96" > nvmepf.0.nqn/attr_subsys_vendor_id
> +        # echo 1 > nvmepf.0.nqn/attr_allow_any_host
> +        # echo 4 > nvmepf.0.nqn/attr_qid_max
> +
> +Next, create and enable the subsystem namespace using the null_blk block device::
> +
> +        # mkdir nvmepf.0.nqn/namespaces/1
> +        # echo -n "/dev/nullb0" > nvmepf.0.nqn/namespaces/1/device_path
> +        # echo 1 > "pci_epf_nvme.0.nqn/namespaces/1/enable"

I have to do, 'echo 1 > nvmepf.0.nqn/namespaces/1/enable'

> +
> +Finally, create the target port and link it to the subsystem::
> +
> +        # cd /sys/kernel/config/nvmet/ports
> +        # mkdir 1
> +        # echo -n "pci" > 1/addr_trtype
> +        # ln -s /sys/kernel/config/nvmet/subsystems/nvmepf.0.nqn \
> +                /sys/kernel/config/nvmet/ports/1/subsystems/nvmepf.0.nqn
> +
> +Creating a NVMe PCI Endpoint Device
> +-----------------------------------
> +
> +With the NVMe target subsystem and port ready for use, the NVMe PCI endpoint
> +device can now be created and enabled. The NVMe PCI endpoint target driver
> +should already be loaded (that is done automatically when the port is created)::
> +
> +        # ls /sys/kernel/config/pci_ep/functions
> +        nvmet_pciep
> +
> +Next, create function 0::
> +
> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pciep
> +        # mkdir nvmepf.0
> +        # ls nvmepf.0/
> +        baseclass_code    msix_interrupts   secondary
> +        cache_line_size   nvme              subclass_code
> +        deviceid          primary           subsys_id
> +        interrupt_pin     progif_code       subsys_vendor_id
> +        msi_interrupts    revid             vendorid
> +
> +Configure the function using any vendor ID and device ID::
> +
> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pciep
> +        # echo 0x1b96 > nvmepf.0/vendorid
> +        # echo 0xBEEF > nvmepf.0/deviceid
> +        # echo 32 > nvmepf.0/msix_interrupts
> +
> +If the PCI endpoint controller used does not support MSIX, MSI can be
> +configured instead::
> +
> +        # echo 32 > nvmepf.0/msi_interrupts
> +
> +Next, let's bind our endpoint device with the target subsystem and port that we
> +created::
> +
> +        # echo 1 > nvmepf.0/portid

	'echo 1 > nvmepf.0/nvme/portid'

> +        # echo "nvmepf.0.nqn" > nvmepf.0/subsysnqn

	'echo 1 > nvmepf.0/nvme/subsysnqn'

> +
> +The endpoint function can then be bound to the endpoint controller and the
> +controller started::
> +
> +        # cd /sys/kernel/config/pci_ep
> +        # ln -s functions/nvmet_pciep/nvmepf.0 controllers/a40000000.pcie-ep/
> +        # echo 1 > controllers/a40000000.pcie-ep/start
> +
> +On the endpoint machine, kernel messages will show information as the NVMe
> +target device and endpoint device are created and connected.
> +

For some reason, I cannot get the function driver working. Getting this warning
on the ep:

	nvmet: connect request for invalid subsystem 1!

I didn't debug it further. Will do it tomorrow morning and let you know.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

