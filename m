Return-Path: <linux-pci+bounces-16774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A09C9100
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122F9B2F0E0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909DA3FBB3;
	Thu, 14 Nov 2024 16:44:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1F126C03;
	Thu, 14 Nov 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602674; cv=none; b=QTVyCnvEitj5i8Bi7eGkUEoO1v74mKrhDWLlHMlqpllUUARwUvIktaPCtT94ESwW+l56Y4WG80rcoy6ygF/7qQRufTq46gL3TDIonfmKpjjzFOr+iuv5VrO6sa/Vuqk0/0r7oEr/UE4grg0xqyYyfCjdbZ3xrpscVXImifP+Ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602674; c=relaxed/simple;
	bh=yTTebUgilUcScFJvsEz7xDxnwIE2WJs/ED3QOn9Z1oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7I+n0Tlhn+VX5H4yqm5Qax1lAnDMz7r2lEAHUsPbj05lgsikniUzccyP+AZrdb0xdzazxSPcCoxLP327AD58R72jBqv24S4shn9xdQgELZg7uLYoWGM7UeHiHPIDet6FBaYF9fw3PQUhfw4/jw1iGaky7OP0O9hkErLdMLmUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id EBAA82800A273;
	Thu, 14 Nov 2024 17:44:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D2A893C3D3B; Thu, 14 Nov 2024 17:44:22 +0100 (CET)
Date: Thu, 14 Nov 2024 17:44:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
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
Message-ID: <ZzYo5hNkcIjKAZ4i@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113215429.3177981-6-terry.bowman@amd.com>

On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_internal_error(info) && handles_cxl_errors(dev))
> +		cxl_handle_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
> +
>  	pci_dev_put(dev);
>  }

If you just do this at the top of cxl_handle_error()...

	if (!is_internal_error(info))
		return;

...you avoid the need to move is_internal_error() around and the
patch becomes simpler and easier to review.


> The AER service driver supports handling downstream port protocol errors in
> restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> functionality for CXL PCIe ports operating in virtual hierarchy (VH)
> mode.[1]

This is somewhat minor but by convention, patches in the PCI subsystem
adhere to spec language and capitalization, e.g. "Downstream Port"
instead of "downstream port".  Makes it easier to connect the commit
message or code comments to the spec.  So maybe you want to consider
that if/when respinning.

Thanks,

Lukas

