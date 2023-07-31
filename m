Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385D769A43
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGaPBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjGaPBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 11:01:45 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175FE78
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690815704; x=1722351704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0GTWO4SmXJxUphFXKRsxWk6s1j3XoIyGvJhxu9fzcEQ=;
  b=KVko8NrjzykmsEDifa4tLKYObmGAx/gIvR+nomuY+E9dzucrhpY3ni+y
   xaKNtwKYHByrPhNbDqO7ZZbEcvQaYTlpFVOyHHieKIvJQR4p+1xKdrfDD
   qK9jOnwFH17rrD0BYwR0TpDHU4GaAbaSPaAh60cA0ntRPClczdNManHD0
   42+rQMKRbKCcb3KSIaa0Dsz6y5OyUqRd+betfxB+e67aaF5XfpkhHj1/0
   yyT8PqXFNO4moQclXpuSAGJ/2tp1lCGPTe819LAIOOvcgJ2LBl0LMI4wC
   8c1H3xh0uFQi7kzNXBgrI7vh9yg/Jv2SNsHHqEoVHNWZOuqsH+N0OPiKu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367940486"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="367940486"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 08:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818363349"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="818363349"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2023 08:01:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C60A11E8; Mon, 31 Jul 2023 18:01:28 +0300 (EEST)
Date:   Mon, 31 Jul 2023 18:01:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Witt <thomas@witt.link>
Cc:     david.e.box@linux.intel.com, Thomas Witt <kernel@witt.link>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230731150128.GK14638@black.fi.intel.com>
References: <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
 <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
 <20230630104154.GS14638@black.fi.intel.com>
 <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
 <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
 <6673c6a1-16ba-aaa4-707a-70d92d9751f6@witt.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6673c6a1-16ba-aaa4-707a-70d92d9751f6@witt.link>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Thu, Jul 06, 2023 at 09:14:27PM +0200, Thomas Witt wrote:
> On 05/07/2023 22:53, David E. Box wrote:
> > Mika is now out on extended vacation. We still need a solution that will enable
> > the L1 substate save/restore without breaking your system. I'd like to try to
> > get the power consumption lowered on your system while suspended with s2idle.
> > The s0ix self test script will really help to tell us where to start. You can
> > provide the results in the bugzilla.
> > 
> > The other thing we can do is find out why it only breaks under S3. It could be
> > timing related, so I've attached another patch to the bugzilla to test this.
> > 
> > https://bugzilla.kernel.org/attachment.cgi?id=304553
> > 
> > Please let me know if it works. Thanks.
> > 
> > David
> 
> Hi David,
> 
> I tried your patch, and I see no difference from Mika's. Still not coming
> back from suspend.

Thanks for trying that. Did you manage to try out the S0ix script David
suggested? That should show us hopefully what is draining the battery in
s2idle.
