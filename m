Return-Path: <linux-pci+bounces-12153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AF95DBCE
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 07:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A59B2353B
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 05:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156D1509B4;
	Sat, 24 Aug 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cJiIPOll"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32114F9F8;
	Sat, 24 Aug 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476654; cv=none; b=fc+wNYKKIDv5wE571EHEBlCuKoANymZBTnI6ontILSQhhgLs/Ck99mdSCEdTuliRhXLMXJbeu4y0IJKtmNarMfW6BZX/o8TisL8dgrVdu6P3sfI0PmZpJRDh0BiX33jRmuuoWn4+cbl6Dkol7g1kcicC/Ssfyo5B8BhdVHdR7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476654; c=relaxed/simple;
	bh=15V5TgWNq8JrlLg364Fh3kLBQSfkHM5P5gucnou9TbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g25lFRMYI9UkJ55MTXFf4dxuMeVAb/bczG/K7q/NnTgckmsb8CP/yQ6jxKQfVuoWTFiX71H7kz0bx4TmgAhdhpvzNXHllKfXXyGyf2R6T/O8UJBu6+kITrISJ+VTkiKdaVd9DZSrXRGB1bNT7n/OyydJcknVfjVlu7N6EcJTMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJiIPOll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9F6C4AF09;
	Sat, 24 Aug 2024 05:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476654;
	bh=15V5TgWNq8JrlLg364Fh3kLBQSfkHM5P5gucnou9TbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJiIPOllWpbcBPKWmpCXp4TAARO6bG4Ft08uRMJ9xdRq1fEEIYS6RoPW77Jcm3PAs
	 DDN6pM9emsLOdPmm8pQveUN8S/j+evwpHxM8cjPxs0rdQLhmxHu6QvOZ9yDzAPplzj
	 I5lB4pbN+iotdUnvC1/UhntKNpbEodNunQi7HAz8=
Date: Sat, 24 Aug 2024 09:55:11 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 4/5] PCI: Allow Ryzen XHCI controllers into D3cold and
 drop delays
Message-ID: <2024082458-bagful-statue-5377@gregkh>
References: <20240823042508.1057791-1-superm1@kernel.org>
 <20240823042508.1057791-6-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823042508.1057791-6-superm1@kernel.org>

On Thu, Aug 22, 2024 at 11:25:07PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> As the PCI core now has a delay after D3cold exit, the Ryzen XHCI
> controllers that were quirked to not use D3cold and to add a delay
> on D3hot no longer need these quirks.
> 
> Drop both the PCI and XHCI sets of quirks.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

