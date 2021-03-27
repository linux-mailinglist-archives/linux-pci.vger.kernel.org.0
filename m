Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683F134B4C4
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 07:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhC0GoX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 02:44:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15332 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhC0GoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 02:44:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6q4m0868z93nQ;
        Sat, 27 Mar 2021 14:41:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 14:43:37 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH 08/15] ACPI: acpi_pad: fix a coding style issue
Date:   Sat, 27 Mar 2021 14:40:49 +0800
Message-ID: <1616827256-51840-9-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
References: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following coding style issue reported by checkpatch.pl

WARNING: Missing a blank line after declarations

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_pad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b84ab72..df4adeb 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -128,6 +128,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
+
 	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
 	tsk_in_cpu[tsk_index] = -1;
 }
@@ -265,6 +266,7 @@ static ssize_t rrtime_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
+
 	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	if (num < 1 || num >= 100)
@@ -286,6 +288,7 @@ static ssize_t idlepct_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
+
 	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	if (num < 1 || num >= 100)
@@ -307,6 +310,7 @@ static ssize_t idlecpus_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
+
 	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	mutex_lock(&isolated_cpus_lock);
-- 
2.8.1

