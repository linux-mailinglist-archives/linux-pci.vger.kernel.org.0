Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AA90624
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfHPQvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51342 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbfHPQvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 112E542EFF;
        Fri, 16 Aug 2019 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974279; x=1567788680; bh=K/nfH13rUWMvabK6CuDuNbtLJNQophMLLiP
        WhN0Bsk8=; b=VqKcxHQFgaKQixA+3vQeVnLhcAOVeabzzIkL+WWTrlN3g7IwOwa
        mBiVFE84LPcvreyzyd4BwBhfXVzQABXHNfPK/Fqe2Yo901VJipwbndX010ZhQXYX
        1cgn2mDi2GQRe4M7GtzhWrXU7mNXVUN7CzkvZxfqROQrlA8w1HK8XmX8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zTt0_kUQmjt1; Fri, 16 Aug 2019 19:51:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 7CDB442EE3;
        Fri, 16 Aug 2019 19:51:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:12 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v5 17/23] powerpc/pci: Fix crash with enabled movable BARs
Date:   Fri, 16 Aug 2019 19:50:55 +0300
Message-ID: <20190816165101.911-18-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a check for the UNSET resource flag to skip the released BARs

CC: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8080558d020..362eac42f463 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2986,7 +2986,8 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 	int index;
 	int64_t rc;
 
-	if (!res || !res->flags || res->start > res->end)
+	if (!res || !res->flags || res->start > res->end ||
+	    (res->flags & IORESOURCE_UNSET))
 		return;
 
 	if (res->flags & IORESOURCE_IO) {
-- 
2.21.0

