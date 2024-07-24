Return-Path: <linux-pci+bounces-10740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6E93B6D0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D067F1C216A2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF816DEB6;
	Wed, 24 Jul 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOgJDWw4"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA916D9A6
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846194; cv=none; b=J72a+zAcGaToqAmWnlhuwjpcZcRrqU79msmfeLHDkZ+PMkFmHEVbO8vtRyo+rAqvkFtlN8kygxDdyWC2lApcvU3aIGF3XTSh/RziPb92OCW5+lfNJ88RpjPsIIRgT4eBtxAc7/T8rzFJu9dZ8vcKWY+UIoH7g1BiklGIYnxnOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846194; c=relaxed/simple;
	bh=2eNG5TTZpb5jJwF7GKQh5V7cdavWVsBnOCdWU305yOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Zz8ZifKcl8wZFzkjBgxQz8LNWmvoEfmHtrAXeH0WyM8u2Xm4A/vaE23qAXPAOlP6zgbBIxHQ29qcZilGaAf3ScvTKbLIPKBpyRr4VuLiFilFeCo92jIpAe/NGmnz9G0OAr54tV5Uj9wX2UXn03skRuDEJjfW4WFZwRtZJ10jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HOgJDWw4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ve+K84xSNxeO4ivvNytWeMN5IvxW8DUwiSOEU3u4FQ=; b=HOgJDWw45QC2BBD1oG3llHgdSq
	j0dc64hqktQehbL2AilXDsZ/iouAm2AF6/ZfCMSIoAmhjzCL8l6nBxUm937+X/CJDNF27bBX6jUjV
	zGL74Q98BjMDqHteVRagXUm8IaSd6vjB/5Ke9rU8do0d+lumMSewEixVpXCzadVLf8K/J7foqatll
	felhDjW4zNfnvLyFduD+dowIdtEw9002GlCWtz24jROP5qwyHxSaAYiBkM919oG1KPJzvVzrMRftT
	Ht8nrehhWJMr2n4VkUJf4fouKJarI0WvUpWd4UHG1TId/3z2I0mDanPQBilBKTCAcERQh1Ezlt4Ri
	pTqXzxsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWgql-0000000GDVE-3EvN;
	Wed, 24 Jul 2024 18:36:31 +0000
Date: Wed, 24 Jul 2024 11:36:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com,
	Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream devices
Message-ID: <ZqFJr7Y3Vemjv2SC@infradead.org>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> +#if IS_ENABLED(CONFIG_VMD)
> +/* 
> + * VMD does not support legacy interrupts for downstream devices.
> + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure OS
> + * doesn't try to configure a legacy irq.
> + */

The wording is a bit weird, Linux is the OS normally.  Or is this
about guest OSes in virtualized environments?  Given how VMD bypasses
a lot of boundaries can we even assign individual devices to VFIO?
And if so is that actually safe or should we prohibit it?


