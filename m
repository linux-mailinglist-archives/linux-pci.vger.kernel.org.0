Return-Path: <linux-pci+bounces-13381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187897EF7B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A761C20349
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0962813D625;
	Mon, 23 Sep 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WaorQn2P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B3DF60;
	Mon, 23 Sep 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110020; cv=none; b=Zf/h0CGBrUZKoTQH4YzJPLn4Q9uaZmVuVNl5hCO6y+3zmIYZnI5k4ZLYjAq+Tz6K17sEWejSFpuI+Arw0WsweE+O8zr+3ZqXGr/KxTafiyjVevR1DLLWRYjAa7graAgMV5Gu5JCc2yuY0QN6UVMqzJ0dcI6zIDqWDezfNYYjBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110020; c=relaxed/simple;
	bh=F4v0y+Bjl8NFZT0MvI31qMxhmbhaaLLhvzclYgL6lCU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BnxixI2nB+TcOIB3CVDibuIprJpDl/71NsFBl0IRLp1KJyycV+gQpme6NfHvIYiYWHKp9V/YDAppKRiSQj2acuIAMwlWaV7DZUEvd3lsGbhKck0s5ARH2/pJ64Nmwr3r/s/DJoo1URY4yJ8ZpkNnDoO0oQkjJwokJgzrt0T6fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WaorQn2P; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727109994; x=1727714794; i=markus.elfring@web.de;
	bh=cLl2PIYMfeKrxIuDVB1meXKJeIwGbLWbFBXhJWFwUWM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WaorQn2PYMhdsk95EbSfq/FL30bwiJlmtcFnEQSg3J4xQgrVIrBQdbahrxC/f3ak
	 0E9CDqkYL8XFdGWIododSUEloM9oh/IsrXY+sfQ2t9LyUfGQnRUO0T9raNq3F20Zv
	 ZyDlVs25CmTV62KMJ8dCilZeqXUy+1W+5ebNxoZJlRlhwklIBgfJ75m+PK9DYbaSC
	 /PRgEoQXwrVWkaCZ7gZROiFjGhY1gqCyEvehZgR8fXalY4PEfiDZnHauVdPNJ21uI
	 ZXf/LZ6HgyJCyp6kfOOIYU/Un5jHfBrU+yxy/91EQridNfBkr+5hbkMdC1qEZd6o/
	 itU1Pyva28n6V6PbmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1siKjz3NCE-004LHi; Mon, 23
 Sep 2024 18:46:33 +0200
Message-ID: <95114539-d177-4be7-81bd-a10ef9dd64f2@web.de>
Date: Mon, 23 Sep 2024 18:46:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pci/hotplug/pnv_php: Reduce of_node_put(dn) calls in
 pnv_php_register_slot()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4mCo/RU42zxNcsXGSzibyvIeiV2BzIe9Aa534X8UIIfGsmSXiCo
 5mEOeVPUkp9CQ3cTsBKMR+P0Vw39x2t80SxhlRc7aL44PFv20PS/2gNsJb85lV1epa9ifwF
 J/L/woOOkj6zxuOK+2Ui+0M1tLnBnur7FfSrHi/ot2xnGtb+/9g21y62SLFVrdBH+mFq+/N
 PUeZt57Szc9Kn4k1NyGng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4QTreKRe//I=;QuM/+gaOgTylr75BQOxFi3oX7ss
 xt/Oq2lVsdajyLeNrvStW6MbYEyMYtEaiSSIEVVy4AoxSiFXOgYBJaezgvy1hC/b40KW5sAi0
 5AsKUFQPHFwwoOV2W35dlJDT6ZisNe6tspRClJ7/ay6J2GAtH5D50A17/W6hp3cH72v0IpSts
 f5O2prfsV6BfbMo/NUHOYn/aMgY2M8iveSdxixYuHjzDGJaROooXHGkyiH8YY9E9vtdHaWxs5
 63UFTk2KUWFn3QitXPoaCaVnSCJB/tdtdxTyVeENQ6sw4DxbV7fI725F/OSt8NevQim6FPBja
 46izS99jxDOERp0jnZf9dH3T24+L4OiLqXXyQd7dNPX8eFaQjAjTXRp9UjfT3Q8V1DvfTQHv7
 xXVacvDj71Ska5JyqK0+lsJgClFMcaQZTQ3WhnSwGCN1+nM1SO/fVzPCtbNhKySjR6aChJqJz
 ECsyhzwswHZE5YlA1x+eJnCtzkLlZin+WMlIJJWqx8LgPlMAG2XJNaZVvexeFVTcrSyQ/nUsy
 9ik8I1wQqWT1Rs+B3x3Ht2noo7LnPBgCyzYlRyIQrklssrCW/EDaEcyfJoOc8YMU2WzIaxrnY
 JSStHje4mMVAHu2oai2ymYeTVrGZgXetAVAz6bzoh5KFIRfougcV38XBmEHzgLHw5aO4zuNBA
 R3T7xe5tiwthQV+9N0mrxdKX2Jd1BjTFz0kJDdHnL0nDhKw8rgn1ePJgA3m+Xkj/LAHeu4tSf
 Td+eFg6NpUFBBJAseGbzZwJI/zb4ZZsn4tyoyAN4LGgbClISCdfvs5e+N74T5T9QJWhzwriN1
 Yqjvu96Xacg3fMUOFCCh5OWQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Sep 2024 18:32:21 +0200

An of_node_put(dn) call was immediately used after a pointer check
for a pnv_php_find_slot() call in this function implementation.
Thus call such a function instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pci/hotplug/pnv_php.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 573a41869c15..fcbf20db136b 100644
=2D-- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -697,12 +697,9 @@ static int pnv_php_register_slot(struct pnv_php_slot =
*php_slot)
 		}

 		parent =3D pnv_php_find_slot(dn);
-		if (parent) {
-			of_node_put(dn);
-			break;
-		}
-
 		of_node_put(dn);
+		if (parent)
+			break;
 	}

 	spin_lock_irqsave(&pnv_php_lock, flags);
=2D-
2.46.1


