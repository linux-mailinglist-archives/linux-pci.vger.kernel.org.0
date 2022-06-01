Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90AB53AB64
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351569AbiFAQzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351331AbiFAQzm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 12:55:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF79E9E0;
        Wed,  1 Jun 2022 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654102542; x=1685638542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73mc9UeFg58ka932G9d5Vhn6ii7yZChtzbk6FVFDixA=;
  b=FiRQhHIe7y4rkj4KBb8VCynHNDzTipwleFNqCpVfpKEgPGE1exw894NX
   TMYfXQ4zKWLpvPEHUgv98SKJJIx25v+7VKi4BDgE/c5DxVQeqRcXZPqYK
   5DqyTzPiviaxgB2l/uS6mVe21fvuJjtN1CmTRavoldv7mW4lPsxiBFUuP
   TSzSNTKkUaOvLbsPNrS/80w6Gcb8shLbGjXiqiZIPGgcFoHhCIdIvh4pZ
   sYneSxW290LvqgLung0E64GzBL6j8ldPx6f9lAZCe7DfVQYuTF4+Cy6nO
   occajMI46O5naEOgDeoOyEWLpT3LoxtGsm/VNQbGWe1o82UQ3WpMN8o39
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275733973"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275733973"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:55:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="552399086"
Received: from cwmurphy-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.32.23])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:55:37 -0700
Date:   Wed, 1 Jun 2022 09:55:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        a.manzanares@samsung.com
Subject: Re: [PATCH v9 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YpeaCSvFo1Mqvsgv@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-4-ira.weiny@intel.com>
 <20220531172507.5ert5tgwellpe7fx@offworld>
 <20220531175652.qog7xaqmypy36whu@offworld>
 <Ypbw3d/vUyMHGcBW@iweiny-desk3>
 <20220601135909.mvnam4vvfmofpsdb@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601135909.mvnam4vvfmofpsdb@offworld>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 06:59:09AM -0700, Davidlohr Bueso wrote:
> On Tue, 31 May 2022, Ira Weiny wrote:
> > Thinking about it I don't see a benefit to a rwlock.  We don't have multiple
> > readers.
> 
> ... but you have concurrent workqueues reading the value of cur_task.

No, concurrent workqueues are reading the value of different DOE mailboxes'
cur_task.  Each mailbox has it's own lock for its current task.

This is a multiple writers to a single reader pattern.  The lock serializes
driver requests (possibly from different threads) into the single mailbox as
well as signaling when the cur_task is done; retire_cur_task().

At the same time multiple mailboxes can be running parallel.

I don't think taking the lock in doe_statemachine_work() is technically
necessary.   But I left it there for completeness because if the queue depth is
increased like it was in Jonathans original code the locking around cur_task
will need to be adjusted in this area.

Ira

> 
> Thanks,
> Davidlohr
