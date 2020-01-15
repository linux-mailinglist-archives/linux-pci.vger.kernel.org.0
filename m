Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E966E13BE13
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgAOLCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 06:02:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbgAOLCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 06:02:11 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4EDF2861C121A2EABE1;
        Wed, 15 Jan 2020 19:02:08 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 19:02:00 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <bp@alien8.de>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <gregkh@linuxfoundation.org>,
        <zhangliguang@linux.alibaba.com>, <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/2] ACPI: APEI: Add support to notify the vendor specific HW errors
Date:   Wed, 15 Jan 2020 11:01:38 +0000
Message-ID: <20200115110141.12300-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently the vendor drivers are unable to do the recovery for the vendor
specific HW errors, reported to the APEI driver in the vendor defined sections,
because APEI driver does not support reporting the same to the vendor drivers.

This patch set
1. add an interface to the APEI driver to enable the vendor
drivers to register the event handling functions for the corresponding
vendor specific HW errors.

2. add driver to handle HiSilicon hip08 PCIe controller's errors
   which is an application of the above interface.

Changes from the previous version
1. Fix comments from James Morse.

2. add driver to handle HiSilicon hip08 PCIe controller's errors,
   which is an example of the above interface.

Shiju Jose (1):
  ACPI: APEI: Add support to notify the vendor specific HW errors

Yicong Yang (1):
  PCI:hip08:Add driver to handle HiSilicon hip08 PCIe controller's
    errors

 drivers/acpi/apei/ghes.c                       | 110 ++++++++-
 drivers/pci/controller/Kconfig                 |   8 +
 drivers/pci/controller/Makefile                |   1 +
 drivers/pci/controller/pcie-hisi-hip08-error.c | 323 +++++++++++++++++++++++++
 include/acpi/ghes.h                            |  49 ++++
 5 files changed, 486 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-hip08-error.c

-- 
1.9.1


