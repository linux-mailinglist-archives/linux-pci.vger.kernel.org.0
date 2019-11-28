Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B914D10C8F8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 13:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfK1M4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 07:56:49 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:47357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1M4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2019 07:56:49 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mj8Vx-1hvDjy246X-00fC0B; Thu, 28 Nov 2019 13:54:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tim@buttersideup.com, james.morse@arm.com, rrichter@marvell.com,
        jdelvare@suse.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 4/6] edac: i82443bxgx_edac: use pci_get_device_by_id()
Date:   Thu, 28 Nov 2019 13:54:04 +0100
Message-Id: <20191128125406.10417-4-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128125406.10417-1-info@metux.net>
References: <20191128125406.10417-1-info@metux.net>
X-Provags-ID: V03:K1:9EUuGTPFx9yVqpEoKdlnLYODqk9fzt9TtUcFLxUJNQuCt8Dur2J
 ACsPPHh76A4wFy8Z88Uwcih8Gh0dLZpBgM8CFlKvY0QA8CbpcQLiyPn2pyQvfVC0LvrKJga
 Cc1aJBxlcwchVkCPVIP3TXc8IMtS9wGQaNQjzGegaEmSeVHuId1bQ7trzN6njcAQpcGXqw0
 CyUuKxSGvW13czLk3/woA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/fn+U6evcp8=:mG00zLE+KR2h6oHqb9009C
 L0fikJ9nBQgS+pmDUpSajRT4HUgHowXnOvY7nwciAUil9VzSSq5nS6YUn9wUiEJbCmBNMLBBi
 9GNdhWPS1tyZZwSwlZKHW8wKz+wikAN8xUu6xrk4YFNN23kXZplI4zmNLc+Lm5NyhRAcNdTIn
 zy59HI05sybYGVBCSLYg7ZHBT8R1zeYbZwKMqGNW4KS58cEhkWwLinI5jCexhRJ84HZZ+BoN1
 G3gCzTOfZgWRYOZCs88AkG/lhETTv0KlMQYhKgL7ekvBt7psZVSXZ/8i3OBWs8nO/GhCTTNyJ
 zoZAY24hx+Pi36uQKrn26DyHbKnFkAWh/JhYMI+8XYHj3RMrXDJmLGAADEQ8R7udrni5VDqRQ
 lIUeB02b37i4SJS82xbox6wwsVxwI4Y0yKU7hg41FJkk0yO59QBugIBSQMqoMuC8LwGZhF5Tt
 ChOYleEqTKERFMWYdnAQpTtmOUQYPTKU/6K02ai1cOGFMYV2JbZk1eMDM/7homG2m5rb9bIIl
 FtwTTsakh/VyDO4Xv+1wDFd/Ikjme1b8mbIQclCY8siGvzx4CZh0wrQpHYOLhR6tJC17XL3mK
 IaVxXZbWmn5zjH4JoffpYxppi9setLwa8TImMh23Np222al9COuJD16fmAPMYIbRxoHwrk4HP
 8Sd3yluxx5TCu/GorU/8vmVsRwGuRqEDm9KjAC2Cnn94lyTRGo1dVG/xfH+/xJGUfQgeab/lE
 IAshHFivK66H3YugaZnI3Fi5fIl4E0cFBdikOvm05PGkuNcE6Jv9wBeexKJo7o3NB+eECt7hu
 99QB4XBE7inceZX+WISbvRB+ohIstws4Entssak1jqg2wR4RN1TBTWYp/wY0m2rLoAKQCa+x/
 B6FZ1HHlOMjNBYVsVT/A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new pci_get_device_by_id() helper in order to reduce
a bit of boilerplate.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/edac/i82443bxgx_edac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index a2ca929e2168..c01f51a4848c 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -407,15 +407,13 @@ static int __init i82443bxgx_edacmc_init(void)
 		goto fail0;
 
 	if (mci_pdev == NULL) {
-		const struct pci_device_id *id = &i82443bxgx_pci_tbl[0];
 		int i = 0;
 		i82443bxgx_registered = 0;
 
-		while (mci_pdev == NULL && id->vendor != 0) {
-			mci_pdev = pci_get_device(id->vendor,
-					id->device, NULL);
+		while (mci_pdev == NULL && i82443bxgx_pci_tbl[i].vendor) {
+			mci_pdev = pci_get_device_by_id(
+				&i82443bxgx_pci_tbl[i]);
 			i++;
-			id = &i82443bxgx_pci_tbl[i];
 		}
 		if (!mci_pdev) {
 			edac_dbg(0, "i82443bxgx pci_get_device fail\n");
-- 
2.11.0

