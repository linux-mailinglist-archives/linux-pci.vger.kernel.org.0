Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659F44F5627
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 08:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiDFFn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiDFBsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 21:48:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB814967D;
        Tue,  5 Apr 2022 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649200933; x=1680736933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cym0Pw0QcLDQnr52mNX0ucLJTCN58zuKPpTCX2cEV8g=;
  b=OpNzHCZO+Gqk3Z/3TLfcMiGQRl1zs0rZqw6R7TOJY5MfoSWQWPYoWclY
   T48ZkAfTjlgvovNdeAe8ei7AqN2ENwuWz7/Q6iBiuSRmdjU+pylOXm7bN
   BCJ+I/egRO/ugiVyyqQVcVXMcdozrmJRxcPY2WwgR6K4bFxfqIhCpEGUb
   CINrLiTBw8zCeMCDwy6rMmaQxCexkabTW6mlhkqglT6vK+iin5FmrLhw3
   dFZ3v9TbyW0hs0Ye7SpbPD+G7DK+6U2TISWSX9JDdMtcuJbWrjRl7RsKa
   GGk75KHLzOR3oQzK3ZdQKt0FMHD0EoY55FImbAIVDgOfTiotlk+pTX4Tb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260881728"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260881728"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:22:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="722255356"
Received: from dforbisx-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.115.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:22:12 -0700
Date:   Tue, 5 Apr 2022 16:22:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YkzPIzIhfzQKIMe0@iweiny-desk3>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
 <20220330235920.2800929-4-ira.weiny@intel.com>
 <YkVBJ+nRA2g/WDxa@infradead.org>
 <YkXGnKsTEUAe29io@iweiny-desk3>
 <20220402144845.GA7822@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402144845.GA7822@wunner.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 02, 2022 at 04:48:45PM +0200, Lukas Wunner wrote:
> On Thu, Mar 31, 2022 at 08:19:56AM -0700, Ira Weiny wrote:
> > On Wed, Mar 30, 2022 at 10:50:31PM -0700, Christoph Hellwig wrote:
> > > On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:
> > > > Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> > > > with standard protocol discovery.  Each mailbox is accessed through a
> > > > DOE Extended Capability.
> > > 
> > > I really don't think this should be built unconditionally and bloat
> > > every single kernel built with PCI support.
> > 
> > I can add a Kconfig.
> 
> Ideally, that config option should live in the pcie/ subdirectory,
> i.e. in drivers/pci/pcie/Kconfig, alongside drivers/pci/pcie/doe.c,
> as we try to consolidate PCIe-specific features there and reserve
> core code in drivers/pci/*.c for functionality that also applies
> to Conventional PCI.

Thanks for letting me know about this direction.  I was unaware of this.

I'll move the file no problem, thanks,
Ira

> 
> Thanks,
> 
> Lukas
