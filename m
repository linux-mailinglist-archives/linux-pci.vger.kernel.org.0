Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A32106C56
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 11:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfKVKvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:51:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56065 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfKVKvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:51:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so6914074wmb.5
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vx4Rp2JWxTpwjHbsPUwQOJio9qv2Si3UTdoXXTOJ6hw=;
        b=RzMiAchIN0a1MA2agzsMmmUVN/NACrbKmeQxW9OYLy/xyPd/+bdzJ3ZJ1a0SCZIMfi
         1opvf0yvvJPDEs69SqH0j0177JHM9wAcPvQa0Gx7Qfznl9EMxk1LCPjTfQ/rzrY99sa9
         tj6hbbskL7HY5QzmcYnpJ7i7eRhpYkp7Wf4Uk4wk9S0J4GIQIVqnSyoESgxWxPktMOyg
         tzoZBhV6FQMgH8nP/3g1GYHXT/3k1thAdNwX9RVy6NoGRBnSI0wWuQUkd+LZicHh7Mrp
         w2x3EEBfT7ZqyQsIs5utEfoIRm2rYkYWXLhhZn6cJ8ThHpUuu7kXjmE83dXpl6mgyUgR
         1HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vx4Rp2JWxTpwjHbsPUwQOJio9qv2Si3UTdoXXTOJ6hw=;
        b=IExtsTz+RVARjWpOi4PdyhSgt8jL5Z/l7FNrNZ3A0AFv1eqfMdbK8rjbhierPcMO4C
         /JrbNw0XVGBvlKxUUBhq0JeB0zqcJvbutPvGSsz3Lnty+eVluyf9qjTmFySVofGzIetD
         FYgwcbbak86RZvGth4oWjvX53luNifCS2QWAUySjOmscadzVBaZL00noECQt7++k9LLE
         Vz28b9M7TY2trsxT6nw63Ehys6Xz1kZoU/ySCx5q528tB+EVfpusFU8PnHTWJa6Mmq8z
         ZPs4mLmHlIIpCYkTVJEaOtd6u5wdjKY+HpE0c/xsc+cnd1ysyYDV7r/iKJ7SfV+laEnz
         tjHw==
X-Gm-Message-State: APjAAAX2q5Zi7aBB59ByE+615e+rDe3LTVcIz/leBYIC9lmtdx47MgmJ
        GgYd/O8q+1Srl55g8FI1wUy63Q==
X-Google-Smtp-Source: APXvYqyZxbgndRY6b3Fh3ipFtYb3tNJ6jmpmtk3V3fd+ZYBSzCjLSNTlmzWGkB0HHefvBHwBmcEmHA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr16254886wmc.130.1574419867091;
        Fri, 22 Nov 2019 02:51:07 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:51:06 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC virtio 12/13] virtio-iommu: Add built-in topology description
Date:   Fri, 22 Nov 2019 11:49:59 +0100
Message-Id: <20191122105000.800410-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a lightweight method to describe the IOMMU topology in the config
space, guarded by a new feature bit. A list of capabilities in the
config space describes the devices managed by the IOMMU and their
endpoint IDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 virtio-iommu.tex | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 28c562b..2b29873 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -67,6 +67,9 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
 
 \item[VIRTIO_IOMMU_F_MMIO (5)]
   The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
+
+\item[VIRTIO_IOMMU_F_TOPOLOGY (6)]
+  Topology description is available at \field{topo_offset}.
 \end{description}
 
 \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
@@ -97,6 +100,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device /
     le32 end;
   } domain_range;
   le32 probe_size;
+  le16 topo_offset;
 };
 \end{lstlisting}
 
@@ -141,6 +145,90 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
 If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
 device SHOULD NOT let endpoints access the guest-physical address space.
 
+\subsubsection{Built-in topology description}\label{sec:Device Types / IOMMU Device / Device initialization / topology}
+
+The device manages memory accesses from endpoints, identified by endpoint
+IDs. The driver can discover which endpoint ID corresponds to an endpoint
+using several methods, depending on the platform. Platforms described
+with device tree use the \texttt{iommus} and \texttt{iommu-map} properties
+embedded into device nodes for this purpose. Platforms described with
+ACPI use a table such as the Virtual I/O Table. Platforms that do not
+support either device tree or ACPI may embed a minimalistic description
+in the device configuration space.
+
+An important disadvantage of describing the topology from within the
+device is the lack of initialization ordering information. Out-of-band
+descriptions such as device tree and ACPI let the operating system know
+about device dependencies so that it can initialize supplier devices
+(IOMMUs) before their consumers (endpoints). Platforms using the
+VIRTIO_IOMMU_F_TOPOLOGY feature have to communicate the device dependency
+in another way.
+
+If the VIRTIO_IOMMU_F_TOPOLOGY feature is negotiated, \field{topo_offset}
+is the offset between the beginning of the device-specific configuration
+space (virtio_iommu_config) and the first topology structure header. A
+topology structures defines the endpoint ID of one or more endpoints
+managed by the virtio-iommu device.
+
+\begin{lstlisting}
+struct virtio_iommu_topo_head {
+  le16 type;
+  le16 next;
+};
+\end{lstlisting}
+
+\field{next} is the offset between the beginning of the device-specific
+configuration space and the next topology structure header. When
+\field{next} is zero, this is the last structure.
+
+\field{type} describes the type of structure:
+\begin{description}
+  \item[VIRTIO_IOMMU_TOPO_PCI_RANGE (0)] struct virtio_iommu_topo_pci_range
+  \item[VIRTIO_IOMMU_TOPO_ENDPOINT (1)] struct virtio_iommu_topo_endpoint
+\end{description}
+
+\paragraph{PCI range}\label{sec:Device Types / IOMMU Device / Device initialization / topology / PCI range}
+
+\begin{lstlisting}
+struct virtio_iommu_topo_pci_range {
+  struct virtio_iommu_topo_head head;
+  le32 endpoint_start;
+  le16 hierarchy;
+  le16 requester_start;
+  le16 requester_end;
+  le16 reserved;
+};
+\end{lstlisting}
+
+The PCI range structure describes the endpoint IDs of a series of PCI
+devices.
+
+\begin{description}
+  \item[\field{hierarchy}] Identifier of the PCI hierarchy. Sometimes
+    called PCI segment or domain number.
+  \item[\field{requester_start}] First requester ID in the range.
+  \item[\field{requester_end}] Last requester ID in the range.
+  \item[\field{endpoint_start}] First endpoint ID.
+\end{description}
+
+The correspondence between a PCI requester ID in the range
+[ requester_start; requester_end ] and its endpoint IDs is a linear
+transformation: endpoint_id = requester_id - requester_start +
+endpoint_start.
+
+\paragraph{Single endpoint}\label{sec:Device Types / IOMMU Device / Device initialization / topology / Single endpoint}
+
+\begin{lstlisting}
+struct virtio_iommu_topo_endpoint {
+  struct virtio_iommu_topo_head head;
+  le32 endpoint;
+  le64 address;
+};
+\end{lstlisting}
+
+\field{endpoint} is the ID of a single endpoint, identified by its first
+MMIO address in the physical address space.
+
 \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}
 
 Driver send requests on the request virtqueue, notifies the device and
-- 
2.24.0

