Return-Path: <linux-pci+bounces-6804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9CC8B6107
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 20:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6B91C21526
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F6127E2A;
	Mon, 29 Apr 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZhi2Qk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467298614C
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415008; cv=none; b=N87pdOHr7MfuKmIPyHutAl3Ubf3kGiXqrpTLp9Gk6wmvPfwJUYMoGRo9rct2Flw1fPalnizPNsPBfutWK8P7k6535NjeIY2/EhfCxQ9IUfPhQtc/k1JTYnGkjVd7+/cq4VAgh9/h/GVFEPqP5NmHDgqfWj17XtjElQ849VzDG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415008; c=relaxed/simple;
	bh=eDXH6nZ9Ir6v/gZ2C6ESuLyS5IwayRp1gg97uSqIojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABR7tPK2HKJxvraB8VZeBF1qr0tACNSmrgnMFALagt5gNnLxGSPKcsWilrXX4Njs/OOyGcEvWztASzAWzsI7CNRhKOEunn8GqZxTyRzmCy2kg7Qvvh2+aYnZ5b0zA5Fgc3ILDBEcRMoXY+t/SBI/26yD10NLSR42IsTJqkERRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZhi2Qk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3FEC113CD;
	Mon, 29 Apr 2024 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714415007;
	bh=eDXH6nZ9Ir6v/gZ2C6ESuLyS5IwayRp1gg97uSqIojQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZhi2Qk0PQK6gCz3X8SVWBjODcWnhZfjXephWQ1rY5vqgw6aHfbNk2ITRGxn2yOHn
	 yR0H1zWaiOE6wVcW6F8wv7Bv7DcVYuC2mrxBbBMKhFSpsBsDbLGHZ6jxmwj71DnvZX
	 Or352FdWUHTuavmMHLqKLCAfPzfk0SToHy9lwJI+aEufJu/QGYiXl618veKO+vy5ko
	 wiOr12gGQnNx3D1CTbEVe86NYvp4JvT5lFcjLxrqi/T6QI+UwczYAuFu4xIu4gMmYt
	 mFOwFI6QP2iRwVSsLXTI02LOmK0HPfDLQN7QkDX8OoOKRGICw7hmkG8Eazpe6P5iKb
	 X4Haelg0JDD1w==
Received: by pali.im (Postfix)
	id 45C387BA; Mon, 29 Apr 2024 20:23:25 +0200 (CEST)
Date: Mon, 29 Apr 2024 20:23:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/10] PCI: Add generic Conf Type 0/1 helpers
Message-ID: <20240429182325.r2ppmwbiy6zvtwsl@pali>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
User-Agent: NeoMutt/20180716

On Monday 29 April 2024 13:46:23 Ilpo Järvinen wrote:
> This series replaces PCI_CONF1{,_EXT}_ADDRESS() with more generic
> helpers and makes them more widely available by placing the new helpers
> into include/linux/pci.h.

There was a request to move these macros from include/linux/pci.h file
to the driver/pci/pci.h file...

https://lore.kernel.org/linux-pci/20220913211143.GA624473@bhelgaas/

Something was changed that it has to be moved back?

