Return-Path: <linux-pci+bounces-6135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C28A1B2D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888552880DE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60A56B9D;
	Thu, 11 Apr 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQ+YzVV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A256B6B;
	Thu, 11 Apr 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850889; cv=none; b=I8qPTi4vhcFj9IxiSf/2kUmQYd7HjG80n/Nm7phYLdY6m+Sq6d8IwGtaSKVOvDrKyf4jk0w6O3l9ii8iHTN6bOdKVmDAigkisgNfQVQ0wJ8VvBUZlIp4jbpQGooJSMM4IN1309SoqCLJFe8bx/fbNvVMBNta5h3AB+Ys4WdRHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850889; c=relaxed/simple;
	bh=egZdJSFExk9BMoCnnuYjtL653GjEjJ21nFYOelvAHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHvdOn5E4vMDonrUc3LPUa4XGeY64kp6vFKrYnLeavYHT8LSrNCXo+3rqCGUfLVqgjno0+Q7eis9I8mkgt7X6nGMVhmAr/SlS/5DSxbVjjaMyz6sqNgI9PGSMzA0tRBeSNdwTRWyoRWtNIdjwPnNjPGF5vw6ujMFQViTN1b2ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nQ+YzVV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D792C072AA;
	Thu, 11 Apr 2024 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712850888;
	bh=egZdJSFExk9BMoCnnuYjtL653GjEjJ21nFYOelvAHUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ+YzVV7d+rOsmnOG1Y6LWVNJlQ8Iame9mpq+cQ0LJ9s6tRY/j+sn/rlRRqgi3djY
	 sf/B1Y0SA7tEejY9guyWMykYiPPB3sSH39lhe8V9uEjApgURk1MCioGIvBA9PLPniG
	 vM3kXlY2sIfTDSadKue2c/ZVexIg5crwvrM86VgI=
Date: Thu, 11 Apr 2024 17:54:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: parker@finest.io
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 1/2] serial: exar: add missing CTI/Exar PCI IDs to
 include/linux/pci_ids.h
Message-ID: <2024041124-blah-obligate-5f6d@gregkh>
References: <cover.1712846025.git.pnewman@connecttech.com>
 <936439b200c810f83076a710eab81acd1e79ec83.1712846025.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <936439b200c810f83076a710eab81acd1e79ec83.1712846025.git.pnewman@connecttech.com>

On Thu, Apr 11, 2024 at 11:29:26AM -0400, parker@finest.io wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> - Added missing CTI serial car PCI IDs
> - Added missing Exar XR17V25X PCI IDs
> - Moved XR17V4358 and XR17V8358 PCI ID defines to pci_ids.h

Did you read the top of the pci_ids.h file?  Don't add new ids there
unless it is going to be needed in multiple files please.

thanks,

greg k-h

