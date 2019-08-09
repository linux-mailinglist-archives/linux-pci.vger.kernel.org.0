Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF888353
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfHITew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 15:34:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:33782 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfHITew (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Aug 2019 15:34:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 12:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="204021417"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2019 12:34:39 -0700
Date:   Fri, 9 Aug 2019 13:32:16 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] PCI: pciehp: Avoid returning prematurely from sysfs
 requests
Message-ID: <20190809193216.GD28515@localhost.localdomain>
References: <4174210466e27eb7e2243dd1d801d5f75baaffd8.1565345211.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4174210466e27eb7e2243dd1d801d5f75baaffd8.1565345211.git.lukas@wunner.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 12:28:43PM +0200, Lukas Wunner wrote:
> A sysfs request to enable or disable a PCIe hotplug slot should not
> return before it has been carried out.  That is sought to be achieved
> by waiting until the controller's "pending_events" have been cleared.
> 
> However the IRQ thread pciehp_ist() clears the "pending_events" before
> it acts on them.  If pciehp_sysfs_enable_slot() / _disable_slot() happen
> to check the "pending_events" after they have been cleared but while
> pciehp_ist() is still running, the functions may return prematurely
> with an incorrect return value.
> 
> Fix by introducing an "ist_running" flag which must be false before a
> sysfs request is allowed to return.

Can you instead just call synchronize_irq(ctrl->pcie->irq) after the
pending events is cleared?
