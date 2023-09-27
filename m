Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9497B0909
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjI0PjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjI0PiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:38:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2ECD9
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695829015; x=1727365015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4y2ufGhmhaXTWIjmW47x7Uel7sXWt7hrK42AXxm10zk=;
  b=VjNin6qzSHEjzZSjWj1PqNoukYf9H28GI38TILHI9FF9W9+gHthsgk3N
   i6lUNSPp/oMjDkGntdOuAQ9+nu4csgT/3OJr1RuRNUUXHT7ANckD3oT3f
   ugfXobzKHIALjl+8QuxiqoThiNKBWj3mZCTId9DzGTH6/fep5mpehuYlP
   JYESGmPDbxR4idSINapyorLvdYr0cOwejJyhdGnMm7x6y3075P34hv6m7
   bXcg+nAfLsQm0Zwoiso7V14ycZgV+dlKXOslEkECSCOb+96XZCBSt+mwC
   KEpvldm36noUmrl0LggMJv9uCzLmSEyvL5xY4gqk1SQKMkZP5aNZRwZyY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="384651401"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="384651401"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="725854404"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="725854404"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 08:36:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AE3C5177; Wed, 27 Sep 2023 18:36:50 +0300 (EEST)
Date:   Wed, 27 Sep 2023 18:36:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927153650.GL3208943@black.fi.intel.com>
References: <20230927051602.GX3208943@black.fi.intel.com>
 <20230927115703.GA445616@bhelgaas>
 <20230927124732.GI3208943@black.fi.intel.com>
 <20230927143143.GA16217@wunner.de>
 <20230927144248.GK3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927144248.GK3208943@black.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 05:42:48PM +0300, Mika Westerberg wrote:
> On Wed, Sep 27, 2023 at 04:31:43PM +0200, Lukas Wunner wrote:
> > On Wed, Sep 27, 2023 at 03:47:32PM +0300, Mika Westerberg wrote:
> > > This is not a Linux defect. The firmware is expected to create that
> > > tunnel so regardless of the "delay" the devices are already back. This
> > > is not happening.
> > 
> > I recall that newer chips can be switched over to software connection
> > manager at runtime.
> > 
> > Can we determine that the ICM firmware failed to do what it should,
> > kick it out and let the software connection manager take over?
> 
> No that's not possible. In Macs it was "partially" possible but even
> there you lose all the PM and the like. I don't even want to speculate
> what happens if you run the same on PCs.
> 
> There is an option to "force" this but I do not recommend this (pass
> thunderbolt.start_icm=1 in the command line).

Sorry, this is the complete opposite. This starts the firmware not stops
it but anyways everything else above is true ;-)
