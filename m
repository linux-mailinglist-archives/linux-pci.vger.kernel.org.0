Return-Path: <linux-pci+bounces-9838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F692892C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83EA28660B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865D14430E;
	Fri,  5 Jul 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0HYQF6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C293143C79
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184575; cv=none; b=erWxGq93HxclO6m8ySz6Ui1Z7qxLSaJJUu4vKFIEGyKSn/7oJb5WfomsumcgwdnoD0uz69FzMdHghpMiMbCDtzLVnI8fJORJo6oY6spz31tjaXdX3Q4J92gguEzt/Yjcjf/XbeoH3CK3imavfRdil+fvxnnyiG1g431ykhVrQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184575; c=relaxed/simple;
	bh=F36yirndu7fgVXcEVsduvMr79DPSy3weKjC4PqZn7Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtim2U0jiB+iBxu3RXgmlwOAlKrVhJOfZLxQiW3VStBOSb4dTOr3XC/9DsqWNbCOapqeSluWQctr4hNBvC3kOCbP2PNwbP5Gpjq3c4x6p7UdOwUpSbKAelOasbBKPK3xnCikQAVi7sfnDUTu6D+tL+AM5hFuxLTDSCkFmTlR6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X0HYQF6r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZpW7y64yNzA7b1sh0ikUjJd9N9Fjl07a/mgC8bd6eFQ=; b=X0HYQF6rUOy93P/Nqq/1GSHem7
	7hYyYFtGT9ZhZUeWvinv6FkxofrCKOXWlXwzRMpc5NODa+ph+nHQXI+pzEyGpztval0aB7iutMKPj
	HFoYjw4YWXjrrP6IWm3CsV3Uks+MxfIExn/wwM/v4NoVDUbUXSReXYf6LhXNOijG/HkZ33BBXzMiE
	1gBfyfDtNZnjQUTWT4P2KSZ4o+xYh2t2oQN2nPWr+DzA4UxkWHZEaPM/32XkxyPLricTLWrYdk+r2
	JPLkMzwwMq3ZbJ2hOcVQ6vGrBhg5+t0p8VO/0fk6whXsV9uScS3SIRT12Pu4O13zMoNPOoA34hYiw
	jvg25yew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPiaT-0000000FzAi-32rC;
	Fri, 05 Jul 2024 13:02:53 +0000
Date: Fri, 5 Jul 2024 06:02:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zofu_b-vnBDkWsnJ@infradead.org>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#define for_each_indication(ind, inds) \
> +	for (ind = inds; ind->bit; ind++)

I find this more confusing than just seeing the actual for loop in
the two places using it, but that my just be personal preference.

/*
 * Driver has internal list of supported indications. Ideally, driver should not

s/drivers/the driver/ both times?

> +	if (!npem_has_dsm(dev)) {
> +		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> +		if (pos == 0)
> +			return;
> +
> +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> +			return;
> +	} else {
> +		/*
> +		 * OS should use the DSM for LED control if it is available
> +		 * PCI Firmware Spec r3.3 sec 4.7.
> +		 */
> +		return;

If you just did a:

	if (npem_has_dsm(dev))
		return;

we'd save a level of identation for the !dsm case an make the
code a bit easier to read.  Also I think "OS" above should be "The OS".

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

