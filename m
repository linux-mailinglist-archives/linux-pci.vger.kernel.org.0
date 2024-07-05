Return-Path: <linux-pci+bounces-9839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC85928930
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 15:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405751F220DE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B435146A8A;
	Fri,  5 Jul 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZt0rp4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27171143C79
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184681; cv=none; b=A4lJfoBJu8OdGXVKCR9I9EK7euhK6lSJ1Y3LV+Q3CpWXewp/ceLN8iMj31M6REof01kP+1RRbyEjqCvMBv4Cur5MDtn6Cv5rGQsjVM9iMbVMUGYS5p0YSxNx20cUjdxhfcs+fk7vP2CiZPBw+9AIezDeNNP6IPPLU8cpnYE3zxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184681; c=relaxed/simple;
	bh=MQohbUMknF8/tbNP3AFN/V98hUaZYrHoeV5tmsK+3K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZIWRCA3P0M3TvTCE8HPsoWi+gFfNrUyh4i9Ynn5AnsM9nmkaQE1nyqDWU1wUDECfAkoT18zwIPt6zqQoG3F+hCZ/2w2YaWaw3SAdbnBJ91amzUpY/9VRmMuA6+CQ6gGP8JzXhJmb3vqyo3He5urv/R279+mjC4x6H2Ns/tYUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZt0rp4D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5EY/pAlLecgVEA6d6dyFF1NIYvua8Cvjg/ByRMRnCpA=; b=cZt0rp4DVdsmOTTClyyGkG6Baf
	u+xPSR4H7rb8Pv5/bmveG2DMJfbdQAWvfiWCpXx73I0bp7ejZVx45nJbLtl+xPIKOnP5jsYE9Kavl
	/BOReA30W4x6T6Hwd62OPF3GEA1CSBZkN0QpOknIkNWOXdi56HxlfsvzmM3mS+bKOZYQeLD8m6Wkn
	mONXN0YYUw7obpa38EFMUbNLFGSAR8UrracQt9vAoK1FyElwAJsA+yYpjsXAjwjftkFxssX1s28xg
	tMfLb55ZVSWWymHyo+aMLIFjOqP/c4gMbzFM5j+9oGI2pQP+xJne5zlrQUycagX0bhGHTT6azSI0z
	XW9TERVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPicB-0000000FzSh-2ErM;
	Fri, 05 Jul 2024 13:04:39 +0000
Date: Fri, 5 Jul 2024 06:04:39 -0700
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
Subject: Re: [PATCH v3 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Message-ID: <ZofvZyzIe_7tH6zZ@infradead.org>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-4-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705125436.26057-4-mariusz.tkaczyk@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +struct dsm_output {
> +	u16 status;
> +	u8 function_specific_err;
> +	u8 vendor_specific_err;
> +	u32 state;
> +} __packed;

This structure is naturally aligned, so no need for the __packed.

Otherwise looks good (or at least as good as something can look while
interacting with the weirdo ACPI interfaces..):

Reviewed-by: Christoph Hellwig <hch@lst.de>

