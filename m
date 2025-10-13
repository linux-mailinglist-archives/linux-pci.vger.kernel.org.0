Return-Path: <linux-pci+bounces-37899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F243DBD37EF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7582E3A1CD2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897372727FE;
	Mon, 13 Oct 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw290XCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D7238D22
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364996; cv=none; b=WS+I3+GvuGH1pSq2GRWk+Y5SkCTkFMjojcePJ/a3xHtBcfSuVqVSNqKFRN1ryue2oHsj3Yi1K2v0iYQkhRPAs0tg0QeOSep0vzF85WkzMV+PSGWU0PfRL09cSiagjqwS1l6siJUEnniRJ1H999r/PZJp/po1jRKzmOkmoCY5Hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364996; c=relaxed/simple;
	bh=4eYDIhwL5zfITY3lWDNtamkTAv4948j+n0s1SB2BGfE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=unhv7y9ra03WZdstv72JpPM05EZgqjOx9SVOWM6o1t16RudsGCxgOorFvdnc91A5l4Uu32/fyYUo6a61ZFi3dfnKfEWRVN/fa852WdcGRm1dk69wpI/ohAiRDQfyUw8SkmlIXFSLcj2j+s+1TjqT44Who0zlWEVKcXySpGqRUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw290XCc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760364995; x=1791900995;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4eYDIhwL5zfITY3lWDNtamkTAv4948j+n0s1SB2BGfE=;
  b=Iw290XCc2rnFlMIABvrC1mJIzkpv2030/Iw407atpFRggOepPfFofMQK
   ZBT7c9I7291XZ4CoWrasLQvNEZ9S0ZM28NgS5+Ph1vyxad/UWGlXUenzu
   3l99IT+lVc96wkm6MW1mjlJ5dFifm8bGslqnzAdNBRsCXZKxJliTP0Dfp
   9mDYQZneFjX+ORM9P19NnN1UfyXwaqygvzsUHOLcYm9RabIth9myieHa/
   FSyGBfUDY6k//08eCbeTagJta1CwCUyN7sPQVqexe7SmIsWezoFOktcGx
   pdfzM57LhdEKBye4yIy8Z6Prr4JSMrSJEwXzIfDBiAl+WznzX9yUM81I5
   Q==;
X-CSE-ConnectionGUID: DtS+FCL1SPWGFmG9BxfCsw==
X-CSE-MsgGUID: NwAZbau4QEavSkQ1Nf0f7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62394780"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62394780"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 07:16:34 -0700
X-CSE-ConnectionGUID: gd5FyWlLTvCqAv38Wnq46g==
X-CSE-MsgGUID: dA7HLYX4RUSEOkzUioXzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="181419209"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 07:16:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 17:16:27 +0300 (EEST)
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de, 
    Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Select SCREEN_INFO
In-Reply-To: <20251013135929.913441-1-superm1@kernel.org>
Message-ID: <f36a943e-73bb-97ce-83bc-56aa0e1b5267@linux.intel.com>
References: <20251013135929.913441-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Oct 2025, Mario Limonciello (AMD) wrote:

> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
> 
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  Add a select for SCREEN_INFO to ensure that the
> VGA arbiter works as intended.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7065a8e5f9b14..c35fed47addd5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -306,6 +306,7 @@ config VGA_ARB
>  	bool "VGA Arbitration" if EXPERT
>  	default y
>  	depends on (PCI && !S390)
> +	select SCREEN_INFO
>  	help
>  	  Some "legacy" VGA devices implemented on PCI typically have the same
>  	  hard-decoded addresses as they did on ISA. When multiple PCI devices

The commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
a screen info check") also changed to #ifdef CONFIG_SCREEN_INFO around the
call, but that now becomes superfluous with this select, no?

Looking into the history of the ifdefs here is quite odd pattern (only 
the last one comes with some explanation but even that is on the vague 
side and fails to remove the actual now unnecessary ifdef :-/):

#if defined(CONFIG_X86) -> #if defined(CONFIG_X86) -> select SCREEN_INFO

Was it intentional to allow building without CONFIG_SCREEN_INFO?

-- 
 i.


