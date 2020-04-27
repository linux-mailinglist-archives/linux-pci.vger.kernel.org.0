Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15EE1BAC80
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgD0SY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:28 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53026 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbgD0SY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 993784C86B;
        Mon, 27 Apr 2020 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011864; x=1589826265; bh=zMr30wP67VsbDrjVeq0RF/XuXwdXQQ63IPU
        finfy9rY=; b=jKzXHW2DAKUiIrxQtUQWwhCIJxei3tHcimu/JCEyVs7Y0Ehc+gR
        /C+vObLL/1urMahDKkkN307xKvwqLiEzrV8evsZDRvJ4SRGt0EAfLPU5zQ7Fqh51
        W3Hc2rlHCKuszgkW7O7pr+YZ+mi+2I+n8Ux7qCqi153+SC6E4LjXxmy8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OND_HZJOtFXm; Mon, 27 Apr 2020 21:24:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1D6FB4C84C;
        Mon, 27 Apr 2020 21:24:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:14 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 20/24] PCI: Don't claim fixed BARs
Date:   Mon, 27 Apr 2020 21:23:54 +0300
Message-ID: <20200427182358.2067702-21-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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

Fixed BAR always has an address, but its parent bridge window can be not
yet calculated (during boot) or temporarily released for re-calculation
(during PCI rescan) when pci_claim_resource() is called.

Apart from that, fixed BARs now have separate guaranteed mechanism of
assigning comparing to usual BARs, so claiming them is not needed.

Return immediately from pci_claim_resource() to prevent misleading "can't
claim BAR ... no compatible bridge window" error messages

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-res.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index a1e61e74ce00..98051edd7eef 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -138,6 +138,9 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 		return -EINVAL;
 	}
 
+	if (pci_dev_bar_fixed(dev, res))
+		return 0;
+
 	/*
 	 * If we have a shadow copy in RAM, the PCI device doesn't respond
 	 * to the shadow range, so we don't need to claim it, and upstream
-- 
2.24.1

