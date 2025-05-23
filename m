Return-Path: <linux-pci+bounces-28314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1043AC1C7A
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 07:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E017851D
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 05:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D5226541;
	Fri, 23 May 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CsKaf0Aw"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FF222584;
	Fri, 23 May 2025 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978403; cv=none; b=PIkCyXd/d+DHz/9oJlRXKzArZcvnlB5cEm0BsuteYsjuJytJo9Zsea/2t2XypHdl68DXsXmSdkeIhvTF7QPBgZ2hXs6AOTyZ7BpM/9SNBdsUor/yg7x9lcaX0RVGKgeg0nJSiu7diXnheQNX2efAp2pp4hriLVXudJ+fz3e0WXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978403; c=relaxed/simple;
	bh=0B1mE5d6hh55zXmrDVYGoc30+qanDw8Mr9iQY4zYCQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpMI6CDlK/TQmaxgWW4oR31fPIdFtelTe1VHyKusMzgLU7kCnkoNhhtepJOdWdFiTNn7Bju1/sCzfJnfjr8y1Shb3Glo50/YdxjKFd3mJmAPFyfSqiJUjsjLU3a1OkL1scQ8jceZ8gX8aa8VkLT67VEm/GezOEuRJqLmFg7LnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CsKaf0Aw; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54N5WfDw833898;
	Fri, 23 May 2025 00:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747978361;
	bh=EB7rgMEVkNHPNOu5eE3mPD6AxaPnrpq2uXYFS720rCk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CsKaf0AwywPoU+/W5Pthl4dZP8BJPZm5H8gPOpT8k/DUoIXzz2koUH8cYjriuodT0
	 t4pVdSLU9pAFN0AyZ398wPfeI7g/Gbg//EdA0CuMF2jJt+1GLaVXyH5cTyqmFrbQ5k
	 VLSaDbaqee2M/54LBOndIs+IDf4egJiY2A15wpwE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54N5Wffd4034342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 23 May 2025 00:32:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 May 2025 00:32:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 May 2025 00:32:40 -0500
Received: from localhost (dhcp-10-24-69-136.dhcp.ti.com [10.24.69.136])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54N5WdIF1038466;
	Fri, 23 May 2025 00:32:39 -0500
Date: Fri, 23 May 2025 11:02:38 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Frank Li <Frank.li@nxp.com>
CC: <s-vadapalli@ti.com>, <bhelgaas@google.com>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzk+dt@kernel.org>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robh@kernel.org>, <tony@atomide.com>, <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/1] Revert "ARM: dts: Update pcie ranges for dra7"
Message-ID: <5a8a4f18-d5cc-4fd1-aeda-2e739502e0eb@ti.com>
References: <20250411153454.3258098-1-Frank.Li@nxp.com>
 <aC97HguxSt56BkHa@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aC97HguxSt56BkHa@lizhi-Precision-Tower-5810>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, May 22, 2025 at 03:29:34PM -0400, Frank Li wrote:

Hello Frank,

> On Fri, Apr 11, 2025 at 11:34:54AM -0400, Frank Li wrote:
> > This reverts commit c761028ef5e27f477fe14d2b134164c584fc21ee.
> >
> > The commit being reverted updated the "ranges" property for the sake of
> > readability. However, this change is no longer appropriate due to the
> > following reasons:
> >
> > - On many SoCs, the PCIe parent bus translates CPU addresses to different
> > values before passing them to the PCIe controller.
> > - The reverted commit introduced a fake address translation, which violates
> > the fundamental DTS principle: the device tree should reflect actual
> > hardware behavior.
> >
> > Reverting this change prepares for the cleanup of the driver's
> > cpu_addr_fixup() hook.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> s-vadapalli:
> 
> 	Any update about this patch? it prepare to remove cpu_addr_fixes()!

This patch looks good to me, but I was hoping that Tony Lindgren, who is
the author of the commit being reverted, would provide feedback as well.

Regards,
Siddharth.

