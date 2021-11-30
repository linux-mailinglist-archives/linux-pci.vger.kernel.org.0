Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9537346326B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 12:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhK3LfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 06:35:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16323 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhK3LfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 06:35:12 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J3KmR72RPz91QC;
        Tue, 30 Nov 2021 19:31:19 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 19:31:51 +0800
CC:     <yangyicong@hisilicon.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Subject: [Issue] PCIe AER/Hotplug is disabled when pcie_aspm=off
To:     <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Message-ID: <4d5943c3-1951-767a-5b03-46f527e6ab3a@hisilicon.com>
Date:   Tue, 30 Nov 2021 19:31:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn and Rafael,

Our test found that if set pcie_aspm=off in cmdline, the AER and hotplug is also disabled without
negotiating with firmware through _OSC. Driver regards ASPM as a requirement of PCIe support and
if it's disabled, we'll not enable other advanced services like AER and hotplug at all.

Any reason for binding ASPM with other PCIe services? There is an attempt to split ASPM with other
services [1] but the patch is not accepted. The original patch [2] makes ASPM a necessity related
a bugzilla report but I didn't figure out the detailed reason for doing so.

Can we add some detailed reasons in the code why regards ASPM a necessity?
or shall we split ASPM and other services as they are independent?

[1] https://lore.kernel.org/linux-pci/20190702201318.GC128603@google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=415e12b23792

Thanks,
Yicong
