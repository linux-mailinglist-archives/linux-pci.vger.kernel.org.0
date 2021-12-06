Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21217469554
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 12:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbhLFMAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 07:00:04 -0500
Received: from 8bytes.org ([81.169.241.247]:40126 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242778AbhLFL77 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 06:59:59 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 341393FC; Mon,  6 Dec 2021 12:56:28 +0100 (CET)
Date:   Mon, 6 Dec 2021 12:56:21 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, helgaas@kernel.org,
        alexander.shishkin@linux.intel.com, lorenzo.pieralisi@arm.com,
        will@kernel.org, mark.rutland@arm.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        john.garry@huawei.com, shameerali.kolothum.thodi@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        song.bao.hua@hisilicon.com
Subject: Re: [PATCH v2 1/6] iommu: Export iommu_{get,put}_resv_regions()
Message-ID: <Ya36ZSG1LFjhGGfO@8bytes.org>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-2-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116090625.53702-2-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 05:06:20PM +0800, Yicong Yang wrote:
> Export iommu_{get,put}_resv_regions() to the modules so that the driver
> can retrieve and use the reserved regions of the device.

Why should any driver bother? These functions are only used by the iommu
core to call into iommu drivers to get information about needed direct
mappings. Why drivers need this information belongs into this commit
message.

Regards,

	Joerg

