Return-Path: <linux-pci+bounces-383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140188025F6
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C607B280BF5
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC019171A4;
	Sun,  3 Dec 2023 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cECRBRCZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5DC156DC
	for <linux-pci@vger.kernel.org>; Sun,  3 Dec 2023 17:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99154C433C7;
	Sun,  3 Dec 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701624618;
	bh=icVOkA4ZruYQ28o6dqOjvQ4T2dTFZfkpGqbWRS9fM4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cECRBRCZ/rVTGXQpq2pwS5nJ4DfYoHbjJ9HpEt8PSD049rinkl2OMHXLrqCMZj+an
	 aIAT02zRJHE9Q2DkIotcE8ZOrnzx8+ar4+4/iTMwcp9jPCUMWjW8ISIb/4mWtHezn+
	 i7RaxFZixob4q0hSAC9wZXmuLDToEBQR1yVg/p44=
Date: Sun, 3 Dec 2023 18:30:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Wasim Khan <wasim.khan@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <2023120354-expansion-frequency-f991@gregkh>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
 <2023113014-preflight-roundish-d796@gregkh>
 <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203151654.nh4ta7vtzwpwg4ss@skbuf>

On Sun, Dec 03, 2023 at 05:16:54PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 30, 2023 at 11:10:19AM +0000, Greg Kroah-Hartman wrote:
> > > Why would we remove name of the current company and use the name of a
> > > company that doesn't exist any more?
> > 
> > Yes, this seems very odd.  What is the reason for any of this other than
> > marketing?  Kernel code doesn't do marketing :)
> 
> I'm not sure who is doing the marketing; not me, that's for sure.
> The patch that I'm proposing undoes these strange aliases.

Why?  Who did it originally in what commit id and what was wrong with
them then?

thanks,

greg k-h

