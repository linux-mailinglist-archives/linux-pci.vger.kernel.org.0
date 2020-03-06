Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46917B954
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 10:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCFJd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 04:33:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbgCFJd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 04:33:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD4911C0AA932FE648A1;
        Fri,  6 Mar 2020 17:33:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 17:33:12 +0800
Subject: Re: [PATCH 00/10] PCI/ATS: Device-tree support and other improvements
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
        <amurray@thegoodpenguin.co.uk>, <frowand.list@gmail.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b898317c-c534-aad8-5b0d-45723e0b8e89@huawei.com>
Date:   Fri, 6 Mar 2020 17:32:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
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
> Enable ATS on device-tree based systems, and factor the common ATS
> enablement checks into pci_enable_ats().
> 
> ATS support in PCIe endpoints is discovered through the ATS capability,
> but there is no common method for discovering whether the host bridge
> supports ATS. Each vendor provides their own ACPI method:
> * DMAR (Intel) reports ATS support per domain or per root port.
> * IVRS (AMD) reports negative ATS support for a range of devices.
> * IORT (ARM) reports ATS support for a root complex.

Tested this patch set against 5.6-rc2 on a Kunpeng920 ARM server,
I just confirmed that this patch set didn't break anything in
my box with ACPI booting, PCI devices work as expected, FWIW,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

