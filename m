Return-Path: <linux-pci+bounces-7655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C9A8C9C08
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73E61C21D83
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28064DA1B;
	Mon, 20 May 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g3O5Mq+L"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980820EB;
	Mon, 20 May 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203866; cv=none; b=ALkH851idkie/29alWcD0/Lgh5EkEd5Nz/DYiOMLFDdqPjV0wF/MKf0jYHKngT1y6Rdg9zplHNhpPMRtgfvyG/c85wTAri3MtKttIXtqDQ34WUtdhNOaStDuLDMv9Hbk5XKJ6+VBpX3p4RMYKl5ojRBy+RuM1mLjrKGXY05p6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203866; c=relaxed/simple;
	bh=Tr8/wwJz4pOtQRmig0+vpz4m6s/lwh1H78YLrzvodNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ4oiY5HeEZwbge6aFAUJV548Qmn3DkohjUV1y+ILCRN1zIC4by7lNwyfDLHhaztLeM8hguwxmtopc7JMtdG+7eQ0faZnEkmn1m+20+NWJwgp1xh1LrlCUvritu65OWrIUdS1iPf6d5v7e+kvkyai6RMAi42kmj0avOctatAhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g3O5Mq+L; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KBGaTh127346;
	Mon, 20 May 2024 06:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716203796;
	bh=DtbotRrxlfh+3BepWZTeI8VdjCOrKh6fu9usGat9L9E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=g3O5Mq+LDVkAiOTfu89f+qA4Hc5CXAw8hwO6CDpVZOWCWTiaPXueaSCSB4aV5yfpo
	 7kuGcJqh/HJywyzhyxgs+Jn/UDIqkdj825k8R7YYhVLHbxsqxQUNfeptJZiZDPQQU8
	 /Iwl/AjrCGfhiuyQLi1IETRhlb3zpxdwUt3cYlao=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KBGahd004860
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 06:16:36 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 06:16:36 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 20 May
 2024 06:16:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 06:16:35 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KBGZ84034645;
	Mon, 20 May 2024 06:16:35 -0500
Date: Mon, 20 May 2024 16:46:34 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Onkarnath <onkarnath.1@samsung.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "yue.wang@Amlogic.com"
	<yue.wang@Amlogic.com>,
        "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "lchuanhua@maxlinear.com"
	<lchuanhua@maxlinear.com>,
        "srikanth.thokala@intel.com"
	<srikanth.thokala@intel.com>,
        "songxiaowei@hisilicon.com"
	<songxiaowei@hisilicon.com>,
        "wangbinghui@hisilicon.com"
	<wangbinghui@hisilicon.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "pali@kernel.org"
	<pali@kernel.org>,
        "toan@os.amperecomputing.com"
	<toan@os.amperecomputing.com>,
        "daire.mcnamara@microchip.com"
	<daire.mcnamara@microchip.com>,
        "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>,
        "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>,
        "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "jdmason@kudzu.us"
	<jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
        "oohall@gmail.com"
	<oohall@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 1/1] PCI : Refactoring error log prints for better
 readability
Message-ID: <e0e28988-9699-4e6c-abb0-30fa2727c2c3@ti.com>
References: <4ec3b167-9324-41d3-a086-74ca001b9042@ti.com>
 <20240517105923.2406246-1-onkarnath.1@samsung.com>
 <CGME20240517105941epcas5p3e8dbb97f19c9553bf9942ad146124806@epcms5p5>
 <20240520104358epcms5p50e00970ef70f66e87ceaaa893fc0ba67@epcms5p5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240520104358epcms5p50e00970ef70f66e87ceaaa893fc0ba67@epcms5p5>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, May 20, 2024 at 04:13:58PM +0530, Onkarnath wrote:
> Hi,
> 
> 

[...]

> 
> >>Similar question as above regarding converting "failed, ret" to
> 
> >>"failed:". Is this a new convention that is expected to be followed,
> 
> >where all errors are supposed to have "failed: %pe", rather than custom
> 
> >statements? Please let me know if this has already been discussed
> 
> >elsewhere.
> 
> 
> Bjorn suggested to make all errors consistent.
> 
> and I thought printing error like below:
> 
> 
> "gpio request failed: -ENOMEM".
> 
> 
> Seems more suitable than
> 
> 
> "gpio request failed, ret (-ENOMEM)".
> 
> 
> If it needs to be changed in other format, please let me know, i will make all
> errors in that format.
> 
> and will share v2.

Thank you for clarifying. It appeared to me that the suggestion was
limited to the %d to %pe conversion. The existing implementation looks
good in that case.

Regards,
Siddharth.

