Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F06C3B38C9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhFXVgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 17:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhFXVgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 17:36:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F16EA6124C;
        Thu, 24 Jun 2021 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624570440;
        bh=zy6XqKHAM6vhaOMsX4oGx0Sh3Sk5/sNITeoFBVzQ2NY=;
        h=From:To:Cc:Subject:Date:From;
        b=M6X0F2s6pJ9AFjjbee8UtDnqnPj1lEx3EwGlh6YC6ViKLvhYougg58DchDanlHeiw
         tqECFZpmWvl1aElbXC1a59F9MZ6kvP8hHuAEhdNxpKBWmgLXhjwcHN3dnWH8L58qKl
         +6GIGOuz+XWkrtRcG7Xw2ZthkZKi/+eKh5XY2B6NC8YIW4vNlFGEUhj/hCx24aJ11A
         RWoTkCwhTt8EZ0o8+0rcMGYnyUn5ogr8Wz+CWb+kpfjnSY2cdowerZnsJ1I49FFfKG
         9CDfxx5P9GQIFcnypwRHGc8A3SZSkJLBaTl5Flrwj77O9BftJuo7pZnPSfPI4BeknP
         9rtqSIVkLLjEQ==
Received: by pali.im (Postfix)
        id C258752D; Thu, 24 Jun 2021 23:33:57 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/3] PCI: aardvark: PIO fixes
Date:   Thu, 24 Jun 2021 23:33:42 +0200
Message-Id: <20210624213345.3617-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per Lorenzo's request [1] I'm resending PCI aardvark patches from big
patch series [2] which fixes just one small thing - aardvark PIO code.

[1] - https://lore.kernel.org/linux-pci/20210603151605.GA18917@lpieralisi/
[2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/

Evan Wang (1):
  PCI: aardvark: Fix checking for PIO status

Pali Rohár (2):
  PCI: aardvark: Fix checking for PIO Non-posted Request
  PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO
    response

 drivers/pci/controller/pci-aardvark.c | 97 ++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 15 deletions(-)

-- 
2.20.1

