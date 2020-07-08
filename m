Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB3217C20
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 02:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgGHAOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 20:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgGHAOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 20:14:09 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7081820771;
        Wed,  8 Jul 2020 00:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594167248;
        bh=DN3iHDNuntnbnmz3uN4swyGc0jqn5mJ14MJNiYTaZao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVZTu0mMGT6MjYBicHaKCgG+eidNn7SG3rRrARO/ycC1BN7ewoPVW5PT2qMBXVa0D
         WcQPWS2HI+wqy83xmcS5PSFNsvOn5PbH/SSzk63dm3j2R/1uJ2D6X+woyb7GEHzr0a
         oHSQ1Bd6K5MPMBMPBUOr6Am2wpNtsRriFjy4QFLg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matt Jolly <Kangie@footclan.ninja>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI/AER: Simplify __aer_print_error()
Date:   Tue,  7 Jul 2020 19:14:00 -0500
Message-Id: <20200708001401.405749-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618155511.16009-1-Kangie@footclan.ninja>
References: <20200618155511.16009-1-Kangie@footclan.ninja>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

aer_correctable_error_string[] and aer_uncorrectable_error_string[] have
descriptions of AER error status bits.  Add NULL entries to these tables so
all entries for bits 0-31 are defined.  Then we don't have to check for
ARRAY_SIZE() when decoding a status word, which simplifies
__aer_print_error().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 48 ++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..9176c8a968b9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -447,7 +447,7 @@ static const char *aer_error_layer[] = {
 	"Transaction Layer"
 };
 
-static const char *aer_correctable_error_string[AER_MAX_TYPEOF_COR_ERRS] = {
+static const char *aer_correctable_error_string[] = {
 	"RxErr",			/* Bit Position 0	*/
 	NULL,
 	NULL,
@@ -464,9 +464,25 @@ static const char *aer_correctable_error_string[AER_MAX_TYPEOF_COR_ERRS] = {
 	"NonFatalErr",			/* Bit Position 13	*/
 	"CorrIntErr",			/* Bit Position 14	*/
 	"HeaderOF",			/* Bit Position 15	*/
+	NULL,				/* Bit Position 16	*/
+	NULL,				/* Bit Position 17	*/
+	NULL,				/* Bit Position 18	*/
+	NULL,				/* Bit Position 19	*/
+	NULL,				/* Bit Position 20	*/
+	NULL,				/* Bit Position 21	*/
+	NULL,				/* Bit Position 22	*/
+	NULL,				/* Bit Position 23	*/
+	NULL,				/* Bit Position 24	*/
+	NULL,				/* Bit Position 25	*/
+	NULL,				/* Bit Position 26	*/
+	NULL,				/* Bit Position 27	*/
+	NULL,				/* Bit Position 28	*/
+	NULL,				/* Bit Position 29	*/
+	NULL,				/* Bit Position 30	*/
+	NULL,				/* Bit Position 31	*/
 };
 
-static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
+static const char *aer_uncorrectable_error_string[] = {
 	"Undefined",			/* Bit Position 0	*/
 	NULL,
 	NULL,
@@ -494,6 +510,11 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
 	"AtomicOpBlocked",		/* Bit Position 24	*/
 	"TLPBlockedErr",		/* Bit Position 25	*/
 	"PoisonTLPBlocked",		/* Bit Position 26	*/
+	NULL,				/* Bit Position 27	*/
+	NULL,				/* Bit Position 28	*/
+	NULL,				/* Bit Position 29	*/
+	NULL,				/* Bit Position 30	*/
+	NULL,				/* Bit Position 31	*/
 };
 
 static const char *aer_agent_string[] = {
@@ -650,24 +671,23 @@ static void __print_tlp_header(struct pci_dev *dev,
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
+	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *errmsg = NULL;
+	const char *errmsg;
 	int i;
 
+	if (info->severity == AER_CORRECTABLE)
+		strings = aer_correctable_error_string;
+	else
+		strings = aer_uncorrectable_error_string;
+
 	for_each_set_bit(i, &status, 32) {
-		if (info->severity == AER_CORRECTABLE)
-			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
-				aer_correctable_error_string[i] : NULL;
-		else
-			errmsg = i < ARRAY_SIZE(aer_uncorrectable_error_string) ?
-				aer_uncorrectable_error_string[i] : NULL;
+		errmsg = strings[i];
+		if (!errmsg)
+			errmsg = "Unknown Error Bit";
 
-		if (errmsg)
-			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
+		pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
-		else
-			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
-				i, info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
 }
-- 
2.25.1

