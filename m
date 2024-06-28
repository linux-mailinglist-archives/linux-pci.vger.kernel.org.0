Return-Path: <linux-pci+bounces-9397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35791B6F4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 08:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD721C232E2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69B153E22;
	Fri, 28 Jun 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lifJ+5zE"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52603398B;
	Fri, 28 Jun 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555850; cv=none; b=dPTAkbmw8HAmP4Qto5f13Gn1riQqyY+MNsC8tUOLgoT5z492IWaVeBJAYDEFlfzMmER5xYD1BGzebuGfyHtVnRaHRdoiyUVqJYTN+U79WBgopjgYGCgmHfv12BPxfqFC8VElkJ1WlOwT1zc1bGiHzEM2dk3ji2h1UK+4z4pRHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555850; c=relaxed/simple;
	bh=rm4MMpbBJ/hn54FD10qb95oP5206KyDIT9PgzJ3atWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbZbYxp+jsnnSWNjzBS/6wybwq5vSq20P/iIztxyfrOdStIexrdd5H3DVgBxn4GIfljWKh3xrFi6LnyxgvcRtDa1ZS1rHkCuIoU08JRYkAt4j3KKIPlrrbOYMiVZvvd4c6v5+d5upYTDW1QxKQJN1AbMccFnfLIy5zChd+YNNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lifJ+5zE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S6NiHl102190;
	Fri, 28 Jun 2024 01:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719555824;
	bh=JU5C/Dj5jobv9qpppe4bzTs1hc7sfYcJTBUQFu6B0SE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=lifJ+5zEn3LtNiLxnpUn6zfNc0SxapJSnDICZqYqMGo9VQwOBVc/U7ejN4FjIsVN0
	 XSb2H2HwoHkqsaCavRd1qWX1XEEvAGn6ETs2St3UC4g9UUaKTSYN/pj2GpFqGsxvoS
	 4l5r6ka1Ef1afkLBN6oLtsbr9ks0P2t4x6o/A3tI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S6NhT2011026
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 01:23:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 01:23:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 01:23:43 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S6NgKl043714;
	Fri, 28 Jun 2024 01:23:43 -0500
Date: Fri, 28 Jun 2024 11:53:42 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] PCI: keystone: Add workaround for Errata #i2037
 (AM65x SR 1.0)
Message-ID: <7158c241-51f5-4034-8713-d56d8fcaa0f5@ti.com>
References: <e8aee86f-4f4e-47f7-a472-58a7c154ab06@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8aee86f-4f4e-47f7-a472-58a7c154ab06@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Jun 28, 2024 at 08:14:41AM +0200, Jan Kiszka wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
> (SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
> inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
> the bus may corrupt the packet payload and the corrupt data may
> cause associated applications or the processor to hang.
> 
> The workaround for Errata #i2037 is to limit the maximum read
> request size and maximum payload size to 128 bytes. Add workaround
> for Errata #i2037 here. The errata and workaround is applicable
> only to AM65x SR 1.0 and later versions of the silicon will have
> this fixed.
> 
> [1] -> http://www.ti.com/lit/er/sprz452d/sprz452d.pdf

nitpick: The above link redirects to:
https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
So it is still valid, but it might be a good idea to use the updated
link and also update the commit message accordingly:
Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452I_JULY_2018_REVISED_MAY_2023 [1]) ...
The updated link also uses "https" instead of "http" which is better.

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thank you for updating the patch.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

[...]

Regards,
Siddharth.

