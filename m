Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E3135B73
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgAIOeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 09:34:01 -0500
Received: from verein.lst.de ([213.95.11.211]:54979 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbgAIOeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 09:34:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 13FDD68C4E; Thu,  9 Jan 2020 15:33:57 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:33:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 3/5] x86/PCI: Expose VMD's device in pci_sysdata
Message-ID: <20200109143356.GB22656@lst.de>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com> <1577823863-3303-4-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577823863-3303-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 01:24:21PM -0700, Jon Derrick wrote:
> To be used by intel-iommu code to find the correct domain.

Any reason to prefer this version over my patches 2 and 3 from the
series in August?
