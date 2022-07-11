Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4D570D88
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiGKWr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKWr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:47:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD11DA5B;
        Mon, 11 Jul 2022 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVb8qI+Iy0WZdlOU+oxerSlvClQzfHKYxHE8YXk9e58=; b=rsrFIyjxmoIi1JK7GwRQ1fbpvN
        nUfUOVKJ3rU7R707zHlbNUoEsmiWftZmgkmrV6tX4GwdOzPzy2j+eCWsyTHfsi3q5W6zwMlTAENCi
        VMk0FDemCYS9Gj2vGHdMXFXw7oicN2djBNdOPmYBGcaKbiGvgy0JF821yMubcAd49uA0iPzV6+URj
        Idp4jOqwqLqiHs32Q9VuKHinvX2+ybg65PYFvmGlakqpSZ6GpmmAapxfrV5VkuCMoYz0tEzu6CwcH
        chXd7b5H9D7T9TiezBR/rzNCliG8fOY6WD/3OJYNmeMdFzMiQbT3bh/H7MWfN0YI3fc1BKiqpLzoy
        iGJ2ZsFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB2Bf-006Lxj-SB; Mon, 11 Jul 2022 22:47:31 +0000
Date:   Mon, 11 Jul 2022 23:47:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V13.1] PCI/DOE: Add DOE mailbox support functions
Message-ID: <Ysyog0OFUu+5MIxT@casper.infradead.org>
References: <20220705154932.2141021-4-ira.weiny@intel.com>
 <20220711222748.470340-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711222748.470340-1-ira.weiny@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 11, 2022 at 03:27:48PM -0700, ira.weiny@intel.com wrote:
> +/**
> + * struct pci_doe_mb - State for a single DOE mailbox
> + *
> + * This state is used to manage a single DOE mailbox capability.  All fields
> + * should be considered opaque to the consumers and the structure passed into
> + * the helpers below after being created by devm_pci_doe_create()
> + *
> + * @pdev: PCI device this mailbox belongs to
> + * @cap_offset: Capability offset
> + * @prots: Array of protocols supported (encoded as long values)
> + * @wq: Wait queue for work item
> + * @work_queue: Queue of pci_doe_work items
> + * @flags: Bit array of PCI_DOE_FLAG_* flags
> + *
> + * Note: @prots can't be allocated with struct size because the number of
> + * protocols is not known until after this structure is in use.  However, the
> + * single discovery protocol is always required to query for the number of
> + * protocols.
> + */

Can you add at least stub documentation in Documentation/PCI/doe.rst
and include the kernel-doc from both pci-doe.c and pci-doe.h?

> +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	unsigned long timeout_jiffies;
> +
> +	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);

"Issuing DOE abort", perhaps?

