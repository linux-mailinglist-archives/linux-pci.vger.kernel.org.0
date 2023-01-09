Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0876C6623DC
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjAILK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 06:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjAILK5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 06:10:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961F64C3
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673262656; x=1704798656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0xQk74+xvyKIcdFX00z0CYMSL/O7r51rogIWSBwGo8g=;
  b=JN/69ZAZUMHQ03SefSZWtPqN1s8R/Jp/OxBB4j9AL+lpXPD1VLuH0BYU
   txqYEkC5PrUA26o7QXFN8N6cXUGFOWp3PaQGSUteEiMKF1kgOFqByuv6I
   YYEQed8zqBX1eRoluSS6YjCpW3KnatjXUgg+McC0MKr+s0rLSJyOukeNV
   EtKTp5EP3DkOD/Qn6H+hxFCKXZC/sgnM4s44H/AdmiB2RSZ0UwSdiwjYi
   nHl6KXKxfs1YM5ya+eKwuJ6WzQ0Ny3LqLvd0Lbh0PHh+zkTzqWqxwhHhd
   5CLsHogEdaJnLYlpewEIR5LU/7WDE0erABjzIpVjVxzcXZhTzJ5Fjm6iC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322923517"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322923517"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="656647331"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656647331"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2023 03:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BB58DF4; Mon,  9 Jan 2023 13:11:25 +0200 (EET)
Date:   Mon, 9 Jan 2023 13:11:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <Y7v2XT1N4J1deVEt@black.fi.intel.com>
References: <Y7bUAaxt6viswdXV@black.fi.intel.com>
 <20230105170413.GA1150738@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105170413.GA1150738@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 05, 2023 at 11:04:13AM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 05, 2023 at 03:43:29PM +0200, Mika Westerberg wrote:
> > On Thu, Jan 05, 2023 at 11:12:11AM +0200, Mika Westerberg wrote:
> > > > What happens in a topology like this:
> > > > 
> > > >   10:00.0 non-hotplug bridge to [bus 20-3f]
> > > >   10:01.0 non-hotplug bridge to [bus 40]
> > > >   20:00.0 hotplug bridge
> > > >   40:00.0 NIC
> > > > 
> > > > where we're distributing space on "bus" 10, hotplug_bridges == 0 and
> > > > normal_bridges == 2?  Do we give half the extra space to bus 20 and
> > > > the other half to bus 40, even though we could tell up front that bus
> > > > 20 is the only place that can actually use any extra space?
> > > 
> > > Yes we split it into half.
> > 
> > Forgot to reply also that would it make sense here to look at below the
> > non-hotplug bridges and if we find hotplug bridges, distribute the space
> > equally between those or something like that?
> 
> Yes, I do think ultimately it would make sense to keep track at every
> bridge whether it or any descendant is a hotplug bridge so we could
> distribute extra space only to bridges that could potentially use it.
> 
> But I don't know if that needs to be done in this series.  This code
> is so complicated and fragile that I think being ruthless about
> defining the minimal problem we're solving and avoiding scope creep
> will improve our chances of success.
> 
> So treat this as a question to improve my understanding more than
> anything.

Okay, undestood ;-)
