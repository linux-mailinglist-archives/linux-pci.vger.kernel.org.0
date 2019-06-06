Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E756D36FBC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFFJWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 05:22:54 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9725 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJWy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 05:22:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8db6d0000>; Thu, 06 Jun 2019 02:22:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 02:22:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 02:22:53 -0700
Received: from localhost.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 09:22:51 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>, Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH v2 0/2] PCI: device link quirk for NVIDIA GPU
Date:   Thu, 6 Jun 2019 14:52:23 +0530
Message-ID: <20190606092225.17960-1-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559812973; bh=tbKkyt/K+Dnc3K8ZzvLUciqyYeSlK6VCzexvmG6DFYI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=FDFex7CLIRxqr57Z/OXaVJqWJjyJ56OrvQ/EqAw6golwcjsu47mZWVwx86CVBWZOA
         hLnYwQgSRN4IWC0GHkiuYZrJXioH0OmQLQddzXDaXB9kmCX32NYzh3hET33bzOX6Kj
         BUEFTTpFfYK3avCaEAcVy2edJrItBzjSZVIWDrAuptu/kz2cKBWu01difNn1qFWRw5
         geHIKZedkSS+ieV1nQWvQBLNBUtkTW5g+BPl4gqCoHagf1Z3fDdkvQEtubepEOBTIE
         ZqUq7MTR8YiYoJEOLYWqCztXmREMhg45+URLvDutFi98zLshe6Ap0uOBN4Xb9IEbro
         FVzQTzDbReJjA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* v2:

1. Make the pci device link helper function generic which can be
   used for other multi-function PCI devices also.
2. Minor changes in comments and commit logs.

* v1:

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
  PCI: Code reorganization for creating device link
  PCI: Create device link for NVIDIA GPU

 drivers/pci/quirks.c | 79 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 20 deletions(-)

-- 
2.17.1

