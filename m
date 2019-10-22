Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E2E045C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfJVM7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 08:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389143AbfJVM7x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 08:59:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0732075A;
        Tue, 22 Oct 2019 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571749192;
        bh=4CPRU2ALG6GtK6+pZ+F3xABl2sxm6yLoW6A4ltcqWtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qd0nYUPsgaG9IQbK11fQUzwXq8mTBGzbDXUTHySjkMY6Isg3AWTNC57qoNvhrhJE3
         QU5mwzF0qEtRY4mBoO2BgXUMNBl7kBZ+DpM0UhKcORxb/NSXxxULcBPdRqfsiFGVLY
         9YV20AE4vybz5xwzQNJeySSj3JmCvGA+VTmjSLng=
Date:   Tue, 22 Oct 2019 07:59:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191022125950.GA133170@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <187a1a7d-80bd-a0e9-a0d9-7fc53bff8907@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm, beginning of discussion at
https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]

On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > of changing link width and speed on the fly.
> > Please add more details about why this is needed.  Since you're adding
> > sysfs files, it sounds like it's not actually the *driver* that needs
> > this; it's something in userspace?

> We have use cases to change the link speed and width on the fly.
> One is EMI check and other is power saving.  Some battery backed
> applications have to switch PCIe link from higher GEN to GEN1 and
> width to x1. During the cases like external power supply got
> disconnected or broken. Once external power supply is connected then
> switch PCIe link to higher GEN and width.

That sounds plausible, but of course nothing there is specific to the
Intel Gateway, so we should implement this generically so it would
work on all hardware.

I'm not sure what the interface should look like -- should it be a
low-level interface as you propose where userspace would have to
identify each link of interest, or is there some system-wide
power/performance knob that could tune all links?  Cc'd Rafael and
linux-pm in case they have ideas.

Bjorn
