Return-Path: <linux-pci+bounces-18419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B29A9F1CD9
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CEF188D205
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588402561D;
	Sat, 14 Dec 2024 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUyDQssX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BAB674
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734155544; cv=none; b=RPetVuBy0f8542fkti7RdsfllSGaZ9Z8C4NTchuwDaXQmNYjuX1cmIjH1yOC8KB3Hqrx5QGN7SvUA/c/CMFDVgCCJ+uknwbkryrsrORv8IlMKtVeYIN+U87TwWrvCep327a4zzdsjXUwmDS9LwcUdfQN8FQ78s69ZvgKpVQMFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734155544; c=relaxed/simple;
	bh=OYdXiKe7Rzv6Q1F23Q/vI3qVefJed3FVeqzukNlTszE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyAMx7sl65utnnZi9RZZtPQGUu6/y/V5nuLvmbxxdcVWBbd035NR8FQgjA0ZrA6y0A5j4BjMERpcF9Km+Q5s66pxJjpe7D/XTZeH+aUvtu+aZXKac9CsHfccIwCBBZl9nqxdCVtjR0mWuiYfIh8k6KhlvJ17cPHszxxYn9WbRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUyDQssX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110D4C4CED1;
	Sat, 14 Dec 2024 05:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734155543;
	bh=OYdXiKe7Rzv6Q1F23Q/vI3qVefJed3FVeqzukNlTszE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fUyDQssXl9ayZejEHkN2jjg0LvC3RlA46SNqZElFYERNdBsOF6xlaw0dCzFab39Ba
	 /0yGP1cV5eeZUrXpAAvIiEC7GtBYpLgg6QJgbOsnl6k5j8EQD898289ck3qeqV52bk
	 ObCdwHD+hlQ7QuOfyLUtWcY0fgsodPmkvmeTbAOA7cZktj9YXfQwZPOUNtOrbTJmNM
	 frGjIoNa2zJ3DgZtD+R0lNjmHAbAtqBzc2eADdWqbCqDoKtJG1O27YEXm8Uib5u6Sv
	 czuxUymesXYENnX3uMLj341w1pOtQm9Mmt+BROoJi0zIjTXG5j7b3Jj1UnvZZhUWDb
	 crYB301Cq9YTQ==
Message-ID: <09563385-63a4-478d-80ed-81a5ca74d557@kernel.org>
Date: Sat, 14 Dec 2024 14:52:20 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241212185527.GA3356063@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241212185527.GA3356063@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 03:55, Bjorn Helgaas wrote:
> On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> 
>>    This ensure correct operation if, for instance, the host reboots
>>    causing the PCI link to be temporarily down.
> 
> s/ensure/ensures/
> 
>> The configuration of a NVMe PCI endpoint controller is done using
>> configfgs. First the NVMe PCI target controller configuration must be
>> done to set up a subsystem and a port with the "pci" addr_trtype
>> attribute. The subsystem can be setup using a file or block device
>> backed namespace or using a passthrough NVMe device. After this, the
>> PCI endpoint can be configured and bound to the PCI endpoint controller
>> to start the NVMe endpoint controller.
> 
> s/addr_trtype/addr_type/ ?

Nope, addr_trtype is correct. "address transport type" is the meaning for an
nvme target port.

> s/configfgs/configfs/

Good catch. Thanks.


-- 
Damien Le Moal
Western Digital Research

