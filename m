Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1B64F064
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiLPRay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 12:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiLPRaw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 12:30:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBABCA1;
        Fri, 16 Dec 2022 09:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F7A5B81D0A;
        Fri, 16 Dec 2022 17:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00C2C433F0;
        Fri, 16 Dec 2022 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671211848;
        bh=AVBHmsuF/d7lLhQICZGq4PhvL5nR45Zua7okdhVMKEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NW6YxvkCNQlp8nAavyfbtcC/G5ItpXHc4kI24UiJMc2wwJZV/dvyK/PBERqaE+tGC
         fuy93KoAzqH9Xw1+y/Ws15GLSmNgoMUqQ5LCtasPR9ASkZSHk5jIo3NjA+FvS8Ggdi
         EvCLpFChIdfsqEZkNsZ5lPE9+AIINJNzFr8X/4Vs1E+LPVDlIq8y4La9F2usCJQ30+
         qw1CBNLWxOInbxjeIk5hkfFa+mHB8emlj9OTCfWlLkAg/iEbPnAod2zXBbE1oKd0sP
         7EADuVdIWpWT/WV3LxJAKCtP2OumoIV0Dun+SZHwXF9KZYSpEQa4RXxmZgu3aUwk9u
         LlyzUeXaC5sow==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p6EXl-00D81v-Fw;
        Fri, 16 Dec 2022 17:30:45 +0000
MIME-Version: 1.0
Date:   Fri, 16 Dec 2022 17:30:45 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
In-Reply-To: <20d5b238-4c2c-6232-0251-c17b07dffbe3@linux.ibm.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
 <86wn6rptdu.wl-maz@kernel.org>
 <0acb8c63-7f6c-6df6-cb40-66b265a6e6ce@linux.ibm.com>
 <86v8mbphzw.wl-maz@kernel.org> <86tu1vphs9.wl-maz@kernel.org>
 <20d5b238-4c2c-6232-0251-c17b07dffbe3@linux.ibm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9cfb5efa91ec0d58e12b5baffae8941c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mjrosato@linux.ibm.com, tglx@linutronix.de, schnelle@linux.ibm.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, x86@kernel.org, joro@8bytes.org, will@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, jgg@mellanox.com, dave.jiang@intel.com, alex.williamson@redhat.com, kevin.tian@intel.com, dan.j.williams@intel.com, logang@deltatee.com, ashok.raj@intel.com, jdmason@kudzu.us, allenbh@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-12-16 14:11, Matthew Rosato wrote:
> On 12/16/22 9:03 AM, Marc Zyngier wrote:
>> On Fri, 16 Dec 2022 13:58:59 +0000,
>> Marc Zyngier <maz@kernel.org> wrote:
>>> 
>>> I'll update Thomas' patch. Once Guenter confirms that PPC is OK, I'll
>>> send it out.
>> 
>> And FWIW, the branch is at [1].
>> 
>> Thanks,
>> 
>> 	M.
>> 
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/msi-fixes-6.2
>> 
> 
> FYI, your patch there mentions MSI_XA_DOMAIN_SIZE in the commit
> message but the code (and comment) is still returning MSI_MAX_INDEX

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/msi-fixes-6.2&id=e982ad82bd8f7931f5788a15dfa3709f7a7ee79f

That was the case initially (amended the commit message, but
didn't commit the code...), then pushed the real stuff a couple of
minutes later. It took about 20 minutes for the mirror to sync
up...

I guess the git mirroring is a bit busy at the moment...

         M.
-- 
Jazz is not dead. It just smells funny...
