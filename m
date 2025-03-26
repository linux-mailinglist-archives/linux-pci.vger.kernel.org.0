Return-Path: <linux-pci+bounces-24728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4AA710EF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83803AB72A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD91624C9;
	Wed, 26 Mar 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wHjLVFPi"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072328366;
	Wed, 26 Mar 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972507; cv=none; b=aVAq5VH6tQle4ISyZ+51yiGu4FRCCyCr5VWvmlFNk7GnFX8eJa3X9rP+tp+V6R9dEtGV2PjKEru41XJIMnqfO0zK5P8fqJ1O2sf5Q/Q3sD2812lKmhjcijgHmqV4lw54S3mwWAXBEj3c+joaTrO2BuBMHTLjz7BcAA419OQpxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972507; c=relaxed/simple;
	bh=ZurPlm/pQi9/1zZhx7T2csNJ/sl6/XZXuB7q2m7TWbw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv1nHq+Io/ZSChkWpN4R3kyxwfES+XEzdbNmsDVO1lZR07YFH9mF0mC+9Hyl45aiwO0QMBhB0JA0KiS4tNjqz2KDETj/TbTeqmEkqZCSeD+o5AHnDgAGYgkTBp/+7zWa503lwDSXc07NnFrA5TkBV9k+B+8utdLH+xCTP1o1vZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wHjLVFPi; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52Q71Q0l1465705
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 02:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742972486;
	bh=B31+gj3MwqN7LoN9ERg8P/Z27YfrdG3tWO6mWfVZyCw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wHjLVFPiQphWSE+jvlERGE9uinhReD6JvrZE6zL0ZfQrHAS6J5/GK3yiGGcN3K8nO
	 A0p4Bl5wEL8Y5A+wYypOy2nkLzACUuZDc6v1sSNGBjlKdPFdQIJKQYQsvayHAZ1UMt
	 8ns/kaYVdziTLdYb6RWPsllxR6U+7EJGJiUCPrXo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52Q71QKW081781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 02:01:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 02:01:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 02:01:26 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52Q71P7s002368;
	Wed, 26 Mar 2025 02:01:25 -0500
Date: Wed, 26 Mar 2025 12:31:24 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Bjorn Helgaas
	<helgaas@kernel.org>, <lpieralisi@kernel.org>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <rogerq@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250326070124.boluxjcid4ouszqk@uda0492258>
References: <20250313055519.j3bpvsm6govd5ytk@uda0492258>
 <20250313160215.GA736346@bhelgaas>
 <20250314041705.v5j2fjulol5ywvyq@uda0492258>
 <20250326065447.GC2822343@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326065447.GC2822343@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Mar 26, 2025 at 03:54:47PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > So I guess without this patch, we incorrectly ignore link-down
> > > interrupts on J784S4.  It's good to have a one-sentence motivation
> > > like that somewhere in the commit log that we can pull out and include
> > > in the merge commit log and the pull request.
> > 
> > Yes, we can prepend the following to the existing commit message:
> > "Link down interrupts on J784S4 SoC are missed because..."
> > 
> > resulting in the following updated paragraph in the commit message:
> > Link down interrupts on J784S4 SoC are missed because commit under Fixes
> > assigned the value of 'linkdown_irq_regfield' for the....
> 
> How does this look like?
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/j721e&id=b97b5b8cb603a4ba6b3f7f1b6065fa76e69bdb56
> 
> Let me know if you want any changes.

I will suggest minor changes to the first paragraph of the commit
message resulting in the following paragraph:

Commit under Fixes assigned the value of .linkdown_irq_regfield for the
J784S4 SoC as the "LINK_DOWN" macro corresponding to BIT(1), and as a
result, the Link Down interrupts on J784S4 SoC are missed.

Regards,
Siddharth.

