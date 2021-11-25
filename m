Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA35B45DE41
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356278AbhKYQHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 11:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233175AbhKYQFH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 11:05:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C49A7610A7;
        Thu, 25 Nov 2021 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637856115;
        bh=xUV6msfjbRTfjFkSOjynVEGEj2R2qvygZ3y8/PIc1t4=;
        h=From:To:Cc:Subject:Date:From;
        b=iI3t6mQcyZQ9iTxTlaQEpTqgXbkpfzZRCHYGBJ8+M4fXXHiK5Iaj4hgMbd8xasMe5
         mCbPfEcf/840ZtYleyPQmdXhRR0QdNrtOuzTEtOVhET0AJn91EjZsBfUZ+8WQG+guK
         A/KLWTZm2M56XDntoa4+7PIlEi88VXMjTf8z8GCIEAhwu/7lPJSztHIxF3e0oro+p5
         iAKGgm2NlYNrss8VL5ScO9kaZOcCyFoTB6W8uNKcTHAZKUkRinDW7yrGpGiboax3fZ
         /zCOR3kSlobs97oWkYoQY2MkMTx8xYOSV70L//a5/MVIfCrNyyXHkLPhtIiqVWqUyp
         oq4fxzw9OEF4Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH pci-fixes 0/2] PCI Aardvark controller fixes
Date:   Thu, 25 Nov 2021 17:01:46 +0100
Message-Id: <20211125160148.26029-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo, Bjorn,

here are two fixes for pci-aardvark controller.

Marek

Marek Behún (1):
  Revert "PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated
    bridge"

Pali Rohár (1):
  PCI: aardvark: Fix checking for MEM resource type

 drivers/pci/controller/pci-aardvark.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

-- 
2.32.0

