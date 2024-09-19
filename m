Return-Path: <linux-pci+bounces-13289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83297C5C1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 10:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046052810E5
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02C198E7E;
	Thu, 19 Sep 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hYBk5qcV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B52194C69
	for <linux-pci@vger.kernel.org>; Thu, 19 Sep 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734338; cv=none; b=MCciacfXWiPn8RdnC2kw3TKf9Nvmo8E8k7dKFD3R9FV+RyGJh/f4/bUaHZcI819EpH5J+OxRCU9mQJiHKZtKrX8D8Mp9L2LuVFPZfOTA0lGT/3UjI0SlYm8gctD7uOHOdGRRZ7JUtnpZrt5J/TGt2Uw8n1EXcV0uHBiml17yz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734338; c=relaxed/simple;
	bh=SnP6TLUxZQ6kRf3ha8ERCL12fPN+JBGXdUUdC4EdtuI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=p0KWsjsVXvJvhEaClSrzhqFC9HYza+l4+NOKNxtE5YdiBxrxbEgJgfF5+brO6Vnyu0OM0F+739PKoZPu4sS0w3V2FTUF19bp3uGPgyknaLnfr09wQDmIfxzQusUroW3PfnOCEkZeiH+8M2ZswGY+mbWHtYHQcauHTykqoXecb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hYBk5qcV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206aee4073cso6876695ad.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Sep 2024 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726734335; x=1727339135; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg6i9CBOLwsKEVAxZPAobHH9kzXv6povJYcWn9speVk=;
        b=hYBk5qcV7YLS99lo/sfSwUTimwyPt5dIdHMQ6pP45fd4GPDPslcnxpj7k/3cYNnSp9
         3076A5gpGGPmYiHR2q7C/Rsv2LJVQNy7y0p+kwLcYnGmTcsu+3FEOpcNiY/P5FFBwfzI
         ZoNsjhfjAHJDrWwua6qZGJmvShu+O34U6hJcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734335; x=1727339135;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg6i9CBOLwsKEVAxZPAobHH9kzXv6povJYcWn9speVk=;
        b=cZlyPv8WSQg/NMeQUTap1yCJD+vIwQgqppJwgtXzshkxQh5MkXxcJApTjuiVh2oO2n
         l1KkdIs7bCmlXFZLaFXuqQ103oGBlDt3Tfmn3N2CA5NfvhDDlxF2T1iyJUr/q+lfmPuY
         /6l+lzvJIOJ4WDjUs9+SXa6CoxDZ5iJh6MIaXH6kfzRt7FxawKtjm9Kfql/JIC042IY6
         jlA+iIc4+wYK9OoT2YTGUKzfI7LXJljSk+FVbgJisGirh1GMXrPOk+ju2zng4GNpZn2z
         8SqZJ0iVpdqjMhvKttvkrxW78UuY+8iL57pvlsSLOM2ptXze0iL9olyAMZO+g1/rECfR
         HB6w==
X-Gm-Message-State: AOJu0Yzvib1Yk0U8rpwpUryNK1zSCMKDIexmS9rhiko7WBDOTz0P2H/e
	bcgd8qhHqjl4F6bppC/AK4d8IlIqBVhYYkngoS0IRYbA+OTBLjYOPNXJiVtUo8UHnCi84xcGXKQ
	s+R37q5co0MXJxGJS0WqFE01LABeyXObF1sQYHqigt9aIJBWulD5EJkJoUCVjAOgfZLWw85Sy+H
	gte5DU36xjFzSGHplhSsDDtOgLXt77LMYMrYfWxHS1KTAXBf5g+fVQEUdn6UFJ6To=
X-Google-Smtp-Source: AGHT+IE73vj5Glvvp2mf0syR7phPfaJKmItZ0JPjffkM7gQpry7jzH2INTGSS1U9PWZ/8DJvhJPQpw==
X-Received: by 2002:a17:902:e5ca:b0:202:671:e5bd with SMTP id d9443c01a7336-2076e3f510bmr417875855ad.42.1726734334670;
        Thu, 19 Sep 2024 01:25:34 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735810sm75228425ad.278.2024.09.19.01.25.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:25:34 -0700 (PDT)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	logang@deltatee.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 0/2 v2] PCI/portdrv: Report inter switch P2P links through sysfs
Date: Thu, 19 Sep 2024 01:13:42 -0700
Message-Id: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Changes done in v2:
The previous submission of this series was at [1].
As per the feedback received from Mani, the code is moved to PCI portdrv
to create the sysfs entries instead of having a separate kernel module.

A. Introductory definitions:

Virtual Switch: Broadcom(PLX) switches have a capability where a single
physical switch can be divided up into N number of virtual switches at
start of day. For example, a single physical switch with 64 ports can be
configured to appear to the host as 2 switches with 32 ports each. This is
a static configuration that needs to be done before the switch boots, and
cannot generally be changed on the fly. Now consider a GPU in Virtual
switch 1 and a NIC on Virtual switch 2. The key here is that it's actually
the same switch, and IF P2P is enabled between the two virtual switches,
then that would be almost infinite bandwidth between the GPU and the NIC.
However, today there is no way for the host to know that, and host
applications believe that any data exchange between the GPU and NIC must
go through host root port and thus would be slow.
Note: Any such P2P must follow ACS/IOMMU rules, and has to be enabled in
the Broadcom switches.

Inter Switch Link: While the current use-case is about the virtual switch
config above, this could also extend to physical switch, where the two
physical switches have, say, a x16 PCIe connection between them.

B: Goal/Problem statement:

Goal 1: Summary: Provide user applications a means by which they can
discover two virtual switches to be part of the same physical switch or
when physical switches are physically connected to each other, so that
they can discover optimized data path for HPC/AI applications.

With the rapid progression of High Performance Computing (HPC) and
Artificial Intelligence (AI), it is becoming more and more common to have
complex topologies with multiple GPU, NIC, NVMe devices etc interconnected
using multiple switches. HPC and AI libraries like MPI, UCC, NCCL, RCCL,
HCCL etc analyze this topology to build a topology tree to optimize data
path for collective operations like all-reduce etc.

Example:

                             Host root bridge
                ---------------------------------------
                |                  |                  |
  NIC1 --- PCI Switch1        PCI Switch2        PCI Switch3 --- NIC2
                |                  |                  |
               GPU1 ------------- GPU2 ------------- GPU3

                               SERVER 1

In the simple picture above in Server1, Switch1, Switch2, Switch3
are all connected to the host bridge and each switch has a GPU
connected, and Switch1/3 each has a NIC connected.
In a typical AI setup, there are many such servers, each connected by
upper level network switch, and "rail optimized", ie, NIC1 of all
servers are connected to Ethernet Switch1, NIC2 connected to Ethernet
Switch2 etc (Ethernet switches are not shown in picture above)
The GPUs are connected among themselves by some backend fabric, like
NVLINK (NVIDIA).
Assume that in the above diagram, PCI Switch1  and PCI Switch3 are
virtual switches belonging to the same physical switch and thus a very
high speed data link exists between them, but today host applications
have no knowledge about that.
(This is a very simple example, and modern AI infrastructure can be
way more complex than that.)

Now for collective operations like all-reduce, the HPC/AI libraries
analyze the topology above and typically decide on a data path like
this: NIC1->GPU1->GPU2->GPU3-> NIC2 which is suboptimal, because
ideally data should come go in and out through the same NIC because of
"rail optimized" topology.
Some libraries do this:NIC1->GPU1->GPU2->GPU3-> GPU1->NIC1.
The applications do the above because they think data from GPU3 to
NIC1  needs to go through the host root port, which is very
inefficient. What they do not know is that Switch1 and Switch3 are the
same physical entity with virtually infinite bandwidth between them,
and with that, they would have chosen a path like:
NIC1->GPU1->GPU2->GPU3->NIC1, which is the most optimized in the above
example.

Goal 2: Extend Linux P2PDMA distance function pci_p2pdma_distance to
account for Virtual Switch and physical switches connected by inter
switch link. The current implementation of the function has no
knowledge of Virtual switch and inter switch link.
Consider the example below:

     -+  Root Port
      \+ Switch1 Upstream Port
         +-+ Switch1 Downstream Port 0
          \- Device A
      \+ Switch2 Upstream Port
         +-+ Switch2 Downstream Port 0
           \- Device B

Suppose Switch1 and Switch2 are virtual switches belonging  to the
same physical switch. Today P2PDMA distance between Device A and
Device B  will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE, as kernel has
no idea that switch1 and switch2 are actually physically connected to
each other. We intend to fix that, so that pci_p2pdma_distance now takes
into account switch connectivity information.

C. FAQs

FAQ 1:  How does this feature work with ACS/IOMMU?
This feature does NOT add any new connectivity.  The inter-switch
/virtual switch connections already follow all ACS/IOMMU rules, and
only if allowed by ACS settings, they allow for data to follow a
shortcut connection between switches and bypass the root port. The
only thing this patch does is provide the switch connection
information to application software and pci_p2pdma_distance clients,
so that they can make intelligent decisions for the data path.

FAQ 2:  Is this feature Broadcom specific and will it work for other
vendors?
The current implementation of the patch looks at Broadcom
Vendor specific extensions to determine if switch p2p is enabled.
Thus, the current implementation works only on Broadcom switches. That
being said, other vendors are free to extend/modify the code to
support their switch. The function names, code structure and sysfs path
that exposes the PCI switch p2p is made generic, to allow for extension of
support to other vendors. All broadcom specific functionality is segregated
into a Broadcom specific function.

FAQ 3: Why can't applications read the Broadcom vendor specific
information directly from the config space? Why do we need the sysfs
path?
The vendor specific section of PCIe config space is not readable by
applications running in non-root mode, as such applications can only
read the first few bytes of the config space. Besides, reading the
vendor specific config space will not make the solution generic.

FAQ 4: Will applications still use the standard P2P model of
registering the provider, client etc?
Absolutely. All existing p2p API will work as is. All that this patch
provides is information that a fast connection exists between switches
and/or PCI endpoints. To make the actual p2p DMA, application need
use existing p2p API and follow existing ACS/IOMMU rules

FAQ 5: Why can't we only modify the existing pci_p2pdma_distance
function, and expose a p2pdistance to userspace? Why do we need the
new sysfs entries for pci switch connectivity?
The existing HPC/AI libraries like MPI, UCC, NCCL, RCCL, HCCL etc work
not only with PCIe switches, but also with other kind of connectivity,
like TCP, network switches, infiniband and backend inter GPU
connectivity like NVLINK and AFL. Because of that, the libraries have
matured code that analyzes all the connections and entire topology to
determine the most optimal data path among nodes. Just using
pci_p2pdma_distance does not work for them, because there might be a
shorter path between two nodes using NVLINK or a network switch.  In
theory those libraries could be modified to use pci_p2pdma_distance
for PCIe connection and other method for other connection, but in
practice that is near impossible, as those changes are very intrusive
and those libraries have matured for a long time,. Their respective
maintainers are highly reluctant to make such a big change and rather
get only the missing information, that is whether two switches are
connected together. Broadcom has received such first hand feedback.
Forcing everyone to use p2pdistance only will defeat the whole purpose
of this patch. However, we do want to support those libraries that
want to use pci_p2pdma_distance, and that is why we are extending
pci_p2pdma_distance function too. Thus, our goal here is to enable
existing libraries to get only the information they need, while having
means for new code or more flexible code to use pci_p2pdma_distance as
needed.

[1] https://lore.kernel.org/linux-pci/1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com/

Shivasharan S (2):
  PCI/portdrv: Enable reporting inter-switch P2P links
  PCI/P2PDMA: Modify p2p_dma_distance to detect P2P links

 Documentation/ABI/testing/sysfs-bus-pci |  14 ++
 drivers/pci/p2pdma.c                    |  15 ++-
 drivers/pci/pcie/portdrv.c              | 165 ++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h              |  12 ++
 4 files changed, 205 insertions(+), 1 deletion(-)

-- 
2.43.0


