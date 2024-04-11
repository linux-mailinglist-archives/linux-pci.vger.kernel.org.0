Return-Path: <linux-pci+bounces-6136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD88A1B32
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5451F215E0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F558AB0;
	Thu, 11 Apr 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0S1AwPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2A58ABC;
	Thu, 11 Apr 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850958; cv=none; b=JoGeMHzOjxToDTtBSSTVaZm933CnONQePBz/9qg08IhMBBOeqCiMqheQhA57EpiyU4L2olgRUuX4NMLSorjbxp9tVLVFOqhvn4bYf1Pys9mkHX89wEcrbdLcUb/EuT6te7ZrlJqKE62dFivyIaTxbGA7YD8G61EWYVIUH9JSMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850958; c=relaxed/simple;
	bh=FNDypULQLOQIN5BAJ/sEuXNcYZHkgcTlSvwD6wDdReY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBT0j5UmjNx5o51siL2WozGh0jonj9CZFZa4O791/o5oiM+0oXZVmbn74J5lx/pXQgo3rPhvmVXzZ5Tnf4KOo65UuRm5mnmECSLd9EkRLhQ76+F5/V4UuXY5XmiHr0q92aZ6PVFKZY6j5BrEBlstJ0Lk2WUBUoC692XBM3dTT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0S1AwPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60298C4AF55;
	Thu, 11 Apr 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712850957;
	bh=FNDypULQLOQIN5BAJ/sEuXNcYZHkgcTlSvwD6wDdReY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0S1AwPY31L5PxKgjLdIxxbZC2FLVSjKhAWRlQuLWbRt+X0P4B3oAvPhN78O3e+a+
	 S+92EBxRGXtxH+8DNRt3/Zeph6UxT2GM3LeB8MLiVVgKZkVQbIt+RprVM9h+8re9sf
	 /q7z/CkT3Adq4sijpCX5UVJAAMV+HnRgqU/QbGZY=
Date: Thu, 11 Apr 2024 17:55:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: parker@finest.io
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port
 support to 8250_exar
Message-ID: <2024041147-flogging-straining-910c@gregkh>
References: <cover.1712846025.git.pnewman@connecttech.com>
 <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>

On Thu, Apr 11, 2024 at 11:29:27AM -0400, parker@finest.io wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> This patch adds support for most of Connect Tech's (CTI) PCI/PCIe
> serial cards to the 8250_exar driver.
> 
> Major changes:
>  - Added (optional) board_setup function called once during probe
>  - Added exar_get_nr_ports function
>  - Removed old Connect Tech setup functions
>  - Added new UART family based CTI setup functions
>  - Added PCI IDs entries for Exar XR17V25x and CTI FPGA based cards
>  - Added MPIO functions for configuring/setting a single MPIO
>  - Added support for reading from the Exar EEPROM

When you need to list the different things you did in a single patch,
that's a huge hint it needs to be broken up into smaller, easier to
review, pieces.

> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 1089 +++++++++++++++++++++++++--
>  1 file changed, 1019 insertions(+), 70 deletions(-)

Reviewing 1000 lines of changes at once that does different things,
isn't easy.  Please break this up into smaller,
one-logical-step-at-a-time patches.

thanks,

greg k-h

