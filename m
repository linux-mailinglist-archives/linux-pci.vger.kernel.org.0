Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC43E9FF6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhHLH4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 03:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhHLH4V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 03:56:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F57160560;
        Thu, 12 Aug 2021 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628754956;
        bh=0EaAW0LQ88r9WARCvYEfjdVQ4X+gcuRdOGqTvTOPYpM=;
        h=From:To:Cc:Subject:Date:From;
        b=hgO9W+RPucEMItNLpcywbI659JrMHlb9Ec0rT3D6dFk6ItiWTQQItPjrBJkmrOoXt
         lI0L1RDnBGsamowVwEBiPKO2IqBR8a0i85K3l/ncEOPymzBy10gEUkW2yKZWDYvAVk
         Sx9qcq4r2B4O9baQsDNMLfyu2URlGSUuZdh8X402Ym7Tw+Rz8cPyPnlR+bsn2f+13y
         pW50KkXQn0xyo54CCRkn2EUrKntrxJ1YYNts7/eCRDAMq9Ya1ae6W/3/DtIp4T1Fx/
         JhytzAnOmdv4yudp4yCqw5/9OhVC2yYb6sxqLy8AAvOArfYidWFK8nYvzKRX2PZHLS
         7Ir/Cu10du1Xw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5ZC-00DZ3i-9i; Thu, 12 Aug 2021 09:55:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Fix examples at pci/hisilicon,kirin-pcie.yaml 
Date:   Thu, 12 Aug 2021 09:55:50 +0200
Message-Id: <cover.1628754620.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

This small series fix the HiKey960 and HiKey970 examples for the
DT schema defined at pci/hisilicon,kirin-pcie.yaml,

The first one fix bus-range for HiKey960. It is meant to suppress a
resource conflict warning when PCI probe happens. I sent a separate
patch to be applied by HiSilicon maintainers with the DTS change.

The second one fix the topology of the PCIe bridge found at
HiKey970. It matches the DTS file that I'll submit once everything
gets merged. With such DT schema, all of_node sysfs files should
be created, pointing to the right place. It also supresses the bus-range
warnings.

Please apply on your tree, as it depends on the other patches you
already merged there.

Thanks!
Mauro

Mauro Carvalho Chehab (2):
  dt-bindings: PCI: kirin: fix bus-range
  dt-bindings: PCI: kirin: fix HiKey970 example

 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 67 ++++++++++---------
 1 file changed, 37 insertions(+), 30 deletions(-)

-- 
2.31.1


