Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD1742888
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjF2OgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjF2Ofy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 10:35:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B73C14
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688049309; x=1719585309;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=S04ni7+1VddG+EEOMBUtQbX4vrkPBPx8pGqYeB9E16g=;
  b=aFbwXZrNVdgvM7kMMdWVw18+uEivWAQrqxq2AQNEXAaXYe7rHIaMtvMV
   8qgzCnpUkafBtZkbV9aSjmJZ8WpPmZtS0iLpzPt2ZrstvJjbkmHeuIdvu
   xEzKWsGySo3lX5mu4x7xaYRxpWkx/rCoWng4+krlZ41S6irrJs11bNfJE
   Ma1iDM4aRwOqpGJzj9KivNcURldkqPoNiRTRovuYVDMt3GpehOKA3C1Xz
   V8fGgDrNE8o2VvQyf7VDVaKSn6499Nk/9VX2uIoTrXYPkMHuTVm+6aUQh
   EnhRqtkb+piSnPWqu7JjPi95Z9gSQRiDthl6+vV6D0w9s0GGRyEBVfRxG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="351943274"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="351943274"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 07:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="787373428"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="787373428"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2023 07:24:55 -0700
Received: from petermce-mobl.ger.corp.intel.com (unknown [10.209.78.234])
        by linux.intel.com (Postfix) with ESMTP id 6CCDD5804D9;
        Thu, 29 Jun 2023 07:24:55 -0700 (PDT)
Message-ID: <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Thomas Witt <thomas@witt.link>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Witt <kernel@witt.link>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Date:   Thu, 29 Jun 2023 07:24:55 -0700
In-Reply-To: <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
References: <20230627100447.GC14638@black.fi.intel.com>
         <20230627204124.GA366188@bhelgaas>
         <20230628064637.GF14638@black.fi.intel.com>
         <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
         <20230628105940.GK14638@black.fi.intel.com>
         <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-06-29 at 11:47 +0200, Thomas Witt wrote:
> On 28/06/2023 12:59, Mika Westerberg wrote:
> > I wonder if the patch actually helps here now because the reason we wan=
t
> > to add it back is that it allows the CPU to enter lower power states an=
d
> > thus reducing the power consumption in S2idle too. Do you observe that
> > when you have the patch applied?
>=20
> No joy. I did not check what its actually doing, but the computer takes=
=20
> about 150mA over the charger at idle with screen off and 140mA in=20
> suspend. With mem_sleep set to "deep", it takes about 20mA in suspend.=
=20
> All with the battery at 100%, at 19.7V.
>=20
> So I guess I want to keep the "deep" setting in my cmdline.

It's likely something is not entering the right state. You can try the foll=
owing
script to check what the cause may be.

https://github.com/intel/S0ixSelftestTool

David

>=20
> BR
> Thomas
>=20

