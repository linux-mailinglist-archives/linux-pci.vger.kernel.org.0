Return-Path: <linux-pci+bounces-21798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D824A3B3B1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 09:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1551316BC93
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619511C6FE3;
	Wed, 19 Feb 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZr6cDOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF81C5D75;
	Wed, 19 Feb 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953691; cv=none; b=A/5otSxPy8xwFxvP06o+vKNLpRA8xQ24yU7fQLKptP3Nkc3RuVNNhryVBDXEcFFjeJuAZsETURadYhCTg5MfjvaM+7NqmKofFogrgSl8rgipcEyrBkD5PWxF/48Z9y0+EJM6tg2WFM3K60nmBqmvM2RNboU6HN6V1679m0D7/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953691; c=relaxed/simple;
	bh=nAKL2YOj2bm+4jwi+QQb4MHdG+kEqa1ODBgc6/shPqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK1yXyWa6V9MLo0i46X+9488uvBtDhPat6w0LF3d9NM38P4Vwc6Z7iMzBU+rJMAiWV1lxI77FryqvR3gptjlEvtSXxtSSMHk51nk4DefTgX4iDbBP7kzvKzICNyjwkUOAojx2Qnfl1irOsOFZWL37smi5xYqQcFgWX4HQv+Yr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZr6cDOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F573C4CED1;
	Wed, 19 Feb 2025 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739953690;
	bh=nAKL2YOj2bm+4jwi+QQb4MHdG+kEqa1ODBgc6/shPqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZr6cDOxv1coAdlPXqcDgNSOffNMvdzRw91iJbFuGu33BcQYhYPxNay0J5BfGb3Bq
	 dbFXaVW2qlEsSqBF5BJZTRWmI26gwsnUvY98Z+i2KBs3C4xWTI+E3Mdl85loB1sBri
	 RJ5exJemKEu1UaV54RZ2vZz4o0pIt1TxznCHyxgU=
Date: Wed, 19 Feb 2025 09:28:07 +0100
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
Subject: Re: [PATCH v7 0/5] Add support for the PCI host bridge device-tree
 node creation.
Message-ID: <2025021945-width-dime-032a@gregkh>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
 <20250219092448.2e3e8ac3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219092448.2e3e8ac3@bootlin.com>

On Wed, Feb 19, 2025 at 09:24:48AM +0100, Herve Codina wrote:
> Hi Greg, Bjorn,
> 
> 
> I took into account feedback received on v5 and sent the v6 on 01/10/2025.
> I didn't receive any feedback on the v6. In the meantime, the kernel
> v6.14-rc1 has been released. I rebased the v6 and sent the v7 on 12/09/2024.
> 
> Is there something blocking in this series from having feedback or having
> the series applied?

Sorry for the delay, the driver core changes look fine to me, now acked.

I'll defer the pci stuff to Bjorn.

thanks,

greg k-h

