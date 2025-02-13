Return-Path: <linux-pci+bounces-21389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD588A350E5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787B71890CAD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E0020D50E;
	Thu, 13 Feb 2025 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="talKcyaI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1A20CCE2;
	Thu, 13 Feb 2025 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484295; cv=none; b=K9axs+9X/5ZYP/eFNBq3bH8FJvMfSFMYeiCt7JF2P217YXx2+4hTR9HA1kAwMg/nC1MPyXWgMXo8YMxbSgoIsVkMzZ967JbCv/hMpfCNvLkIs+eAz5t6bzXGosDjY8OJvIqxgTlMkG9iekH8Q0Pl+NELlqwXk+G+oGRygM9VaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484295; c=relaxed/simple;
	bh=1/WveDm/ekbxB+e2hgWNoswGMfH9BEp6P/yKiJf4W30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ESze8nDBaSTpYaysg0Pm+CXByg4k3LI66cV4oolK2XowqDuyqjqMHPtuf/B8zF4ucZJQSchCEdcVrRrLjaiUoeG5fSt9pJzbKxWRIueFygVLDuDpZaNcJrngrCLM1Pyn/3CCiCNbwOG63wbwifPIlB+s9WMnALQ/vyrYn+zkmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=talKcyaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA989C4CED1;
	Thu, 13 Feb 2025 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484295;
	bh=1/WveDm/ekbxB+e2hgWNoswGMfH9BEp6P/yKiJf4W30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=talKcyaIhuIqjTNEjZE/LJL4lAacjN+SrWguhvlv7aYxpZiEg2znEHLgZvJygvpFk
	 iaNUgjNYGHyxc1HYl3ewtpvlmNDrHmYlwCqZFXytRQVgxtDPXlHqX5g74W1MzH3PTX
	 7xNaQCHaSbgPzLovB0fjp/MByTd/XiDzkYBTY6DPh7TdIDmkVz7YL/hRIzOqt7kEnG
	 Ae6TjTTO0rnZpJE9GK2HYgAKwyf9Wd9hH9bCbWvfAirWeZSRXa1msSZdXCk9TeBmT5
	 CC4NbHkEb2TqpwY1f8kWK/QLNnToTzUqKGgASD1ZWBEI9AS33rk9N3SXE3cPXIzrpt
	 PpfdHG9z+E+jg==
Date: Thu, 13 Feb 2025 16:04:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 3/4] PCI: shpchp: Cleanup logging and debug wrappers
Message-ID: <20250213220453.GA135512@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216161012.1774-4-ilpo.jarvinen@linux.intel.com>

On Mon, Dec 16, 2024 at 06:10:11PM +0200, Ilpo Järvinen wrote:
> The shpchp hotplug driver defines logging wrappers ctrl_*() and another
> set of wrappers with generic names which are just duplicates of
> existing generic printk() wrappers. Only the former are useful to
> preserve as they handle the controller dereferencing (the latter are
> also unused).
> 
> The "shpchp_debug" module parameter is used to enable debug logging.
> The generic ability to turn on/off debug prints dynamically covers this
> usecase already so there is no need to module specific debug handling.
> The ctrl_dbg() wrapper also uses a low-level pci_printk() despite
> always using KERN_DEBUG level.

I think it's great to get rid of the module param.  Can you include
a hint about how users of shpchp_debug should now enable debug prints?

The one I have in my notes is to set CONFIG_DYNAMIC_DEBUG=y and boot
with 'dyndbg="file drivers/pci/* +p"'.

> Convert ctrl_dbg() to use the pci_dbg() and remove "shpchp_debug" check
> from it.
> 
> Removing the non-ctrl variants of logging wrappers and "shpchp_debug"
> module parameter as they are no longer used.

> -#define dbg(format, arg...)						\
> -do {									\
> -	if (shpchp_debug)						\
> -		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
> -} while (0)
> -#define err(format, arg...)						\
> -	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
> -#define info(format, arg...)						\
> -	printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
> -#define warn(format, arg...)						\
> -	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)

The above are unused, aren't they?  Can we make a separate patch to
remove these, for ease of describing and reviewing?

Bjorn

