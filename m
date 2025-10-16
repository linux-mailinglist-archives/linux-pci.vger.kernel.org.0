Return-Path: <linux-pci+bounces-38348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA9BE331A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A504006E5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD631B800;
	Thu, 16 Oct 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKORyzMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F153090D0;
	Thu, 16 Oct 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615684; cv=none; b=Kgb43CZQQZfe+nTOYdEStBRPOQE+vTt4igcl7ilc892zC8KUaTVpIRMaWHcO1QnH+PgDkFLBMKVttuhNszLj5fdAx4X9hH4a4qF1afNIa1fkEuwCTdQ1Q9NLbYBiGz3W4bIawLXv197APi99yPqIzpz+frsL9wHBD6e/nxBFA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615684; c=relaxed/simple;
	bh=R5K6gjYxckr64q8GAE7CkGg327Su9eLC9K5LHFsyno4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXdzwOcIpXN3Joogdf2mx1QW7/if/006YV6iO7RlpsIu6LKjSOYDIKXXUfpiFuKgerSJLYT75Zg1eu6YG9eu9hRgwM6kI6w0ciGspYH891Jg6rtRIsRy52xaz/qLcqx+ekD49gsgSFhw8QQwMUftWL5RLc5zKZlJn1jPBaszeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKORyzMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52F2C4CEF1;
	Thu, 16 Oct 2025 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615684;
	bh=R5K6gjYxckr64q8GAE7CkGg327Su9eLC9K5LHFsyno4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKORyzMlz37CnwE/AsPa7TwOC82iW7gFC91EMw9bX4VbuD2PeuD7xg9o0/pf5fTz7
	 OGW8CAYomuUH5B4T7iM1o+0+BaZcM98k3lJ1NGpdUAs7BdM81EKxvSlKLMoICxpvuY
	 Md+7EiDsto58hPRlFC4JbWi2lBGZS3qmQotx5yek7DU4DpK5j3zwx3VJYUD6gbNsjM
	 p8neDUHULHRzrrBBXiYod3mtCsujy+L2mzYjzRydSbupn2ul4bHfRRMNaEiUUeU/qj
	 aLbFDv+f8gfSfEl88WfSQtPCl05LKVTW/TGSJqdlM85Ag2tSykCRgUtKaDYQmA3k9c
	 x0fPQh1zX//PA==
Date: Thu, 16 Oct 2025 13:54:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, pjw@kernel.org, randolph.sklin@gmail.com,
	tim609@andestech.com, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v6 1/5] PCI: dwc: Allow adjusting the number of ob/ib
 windows in glue driver
Message-ID: <aPDc-yclubiHbUcD@ryzen>
References: <20251003023527.3284787-1-randolph@andestech.com>
 <20251003023527.3284787-2-randolph@andestech.com>
 <aO4bWRqX_4rXud25@ryzen>
 <aPDTJKwmpxolGEyj@swlinux02>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPDTJKwmpxolGEyj@swlinux02>

Hello Randolph,

On Thu, Oct 16, 2025 at 07:12:36PM +0800, Randolph Lin wrote:
> > 
> > Could we please get a better explaination than "satisfy platform-specific
> > constraints" ?
> > 
> 
> Due to this SoC design, only iATU regions with mapped addresses within the
> 32-bits address range need to be programmed. However, this SoC has a design
> limitation in which the maximum region size supported by a single iATU
> entry is restricted to 4 GB, as it is based on a 32-bits address region.
> 
> For most EP devices, we can only define one entry in the "ranges" property
> of the devicetree that maps an address within the 32-bit range,
> as shown below:
> 	ranges = <0x02000000 0x0 0x10000000 0x0 0x10000000 0x0 0xf0000000>;
> 
> For EP devices that require 64-bits address mapping (e.g., GPUs), BAR
> resources cannot be assigned.
> To support such devices, an additional entry for 64-bits address mapping is
> required, as shown below:
> 	ranges = <0x02000000 0x0 0x10000000 0x0 0x10000000 0x0 0xf0000000>,
> 		 <0x43000000 0x1 0x00000000 0x1 0x00000000 0x7 0x00000000>;
> 
> In the current common implementation, all ranges entries are programmed to
> the iATU. However, the size of entry for 64-bit address mapping exceeds the
> maximum region size that a single iATU entry can support. As a result, an
> error is reported during iATU programming, showing that the size of 64-bit
> address entry exceeds the region limit.

Note that each iATU can map up to IATU_LIMIT_ADDR_OFF_OUTBOUND_i +
IATU_UPPR_LIMIT_ADDR_OFF_OUTBOUND_i.

Some DWC controllers have this at 4G, others have this at 8G.

Samuel has submitted a patch to use multiple iATUs to support
a window size larger than the iATU limit of a single iATU:
https://lore.kernel.org/linux-pci/aPDObXsvMoz1OYso@ryzen/T/#m11c3d95215982411d0bbd36940e70122b70ae820

Perhaps this patch could be of use for you too?


Kind regards,
Niklas

