Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32BBF10C903
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 13:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfK1M4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 07:56:54 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1M4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2019 07:56:53 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MyK1E-1hbdcU0isO-00ydb8; Thu, 28 Nov 2019 13:54:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tim@buttersideup.com, james.morse@arm.com, rrichter@marvell.com,
        jdelvare@suse.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/6] mtd: maps: esb2rom: use pci_get_device_by_id()
Date:   Thu, 28 Nov 2019 13:54:02 +0100
Message-Id: <20191128125406.10417-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128125406.10417-1-info@metux.net>
References: <20191128125406.10417-1-info@metux.net>
X-Provags-ID: V03:K1:LJ4XD4Q1I99644y7Yi8gy5ObuDirUwTeYOjL2svDYQFbmIEiqVd
 vGqICSXk5rQO+LpL8caYsCfU5mx3d3HH5lM+2lZ2CEC58FUd5oY6TspsspPuQyR8euODIMZ
 n1i2gE8epRjsRuicdy7dtKZt2dS7q4Yan+TOCBWn6G9TyYJU4ClCXJ6c0GAieG84hIBeQbF
 5BlvrLn6Hpt6J17cgNARA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:huBOBxAjfPw=:zTo6XDhnLLzzv4ltg2BFi1
 nF2A00B8dy/VI82VW2OR01ds3tNc3tlEoJbXB2DTIR8n8UfO5/gexNjvuMhroiSHZIXOd3kvx
 jGNfa5bnxm1dbSM0gMs+w/D6WU8b9vg55rfVAqAY/gh3PLZFnRjlVbKILDLKsKA8gMEllJIWa
 MKleovtQv0maEKfs6ZGBCqYa3JoG2XmXP7pY2rA46EZyHg4HuDgtVhMa9RFQ5FvPR/TZHgTkX
 eAWmw44grNDI5c1aHxTSzw6XrY2hq5gKGxCHeKlqP2G+UKnfunIU5Wiop4A4T3eoxBh+qUliP
 /hmcVhTWAHRRqb1kyliqjsonMyZVmpIIXrfntkaJD577lHx7deq4OB+vCqt0VlBItzHd/aQMk
 4n/WY/6SI3nFbPxXamY6/F31fegGPmno9Si3NvXd/tZbtgJEPpVvD9vZynF6/fD6SvOhFMWYW
 xNkgPUQQ2QCSIDdIyfUtLtcKRSTqn93H2r00mAUcQ3IYbM/VOcoivlgbOeMehDgxA3tBIdMtx
 7nltM8Qh54ZJir0i84C1ziLMX13ZP0oD+y3hYBv283tLfALIGCDDje1bxzCJFfuuj8FgcD8jh
 cpPACtaPhZCZT2Zb27kDXOFvd6O1ePurAbNrIaRckJOmdoz6HXkDWtPJ+dhKPn2YB3Ch4CRT9
 qGB05QuHTPE+MoD+Tu3H6EMjm+BOtddiG72X5hMDgKwZx/m+6AGzFjiLFMAtd1uavzPqCPrGr
 hTttJv+ul5QcjQNcqwdBDyCFqhITSMjI/0bb9Neas+U0GwS2Z+ZPC2aHk/bvb0+wJAssQ8IyH
 G+Mh+rLaqXVLNlC8EaSnZ++5+T2u8tT4WxyfiGko+FA50gM9mKPmEl9OHzpHqWghgcpPBwTUz
 oi7mN497nCPqXxEoMqNw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Use the new pci_get_device_by_id() helper in order to reduce
a bit of boilerplate.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/mtd/maps/esb2rom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/esb2rom.c b/drivers/mtd/maps/esb2rom.c
index 5c27c6994896..0c638ac6ad82 100644
--- a/drivers/mtd/maps/esb2rom.c
+++ b/drivers/mtd/maps/esb2rom.c
@@ -421,7 +421,7 @@ static int __init init_esb2rom(void)
 	pdev = NULL;
 	for (id = esb2rom_pci_tbl; id->vendor; id++) {
 		printk(KERN_DEBUG "device id = %x\n", id->device);
-		pdev = pci_get_device(id->vendor, id->device, NULL);
+		pdev = pci_get_device_by_id(id);
 		if (pdev) {
 			printk(KERN_DEBUG "matched device = %x\n", id->device);
 			break;
-- 
2.11.0

