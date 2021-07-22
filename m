Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8B3D25EF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGVOAL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 10:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGVOAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 10:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D04A46100C;
        Thu, 22 Jul 2021 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626964846;
        bh=pPFqJyHkX6T9ZxDCYGAld/IolwKzlGVpjkC1PegMP2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXz/RLsHHi20pdKUuBVhs2p++3t9fLqcbAUfpsoRJ/lF9ZfIoywlJDukgg1WCxNGd
         RUBt4dtJ/2Kr5IlFMA9APXq4UbPBx4QoRCoyD3iAlNVUjZ/1SDtY6mSNsTrXrqCcsH
         mWjwd2XhbdIpgi1owQKXxd/9w/GbpLkn8pgaexqoJNVZh9xz/sAFVjqxUclGo0vlPV
         ZNkCXCY+2YswcQeWIdOzp6eEJWDYeykavqd6JbStQ103Boqjli0zFjdNRVodgfZGP2
         wC5xSqcWFuR2P1eLFgtKPUpER/AGuY576B6RL12ECbR7XjgFZH6qD7G8SsH9FM/ZUQ
         u03FSoYNWb3vA==
Received: by pali.im (Postfix)
        id 6CC95805; Thu, 22 Jul 2021 16:40:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: aardvark: PIO fixes
Date:   Thu, 22 Jul 2021 16:40:37 +0200
Message-Id: <20210722144041.12661-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624213345.3617-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fix PIO functions used for accessing PCI config space.

In v2 is fixed processing of CRS response which depends on emulation of
CRSVIS and CRSSVE bits in config space of emulated PCIe bridge.

Patch "PCI: aardvark: Fix checking for PIO Non-posted Request" was
dropped from v2 as it was already applied.

Evan Wang (1):
  PCI: aardvark: Fix checking for PIO status

Pali Rohár (3):
  PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO
    response
  PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
  PCI: aardvark: Fix reporting CRS value

 drivers/pci/controller/pci-aardvark.c | 125 +++++++++++++++++++++++---
 drivers/pci/pci-bridge-emul.h         |   2 +-
 2 files changed, 116 insertions(+), 11 deletions(-)

-- 
2.20.1

