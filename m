Return-Path: <linux-pci+bounces-12135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23DD95D5AB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56B91C21A26
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221CD2D7B8;
	Fri, 23 Aug 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Y1qDawj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F116026A
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439624; cv=none; b=c63FmdZkbBhjodMuXjwoOfhTt5xmTRMWPCv71g+Kjaopl320s3gM/WpY+tFV0DmGOZ+7teYym2x1MjnGhrIZVAaRWaygiZ8OtmYPK9hPMw9yxyowAt0/AeYdvqVtbTcVkRsXxAEVLTHBFpc6lBzGvgCNrg4jM1BTqhvecxXjpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439624; c=relaxed/simple;
	bh=N1nvBZ8+2pAH1w5F8/N3Xdi5BIp9byf37Ug5OBkACJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ont4xvthbvZOGvJYMTvfrMFuYFwy2Iw8x9Bx25yRkPIjXB0ac1Tt68X7n/teMqyVz0q6SwsrUdKtHiztNlsSJAPMNv7/mF7oF9KlU2Rm7ja2WW6EJ5Gg16cu7YtBKtsPVuakij3gzX0aSzBVwT19x6cc4vsJEy0bUzUUIJlbn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Y1qDawj6; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 88ABD28796E; Fri, 23 Aug 2024 20:51:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1724439118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boa5DLUkQoLAdFQvGHhcbL7EeynSF8HEq7+ZLKme5V4=;
	b=Y1qDawj6dL7OLXSuEBycDPp4tr4MefTGgki738g2e4Pla8JVjSQeFtg2V88YA1RFi/Oad7
	8P8v+TEL3ubLGyYoGcdiy+D9KfCU6gem64UmYvEL79leA5cgE7qO6GU7tXwnwX1FTfAWtD
	3UMXJE2GfbniM6TIcgndb6jpTdD+UvY=
Date: Fri, 23 Aug 2024 20:51:58 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Erin_Tsao@wistron.com
Cc: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Re: Issue about PCI physical slot fetch incorrect number
Message-ID: <mj+md-20240823.185024.10254.nikam@ucw.cz>
References: <a600fc09c06d4ca28b045668ad1e63cb@wistron.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a600fc09c06d4ca28b045668ad1e63cb@wistron.com>

Hi!

> This is Erin from Taiwan. I have a question about physical slot number.
> Currently we are working on the PCIE slot number assigning by PCIE switch. In the PCIe slot assignment process, the slot numbers are assigned to bridges first, and then the end devices fetch the slot ID from the bridge in the upper layer.
> 
> I have observed that under our PCIE switch, GPUs will create a bridge before reaching the end device. If GPUs also fetch the slot ID from the upper bridge layer, they may retrieve incorrect values.
> 
> Our GPU will get the physical slot number with number “0”, and show the slot number “0”、”0-1” , etc.
> May I ask
> 
>   1.  Why GPU will fetch the slot number “0”? Is the slot number assigned to GPU related to any register? Or can we set any bit to fetch the right number?
>   2.  Is there any possible for us not to show the physical slot number of GPU?
> 
> I have checked with the code on the git, unfortunately I didn’t obtain any answer.
> It will really be helpful to get the response from you.
> Hope to hear from you soon, thanks in advance.

It's a long long time since I was the maintainer of the PCI layer in the
kernel. Now I maintain just the PCI utilities which display whatever the
kernel tells them.

I am forwarding your question to the linux-pci mailing list where it
hopefully finds a better audience.

				Martin

