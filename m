Return-Path: <linux-pci+bounces-5845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4E89B414
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 23:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8C72811EF
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA74204C;
	Sun,  7 Apr 2024 21:28:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91E848E;
	Sun,  7 Apr 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525310; cv=none; b=QH+6Xih95+3VmsEb3Szr3YAXFWm1KIIt4eNFZYXs/+iwXtKJa/v+QX+BFYx7C44UvwcBuR6qCFp2KIOy58X/MHzoUJuGLiKXdfiF3H+OTnGn3v/XwFPq+N5nvvdk38BVHTGpmQZEFZFy0aKjB+lu2UkVCJE+JyxDddNmwENerls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525310; c=relaxed/simple;
	bh=k5M/CSvk/88H2bpt2CNd87p3/5oo8+vxSyFdr9mJmIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTAjTxWzGNPS4JpmMyZgrXbLUbWG1GPSJqMTfDVFnUbgeo09T4PapYIJDtovfYkLkPRD+CNhTYdWOEP9adJWN5euuxWlyp1GlVSUNMofNsI/NHeaui2v0fmbV3Jx03iHhTa9t0XG3RuGayVC3f74M/SXOG51kUqWGq4U2qWBf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id DBB1D100DA1AC;
	Sun,  7 Apr 2024 23:28:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9F0CB517537; Sun,  7 Apr 2024 23:28:24 +0200 (CEST)
Date: Sun, 7 Apr 2024 23:28:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: ppwaskie@kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <ZhMP-NBMb387KD4Y@wunner.de>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407210526.8500-1-ppwaskie@kernel.org>

On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
>  
>  	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
>  	if (rc != AE_OK) {
> -		dev_err(dev, "unable to retrieve _UID\n");
> +		dev_err(dev, "unable to retrieve _UID. Potentially buggy BIOS\n");
>  		return -ENOENT;
>  	}

dev_err(dev, FW_BUG "unable to retrieve _UID\n");
             ^^^^^^

There's a macro for that.

