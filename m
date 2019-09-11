Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA5BAF701
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfIKHfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 03:35:11 -0400
Received: from p-mail-ext.rd.orange.com ([161.106.1.9]:44648 "EHLO
        p-mail-ext.rd.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIKHfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 03:35:11 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 03:35:11 EDT
Received: from p-mail-ext.rd.orange.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id D1A0E561587;
        Wed, 11 Sep 2019 09:27:56 +0200 (CEST)
Received: from p-mail-int.rd.francetelecom.fr (p-mail-int.rd.francetelecom.fr [10.192.117.12])
        by p-mail-ext.rd.orange.com (Postfix) with ESMTP id CBF0F5613CD;
        Wed, 11 Sep 2019 09:27:56 +0200 (CEST)
Received: from p-mail-int.rd.francetelecom.fr (localhost.localdomain [127.0.0.1])
        by localhost (Postfix) with SMTP id D71071802BC;
        Wed, 11 Sep 2019 09:27:53 +0200 (CEST)
Received: from yd-CZC9059FTQ.si.francetelecom.fr (yd-CZC9059FTQ.rd.francetelecom.fr [10.193.71.64])
        by p-mail-int.rd.francetelecom.fr (Postfix) with ESMTP id A4CBC1802B1;
        Wed, 11 Sep 2019 09:27:53 +0200 (CEST)
From:   =?UTF-8?q?Pierre=20Cr=C3=A9gut?= <pierre.cregut@orange.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pierre=20Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: [PATCH v2] PCI/IOV: avoid giving back wrong numvfs
Date:   Wed, 11 Sep 2019 09:27:36 +0200
Message-Id: <20190911072736.32091-1-pierre.cregut@orange.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2019.9.11.72116, AntiVirus-Engine: 5.65.0, AntiVirus-Data: 2019.9.11.5650000
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1200_1299 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, LEGITIMATE_SIGNS 0, MULTIPLE_REAL_RCPTS 0, SINGLE_URI_IN_BODY 0, URI_WITH_PATH_ONLY 0, __ANY_URI 0, __BODY_NO_MAILTO 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FROM_DOMAIN_IN_ANY_CC1 0, __FROM_DOMAIN_IN_RCPT 0, __FROM_UTF_Q 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __HTTPS_URI 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __MULTIPLE_RCPTS_CC_X2 0, __NO_HTML_TAG_RAW 0, __SANE_MSGID 0, __SINGLE_URI_TEXT 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_IN_BODY 0, __URI_NOT_IMG 0, __URI_NO_WWW 0, __URI_NS , __URI_WITH_PATH 0'
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When numvfs is being updated, reply to numvfs queries with EAGAIN.
As drivers may notify changes on numvfs before they are implemented,
it is advisable to not reply rather than giving back an outdated value.
Clients will notice that the value is still unknown and will retry
to get it.

The patch relies on the status of the device mutex as an
overapproximation of when numvfs is modified.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202991
Signed-off-by: Pierre Crégut <pierre.cregut@orange.com>
---

This is an updated version of "PCI/IOV: update num_VFs earlier" and a
reply to your mail sent on 14/06/19. Sorry I completely missed it.
The commit message was changed as the implementation principle was
modified.

 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 965c72104150..493eea261d40 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -568,6 +568,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
+	if (mutex_is_locked(&dev->mutex))
+		return -EAGAIN;
 	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
 }
 
-- 
2.17.1

