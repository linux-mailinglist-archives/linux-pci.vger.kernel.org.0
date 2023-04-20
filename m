Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A676E910C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjDTKxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjDTKxP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 06:53:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1930165B7;
        Thu, 20 Apr 2023 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681987847; x=1713523847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wi6do+kdeWyssmSZcEobm0D15cuhIlPLQEG7kFMD844=;
  b=RS/RT6CuSob+UFMQxWXaNFnlbmEMMFwvEKxy6+pF3cDJXUQylKheY9jn
   cmaByM8Xld3IR9MJ1XtiXIdgfHKlmH9EyfbnBlbg+ZDldMb14p8mLlYgo
   Mov5B5izrlRDyUaaI9OA1CbeUgmbtxaP3SdMTe/raEykkpBDp9CSpTpKa
   0aZC40/BTbD9sdj+DpCsmK7Xn8OkeuiBmWx75kZwXy6LvVJlJu7cb5Ij1
   BiGoGYtwzEIHbXSkDWuE90JPl4YGdI/FVWmdP+3XhT5SYj/Ry+ncJaJ1D
   mQzWpVgMexlHodfi03AAernZ9CxJfeNykgRtQ8BPPqo4/N/1GnghYEbzG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373596261"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="373596261"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 03:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803299458"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803299458"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 03:49:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D668B21E7; Thu, 20 Apr 2023 13:49:47 +0300 (EEST)
Date:   Thu, 20 Apr 2023 13:49:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: Keep AER status in pci_restore_state()
Message-ID: <20230420104947.GM66750@black.fi.intel.com>
References: <20230420015830.309845-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420015830.309845-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 09:58:27AM +0800, Kai-Heng Feng wrote:
> When AER is using the same IRQ as PME, AER interrupt is treated as a
> wakeup event and it can disrupt system suspend process.
> 
> If that happens, the system will report it's woken up by PME IRQ without
> indicating any AER error since AER status is cleared on resume.
> 
> So keep the AER status so users can know the system is woken up by AER
> instead of PME.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
