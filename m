Return-Path: <linux-pci+bounces-31414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED4AF7CCC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDCF173821
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA931223715;
	Thu,  3 Jul 2025 15:47:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA32F2E;
	Thu,  3 Jul 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557671; cv=none; b=cHMmGEbmFT0/aDUkHFJGW20bQFIPRCPmQHO0zxSbGawa5MpBtr7Az+SbLbaiwPmjuBPie4+Ek4GZZxlpMBkQSCH0eXCRroqd3JM/nCd9lgcRxRDw7mQpdYiNjKxelJgB/+xFKGg/p+H3gzPoZjAyqRFCLBtzyef4dffHfHtLsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557671; c=relaxed/simple;
	bh=RkiQbv6jcjROw1Dp0k32vk+7Ay6/ZtjNUJJxbO9e8lY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz+4bTmGnnPkluF2T4WgSqIFunl2YacvmSBzmh15zHOyqBSWXvy+4uqJV3VGpVGZOOHhjGKe2vpWyy941mCzKsaQqKzmsUCPhrOy+8VM1sMHTPKNr1VdLsz6s58tvTnu5gTiH3xSX8tFxmF6sSNTRngXFL/ESwNhuMyY5Y90s+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bY1N8715Vz6M4lV;
	Thu,  3 Jul 2025 23:46:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 43813140447;
	Thu,  3 Jul 2025 23:47:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 17:47:45 +0200
Date: Thu, 3 Jul 2025 16:47:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Sascha
 Bischoff" <sascha.bischoff@arm.com>, Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 00/31] Arm GICv5: Host driver implementation
Message-ID: <20250703164743.00004f3e@huawei.com>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)


> ---
> Changes in v7:
> - Added CDDI/CDDIS/CDEN FIELD_PREP(hwirqid) for instruction preparation
> - Fixed IST/DT/ITT L2 size selection logic for 64K PAGE_SIZE

Hi Lorenzo,

I took another look, particularly focused on this aspect and it all looks good to
me.  Thanks for making these last minute changes.

No more RBs from me but that is just down to my lack of confidence that I know my way
around the spec well enough. It's not anything to do with the content of your series!

Thanks

Jonathan


> - Reordered some ITS error paths according to review
> - Link to v6: https://lore.kernel.org/r/20250626-gicv5-host-v6-0-48e046af4642@kernel.org

