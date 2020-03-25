Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD8193068
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCYSbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 14:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCYSbc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 14:31:32 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C139206F6;
        Wed, 25 Mar 2020 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585161091;
        bh=bUVzSI9dzv00tGiSCBQcCwFyz4bKHFbg5OdnpsNxay4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h0cTdrgxgbuEC6eoNOaOOybXnUDCfcYCPmFkWZMT5fV+WWIsosBg2gcMRsqPu196e
         eAq/f8XS+n/3PCkoxNPz3nTxiYdLNZXmrUOdEE9ldsb0mawD2TybHiD4mES7vhrdbF
         P0Hw2X8id1hiGHCFyR5jyxW/RxrP8s3NBHQWfHpM=
Date:   Wed, 25 Mar 2020 13:31:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
Subject: Re: [PATCH v5 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200325183129.GA29158@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a30116698a49cda1e8b580ee35ce1f@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 25, 2020 at 04:27:15PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Bjorn Helgaas [mailto:helgaas@kernel.org]

> >3) drivers/pci/controller/pcie-hisi-error.c should be next to
> >drivers/pci/controller/dwc/pcie-hisi.c, shouldn't it?
>
> Our hip PCIe controller doesn't use DWC ip.

Ah, I was assuming this pcie-hisi-error.c driver was for the same
device claimed by pcie-hisi.c.

Error drivers like this will have some device-specific knowledge
(e.g., which registers to dump), but I guess they'll always be
used with the generic acpi/pci_root.c driver, right?

It looks like this driver has little or nothing to do with the PCI
core directly.  It does include drivers/pci/pci.h, but I'm not sure it
really needs it.

Maybe drivers/pci/controller/ is the best place for it, but I'm not
sure.  It's a little confusing because it's not really like the other
things there.

There are some vaguely similar things in drivers/acpi/apei/ and
drivers/acpi/nfit/.  And of course there are .acpi_match_table uses
all over the drivers/ tree.  Maybe we need a new subdirectory under
drivers/pci?  drivers/pci/controller/apei/?

Any thoughts, Rafael?

Bjorn
