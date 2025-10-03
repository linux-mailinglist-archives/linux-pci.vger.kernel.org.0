Return-Path: <linux-pci+bounces-37518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA4BB6478
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21340189C714
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73327283C9E;
	Fri,  3 Oct 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="j+217xCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6C283C9D;
	Fri,  3 Oct 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482068; cv=none; b=NT7auz/kxUhhdZVc2ENfQL6Nx/b8BH+LhL8D4OuIt9ucxAmSbDeYKsDWKUUcHAQwmSopKPlK5AOW+11Ul3iORBzye5eMTji2sM29tgw3eUgNAsPCpoC7ulP5KZs0RP0Awu46YzHvdRs0R6Y1MIGmeGhio+AeDQCZSpLaksM/qDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482068; c=relaxed/simple;
	bh=MyYERWpVStffVq0oa/etdt4HUy2hJFWJ60PV2TbZiLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EuU2fCg09kF8CRfV/QdyYJKjkQyQFwq9EK6XHt0A6LrSYzN8I2A5/yS/z4nAy0m81C7sQ2y4uF9ti6pvWL88WMrQ4ROjsDcW4cnzPcoPrBkDyMsVWDQks9s3AX5fm60h+gGOG3ffzykodZkln/eneHTlGELGuVcx4c9L2dM7pTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=j+217xCy; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482065; x=1791018065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rKCZJGm4chvAfoVwGg85MKvPY+Y2zQKu0hy0YfJfqjY=;
  b=j+217xCyV40vpG06sNPaUuFz1AzLry3Syxb8tsHcYhYz23lOQ3d1xWOD
   FEaEcD6TpsaXsrjexfwvH8KQZjxLfzaq1gNmdlro/BzsMPuLmFcL1uwki
   9p9HxGh2857yA+4Tn+Ol7jAtRJ3/wNnTKccnvbTINduqDz0Jg0Df2yeLo
   GUrkZbdvd1/s1EhnSSqK34SGEVB1d8TM7qWNFJb+gK6Xep/F42+YDmSaX
   mjWcP35pcrJBWlk/m4cdgHre/OJNDbhbJPSGW+frg6cqO4keZBfoGgHrm
   0+rGjMPmbPe7XtkEgDQ9pEdsYiWBl4cRXWfZTbiwQVCjZ127nnId2RKlF
   A==;
X-CSE-ConnectionGUID: eZUzfFDGToGgBO91CdHeWA==
X-CSE-MsgGUID: qIhngR33Tha2Yu4dAuIdNA==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4212612"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:01:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:42694]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.233:2525] with esmtp (Farcaster)
 id ecc21aef-8cb2-445a-9885-2f13a6415b54; Fri, 3 Oct 2025 09:01:03 +0000 (UTC)
X-Farcaster-Flow-ID: ecc21aef-8cb2-445a-9885-2f13a6415b54
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:01:02 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:01:00 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 00/13] Introduce PCI Configuration Space Cache (PCSC)
Date: Fri, 3 Oct 2025 09:00:36 +0000
Message-ID: <cover.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Modern virtualization environments, particularly those leveraging SR-IOV
with hundreds or thousands of Virtual Functions, expose a significant
performance bottleneck in PCI configuration space accesses. During VM
initialization, the repeated enumeration and configuration of assigned
VFs creates substantial delays that scale linearly with deployment
density. Each configuration space read triggers a hardware transaction,
leading to bus contention and measurable impact on system startup times.

The fundamental issue stems from the PCI subsystem's approach of
treating every configuration space access as a direct hardware
operation, even when reading registers that contain static,
rarely-changing values. Capability registers, device/vendor IDs, and
many control registers remain constant throughout a device's lifetime,
yet are repeatedly accessed during driver initialization, device
enumeration, and system management operations.

This patch series introduces the PCI Configuration Space Cache (PCSC), a
transparent caching layer that intercepts configuration space operations
and maintains cached copies of register values. The implementation
philosophy centers on complete transparency; existing drivers,
applications, and system management tools continue functioning unchanged
while benefiting from reduced hardware access overhead. Currently, only
endpoint devices are cached. Bridges and Root Complexes utilize a
passthrough approach.

The architecture employs a write-invalidate caching policy. By
invalidating cache entries on writes and allowing subsequent reads to
repopulate the cache with fresh values, the system accommodates complex
initialization sequences like BAR sizing. This design choice
maximizes the number of cacheable registers while maintaining strict
coherency guarantees, ensuring that any software-visible state changes
are immediately reflected.

The implementation attaches per-device cache nodes to `struct pci_dev`,
each containing a cached copy of the configuration space alongside
bitmasks tracking which registers are cacheable and currently valid. The
system dynamically injects custom PCI operations into the bus hierarchy
at multiple integration points - during host bridge registration, child
bus allocation, and dynamic operation changes.

The cacheability of the configuration space registers is deduced by
dynamically traversing device's capability chains during initialization.
The implementation analyses both PCI capabilities and PCIe extended
capabilities, identifying safe-to-cache registers based on the PCI and
PCIe specifications. Capabilities like Power Management, MSI/MSI-X, EA,
VPD, AF and vendor-specific regions are parsed to determine which
fields represent static configuration versus dynamic status information.
The extended capability support covers AER, ACS, ARI, SR-IOV, PRI, DPC,
PASID and PTM.

Device reset handling ensures cache coherency across all reset scenarios
where configuration space values may change. The implementation hooks
into Function Level Resets, Advanced Features FLR, power management
resets (D3hot->D0 transitions), device-specific resets, D3cold power
state transitions, ACPI-based resets, and both bus and slot restore
operations. Secondary bus resets receive special handling - the cache is
recursively invalidated for all devices on the secondary bus and its
subordinate buses, ensuring consistency across the entire hierarchy.
Additionally, the patch addresses cache consistency when bus operations
are dynamically changed via `pci_bus_set_ops()`, as different ops
implementations may return different values for the same registers.
The invalidation mechanism clears the `cached_bitmask` while preserving
the cacheable_bitmask, allowing the cache to repopulate with fresh
values on subsequent accesses.
Paths that do need to access the real Config Space like,
`pci_dev_wait()` are configured to bypass the cache entirely to read
hardware state directly.

Beyond basic caching, the series implements persistence across kexec
operations using the Kernel HandOver (KHO) subsystem. This feature
allows cached PCI configuration data to survive kexec eliminating
redundant configuration space probing in the new kernel. During kexec
preparation, the implementation creates Flattened Device Tree structures
containing device information and physical addresses of preserved cache
data. The new kernel discovers and restores this data during PCI
initialization, achieving up to 50% vm start time improvements on systems
with numerous PCI devices.

The persistence mechanism includes  versioning support to handle
evolving cacheability rules. When the incoming kernel detects a version
mismatch with saved data, it re-infers cacheability while preserving
cached values, ensuring compatibility across kernel updates. A
hashtable-based lookup optimization reduces restoration complexity from
O(n^2) to O(n) by building an index during initialization rather than
searching the FDT for each device. In the next iteration of this
patchset, the Live Update Orchestrator (LUO) subsystem will be used
instead.

Performance characteristics demonstrate significant improvements, with
cache hit rates reaching 49% in typical virtualization scenarios without
persistence, and up to 81% when combined with kexec persistence. These
metrics translate to substantial reductions in configuration space
access latency, particularly during bulk VM operations where thousands
of configuration space accesses would otherwise create significant bus
traffic spikes.

Testing has covered diverse hardware configurations including
high-density SR-IOV deployments. The implementation demonstrates
particular effectiveness in cloud environments where rapid VM deployment
and high device density create substantial configuration space access
pressure.

The entire implementation strives to maintain compatibility with the
existing PCI subsystem behaviour. No driver modifications should be
required, and the caching layer can be completely disabled without
functional impact.

Current Limitations
-------------------

- map_bus is not properly handled. This does not cause any issues in
the current upstream linux, as the only users are either bridges that are
not currently being cached, or the
`pci_generic_config_{read,write}{,32}` which is already handled.

- In PowerPC secondary bus resets the architecture-specific
`pcibios_reset_secondary_bus()` can bypass the generic
`pci_reset_secondary_bus()` where our cache invalidation occurs.

- The current Implementation is based on KHO. In the next RFC version
it will be changed to use the Live Update Orchestrator (LUO)
https://lore.kernel.org/lkml/20250807014442.3829950-1-pasha.tatashin@soleen.com/

A branch can be found in:
https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/pcsc-rfc-v1

Example Output of `sys/bus/pci/pcsc/stats`
```
Cache Hits: 21063
Cache Misses: 510
Uncachable Reads: 4398
Writes: 1049
Cache Invalidations: 584
Device Resets: 0
Total Reads: 25971
Hardware Reads: 4908
Hit Rate: 81%
Total Cache Access Time: 30952 us
Cache Access Time (without HW reads due to Misses): 16126 us
HW Access Time due to misses: 14826 us
Total Hardware Access Time: 101819 us
KHO Restore Statistics:
  Restored Devices: 2819
  Total Restore Time: 1362 us
  Hashtable Initial Entries: 2819
  Hashtable Build Time: 1000 us
```

Evangelos Petrongonas (13):
  pci: pcsc: Add plumbing for the PCI Configuration Space Cache (PCSC)
  pci: pcsc: implement basic functionality
  pci: pcsc: infer cacheability of PCI capabilities
  pci: pcsc: infer PCIe extended capabilities
  pci: pcsc: control the cache via sysfs and kernel params
  pci: pcsc: handle device resets
  pci: pcsc: introduce statistic gathering tools
  pci: Save only spec-defined configuration space
  vfio: pci: Fill only spec-defined configuration space regions
  pci: pcsc: Use contiguous pages for the cache data
  pci: pcsc: Add kexec persistence support via KHO
  pci: pcsc: introduce persistence versioning
  pci: pcsc: introduce hashtable lookup to speed up restoration

 Documentation/ABI/testing/sysfs-bus-pci-pcsc  |   29 +
 .../admin-guide/kernel-parameters.txt         |    7 +
 drivers/pci/Kconfig                           |   27 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/access.c                          |   86 +-
 drivers/pci/pci-acpi.c                        |    4 +
 drivers/pci/pci-driver.c                      |    5 +
 drivers/pci/pci.c                             |  121 +-
 drivers/pci/pcie/Kconfig                      |    9 +
 drivers/pci/pcsc.c                            | 1766 +++++++++++++++++
 drivers/pci/probe.c                           |   33 +-
 drivers/pci/quirks.c                          |    7 +-
 drivers/vfio/pci/vfio_pci_config.c            |   13 +-
 include/linux/pci.h                           |    8 +
 include/linux/pcsc.h                          |  163 ++
 15 files changed, 2268 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-pcsc
 create mode 100644 drivers/pci/pcsc.c
 create mode 100644 include/linux/pcsc.h

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


