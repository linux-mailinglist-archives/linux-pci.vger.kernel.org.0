Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574CE64DD20
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 15:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLOOtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 09:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLOOta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 09:49:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACE2F020;
        Thu, 15 Dec 2022 06:49:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671115765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/N383Y9ZIeo3FhhagyHzDG/u7Nr3CslcNPpWx8HQDg=;
        b=2xCf+2Mh/hZE21G0XLpqi9Msd0K+rbstdy4LHr8nn8Ja7nrDuLUe3uLRB8vmj7q2dtDp0h
        tmtikORtCjXPpWisxpMU1CZgYnZI4mnhDiXkjSfkI9goLIqAo0P7e9R479WZ0Px7wSnEvN
        ijDGCZetZdn9c98Sv17UetZa+Iyp/TQaHT4V5PTaNztk49e1DKmc7pXx94t5OIEf2McaAJ
        kYvidt5WqlqwR02j+UHN2w9PXEEFIq1JRXv4MJtUTstXUUtAwtUkACH3vX6zKs5n1eKG/M
        UwYWrL7Rrh66IVFA8DUgoKVHkp2nK0NKhp2xLlUsrht6eR4xrbMhbp8kTDOUQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671115765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/N383Y9ZIeo3FhhagyHzDG/u7Nr3CslcNPpWx8HQDg=;
        b=GkrmTcu8kHcYqSVCJCsPAlN7TK9w3HnnWKEHY/K+Q0VjBaFqYotA/9/mZ1KN2XTHRmzf5W
        NEhxmT1u0HWetqDw==
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
In-Reply-To: <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
Date:   Thu, 15 Dec 2022 15:49:15 +0100
Message-ID: <87fsdgzpqs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 14 2022 at 10:42, Niklas Schnelle wrote:
> On Tue, 2022-12-13 at 11:04 -0800, Guenter Roeck wrote:
>> This patch results in various s390 qemu test failures.
>> There is a warning backtrace
>> 
>>    12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_valid+0x2a/0xb0
>> 
>> followed by
>> 
>> [   12.684333] virtio_net: probe of virtio0 failed with error -34
>> 
>> and Ethernet interfaces don't instantiate.
> As far as I'm aware so far he tracked this down to code calling
> msi_domain_get_hwsize() which in turn calls msi_get_device_domain()
> which then returns NULL leading to msi_domain_get_hwsize() returning 0.
> I think this is related to the fact that we currently don't use IRQ
> domains.

Correct and for some stupid reason I thought 0 is a good return value
here :)



diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index bd4d4dd626b4..8fb10f216dc0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -609,8 +609,8 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
 		info = domain->host_data;
 		return info->hwsize;
 	}
-	/* No domain, no size... */
-	return 0;
+	/* No domain, default to MSI_MAX_INDEX */
+	return MSI_MAX_INDEX;
 }
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
