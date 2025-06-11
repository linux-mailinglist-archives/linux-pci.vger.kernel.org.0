Return-Path: <linux-pci+bounces-29495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1690AD6053
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 22:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7721892039
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CF21E9B28;
	Wed, 11 Jun 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRueTO6Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251221B9D6;
	Wed, 11 Jun 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674800; cv=none; b=aNYc5RuVdYE4FsDfp/t6zaNBeI6ZcA6YbiN81AzQOozFiwf+f8STfJZSADkiKHmv34wxli/wvXBdQof0jlcGJqKnUuWXwq7nK/YJz+z8w2g88CgCU7YeYAqs9z512+cqAB6cRWKS3HQE4TN7QiwJ1/j3hMeSY/hWN63h/2W4sjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674800; c=relaxed/simple;
	bh=2T08UCcQpUVY0iAFqAOkUfeveEoA119qPNfHEDLEWo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PeCUgBOwuziuqJ0dC3nUfBR5iSI/cQj4ymxWCpR1SmBZwjKLVwOuQiyQOsViZs8Kxj6SWQzr/sDJ5Bx2o3N1f0Kzk1hN7tSWINpJfziV6xka1co0QwtLo8aBDN9x48HaJRtNyc3b+NImlQaSwEH3spZuA3AnhGHksXlF/WrMzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRueTO6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB6C4CEEA;
	Wed, 11 Jun 2025 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749674798;
	bh=2T08UCcQpUVY0iAFqAOkUfeveEoA119qPNfHEDLEWo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DRueTO6Y3QQeLiUDcjVMKJpCFLvyX6BsDsleZsyU7rU0QeHaClXni+OGwB1WPMrBT
	 U95v1TByZkkmc1K5WlmsSdivD75I6sDUdKTsZ9xuqJCPA4oY3+s6YVA4fkEJTLK0du
	 EmoXWFNKZxtBabIclCAT/PeugO7zFdt1HaY203wUT5YtbZOwGDTYOmgtHi+Itew+hQ
	 YgelGnD9EFeC3UkcgxKi34SJ6j+W7Nm/gq58T7myjyDLM9B/IHQgpypWtInT+jKWfd
	 P4MeEBGlAthkd6RP26G0n/wjZwSKB2iYeMUnwlslOcE9jtzTGBvu0uBfYjzsBxDJUn
	 qK4iBkG0VU6Pw==
Date: Wed, 11 Jun 2025 15:46:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: bhelgaas@google.com, ngn@ngn.tf, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: hotplug: remove resolved TODO
Message-ID: <20250611204636.GA869752@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611022123.201839-1-trintaeoitogc@gmail.com>

On Tue, Jun 10, 2025 at 11:21:23PM -0300, Guilherme Giacomo Simoes wrote:
> The commit 8ff4574cf73d ("PCI: cpcihp: Remove unused .get_power() and
> .set_power()") and commit 5b036cada481 ("PCI: cpcihp: Remove unused
> struct cpci_hp_controller_ops.hardware_test") is resolved this TODO.
> 
> Remove this obsolete TODO notes.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Applied to pci/misc for v6.17, thanks!

> ---
>  drivers/pci/hotplug/TODO | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
> index 92e6e20e8595..7397374af171 100644
> --- a/drivers/pci/hotplug/TODO
> +++ b/drivers/pci/hotplug/TODO
> @@ -2,10 +2,6 @@ Contributions are solicited in particular to remedy the following issues:
>  
>  cpcihp:
>  
> -* There are no implementations of the ->hardware_test, ->get_power and
> -  ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
> -  introduced?  Can they be removed from the struct?
> -
>  * Returned code from pci_hp_add_bridge() is not checked.
>  
>  cpqphp:
> -- 
> 2.34.1
> 

