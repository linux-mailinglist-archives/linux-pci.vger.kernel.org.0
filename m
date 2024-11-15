Return-Path: <linux-pci+bounces-16841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572E9CDAE4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F2CB24BB6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D218BC36;
	Fri, 15 Nov 2024 08:51:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CC18C03D;
	Fri, 15 Nov 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660673; cv=none; b=j7Jcjfcx5TiaHgp8Vf2w8LRhGNP4JexR0Jd9tdqdiSTBOjaQkwthIsvSzqvTwUk7AX82zFSKloEKXhDqFdLqe0QxRbzAqxfMdMe7PfeaS0LywzNtRWU2SInTwG430PqYXbbgDzR07DhCasfJbWGxlBLCGNvUqXTYU5y1QREeDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660673; c=relaxed/simple;
	bh=q4CdGek4zZM8hLPqis+Z+vHsJfbvQsA8UIxLU08XOBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvtYlEgAh3NVNrW7K1UdAQWQJ6aQngjWZzr65iYRSrW0JnOi6sZ330hgwrh2WReHD9uIWpI3fAG8Yq2VLrOKQKZV4R6iToFDkV7WYYmj1nEcREwlRcl5D4mgjX706zA41xXeu/7/M+RTpOkSm/IHKi7/4gZ+et29u3k2JkRwuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6165B2800B6CC;
	Fri, 15 Nov 2024 09:51:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4C2103D0547; Fri, 15 Nov 2024 09:51:07 +0100 (CET)
Date: Fri, 15 Nov 2024 09:51:07 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
Message-ID: <ZzcLe3tDPa6TYs1h@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com>
 <ZzYo5hNkcIjKAZ4i@wunner.de>
 <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>

On Thu, Nov 14, 2024 at 12:41:13PM -0600, Bowman, Terry wrote:
> On 11/14/2024 10:44 AM, Lukas Wunner wrote:
> > On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
> > > @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> > >  
> > >  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> > >  {
> > > -	cxl_handle_error(dev, info);
> > > -	pci_aer_handle_error(dev, info);
> > > +	if (is_internal_error(info) && handles_cxl_errors(dev))
> > > +		cxl_handle_error(dev, info);
> > > +	else
> > > +		pci_aer_handle_error(dev, info);
> > > +
> > >  	pci_dev_put(dev);
> > >  }
> > 
> > If you just do this at the top of cxl_handle_error()...
> >
> > 	if (!is_internal_error(info))
> > 		return;
> >
> > ...you avoid the need to move is_internal_error() around and the
> > patch becomes simpler and easier to review.
> 
> If is_internal_error()==0, then pci_aer_handle_error() should be called
> to process the PCIe error.

You're absolutely right, I missed that, sorry for the noise.

Thanks,

Lukas

