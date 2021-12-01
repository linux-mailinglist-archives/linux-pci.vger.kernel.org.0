Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6746451F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 03:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbhLAC5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 21:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbhLAC5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 21:57:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3FC061748;
        Tue, 30 Nov 2021 18:54:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB51B8164C;
        Wed,  1 Dec 2021 02:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3786AC53FCB;
        Wed,  1 Dec 2021 02:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638327265;
        bh=bLoI2u1zhgXsRynXZI+d7PsJZN0AP7jMWKDX+qn0CQo=;
        h=From:To:Cc:Subject:Date:From;
        b=plMU7TyDEyojfbdt2+C+FKRjElwHXfUPE3a0n3tTBZKJ9tzcRmhS8DW9LGehQe+GY
         yvwgrbfI+JctbnSvSlgmugH+S/iK43HFVvfZE2+Db/niqtsEzzpcwn54x1Oo+v9RXT
         m7ZLru5eDGRLtyicXPmrPZNafIQwM+7BRK8OoLydQt1fJDobDfZwKuq/c0BbugivYz
         AbsY8gU4bC413t29yCFb0FozBXJ1c+IE5+eLO1vCH2vu22jNvx1zt36F/KDtOR5RHl
         pJraNNiAsb6PitY1x0fTW7IUfGxFHdf32D2hp2a/w4iC4eEdbPDwXd/nV+e8EcLl00
         xNfWcg9+Mh6xA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 RESEND 0/3] agp: convert to generic power management
Date:   Tue, 30 Nov 2021 20:54:16 -0600
Message-Id: <20211201025419.2797624-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a repost of patches from Vaibhav to convert from legacy PCI power
management to generic power management.  The most recent posting is here:

  https://lore.kernel.org/all/20210112080924.1038907-1-vaibhavgupta40@gmail.com/

Vaibhav has converted around 180 drivers to generic power management, and
over 100 of those conversions have made it upstream.  If we can finish off
the remaining ones, we'll be able to remove quite a bit of ugly legacy code
from the PCI core.

I updated the commit logs to try to make it easier to verify these.  The
patches themselves are unchanged other than being rebased to v5.16-rc1.

Vaibhav Gupta (3):
  amd64-agp: convert to generic power management
  sis-agp: convert to generic power management
  via-agp: convert to generic power management

 drivers/char/agp/amd64-agp.c | 24 ++++++------------------
 drivers/char/agp/sis-agp.c   | 25 ++++++-------------------
 drivers/char/agp/via-agp.c   | 25 +++++--------------------
 3 files changed, 17 insertions(+), 57 deletions(-)

-- 
2.25.1

