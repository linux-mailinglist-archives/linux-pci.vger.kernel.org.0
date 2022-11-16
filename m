Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715C262B72F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 11:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKPKJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 05:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKPKJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 05:09:42 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D0F1DDC0;
        Wed, 16 Nov 2022 02:09:40 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 390A13000BA01;
        Wed, 16 Nov 2022 11:09:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 269184378B; Wed, 16 Nov 2022 11:09:39 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:09:39 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <20221116100939.GA32050@wunner.de>
References: <20221115011943.1051039-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115011943.1051039-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> stack.  This causes the work structure to be allocated on the stack
> without pci_doe_submit_task() knowing.  Work item initialization needs
> to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> how the work item is allocated.
> 
> Jonathan suggested creating doe task allocation macros such as
> DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> function is not known to the callers and must be initialized correctly.
> 
> A follow up suggestion was to have an internal 'pci_doe_work' item
> allocated by pci_doe_submit_task().[2]  This requires an allocation which
> could restrict the context where tasks are used.
> 
> Compromise with an intermediate step to initialize the task struct with
> a new call pci_doe_init_task() which must be called prior to submit
> task.
> 
> [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667

We have object_is_on_stack(), included from <linux/sched/task_stack.h>.

So you could just autosense in pci_doe_submit_task() whether
pci_doe_task is on the stack and call the appropriate INIT_WORK
variant.

Any reason not to do that?

Thanks,

Lukas
