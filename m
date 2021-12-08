Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7646DC50
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhLHThB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:37:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40202 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbhLHTgx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:36:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B79D3CE2334;
        Wed,  8 Dec 2021 19:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651CDC341C7;
        Wed,  8 Dec 2021 19:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638991997;
        bh=oDjg3WZFbjc9s4BCNu9jYA1XTiqP2A+Ud1hq6kK3QZc=;
        h=From:To:Cc:Subject:Date:From;
        b=GCuXTRFOhr0ZtgOZs+KKJKO8fcDtj2LiVC4ZabdxyT6HmoZsdhcM17Q6Z/FrZ1let
         dZ4aVswVERKPAkcOVqq0JnNx4e644M4cRt024zTuXfhcYiI5JATbwTp86y3iDiDmrs
         VwBCGNokrczzwx03Gbo0tbM6OQUtXpYIRzTZ0tSvd456eNg5GFC3LNUitlZZ+8j7rK
         l+ogcOtBlpeW7bsfH/RFQAIxMnMl6cKySziE+QOS9RFUq/7aLoP6jrIGRQM5Z9e4hL
         BXOVRDcCnwH6ypDhuDqpM0wtIiBmHcWKhFdXBycGUn54M7AVcKKm09ySK5qZz5TT2X
         RuNZH0UbTpZQw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 0/3] agp: convert to generic power management
Date:   Wed,  8 Dec 2021 13:33:02 -0600
Message-Id: <20211208193305.147072-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Vaibhav has converted around 180 drivers to generic power management, and
over 100 of those conversions have made it upstream.  If we can finish off
the remaining ones, we'll be able to remove quite a bit of ugly legacy code
from the PCI core.

This is a repost of Vaibhav's patches for AGP.  I rebased them to v5.16-rc1
and updated the commit logs to try to make it easier to verify them.

In the most recent posting here:

  https://lore.kernel.org/linux-pci/20211201025419.2797624-1-helgaas@kernel.org/

my commit log updates were incorrect.  This v3 has updates that I believe
to be correct, but of course I'd be grateful for more corrections.

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

