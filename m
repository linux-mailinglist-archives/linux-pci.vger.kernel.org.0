Return-Path: <linux-pci+bounces-17409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098409DA6E2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20D41659C7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEC51F8AE1;
	Wed, 27 Nov 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOMP5H4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D8118FDD0
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707179; cv=none; b=jYNgIuuv9CNkZ5M4jd4UUV4CzEOfnv134F17klKN1E57e5QYh1df2XEK0XvlYyv2XIJjd/Cg5cNgnLRwxaLQnaPaV3k89/dtm48uPzXY41YIP0gK0OcilYtiZ+oRXjZK7jDVrW9yuJcvjMqFzLW25WOV+FmHZdRhPfogIDqWxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707179; c=relaxed/simple;
	bh=kEx8ak7WWxCOxbdIxveHKF/9WNYkoYjdzpp1DbkDnMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToSsJqpSb/MS+xMJJVpShGntQ735U7J2Tf86wUUDFPN33l3mD/G47EPDJpkLvt/1fzwutOtg7nWp6gkkZiENmkLGyoOo14y1FOCV3xRS/Uqlgbk+MwS3pg1KV3K+enuBvuBf9qg+eRmyjfMj3slGLZZQoUwwdBtdKgsopepjKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOMP5H4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1DAC4CECC;
	Wed, 27 Nov 2024 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732707178;
	bh=kEx8ak7WWxCOxbdIxveHKF/9WNYkoYjdzpp1DbkDnMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOMP5H4zXz/8vbh94LkvKhJLRAvJx8p49MQwhPQeF2FxojcGnmy4xbRCVAoAN22DY
	 e6d/q1lgQ2gtQakGXP9o/FNYr0nHxSqCJwsf0KEUFmefsGpDIHwebmtqLL3XSwJchw
	 4aAAa68YWGZyl09J1ymcV2kFfY908YTs3oiUOamg8m3+O1XfD0j0OEmRkccd+mDX4+
	 42YQUFP1Q8arbpRKYGZLHbkfhv+TWa4sOs09+qKS9aAHr56VFIHgeb+wAeLc2y67O9
	 iDAsqFGQIEE03/OZB1c5BSytrsI3ndlbM8xEPluXhIP2tbrfg0bFK3ldfTXE2fQs5I
	 3mzXjZc3PwZgA==
Date: Wed, 27 Nov 2024 12:32:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <Z0cDZrHfU3jlfOgB@ryzen>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241126132020.efpyad6ldvvwfaki@thinkpad>
 <Z0cBFjK1WgSmg6k5@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0cBFjK1WgSmg6k5@ryzen>

On Wed, Nov 27, 2024 at 12:23:02PM +0100, Niklas Cassel wrote:
> 
> Once all EPC drivers have implemented .align_addr(), we could change
> pci-epf-test.c to unconditionally set the CAP_UNALIGNED_ACCESS capability.

...and it would also allow us to get rid of everything related to alignment
in drivers/misc/pci_endpoint_test.c.


Kind regards,
Niklas

