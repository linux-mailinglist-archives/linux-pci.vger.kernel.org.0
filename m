Return-Path: <linux-pci+bounces-25504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C7A81018
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D9E1B65B1A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390391ADC7D;
	Tue,  8 Apr 2025 15:29:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B798185935
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126142; cv=none; b=WKXFYR/ncnhF/+nWIayRUocbIjnwFgwuiEGUSoR4nr3SeZV91IjGXcOlQ7xFS7Dlnbb2Dr5K1SAhg/J81PFumMOIol23ofZoa08flCUt6kdkFBTE9I/7nZJgCQMK5N02iKbRNC8zJpwnN0BZN+8NYzqQFVlV87WgL02cPAYZeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126142; c=relaxed/simple;
	bh=U2qUsxY/owniltXMFSi+vDO1f58AxkMTNvF/h/JTJgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXYUlWvMUg9rLdg4w303WxvoKqzm39OBZggAIIpNskneCVAEq6YZBmpdr1zhVjSFJPj1sTb9qrTtcAwJ3yLdlXDef9xf1LDM02XYPTxQqYLSNXxyoC5gB/d08vtJHzHhx+fHB7AZyX/00GRIrKEu0GGG6bTgl6weAQNjGrzr2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 46119200D253;
	Tue,  8 Apr 2025 17:28:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0700F354AA; Tue,  8 Apr 2025 17:28:56 +0200 (CEST)
Date: Tue, 8 Apr 2025 17:28:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Damir Chanyshev <conflict342@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: P2PDMA support status for the sappire rapids+
Message-ID: <Z_VAuOu7lvm5ykNX@wunner.de>
References: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>
 <20250408150623.GA232275@bhelgaas>
 <CAAUwoOg-uUGRcyNx3npvJuA9ZQa=dH+7tzdtKnA1y69kBriyuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUwoOg-uUGRcyNx3npvJuA9ZQa=dH+7tzdtKnA1y69kBriyuw@mail.gmail.com>

On Tue, Apr 08, 2025 at 06:14:55PM +0300, Damir Chanyshev wrote:
> On Tue, Apr 8, 2025 at 6:06???PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > The pci_p2pdma_whitelist[] is only updated when somebody tests a
> > platform and determines that its RC can route peer-to-peer
> > transactions between separate Root Ports.  This routing is not
> > required by the PCIe spec, so we can't assume that all platforms
> > support it.
> 
> For the testing, is simple rdma ping-pong sufficient? Or a more
> specific testing tool?
> Unfortunately I don't have a fancy pcie hardware analyzer.

You should test that performance is satisfactory for you needs.

There are claims that older Intel CPUs have poor p2pdma performance:
https://lore.kernel.org/all/e2c56983-0111-4132-ae17-0095aa33fd2d@deltatee.com/

Thanks,

Lukas

