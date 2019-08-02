Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869357E7BE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 04:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfHBCLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 22:11:43 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.82]:32388 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbfHBCLn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2019 22:11:43 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 22:11:43 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6545C1D408
        for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2019 20:23:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tMHzhhuB64FKptMHzhr7h1; Thu, 01 Aug 2019 20:23:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PyIxTuo3Q1FmZoMfrad16Zm5et086ZfT9Fbkw6cUKF8=; b=vSUWD0y67/E+mYWoTLaLfPgtgF
        vQr+eAzntBM3oJVYsXpEnu/2DdYWkJm/BIjYy2DC7Qbv1NnbkM372ZDMhWOKUSNdtPy7AgNeKBRnL
        +cIt8tquHHdl24C+DuB5Uylw7VKosqSi5+ezJP9BEJ7LnSkqG58dT17XK9p0ZFhVVxfSow+SYAnXq
        xqK2W+JeXj9m9tdifMzqx43FR8WVXYNVk/ifpy7o+tDWZxKokg8qpGVEr6tPnOPvq2wtISP7zuicC
        UnbZkuLiU0zRdRs3gTePfByYAKCB0oiy425jtCBUKC+WHZ/QK68Pb9qRN6MVz4wU5LEXvS1dkYe6C
        tF3B1Xtw==;
Received: from [187.192.11.120] (port=53894 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1htMHy-002DcS-Bq; Thu, 01 Aug 2019 20:23:22 -0500
Date:   Thu, 1 Aug 2019 20:22:48 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] PCI: Mark expected switch fall-through
Message-ID: <20190802012248.GA22622@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1htMHy-002DcS-Bq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:53894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: allmodconfig i386):

drivers/pci/hotplug/ibmphp_res.c: In function ‘update_bridge_ranges’:
drivers/pci/hotplug/ibmphp_res.c:1943:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
       function = 0x8;
       ~~~~~~~~~^~~~~
drivers/pci/hotplug/ibmphp_res.c:1944:6: note: here
      case PCI_HEADER_TYPE_MULTIBRIDGE:
      ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/hotplug/ibmphp_res.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
index 5e8caf7a4452..1e1ba66cfd1e 100644
--- a/drivers/pci/hotplug/ibmphp_res.c
+++ b/drivers/pci/hotplug/ibmphp_res.c
@@ -1941,6 +1941,7 @@ static int __init update_bridge_ranges(struct bus_node **bus)
 						break;
 					case PCI_HEADER_TYPE_BRIDGE:
 						function = 0x8;
+						/* Fall through */
 					case PCI_HEADER_TYPE_MULTIBRIDGE:
 						/* We assume here that only 1 bus behind the bridge
 						   TO DO: add functionality for several:
-- 
2.22.0

