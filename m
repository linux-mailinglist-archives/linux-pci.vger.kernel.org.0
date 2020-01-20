Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A60142896
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 11:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATKzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 05:55:21 -0500
Received: from foss.arm.com ([217.140.110.172]:58382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgATKzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jan 2020 05:55:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3B430E;
        Mon, 20 Jan 2020 02:55:20 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7A73F68E;
        Mon, 20 Jan 2020 02:55:18 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:54:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: brcmstb: Fix missing mutex_init()
Message-ID: <20200120105447.GA17089@e121166-lin.cambridge.arm.com>
References: <20200119023003.100987-1-weiyongjun1@huawei.com>
 <f49226ca-6256-3709-3f7a-8996f5e68d76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49226ca-6256-3709-3f7a-8996f5e68d76@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 19, 2020 at 09:50:09AM -0800, Florian Fainelli wrote:
> 
> 
> On 1/18/2020 6:30 PM, Wei Yongjun wrote:
> > The driver allocates the mutex but not initialize it.
> > Use mutex_init() on it to initialize it correctly.
> > 
> > This is detected by Coccinelle semantic patch.
> > 
> > Fixes: 72af6f6f0d13 ("PCI: brcmstb: Add MSI support")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

I have squashed it in in my pci/brcmstb branch, thanks.

Lorenzo
