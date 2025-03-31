Return-Path: <linux-pci+bounces-25006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6DA7651C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 13:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5118B3AAA8B
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975871DF738;
	Mon, 31 Mar 2025 11:44:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB2136352;
	Mon, 31 Mar 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421442; cv=none; b=P/ZRkyqPKSrKwodxjKzI26hRGz6FL8iTCVUuLQF/2iHkays3VXkvxb75g1fVM2hp5l8RReXoGxuH/gSk4RKjINIVsUjX2EgaIBocBdHu7J80w1vQrJeqNxBS1ScTwmR48/qV8ltex5HIuIWgNSysTh+Ot/p+NHIuF3hZfDa170s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421442; c=relaxed/simple;
	bh=VwtcWRGkbuUGP9F5bdb3pyQWL/+vqoqNVSoYEpXLvX0=;
	h=Message-ID:Date:MIME-Version:CC:From:Subject:To:Content-Type; b=ei2D+9OLaRFvBUxMnountrCgGHPTfajvOvHDj/kJs0vnI0Zm71pvei6Urs16pjqBW4Ucf3miV5p0dbQYw1NzuYInHWHg/TX6G4SSbjfZcCooVj5ZpoxHgESbUOBzCEQ3AeGnf+rPmjcsOW+ySsUZcq1w8U80VHwQbzfmj5sbnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZR8Pg2sZVztQpp;
	Mon, 31 Mar 2025 19:42:31 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id E70B8180080;
	Mon, 31 Mar 2025 19:43:56 +0800 (CST)
Received: from [10.174.179.176] (10.174.179.176) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 31 Mar 2025 19:43:55 +0800
Message-ID: <805b2e50-00f7-40a4-975c-6bfe7d3c431b@huawei.com>
Date: Mon, 31 Mar 2025 19:43:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: "liwei (JK)" <liwei728@huawei.com>, Xiongfeng Wang
	<wangxiongfeng2@huawei.com>, <libang.li@antgroup.com>,
	<bobo.shaobowang@huawei.com>, <weiliang.qwl@antgroup.com>,
	<zhaochuanfeng@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "liwei (JK)" <liwei728@huawei.com>
Subject: [Question] pcie_do_recovery and pci_enable_sriov deadlock problem
To: <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200007.china.huawei.com (7.202.181.34)

Hi, Bjorn

I have encountered a PCI-related deadlock issue triggered by a NONFATAL
AER event during the kdump kernel boot process. However, I have not yet
devised a suitable fix for this problem and would appreciate your
guidance in resolving it. Could you please assist me with this?

The deadlock description is as follows:
When a device is added to the delay_probe_pending_list, the
pci_enable_sriov function is called in the probe interface of struct
pci_driver, if the device triggers an AER NONFATAL event and this
process occurs during the kdump boot sequence, a deadlock will arise.

       The deferred_probe_work side is:

       deferred_probe_work_func
         ...
         __device_attach
           device_lock                         # hold the device_lock
             ...
             pci_enable_sriov
               sriov_enable
                 ...
                 pci_device_add
                   down_write(&pci_bus_sem)    # wait for the pci_bus_sem

       The AER side is:

       pcie_do_recovery
         pci_walk_bus
           down_read(&pci_bus_sem)           # hold the pci_bus_sem
             report_normal_detected
               device_lock                   # wait for device_unlock()


This issue was reported by Jay Fang <f.fangjian@huawei.com> in 2019.
Reference link: 
https://lore.kernel.org/linux-pci/bdfaaa34-3d3d-ad9a-4e24-4be97e85d216@huawei.com/T/#mcb7dfafd0f76beaddfc9f56a71aee6d984ed4a7f

Thanks,
Xiangwei Li

