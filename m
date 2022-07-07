Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48656A7EE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiGGQWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGGQW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 12:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD232CC84;
        Thu,  7 Jul 2022 09:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA08F623C7;
        Thu,  7 Jul 2022 16:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291E3C3411E;
        Thu,  7 Jul 2022 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657210945;
        bh=HN6yvGVfevEjt75PnG4J8rUpc7xjiTvUZmOyG5gVKtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IMvF4f6cwmSSL2YUBBg7x2oJf9s+3uFnEP9GoviCcwUOdrzANU1J2xHC7pguJLCv1
         nRwjeXWdTUIyoPIgPzHd06b6+T7/cAPje5o+ei9+XZrlQeW1ktEeK4lMK4KHYJ0oHN
         nD+Pz7HuoxwZmeAFW0zsLaEnqDBNdhMLDRXcX5rP4V4KtsMiauY+Uh2Q58Vdc1Bh3L
         gIt2IdYa3P3XaNH94nIayGi/ISeINGl+rYHvKx8kJR6HToTGoVIUwpqQObB4ZgMXfR
         /RuM8ZPgmINLAVgz7Asn7DY/BgBuubRQk2C7XEX3PhYVxqOz8BlT8G5ZUVyNq4Rdmj
         QGFRYaVgVysrw==
Date:   Thu, 7 Jul 2022 11:22:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V13 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <20220707162223.GA307520@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-4-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 05, 2022 at 08:49:26AM -0700, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Possible subject:

  PCI/DOE: Add DOE mailbox support functions

(no trailing period required)

> Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> defined config space offset.  Functionality includes iterating,
> creating, query of supported protocol, and task submission.  Destruction
> of the mailboxes is device managed.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Whenever the CXL folks are happy with this:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> ...
> +		pci_err(pdev,
> +			"[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",

Since the string already wraps, I think there's no benefit to starting
it on its own line.  Joining with "pci_err(pdev, "[%x] ..." improves
greppability slightly.

> +			pci_err(pdev,
> +				"[%x] busy detected; another entity is sending conflicting requests\n",
> +				offset);

Ditto.

> + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> ...
> + * RETURNS: 0 when task has been successful queued, -ERRNO on error

successfully

> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> ...
> +	 * DOE requests must be a whole number of DW
> +	 * and the response needs to be big enough for at least 1 DW

Rewrap to fill 78 columns or so.
