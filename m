Return-Path: <linux-pci+bounces-18966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727559FAE1A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9087A19A3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E381A8F6E;
	Mon, 23 Dec 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuHqgJj+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35A166307;
	Mon, 23 Dec 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955549; cv=none; b=f6pWmRIcNV3FJfmZi3cmc+96BU3D3A/0G4c0soTaV4n/LLSLj8f9GpS2iY67CNUtazzi5SdDedCHnHe6jddBtQipe6pSOhRSVR9Uzp1qo6xiKt58yEGHpinK8eE1WUN2KKJ4hqrZhm0eHyV5iM5AvSDrcRUtFptXkgNG+zqKM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955549; c=relaxed/simple;
	bh=e30vzzM7b/2rv4f0iYgnhl37bCQLhfHEPZ3Scyl8qPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE8n/I8UvVDpVOC+MqWXr+Bbe7Wj5VMTfBItQr8hWmY9i1XmQ7iZnDRiESWAS8KCEZy9dMuASBs4kkJcM9KTATN0d+xaWrl1TZILTtKCXXl18je2efEsRU18AD8abx0rkrWNGgIXWoqUA+0haksYehu80NH6J8TJtukZJed/f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuHqgJj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A8EC4CED3;
	Mon, 23 Dec 2024 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734955549;
	bh=e30vzzM7b/2rv4f0iYgnhl37bCQLhfHEPZ3Scyl8qPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuHqgJj+B6woJTFfkd/utLcetirMePw8wzjA0DOhnnvGUvuychiXXw/SXFFnAkZba
	 2rdfsil4V0PJqqXFYRs+LZXC4+YlFDs4CSAVxtkGXQUHI7ZKM3InGaU+mrolaBLHan
	 t2epj3bP9BVhM71bDI5Yt6a7zjE9t+ME+HiF36knlPtMN8efsAmhY5h2vCTW4RqW2N
	 7FFE8t5TehtbWv5O/IgFkeFpRBrm9QCj9PAKO2wuwu7JETc35p6dyTKbtWLNhBuZ4P
	 thN9J8a+eqWFuz7HaGG7gLUQ6U+FLCP8nLQv8NBJ/guOl06n2J7v0aM5BmVMBX0fIT
	 e096H93blej8Q==
Date: Mon, 23 Dec 2024 13:05:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Set reserved BARs for each
 SoCs
Message-ID: <Z2lSGcQCob6_upuT@ryzen>
References: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
 <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>
 <Z2E0EDC3tV76303d@ryzen>
 <56f1a6cf-40ad-4452-bce1-274eb3d124a9@socionext.com>
 <Z2QasXs0c9jQY8RL@x1-carbon>
 <5f978a20-3f28-4282-8688-b05f3a1f21b8@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f978a20-3f28-4282-8688-b05f3a1f21b8@socionext.com>

On Mon, Dec 23, 2024 at 08:51:42PM +0900, Kunihiko Hayashi wrote:
> On 2024/12/19 22:08, Niklas Cassel wrote:
> > On Thu, Dec 19, 2024 at 08:17:50PM +0900, Kunihiko Hayashi wrote:
> > > On 2024/12/17 17:19, Niklas Cassel wrote:

[...]

> On the other hand, some other SoCs might have BAR masks fixed by the DWC
> IP configuration. These BARs will be exposed to the host even if the BAR
> mask is set to 0. However, such case hasn't been upstreamed, so there is
> no need to worry about them now.

The three schemes are:
BARn_SIZING_SCHEME_N =“Fixed Mask” (0)
BARn_SIZING_SCHEME_N =“Programmable Mask” (1)
BARn_SIZING_SCHEME_N =“Resizable BAR” (2)

Considering that the text:
"To disable a BAR (in any of the three schemes), your application can
write ‘0’ to the LSB of the BAR mask register."

says "in any of the three schemes", I would expect writing 0 to BAR_MASK
should disable a BAR, even for a Fixed Mask/Fixed BAR.


Kind regards,
Niklas

