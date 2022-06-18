Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8E550620
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiFRQjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jun 2022 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiFRQjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jun 2022 12:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D279FD05;
        Sat, 18 Jun 2022 09:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E46F160F0C;
        Sat, 18 Jun 2022 16:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D46C3411A;
        Sat, 18 Jun 2022 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655570371;
        bh=twtOJw4hn7qZLSBUAVevuQy1fZO2I0MokLlWvf+gzSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hMdaUPsw3/cbyiWgPOcGrS9hHTWIQ+Qn5AGuEpdDUp9Y5H9AIstV+rZNWuA0bgZNz
         TRChA22h4bsD+HviGfmZIcdkXG6xxK+wTTHk/5gpLDhvhy/ew2WRdNx16QO3vnytvk
         f7et/tC1OFuDP4TZdjiw0M9Lf74uP9ki0TN9KPv99sHZAWswaBvGdGURN69KwZUOBQ
         HEWta4E2WVOA4WrwTEymBEXpTnj+GWKb2QmuLJuY0s4BZPX6t5OxQwBJskEOwz+a9H
         xHsL6+lmq6gDB2vCc8qEBPDurdm0sEGjA8xnGQwm1kfRgArahopr2N0Z2wrywdjBtx
         45IW84wnZ66sg==
Date:   Sat, 18 Jun 2022 11:39:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220618163927.GA1235355@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617224019.GA1208614@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 05:40:19PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2022 at 01:22:54PM -0700, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.

> > + * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
> > + *
> > + * @pdev: The PCI device
> > + * @offset: Offset of the DOE mailbox
> > + *
> > + * Returns: irq number on success
> > + *	    -errno if irqs are not supported on this mailbox
> > + */
> > +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
> > +{
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > +	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> > +		return -EOPNOTSUPP;
> > +
> > +	return FIELD_GET(PCI_DOE_CAP_IRQ, val);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_get_irq_num);
> 
> Confusing function name (and comment) since PCI_DOE_CAP_IRQ is an
> Interrupt Message Number that has nothing to do with Linux IRQ
> numbers.
> 
> I see we already have PCI_EXP_FLAGS_IRQ, PCI_ERR_ROOT_AER_IRQ,
> PCI_EXP_DPC_IRQ, so I guess you're in good company.

Should have been more clear about this: I think we should rename the
new one to be PCI_DOE_CAP_INT_MSG_NUM or similar, and rename the
function as well.  It's too confusing to use "irq" for both Linux IRQs
and what the spec calls "Interupt Message Numbers".

Bjorn
