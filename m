Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEF553BB0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354268AbiFUUhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiFUUhq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 16:37:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B222EA16;
        Tue, 21 Jun 2022 13:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1327B80F63;
        Tue, 21 Jun 2022 20:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2489AC3411C;
        Tue, 21 Jun 2022 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655843862;
        bh=JsFjrorP7E0Fvn/M3eVM+14S0jBkJsfB4KDOz5NDn98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KM1VufKw+2sYJQhARiw5X8V86Xp88sv7+cmJomMtKqLVL5UNmELDs+cLvIrec/Oov
         9gJpKGvCh8gyAtwtS8oR0jtR5E4Sk6mr7Mb/oK++Uyk1SrOTZr7Q3GLZdUF5GO2qjA
         3vikkyPhV5B7jtuc8oI6oRXhzeIa3mvJiuI1tjFSWI5MZvwCA+bwwcDD1dzJrSTbtp
         MkxXxTJb1oOiO2KTGuFiTQL0YLolIdhAs75Zfcw5BKS5SVM1JEmBU3ehe1BQIKAb0d
         A+QYvk82uWfysQ5Hct+lnXRi7mtoZuRYUpDKaKXr0wmYZYkWEdBUr7P8sDa49tWrnj
         B2KtHFilFsdQw==
Date:   Tue, 21 Jun 2022 15:37:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220621203739.GA1331637@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-5-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, I assume you mean the plural "mailboxes", not the
possessive "mailbox's".

On Fri, Jun 10, 2022 at 01:22:55PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DOE mailbox objects will be needed for various mailbox communications
> with each memory device.
> 
> Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> as found.
> 
> It is not anticipated that this is the final resting place for the
> iteration of the DOE devices.  The support of ports may drive this code
> into the pcie side.  In this imagined architecture the CXL port driver

s/pcie/PCIe/ to match other usage below.

> would then query into the PCI device for the DOE mailbox array.
> 
> For now this is good enough for the endpoints and the split is similar
> to the envisioned architecture where getting the mailbox array is
> separated from the various protocol needs.  For example, it is not
> anticipated that the CDAT code will need to move because it is only
> needed by the cxl_ports.
> 
> Likewise irq's are separated out in a similar design pattern to the
> PCIe port driver.  But a much simpler irq enabling flag is used and only
> DOE interrupts are supported.

I don't know what the convention is or will be for drivers/cxl.  In
drivers/pci, we favor "IRQ" over "irq" in English text to go along
with PCI, DOE, CDAT, etc.

Also makes "IRQs" intelligible where "irq's" looks a little funny
because the usage isn't possessive and "irqs" isn't obviously a word
or an acronym.

Bjorn
