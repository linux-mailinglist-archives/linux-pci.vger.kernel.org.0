Return-Path: <linux-pci+bounces-27806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFFDAB88E3
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 16:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AAF3AE28A
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D1198A08;
	Thu, 15 May 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/v5Jaib"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221542C0B;
	Thu, 15 May 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317918; cv=none; b=MXboBp8F+CCPo0dY9kIUyEbf6qkIQzmOjP8G1g7BbI+kec6xjgJVZKCisnQIA/2FdP/gCsHIoY6V3DJmYrgoz1SAUYTc2vwHS0yePxjH2QDD5fWOynJTXJJqpOUwslnXYLWtBwrm55M5maQC/WXXvnPUMglZfiURpq9hok6xop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317918; c=relaxed/simple;
	bh=sNePq+LMM3kIp5u3UriW4MrUnaPdzDIW/KVxIFD2WVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmGX6bIc3SXhDjU8SMZuz/7AaWA13gX6dxDhqLWghPZ1Du3brbrj/oNMXNeOqP2CJagH1C0ZD6nhjrkhl/sYKiDIUNw04ZLBxdCsWaIyUm8uIBssCnNXAogiCNgWkXFvXJVrRUtXIL9vcQKESRXd/0XAJ7I47fdEbbDgWi+b4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/v5Jaib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D973C4CEE7;
	Thu, 15 May 2025 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317916;
	bh=sNePq+LMM3kIp5u3UriW4MrUnaPdzDIW/KVxIFD2WVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/v5JaibzWHrLqc982tXka0FwsSIz6g11tW0rx/a/dOURkwmKyNgj3hofNEnCzzN5
	 pID24Qf7r22RQNLt/5pnFfK9ECY035vPEDSwJJJg5cjVfnBfde1ePEXsBeJ0Ok0fAS
	 GwjRorSMTlz3vZBLFJzEPty8z8cvXbeOnlqXAyoAmGbI6KTpC/zVIsC91Rw+C3rO3x
	 D4oX1+G/wZPveCVAruHyGBr4/wbObVdxdHKsLFefU40vj2RvDHtWCGPLt/r0wtq27x
	 VSQh1uE+UlExY6Q7ALZQhQPsxvXV2xZUdKec+bvrTEmd3zgbs7nT9jKHsvWzSed20q
	 lXfPT6dCDe3TQ==
Date: Thu, 15 May 2025 23:05:15 +0900
From: Krzysztof Wilczy??ski <kwilczynski@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <20250515140515.GA4092346@rocinante>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
 <20250515084346.GA51912@rocinante>
 <aCXZdfOA8bme-qra@wunner.de>
 <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>
 <aCXe_SMq6vsAIAin@wunner.de>
 <20250515140034.GC3596832@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515140034.GC3596832@rocinante>

Hello,

[...]
> But, any help with the housekeeping always appreciated. :)

Speaking of housekeeping...

Lukas, do you prefer US ASCII when sending e-mails?

I've noticed that the letter in my surname got broken here. It's also
interesting that my "ń" broke, but Ilpo's "ä" didn't.  I assumed both
would be encoded as UTF-8.

Anyway, just curious. :)

	Krzysztof

