Return-Path: <linux-pci+bounces-11308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE1947DC4
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010AE284293
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC742045;
	Mon,  5 Aug 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bTYNpAmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142B2D7B8;
	Mon,  5 Aug 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870909; cv=none; b=HK7/mnW6aH9pLhLx49nmjREL6atoCTDJcNgas9Qzcxkdtp0Swkl+O1U08TdSzkJtW4jepf1tI3JB3xpKBCGXj8WCOh9UIpq3dClqef/tTCbcq/Jz+TMyj+Uh1MQyCd8btHvnAviu4RM4jXfSSokLQ8PpACemmFHFLduvQTGnims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870909; c=relaxed/simple;
	bh=hEjI7G/mwo/RSGMWGSClW9gSqJ6PBG2hmPpL9j/Bz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVAPIPRXEfm4zonh3xlozDttVcLoiOZuOmVNntc2g62NxM9PxfqwhWCTcW241MZESIx9ZlfPeh0FjMd0P4uNg7AvaKNpmsnLfNzDL7Axpo5z+C7vgSqbA4ox4sR/0UST8wZxUAdj4X8l5SkpikfDdj3lThQ/QQQo02o1QnCVSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bTYNpAmF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=odYhL10aGT5OasfIueuuGPU6JgBCgXOLpbIAhkKv+Gc=; b=bTYNpAmFXj2qriAOV+gcbP3foS
	j29RgYDtktjL39ONRllYd6zLpM+3ykUHscEQ1EAbnF+Sm1HOzPBK7p3vBpBVOVoKgL01pfgu0fjCR
	/bVNIU08KPKpBeQk080/vOHWWEWjccfMA1QY+hb37Tq/pwLL89/QWFdb11duOofIspeUZpd8PMuSo
	l5C2lOAzCVXQoc4AQk5DFqspLHiyWXsJrRzgRT78tfvthvuVzzTY+shzcnDPrrjqTUuYwpL1sv0Ra
	UHnysdc4SuHwiyn4gfOeLKMEu7rpoCeu+b7SYWHGNxXrMbpY9XBoN5tOWVzaQBs9/V5tt1XkZWsfY
	PqlyG72A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazQK-00000004O32-27sM;
	Mon, 05 Aug 2024 15:15:00 +0000
Date: Mon, 5 Aug 2024 16:15:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: 412574090@163.com
Cc: corbet@lwn.net, bhelgaas@google.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xiongxin@kylinos.cn, weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH] PCI: limit pci bridge and subsystem speed to 2.5GT/s
Message-ID: <ZrDsdA3-uUJV8VdK@casper.infradead.org>
References: <20240805092010.82986-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805092010.82986-1-412574090@163.com>

On Mon, Aug 05, 2024 at 05:20:10PM +0800, 412574090@163.com wrote:
> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> Add a kernel command-line option 'speed2_5g' to limit pci bridge
> and subsystem devices speed to 2.5GT/s. As a debug method, this
> provide for developer to temporarily slow down PCIe devices for
> verification.

I am opposed to this patch benig merged.  There's no harm to keep it for
your own testing.

