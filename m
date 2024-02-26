Return-Path: <linux-pci+bounces-3996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA7866F47
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 10:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0596D1C23126
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735F208A5;
	Mon, 26 Feb 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="n51uo9M+"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D39208A3
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939079; cv=none; b=o7R11xg0HDBOc1u6VdnFKkDmHe7eqL9Vb+hnQVMERwHTLFUdUWMJQybDZPjh1ixE/unoVLBTdL5/mHtmS1zq7K+19Ct0pmSSuXh4PQUdWRajI9wdrLcAnvXa8uCaxA3ppwRD24EKRiNR0TB5PqMSZtdtqk9yKutGMBt5J9LCUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939079; c=relaxed/simple;
	bh=BZV4vTFPC7/YjtNQxCPtXXgoT6OunrFpP24dKAr5WeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luut2iicOnVUpnrrMkhwcQRREubgG4r8L/gfzDqp0LPP52zpIA4PBF64afDmz1VjqpNTeo0RcT48MRlzR58G+ceGR38xzP3Qyh0UpN/ZwuMlExtXonFyApDXWBWCVL7lopEDCU+PoayRXkJv4ODFd0WON0d3WG5+aylG7TzKUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=n51uo9M+; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id AE3FD282CB0; Mon, 26 Feb 2024 10:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708938640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQOyhF3sj8A3WermyqHRw0KL0qksOH19SW11hAJV+L0=;
	b=n51uo9M+4DCxTr2JeQq9+TXyYxLvymW4j0iaH2amG17ugxTvJ4+NOmOiKabuqcAFQeRUlP
	BTJk9oXAf/FzhYttcyp6apVzy38beqj7+g1DHENE2hP7S6zPSk2xQrnZFoecYpU4UzPScx
	blfdKvG3nyUnbTRinp5dZpdYPfS0+6Y=
Date: Mon, 26 Feb 2024 10:10:40 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH pciutils v2 0/2] lspci: Adding TDISP, IDE
Message-ID: <mj+md-20240226.091031.8587.nikam@ucw.cz>
References: <20240226060135.3252162-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226060135.3252162-1-aik@amd.com>

Hello!

> Here is a couple of patches for TDISP/IDE capable PCIe devices.
> IDE enables PCIe link encryption and TDISP enables secure pass-through
> of PCI devices into confidentional virtual machines running under
> Linux KVM on supported hardware.

Thanks, applied.

				Martin

