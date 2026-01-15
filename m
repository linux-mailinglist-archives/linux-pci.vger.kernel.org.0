Return-Path: <linux-pci+bounces-44939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D21D2470B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 13:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4BFC301AFE5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B73939AE;
	Thu, 15 Jan 2026 12:23:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463F395273;
	Thu, 15 Jan 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479835; cv=none; b=sDALUdt34Cz9W50QCDDI1h0hs7y5/Yj+KypzKBZo7SQRm8IXzkfHMXZA6PLDTUCpXbLbqSzFxD6eZVynqf3Pm04+IZM7QhgIkIZDYsflk6f+T4TiI6Ji1rAku+w+zDVryXvoJYhzNxBIL4Ea7jWs2nh+P3WBtKOYRagfg/m6sTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479835; c=relaxed/simple;
	bh=VGb3wJYeCpUCuDberjukZS5Aq79VJ6Iqf43mUsO5CWI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYkPOdTHtqFbXPVvBOXD5M7PXV/9g3c8XMnWY7mgCGzHGk4/uY3AMJo0cBCaBfIckDRD2ZIb8MC9J5o9IRg8vqtPUOCv2pWgXvrBtnzMv5ZNb/7DQrIW+sg0HgcDMUZ1tJmCJZWlfRCKQHCLcK9h2Np+LehQc1iuxhbzLra/hkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsMbB1xDgzJ46cC;
	Thu, 15 Jan 2026 20:23:34 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 846964056B;
	Thu, 15 Jan 2026 20:23:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 12:23:49 +0000
Date: Thu, 15 Jan 2026 12:23:48 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] irqchip/gic-v5: Split IRS probing into OF and
 generic portions
Message-ID: <20260115122348.00005759@huawei.com>
In-Reply-To: <20260115-gicv5-host-acpi-v3-3-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
	<20260115-gicv5-host-acpi-v3-3-c13a9a150388@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 15 Jan 2026 10:50:49 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> Split the IRS driver code into OF specific and generic portions in order
> to pave the way for adding ACPI firmware bindings support.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


