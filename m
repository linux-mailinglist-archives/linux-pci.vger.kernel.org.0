Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46414206E
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2020 23:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgASWZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jan 2020 17:25:26 -0500
Received: from verein.lst.de ([213.95.11.211]:42044 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgASWZ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Jan 2020 17:25:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89B1368B20; Sun, 19 Jan 2020 23:25:23 +0100 (CET)
Date:   Sun, 19 Jan 2020 23:25:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 0/7] Clean up VMD DMA Map Ops
Message-ID: <20200119222523.GA4890@lst.de>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series looks good to me (modulo the one minor nitpick which isn't
all that important):

Reviewed-by: Christoph Hellwig <hch@lst.de>
