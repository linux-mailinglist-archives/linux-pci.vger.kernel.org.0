Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807A44566F7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 01:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhKSAmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 19:42:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39910 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhKSAmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 19:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637282358; x=1668818358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVS4zJZCWHQBaTlisa8bNfSi3Y6NeWW4bfoJMvMTDoA=;
  b=abJitUNNdXbtmcJUuLnRPmSds6hnuFeoFHO5Z2s6vQOj4VGhOgQysIdL
   aLINQJtM1NsGjBlh85ZBqpMce4mkhn+HWPWxTa7KZTixKW6c/sb5CPVBf
   YYmov8AtXAdiDhuyFm8DRMMym7W4fePNI0x9eqqUC4Nz+TKDHfwGFJzq6
   vYGyXmo6GHHP+6M9ir7QagDrBAOT/doNDbzK+rWNc1HAo0UabktzlT35L
   WAXeQUitXcny3f4XLC9gJa1N2sMImZ7QC8FnADJXrflg/r/+3B2se8wOl
   AfokOFSOpI3DHmWfzKH80QAFXbHSUIh+A6baJSm3Zic7MPx5TNyR6BjUu
   g==;
IronPort-SDR: RLLN5VBYeVoEeGAuMN33eheFkYjohIEV5IWfwE6dcykDjnsEuAHXSPlWDW2Sj0VUEgr7b/MJi3
 XI9D7S71jIABicSjb7K2maKWvyPk9RCOoBoBkB1MnqskhPx0ocPfcyMLbeEjL1S6XsDBIFo3u8
 HoSvITaYmoB8s35VIQPXa3v4CHc6+FO0MHYhaA3EGoccc0WAYfO52KXp75uM7BVseTmOum5gmK
 AHdeq4v/sRxpNKZhik8qMzf/QMz90c/BwB/OgC57vWcgLX/zWK+BnyDjvZfjzPEGUKlkvMXQUy
 pTX6JoZOtIg0gUQkpnAFrSGK
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="143882522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2021 17:39:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 17:39:16 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 18 Nov 2021 17:39:16 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 2/2] Declare local array state_names as static
Date:   Thu, 18 Nov 2021 16:38:03 -0800
Message-ID: <20211119003803.2333-3-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119003803.2333-1-kelvin.cao@microchip.com>
References: <20211119003803.2333-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a MRPC command is being executed, the function stuser_set_state()
will be called several times to set the command execution state.
During each run of stuser_set_state(), the local array state_names is
allocated and populated. The array contains a constant mapping of the
state enum values to the text strings, so repeated allocation and
initialization is just a wait of CPU cycles. Therefore, declare the
array as static.

See the link below for the discussion.

  https://lore.kernel.org/r/20211014141859.11444-1-kelvin.cao@microchip.com/

Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 6e2d6c5ea4b5..c36c1238c604 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -122,7 +122,7 @@ static void stuser_set_state(struct switchtec_user *stuser,
 {
 	/* requires the mrpc_mutex to already be held when called */
 
-	const char * const state_names[] = {
+	static const char * const state_names[] = {
 		[MRPC_IDLE] = "IDLE",
 		[MRPC_QUEUED] = "QUEUED",
 		[MRPC_RUNNING] = "RUNNING",
-- 
2.25.1

