Return-Path: <linux-pci+bounces-26528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8510A987FC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DA31B642D0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00C26C3A6;
	Wed, 23 Apr 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+++FiXM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30512BAF7;
	Wed, 23 Apr 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405885; cv=none; b=p/1sdj8b04th0LZ7V04U0Gj3LHluoHmuvSojWSUck8x+kouwioKMDCAmYUF+rR3vJZOnsUGl+QVVM4VGV7MTJIQmy6KVhC2cVnasP30ZTZjFbc8YSHlEOXmuzJfDqDoCG4PLr7Fn42xUd/pndplXZqXWRzJFg+RTOtncIgqp8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405885; c=relaxed/simple;
	bh=Zn1rhX3sBq9a790THaJgA+kJ6YndcCXata6x97D7ano=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bytYTxA4QDf1H58OFy+0iMOlbnV6FFnBPS4FKsVzlJ+WvK1q3+eZy4ZD34Dpszx8caWkop2M/S/r2Ar0pJEwHSe3HBhCIIO6SsS78gW1sQlV6/bjz12STspVZZD4aM3wTChgxg7OmrKvInqMwzDXMey2EL5ciNOv7IT3rOmPi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+++FiXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A64C4CEE2;
	Wed, 23 Apr 2025 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745405884;
	bh=Zn1rhX3sBq9a790THaJgA+kJ6YndcCXata6x97D7ano=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k+++FiXMPt27gKJSDL2IV97tBfO1L0+4O0KKE9vEv8eiS0BCILUu6r5dfvGaSi2Lt
	 7za/BH0efWJUJZ9ONGR5QL1vX5lJCP8AyRHhkwHlbz9oWW/C8G38pBkI/ZTay+hEP6
	 fsEnBxZJZNu9GEmQyDeDqw40RMn3mR+qi3wDwXW15tEBNcE6AuvIb0GqzvbOuwOMA7
	 dxfEWXtjhMAzR77drOxJfWtEbJVMf314OnnnuuX4oUtOHwuPSGjJPTb9L+w1vBKRhb
	 l6DOgztO2MnAB3cInal0xYaFAYGZLOi4td8LzumCxRJZWTbjw/wEfls04v4rt2X4gX
	 LkzJyCLVKAThQ==
Message-ID: <397609a9-bd8d-470a-97f7-05d7b5a0a4ab@kernel.org>
Date: Wed, 23 Apr 2025 19:57:08 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix path for NVMe PCI endpoint target
 driver
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423095643.490495-1-rick.wertenbroek@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250423095643.490495-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 6:56 PM, Rick Wertenbroek wrote:
> The path for the driver points to an non-existant file.
> Update path with the correct file: drivers/nvme/target/pci-epf.c
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

