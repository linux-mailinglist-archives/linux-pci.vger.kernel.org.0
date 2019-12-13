Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE011ECB0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 22:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLMVOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 16:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfLMVOM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 16:14:12 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BDC24671;
        Fri, 13 Dec 2019 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576271651;
        bh=kUQ9ID/xbPJQ3wZiChap4nrJxz4IWowR3x8gqN0lLMg=;
        h=Date:From:To:Cc:Subject:From;
        b=SD+2BCuj8VJGHyQFaFA3kcReZjhXRj4gnbbBsRT32ZMQmvJYtcbgb/0P0rqN9Rh0f
         orW0e4rwNpdXG8ioTVej39Afqebu1lTgJWlgT5+jM5r8dTY9UQnGf7oCTSA5hqvku7
         puustTox0IA5AHogGgk7Fy5mXcR2X9B+eST9P3ts=
Date:   Fri, 13 Dec 2019 15:14:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>
Subject: [GIT PULL] PCI fixes for v5.5
Message-ID: <20191213211409.GA200528@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix rockchip outbound ATU issue that prevented Google Kevin
    Chromebooks from booting (Enric Balletbo i Serra)


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.5-fixes-1

for you to fetch changes up to ca01e7987463e8675f223c366e262e82f633481a:

  PCI: rockchip: Fix IO outbound ATU register number (2019-12-12 15:25:37 -0600)

----------------------------------------------------------------
pci-v5.5-fixes-1

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      PCI: rockchip: Fix IO outbound ATU register number

 drivers/pci/controller/pcie-rockchip-host.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
