Return-Path: <linux-pci+bounces-34214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F79B2AF38
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF58C4E3149
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EB2620C3;
	Mon, 18 Aug 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JtSXwACX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801F21767D
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537543; cv=none; b=cEmyfdQylzy+UTSEfZflDBSHe9BDDybg4lMGcsxTY+NymeK16iAH/ZXqPCIxJZdAsP1dqouv01S+1/V3mtBT2CgXn+vt/aJcFGkSufGa1b1dzVuU5cYUywlS3RXxs0iSKO/XwjSrfruFTuYmYqkrKRYopg1X9hSCwKnOeYk+6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537543; c=relaxed/simple;
	bh=s7WdcctdTp3nMZ9CiHzRqZbDxGdRFDvPjVrCwaAz+co=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=SqGkKk26QDXn43F+VRt/gTTccs+A9R73HdU+WCNa+uqlvUxW4ENghieHGkgQ61E/0EEjnmEPh/bSLL1QS7ivE5y8yXEBCsveu3BN40CDE5YQtWvDGY0DI+iNZn06nnRU9jBJBXWWW0FrWQvBGlBXz83FinDR7eqPaUPBEycDXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JtSXwACX; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250818171900epoutp01e8101e72966b629e54b7f8748dcc90c7~c7BdszKxY1353113531epoutp01f
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:19:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250818171900epoutp01e8101e72966b629e54b7f8748dcc90c7~c7BdszKxY1353113531epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755537540;
	bh=PVAbcWAk2aOq5yy+lLQNEPDOBF4DHImBPvsWHnIPBDw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=JtSXwACXJRyQMkQkfqV42PnpEqSF0oKpqJM5yCiC6+SnGKVr688gcaSBWTPktTkP3
	 aL5+DJDjCRgPZto5QKZT5D41sabpzUrpPVdPXWuA1wPbhHghJAz74uI7ERJ5FxjbXj
	 zZALPwTqrUxYhvRAuzqi4FjMREY8jbogZIhnstTI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250818171858epcas5p3db5238d0bc3abe8892dd1d5310cd10c1~c7BcPDxfv1755617556epcas5p3z;
	Mon, 18 Aug 2025 17:18:58 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c5KFF4J95z2SSKX; Mon, 18 Aug
	2025 17:18:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250818092138epcas5p4fbd973353a8fc583a307a0d70e44469e~c0grPJ0XS2613226132epcas5p4j;
	Mon, 18 Aug 2025 09:21:38 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250818092135epsmtip1df543cb8d0e7ffd41433147419ef4712~c0gojae4r1917919179epsmtip1l;
	Mon, 18 Aug 2025 09:21:35 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20250813230733.GA299608@bhelgaas>
Subject: RE: [PATCH v3 05/12] PCI: exynos: Add resource ops, soc variant and
 device mode
Date: Mon, 18 Aug 2025 14:51:34 +0530
Message-ID: <000c01dc1021$803abad0$80b03070$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ1qeWx2HpfZpij3siYHlZJEM8QdQHmt79NsyW42rA=
Content-Language: en-in
X-CMS-MailID: 20250818092138epcas5p4fbd973353a8fc583a307a0d70e44469e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813230739epcas5p3d0b8e4bfa880874092c185c7e9819e99
References: <CGME20250813230739epcas5p3d0b8e4bfa880874092c185c7e9819e99@epcas5p3.samsung.com>
	<20250813230733.GA299608@bhelgaas>

> > Some resources might differ based on platforms and we need platform
> > specific functions to initialize or alter them. For better code
> > re-usability, making a separate res_ops which will hold all such
> > function pointers or other resource specific data. Include ops like
> >  - init_regulator (initialize the regulator data)
> >  - pcie_irq_handler (interrupt handler for PCIe)
> >  - set_device_mode (set device mode to EP or RC)
> >
> > Some operations maybe specific to certain SoCs and not applicable
> > to others. For such use cases, adding an SoC variant data field
> > which can be used to distinguish between the variants.
> >
> > Some SoCs may have dual-role PCIe controller which can work as
> > RC or EP. Add device_mode to store the role and take decisions
> > accordingly.
> >
> > Make enable/disable of regulator and initialization of IRQ as
> > common functions to be used by all Samsung SoCs.
> 
> As hinted above, this patch ends up being a mixture of several things
> that makes this kind of hard to review.  Separating these into their
> own patches would make it easier.
> 

Will split into multiple patches



