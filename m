Return-Path: <linux-pci+bounces-8779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64174908028
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 02:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E14C1C21099
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557C383;
	Fri, 14 Jun 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7XM9BcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05881F;
	Fri, 14 Jun 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324724; cv=none; b=RgoskZLbJkbYX4f3QZTAuB3cISyBlWm69DSAA0mjT+oOdTMDO//auXL3VVkQpaFMFD2AaGdXSCBsVLlEKVImv8/sB1ovb0NeNPBDRia+qv2sS76TnUbf121TAFzexadNZrDtwvv4Dmmz7ifdkWjamdc4lS8f0B42ESVYMbiPzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324724; c=relaxed/simple;
	bh=MqKN/lTc5FFRSAKb3EksxP9cFnRll3A3BzfK2biNUAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIlm550i/jmQIuRTMagJb5Q/XtoK3IFnHbgi2D5rX36oHokP0t3PCo57ewCruZ3msjjW+DDe9Q3TilNZw5PYRzebEb8KCsjyCI7G3Kr1dgS3+cPdS1xjJZISriwFQtrP5n0I41bjvYfUmpS+qpicDH/OTOZX8ZCVHuowi0FjEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7XM9BcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C5FC2BBFC;
	Fri, 14 Jun 2024 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718324724;
	bh=MqKN/lTc5FFRSAKb3EksxP9cFnRll3A3BzfK2biNUAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I7XM9BcA5h/hTnxIcRlIogW6z9g9dX4jSE1J3yK9hgalW8HKxrrPOTj5G8JzR2Xgy
	 TS++W9NgDgVkVYEBBPJWo9m/xiKpDBCGLpQ45WwyTaQNSm1eNVmgHS0oedGI1WQC4Z
	 bXh0FLaCuGm3S7tN0NNvLZIYETIQN9uAIjBiaIlHyofoiygyxY0G8h6pSkSPAD5SvP
	 pGB81KoDMLQgI0h+5/Kl7tXKoucCOSgwbUeBqCdKooVeE9M+WaM76HyHy1YmvLTDY3
	 zxjuUfrujYjgC7+LMEYWurxPOgGPlgFniN7eHkEiSLZ7DQSwTYV+w3CzpVp9NLU7DD
	 CBEpYQ8kX9k+g==
Date: Thu, 13 Jun 2024 17:25:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/7] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <20240613172522.2535254d@kernel.org>
In-Reply-To: <20240611045217.78529-3-fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:52:12 +0900 FUJITA Tomonori wrote:
> This just adds the scaffolding for an ethernet driver for Tehuti
> Networks TN40xx chips.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Minor notes below

> +TEHUTI TN40XX ETHERNET DRIVER
> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> +L:	netdev@vger.kernel.org
> +S:	Supported

Keep in mind that Supported will soon mean you gotta run a test farm ;)
https://netdev.bots.linux.dev/devices.html


> +MODULE_DEVICE_TABLE(pci, tn40_id_table);
> +MODULE_AUTHOR("Tehuti networks");

I don't see sign-offs from anyone else, so you can either put yourself
as the author or just leave it out. People write code, not corporations.
IOW authorship != copyright.

