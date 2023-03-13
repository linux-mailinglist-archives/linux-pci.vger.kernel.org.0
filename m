Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119A36B81E9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 20:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCMTzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCMTze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 15:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7330B18;
        Mon, 13 Mar 2023 12:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3287614B7;
        Mon, 13 Mar 2023 19:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C39BC433EF;
        Mon, 13 Mar 2023 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678737332;
        bh=O0BGX1z93oxxZhwU7kFkfssgOsCKZZ8CfrG7bcT9DII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SB06ZCBu09lo7ddQDwEVWWvfVkUbtU75JYTz8sFDUfNuk1mYeFdRftzE4nCH6FDIR
         6AlA/0+XrvonYwsgFF3uI1b3h1AU8YDCIP/W1Y+B2vtj9qiKy8UJjDBLqWuvJC9FEV
         w3QmUsW3l1LgnMBSRHblbNssHJ9T27hdoyQBQ2IwclUbqHBnRxR9ic6dNVmdqb27zZ
         OUWngJ+kBIAXDR5DnkjH//LBuC17iy5ECTIubSJJhqm0E+i2MqI/QQTtsbP5wh/8Do
         b2vS67rLaz7m6rl0cg6LXkN4704ccpSmMtLv3RGxVJkLEvGY8pIbsIyn1euVBXxO2u
         cM5k2OmRgCnFQ==
Date:   Mon, 13 Mar 2023 14:55:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
        linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
Subject: Re: [PATCH v4 00/17] Collection of DOE material
Message-ID: <20230313195530.GA1532686@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 11, 2023 at 03:40:00PM +0100, Lukas Wunner wrote:
> Collection of DOE material, v4:
> 
> Migrate to synchronous API, create mailboxes in PCI core instead of
> in drivers, relax restrictions on request/response size.
> 
> This should probably go in via the cxl tree because Dave Jiang is
> basing his cxl work for the next merge window on it.
> 
> The first 6 patches are fixes, so could be applied immediately.
> 
> Thanks!
> 
> 
> Changes v3 -> v4:
> 
> * [PATCH v4 01/17] cxl/pci: Fix CDAT retrieval on big endian
>   * In pci_doe_discovery(), add request_pl_le / response_pl_le variables
>     to avoid typecasts in pci_doe_task initializer (Jonathan)
>   * In cxl_cdat_read_table(), use __le32 instead of u32 for "*data"
>     variable (Jonathan)
>   * Use sizeof(__le32) instead of sizeof(u32) (Jonathan)
> 
> * [PATCH v4 03/17] cxl/pci: Handle truncated CDAT entries
>   * Check for sizeof(*entry) instead of sizeof(struct cdat_entry_header)
>     for clarity (Jonathan)
> 
> * [PATCH v4 12/17] PCI/DOE: Create mailboxes on device enumeration
>   * Amend commit message with additional justification for the commit
>     (Alexey)
> 
> * [PATCH v4 16/17] cxl/pci: cxl/pci: Simplify CDAT retrieval error path
>   * Newly added patch in v4 on popular request (Jonathan, Dave)
> 
> * [PATCH v4 17/17] cxl/pci: Rightsize CDAT response allocation
>   * Amend commit message with spec reference to the Table Access
>     Response Header (Ira)
>   * In cxl_cdat_get_length(), check for sizeof(response) instead of
>     2 * sizeof(u32) for clarity
> 
> Link to v3:
> 
> https://lore.kernel.org/linux-pci/cover.1676043318.git.lukas@wunner.de/
> 
> 
> Dave Jiang (1):
>   cxl/pci: Simplify CDAT retrieval error path
> 
> Lukas Wunner (16):
>   cxl/pci: Fix CDAT retrieval on big endian
>   cxl/pci: Handle truncated CDAT header
>   cxl/pci: Handle truncated CDAT entries
>   cxl/pci: Handle excessive CDAT length
>   PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y
>   PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y
>   PCI/DOE: Provide synchronous API and use it internally
>   cxl/pci: Use synchronous API for DOE
>   PCI/DOE: Make asynchronous API private
>   PCI/DOE: Deduplicate mailbox flushing
>   PCI/DOE: Allow mailbox creation without devres management
>   PCI/DOE: Create mailboxes on device enumeration
>   cxl/pci: Use CDAT DOE mailbox created by PCI core
>   PCI/DOE: Make mailbox creation API private
>   PCI/DOE: Relax restrictions on request and response size
>   cxl/pci: Rightsize CDAT response allocation

Acked-by: Bjorn Helgaas <bhelgaas@google.com> for the PCI/DOE patches,
and I assume these will all be merged via the cxl tree.

>  .clang-format           |   1 -
>  drivers/cxl/core/pci.c  | 140 +++++++---------
>  drivers/cxl/cxlmem.h    |   3 -
>  drivers/cxl/cxlpci.h    |  14 ++
>  drivers/cxl/pci.c       |  49 ------
>  drivers/pci/doe.c       | 342 ++++++++++++++++++++++++++++++----------
>  drivers/pci/pci.h       |  11 ++
>  drivers/pci/probe.c     |   1 +
>  drivers/pci/remove.c    |   1 +
>  include/linux/pci-doe.h |  62 +-------
>  include/linux/pci.h     |   3 +
>  11 files changed, 350 insertions(+), 277 deletions(-)
> 
> -- 
> 2.39.1
> 
