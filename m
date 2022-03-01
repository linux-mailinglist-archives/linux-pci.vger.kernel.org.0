Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABA4C8CAD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 14:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiCANcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 08:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCANcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 08:32:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675169D4D4;
        Tue,  1 Mar 2022 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646141512; x=1677677512;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rPEZC56dHt+xxnN1y+l9smG/XUeEeiafGJU3lPYFGa0=;
  b=nFS8d1wStxk888XmkmJ/0qhByfXhaytsX1BOfy5xOpI35NH5KGpHp/FR
   B9FXdORb/zYEMu9wufpXJ++WT6KrnKEhjbvuQMpP374PxjYjWewb6N75i
   pjiMwG24aRotfAGPwL2/aIZ9d+U6iVhCjAZd8+6jRRDXpDmr1G8a8BRcH
   kdOspaMZFDmAUtPbSxeWFSFYk7kuqWbNNH/qCNPiDEf51/S5GPc5DmAPH
   AQr12qq2O6d0uGmfiRavLWjDifVP9SthQ7nhYZBuvy8uKhZXz/nPeaw09
   et864GC2/mQEvVJClr7RYRms2/UisN88IyEzM2vdn2vUs99LmK0JmQdlf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250711634"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250711634"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="534894424"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2022 05:31:51 -0800
Received: from sradha3-mobl1.amr.corp.intel.com (sradha3-mobl1.amr.corp.intel.com [10.212.250.139])
        by linux.intel.com (Postfix) with ESMTP id 8659A580BE9;
        Tue,  1 Mar 2022 05:31:51 -0800 (PST)
Message-ID: <ba9128b499b243f5c08f855018a37cd1484211b6.camel@linux.intel.com>
Subject: Re: [PATCH V6 1/3] PCI/ASPM: Add pci_enable_default_link_state()
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Christoph Hellwig <hch@infradead.org>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 01 Mar 2022 05:31:51 -0800
In-Reply-To: <Yh3Vt6/WzoAasPxZ@infradead.org>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
         <20220301041943.2935892-2-david.e.box@linux.intel.com>
         <Yh3Vt6/WzoAasPxZ@infradead.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-03-01 at 00:13 -0800, Christoph Hellwig wrote:
> On Mon, Feb 28, 2022 at 08:19:41PM -0800, David E. Box wrote:
> > +	down_read(&pci_bus_sem);
> > +	mutex_lock(&aspm_lock);
> > +	link->aspm_default = 0;
> > +	if (state & PCIE_LINK_STATE_L0S)
> > +		link->aspm_default |= ASPM_STATE_L0S;
> > +	if (state & PCIE_LINK_STATE_L1)
> > +		/* L1 PM substates require L1 */
> > +		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> > +	if (state & PCIE_LINK_STATE_L1_1)
> > +		link->aspm_default |= ASPM_STATE_L1_1;
> > +	if (state & PCIE_LINK_STATE_L1_2)
> > +		link->aspm_default |= ASPM_STATE_L1_2;
> > +	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> > +	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> > +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> 
> Is there any reason the ASPM_* values aren't passed directly to this
> function?

The ASPM_* macors aren't visible outside of aspm.c whereas the
PCIE_LINK_STATE_* macros are defined in pci.h. This is similar to what
is done for pci_disable_link_state().

David

