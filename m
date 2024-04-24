Return-Path: <linux-pci+bounces-6622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5B8B0830
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E65AB203EF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87F15A484;
	Wed, 24 Apr 2024 11:15:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF511CA9;
	Wed, 24 Apr 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957359; cv=none; b=JZD2wy7v/kmeNbX6016w73UoNeXgA1D34zzdgox2nGIc9zeM+W+K4MeRIuWj22dYz0VeUjh9VIP5N0Cxrrc8kR/4u8r5ipQuEz5Yh+ae8PrFirtsIvE2T0Kn94WTYKjNOBAytv4cWJUvavLlnY4wklI/mzdaWS1CNWcNwPK54/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957359; c=relaxed/simple;
	bh=XINDDeTOGOVVGSigsc0sBkS33iJM5Tcw6vkFg/tl1vU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uOtRrhQNVMe5b8wGpiC0srSTfrvh2QL+llAAxvv4GWPvDSzh5b9QH3gyxQ1J2xFJNYZ0XxnZZZPcK7X6Ui9DcbjmFVm/PkE8Va2wKjbHKhQE2pSY89SdsSevGYkTJre9eKV4RJ/+rH0V2lzCddoD3TjXnhaCinryxZvPl/3wPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A195492009C; Wed, 24 Apr 2024 13:09:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 962BE92009B;
	Wed, 24 Apr 2024 12:09:21 +0100 (BST)
Date: Wed, 24 Apr 2024 12:09:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Use the correct bit in Link Training not
 active check
In-Reply-To: <20240423130820.43824-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2404241207450.9972@angie.orcam.me.uk>
References: <20240423130820.43824-1-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 23 Apr 2024, Ilpo Järvinen wrote:

> v2:
> - Improve commit message
> 
> NOTE: Maciej NAK'ed the v1 of this patch but has since retracted his
> NAK.
> 
> Maciej, if possible, could you please test this with your HW?

 I'll try before the end of this week, thanks for your work in this area.

  Maciej

