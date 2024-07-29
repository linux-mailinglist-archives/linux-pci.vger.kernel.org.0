Return-Path: <linux-pci+bounces-10928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F9993ED05
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 07:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15993B20C06
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 05:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359F81742;
	Mon, 29 Jul 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CSTGPJ5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76964D;
	Mon, 29 Jul 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722231722; cv=none; b=Z2rbP7V9AU/yV6jf11X+Q+GwgKG1tJ6aPm7c2i+0CytNX1C7eAYmSVgMH1E6rjuIuiQRqccgrAHbYMfqTlBxzQmGx3kb2Uasc984ZYpxc6WRHxi4uH2iO/r3sIuOvt8d3V75vSVsKVEimdAdsjKJhHf4xASSt1JZJ0xKqugZE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722231722; c=relaxed/simple;
	bh=eN97W4AJl8VwFzZID1IWU9r6D2Aa8cVQYiFEoHJTaGk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCMArZn//sKaGfFf0aeJFM83GmCmXJ3XNObn3gRjL6YK6lzY5btyw0UJ7UYRDRteiT/LCpd3dMkWTX+a1a0Q+LNaMTNyBr9gAGEeivke8Rc96CHE7+P+GqplHhjCydrkA9Ur3TO8f1TMtmweOFi6G4DKrVhYqSFWpzjz1Szv4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CSTGPJ5T; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T5fbF3095616;
	Mon, 29 Jul 2024 00:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722231697;
	bh=HgdeL/6Y64GlvcJmJ4VTLd40a0vZOfkawLINOafE49Y=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CSTGPJ5TLaElvSWopyvQ0Y/RwgIR5a7C8rsfEaMPs0LaHBGKFhCitNzB5kbjHYekR
	 UK2jCCO8jtq+qCBg1o8MLiKeoucwXHcSKaceYcRcijTQYvQFMQSXgjLudQU+bU3vPY
	 mXmOJ6LT1E9ui5ernXp0JCtWPhLP/4Q9yboT/I/w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T5fbkO014713
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 00:41:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 00:41:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 00:41:37 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T5faUe046404;
	Mon, 29 Jul 2024 00:41:36 -0500
Date: Mon, 29 Jul 2024 11:11:35 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Lee Jones <lee@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <vigneshr@ti.com>, <kishon@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: mfd: syscon: Add
 ti,j784s4-acspcie-proxy-ctrl compatible
Message-ID: <a640435f-e840-48a8-9cf5-c796c7422070@ti.com>
References: <20240715120936.1150314-1-s-vadapalli@ti.com>
 <20240715120936.1150314-2-s-vadapalli@ti.com>
 <172190301400.925833.12525656543896105526.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172190301400.925833.12525656543896105526.b4-ty@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jul 25, 2024 at 11:23:34AM +0100, Lee Jones wrote:

Hello Lee,

> On Mon, 15 Jul 2024 17:39:34 +0530, Siddharth Vadapalli wrote:
> > The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
> > SoC are used to drive the reference clock to the PCIe Endpoint device via
> > the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
> > obtain the regmap for the ACSPCIE_CTRL register within the System
> > Controller device-tree node in order to enable the PAD IO Buffers.
> > 
> > The Technical Reference Manual for J784S4 SoC with details of the
> > ASCPCIE_CTRL registers is available at:
> > https://www.ti.com/lit/zip/spruj52
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] dt-bindings: mfd: syscon: Add ti,j784s4-acspcie-proxy-ctrl compatible
>       commit: d86ce301dcf715ea2d5147bb013a29f722bf5d0b

I don't see the commit in the MFD tree [1] and Linux-Next. Therefore I
am assuming that this patch was not committed and will be posting the v2
series with this patch included.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next

Regards,
Siddharth.

