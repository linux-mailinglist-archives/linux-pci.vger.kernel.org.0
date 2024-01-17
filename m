Return-Path: <linux-pci+bounces-2268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D75830403
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6F1C23F51
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310201C28C;
	Wed, 17 Jan 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RQQGjUrL"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D31DDC9;
	Wed, 17 Jan 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489126; cv=none; b=ZCrFPPQ+gYJotXjz2trA/QgUB/JJHlXMDi8w3Fr60Djk0puhsaCyUPq+qq6tKVbPx68T1wTVwBhhMiUa2Ve0+K52Mwq/WNQLUcwsPs28VRDoiKxP3Vd5ZkUjl7R6UjsO8bKRWTFJT6w3AHu3fV06yTnbQKA37hHkYGCNMZUja5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489126; c=relaxed/simple;
	bh=rqQp4uE6GicuSvLRiYYT8pqnRl3MYBl1/Xk05YKSEiM=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=liN6blQSOTI71W6I8Mr8u3SaqA4XaoQGuX1Nc5FUSfCGf3nj7NYu/iRCLniyzUUWURH0H/j5z/gooim3FPlPefRdMbH4dMvAx3ma1qOwkl2vw097KgC/Du4/jPLVPimv/x6Y+z8D5Zp2SOqAfFpFXyeLdXFF/1a+rMntpptlPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RQQGjUrL; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HAwXIR124543;
	Wed, 17 Jan 2024 04:58:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705489113;
	bh=Fru2H61GUxyYDw7D4NtoctZ/6enUK3Gyr4uPdi0B8n4=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=RQQGjUrLjnEEZHLzjExu40P3QQy2jxWtk/zCZCKniyXYjBOdbd/BqhXMWfNtm/CLE
	 5IBB0eBUXAyKI6JEIk6gVwuVjV/RvnRi81SyoKpkhLBJ2IpyaBz5fiD9EfTEDwytTV
	 XuDGkL8ddsCxkSzHCwl8fnl0bcc2ipTfS6TYmaMk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HAwXDj046782
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 04:58:33 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 04:58:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 04:58:33 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HAwTtZ073889;
	Wed, 17 Jan 2024 04:58:29 -0600
Message-ID: <92ceb1ea-78db-4bc4-af1f-a1690eaca24c@ti.com>
Date: Wed, 17 Jan 2024 16:28:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: ti,j721e-pci-*: Add checks for
 max-link-speed
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-3-s-vadapalli@ti.com>
 <4282b248-cb7f-4486-bde6-105a3aed6be2@linaro.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <4282b248-cb7f-4486-bde6-105a3aed6be2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/01/24 16:05, Krzysztof Kozlowski wrote:
> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>> Extend the existing compatible based checks for validating and enforcing
>> the "max-link-speed" property.
> 
> Based on what? Driver or hardware? Your entire change suggests you

Hardware. The PCIe controller on AM64 SoC supports up to Gen2 link speed while
the PCIe controllers on other SoCs support Gen3 link speed.

> should just drop it from the binding, because this can be deduced from
> compatible.

Could you please clarify? Isn't the addition of the checks for "max-link-speed"
identical to the checks which were added for "num-lanes", both of which are
Hardware specific?

-- 
Regards,
Siddharth.

