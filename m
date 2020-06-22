Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD42044BB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 01:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgFVXrY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 19:47:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbgFVXqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 19:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592869565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=A3Sr9mNHVM8s9WUTsyWY81eoKGneWkQuZ36cxKIntEs=;
        b=ha6n7e80e/OQ1ytN6q73MH3JJDWxWmNCmZUS+ayxwlsTVAdvQ0ij2tIkHLlNbWdAhF7vc5
        HSMuUOlrbFBiU5cr7FVQ2elOaZ2AnXnR19tDN9N6NG7pX91Bzy0gE1usez3OtDJjA1REGI
        Xg3i9jdWqBAn6IgyocwoyZsdVXmq/3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-LXVPb2CoMgOtLk5LQrxHpw-1; Mon, 22 Jun 2020 19:45:54 -0400
X-MC-Unique: LXVPb2CoMgOtLk5LQrxHpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45101107ACCA;
        Mon, 22 Jun 2020 23:45:51 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3812D5C583;
        Mon, 22 Jun 2020 23:45:46 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [PATCH v2 0/3] Preventing job distribution to isolated CPUs        
Date:   Mon, 22 Jun 2020 19:45:07 -0400
Message-Id: <20200622234510.240834-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                                                                           
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
                                                                           
                                                                           
Changes from v1:                                                           
===============                                                            
- Included the suggestions made by Bjorn Helgaas in the commit messages.    
- Included the 'Reviewed-by' and 'Acked-by' received for Patch-2.          
                                                                           
[1] https://patchwork.ozlabs.org/project/netdev/patch/51102eebe62336c6a4e584c7a503553b9f90e01c.camel@marvell.com/
                                                                           
Alex Belits (3):                                                           
  lib: Restrict cpumask_local_spread to houskeeping CPUs                   
  PCI: Restrict probe functions to housekeeping CPUs                       
  net: Restrict receive packets queuing to housekeeping CPUs               
                                                                           
 drivers/pci/pci-driver.c |  5 ++++-                                       
 lib/cpumask.c            | 43 +++++++++++++++++++++++-----------------    
 net/core/net-sysfs.c     | 10 +++++++++-                                  
 3 files changed, 38 insertions(+), 20 deletions(-)                        
                                                                           
--

