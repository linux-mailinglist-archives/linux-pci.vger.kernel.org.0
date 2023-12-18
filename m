Return-Path: <linux-pci+bounces-1140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E024816A72
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 11:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B293283FA6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060C125B8;
	Mon, 18 Dec 2023 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSKKcTUK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D41171CA
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 10:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35981C433C7;
	Mon, 18 Dec 2023 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702893828;
	bh=lG/bIlcXv/Fi94/zp/r5cbNRdmNcl1/kh8vjWPGkjWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gSKKcTUKUB58LYYXTtRY/rOgEuXyd/lIf3ylNQKdo2VULrPugQTDnanJmr/fergsF
	 wiAtDLTU8EzHRpiJtujBk8ZTeL4hqHT89Ytp/23AZj1yDiXxz5K5T2ws0rau7s8uqV
	 NZgbWHYbcn0/Qu8n7ex4TRLWIa0K6AtlhHPqGHnwq0qJ+DIMfCwV2fUgQt+QRwJGTq
	 iBIpc2ZuZjAleH7uwuHkj/LkE9IV72FP4HH/R6YhFGMpp1Z7rlzBxFUw01EILkMK+k
	 LCivp3qcgtqvZdlbAV0bUoo72eBrVOaSDBua5Vr3m4oWw1tfpd+//tr8VGYRhhjAuZ
	 KLe9v5c2mFgCg==
Message-ID: <7dea655f-86f7-48f9-90f1-3173a585dc71@kernel.org>
Date: Mon, 18 Dec 2023 19:03:45 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: pci_endpoint_test: Use a unique test pattern for
 each BAR
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
References: <20231215105952.1531683-1-nks@flawful.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231215105952.1531683-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/15 19:59, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Use a unique test pattern for each BAR in. This makes it easier to
> detect/debug address translation issues, since a developer can dump
> the backing memory on the EP side, using e.g. devmem, to verify that
> the address translation for each BAR is actually correct.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


