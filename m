Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760284EDC9B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiCaPV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiCaPV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 11:21:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDCD194AA9;
        Thu, 31 Mar 2022 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648740011; x=1680276011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpfE9EOmt5CFwh3mL9y2HjLfgZakXpxm9CD99bN3kIk=;
  b=X+P0mrnGugJdJN9w8QQWZJ61xpdwQCrJsH2LSsV+mGzXnvQWm+3xQKhZ
   NSVSzikNi51lrEVFhgAkN9gI0hF9boUZMwxsUgSyEpabEPvRK47WGp+EK
   LhwbWvjA+H2RWwG7TAm26Y0+NOQR21pHIJ5u5gvUDlBpR2l7+eJmLZlnJ
   8K+dnsb5RAPWnsp5FOjL9b5t8NacSS0yG3r3vdVakNflHL6sczhtiv6jY
   yzv5ZaMacDZNqzUPxMhPXEtTuwwKcw1Trzoj1QIR9vq7jAoiNmdWd8Ylw
   a4Kck95t3yWrxq1nxVhUJnWF+rQ+2gdbJQi51CGIdzYJY0TvHP1BBIiGM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="323043672"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="323043672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 08:19:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="520610411"
Received: from sgkeithl-mobl3.amr.corp.intel.com (HELO localhost) ([10.213.179.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 08:19:57 -0700
Date:   Thu, 31 Mar 2022 08:19:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YkXGnKsTEUAe29io@iweiny-desk3>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
 <20220330235920.2800929-4-ira.weiny@intel.com>
 <YkVBJ+nRA2g/WDxa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkVBJ+nRA2g/WDxa@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 10:50:31PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> > with standard protocol discovery.  Each mailbox is accessed through a
> > DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCI functionality to manage a single PCI DOE mailbox at a
> > defined config space offset.  Functionality includes creating, supported
> > protocol queries, submit tasks to, and destroying the new state objects.
> > 
> > If interrupts are desired, interrupts vectors should be allocated prior
> > to asking for irq's when creating a mailbox object.
> 
> I really don't think this should be built unconditionally and bloat
> every single kernel built with PCI support.

I can add a Kconfig.

Thanks for looking,
Ira
