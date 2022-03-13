Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7474D7880
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 22:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiCMVwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiCMVww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 17:52:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FBD56212;
        Sun, 13 Mar 2022 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647208304; x=1678744304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjVd8cturXGZmGe8andxrrHRkoNcB+kQTYO3rJ+bTec=;
  b=EpiquG1X/u2w1nvqqJcqLYt60vCd26DErXldMeyQ2lvGkLTJix7AtE6N
   CXl7ahme3xj3YPr0CO/IKPaRigUdO5U13q/tWghC+Xt3gs0UVv/80qCTB
   WApd7fHuIPoyxrX/rsbnoJUW2snSrj94oIdGP1CzRHRK0aBinOinRYA9P
   HClxOyfHeZTiUU5bGGxBOUM2XtVo8tXHfgSag5JgxMpRqI2UWhm3Rdw5M
   Gcc6JsAlEprWxqsomcnqohXoWvhGt328TcupqZ08m2BZtet+tUxWHWmR+
   /6NzWQRLT9gqcl1QKE5whPmj9ispfDP6pAjJl9M/KA3NNJu3AaY3LsJHU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253460215"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="253460215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 14:51:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="556126366"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 14:51:43 -0700
Date:   Sun, 13 Mar 2022 14:43:14 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Badger <ebadger@purestorage.com>,
        linuxppc-dev@lists.ozlabs.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220313214314.GD182809@otc-nc-03>
References: <20220311025807.14664-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220313195220.GA436941@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313195220.GA436941@bhelgaas>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 13, 2022 at 02:52:20PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 11, 2022 at 02:58:07AM +0000, Kuppuswamy Sathyanarayanan wrote:
> > Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> > PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> > assumption is incorrect.
> > 
> > Consider a scenario where aer_irq() is triggered for a correctable
> > error, and while we process the error and before we clear the error
> > status in "Root Error Status" register, if the same kind of error
> > is triggered again, since aer_irq() only clears events it saw, the
> > multi-bit error is left in tact. This will cause the interrupt to fire
> > again, resulting in entering aer_irq() with just the multi-bit error
> > logged in the "Root Error Status" register.
> > 
> > Repeated AER recovery test has revealed this condition does happen
> > and this prevents any new interrupt from being triggered. Allow to
> > process interrupt even if only multi-correctable (BIT 1) or
> > multi-uncorrectable bit (BIT 3) is set.
> > 
> > Reported-by: Eric Badger <ebadger@purestorage.com>
> 
> Is there a bug report with any concrete details (dmesg, lspci, etc)
> that we can include here?

Eric might have more details to add when he collected numerous logs to get
to the timeline of the problem. The test was to stress the links with an
automated power off, this will result in some eDPC UC error followed by
link down. The recovery worked fine for several cycles and suddenly there
were no more interrupts. A manual rescan on pci would probe and device is
operational again.

The test patch revealed we entered the aer_irq() with just the multi-error
PCI_ERR_ROOT_MULTI_COR_RCV or PCI_ERR_ROOT_MULTI_UNCOR_RCV, then we didn't
clear those bits causing interrupt generation to cease after that.

Cheers,
Ashok
