Return-Path: <linux-pci+bounces-17128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E99D43F1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 23:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F41282ACA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411701B5827;
	Wed, 20 Nov 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drl4n9pw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC188717;
	Wed, 20 Nov 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142078; cv=none; b=R+NyscgSvgHc/ILJUA15flA0cZd0pMvU4Rh8Bpzvtgrg2cBWDkcyP4/NXl1Po1gmGh10siwkkB9lREmTXBixRXpnYJiCJgWGxdLYe8lS+6KoLh+4g3g981e4bldp4ZGtKHdqFz0jRyAonIm3ww6v38AKbXm+ie9z6G0hzPFRz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142078; c=relaxed/simple;
	bh=nZJ0yC27OSYKoh/M06FiEtADKZURX1+kaM8rnVQa7sw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uNPz4H6Tf9OsTVxfZ/ILMUcvj9IS9eU22KsDyIbfPKym47EqipzsJ0NZrS8qaw9ApuHxZ2dIyG7uIy2sabH3RHI0MsEzdAyoYhJmfddUf35witFDl9ydeoT8gkDCC632NgwLLy4x0+HtkmkLq0DVnLvSr03vIoQl1o5rthiRPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drl4n9pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2B2C4CECD;
	Wed, 20 Nov 2024 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732142077;
	bh=nZJ0yC27OSYKoh/M06FiEtADKZURX1+kaM8rnVQa7sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=drl4n9pwNQmlNmDQoMx4MHmMsmb4IR4/EKUaDRiAK7Zm6cu+NVoN/YQxM/v8mfnMP
	 cZsrVlh2K85hvZCAGMn8NJaKaVfcMogRNsJ58MHg8O+vFBQYt0RTbaMDwzEjvMHX1L
	 9L+EVFf5kn/GsoX/Rl54GLwlS19l8EZaoYKb1x3FWEiNtI+0MxwFKsjuROHodv2i0y
	 5Exbh+EqetWuS5xdO8Ba+9h9ggJkHtkrf/ilQBwxFZseG6hu0Hq30zxYOV2hOXhHUG
	 r08+zJwd3lmuyllUlROpfggiNYEUMsoYA4VW+Q6M41rC9uNQAqbMMUCoVoY5Q5O8un
	 95RydiVL0mfzA==
Date: Wed, 20 Nov 2024 16:34:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 11/15] PCI: don't include 'pm_wakeup.h' directly
Message-ID: <20241120223436.GA2358716@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118072917.3853-12-wsa+renesas@sang-engineering.com>

On Mon, Nov 18, 2024 at 08:29:10AM +0100, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I plan to pick this up for v6.14 as soon as the v6.13 merge window
closes.

> ---
>  drivers/pci/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 225a6cd2e9ca..3b1939c9cf46 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -23,7 +23,6 @@
>  #include <linux/string.h>
>  #include <linux/log2.h>
>  #include <linux/logic_pio.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> -- 
> 2.39.2
> 

