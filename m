Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874241428B4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 12:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATLCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 06:02:24 -0500
Received: from foss.arm.com ([217.140.110.172]:58478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgATLCY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jan 2020 06:02:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA5630E;
        Mon, 20 Jan 2020 03:02:23 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B50A3F68E;
        Mon, 20 Jan 2020 03:02:22 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:02:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        iommu@lists.linux-foundation.org, Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 0/7] Clean up VMD DMA Map Ops
Message-ID: <20200120110220.GB17267@e121166-lin.cambridge.arm.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
 <20200119222523.GA4890@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119222523.GA4890@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 19, 2020 at 11:25:23PM +0100, Christoph Hellwig wrote:
> This series looks good to me (modulo the one minor nitpick which isn't
> all that important):
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hi Bjorn,

are you picking this up ? I can merge it too but since it is mostly
x86 changes I reckon you should take it, I acked patch (6) to that
end.

Thanks,
Lorenzo
