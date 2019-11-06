Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F53F1CA7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 18:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfKFRmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 12:42:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:23987 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfKFRmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 12:42:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="192539712"
Received: from mton-linux-test2.lm.intel.com (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.117.44])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2019 09:42:05 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the storage stack
Date:   Wed,  6 Nov 2019 04:40:05 -0700
Message-Id: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset optimizes VMD performance through the storage stack by locating
commonly-affined NVMe interrupts on the same VMD interrupt handler lists.

The current strategy of round-robin assignment to VMD IRQ lists can be
suboptimal when vectors with different affinities are assigned to the same VMD
IRQ list. VMD is an NVMe storage domain and this set aligns the vector
allocation and affinity strategy with that of the NVMe driver. This invokes the
kernel to do the right thing when affining NVMe submission cpus to NVMe
completion vectors as serviced through the VMD interrupt handler lists.

This set greatly reduced tail latency when testing 8 threads of random 4k reads
against two drives at queue depth=128. After pinning the tasks to reduce test
variability, the tests also showed a moderate tail latency reduction. A
one-drive configuration also shows improvements due to the alignment of VMD IRQ
list affinities with NVMe affinities.

An example with two NVMe drives and a 33-vector VMD:
VMD irq[42]  Affinity[0-27,56-83]   Effective[10]
VMD irq[43]  Affinity[28-29,84-85]  Effective[85]
VMD irq[44]  Affinity[30-31,86-87]  Effective[87]
VMD irq[45]  Affinity[32-33,88-89]  Effective[89]
VMD irq[46]  Affinity[34-35,90-91]  Effective[91]
VMD irq[47]  Affinity[36-37,92-93]  Effective[93]
VMD irq[48]  Affinity[38-39,94-95]  Effective[95]
VMD irq[49]  Affinity[40-41,96-97]  Effective[97]
VMD irq[50]  Affinity[42-43,98-99]  Effective[99]
VMD irq[51]  Affinity[44-45,100]    Effective[100]
VMD irq[52]  Affinity[46-47,102]    Effective[102]
VMD irq[53]  Affinity[48-49,104]    Effective[104]
VMD irq[54]  Affinity[50-51,106]    Effective[106]
VMD irq[55]  Affinity[52-53,108]    Effective[108]
VMD irq[56]  Affinity[54-55,110]    Effective[110]
VMD irq[57]  Affinity[101,103,105]  Effective[105]
VMD irq[58]  Affinity[107,109,111]  Effective[111]
VMD irq[59]  Affinity[0-1,56-57]    Effective[57]
VMD irq[60]  Affinity[2-3,58-59]    Effective[59]
VMD irq[61]  Affinity[4-5,60-61]    Effective[61]
VMD irq[62]  Affinity[6-7,62-63]    Effective[63]
VMD irq[63]  Affinity[8-9,64-65]    Effective[65]
VMD irq[64]  Affinity[10-11,66-67]  Effective[67]
VMD irq[65]  Affinity[12-13,68-69]  Effective[69]
VMD irq[66]  Affinity[14-15,70-71]  Effective[71]
VMD irq[67]  Affinity[16-17,72]     Effective[72]
VMD irq[68]  Affinity[18-19,74]     Effective[74]
VMD irq[69]  Affinity[20-21,76]     Effective[76]
VMD irq[70]  Affinity[22-23,78]     Effective[78]
VMD irq[71]  Affinity[24-25,80]     Effective[80]
VMD irq[72]  Affinity[26-27,82]     Effective[82]
VMD irq[73]  Affinity[73,75,77]     Effective[77]
VMD irq[74]  Affinity[79,81,83]     Effective[83]

nvme0n1q1   MQ CPUs[28, 29, 84, 85]
nvme0n1q2   MQ CPUs[30, 31, 86, 87]
nvme0n1q3   MQ CPUs[32, 33, 88, 89]
nvme0n1q4   MQ CPUs[34, 35, 90, 91]
nvme0n1q5   MQ CPUs[36, 37, 92, 93]
nvme0n1q6   MQ CPUs[38, 39, 94, 95]
nvme0n1q7   MQ CPUs[40, 41, 96, 97]
nvme0n1q8   MQ CPUs[42, 43, 98, 99]
nvme0n1q9   MQ CPUs[44, 45, 100]
nvme0n1q10  MQ CPUs[46, 47, 102]
nvme0n1q11  MQ CPUs[48, 49, 104]
nvme0n1q12  MQ CPUs[50, 51, 106]
nvme0n1q13  MQ CPUs[52, 53, 108]
nvme0n1q14  MQ CPUs[54, 55, 110]
nvme0n1q15  MQ CPUs[101, 103, 105]
nvme0n1q16  MQ CPUs[107, 109, 111]
nvme0n1q17  MQ CPUs[0, 1, 56, 57]
nvme0n1q18  MQ CPUs[2, 3, 58, 59]
nvme0n1q19  MQ CPUs[4, 5, 60, 61]
nvme0n1q20  MQ CPUs[6, 7, 62, 63]
nvme0n1q21  MQ CPUs[8, 9, 64, 65]
nvme0n1q22  MQ CPUs[10, 11, 66, 67]
nvme0n1q23  MQ CPUs[12, 13, 68, 69]
nvme0n1q24  MQ CPUs[14, 15, 70, 71]
nvme0n1q25  MQ CPUs[16, 17, 72]
nvme0n1q26  MQ CPUs[18, 19, 74]
nvme0n1q27  MQ CPUs[20, 21, 76]
nvme0n1q28  MQ CPUs[22, 23, 78]
nvme0n1q29  MQ CPUs[24, 25, 80]
nvme0n1q30  MQ CPUs[26, 27, 82]
nvme0n1q31  MQ CPUs[73, 75, 77]
nvme0n1q32  MQ CPUs[79, 81, 83]

nvme1n1q1   MQ CPUs[28, 29, 84, 85]
nvme1n1q2   MQ CPUs[30, 31, 86, 87]
nvme1n1q3   MQ CPUs[32, 33, 88, 89]
nvme1n1q4   MQ CPUs[34, 35, 90, 91]
nvme1n1q5   MQ CPUs[36, 37, 92, 93]
nvme1n1q6   MQ CPUs[38, 39, 94, 95]
nvme1n1q7   MQ CPUs[40, 41, 96, 97]
nvme1n1q8   MQ CPUs[42, 43, 98, 99]
nvme1n1q9   MQ CPUs[44, 45, 100]
nvme1n1q10  MQ CPUs[46, 47, 102]
nvme1n1q11  MQ CPUs[48, 49, 104]
nvme1n1q12  MQ CPUs[50, 51, 106]
nvme1n1q13  MQ CPUs[52, 53, 108]
nvme1n1q14  MQ CPUs[54, 55, 110]
nvme1n1q15  MQ CPUs[101, 103, 105]
nvme1n1q16  MQ CPUs[107, 109, 111]
nvme1n1q17  MQ CPUs[0, 1, 56, 57]
nvme1n1q18  MQ CPUs[2, 3, 58, 59]
nvme1n1q19  MQ CPUs[4, 5, 60, 61]
nvme1n1q20  MQ CPUs[6, 7, 62, 63]
nvme1n1q21  MQ CPUs[8, 9, 64, 65]
nvme1n1q22  MQ CPUs[10, 11, 66, 67]
nvme1n1q23  MQ CPUs[12, 13, 68, 69]
nvme1n1q24  MQ CPUs[14, 15, 70, 71]
nvme1n1q25  MQ CPUs[16, 17, 72]
nvme1n1q26  MQ CPUs[18, 19, 74]
nvme1n1q27  MQ CPUs[20, 21, 76]
nvme1n1q28  MQ CPUs[22, 23, 78]
nvme1n1q29  MQ CPUs[24, 25, 80]
nvme1n1q30  MQ CPUs[26, 27, 82]
nvme1n1q31  MQ CPUs[73, 75, 77]
nvme1n1q32  MQ CPUs[79, 81, 83]


This patchset applies after the VMD IRQ List indirection patch:
https://lore.kernel.org/linux-pci/1572527333-6212-1-git-send-email-jonathan.derrick@intel.com/

Jon Derrick (3):
  PCI: vmd: Reduce VMD vectors using NVMe calculation
  PCI: vmd: Align IRQ lists with child device vectors
  PCI: vmd: Use managed irq affinities

 drivers/pci/controller/vmd.c | 90 +++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 51 deletions(-)

-- 
1.8.3.1

