Return-Path: <linux-pci+bounces-3119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081284A372
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2E01F2114D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E6657D2;
	Mon,  5 Feb 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eifBx5TA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654FD67C5E;
	Mon,  5 Feb 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159797; cv=none; b=aISON6NoqU9CyH+D2RdC1IcRFT2Gf+l77kXpPy0HxVAj40UgQZF2f8243Kx6f/8eiT926mTYIp1b2VMeG2HPyxC4W1kd6ZTGjaGrjvezEXY/O5C0cWvYy/snhJuGhuy5TIogl0by3HBnQ4GffZZPe2hl3xCJ6wYWQctAxJ8ABoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159797; c=relaxed/simple;
	bh=x9UpyMNf9RClykFARyBh7yW+2jrk9h8lZION24rm8nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjzuoHCBpNa/9F1rrePUw1WKHVju/HwBONqtks/7tENAbe8PWFb4fzbG9fMHbjbJoHvRu0MkhNHkyuKgaLXNMWxyBNtSNfXeEldPY8RaNbp6drjhRHD9Lfy4ALKSu67iAx1A4X7MmaX8l/3qci8aqCzq074FSqms2MScBWXjkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eifBx5TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E400AC43399;
	Mon,  5 Feb 2024 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159797;
	bh=x9UpyMNf9RClykFARyBh7yW+2jrk9h8lZION24rm8nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eifBx5TAl+5l11/Im6QHK1bBK//OlGnKIkFD7OEoSICENVKM0cA4hkiyAB6NH61SJ
	 sFclkz2EeVgtfw3/aRnYr9rUw3/dbDwahe1zzWDsQ2c+RNyBcl3aRcjmmBrXiuk+Cf
	 sTrBBZQhIIo/uOcszcCEUKJ0W2V+IjhRddteftDo=
Date: Mon, 5 Feb 2024 04:47:08 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: endpoint: make pci_epf_bus_type const
Message-ID: <2024020504-unadvised-quizzical-b8c0@gregkh>
References: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>

On Sun, Feb 04, 2024 at 05:28:58PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pci_epf_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

