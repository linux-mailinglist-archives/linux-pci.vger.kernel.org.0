Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887023E8B46
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 09:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhHKHzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 03:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235737AbhHKHzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 03:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7365860F38;
        Wed, 11 Aug 2021 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628668498;
        bh=iggevxB/ZPSUP17/Z4dnE41CO3GAmi2defdB2xVpa8w=;
        h=From:To:Cc:Subject:Date:From;
        b=i/emjvXiNHjWAA6UnB+Wd7qu2bjfEW9Hfm3HNoiYcSR+QU5I2YDQ19KiITe1fYOSM
         yPR1mHvovipMJwAuqCiD8S4LEL9RedjjbZjqG8fF6WM/EvyJQ9+UzJ643a3G49kGAq
         nzbCXJikUkc+CA+wbf71+d2L0Tco/uT2CMPZ/pqvti5mH2OT9CL9fRn7qt7fqT1xeZ
         tmGWUO6UUSGGl/7y+b2ntQ/tb5u2CH1zMLlfUEdrZvcRr4u9J8FMvw/1IVaJEnSMuj
         bvTJr8znzI9VNfXtFbMgyB5/xHAHM/QVr7LP2asPRMi7J4MNMEMTgnSrY5aXpOkP54
         JbqE3AONrZf6g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDj4i-00BuOf-8U; Wed, 11 Aug 2021 09:54:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Adjust HiKey examples for kirin-pcie
Date:   Wed, 11 Aug 2021 09:54:51 +0200
Message-Id: <cover.1628668306.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,

As discussed on another thread, there are two issues at
pci/hisilicon,kirin-pcie.yaml:

- The bus-range parameters are causing warnings;
- The Kirin970 example doesn't reflect the right device
  hierarchy, causing some of_node files under sysfs to
  not be initialized.

This small series fix both.

Mauro Carvalho Chehab (2):
  dt-bindings: PCI: kirin: fix bus-range
  dt-bindings: PCI: kirin: fix HiKey970 example

 .../bindings   | 67 ++++++++++---------
 1 file changed, 37 insertions(+), 30 deletions(-)

-- 
2.31.1


