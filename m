Return-Path: <linux-pci+bounces-17131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC19D4601
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 04:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B714F280DEE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442A33F9;
	Thu, 21 Nov 2024 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4nJ+Uda"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A714D6EF
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158010; cv=none; b=Xdh2WceH250sRcL2uHDEZkxxQQ3tNtMjRPuHskk6gGYpChomg7aHmLpZdmWTjXUeUHu+yU6Xk70Bs/kebbRx9kmTg4hoxaaOuACD/IAlWFlC96mZ33GVWAZhahZEIxg7AAacgYnTivDdcKNnFVUEI4ZxPnLWQ6QfnMYywnQmvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158010; c=relaxed/simple;
	bh=f7u6KpkD6hknrvOT9+TyFzo7esUZxDOrkURMpRZHNOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOBYFmiQl1Ham5RUD6NecjHVGpE00Th+QZ+IHN38s5/TW8i46fels/eCnbWO9++58A0vMEYWc6A9P8ih7lYBMxck4iPGj9gLPRP5arx3Mqpz+IkFl/a7undTlT7+v6FS7qs4RsDBIxQPDPj1+vrVhKcOolrJsoBOMN52gG1/LPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4nJ+Uda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2097C4CECD;
	Thu, 21 Nov 2024 03:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732158010;
	bh=f7u6KpkD6hknrvOT9+TyFzo7esUZxDOrkURMpRZHNOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l4nJ+UdaTNHFCVyyrI6Eik6V/f8jc0uvjRdBZ8uEp2A39LVJ0PQo3k8KEYMvTncES
	 ZrmDQNPqxRxFQYqMzGPYACs8yiR0hkU/rTANtv4yBLSY/I4zLdk4YOp5d+e88CEEy+
	 YN/RO21oShcoPdl7NWJgQZezGFDuajAeMiQENAZi43jtsc5Xxq+aX5bbtghE9z6wq5
	 CbnLoPrja4ybp77SGCOtda+RLglYu39HE3yb8TXNeOujEP6hnbLXYDeKx1JmcratHV
	 vLi+EcUm0QFtcGgyBDYDDEpDjWzjGUiOcqZJKaazk7aGLsX+cCIyJvtZfSXA8bxcG4
	 kWC5myZjUIcSw==
Message-ID: <2cb06027-f8d0-4a49-a48c-2f2b649141a7@kernel.org>
Date: Thu, 21 Nov 2024 12:00:08 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:controller/rockchip] BUILD SUCCESS
 592aac418ebdf451fe9b146bc2ca6dfc96921af0
To: Bjorn Helgaas <helgaas@kernel.org>, kernel test robot <lkp@intel.com>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
References: <20241119151925.GA2263235@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241119151925.GA2263235@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/20/24 00:19, Bjorn Helgaas wrote:
> On Mon, Nov 18, 2024 at 12:01:12AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
>> branch HEAD: 592aac418ebdf451fe9b146bc2ca6dfc96921af0  PCI: rockchip-ep: Handle PERST# signal in endpoint mode
> 
>> x86_64                           allyesconfig    clang-19
> 
> How can I reproduce this build?  Do you have a packaged clang-19
> toolchain?
> 
> The x86_64 allyesconfig build succeeded for the robot, but when I
> build on x86_64 with gcc-11.4.0, I get an error:
> 
>   $ gcc -v
>   gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
>   $ git checkout 592aac418ebd
>   $ make allyesconfig
>   $ make drivers/pci/controller/pcie-rockchip-ep.o
>     CC      drivers/pci/controller/pcie-rockchip-ep.o
>   drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration of function ‘irq_set_irq_type’

Using gcc v14.2 here (Fedora 40/41) and never saw this compilation error. Weird.

> 
> irq_set_irq_type() is declared in <linux/irq.h>.  On arm64, where this
> driver is used, <linux/irq.h> is included via this path:
> 
>   linux/pci.h
>     linux/interrupt.h
>       linux/hardirq.h
> 	arch/arm64/include/asm/hardirq.h
> 	  asm-generic/hardirq.h
> 	    linux/irq.h
> 
> but on x86, arch/x86/include/asm/hardirq.h does not include
> asm-generic/hardirq.h and therefore doesn't include <linux/irq.h>.
> 
> I'm confused about why the robot reported a successful build with
> clang-19.  It seems like that should have the same problem I saw with
> gcc, so I'd like to try it manually.
> 
> Bjorn


-- 
Damien Le Moal
Western Digital Research

