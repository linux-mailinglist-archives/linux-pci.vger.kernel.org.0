Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E968FA24
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 23:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBHWQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 17:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjBHWQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 17:16:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A370527496;
        Wed,  8 Feb 2023 14:16:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5375CB81FC8;
        Wed,  8 Feb 2023 22:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B527EC433D2;
        Wed,  8 Feb 2023 22:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675894561;
        bh=180SwzFa3o9190yU4lPgphWW7oAP/AsKVzVTKpBhdFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PCBPy7LT6va7KOH+Jo+krtjMix4dGI7mDcDTWnG/Gc3lRR3I9W5QoJKd4iK3BtlN3
         N98qAUmQb/YCkqtJNan6yqxvD+Wv8wZkZkHDuzSxaSpUE/LbPoDiFN0Y2ulErutGcr
         /dBygnVGUXS1nfPb/Q9Ie7lvY3AderL998kSFhq2zsil9vM57q807j2vsrozsBdf4+
         1T4OBTd5E1C8bHutUoiqmsLxS072Gzyq/om8WFba+LctGFpRg01cee77psCCeu4rU8
         8WoOq/WoiTcKE5QrZ28F4VgfhvPG74HqkebH+2tXMo3WpcYET3GemDKz0cBkgpA1KU
         ovOUQcNk3QgRA==
Date:   Wed, 8 Feb 2023 16:15:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Subject: Re: [PATCH 12/18] cxl: Add helpers to calculate pci latency for the
 CXL device
Message-ID: <20230208221559.GA2489627@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f777db-fdc4-3f6e-ced5-d7bc43f6a340@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 07, 2023 at 01:51:17PM -0700, Dave Jiang wrote:
> 
> 
> On 2/6/23 3:39 PM, Bjorn Helgaas wrote:
> > On Mon, Feb 06, 2023 at 01:51:10PM -0700, Dave Jiang wrote:
> > > The latency is calculated by dividing the FLIT size over the
> > > bandwidth. Add support to retrieve the FLIT size for the CXL
> > > device and calculate the latency of the downstream link.

> > I guess you only care about the latency of a single link, not the
> > entire path?
> 
> I am adding each of the link individually together in the next
> patch. Are you suggesting a similar function like
> pcie_bandwidth_available() but for latency for the entire path?

Only a clarifying question.

> > > +static int cxl_get_flit_size(struct pci_dev *pdev)
> > > +{
> > > +	if (cxl_pci_flit_256(pdev))
> > > +		return 256;
> > > +
> > > +	return 66;
> > 
> > I don't know about the 66-byte flit format, maybe this part is
> > CXL-specific?
> 
> 68-byte flit format. Looks like this is a typo from me.

This part must be CXL-specific, since I don't think PCIe mentions
68-byte flits.

> > > + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> > > + * mode, otherwise it's 68B flits mode.
> > > + */
> > > +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
> > > +{
> > > +	u32 lnksta2;
> > > +
> > > +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> > > +	return lnksta2 & BIT(10);
> > 
> > Add a #define for the bit.
> 
> ok will add.
> 
> > 
> > AFAICT, the PCIe spec defines this bit, and it only indicates the link
> > is or will be operating in Flit Mode; it doesn't actually say anything
> > about how large the flits are.  I suppose that's because PCIe only
> > talks about 256B flits, not 66B ones?
> 
> Looking at CXL v1.0 rev3.0 6.2.3 "256B Flit Mode", table 6-4, it shows that
> when PCIe Flit Mode is set, then CXL is in 256B flits mode, otherwise, it is
> 68B flits. So an assumption is made here regarding the flit side based on
> the table.

So reading PCI_EXP_LNKSTA2 and extracting the Flit Mode bit is
PCIe-generic, but the interpretation of "PCIe Flit Mode not enabled
means 68-byte flits" is CXL-specific?

This sounds wrong, but I don't know quite how.  How would the PCI core
manage links where Flit Mode being cleared really means Flit Mode is
*enabled* but with a different size?  Seems like something could go
wrong there.

Bjorn
