Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F394945FC0B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhK0CXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbhK0CVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:21:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B847C08EC73;
        Fri, 26 Nov 2021 17:32:08 -0800 (PST)
Message-ID: <20211127000918.779751933@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CFmm+AWRwXcJQSLL7VY9/FlDxYE98PyZd7GrvqHxiD8=;
        b=jPDSHQYSdxJlKUo1m9F9w8gw8R2TMDWPPxDRazvUWAKO2OAqttDQmAKiiB0cHxtncw0LoP
        I0nGS3ipmEFxCJjXQCspGZYqDLzYgAoHAzN8IALfV/R/UU8HnLONKw15r9QLBWIOy2tuBo
        v9UWh+uBu1gxtuVFZyC/oeYLLr7fsy2iBobG7WdjyJrjG53L08Qf0qS3j4Lea61UvUlvc7
        FlpqePyPni277I+e5Ve/tq90mOGCGQlu+ToYDaGLhxtuIL86QQHHHN2/nYRSDe2FLpzekY
        c4FjwvUSwWt/aSE1XxP6zVLeTmHWkEXcbwea6utFdTTv8Pecmzc4qo2LW6T26Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CFmm+AWRwXcJQSLL7VY9/FlDxYE98PyZd7GrvqHxiD8=;
        b=YpvVGHpsYjY8WLBK+/d3v25qrNDG94vLX8P5K9v/o3GbLxhwTttsJXuyACy8VlvKBn+N9c
        5C2HM/JCLaf7F2Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 05/10] genirq/msi: Add domain info flag MSI_FLAG_CAN_EXPAND
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:25:05 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Not all MSI domains support runtime expansions of PCI/MSI-X vectors. Add a
domain flag so implementations can opt in.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -494,6 +494,8 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	/* MSI vectors can be expanded after initial setup */
+	MSI_FLAG_CAN_EXPAND		= (1 << 11),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,

