Return-Path: <linux-pci+bounces-10563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FCA937F17
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E81C1F21A29
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EDDDDF;
	Sat, 20 Jul 2024 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wYSGYUaU"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10A2F5A;
	Sat, 20 Jul 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721455559; cv=none; b=M9Ezk/D+E+F4FWu69C+gTK6gVtbbvswDW0mvreYPgzFphjq9uv12RjombXlwNDYuQvrZSS3+P7+FtE0EfuIZPiaR9Ntn1rpvzc+eMBUPf3116UkVDqWq4T5LkHFs3XdXq09OvnQTyI9UB9w7JaTx21yuZf+jxKdUk14pvR8JFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721455559; c=relaxed/simple;
	bh=SAmjcwt+H0HCe9djoIu0iZu3AnsR25j1fRzonNRbU6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HndUAINjgu60tcp4ORx8KdnWNVdt0ID3UuA6JMVpPso4IPi6vMTnvjYjmsEQPYCRN5mzE4TzFWBjnjNgxELDykKrKMLFzAJDL1aDlqKmoxhZFtv+HZOa7MfQmkd2MrBO3E0Tbxz52zQ0HhWtG+hZA3SorFGVzIiWK+9quVmkmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wYSGYUaU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46K65XoF084039;
	Sat, 20 Jul 2024 01:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721455533;
	bh=IUwJKoer6LWSfyx1dmKm3lX66EAqNMpwJb7CXtHw3CE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wYSGYUaUeU7AzQdBjxcNol0wq5wbpDZiTcJpcd2MaX9opnRNvkQnIbe8G4Jf/e4Ts
	 YfvFs8RFlH7/E3kYq1/5EB3WtNSFxFTH6ed8DzWq5ai+XyMRd4L4pKQvIs7fdml+/1
	 xErX13HL8q6wT3KHkyoIMLsZ9wZE8YHWRuwpf518=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46K65WWq071025
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 20 Jul 2024 01:05:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 20
 Jul 2024 01:05:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 20 Jul 2024 01:05:32 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46K65VJD067154;
	Sat, 20 Jul 2024 01:05:32 -0500
Date: Sat, 20 Jul 2024 11:35:31 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Kishon Vijay Abraham I <kishon@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Niklas Cassel <cassel@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Aleksandr Mishin
	<amishin@t-argos.ru>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: Fix && vs || typo
Message-ID: <dfe47606-1146-4e1e-b349-23a3a60b7629@ti.com>
References: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Jul 19, 2024 at 06:53:26PM -0500, Dan Carpenter wrote:
> This code accidentally uses && where || was intended.  It potentially
> results in a NULL dereference.
> 
> Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thank you for the fix.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

