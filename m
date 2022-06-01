Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC853AED0
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 00:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiFAUxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFAUxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 16:53:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950421112A;
        Wed,  1 Jun 2022 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654116822; x=1685652822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfeLxW/HpQLw+GEfWrr/3Qjls87VQ3SLjaDsiWsQoDk=;
  b=OxzaRPYEpYp8GgEoQcyGnQspp09wGeLUMfp7fH+NeL/4ocI2ai16dnl9
   eNPPuOi8V2H3z+u4b6nWBMI+tdw8/LGl8QefRv1Cy3IC9+J9AknPPCD33
   tRxZVk0VQL/LhSiCCRz+zFtuBMxGEhW5UBVITaU8kgyq10NrtS9412rGo
   HyIPBtSTSfdKXJWnqF43oJoNXbDlNdfstbuZwXLMwa18CIKntv+tTL0tD
   IwLbJhva/dQsWv41EGc/9omTnI7n5OgHz8szWFZ6x32Si9cJvVClRM6ZK
   le9slYXD9SOSQJ3O25yNR61LWazYAD/YbD2GjEb2YbPtimZwT0kRM0eM9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301077358"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="301077358"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 13:17:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="720946603"
Received: from cwmurphy-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.32.23])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 13:17:38 -0700
Date:   Wed, 1 Jun 2022 13:17:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YpfJYujerG2hM4vU@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-4-ira.weiny@intel.com>
 <20220530190657.GA14765@wunner.de>
 <20220531113350.0000421e@Huawei.com>
 <YpbWCYujYDEkMm1B@iweiny-desk3>
 <20220601071808.GA19924@wunner.de>
 <Ypee328j+l6ZdbUT@iweiny-desk3>
 <20220601175647.GA21509@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601175647.GA21509@wunner.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 07:56:47PM +0200, Lukas Wunner wrote:
> On Wed, Jun 01, 2022 at 10:16:15AM -0700, Ira Weiny wrote:
> > On Wed, Jun 01, 2022 at 09:18:08AM +0200, Lukas Wunner wrote:
> > > You only need to re-check the Data Object Ready bit on the last-but-one
> > > dword in case the function was reset concurrently.  Per sec. 6.30.2,
> > > "An FLR to a Function must result in the aborting of any DOE transfer
> > > in progress."
> > 
> > I think I disagree.  Even if we do that and an FLR comes before the last read
> > the last read could be 0's.
> 
> PCIe r6.0, Table 7-316 says:
> 
>   "If there is no additional data object ready for transfer, the
>    DOE instance must clear this bit after the entire data object has been
>    transferred, as indicated by software writing to the DOE Read Data
>    Mailbox Register after reading the final DW of the data object."
> 
> Remember that you *read* a dword from the mailbox and then acknowledge
> reception to the mailbox by *writing* a dword to the mailbox.
> 
> So you check that the Data Object Ready bit is set before acknowledging
> the final dword with a register write.  That's race-free.

Ok.

> 
> (I realize me talking about the "last-but-one dword" above was quite
> unclear, sorry about that.)
> 

Ah yes.  Ok, I'll put in a check before the final write.

Ira
