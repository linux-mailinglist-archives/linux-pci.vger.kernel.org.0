Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95906678AC4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjAWWa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 17:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjAWWa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 17:30:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB3C3756E;
        Mon, 23 Jan 2023 14:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77C826116F;
        Mon, 23 Jan 2023 22:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF453C4339B;
        Mon, 23 Jan 2023 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674513054;
        bh=SC5wpST6X4zsnOpfpoPHoMTShe9VsT6W9HY+feOLJN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uHf5O1Qg87zbb1mWN2/1PbndZQlt3iwV1g02yVdohjQ59LgjZYCXzvvX/PdI8QJ/j
         MyNCdL4TPfqMwF152yIJ1e+GqIYoBMfXPyHqMzI68luGAqDuMISqf42gm3n+5+h04p
         UkXUfaCg2M69UuzJ8greQEZ4Pvh8PtYDk7TGJa2StlwhnrUYemZGAqMh3OSvIIpI9X
         IzlfKEHXEsvaJogNtEuoD/z2JgKU6q05uko8LpP01IR/rNyXIMcH6OuXxC6RFpeoje
         6J5FCnf1DFx/mHidgV9Z5ddAbSxKKGz7HCl03piankk2KOGgnoUecY6D9fG8cp/4mq
         0ggC6BRdFr5QQ==
Date:   Mon, 23 Jan 2023 16:30:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Collection of DOE material
Message-ID: <20230123223053.GA994135@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674468099.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 11:10:00AM +0100, Lukas Wunner wrote:
> Collection of DOE material, v2:
> 
> * Fix WARN splat reported by Gregory Price
> * Migrate to synchronous API
> * Create DOE mailboxes in PCI core instead of in drivers
> * No longer require request and response size to be multiple of 4 bytes
> 
> This is in preparation for CMA device authentication (PCIe r6.0, sec 6.31),
> which performs DOE exchanges of irregular size and is going to be handled
> in the PCI core.  The synchronous API reduces code size for DOE users.
> 
> Link to CMA development branch:
> https://github.com/l1k/linux/commits/doe
> 
> 
> Changes v1 -> v2:
> * [PATCH v2 01/10] PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y 
>   * Add note in kernel-doc of pci_doe_submit_task() that pci_doe_task must
>     be allocated on the stack (Jonathan)
> * [PATCH v2 05/10] PCI/DOE: Make asynchronous API private
>   * Deduplicate note in kernel-doc of struct pci_doe_task that caller need
>     not initialize certain fields (Jonathan)
> 
> Link to v1:
> https://lore.kernel.org/linux-pci/cover.1669608950.git.lukas@wunner.de/
> 
> 
> Lukas Wunner (10):
>   PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y
>   PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y
>   PCI/DOE: Provide synchronous API and use it internally
>   cxl/pci: Use synchronous API for DOE
>   PCI/DOE: Make asynchronous API private
>   PCI/DOE: Allow mailbox creation without devres management
>   PCI/DOE: Create mailboxes on device enumeration
>   cxl/pci: Use CDAT DOE mailbox created by PCI core
>   PCI/DOE: Make mailbox creation API private
>   PCI/DOE: Relax restrictions on request and response size

Looks nice.  Do you envision getting acks from the CXL folks and
merging via the PCI tree, or the reverse?

Bjorn
