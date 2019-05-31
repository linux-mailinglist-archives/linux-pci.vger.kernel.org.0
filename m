Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807D2307F0
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfEaFAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 01:00:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6977 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 01:00:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf0b5000000>; Thu, 30 May 2019 22:00:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 May 2019 22:00:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 May 2019 22:00:48 -0700
Received: from localhost.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 May
 2019 05:00:46 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH 0/2] PCI: device link quirk for NVIDIA GPU
Date:   Fri, 31 May 2019 10:31:07 +0530
Message-ID: <20190531050109.16211-1-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559278848; bh=VR1uNXNShNuXcrY0D23sSyId6STjJONID9boODBb+kA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=YQKgwxuMoFlrinXI1/j5LjQncfYlI3METbZ575/2TdSksrAIhepjOOAdNUbYkW5va
         x2ZOBV6so1Cku4in1zM7KBzqQD+O0OgJpVqUkNTSEdnWg5CW119ejydyBWHrHiVrQm
         wFhJYb43TlbxOyEAUvS+AJTsof4IobGT8qwev4EFoyiGZJIjxnSKs2kDsPeHRY1gPq
         2NWQZblwSY5RkEvRynnVBUCUFvnpUFe1k/FEPO1XRuCUnoafqE3MwjY8cOeWzklmVt
         ZiDkH2xmP9NRpiEiC5UAyBKVGnq6sHYEQ5Q3SjM/PXV7s5KrJSqtcuXxmPLTTp0h08
         EEYjbRpCv6eOw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NVIDIA Turing GPU [1] has hardware support for USB Type-C and
VirtualLink [2]. The Turing GPU is a multi-function PCI device
which has the following four functions:

	- VGA display controller (Function 0)
	- Audio controller (Function 1)
	- USB xHCI Host controller (Function 2)
	- USB Type-C USCI controller (Function 3)

Currently NVIDIA and Nouveau GPU drivers only manage function 0.
Rest of the functions are managed by other drivers. These functions
internally in the hardware are tightly coupled. When function 0 goes
in runtime suspended state, then it will do power gating for most of
the hardware blocks. Some of these hardware blocks are used by
the other PCI functions, which leads to functional failure. In the
mainline kernel, the device link is present between
function 0 and function 1.  This patch series deals with creating
a similar kind of device link between function 0 and
functions 2 and 3.

[1] https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf
[2] https://en.wikipedia.org/wiki/VirtualLink

Abhishek Sahu (2):
  PCI: Code reorganization for VGA device link
  PCI: Create device link for NVIDIA GPU

 drivers/pci/quirks.c | 67 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 15 deletions(-)

-- 
2.17.1

