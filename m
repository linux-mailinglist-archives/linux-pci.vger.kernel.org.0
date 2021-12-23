Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9847DC54
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 01:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhLWAsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 19:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhLWAsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 19:48:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E5C061574
        for <linux-pci@vger.kernel.org>; Wed, 22 Dec 2021 16:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y+WseCG54oTY0+6bflP9hEM8X24/3e5+7YnX9/6Qnc0=; b=yELBIdk0piNmjVY38agkS1s+8V
        obag5AlsuqPvukBcmIJ2zA2XRzPcPI09cSHdZm09hgPCx4gsHcRrIRMQrFzrHkWdLXXNGmo2RuIH5
        W8U6rpxRNR07XhZ+P/22IkRHuCdCCw1gbhC8l015FoFhyYmtY9TQrnEoO64R2WZM2J2z7bKkW0Pup
        mGOk/Z9L8aQPtP3rMMhwMXmeCZY0IZU0BoEooap1s3PDeu/3VZg+5lXjkR+MXILANtmgrAwQfN/lB
        uHRpI1LXq5DbuGUmcgpIxCXQcb/Gpb22Mk+P1EJMcErAWTyHkCVyJBvhjWnUT23e9zlAvdiptfIpG
        /lUT8PxA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0CH5-00BcBB-9c; Thu, 23 Dec 2021 00:48:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-pci@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH] ntb_hw_switchtec: fix the spelling of "its"
Date:   Wed, 22 Dec 2021 16:48:02 -0800
Message-Id: <20211223004802.18184-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the possessive "its" instead of the contraction "it's" (it is)
in user messages.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
-- 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211222.orig/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ linux-next-20211222/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -297,7 +297,7 @@ static int switchtec_ntb_mw_set_trans(st
 		 * (see CMA_CONFIG_ALIGNMENT)
 		 */
 		dev_err(&sndev->stdev->dev,
-			"ERROR: Memory window address is not aligned to it's size!\n");
+			"ERROR: Memory window address is not aligned to its size!\n");
 		return -EINVAL;
 	}
 
