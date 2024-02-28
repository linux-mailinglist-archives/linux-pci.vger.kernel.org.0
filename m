Return-Path: <linux-pci+bounces-4226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4C86C2A5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 08:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7591C21B49
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73F45961;
	Thu, 29 Feb 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gTP8kfs4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DE44C9C
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192292; cv=none; b=TsxjjNlSUhvC9+pdmyAc/NqWA/Ih9fJRsSIxl7D9R8hD1aFNsS2Zd9oKDGhSNsLxEjeeeUmruOHa/IIGEBV7uUhmcNUXQ8YuFrZE6SylnU1T5uONJehWWyQFg1UUGJPvZ8hbJPc9L5e/E9wHe/nTiIPNp57Yw8WUJ2A3baUE/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192292; c=relaxed/simple;
	bh=Qcg10EfbIdNpPgAu51XQ097CGQYYZjZe9r5v3xd1sAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=EuLNKc2kodEerO9TwH//j5xpYTgR4n/+iU6GWcKDV4g0vlJj4LwzToytehymeVNQtewFs2dRCmDWP/vHmBoLMF3XehxeycY9ZmNN1LObmJWjWFdfpXu3yrLOPMj0lJ5DZa9C11g9gEfLDLr8cvbwkbWyb4kyGh7taQnL5PWd09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gTP8kfs4; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240229073801epoutp0105798cea4ac87ea79480110f7b2e63d7~4RVMYLHLR1110111101epoutp01C
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 07:38:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240229073801epoutp0105798cea4ac87ea79480110f7b2e63d7~4RVMYLHLR1110111101epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709192281;
	bh=NMRnIeTdMH1QaXB4w+BjaNz5iINjYFDjL1ixEPJsvT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTP8kfs4bgdu7pxNGr9FtXOnh9Y6wuDV3IXnmn23Kz4XogBtlJpapYLjq3UGu8gpY
	 XXsMPKzw5ZdoFPiddYogBGiGWywwMJbDWX5DR4rzzW4q8y0zsnplXov4hXoZ2L7qNY
	 hz7k7fZAwe45GYQEN6VpeuOD599CKWE73pCjoies=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240229073801epcas5p3459bfeefc6142a1e8b6b8335c9a67026~4RVL4A-8O1405014050epcas5p3I;
	Thu, 29 Feb 2024 07:38:01 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TljkH2dwGz4x9Q9; Thu, 29 Feb
	2024 07:37:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.A1.19369.45430E56; Thu, 29 Feb 2024 16:37:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240228134451epcas5p1b974d61fcab67fb5f52a7b291cf85966~4CsMmnDn80371603716epcas5p1d;
	Wed, 28 Feb 2024 13:44:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240228134451epsmtrp2f506c8122a543112b11e536ca19de064~4CsMl7nM52244022440epsmtrp2P;
	Wed, 28 Feb 2024 13:44:51 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-86-65e03454b60a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.37.08817.3D83FD56; Wed, 28 Feb 2024 22:44:51 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240228134450epsmtip12ff7dfd1b362aaad2db74bbd9cfc30f6~4CsK__dlL1554615546epsmtip1b;
	Wed, 28 Feb 2024 13:44:50 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: lchen.firstlove@zohomail.com
Cc: lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, pankaj.dubey@samsung.com
Subject: RE: [PATCH v4] PCI: endpoint: Add prefetch BAR support
Date: Wed, 28 Feb 2024 19:14:48 +0530
Message-Id: <20240228134448.56372-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmhm6IyYNUg5sduhZLmjIsjrb+Z7Zo
	6PnNavH75wMWi8u75rBZnJ13nM2i5U8Li8WBD6sYLRZt/cLuwOmxYFOpx6ZVnWweT65MZ/Lo
	27KK0ePzJjmP37OPMQawRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
	ptoqufgE6Lpl5gDdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7N
	S9fLSy2xMjQwMDIFKkzIzmhauZ+9YJ50xdxP05kaGI+LdTFyckgImEi0XtnA3MXIxSEksIdR
	oqdlEhuE84lR4vTkg4wgVUIC3xgl5s6ShOl4vPUqVMdeRom+vb9YIZxWJon5HbeYQarYBLQk
	Gr92gdkiAgoSLc+3gxUxC2xnlGj/0s0CkhAWsJc4276PCcRmEVCVmLjiPVicV8BKYs63RkaI
	dfISqzccABvEKeAucWnvZTaI+D12iZfr6iBsF4n3u75C1QtLvDq+hR3ClpL4/G4vVH26xMrN
	M5gh7ByJb5uXMEHY9hIHrswB2ssBdJymxPpd+hBhWYmpp9aBlTAL8En0/n4CVc4rsWMejK0s
	8eXvHhYIW1Ji3rHLrBC2h8TFtjfskECZxSjx9/dLtgmMcrMQVixgZFzFKJVaUJybnppsWmCo
	m5daDo+25PzcTYzghKcVsINx9Ya/eocYmTgYDzFKcDArifDKCN5NFeJNSaysSi3Kjy8qzUkt
	PsRoCgzAicxSosn5wJSbVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMH
	p1QDU0rHCi2HlF2CNd6v9Za8T9hRznF53XzrxurON3P2bttd8tcmmnmLZO7t4wyT5kY079LS
	Nno4dfbKh113t25by9O3PuR/oqrb2iNtLyUez7KoerW2R3nzBq67jZ8FA6OY595I4utS1plk
	4ugsL66r9eTFJa/jcvuPmM2atfnTQf9NTjvCBT7K9lfcdIqWYy+omD3lcMQij3sS2a+k0rV4
	b2rNXs72v2pJRPfswy/5lFefOfNh8tm/EcqRTk4r4/SyduyX+Jxx4vJN/RO3LKYfkN1pvLBY
	XNXrUVNHoP+J3tkKs2U0L66UsM+aZJ11+4De/WNHo3Jkb10/PXexjYO44LEpjx5n2vccLFz7
	+PzGvjNKLMUZiYZazEXFiQDXq+haAQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnO5li/upBh8P6VksacqwONr6n9mi
	oec3q8Xvnw9YLC7vmsNmcXbecTaLlj8tLBYHPqxitFi09Qu7A6fHgk2lHptWdbJ5PLkyncmj
	b8sqRo/Pm+Q8fs8+xhjAFsVlk5Kak1mWWqRvl8CV0bRyP3vBPOmKuZ+mMzUwHhfrYuTkkBAw
	kXi89SpzFyMXh5DAbkaJdd+OsUEkJCU+X1zHBGELS6z895wdoqiZSWLegidgCTYBLYnGr13M
	ILaIgIJEy/PtrCBFzAIHGSXe3P/CCJIQFrCXONu+D6yBRUBVYuKK9ywgNq+AlcScb42MEBvk
	JVZvOAA2iFPAXeLS3stAV3AAbXOTmNmZPYGRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8
	dL3k/NxNjOCA1NLawbhn1Qe9Q4xMHIyHGCU4mJVEeGUE76YK8aYkVlalFuXHF5XmpBYfYpTm
	YFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwFTz/ndd1OXeW1PZ9Hd4buX0blc8uVQlr57r
	xiOn+f8/L66Im8RTbZrHMC8ptX2i5KctWeJ2h6/V1u1Z+H5SB29GhGeokp/vnrqI+6Uv/iy9
	eOZ108E4p31fGN9cX3LW2fn/9kldyZfmf+G65f76P+/3db7zJafdMX3pbNkjzBh0b5L4RVn1
	1+65nUslElazFkaY3b458VPHBtYJcRsfzGj6p/aMQ+fMbPXPTsuU8mZe31ohX6x68biEnEBn
	cU5vUJik3407c3+7zJY/fnjL+yVCj0XP3N65KuSQuZuo6u2dqyed5792af0Ew3nWmv2lW4Ku
	qazx8w07xlKwib9qklv3LL8VnAd02HSOcqmrzt2gxFKckWioxVxUnAgAsz4J3LcCAAA=
X-CMS-MailID: 20240228134451epcas5p1b974d61fcab67fb5f52a7b291cf85966
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240228134451epcas5p1b974d61fcab67fb5f52a7b291cf85966
References: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
	<CGME20240228134451epcas5p1b974d61fcab67fb5f52a7b291cf85966@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Reviewed-by: Shradha Todi <shradha.t@samsung.com>

This patch looks useful. Can we revisit this and get it merged?

>Date:   Fri, 21 Jan 2022 12:12:56 +0800
>From:   Li Chen <lchen.firstlove@zohomail.com>
>To:     "Bjorn Helgaas" <helgaas@kernel.org>
>Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
>        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
>        "Bjorn Helgaas" <bhelgaas@google.com>,
>        "linux-pci" <linux-pci@vger.kernel.org>,
>        "linux-kernel" <linux-kernel@vger.kernel.org>
>Message-ID: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
>In-Reply-To: 
>Subject: [PATCH v4] PCI: endpoint: Add prefetch BAR support
>MIME-Version: 1.0
>Content-Type: text/plain; charset="UTF-8"
>Content-Transfer-Encoding: 7bit
>Importance: Medium
>User-Agent: Zoho Mail
>X-Mailer: Zoho Mail
>Precedence: bulk
>List-ID: <linux-pci.vger.kernel.org>
>X-Mailing-List: linux-pci@vger.kernel.org
>
>From: Li Chen <lchen@ambarella.com>
>
>Before this commit, epf cannot set BAR to be prefetchable.
>Prefetchable BAR can also help epf device to use bridge's
>prefetch memory window.
>
>Signed-off-by: Li Chen <lchen@ambarella.com>
>---
>Changes in v2:
>Remove Gerrit Change-id
>Changes in v3:
>capitalize "BAR" in the subject and commit log as suggested by Bjorn.
>Changes in v4:
>This patch context doesn't change but resend with my Zoho mail account in that previous
>company mail will contain un-removeable proprietary messages. 
>Add "From:" to the first line of the message body.
>
> drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
> include/linux/pci-epc.h                       | 2 ++
> 2 files changed, 6 insertions(+)
>
>diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>index 90d84d3bc868..96489cfdf58d 100644
>--- a/drivers/pci/endpoint/functions/pci-epf-test.c
>+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>@@ -817,15 +817,19 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
> {
> 	struct pci_epf_bar *epf_bar;
> 	bool bar_fixed_64bit;
>+	bool bar_prefetch;
> 	int i;
> 
> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> 		epf_bar = &epf->bar[i];
> 		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
>+		bar_prefetch = !!(epc_features->bar_prefetch & (1 << i));
> 		if (bar_fixed_64bit)
> 			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> 		if (epc_features->bar_fixed_size[i])
> 			bar_size[i] = epc_features->bar_fixed_size[i];
>+		if (bar_prefetch)
>+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
> 	}
> }
> 
>diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>index a48778e1a4ee..825632d581d0 100644
>--- a/include/linux/pci-epc.h
>+++ b/include/linux/pci-epc.h
>@@ -161,6 +161,7 @@ struct pci_epc {
>  * @msix_capable: indicate if the endpoint function has MSI-X capability
>  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
>  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
>+ * @bar_prefetch: bitmap to indicate prefetchable BARs
>  * @bar_fixed_size: Array specifying the size supported by each BAR
>  * @align: alignment size required for BAR buffer allocation
>  */
>@@ -171,6 +172,7 @@ struct pci_epc_features {
> 	unsigned int	msix_capable : 1;
> 	u8	reserved_bar;
> 	u8	bar_fixed_64bit;
>+	u8	bar_prefetch;
> 	u64	bar_fixed_size[PCI_STD_NUM_BARS];
> 	size_t	align;
> };
>-- 
>2.34.1
>
>
>

