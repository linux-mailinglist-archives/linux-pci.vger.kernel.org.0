Return-Path: <linux-pci+bounces-16025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1289BC381
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 04:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64D01F22852
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436DD44C81;
	Tue,  5 Nov 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FF+SJ6vU"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCF44384;
	Tue,  5 Nov 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775652; cv=none; b=mjuaPYaA3x4hl/GaqLVvbdvhfLQXF4TzbadJLes2QHyYdcrIUgg0I/GEW74y/eiUeoEX72wyb7S0bP4USpI+PUxhGuYSYCxNQNdhLqLQ3YZ4tzNXS3VSuAuQQ19uxezCJzia+xrFf+lxyDyMQA5CJPT0WM+Y2tw5xSAKWzpzPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775652; c=relaxed/simple;
	bh=bj3DwCv+0tB7B302FckfwexlfI0lLhQcsfn8PTG60Pw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NGLXDNFdiIDvHSEkrh1qHCjwEoVKty1vQ6KJm195tbiY0W1SYY49tZAv3voLjljNA+5kwsT248tVfha9OjYSZqjzsPdpZCly0rOCNnB8jwBpfVGedPJ8n4oai7epJjT0+H1aPfrKRMr2cN4al+87tITw0KAp2KnZoHGXpVp+Y+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FF+SJ6vU; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730775337; bh=SWHjz2Lk6fjSLhOy4bGJ3wF2EBPFw4Pks3JG73diQ68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FF+SJ6vUGYowNjs3pxgEctZAK8VJGw9B583x9O+GntFKbTyzJ1PxirazCJAKbcr06
	 1X01EvfZerUXkiCJxLISnp1A59IhemdHNNUG9vdmsuDvhCWQHJYd5hbZrdhftq1AI0
	 U79XRgUT2Gdq/neRk9Gykh7pSTVKoEY5BU55s3d0=
Received: from localhost.localdomain ([111.48.69.246])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id DE307413; Tue, 05 Nov 2024 10:55:35 +0800
X-QQ-mid: xmsmtpt1730775335tj6c90fe4
Message-ID: <tencent_F250BEE2A65745A524E2EFE70CF615CA8F06@qq.com>
X-QQ-XMAILINFO: OUrMHMu9XZHvy3CREPEd+2k3eya50auhHkfTtb4Gbl2TTPC+51ZHGn9Mm4ou6h
	 Z3YK9RCHJX6YuqkpQZiytCcxpr0tSolhDLDW2BT46uohH1DK40prBT4dFRs12sd8HVkq+yy2WthN
	 S+B11gzCGO65aR4Mq2NqUN9x7gJ6G8o3vwkntAKQE1LHmUWjbopNxdqtchHSLsYEWAYpOwWNcFMx
	 C1Syz8g3W8yObre5rb23NCjNzAbbTZ8MedhVbpUfmOQBt8GA3utZSTu6MXYjLnKmYjnIm5QTFA/b
	 indiVfTdbpZuwTp+8dH4CZyJ+EOKnqWELq0ObpyvnqTXghhfmOwJI2V+iTdheJe7xQo+lUzwXPWl
	 wwlJ/4g3GqeqfkBgtQTJXklrHiHllHqUMuEdzk+2BErqMp+rE9gvuWB1VD73l+s4Dy6SRN6t8ZcW
	 09BA6VPAexGVjaDv0c8XUlLGRFznFGaxJleVatMTi/d4/D24xSkyx8F7VD/a2CPq1txHjxOIpdpO
	 KFgQ6Do1ryj6CWrfCi+4PEqhkqbbmpwOZOJkzlnAs5SKSHBSC6VoQOGtupDqCNZWIDhrdA8sE6Kl
	 voeWopGkoxiHzXgG1NeMFjV3qCGsGSCaLXpigHxf/cbmemadbN11AagDnY6mVllqfPe4Ncbj+Km3
	 E4bQp1rmiA9m4RL8Std0k+6irB2XllfY+YdZK9iYqmBMNOFHf3vg3+jXGtreFqisx88Niu+BS+uq
	 lRqiFTe7kWRqVmJjnRukgHBAKBM3mcN/1PDcv+2hR5B4o7cRPDPGqf1sEsFFLkD5KiaVuIx6nOoc
	 w9Qx8cLU3T/2hFxbWr/ZA2vGj2650OMOFSFg5/WxEZU7lLxYPSJzpXeC0kZw5J0gxYbPCMY7nq5K
	 OzeY2QmQIv
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: 2564278112@qq.com
To: manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	kishon@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	dlemoal@kernel.org
Cc: jiangwang@kylinos.cn,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()
Date: Tue,  5 Nov 2024 10:55:33 +0800
X-OQ-MSGID: <20241105025533.62199-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <=20241105004311.GB1614659@rocinante>
References: <=20241105004311.GB1614659@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

Remove a surplus return statement from the void function that has been
added in the commit commit 8353813c88ef ("PCI: endpoint: Enable DMA
tests for endpoints with DMA capabilities").

Especially, as an empty return statements at the end of a void functions
serve little purpose.

Otherwise, a warning will be issued when building the kernel with W=1:

  296: FILE: ./drivers/pci/endpoint/functions/pci-epf-test.c:296:
  return;

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..cfdb38cd8cd7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -291,8 +291,6 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 
 	dma_release_channel(epf_test->dma_chan_rx);
 	epf_test->dma_chan_rx = NULL;
-
-	return;
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
-- 
2.25.1


