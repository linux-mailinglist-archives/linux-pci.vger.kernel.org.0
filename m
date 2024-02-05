Return-Path: <linux-pci+bounces-3117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81AD84A36E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B1E1C247EA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C2664A5;
	Mon,  5 Feb 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ehJ+ZPtO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB416519E;
	Mon,  5 Feb 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159796; cv=none; b=K23TCWiAmHj+nM1vSdjKiMl2QCF0jk/j+mv1oMxvF128EV/mbOEplle6TWuWF7ecP4XS1vbsiju5kItjI9xGvevdYqew8nfMJyBgLfgZ42ru91ljAG+FDznneNi3n+mVFAYSgt59rk6WM7uUB5gu1lFJdmueGwVy6r5tbBKa8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159796; c=relaxed/simple;
	bh=x9UpyMNf9RClykFARyBh7yW+2jrk9h8lZION24rm8nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OngDuJ2DQe7WX2kNq1LK4+XPwwtgkZMRWqJXpz5yHnue4NOY9DjILZpgOKyaVcSHQnyVYQ+Fxj+odn+gVdtiESdeEI5+aV+k3XgGscNt7yEwxrRDD98M31GrBTxHZljAl2Oa5zwSebkfTi9u3LRf6tMjBN7q3A/QcpSkaXYEYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ehJ+ZPtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0948DC43399;
	Mon,  5 Feb 2024 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159796;
	bh=x9UpyMNf9RClykFARyBh7yW+2jrk9h8lZION24rm8nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehJ+ZPtO5PGZ3jQRrxjiJk2kqekmus7WeqlBtY4LLt3cumg0XzSi7HbnCDIT9EaJu
	 XSGeySZ/Fkt7z13Z8JO5Suw5oQ2l7lbSp5BIgrjjZQHa2Lt4jKKVF/YcHnK0S9sUWw
	 mDhDitzNQIFpOJGOxWzIP2vbwGmJ96eyq+Hq4edY=
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

