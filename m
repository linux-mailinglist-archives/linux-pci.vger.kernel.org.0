Return-Path: <linux-pci+bounces-27583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA4AB3992
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055EF1895E18
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B82EB1D;
	Mon, 12 May 2025 13:47:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1044A3C;
	Mon, 12 May 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057672; cv=none; b=PLQJK4QNLkBdjF2xAliyhi7AjWgO1+nshew7eafxZn3Z7SQAVvpTOW+iMC1CkgRiMhf2tlXtSw5j1WmycJLhUImwriI0saE/mVRPX59GBKYkYVw3x7qgaWmFzG5o5kVzyKYVTKWQx+8owyXDW1ZFR+CZmv3JBqjWC1frRdhGZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057672; c=relaxed/simple;
	bh=4IQj9akotNnkDKWZJmNne8ic/Eyi64NRX5JEFL6YdbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp3iwR6/FKrTxqBgfUOEnB+5bhY7eoIuIeJBD+5bjMRPEuim0c2+PtM9s39Shi2jYuJu9/bC6SwwHOKBaY48DZSHAxUyDiCY+Sx3qLyXYSsJEM91uCDdnoTxjqmSpJC7l3Zd4JVt/1S+04pFV+0YXSWhcTTa9WZJnVybMqNrk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A71E62C0161A;
	Mon, 12 May 2025 15:47:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F31041F0F21; Mon, 12 May 2025 15:47:40 +0200 (CEST)
Date: Mon, 12 May 2025 15:47:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shawn Anastasio <sanastasio@raptorengineering.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: pciehp: Consolidate code files
Message-ID: <aCH7_J4GE112pyCc@wunner.de>
References: <20250512124531.8937-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512124531.8937-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 12, 2025 at 03:45:28PM +0300, Ilpo Järvinen wrote:
> The code in the pciehp driver is a bit painful to read because of the
> criss-cross calls that cross file boundaries making the split to
> multiple files feel quite artificial.
> 
> Consolidate the code into single pciehp.c. The split files are not
> simply merged as is but the functions are grouped based on
> functionality and order that avoids most forward declarations.
[...]
>  drivers/pci/hotplug/Makefile      |    5 -
>  drivers/pci/hotplug/pciehp.c      | 2151 +++++++++++++++++++++++++++++
>  drivers/pci/hotplug/pciehp.h      |  212 ---
>  drivers/pci/hotplug/pciehp_core.c |  383 -----
>  drivers/pci/hotplug/pciehp_ctrl.c |  445 ------
>  drivers/pci/hotplug/pciehp_hpc.c  | 1123 ---------------
>  drivers/pci/hotplug/pciehp_pci.c  |  141 --
>  7 files changed, 2151 insertions(+), 2309 deletions(-)

Ugh, I understand that the current state is suboptimal to grok the code,
but a single file with 2000+ LoC isn't much better in terms of
maintainability.  I think partitioning the code into separate files
does make sense, just the current (historically grown) structure
can be improved upon.  Let me think what a more logical separation
might look like...

Thanks,

Lukas

