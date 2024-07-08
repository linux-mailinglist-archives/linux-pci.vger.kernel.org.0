Return-Path: <linux-pci+bounces-9931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1F92A4A0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BCBB20433
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FD71E515;
	Mon,  8 Jul 2024 14:27:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABA4C9B
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448851; cv=none; b=a0K+/e44s71x9GO9nW021VZpqIioP0qdWO3ExRAWB3/+Mqscwz81OY7p4txpA6AvtbFo/XCvaJN+1SyrlGy0t4bBn+Sc0DPlDJ1rtl+I1p+00hFt1+f1SprkwP1evH3CejKASpIVgIM9ByEMMmX/mxAEe44/qq7rsthEFOYIuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448851; c=relaxed/simple;
	bh=BgXWqSL0pfEp9g25BdETYTpYWFuFM5aPOL+iSU8MQus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9440lX8Rq33NDi+aBJtYF+NXjGhD9EypdQq8s6jnP9dN3KGUmQwN5kU5z5GXzfdpXVgfQXtb4q6eWAv7pc696IuDUUoc6v0bIWcOQDetpc4FvdC5cU2MSWrkvevTqS3uhLTsRkNf+m8fMawmsWtOayiaggEao1FWFRLKypbmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7F5F0100D9438;
	Mon,  8 Jul 2024 16:27:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2A7891F4DF; Mon,  8 Jul 2024 16:27:24 +0200 (CEST)
Date: Mon, 8 Jul 2024 16:27:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zov3TNUKMrBsTBY8@wunner.de>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
 <f318f400-88ef-fe56-dcd5-27434e305d9f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f318f400-88ef-fe56-dcd5-27434e305d9f@linux.intel.com>

On Mon, Jul 08, 2024 at 02:33:34PM +0300, Ilpo Järvinen wrote:
> > +static int npem_set_active_indications(struct npem *npem, u32 inds)
> > +{
> > +	int ctrl, ret, ret_val;
> > +	u32 cc_status;
> > +
> > +	lockdep_assert_held(&npem->lock);
> > +
> > +	/* This bit is always required */
> > +	ctrl = inds | PCI_NPEM_CTRL_ENABLE;
> > +
> > +	ret = npem_write_ctrl(npem, ctrl);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * For the case where a NPEM command has not completed immediately,
> > +	 * it is recommended that software not continuously ???spin??? on polling
> > +	 * the status register, but rather poll under interrupt at a reduced
> > +	 * rate; for example at 10 ms intervals.
> > +	 *
> > +	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
> > +	 * Command Completed"
> > +	 */
> > +	ret = read_poll_timeout(npem_read_reg, ret_val,
> > +				ret_val || (cc_status & PCI_NPEM_STATUS_CC),
> > +				10 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
> > +				PCI_NPEM_STATUS, &cc_status);
> > +	if (ret)
> > +		return ret_val;
> 
> Will this work as intended?
> 
> If ret_val gets set, cond in read_poll_timeout() is true and it returns 0 
> so the return branch is not taken.
> 
> Also, when read_poll_timeout() times out, ret_val might not be non-zero.

Hm, it seems to me that just having two if-clauses should fix that.

+	ret = read_poll_timeout(npem_read_reg, ret_val,
+				ret_val || (cc_status & PCI_NPEM_STATUS_CC),
+				10 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
+				PCI_NPEM_STATUS, &cc_status);
+	if (ret)
+		return ret;
+	if (ret_val)
+		return ret_val;

Does this look correct to you?

Thanks,

Lukas

