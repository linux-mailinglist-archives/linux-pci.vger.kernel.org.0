Return-Path: <linux-pci+bounces-2734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B951F840CA0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 17:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE81F27300
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBF157027;
	Mon, 29 Jan 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If2Ygv7A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2C15699F;
	Mon, 29 Jan 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547579; cv=none; b=Da7+Uik6erafNzx1R7jAJrnjeLb+r7xZ/yGoSPymK6JCTGPKoqAIi+OUBATIj/KQypSE4jLQ9N46utTAuaL3KlQ3I0FljS/h3BOblrJV0vAJbh6Une5+zwHes0r7GM5ftXtLJej7q2Is69qLj5DY7aEYLCOdeoVvGgnJ2egUZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547579; c=relaxed/simple;
	bh=8LILpHnnmR1A97ktFVzmWGYzak1i8dEqIJcb6XHLYyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hWN1DF1f9OlJxXxL3KAX8LRVgMN659I/ebVsA+edi/ItraXmgdzNce0tWxMkzAaI0lHXTdKdGijYAgBNi6uJE4AJk9+VyOz+OoSF77AqfWvt0I36L2GZmPVPljRoAWTtT+AZt/nHGzUkkGhXxBqqDRr1zBIoI04bKl2rKkNEaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If2Ygv7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64430C433F1;
	Mon, 29 Jan 2024 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547579;
	bh=8LILpHnnmR1A97ktFVzmWGYzak1i8dEqIJcb6XHLYyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=If2Ygv7AdJwTzIWfpgSrb/PMUe1PQ/pHHVsXfyua4k38Kcv7gHt8ZnaYdLbbyulTg
	 oxRHLQdokcIdEFGXe5UBdoBKletECirIQ+k9umBu1eoQtH3XAuh4fGAunou7U/b1TM
	 ZWDfYkQdTxt/Pb7AT2yNx+PcH7zZhJWiUjASuAMGyy3Hx9HmWzsPaizJ1IT5Z49vYx
	 V1jSgezKjRWIvCF9vVS2Ygd69ls3N/ZuH/WH/0h9nx9GIaVDs3dMLGOva2fNzg2ahC
	 03Qq+CnSLqjN8IWAvfNHFjKLyO0jPGzF+mWBYK2827mpVgX/+OcqO3NafyMBpQ5Wr5
	 Cg4LCz560sYjg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Date: Mon, 29 Jan 2024 17:59:33 +0100
Message-Id: <20240129165933.33428-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PCI endpoint subsystem is evolving at a rate I
cannot keep up with, therefore I am standing down as
a maintainer handing over to Manivannan (currently
reviewer for this code) and Krzysztof who are doing
an excellent job on the matter - they don't need my
help any longer.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Wilczyński <kw@linux.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..a40cfcd1c65e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
 F:	drivers/pci/controller/pcie-xilinx-cpm.c
 
 PCI ENDPOINT SUBSYSTEM
-M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 M:	Krzysztof Wilczyński <kw@linux.com>
-R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Kishon Vijay Abraham I <kishon@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
2.34.1


