Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91515423AD5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhJFJu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 05:50:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:43404 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237637AbhJFJu2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 05:50:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="312163041"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="312163041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 02:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="623805862"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 06 Oct 2021 02:48:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 06 Oct 2021 12:48:27 +0300
Date:   Wed, 6 Oct 2021 12:48:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Convert to
 device_create_managed_software_node()
Message-ID: <YV1w6wPH96qk3a2e@kuha.fi.intel.com>
References: <20210930121246.22833-2-heikki.krogerus@linux.intel.com>
 <20210930150402.GA877907@bhelgaas>
 <YVbku7IQatCydZ+V@kuha.fi.intel.com>
 <CAJZ5v0g7YBVAhJEWo25GdCic6nAUrwhne9rT1LfUznMKn2NGnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g7YBVAhJEWo25GdCic6nAUrwhne9rT1LfUznMKn2NGnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 04:04:48PM +0200, Rafael J. Wysocki wrote:
> So I'm expecting a v3 of this.

Yes, sorry for the delay. v3 coming up.

thanks,

-- 
heikki
