Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD33EDE44
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 21:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhHPTyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 15:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhHPTyB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 15:54:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5FF560FC3;
        Mon, 16 Aug 2021 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629143609;
        bh=gcmrLJU4TvC/wzPpwVlFSMDTFAMNFOLCiOd3dT/Q/08=;
        h=From:To:Cc:Subject:Date:From;
        b=p5towRMVIXwXFXH5iLJYmr98bZb/IFPWuBZgNCOz3APke610XxnJtsCbmZtb3zBAZ
         3eEPdev4eUQVHLHYorMBKJgYiItsLz815GoQ6Vxm/B99m4VpzOKV5i64wchwOrCIKk
         L/yJtErg20u8gPsFyjPk0CRicUgh2NYdCOLzuyUyjZIT3OEr84oC5NhrjKf8JK0lmf
         TMkwKq71alVeMpNMulcxqt4UrB/idkewT7L+goDipDkPfTGCnEGdPry9/Yf43xrqj4
         ixER3Qc76lvRs8SUx+gwDaewJM+cIllukw/irj55ToffAjiLKMklBQSMlXaVSblIf/
         iC3c/w5Apns+w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mFifn-003CSu-LG; Mon, 16 Aug 2021 21:53:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] Adjust HiKey examples for kirin-pcie
Date:   Mon, 16 Aug 2021 21:53:24 +0200
Message-Id: <cover.1629143524.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,

As discussed on another thread, there are three issues at
pci/hisilicon,kirin-pcie.yaml:

- The bus-range parameters are causing warnings;
- The Kirin970 example doesn't reflect the right device
  hierarchy, causing some of_node files under sysfs to
  not be initialized;
- There is a wrong msi-parent node causing it to not work
  properly and to produce  several warnings.

This small series fix such issues.

Mauro Carvalho Chehab (2):
  dt-bindings: PCI: kirin: fix bus-range
  dt-bindings: PCI: kirin: fix HiKey970 example

 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

-- 
2.31.1


