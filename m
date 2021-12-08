Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87146DC20
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhLHT2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:28:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36846 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLHT2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:28:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 258A7CE232C;
        Wed,  8 Dec 2021 19:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8FFC00446;
        Wed,  8 Dec 2021 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638991502;
        bh=oSILA5JRSWyhwLLRJf0zlbR7eHgbv9S0Wl5DNCBoeJk=;
        h=From:To:Cc:Subject:Date:From;
        b=QwBVXpu2zThzLZ9ZvmcOFQCW4j663oc7ofJUxIBabGfhpWwOWSOlffUtk+fVU7WQI
         wK67+yKRopTuOorBSrCEmdOD3OZzjnNvNLYcITIoYWWbFZyu35u77JzwiJAAS6ODy5
         j/XJk/PUzKaszscbXyE9/8LehzuLvZR4wAN4gP12Aa5wZ4L4MB5Lil8IlCvHsIix78
         XQ0NLdvvtaVPkf+342UFGQ6gaN9jcdFY7OWyryPpP6gS+hnDzuX7RAqBQrS0+DKNqQ
         0v5a9IrOJamud6AVzFQibkcWuxPHcF3YG9XCfjvH3YW+FY3FwE5PPkJ6xWtgcy1N14
         umdwcdgl4zATQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 0/4] block: convert to generic power management
Date:   Wed,  8 Dec 2021 13:24:45 -0600
Message-Id: <20211208192449.146076-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a repost of patches from Vaibhav to convert from legacy PCI power
management to generic power management.  The most recent posting is here:

  https://lore.kernel.org/all/20210114115423.52414-1-vaibhavgupta40@gmail.com/

Vaibhav has converted around 180 drivers to generic power management, and
over 100 of those conversions have made it upstream.  If we can finish off
the remaining ones, we'll be able to remove quite a bit of ugly legacy code
from the PCI core.

I updated the commit logs to try to make it easier to verify these.

I also added a couple trivial mtip32xx cleanup patches in the same area and
changed the rsxx patch to completely drop the PM ops since the driver
doesn't support PM at all.

Bjorn Helgaas (3):
  mtip32xx: remove pointless drvdata checking
  mtip32xx: remove pointless drvdata lookups
  rsxx: Drop PCI legacy power management

Vaibhav Gupta (1):
  mtip32xx: convert to generic power management

 drivers/block/mtip32xx/mtip32xx.c | 86 ++++++++-----------------------
 drivers/block/rsxx/core.c         |  7 ---
 2 files changed, 22 insertions(+), 71 deletions(-)

-- 
2.25.1

