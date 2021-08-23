Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9A3F4E95
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWQlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 12:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhHWQlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 12:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 854B4610F8;
        Mon, 23 Aug 2021 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629736862;
        bh=pB3YK4tQ7OqfOUkSCXMw8MOIgFjohKgFtfck5avD/FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyUGZcW0G46pB3wWEOCMjt5XdkA4s1IDsGsff2ffjAnwCbl7+FRj8j+VjAfKxbGhr
         CLcm+Uvs1WjvXeK9Zavkirab5R+yJg85utDjpoRFx+jJ8qC4AvarsfFoYSmygL8vjn
         XCvUeRe5yCpGGcsMSy+S4XEC4BKvfFudgzzM/DKiTrIg0/DKqcP1iyessxgtTLesdW
         lp/on6oiibLM+WXsIGkY70DIr/6O9rdvcw52+mTDuJEuQVqlzmUc+2cDi46ixesl+q
         K/n0zziE5RqIGe/HKCIadaw2qj9osDixzu3bFHiPMnxf2+StYQQXkeTOM8S2e1R3p8
         jjYYE5Tt67I1Q==
Received: by pali.im (Postfix)
        id 056F0FC2; Mon, 23 Aug 2021 18:40:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PCI: aardvark: MSI interrupt fixes
Date:   Mon, 23 Aug 2021 18:40:30 +0200
Message-Id: <20210823164033.27491-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210815103624.19528-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes MSI and MSI-X interrupt support in
pci-aardvark.c driver and depends on patch series:
https://lore.kernel.org/linux-pci/20210625090319.10220-1-pali@kernel.org/

Pali Rohár (3):
  PCI: aardvark: Fix reading MSI interrupt number
  PCI: aardvark: Fix masking MSI interrupts
  PCI: aardvark: Enable MSI-X support

 drivers/pci/controller/pci-aardvark.c | 65 +++++++++++++++++++++------
 1 file changed, 52 insertions(+), 13 deletions(-)

-- 
2.20.1

