Return-Path: <linux-pci+bounces-30847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F09AEA9BD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5541E564B1D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146321ADB9;
	Thu, 26 Jun 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJXppwaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62D2F1FC9
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977459; cv=none; b=UkGjR4LsA3bTBTL0lBeWBeXLqcVjGxDKbJkn0o5Oj+U2P+gTmMpM0VQYVU9y8FVHYUI0a/lfGwm84MIJKDtw8w69+e5J7Zholcp6v2MD4Qx5OESXBbsWJxyn5Q+wR2HxO9Nu5tG6g3/flJbgiWmtvhxhcXV3GBMuZ+wo70NDa7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977459; c=relaxed/simple;
	bh=TGNCexf2LdZ9XOOwffIQU1tiSWX+PpwAY5oWTyqNKC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHl6yMjXDhwUX6I33lG+JGa0G7LiEFpfLPCSq1/E8Q2H0l6nmzfzrrJg2cx3YSdD8v8OpWQnVuD3KDCrhnY4+zvxDcUAH5j7XniH557/3G4lCPb+LNix9Jy7rpFOnsJKm4zypbBhZEbM/V6np1oVPVimdEmXzehtXAKIcINiVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJXppwaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74CFC4CEEB;
	Thu, 26 Jun 2025 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750977458;
	bh=TGNCexf2LdZ9XOOwffIQU1tiSWX+PpwAY5oWTyqNKC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJXppwaWPdBEi8xb4HiWlANGqBwwAil7RiVweEoDuXWxeWl/cTrnEiHV/NhhIlZ+n
	 Z/+yDijWKIst2Z85S85id8nk/6QQxmCEUhtbUAYi2TCg0jxXB3J9uW0uowXeDgPk+R
	 R2c1Y8KSf+VVMx/kjd3mE8N7TBceGmxPoDMUlvb4D0JTOCcIuhaJiQPjoAoRe+XYw5
	 upZQViCSj4SP2Ug5O56uOnhR2CuG3G+6OhpIqAQRTqTv3klAg+lBmZbLvUYY7H64l8
	 PrINpbguzKYFNUoBbpoXLrvU7/6aG2kEgTYzyh9BGre8SLSuLXBD1YbAdZK7louq4E
	 yX+HiIaqKSqTg==
Date: Thu, 26 Jun 2025 16:37:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Message-ID: <aF3LsDUiRWEMzpn_@kbusch-mbp>
References: <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF04PxJ5WqIA7Je0@wunner.de>
 <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF08kFNy8qrI8LvD@wunner.de>
 <aF1qRv0XlT4EDN-Y@kbusch-mbp>
 <AS4PR07MB85088754E7FC20E462E4A071937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR07MB85088754E7FC20E462E4A071937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>

On Thu, Jun 26, 2025 at 06:16:31PM +0000, Jozef Matejcik (Nokia) wrote:
> Hi Keith, thanks for stepping in. The implementation in drivers/pci/*.c seems to be pretty agnostic to probe_type. I did not find any place where this enum is accessed and some decisions are made based on its value.

You're looking in the wrong place. The different handling for device
probe type happens in base/dd.c, function __driver_attach.

