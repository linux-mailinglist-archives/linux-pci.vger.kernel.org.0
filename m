Return-Path: <linux-pci+bounces-21797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E35A3B3A5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4407A20D2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC91C5D5C;
	Wed, 19 Feb 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGybgjcY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D742A93;
	Wed, 19 Feb 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953666; cv=none; b=CTDZjxaK0aK73HNih1gULXabqayfCwrFFySUCpm0fm8rZzSrdniw6D190woV/4lOwEZH0EUIfQgAP1sTLBAkWDykH/XCo6Ne+BqarCjKc/tC7JDjXBWuSypRry3EqA+nR1QtP5H/YO81gSWOAhXxxwGWPQ+ctL93wfoETFsxkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953666; c=relaxed/simple;
	bh=VV7N6ZB/fyV9zsvAt5BCB9AoEE2RqrMjT+1mMpLyALs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvsC29o4Q1JkCYw9KX+Fx82bvWoXIDdmJu0236Ktkf+ogY5YyNZkwbN+PBOMkt+grjCEyD1OUW6QJmoj3aEEUaGcCrkQoTsm7crddxMNYqSs6mZtMrdN0bAuTko3emBITF5uzsTQ2eTtVGNYHbeneouhlT0yPaLReabm+DIhNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGybgjcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A94C4CED1;
	Wed, 19 Feb 2025 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739953665;
	bh=VV7N6ZB/fyV9zsvAt5BCB9AoEE2RqrMjT+1mMpLyALs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGybgjcYk1lgc3b4gkK6E+Bv7LgWDT48wtew5wSswG9+O21j5AWv6Go7GnHbEC2Jk
	 hlbh6HB4m3BwS+DWia/Idqh+bPybJGhRa1xPYb7wXdQV/FH1/QbmhF6auxBxkAXTai
	 OLe8UNun5lykEdwjyfI8Usn9TlUYRpziKMTrDGv0=
Date: Wed, 19 Feb 2025 09:27:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/5] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <2025021934-backache-hamlet-d940@gregkh>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
 <20250204073501.278248-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204073501.278248-2-herve.codina@bootlin.com>

On Tue, Feb 04, 2025 at 08:34:56AM +0100, Herve Codina wrote:
> An of_node can be set to a device using device_set_node().
> This function cannot prevent any of_node and/or fwnode overwrites.
> 
> When adding an of_node on an already present device, the following
> operations need to be done:
> - Attach the of_node if no of_node were already attached
> - Attach the of_node as a fwnode if no fwnode were already attached
> 
> This is the purpose of device_add_of_node().
> device_remove_of_node() reverts the operations done by
> device_add_of_node().
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/base/core.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 63 insertions(+)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

