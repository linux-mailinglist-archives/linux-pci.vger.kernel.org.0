Return-Path: <linux-pci+bounces-24234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52983A6A8A0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734B2882B3E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0D2628C;
	Thu, 20 Mar 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubPHltrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9F1C5D77
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481244; cv=none; b=XqCSp2CnXCB0JOFg7g+BIwq+t0UJgySxImJLDDJjn7cJh6pdA4KQd/u66hEohzjxnwOrAdniBxGDBhf1eu1QRlaY/6ZbP5hOVk3A9LLgJ+s4Vk9UfaJWGb3rKSvk6PRvqXdU9e/MhP54ksyfYqT4rVl3plyjgD8gag5XuYjd6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481244; c=relaxed/simple;
	bh=zau91YAZg62I6lOBrMi1TbIoDsYaYub01b8nsmXVnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iej4SNnWk+Ny2Bb0WMgwTT1tE/idIqGXhcregSbRdkflDnSGRZWtx266NGmLwKwYac23/brtjXF9qq9+CmPjLP+rRTxOyLP/RmOWhUTA24eTo6RpU1VBvQ5ff7HWcqhOg8JVtCs5wkR+/fNPunUxkbKemdWapHqEVanToKjB/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ubPHltrS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8TmSYXEQitYhYRP0cSqhPruzld+Enbb0lowrhhA3RLU=; b=ubPHltrSdF5Cm6hyLc5nonwLHH
	73KofwWtGm8ZNNfYDuWJ/A+hvimDt6Xm5By4sBUr5/4kshDEBejBttXrcD+UU0I1dcaYj6YH+3vta
	NM+zALVWL9+vBttyMNkrsj+2O59c1J1HROjkorglHqkV5AThSG5DV76KFn1EfXEBtA3Xswe6obnTC
	V+5BTjPxbtEFabGfhrLlDLghyD5w/SnqGBchuzCspsYozDyKcubrpvUsTrKKldph9GfiU5lzh5u2d
	eoLarkpqZWF6QeiqkInoGPYljDKZDlePYFI1dS+cMFXmqLFo0kqiDPBoRE2eIpzJPDozVREBR79hD
	9mXqWrdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvGy8-0000000COkS-3Nfr;
	Thu, 20 Mar 2025 14:34:00 +0000
Date: Thu, 20 Mar 2025 07:34:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v4 0/7] Rate limit AER logs
Message-ID: <Z9wnWOeWLHFyMn8q@infradead.org>
References: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 20, 2025 at 01:20:50AM -0700, Jon Pan-Doh wrote:
> Several OCP members 

The fact that some users are part of a borderline illegal purchasing
cartel should not in any way matter for a linux patch submission.
Please work on your commit messages.


