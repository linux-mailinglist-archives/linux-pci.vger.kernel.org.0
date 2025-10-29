Return-Path: <linux-pci+bounces-39717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B17AC1CCD9
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BF3BB3EE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2B3563CE;
	Wed, 29 Oct 2025 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xYv5Piwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79D3002B3;
	Wed, 29 Oct 2025 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763099; cv=none; b=KdvgwqciK4CXg1WgTAHvTOYQcFpiQ2BLCcZHPNFv9UyUTEXmcPUgdg5XRfHn774hI7YnD+qDMJ8hzku+LW/VgKjVjWcuJ+fVvPCI9bdfi1bG0JeydfNISpzZWfYobzFvAVChaXg8j5METKQoAfi9bWJTGThAa8/iw6Xg8MwMlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763099; c=relaxed/simple;
	bh=WZBS1kPjg5laAP3JZJCHY1tx97VeO1NS+zith7dpj3I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz+IxomQ7L5QHoel88pgajGnMrc4EaGkvEufdBkUf0Uya8MHriaAEhqV2fn6G9KTRya+hvXXmAcXDfixvHdtuIGYlTnKN1zYlEpfan0dTFkLV9eQidPUW8YxAF/eu0aERfUBzwL+yBh6chSOVW/bWg8pkTwkxhTwxA2TjKI7VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xYv5Piwp; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wyeaiq6IPH/ky9Bd3tHY7fQvqRuXyY7i5JOjGwSP/ww=;
	b=xYv5Piwp0XzZQc/a5ZGYVtAKCi/xMTvFIobQV6XpXbj5L/dtO9bvRfDrkSSq7SyDigUMQAlS2
	a4PgCf5V/SdTnbj8QT0LrF2FzFJdrAE9U9GihQKXngbCdtDpzZlfkCHih0xoJbqaSSXFCeaTzJj
	hivvz2b0w60IVAwMI4KJYKU=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxbbK3D3Qz1P6n1;
	Thu, 30 Oct 2025 02:38:05 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxbYM2fQkz67kSy;
	Thu, 30 Oct 2025 02:36:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 548A31402EF;
	Thu, 30 Oct 2025 02:38:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 18:38:09 +0000
Date: Wed, 29 Oct 2025 18:38:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 08/12] coco: host: arm64: Instantiate RMM pdev
 during device connect
Message-ID: <20251029183807.00005fbe@huawei.com>
In-Reply-To: <20251027095602.1154418-9-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-9-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:25:58 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> An RMM pdev object represents a communication channel between the RMM
> and a physical device, for example a PCIe device. With the required
> helpers now in place, update the connect callback to create an RMM pdev
> object.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

