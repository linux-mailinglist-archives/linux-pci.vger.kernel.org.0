Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA13E3984
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439947AbfJXRMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:54 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48808 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436722AbfJXRMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id BE83242F15;
        Thu, 24 Oct 2019 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937171; x=1573751572; bh=VeNEpSnuUTk4BsWDwgPyj1n8sam11FoBZBf
        qWyZyWDk=; b=kYuLNvLmsjlwggN/VzO9PtQCcYOkqXsEtlCLCmVd8AbPb+HYTNe
        bZSZCyhCfhVqYyi5A8KFRRY01x7U1BT7pvwctNx3Ts8N7pGYK6IQF2RtXMcbNR2S
        P7jFw1LDe1qBnVg6HlPGXRW4LGn8Jr0C5MplSEG4sXqmsMVFmJfLXs8c=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rC45o4Nt2fYf; Thu, 24 Oct 2019 20:12:51 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 62A0343E03;
        Thu, 24 Oct 2019 20:12:43 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:42 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Oliver O'Halloran <oohall@gmail.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>
Subject: [PATCH v6 20/30] powerpc/pci: Fix crash with enabled movable BARs
Date:   Thu, 24 Oct 2019 20:12:18 +0300
Message-ID: <20191024171228.877974-21-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a check for the UNSET resource flag to skip the released BARs

CC: Alexey Kardashevskiy <aik@ozlabs.ru>
CC: Oliver O'Halloran <oohall@gmail.com>
CC: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c28d0d9b7ee0..33d5ed8c258f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2976,7 +2976,8 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 	int index;
 	int64_t rc;
 
-	if (!res || !res->flags || res->start > res->end)
+	if (!res || !res->flags || res->start > res->end ||
+	    (res->flags & IORESOURCE_UNSET))
 		return;
 
 	if (res->flags & IORESOURCE_IO) {
-- 
2.23.0

