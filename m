Return-Path: <linux-pci+bounces-14313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64F99A3C0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7F8287F2B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E52216A3B;
	Fri, 11 Oct 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEQKvnaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E4802
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649205; cv=none; b=FuRTq/ri5469Z0zIaplrxzePes74RwgQnOavWnrOp9Wx5KCMeUrR1hpBjjki+0rBzi1RW6flO72IrlglkBtoCmOahtg7aQoEQQN+KGwnGCGCUpaQeHCbnO8kloQGEjFLVxDUUsIM5FYstT97HTwKjUdSKrE91xvBtJcFItnZBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649205; c=relaxed/simple;
	bh=l1AhmbDvh9axEVcFE3ZHVaOPS0jik07VFsLdb/5x1KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToIDu5hy7bpn9EvpMyO/rYKMMdYlxkRB1X9NoWjKWvfBx+AL0unlc0Ey5SnjLL/q42bOVd6refa6h00QK1kLz4fvfTNEZk9Q1QCdQvytluEWdiR9AZmIFjGiMKEBM0ECpKxUsGJ9cr16Z5ju/wANXF9JOtBHcniTZlm87lN/Tx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEQKvnaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F96C4CED1;
	Fri, 11 Oct 2024 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649205;
	bh=l1AhmbDvh9axEVcFE3ZHVaOPS0jik07VFsLdb/5x1KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEQKvnaA3mbv1hbpDLzYyOeTa9uxmxisvg/HmXRPqv930I+UV5B1LTYGEXp1eR2kj
	 PW/E1CML2+wttZbY+Z3ui70OuoRL7i0hl7hOGHnJ5pM7pS2E39cNyAa9SkPXdmewJG
	 1lSSRK/wBVaQKpNcYigRrEvHVILIU9xIkddDmaKJTJFU2CUhfbZNIFVRl/mvlpvmAf
	 7wPgVeCfQTWhIi3b7nWNw46HisStD3KkrEV0TCifJ21OWMh3AORpJYkOyolC2ijAAE
	 p+oZwpW4oBZQ5OjhZoAI2sFY92e3la1gkURtwmY2wUBHLVuBw/MxthEGuIgx3qKy/Q
	 HNJnfeoHwD2Tw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 5/5] PCI: endpoint: Document the NVMe endpoint function driver
Date: Fri, 11 Oct 2024 21:19:51 +0900
Message-ID: <20241011121951.90019-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121951.90019-1-dlemoal@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation files:
 - Documentation/PCI/endpoint/pci-nvme-function.rst
 - Documentation/PCI/endpoint/pci-nvme-howto.rst
 - Documentation/PCI/endpoint/function/binding/pci-nvme.rst

To respectively document the NVMe PCI endpoint function driver
internals, provide a user guide explaning how to setup an NVMe endpoint
device and describe the NVMe endpoint function driver binding
attributes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../endpoint/function/binding/pci-nvme.rst    |  34 ++++
 Documentation/PCI/endpoint/index.rst          |   3 +
 .../PCI/endpoint/pci-nvme-function.rst        | 151 ++++++++++++++
 Documentation/PCI/endpoint/pci-nvme-howto.rst | 189 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 5 files changed, 379 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-nvme.rst
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-howto.rst

diff --git a/Documentation/PCI/endpoint/function/binding/pci-nvme.rst b/Documentation/PCI/endpoint/function/binding/pci-nvme.rst
new file mode 100644
index 000000000000..d80293c08bcd
--- /dev/null
+++ b/Documentation/PCI/endpoint/function/binding/pci-nvme.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+PCI NVMe Endpoint Function
+==========================
+
+1) Create the function subdirectory pci_epf_nvme.0 in the
+pci_ep/functions/pci_epf_nvme directory of configfs.
+
+Standard EPF Configurable Fields:
+
+================   ===========================================================
+vendorid           Do not care (e.g. PCI_ANY_ID)
+deviceid           Do not care (e.g. PCI_ANY_ID)
+revid              Do not care
+progif_code	   Must be 0x02 (NVM Express)
+baseclass_code     Must be 0x1 (PCI_BASE_CLASS_STORAGE)
+subclass_code      Must be 0x08 (Non-Volatile Memory controller)
+cache_line_size    Do not care
+subsys_vendor_id   Do not care (e.g. PCI_ANY_ID)
+subsys_id          Do not care (e.g. PCI_ANY_ID)
+msi_interrupts     At least equal to the number of queue pairs desired
+msix_interrupts    At least equal to the number of queue pairs desired
+interrupt_pin      Interrupt PIN to use if MSI and MSI-X are not supported
+================   ===========================================================
+
+The NVMe EPF specific configurable fields are in the nvme subdirectory of the
+directory created in 1
+
+================   ===========================================================
+ctrl_opts          NVMe target connection parameters
+dma_enable         Enable (1) or disable (0) DMA transfers; default = 1
+mdts_kb            Maximum data transfer size in KiB; default = 128
+================   ===========================================================
diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 4d2333e7ae06..764f1e8f81f2 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,9 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-nvme-function
+   pci-nvme-howto
 
    function/binding/pci-test
    function/binding/pci-ntb
+   function/binding/pci-nvme
diff --git a/Documentation/PCI/endpoint/pci-nvme-function.rst b/Documentation/PCI/endpoint/pci-nvme-function.rst
new file mode 100644
index 000000000000..ac8baa5556be
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-nvme-function.rst
@@ -0,0 +1,151 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PCI NVMe Function
+=================
+
+:Author: Damien Le Moal <dlemoal@kernel.org>
+
+The PCI NVMe endpoint function driver implements a PCIe NVMe controller for a
+local NVMe fabrics host controller. The fabrics controller target can use any
+of the transports supported by the NVMe driver. In practice, using small SBC
+boards equipped with a PCI endpoint controller, loop targets to files or block
+devices or TCP targets to remote NVMe devices can be easily used.
+
+Overview
+========
+
+The NVMe endpoint function driver relies as most as possible on the NVMe
+fabrics driver for executing NVMe commands received from the PCI RC host to
+minimize NVMe command parsing. However, some admin commands must be modified to
+satisfy PCI transport specifications constraints (e.g. queue management
+commands support and the optional SGL support).
+
+Capabilities
+------------
+
+The NVMe capabilities exposed to the PCI RC host through the BAR 0 registers
+are almost identical to the capabilities of the NVMe fabrics controller, with
+some exceptions:
+
+1) NVMe-over-fabrics specifications mandate support for SGL. Howerver, this
+   capability is not exposed as supported because the current NVMe endpoint
+   driver code does not support SGL.
+
+2) The NVMe endpoint function driver can expose a different MDTS (Maximum Data
+   Transfer Size) than the fabrics controller used.
+
+Maximum Number of Queue Pairs
+-----------------------------
+
+Upon binding of the NVMe endpoint function driver to the endpoint controller,
+BAR 0 is allocated with enough space to accommodate up to
+PCI_EPF_NVME_MAX_NR_QUEUES (16) queue pairs. This relatively low number is
+necessary to avoid running out of memory windows for mapping PCI addresses to
+local endpoint controller memory.
+
+The number of memory windows necessary for operation is roughly at most:
+1) One memory window for raising MSI/MSI-X interrupts
+2) One memory window for command PRP and data transfers
+3) One memory window for each submission queue
+4) One memory window for each completion queue
+
+Given the highly asynchronous nature of the NVMe endpoint function driver
+operation, the memory windows needed as described above will generally not be
+used simultaneously, but that may happen. So a safe maximum number of queue
+pairs that can be supported is equal to the maximum number of memory windows of
+the endpoint controller minus two and divided by two. E.g. for an endpoint PCI
+controller with 32 outbound memory windows available, up to 10 queue pairs can
+be safely operated without any risk of getting PCI space mapping errors due to
+the lack of memory windows.
+
+The NVMe endpoint function driver allows configuring the maximum number of
+queue pairs through configfs.
+
+Command Execution
+=================
+
+The NVMe endpoint function driver relies on several work items to process NVMe
+commands issued by the PCI RC host.
+
+Register Poll Work
+------------------
+
+The register poll work is a delayed work used to poll for changes to the
+controller state register. This is used to detect operations initiated by the
+PCI host such as enabling or enabling the NVMe controller. The register poll
+work is scheduled every 5 ms.
+
+Submission Queue Work
+---------------------
+
+Upon creation of submission queues, starting with the submission queue for
+admin commands, a delayed work is created and scheduled for execution every
+jiffy to poll for a submission queue doorbell to detect submission of commands
+by the PCI host.
+
+When changes to a submission queue work are detected by a submission queue
+work, the work allocates a command structure to copy the NVMe command issued by
+the PCI host and schedules processing of the command using the command work.
+
+Command Processing Work
+-----------------------
+
+This per-NVMe command work is scheduled for execution when an NVMe command is
+received from the host. This work will:
+
+1) Does minimal parsing of the NVMe command to determine if the command has a
+   data buffer. If it does, the PRP list for the command is retrieved to
+   identify the PCI address ranges used for the command data buffer. This can
+   lead to the command buffer being represented using several discontiguous
+   memory fragments.  A local memory buffer is also allocated for local
+   execution of the command using the fabrics controller.
+
+2) If the command is a write command (DMA direction from host to device), data
+   is transferred from the host to the local memory buffer of the command. This
+   is handled in a loop to process all fragments of the command buffer as well
+   as simultaneously handle PCI address mapping constraints of the PCI endpoint
+   controller.
+
+3) The command is then executed using the NVMe driver fabrics code. This blocks
+   the command work until the command execution completes.
+
+4) When the command completes, the command work schedules handling of the
+   command response using the completion queue work.
+
+Completion Queue Work
+---------------------
+
+This per-completion queue work is used to aggregate handling of responses to
+completed commands in batches to avoid having to issue an IRQ for every
+completed command. This work is sceduled every time a command completes and
+does:
+
+1) Post a command completion entry for all completed commands.
+
+2) Update the completion queue doorbell.
+
+3) Raise an IRQ to signal the host that commands have completed.
+
+Configuration
+=============
+
+The NVMe endpoint function driver can be fully controlled using configfs, once
+a NVMe fabrics target is also setup. The available configfs parameters are:
+
+  ctrl_opts
+
+        Fabrics controller connection arguments, as formatted for
+        the nvme cli "connect" command.
+
+  dma_enable
+
+        Enable (default) or disable DMA data transfers.
+
+  mdts_kb
+
+        Change the maximum data transfer size (default: 128 KB).
+
+See Documentation/PCI/endpoint/pci-nvme-howto.rst for a more detailed
+description of these parameters and how to use them to configure an NVMe
+endpoint function driver.
diff --git a/Documentation/PCI/endpoint/pci-nvme-howto.rst b/Documentation/PCI/endpoint/pci-nvme-howto.rst
new file mode 100644
index 000000000000..e15e8453b6d5
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-nvme-howto.rst
@@ -0,0 +1,189 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+PCI NVMe Endpoint Function (EPF) User Guide
+===========================================
+
+:Author: Damien Le Moal <dlemoal@kernel.org>
+
+This document is a guide to help users use the pci-epf-nvme function driver to
+create PCIe NVMe controllers. For a high-level description of the NVMe function
+driver internals, see Documentation/PCI/endpoint/pci-nvme-function.rst.
+
+Hardware and Kernel Requirements
+================================
+
+To use the NVMe PCI endpoint driver, at least one endpoint controller device
+is required.
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+        a40000000.pcie-ep
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+        a40000000.pcie-ep
+
+Compiling the NVMe endpoint function driver depends on the target support of
+the NVMe driver being enabled (CONFIG_NVME_TARGET). It is also recommended to
+enable CONFIG_NVME_TARGET_LOOP to enable the use of loop targets (to use files
+or block devices as storage for the NVMe target device). If the board used also
+supports ethernet, CONFIG_NVME_TCP can be set to enable the use of remote TCP
+NVMe targets.
+
+To facilitate testing, enabling the null-blk driver (CONFIG_BLK_DEV_NULL_BLK)
+is also recommended. With this, a simple setup using a null_blk block device
+with an NVMe loop target can be used.
+
+
+NVMe Endpoint Device
+====================
+
+Creating an NVMe endpoint device is a two step process. First, an NVMe target
+device must be defined. Second, the NVMe endpoint device must be setup using
+the defined NVMe target device.
+
+Creating a NVMe Target Device
+-----------------------------
+
+Details about how to configure and NVMe target are outside the scope of this
+document. The following only provides a simple example of a loop target setup
+using a null_blk device for storage.
+
+First, make sure that configfs is enabled::
+
+	# mount -t configfs none /sys/kernel/config
+
+Next, create a null_blk device (default settings give a 250 GB device without
+memory backing). The block device created will be /dev/nullb0 by default::
+
+        # modprobe null_blk
+        # ls /dev/nullb0
+        /dev/nullb0
+
+The NVMe loop target driver must be loaded::
+
+        # modprobe nvme_loop
+        # lsmod | grep nvme
+        nvme_loop              16384  0
+        nvmet                 106496  1 nvme_loop
+        nvme_fabrics           28672  1 nvme_loop
+        nvme_core             131072  3 nvme_loop,nvmet,nvme_fabrics
+
+Now, create the NVMe loop target, starting with the NVMe subsystem, specifying
+a maximum of 4 queue pairs::
+
+        # cd /sys/kernel/config/nvmet/subsystems
+        # mkdir pci_epf_nvme.0.nqn
+        # echo -n "Linux-pci-epf" > pci_epf_nvme.0.nqn/attr_model
+        # echo 4 > pci_epf_nvme.0.nqn/attr_qid_max
+        # echo 1 > pci_epf_nvme.0.nqn/attr_allow_any_host
+
+Next, create the target namespace using the null_blk block device::
+
+        # mkdir pci_epf_nvme.0.nqn/namespaces/1
+        # echo -n "/dev/nullb0" > pci_epf_nvme.0.nqn/namespaces/1/device_path
+        # echo 1 > "pci_epf_nvme.0.nqn/namespaces/1/enable"
+
+Finally, create the target port and link it to the subsystem::
+
+        # cd /sys/kernel/config/nvmet/ports
+        # mkdir 1
+        # echo -n "loop" > 1/addr_trtype
+        # ln -s /sys/kernel/config/nvmet/subsystems/pci_epf_nvme.0.nqn
+                1/subsystems/pci_epf_nvme.0.nqn
+
+
+Creating a NVMe Endpoint Device
+-------------------------------
+
+With the NVMe target ready for use, the NVMe PCI endpoint device can now be
+created and enabled. The first step is to load the NVMe function driver::
+
+        # modprobe pci_epf_nvme
+        # ls /sys/kernel/config/pci_ep/functions
+        pci_epf_nvme
+
+Next, create function 0::
+
+        # cd /sys/kernel/config/pci_ep/functions/pci_epf_nvme
+        # mkdir pci_epf_nvme.0
+        # ls pci_epf_nvme.0/
+        baseclass_code    msix_interrupts   secondary
+        cache_line_size   nvme              subclass_code
+        deviceid          primary           subsys_id
+        interrupt_pin     progif_code       subsys_vendor_id
+        msi_interrupts    revid             vendorid
+
+Configure the function using any vendor ID and device ID::
+
+        # cd /sys/kernel/config/pci_ep/functions/pci_epf_nvme/pci_epf_nvme.0
+        # echo 0x15b7 > vendorid
+        # echo 0x5fff > deviceid
+        # echo 32 > msix_interrupts
+        # echo -n "transport=loop,nqn=pci_epf_nvme.0.nqn,nr_io_queues=4" > \
+                ctrl_opts
+
+The ctrl_opts attribute must be set using equivalent arguments as used for a
+norma NVMe target connection using "nvme connect" command. For the example
+above, the equivalen target connection command is::
+
+        # nvme connect --transport=loop --nqn=pci_epf_nvme.0.nqn --nr-io-queues=4
+
+The endpoint function can then be bound to the endpoint controller and the
+controller started::
+
+        # cd /sys/kernel/config/pci_ep
+        # ln -s functions/pci_epf_nvme/pci_epf_nvme.0 controllers/a40000000.pcie-ep/
+        # echo 1 > controllers/a40000000.pcie-ep/start
+
+Kernel messages will show information as the NVMe target device and endpoint
+device are created and connected.
+
+.. code-block:: text
+
+        pci_epf_nvme: Registered nvme EPF driver
+        nvmet: adding nsid 1 to subsystem pci_epf_nvme.0.nqn
+        pci_epf_nvme pci_epf_nvme.0: DMA RX channel dma3chan2, maximum segment size 4294967295 B
+        pci_epf_nvme pci_epf_nvme.0: DMA TX channel dma3chan0, maximum segment size 4294967295 B
+        pci_epf_nvme pci_epf_nvme.0: DMA supported
+        nvmet: creating nvm controller 1 for subsystem pci_epf_nvme.0.nqn for NQN nqn.2014-08.org.nvmexpress:uuid:0aa34ec6-11c0-4b02-ac9b-e07dff4b5c84.
+        nvme nvme0: creating 4 I/O queues.
+        nvme nvme0: new ctrl: "pci_epf_nvme.0.nqn"
+        pci_epf_nvme pci_epf_nvme.0: NVMe fabrics controller created, 4 I/O queues
+        pci_epf_nvme pci_epf_nvme.0: NVMe PCI controller supports MSI-X, 32 vectors
+        pci_epf_nvme pci_epf_nvme.0: NVMe PCI controller: 4 I/O queues
+
+
+PCI RootComplex Host
+====================
+
+Booting the host, the NVMe endpoint device will be discoverable as a PCI device::
+
+        # lspci -n
+        0000:01:00.0 0108: 15b7:5fff
+
+An this device will be recognized as an NVMe device with a single namespace::
+
+        # lsblk
+        NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
+        nvme0n1     259:0    0   250G  0 disk
+
+The NVMe endpoint block device can then be used as any other regular NVMe
+device. The nvme command line utility can be used to get more detailed
+information about the endpoint device::
+
+        # nvme id-ctrl /dev/nvme0
+        NVME Identify Controller:
+        vid       : 0x15b7
+        ssvid     : 0x15b7
+        sn        : 0ec249554579a1d08fb5
+        mn        : Linux-pci-epf
+        fr        : 6.12.0-r
+        rab       : 6
+        ieee      : 000000
+        cmic      : 0
+        mdts      : 5
+        ...
diff --git a/MAINTAINERS b/MAINTAINERS
index 301e0a1b56e8..48431d2aa751 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16563,6 +16563,8 @@ M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-nvme@lists.infradead.org
 S:	Supported
+F:	Documentation/PCI/endpoint/function/binding/pci-nvme.rst
+F:	Documentation/PCI/endpoint/pci-nvme-*.rst
 F:	drivers/pci/endpoint/functions/pci-epf-nvme.c
 
 NVM EXPRESS DRIVER
-- 
2.47.0


