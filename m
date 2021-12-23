Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3547E922
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 22:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbhLWVh5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 16:37:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54252 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhLWVh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 16:37:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD059CE2208;
        Thu, 23 Dec 2021 21:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1112C36AE5;
        Thu, 23 Dec 2021 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640295474;
        bh=PDCCeDS+WiwJeugTg1oJTd9lOUQUWukHtBR7ZbZWTus=;
        h=From:To:Cc:Subject:Date:From;
        b=I9/8e01DZ3DVu0kywDsK95Fvv2J7/TZvsBEZsCdo1yOWwVAdpfieGaz/PK1aSDQ1Q
         Z0E5gxLLr3yw11iJIJihrcPHLXra+xAmwhic/L+/fYqv2dCStJnrmSs7vPwbIpsWEC
         EnernGMKvwJGxoz3BozTcqMUfowDe0KCxbr+eQHX3ryUCNmaQ4bH3j0isD2iScgn0y
         iSxp8zVSiIYvHTt/U+p87SLrp3hF+HMDlJf8qXl1mCvO6MyNDXVhqkFCTwfCX3g5Fp
         MJSEzmMGDmi4A/oLhxkr8MiByP4Evhrum0f57IuTZu4uZ5ilCkKI7PdPAQQ/BKeWXi
         cFh7mh0M+wgvQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Clean up address space warnings
Date:   Thu, 23 Dec 2021 15:37:47 -0600
Message-Id: <20211223213749.1314142-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix some sparse warnings, found by "make C=2 drivers/pci/controller/".

Bjorn Helgaas (2):
  PCI: hisi: Avoid invalid address space conversions
  PCI: spear13xx: Avoid invalid address space conversions

 drivers/pci/controller/dwc/pcie-hisi.c      | 32 ++++++++++++++-------
 drivers/pci/controller/dwc/pcie-spear13xx.c |  8 +++---
 2 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.25.1

