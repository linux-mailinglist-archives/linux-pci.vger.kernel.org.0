Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7E17B97B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 10:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCFJmO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 04:42:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgCFJmN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 04:42:13 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CDAE13C7A857DF44D953;
        Fri,  6 Mar 2020 17:42:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 17:42:08 +0800
Subject: Re: [PATCH 09/11] ACPI/IORT: Drop ATS fwspec flag
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <bhelgaas@google.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <linux-doc@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <corbet@lwn.net>, <mark.rutland@arm.com>, <liviu.dudau@arm.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <dwmw2@infradead.org>,
        <amurray@thegoodpenguin.co.uk>, <frowand.list@gmail.com>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
 <20200213165049.508908-10-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5c4855e4-381a-771e-d26d-0d0ad534e776@huawei.com>
Date:   Fri, 6 Mar 2020 17:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20200213165049.508908-10-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/2/14 0:50, Jean-Philippe Brucker wrote:
> Now that the ats_supported flag is in the host bridge structure where it
> belongs, we can remove it from the per-device fwspec structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 11 -----------
>  include/linux/iommu.h     |  4 ----
>  2 files changed, 15 deletions(-)

Acked-by: Hanjun Guo <guohanjun@huawei.com>

