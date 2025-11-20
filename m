Return-Path: <linux-pci+bounces-41824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E05C75D48
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0152B2B376
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2229B76F;
	Thu, 20 Nov 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Stn6fK0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D82E7BC0;
	Thu, 20 Nov 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661358; cv=none; b=gGP5sU2ygn8+hmkcnxH2AIdkOAEmc4Lhc7VH33k+kmpeooUyIpHquJBYJQGM++lMfHItbDRtLeoTEiDbfevAnVyW7lzxg3O8dS10vjQZBeKNnmuoanpj006gCkYYWnm9C+ovURIq2eNeNBGsYH/Gg/MTbQLa9GPS1FeY4Gvv+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661358; c=relaxed/simple;
	bh=guC+A2LgeO6j5sCG+rAfLPZ+YznozBmrAF7Ee4gp1KY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDaoHzl2z/2SfzIjzpmBI8fSXq4dMiVx8c9Y35V7WNcrdlpAjRcsb0rjI6Qw4wBIIr04m8WJVd1qyJ2a6Zc0/VNpF1/d6T0kiZvZhqxLiE3s84tF//bRhsXcuqZoWpiVZQNAprUpZkz9ZYZS/Gb7PRCrXQnXBAd9Vm06KxlOtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Stn6fK0h; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HgkY6gq91VjgvoJY8n8L0m4EId8DHSQHvEqBhk4ZC5c=;
	b=Stn6fK0hwM7Dvc5hBoZq+gs3H9132hgvYJ8I/13KnTEkywz77kjpFn4NAh2vDbs7RUQ70FG2p
	7KD5ozdD+0QFEgYhLc1rEdpKcIkMapUttXoLQecQ2k59g2nc0SylZcNPEbNRq+HcjAVlbrPn+xw
	wUdUllbXD7ky6K4DsCFJ1vA=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dC5Zx5HTgzMlQl;
	Fri, 21 Nov 2025 01:54:33 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5bc0lh4zHnGhT;
	Fri, 21 Nov 2025 01:55:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 406FE1402EF;
	Fri, 21 Nov 2025 01:55:43 +0800 (CST)
Received: from localhost (10.48.159.58) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 17:55:42 +0000
Date: Thu, 20 Nov 2025 17:55:40 +0000
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
Subject: Re: [PATCH v2 09/11] coco: guest: arm64: Wire Realm TDISP RUN/STOP
 transitions into guest driver
Message-ID: <20251120175540.00002cf6@huawei.com>
In-Reply-To: <20251117140007.122062-10-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-10-aneesh.kumar@kernel.org>
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

On Mon, 17 Nov 2025 19:30:05 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Teach the Arm CCA guest driver how to transition a Realm device between
> RUN and STOP states. The new helpers issue the RSI START/STOP calls,
> poll with CONTINUE until completion, and surface errors back to the TSM.
> The PCI TSM accept/unlock paths now invoke these helpers so writing `1`
> to `tsm/accept` correctly kicks off the TDISP RUN sequence and unlock
> tears it back down.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

