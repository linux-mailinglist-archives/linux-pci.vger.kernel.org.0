Return-Path: <linux-pci+bounces-20164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EBDA1728F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F897A20D0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191C1EE010;
	Mon, 20 Jan 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OCRnd11c"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE33186E58;
	Mon, 20 Jan 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396640; cv=none; b=kX2cj9ScqFVIfY+eQFZQItdJFnXJvJscZCJ3o8F/Bsrlx3sRg5UFkfL/vzxSgqysi8QcuzhKjznnz8iqMz/vWMYaMNSczQFc7T8s/3+S2a3EKyRxKeFYpur6K0VA7NP7gww2oRrqr0a47FxlQi0LbqQnk7NKAfBo0yJLmIjBlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396640; c=relaxed/simple;
	bh=HYzvqnIo4R8fR/Wlkoo65bVtLU7K4F0sH66XBcJUEvM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Ch2uRsDpHwBcXSDXAtgvjKDviH6u6+Vmaf3vO6LtdHaYrAtMXdGe0eyQpCx8q8P+0fffwQlihLtOEjEewJtrDKMO2EhS+fYEP6/SjlC13XJ7k/kK8h9/AQlIvCoOFl7rzAUa0HplKMDRZCW3rXjdtVNo4npmqLchPh35BE+sv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=OCRnd11c; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=w7akzjT6JwaP+LN0NAQDdIMHu2t1Pg9d0gDA+Dnyk1Y=; b=OCRnd11cOt8Z69ZtYqTN00e9d1
	RPQnS9OVnAgu9D6p/oQs5MzOW9YQVl2WWGDiWTkdaamL12l1OafunEY9fXA+siadRBsxcYxAiJcJf
	/r6MO934v5R3YF3AGBWX9Q8QjY7PKpbpDGrhgdP6vJsCJGNpjuF/nzmyYbKGlE7uFbCnq8Ru936Hr
	BcNQ26qKsX4iXXPhmuO4/kZP3XRA7329KPOw9azYge1kLY6fwHh+4uF4JGGwa3+EGY8PD8iAtUzJ0
	17adth2+ZoekSOWWYcQVmxb0xM2SI4JHo4F8tG60XAX1aJHPaWSRkYAMK7dQ7BFL3gMPb3sspyJ6p
	fBt0HeVQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1tZvcP-005ngO-13;
	Mon, 20 Jan 2025 10:31:18 -0700
Message-ID: <f0b8792e-06c0-43f1-863d-021d9feac2ca@deltatee.com>
Date: Mon, 20 Jan 2025 10:31:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, kurt.schwemmer@microsemi.com
Cc: unglinuxdriver@microchip.com
References: <20250120095524.243103-1-Saladi.Rakeshbabu@microchip.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250120095524.243103-1-Saladi.Rakeshbabu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Saladi.Rakeshbabu@microchip.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, unglinuxdriver@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: switchtec: Include PCI100X devices support
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-01-20 02:55, Rakesh Babu Saladi wrote:
> Add the Microchip Parts to the existing device ID
> table so that the driver supports PCI100x devices too.
> 
> Add a new macro to quirk the Microchip switchtec PCI100x parts
> to allow DMA access via NTB to work when the IOMMU is turned on.
> 
> PCI100x family has 6 variants, each variant is designed for different
> application usages, different port counts and lane counts.
> 
> PCI1001 has 1 x4 upstream port and 3 x4 downstream ports.
> PCI1002 has 1 x4 upstream port and 4 x2 downstream ports.
> PCI1003 has 2 x4 upstream ports, 2 x2 upstream ports and 2 x2
> downstream ports.
> PCI1004 has 4 x4 upstream ports.
> PCI1005 has 1 x4 upstream port and 6 x2 downstream ports.
> PCI1006 has 6 x2 upstream ports and 2 x2 downstream ports.
> 
> Signed-off-by: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
Looks good to me, thanks!

Acked-By: Logan Gunthorpe <logang@deltatee.com>

Logan

