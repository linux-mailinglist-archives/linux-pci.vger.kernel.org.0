Return-Path: <linux-pci+bounces-5380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4F89156F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DA8B22F5C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C639FD1;
	Fri, 29 Mar 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1cTxtUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27A39FCE
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703397; cv=none; b=ZLIzPzoLUJLcqtfF8H8TA+iiEKZcJxOn2h03oxqKo4fWQyE8EUVEqJeih2e/G7B5ZyLiaTle69UyDGowr8rfS/6m8EDPEKh/yxNu75M8B3zx0GK4Z5K9rTqgDHJIFpZU0mZdDXrBDiykKEbLAyo2kJWOGhzA1q7yOsJY7K5S8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703397; c=relaxed/simple;
	bh=RPsgju8wctxiYCFYLF54C9sP1jD4+/+es21hzNjkdTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpHNYsXr2rBvzaAV1cARhf8LU98arcp/QSWU3yIKC66xtBAmPCd8xW3Y4y1xcnjplJIReYUcAXq12mVRJzowCieWGoqrdkarR5oFBxI/JAjytqZryOPKHZfnGepi3X0hZTKoTcLFsBUqbkpEIb9i6kCOUnMyTJYhrY+39XIsgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1cTxtUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A986C433C7;
	Fri, 29 Mar 2024 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703397;
	bh=RPsgju8wctxiYCFYLF54C9sP1jD4+/+es21hzNjkdTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1cTxtUbTPUd9ck6/DygX4OqkrkhveqVmBXUCh15b/AsCDmL0Ph7xsaN/xn+Vd446
	 rrRc0xLppVRCebX/nhzF+UY5qrN099j/SibNwlLHkEKRnS0QRs3AeOQDocRgptxx2q
	 WwvoyEHITgVCHCNAWmV1ewRH25xbM8dU5uS1+5GBfvJXOsC/hCCLhJsotY/KO5mrjj
	 q+hbJgHNhr8Dm3CN6k7nwb0e3DhriLLyDNFvMZ8T+2QbV79kqV77YhFP7TDd5USZQQ
	 WRVOyeLWtTLKQSGjyVn1i1v4AHwA60+D56x5Fao52QaCYd9SyBXMcFa/+UXmpqJBbD
	 NyvXEUAn5b8Ng==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 06/19] PCI: endpoint: test: Synchronously cancel command handler work
Date: Fri, 29 Mar 2024 18:09:32 +0900
Message-ID: <20240329090945.1097609-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pci_epf_test_unbind(), replace the call to cancel_delayed_work() to
cancel the command handler delayed work with the synchronous version
cancel_delayed_work_sync(). This ensure that the command handler is
really stopped when proceeding with dma and bar cleanup.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0e285e539538..ab40c3182677 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -709,7 +709,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	struct pci_epf_bar *epf_bar;
 	int bar;
 
-	cancel_delayed_work(&epf_test->cmd_handler);
+	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
-- 
2.44.0


