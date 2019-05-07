Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340BF1655E
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEGOHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 10:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfEGOHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 10:07:04 -0400
Received: from localhost (173-24-246-231.client.mchsi.com [173.24.246.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1C620825;
        Tue,  7 May 2019 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557238023;
        bh=e8QA8DQbWSmdbFp8W4Fu5R/Ds6lwqAAylvtUcfAGSMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxC1juGRQVxnLxMAT2+XTGQn0nmGGHBhNTu+Y8AVFZtL06Is4EQE8OcJYc14F1obY
         xoRVufDdbJpop5mfbPLLcWsUEM0Sjw88kwfvEvOxIV5ap3p1F2ex6mwEuQRCOcVUtp
         DT55mkV5P7RxjZomeke0a2V7oNe3+WbcyM6qRtoo=
Date:   Tue, 7 May 2019 09:07:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-pci@vger.kernel.org, "Chocron, Jonathan" <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Message-ID: <20190507140702.GD156478@google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <0c7ed46e4a8cf4cea544a7e62c32428b31cdea4e.camel@infradead.org>
 <20190507124948.GC156478@google.com>
 <e156b09d5e83e127f9d9c5ab588a46218092d19f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e156b09d5e83e127f9d9c5ab588a46218092d19f.camel@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 02:02:34PM +0100, David Woodhouse wrote:
> On Tue, 2019-05-07 at 07:49 -0500, Bjorn Helgaas wrote:
> > No good reason; I just screwed up.  Should be fixed in v5.2 (and marked for
> > stable):
> > 
> > https://lore.kernel.org/linux-pci/20190318160718.10925-1-jean-philippe.brucker@arm.com
> 
> Aha, thanks. And I see 'dwc: Use devm_pci_alloc_host_bridge()' in there
> too, which was the reason we were staring at it in the first place.
> 
> That's actually fixing a leak in the error path, not just simplifying
> it, and might want tagging for stable too if it's realistic that
> devm_of_pci_get_host_bridge_resources() would ever actually fail.

OK, IIUC, you're proposing this, where I added the stable tag to "dwc:
Use devm_pci_alloc_host_bridge()":

  http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=e6fdd3bf5aec

Lorenzo, just FYI, I cherry-picked remotes/lorenzo/pci/dwc to a pci/dwc
branch to add that tag.

Bjorn
