Return-Path: <linux-pci+bounces-5739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562A898E0B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 20:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A102CB2A5CE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160C131BDA;
	Thu,  4 Apr 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UNUnb+8t"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C6131BDB;
	Thu,  4 Apr 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255727; cv=none; b=hGaY3SP+wLt8pp0AGPlbSkaTvJ1FRQZ9/AJ31eNiZycbCfVvcAlKNvNEdtvbQffqw4eFUWtnGdRazeAl9gQRV+xS9uW3drva5G9PjhdmxjXjdQgHplifCgj/pgBloqKXL6pa+pz/RF2I4TZ79cshSBCU47z43BmyoFG/tNAg7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255727; c=relaxed/simple;
	bh=LRg4128xan5SzH8WDKrOkbb9y0sYcu1ihtUsBO+VVhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuOpg6HQHuPtcIZtVUPE0cpIAO8nRn/1BThmjZTtID3S3ao/j9h4vwv/Ef4Tv+0vOqTvfkLJfGRbtOUtB/G9IV2X1buiYcqaYfddWMDNj+kBzgROlGnO1qCepZIdw2oaUppOXapg9PsBxPOjYVNhkUXh40rMnAR7+VvaLE5TDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UNUnb+8t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SR2j00hel98hxTZ89qkzLQdu+DAenXYSnL1mOmaOPtU=; b=UNUnb+8tSWwZBIdS/ZpAupOn9P
	BDXvR9CJ3UBI3C+hWo60HKY8ZqQnsG/B9fOoSOeLUBY6JMdmv+2Y5BtYA1CHZtnNTv4OHwEwhl6mv
	y+ebsSi0Nn2L6dLFe59dauKpDlRzi+sp+OP6FMeVwyu5neKd5uUQWS9bbpZXs4OEaTRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsRvi-00CCzF-S0; Thu, 04 Apr 2024 20:35:18 +0200
Date: Thu, 4 Apr 2024 20:35:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20204f34-eae6-47cd-bac3-540a577595e1@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg7JDL2WOaIf3dxI@nanopsycho>

> OCP, ehm, lets say I have my reservations...
> Okay, what motivation would anyne have to touch the fw of a hardware
> running inside Meta datacenter only? Does not make any sense.
> 
> I'd say come again when your HW is not limited to Meta datacenter.
> For the record and FWIW, I NACK this.

Is ENA used outside of Amazon data centres?

Is FUNGIBLE used outside of Microsoft data centres?

Is gVNIC used outside of Google data centres?

I don't actually know, i'm more of an Embedded developer.

  Andrew


