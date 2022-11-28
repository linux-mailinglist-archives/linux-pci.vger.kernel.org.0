Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8B63A205
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 08:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiK1Hgj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 02:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1Hgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 02:36:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC24E0CD
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2022 23:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669620997; x=1701156997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fhsnp5IipDoNgyUy56zWT+xR750gK5dqmLaPQLzU8k0=;
  b=G4KDF2dVhG7TRylbaAVqAz12Kn6KjgSiVr/8QVVv0uGGZB6GLQBTDDy5
   fEABttB0Bx4kMIkNhRkBZYAEsQH7xca74rWzPbvlJkmaBGbns8tUfy4mp
   //NyYVbBfccaMuykw+wYLMnjm2skuCtkcbI4GIxPbb1LA9Sf/8gkWi7Lp
   MinyVprrRLPee/CJNpFvg3ktuIMbdENbTRtyx5W1iTBym3qT0NFSDrcI2
   MlsH0WRaaoeOCYafQlchw0UidrkeC3DFWSOKW0Kcm5DPD9j67BGinhp90
   4MgT/cmSDeDIcFEh589ijm49qs1aZaX4m/IX7HKqYixmlRPDzZ6vWdeQv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="302344656"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="302344656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 23:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674130817"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674130817"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 23:36:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 78F6C179; Mon, 28 Nov 2022 09:37:02 +0200 (EET)
Date:   Mon, 28 Nov 2022 09:37:02 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <Y4RlHrk/vEIEXTIh@black.fi.intel.com>
References: <20221124093519.85363-1-mika.westerberg@linux.intel.com>
 <07c7fcb0-80d5-b29e-2dd3-11fb9b73cfd7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07c7fcb0-80d5-b29e-2dd3-11fb9b73cfd7@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 27, 2022 at 10:28:41PM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 11/24/22 1:35 AM, Mika Westerberg wrote:
> > Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> > or endpoints on the other hand only send messages (that get collected by
> > the former). For this reason do not require PCIe switch ports and
> > endpoints to use interrupt if they support AER.
> > 
> > This allows portdrv to attach to recent Intel PCIe switch ports that
> > don't declare MSI or legacy interrupts.
> 
> "Recent" looks vague. Maybe you can be more specific here.

Okay, maybe something like

"This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
discrete graphics cards. These do not declare MSI or legacy interrupts."

I will do this change in v2.

> Otherwise, it looks good to me.

Thanks!
