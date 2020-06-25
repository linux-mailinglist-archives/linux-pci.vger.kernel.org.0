Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57420A84F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407538AbgFYWjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 18:39:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33593 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406817AbgFYWjq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2020 18:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593124784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=l2eZLw468VrPBQvMvs1l+0bhdKyGLRYbkNFt0SVZO7A=;
        b=TH93+1YmRH4+vg6sJFdFoYo68nrOitDb25kq2SacYRzM19fdlfjYGiWtXkH+DIAwCF/GLk
        wIz64VtvykfcfyEmHZcf6k9BME78EiD5ySMQR61+xEkCbDQqD5Ue4Ry4/UB1ffSuTFIdbM
        AcFO0hHR7ObvCydTswc7k1A+BfwK628=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-C87WdbeiOm-jJ0rHIyCFWA-1; Thu, 25 Jun 2020 18:39:24 -0400
X-MC-Unique: C87WdbeiOm-jJ0rHIyCFWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B774D804002;
        Thu, 25 Jun 2020 22:39:21 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3B6780880;
        Thu, 25 Jun 2020 22:39:16 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: [PATCH v4 0/3] Preventing job distribution to isolated CPUs
Date:   Thu, 25 Jun 2020 18:34:40 -0400
Message-Id: <20200625223443.2684-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch-set is originated from one of the patches that have been
posted earlier as a part of "Task_isolation" mode [1] patch series
by Alex Belits <abelits@marvell.com>. There are only a couple of
changes that I am proposing in this patch-set compared to what Alex
has posted earlier.
 
 
Context
=======
On a broad level, all three patches that are included in this patch
set are meant to improve the driver/library to respect isolated
CPUs by not pinning any job on it. Not doing so could impact
the latency values in RT use-cases.


Patches
=======
* Patch1:
  The first patch is meant to make cpumask_local_spread()
  aware of the isolated CPUs. It ensures that the CPUs that
  are returned by this API only includes housekeeping CPUs.

* Patch2:
  This patch ensures that a probe function that is called
  using work_on_cpu() doesn't run any task on an isolated CPU.

* Patch3:
  This patch makes store_rps_map() aware of the isolated
  CPUs so that rps don't queue any jobs on an isolated CPU. 


Proposed Changes
================
To fix the above-mentioned issues Alex has used housekeeping_cpumask().
The only changes that I am proposing here are:
- Removing the dependency on CONFIG_TASK_ISOLATION that was proposed by
  Alex. As it should be safe to rely on housekeeping_cpumask()
  even when we don't have any isolated CPUs and we want
  to fall back to using all available CPUs in any of the above scenarios.
- Using both HK_FLAG_DOMAIN and HK_FLAG_WQ in Patch2 & 3, this is
  because we would want the above fixes not only when we have isolcpus but
  also with something like systemd's CPU affinity.


Testing
=======
* Patch 1:
  Fix for cpumask_local_spread() is tested by creating VFs, loading
  iavf module and by adding a tracepoint to confirm that only housekeeping
  CPUs are picked when an appropriate profile is set up and all remaining
  CPUs when no CPU isolation is configured.

* Patch 2:
  To test the PCI fix, I hotplugged a virtio-net-pci from qemu console
  and forced its addition to a specific node to trigger the code path that
  includes the proposed fix and verified that only housekeeping CPUs
  are included via tracepoint.

* Patch 3:
  To test the fix in store_rps_map(), I tried configuring an isolated
  CPU by writing to /sys/class/net/en*/queues/rx*/rps_cpus which
  resulted in 'write error: Invalid argument' error. For the case
  where a non-isolated CPU is writing in rps_cpus the above operation
  succeeded without any error.


Changes from v3[2]:
==================
- In patch 1, replaced HK_FLAG_WQ with HK_FLAG_MANAGED_IRQ based on the
  suggestion from Frederic Weisbecker.

Changes from v2[3]:
==================
Both the following suggestions are from Peter Zijlstra.
- Patch1: Removed the extra while loop from cpumask_local_spread and fixed
  the code styling issues.
- Patch3: Change to use cpumask_empty() for verifying that the requested
  CPUs are available in the the housekeeping CPUs.

Changes from v1[4]:
==================
- Included the suggestions made by Bjorn Helgaas in the commit message.
- Included the 'Reviewed-by' and 'Acked-by' received for Patch-2.


[1] https://patchwork.ozlabs.org/project/netdev/patch/51102eebe62336c6a4e584c7a503553b9f90e01c.camel@marvell.com/
[2] https://patchwork.ozlabs.org/project/linux-pci/cover/20200623192331.215557-1-nitesh@redhat.com/
[3] https://patchwork.ozlabs.org/project/linux-pci/cover/20200622234510.240834-1-nitesh@redhat.com/
[4] https://patchwork.ozlabs.org/project/linux-pci/cover/20200610161226.424337-1-nitesh@redhat.com/


Alex Belits (3):
  lib: Restrict cpumask_local_spread to houskeeping CPUs
  PCI: Restrict probe functions to housekeeping CPUs
  net: Restrict receive packets queuing to housekeeping CPUs

 drivers/pci/pci-driver.c |  5 ++++-
 lib/cpumask.c            | 16 +++++++++++-----
 net/core/net-sysfs.c     | 10 +++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 

