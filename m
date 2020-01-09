Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C98135B90
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgAIOlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 09:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIOlH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 09:41:07 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7461720673;
        Thu,  9 Jan 2020 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578580866;
        bh=DlrMPvVhccNEDW9koI+U3MM8MLRCHlA/GNRJ1PYg/fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBGaU9mYNlsPavcKzkYmo8SaTZNfzP/+FyxOm3wgOBXu17YOlpUXWG+DX8Km4vn61
         nhbPjGDttsPWISCNuaksOju0v0lwRPNIzEjOpQmHmWIn2zp2h5RLc3ywrmizM5H0fE
         JZIoKiMKQKpN+2PBhZR09JXUtzQDao5gIDDtK21A=
Date:   Thu, 9 Jan 2020 14:41:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, mark.rutland@arm.com,
        robin.murphy@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        robh+dt@kernel.org, sudeep.holla@arm.com, bhelgaas@google.com,
        zhangfei.gao@linaro.org, lenb@kernel.org
Subject: Re: [PATCH v4 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20200109144100.GD12236@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20200109143618.GA942461@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109143618.GA942461@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 03:36:18PM +0100, Jean-Philippe Brucker wrote:
> On Thu, Dec 19, 2019 at 05:30:20PM +0100, Jean-Philippe Brucker wrote:
> > Add support for Substream ID and PASIDs to the SMMUv3 driver. Since v3
> > [1], I added review and tested tags where appropriate and applied the
> > suggested changes, shown in the diff below. Thanks all!
> > 
> > I'm testing using the zip accelerator on the Hisilicon KunPeng920 and
> > Zhangfei's uacce module [2]. The full SVA support, which I'll send out
> > early next year, is available on my branch sva/zip-devel at
> > https://jpbrucker.net/git/linux/
> 
> Is there anything more I should do for the PASID support? Ideally I'd like
> to get this in v5.6 so I can focus on the rest of the SVA work and on
> performance improvements.

Apologies, I'm just behind with review what with the timing of the new
year. You're on the list, but I was hoping to get Robin's TCR stuff dusted
off so that Jordan doesn't have to depend on patches languishing on the
mailing list and there's also the nvidia stuff to review as well.

Going as fast as I can!

Will
