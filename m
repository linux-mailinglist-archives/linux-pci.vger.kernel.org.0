Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAAF7236A4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 07:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjFFFKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 01:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFFFKY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 01:10:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23786123
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686028222; x=1717564222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFIIlbOOgg+pAfLo8XOwG6fEMayP36lyEo5TVTewpjU=;
  b=ZQrMeiatnEdIrlB3fT27Wzp5NJ1kc+SxHUoU7CUxPAJqx9ciXU5oW5YR
   DCbBvn59pRWMw1EwGqPrIUagitsF4VFTHN16OtEO29P+RMXQdgDy1rxsj
   mjkP8urN3QP4/KZlFHDReGQmtMYWLD4WDwBk+BmKm/pfVOfJ9K5LKg5/d
   Icjz2Y5nafiSKUySMvL7OqT1lJWOLOtGvv1u0RjQIglYGWyhxbOVnpeOw
   QVr2KyaNRV86ujzDj1tvpyU4E8ROPS1JJbrk5H0mRrI8ed7MfWn1dDVYN
   ywqqn3v6qsS/jY1biSTsltoj1mz7MT/p2LEU43xJKWuKevOjE2bVVUACO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356573524"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="356573524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773989500"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="773989500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 22:10:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 11B1634F; Tue,  6 Jun 2023 08:10:24 +0300 (EEST)
Date:   Tue, 6 Jun 2023 08:10:24 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()
 wait time for slow links
Message-ID: <20230606051024.GT45886@black.fi.intel.com>
References: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
 <20230524120545.GR45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524120545.GR45886@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi again,

On Wed, May 24, 2023 at 03:05:46PM +0300, Mika Westerberg wrote:
> Hi Bjorn,
> 
> On Tue, Apr 25, 2023 at 09:47:51AM +0300, Mika Westerberg wrote:
> > With slow links (<= 5GT/s) active link reporting is not mandatory, so if
> > a device is disconnected during system sleep we might end up waiting for
> > it to respond for ~60s slowing down resume time. PCIe spec r6.0 sec
> > 6.6.1 mandates that the system software must wait for at least 1s before
> > it can determine the device as broken device so use the minimum
> > requirement for slow links and bail out if we do not get reply within
> > 1s. However, if the port supports active link reporting we can continue
> > the wait following what we do with the fast links.
> > 
> > This should make system resume time faster for slow links as well while
> > still following the PCIe spec.
> > 
> > While there move the PCI_RESET_WAIT constant into pci.c because it is
> > not used outside of that file anymore.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Any comments on this? If not can you consider taking this for v6.5?
> Thanks!

A gentle reminder :)
