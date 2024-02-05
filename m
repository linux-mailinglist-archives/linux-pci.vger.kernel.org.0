Return-Path: <linux-pci+bounces-3111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F884A362
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 20:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E1E1C24488
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EE4D10A;
	Mon,  5 Feb 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V2BK15bf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806D633FE;
	Mon,  5 Feb 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159795; cv=none; b=PFIjrJIdnrmLhNmwkCEP6648DiBNujC0S3rphxyhLhkskGEuiC9I70F3ZqgCC78fnks21I9Lr5oyuKt2rDPNmw7WT1hsPQz1vE+ZVzPtNSH1tg/5+83sPX+tCOE5iQsoCvugg+8k1YyTXJl8zIMFhH2bl78uZye29R1ES2hvPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159795; c=relaxed/simple;
	bh=x9UpyMNf9RClykFARyBh7yW+2jrk9h8lZION24rm8nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4Y+14wgxGloqchRYRkJ08ve2+2pxLZblnpWsVuBJ2twItGoUQceYHmP2On5uVGqoUherIWSQQUbG+hpB7RrEa7Xn7zwLNSYApnx+f6n74PORl7pwjaCmO1cC87kS4Mtye6o02rQinv9ACp7JCVoRNJs24PIaNtC+VfnHyUn7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V2BK15bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC3C43390;
	Mon,  5 Feb 2024 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159795;
	bh=x9UpyMNf9RClykFARyBh7yW+2jrk9h8lZION24rm8nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2BK15bfWoizIhVo9InGQm8YPrknjWcEUig3EpaY+6yyLaZEWnoPYB+ORRNQWWMIv
	 Tix9bWnfIsQR2M6wyE83s9ybAzwLXKiP6iTGRA2+7vx0RZLUsxblJQRYb9YRyclkE+
	 K+rTHrQWjcbAuh+JXqJpSvMPAjfxWp2U6fPwbgMc=
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

