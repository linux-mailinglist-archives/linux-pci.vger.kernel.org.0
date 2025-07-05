Return-Path: <linux-pci+bounces-31563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F6AF9FC8
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDE61BC7B9A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645F200B99;
	Sat,  5 Jul 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCUpfwzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFC1AA1D5;
	Sat,  5 Jul 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751713917; cv=none; b=tqtF7n6tqRzdluO7Nv8//Su4z8Mpg6s+kfwo8fNQi8lSy/3JwmoduSz1TnMyNXPbL8lydLE1LE9rBJcavzNqF5ggR9QekIy9qNWJ7fJiyXDIEV1HQzlKs/Wg2XRx2fDoaXQbUBgFetBvZoUdcnCPDSCr1LU27uFW+P/lx09XmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751713917; c=relaxed/simple;
	bh=wR3lYsW35VcYmnO6ZQ8EcLIYfhmy3GzLFAGam2Bm/1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKbV+yYUzIkqqZDw7ow5Bx/tY/f2RDDMwCBfnxWGEb4Nze8K6NRdnH0NszfCCSCNY2YIzF0eB6hCfuP3Cr76S4VMTralBarno3DOzpsrAxkIOQ1wDpMrIOowKaMTzJyoieP0mts6lbu83tEgz4PTw2HvqS7VLEj6ed5NU+pDB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCUpfwzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC0FC4CEE7;
	Sat,  5 Jul 2025 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751713916;
	bh=wR3lYsW35VcYmnO6ZQ8EcLIYfhmy3GzLFAGam2Bm/1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCUpfwzVJyVqijtlXfXgYyOmV+HTCF28aN8+JKvaKI/MjhVkyemDZhD8Tb/wPAKCJ
	 0J8sTwj8nsA8Xy2YgaXiA3/KbHyQsfi4eQxSThzJk8fON8myqR79UrakITqn7qYroZ
	 oDMpzwiVMRfIcEdqrQ9i1PAWsDg8/6+qRmQ80/q4xe8M7jePEJHLWTT21B8CxEMSSv
	 ZhpR9Z/yCVY1FXiq1N+VzcH1tWSarqkbcC0BjQt9KdOTfsq+If/tWReypFKv7j0eOA
	 g4Lc2vXCZhfoF+is3SbajHu2dG+46CXXz/WHKhXGNvcTi3jkyQhvQYwXZeGlClWM+4
	 sLyPpQQ7yiEsA==
Message-ID: <21caf88e-aa7d-4133-b6e4-5d365ce8b69d@kernel.org>
Date: Sat, 5 Jul 2025 13:11:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
To: Wren Turkal <wt@penguintechs.org>
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com>
 <954c0915-25d9-4bc3-ac82-452650902a3c@penguintechs.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <954c0915-25d9-4bc3-ac82-452650902a3c@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/29/25 9:14 AM, Wren Turkal wrote:
> On 6/28/25 10:57 PM, Rahul Rameshbabu wrote:
>>   ///
>>   /// # Invariants
>>   ///
>> -/// A [`Device`] instance represents a valid `struct device` created by the C 
>> portion of the kernel.
>> +/// A [`Device`] instance represents a valid `struct pci_dev` created by the 
>> C portion of the kernel.
> 
> Should this not just be a "a valid pci device" and let the type in the function 
> definition speak for the type instead of duplicating the type name in the  doc 
> comment?

The type is relevant for the invariant.

