Return-Path: <linux-pci+bounces-43998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D84CF304D
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64A2300DA73
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787030E0F3;
	Mon,  5 Jan 2026 10:37:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC217A303;
	Mon,  5 Jan 2026 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609462; cv=none; b=Pm1HL3PU+GFvJ9IohV1fKBk0T5delzHdxE+i+wGfCVoFQ+b5Qb06FjieNZdPw1HXOmUN7JtSor54T70Az0MonEUMNkQyyIIa01wK1zqTtuyyU8kkpLOH6YiQ8DDro8bY4fUOiiI1NsZudD5w1tuoaC5IoqW+pBXeMPoWTiKRz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609462; c=relaxed/simple;
	bh=dV3vwIQW/uwkImwNIA/4jo4BV9KIMuKVmq6zz3w4xuQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s84s3y+9W6xIfx9MBelW0/bPDzXO0wlPCXwpeaFfTf/iiytBPRmxteWfhXcri1gMud0XRDDR+zB7gAsOhsZCAw8N/fX/zwHLXzbWyrGeCuzFEBsxOR02ROxFQTcq+eSSz2vTxRIDh3/R0J27SbHSNtZjEvb6cSGGt/5c685lt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dl9hR0GrFzJ46ZT;
	Mon,  5 Jan 2026 18:36:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 41BE040086;
	Mon,  5 Jan 2026 18:37:39 +0800 (CST)
Received: from localhost (10.48.146.88) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 10:37:38 +0000
Date: Mon, 5 Jan 2026 10:37:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?UTF-8?Q?Roh?=
 =?UTF-8?Q?=C3=A1r?= <pali@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Tyrel Datwyler <tyreld@linux.ibm.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/3] PCI: rpaphp: Simplify with scoped for each OF child
 loop
Message-ID: <20260105103736.00000ae1@huawei.com>
In-Reply-To: <20260102124900.64528-6-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
	<20260102124900.64528-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri,  2 Jan 2026 13:49:03 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

