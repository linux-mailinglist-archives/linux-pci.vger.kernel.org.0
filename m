Return-Path: <linux-pci+bounces-16281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7D9C0EA6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 20:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D3B221DE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15532223A41;
	Thu,  7 Nov 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWCDOtrX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED68223A40;
	Thu,  7 Nov 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006592; cv=none; b=fDGgq97PLtr8YhplyuwOiQQsk9JhR4SyuAxmGPiLPWPZYa2/QEVaJEN9co6lvNoxatbSxXo7A3nVghjWXYsleI1VF6FExu2Kup8+aKBZZ1NoNLRPmiyVjVXvZgDVGbtfkJdEDDiS3okrfMSanOyxKcp7WLFWJVtOSDZAAd1LNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006592; c=relaxed/simple;
	bh=rCxKhzIWnMatzzOprxB++//6KGsASl76HzpyqFpJU3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFJFP55loc4o/Hmi8M4lM0wSKT+U668R4uC6pg3xeDENIRRRll5kocTwAdbh9vUt/LKxF6s4Q3weFRFIs9yaZvnWAdzYRM6SQgpXeiFOEM29tAcV/IZuIMwgQrhRL+CZrig6jx0Or87sHD6cJ7pFHcearyjNAql6IYKPOQjSWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWCDOtrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E5FC4CECC;
	Thu,  7 Nov 2024 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006591;
	bh=rCxKhzIWnMatzzOprxB++//6KGsASl76HzpyqFpJU3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWCDOtrX/q8AzJ4i1Ez6dwUur3rBYfNe9daFcKvWG6Tyf6lfHEXiOPPssQ5o4iO5u
	 36TPtGynrhpweqa9lc87mJGx8Khjrato/OrEakMevVTGaYB1TXs8w22R3cu5R649Mi
	 z1B+HJuv8TvAwwwxvQpfOHfjUjHVlK5hc+ndEFsLFLqUce8HlKddcamgcc2kuV/Fyv
	 KZfqO2tYTQbXVSZewEt5hRksoDRFri3lwFuPllcHIDsXSHfp3VPq8esExFKaPfRAZ9
	 fYKzcAyeDcp1/XevEPnL79nWXFvoQ+WErCOlogWqpQbYEtpSQCK8gLm4kJwY5M6sOO
	 QVG6AUFPrlOLA==
Date: Thu, 7 Nov 2024 11:09:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, "Ariel Almog" <ariela@nvidia.com>, "Aditya
 Prabhune" <aprabhune@nvidia.com>, "Hannes Reinecke" <hare@suse.de>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Arun Easi" <aeasi@marvell.com>,
 "Jonathan Chocron" <jonnyc@amazon.com>, "Bert Kenward"
 <bkenward@solarflare.com>, "Matt Carlson" <mcarlson@broadcom.com>,
 "Kai-Heng Feng" <kai.heng.feng@canonical.com>, "Jean Delvare"
 <jdelvare@suse.de>, "Alex Williamson" <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 2/2] net/mlx5: Enable unprivileged read of PCI VPD
 file
Message-ID: <20241107110949.717e3960@kernel.org>
In-Reply-To: <f551f20b0649b4be3f4c9536e756986665366e46.1731005223.git.leonro@nvidia.com>
References: <cover.1731005223.git.leonro@nvidia.com>
	<f551f20b0649b4be3f4c9536e756986665366e46.1731005223.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 20:56:57 +0200 Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> mlx5 devices are PCIe spec compliant, doesn't expose any sensitive
> information Vital Product Data (VPD) section. In addition, these devices
> are capable to provide an unprivileged read access file exposed by PCI core.

Acked-by: Jakub Kicinski <kuba@kernel.org>

