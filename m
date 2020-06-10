Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438D41F58CA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFJQNB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:13:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgFJQNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591805579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/4nlWdsqI8fXiZ35bnUpG0b+i3WYAu7LgKqUCm475Os=;
        b=XG3pyBs/f1SHFb7BEqH6UqeusRitsK/6IMg7Z3ZgstLutHhQQKPKZ6Ffr8f1TFBKLLLSsO
        mcxALJl40rRZer1OhrucXKrIz876iacpMNxTDZKU35W//r5872MSu03KwADBGSsXBLBzWm
        ZjlKIjajDNVUtdlXlIjl3HKEvuaxPA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-NpWOi9ykPG6jwYiZQbS9vw-1; Wed, 10 Jun 2020 12:12:52 -0400
X-MC-Unique: NpWOi9ykPG6jwYiZQbS9vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6380591164;
        Wed, 10 Jun 2020 16:12:50 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526C4512FE;
        Wed, 10 Jun 2020 16:12:46 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: [PATCH v1 0/3] Preventing job distribution to isolated CPUs
Date:   Wed, 10 Jun 2020 12:12:23 -0400
Message-Id: <20200610161226.424337-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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


Changes
=======
To fix the above-mentioned issues Alex has used housekeeping_cpumask().
The only changes that I am proposing here are:
- Removing the dependency on CONFIG_TASK_ISOLATION that was proposed by Alex.
  As it should be safe to rely on housekeeping_cpumask()
  even when we don't have any isolated CPUs and we want
  to fall back to using all available CPUs in any of the above scenarios.
- Using both HK_FLAG_DOMAIN and HK_FLAG_WQ in all three patches, this is
  because we would want the above fixes not only when we have isolcpus but
  also with something like systemd's CPU affinity.


Testing
=======
* Patch 1:
  Fix for cpumask_local_spread() is tested by creating VFs, loading
  iavf module and by adding a tracepoint to confirm that only housekeeping
  CPUs are picked when an appropriate profile is set up and all remaining CPUs
  when no CPU isolation is required/configured.

* Patch 2:
  To test the PCI fix, I hotplugged a virtio-net-pci from qemu console
  and forced its addition to a specific node to trigger the code path that
  includes the proposed fix and verified that only housekeeping CPUs
  are included via tracepoint. I understand that this may not be the
  best way to test it, hence, I am open to any suggestion to test this
  fix in a better way if required.

* Patch 3:
  To test the fix in store_rps_map(), I tried configuring an isolated
  CPU by writing to /sys/class/net/en*/queues/rx*/rps_cpus which
  resulted in 'write error: Invalid argument' error. For the case
  where a non-isolated CPU is writing in rps_cpus the above operation
  succeeded without any error.

[1] https://patchwork.ozlabs.org/project/netdev/patch/51102eebe62336c6a4e584c7a503553b9f90e01c.camel@marvell.com/

Alex Belits (3):
  lib: restricting cpumask_local_spread to only houskeeping CPUs
  PCI: prevent work_on_cpu's probe to execute on isolated CPUs
  net: restrict queuing of receive packets to housekeeping CPUs

 drivers/pci/pci-driver.c |  5 ++++-
 lib/cpumask.c            | 43 +++++++++++++++++++++++-----------------
 net/core/net-sysfs.c     | 10 +++++++++-
 3 files changed, 38 insertions(+), 20 deletions(-)

--  


