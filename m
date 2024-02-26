Return-Path: <linux-pci+bounces-4017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84AB8675D8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E944D1C26D9A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4080C05;
	Mon, 26 Feb 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OinfDMTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44680BFB;
	Mon, 26 Feb 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952306; cv=none; b=PghnLJZplLtILAr2inzcJes6AkwxXChZVYI7nVbzLHn5mDmMIbUekS1vjk2S5onrsaYDguB4nmS5KFz1qGNhWDLLbRqqqGlBv2fv6tZomsn9x57br3BO6PdEH0K9dent6HpH0DhmC0N7uPAtf6LWJibnGq4tusgnus8IMReO4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952306; c=relaxed/simple;
	bh=TYd1QFQIy3LiHRMTeLxXNhm+koA9OdQaPyZaAGwwoHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZXzB32A2kxZMbY8mQeF7clG+sG36eFfOasMbQgVngBTAgOB/PoswcyIHkMcXWDFs50X4e+1oKphKq3kQOau6EkHC2tWswp/BDiu32ILEB0OR93f/+nL6l1IvH4hp4lbEXZTRg/Tg5n/DvJsLL16A9xnOblD4qdpreIeQnSiDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OinfDMTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60066C433C7;
	Mon, 26 Feb 2024 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708952306;
	bh=TYd1QFQIy3LiHRMTeLxXNhm+koA9OdQaPyZaAGwwoHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OinfDMTtujWwkAT2ORY5BuKW9Zbeh0Itlatgty/p3WZ6TmZHBaXOnRzUMqAdXyowD
	 KfiWYXtFSfzhZRAJtUSIxwhX4jZmf0viWfHS/ATHSRclMe6t4406K/cQcOl+9e0gjs
	 O/8wtIMqPgYbFG1tP0EgHIrL7GoWUV3nA+aIhJfy5FwjLt5bovjVtQ9JoSifzKR5Fg
	 JNVF5ndOKcLUUJNrxNNbN2lpNmttu9URhvCW27z5ff4kXGUtYSuEejAL5RKuyT/Efv
	 IhNXCaZcDhdPdg8Xn3pzEJoJHIRQ6vvqYtDMa5rmXHIxRUnWjP6r6ynRa/MVuDY4lc
	 UmwKK26X656YQ==
Message-ID: <2f0f67d3-6a69-400b-b653-9353a3ddff02@kernel.org>
Date: Mon, 26 Feb 2024 04:58:24 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Wadim Mueller <wafgo01@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240224210409.112333-1-wafgo01@gmail.com>
 <20240225160926.GA58532@thinkpad> <20240225203917.GA4678@bhlegrsu.conti.de>
 <20240226094530.GA2778@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240226094530.GA2778@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/26 1:45, Manivannan Sadhasivam wrote:

[...]

>> As virtio is made mainly for Hypervisor <->
>> Guest communication I was afraid that a Hypersisor is able to Trap every
>> Register access from the Guest and act accordingly, which I would not be
>> able to do. I hope this make sense to you.
>>
> 
> I'm not worrying about the hypervisor right now. Here the endpoint is exposing
> the virtio devices and host is consuming it. There is no virtualization play
> here. I talked about this in the last plumbers [2].

FYI, we are still working on our NVMe PCI EPF function driver. It is working OK
using either a rockpro64 (PCI Gen2) board and a Radxa Rock 5B board (PCI Gen3,
rk3588 SoC/DWC EPF driver). Just been super busy recently with the block layer &
ATA stuff so I have not been able to rebase/cleanup and send stuff. This driver
also depends on many cleanup/improvement patches (see below).

> 
>> But to make a long story short, yes I agree with you that virtio-blk
>> would satisfy my usecase, and I generally think it would be a better
>> solution, I just did not know that you are working on some
>> infrastructure for that. And yes I would like to implement the endpoint
>> function driver for virtio-blk. Is there already an development tree you
>> use to work on the infrastructre I could have a look at?
>>
> 
> Shunsuke has a WIP branch [3], that I plan to co-work in the coming days.
> You can use it as a reference in the meantime.

This one is very similar to what I did in my series:

https://github.com/torvalds/linux/commit/05e21d458b1eaa8c22697f12a1ae42dcb04ff377

My series is here:

https://github.com/damien-lemoal/linux/tree/rock5b_ep_v8

It is a bit of a mess but what's there is:
1) Add the "map_info" EPF method to get mapping that are not dependent on the
host address alignment. That is similar to the align_mem method Shunsuke
introduced, but with more info to make it generic and allow EPF to deal with any
host DMA address.
2) Fixes for the rockpro64 DMA mapping as it is broken
3) Adds rk2588 EPF driver
4) Adds the NVMe EPF function driver. That is implemented as a PCI EPF frontend
to an NVMe-of controller so that any NMVe-Of supported device can be exposed
over PCI (block device, file, real NVMe controller).

There are also a bunch of API changes and cleanups to make the EPF code (core
and driver) more compact/easier to read.

Once I am done with my current work on the block layer side, I intend to come
back to this for the next cycle. I still need to complete the IRQ lehacy -> intx
renaming as well...

Cheers.

-- 
Damien Le Moal
Western Digital Research


