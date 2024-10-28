Return-Path: <linux-pci+bounces-15472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0729B3845
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDD71C220B4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125231D6DB6;
	Mon, 28 Oct 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYoDfzcB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54921106;
	Mon, 28 Oct 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138043; cv=none; b=Hxx7To1mbcEl4jQ1uMEs3NzWVDjTdPnso7ffri6Mfq1b0Ehrp82AtVVCUUjqz4Fs4vnhtw1w0uDx8sQSObK5uu4oGcYXh84BefH+rPjKZpSY6Lm0FlSqiXGBvyFYSJBfjDAIAvjjcgPnYem+5S9rvizzBUqVK0/hI8+KVHeoq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138043; c=relaxed/simple;
	bh=tP7n/9Oi4mjk/827WtkyKcRSZBNU8iHMVmmG3PaRM20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR9BiIQKRkMPpgbODE1NpAO592pfFsqhTSY7EI9GVH1noG2VvsfU4ruw7U54PgjDRuumGPt85h/Z48gGr36M52RwFjJD5wvUWx74TcYmiddMOsSbXLerLYzbvkIx+ERaLnooZywpQf6A9oPmkgGLqfENg54wAzz9Pkqb7jklE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYoDfzcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C03FC4CEC3;
	Mon, 28 Oct 2024 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730138042;
	bh=tP7n/9Oi4mjk/827WtkyKcRSZBNU8iHMVmmG3PaRM20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYoDfzcBlJ+ARlQCOz8/Ay77/nTGILdimuWkS2561QnzkcuAfDHT52+QcfzKiB0tv
	 yqJU0S0u1v8QhlbwUErcaM8nBPgU+MCIdighMLtBqvBKUK+gIEAPmzt4m37pMo1+sv
	 f7ez6UfbKbrOOwL9+1yo6O6cy9tO/caTAdPp+FzTLiU7oxSMPCkhPE/ndGwuC+tE2D
	 9x/KfcCLYWS1wpSHiiW6INFnoh8a823STgzz/d2VhYZIKzJ/5/dqt2DqwXenpwRURh
	 EguEV4V+LJ2fDxoHqIYtx/wWNhy/ufqySiAGN2BVb2MiVSboegfuWyoiCYJ4WXiDLv
	 MWuvcaT5BmIVw==
Date: Mon, 28 Oct 2024 11:53:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI/sysfs: Use __free() in reset_method_store()
Message-ID: <Zx_Pt2ObNKIS8cu2@kbusch-mbp>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
 <20241028174046.1736-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028174046.1736-3-ilpo.jarvinen@linux.intel.com>

On Mon, Oct 28, 2024 at 07:40:45PM +0200, Ilpo Järvinen wrote:
> @@ -1430,7 +1431,7 @@ static ssize_t reset_method_store(struct device *dev,
>  				  const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	char *options, *tmp_options, *name;
> +	char *tmp_options, *name;
>  	int m, n;
>  	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
>  
> @@ -1445,7 +1446,7 @@ static ssize_t reset_method_store(struct device *dev,
>  		return count;
>  	}
>  
> -	options = kstrndup(buf, count, GFP_KERNEL);
> +	char *options __free(kfree) = kstrndup(buf, count, GFP_KERNEL);

We should avoid mixing declarations with code. Please declare it with
the cleanup attribute at the top like before, and just initialize it to
NULL.

