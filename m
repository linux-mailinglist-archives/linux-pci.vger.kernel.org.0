Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0420ECD8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 06:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgF3Et5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 00:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgF3Et4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 00:49:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735ADC03E979
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:56 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t32so13712511qth.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1pgr6KaNRkuRhLLKbqD3ulE84r9BXBrKXG+wTgasJBs=;
        b=EmhVGqKj1hxcynFazVyM9BBAatcEV5Glfv6IolcJAU+WZt80BhCC7S95uetkKS69rG
         moLJ6mFVxETH0uu9E5a71IdGi1EO4Jhlu5hsB7433iTczY02C02gemnhGbY2HbNsmeK9
         p89uUnKxxwP9D13BCKNLWLjQu3I1+cvnyQpwfOIonoAfzeqNwq8mWanYN1hfu7UVEnqu
         7AVkwFxIC+IhNltLvEX3U89fGJ3pMmvPsScLgILybybvho+KO8QYE5NqN/pAWR+OXe8w
         GvuFxrbWomAp5dLYDnySp6VAEjs1FyccCG1hfRZ3TOXSnaYyLVsaVOXiMQes4cgLhzF1
         WihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1pgr6KaNRkuRhLLKbqD3ulE84r9BXBrKXG+wTgasJBs=;
        b=ZoD+RhYEvQmYrpNT3zWvaiiWLrsHsQpfh4KzL7drdeyHO2kj9JbGK6YCt/40/QIXFs
         rzXgpF8kh8OBWnn/MXr+G2L7vjf2jG9NhEY/K5a4GValgffeMgMhecvhe6GbkqkjONcj
         +qHDebfd9MwSkb7VgzyLtAa0H4dQQIb9pu7Q3Zh6VavFZOFPatL6apiKi+a3G2CTsORt
         FqE71Bl+OauoV7F2nEmiizlKjNuARjFjG7EwN4svYRPkP7tiaA+H5+kP8gaULdry/fMC
         WGMui3PHUKAXmE1cgaDbp760lzxwdC+W0ERDrTth3EIyIVUdtebKMjzIze8jQUjYses3
         NBZQ==
X-Gm-Message-State: AOAM532d2yWw9PTY9bU40Y/NNMxApJGmh+v95rkNmUGHLT3wCmRq21HR
        seRTB1BnQoerOfd6zWwV454o8B7WdxtA
X-Google-Smtp-Source: ABdhPJxPqRsEUkTJy7xBvIqn4j64tLwwndWDL29Mu8/+Z31HqzfgXJZ/paNZUVBIuCrmANpGN0BjB5/3u/Zp
X-Received: by 2002:a05:6214:18f2:: with SMTP id ep18mr7665592qvb.96.1593492595480;
 Mon, 29 Jun 2020 21:49:55 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:40 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 4/7] PCI: Add device even if driver attach failed
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

device_attach() returning failure indicates a driver error while trying to
probe the device. In such a scenario, the PCI device should still be added
in the system and be visible to the user.

This patch partially reverts:
commit ab1a187bba5c ("PCI: Check device_attach() return value always")

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Cosmetic change in commit log.
    Add Greg's "reviewed-by"

 drivers/pci/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e6da77d..3cef835b375fd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER) {
+	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		return;
-	}
 
 	pci_dev_assign_added(dev, true);
 }
-- 
2.27.0.212.ge8ba1cc988-goog

