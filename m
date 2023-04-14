Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483716E2BDB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNVtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDNVtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 17:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459819A2;
        Fri, 14 Apr 2023 14:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A960264998;
        Fri, 14 Apr 2023 21:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA5C433EF;
        Fri, 14 Apr 2023 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681508959;
        bh=1x7EeM3VZ+EADcoA4/MQ8ManxznxDJ06SrvK/B28czY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=buZL1sGMoy9FUtbGI+SKPAjVXE/ApbZRPVdEhzF5fgwsrF+S5TyVwqkdw1ffvFIhv
         d7kJg+pZpaE/I8r5dztw0BY9z3yT5AcfzB9enLYzZ5dtfm//nJSyOkf4X2Fx22yR/4
         RNwGj7CSMBBvAaq4NptWIRn5GlMvi5HWe+i8p3KsMDT8L71rv3py005BUOgMr5l9Qa
         AHVMVeih/iJM2dikBR0OoPsc4oY8s5H6JfcZtvL4kvUPJgLVoJy5JIS1x2VYe0ipag
         iX9G2b1kOubjkeH8LZ9uX2+FUFv/N7C/r0lzuLwJsXTIOrRCzuNCJ9WsKX9WzFL16T
         oa6Ri90e7zJZQ==
Date:   Fri, 14 Apr 2023 16:49:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Oliver O'Halloran <oohall@gmail.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <20230414214917.GA221407@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDgFv6AtCXkVl8IQ@rric.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 03:38:07PM +0200, Robert Richter wrote:
> On 12.04.23 16:29:01, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2023 at 01:03:02PM -0500, Terry Bowman wrote:
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > RCEC AER corrected and uncorrectable internal errors (CIE/UIE) are
> > > disabled by default.

> > > +static void cxl_unmask_internal_errors(struct pci_dev *rcec)
> 
> Also renaming this to cxl_enable_rcec() to more generalize the
> function.

I didn't follow this.  "cxl_enable_rcec" doesn't say anything about
"unmasking" or "internal errors", which seems like the whole point.
And the function doesn't actually *enable* and RCEC.

> > > +{
> > > +	if (!handles_cxl_errors(rcec))
> > > +		return;
> > > +
> > > +	if (__cxl_unmask_internal_errors(rcec))
> > > +		dev_err(&rcec->dev, "cxl: Failed to unmask internal errors");
> > > +	else
> > > +		dev_dbg(&rcec->dev, "cxl: Internal errors unmasked");
> 
> I am going to change this to a pci_info() for alignment with other
> messages around:
> 
> [   14.200265] pcieport 0000:40:00.3: PME: Signaling with IRQ 44
> [   14.213925] pcieport 0000:40:00.3: AER: cxl: Internal errors unmasked
> [   14.228413] pcieport 0000:40:00.3: AER: enabled with IRQ 44
> 
> Plus, using pci_err() instead of dev_err().

Thanks for that!

Bjorn
