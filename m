Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F92FD0B3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 23:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKNWGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 17:06:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfKNWGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 17:06:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D895206CB;
        Thu, 14 Nov 2019 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573769168;
        bh=cTO4RjOT0SysrtQiwvzarGLc0CZERiI2IsPrmbqAAD0=;
        h=From:To:Cc:Subject:Date:From;
        b=Pqjig2kVGNdZSpI0AH3Yk0P6xOLDoPEKigAIPJSFPj7eL9PGWYwbLDhg/PQ+AbiUw
         1a+4c3LqV4eR6WzdtyQ4CBsSfAevGMAXxgrYvdWMsUWX5tI9e5a02t/y+n1kpfmD+Y
         W0K1eArQAEVxYAsCeLYOYQJ2JRIgZvBy3xAksjO8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     George Cherian <george.cherian@marvell.com>,
        Robert Richter <rrichter@marvell.com>, Feng Kan <fkan@apm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Unify ACS quirks
Date:   Thu, 14 Nov 2019 16:05:59 -0600
Message-Id: <20191114220601.261647-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

These are pretty trivial and not intended to fix anything, but just to
remove unnecessary differences of implementation from the ACS quirks.

Bjorn Helgaas (2):
  PCI: Make ACS quirk implementations more uniform
  PCI: Unify ACS quirk desired vs provided checking

 drivers/pci/quirks.c | 96 ++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 38 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

