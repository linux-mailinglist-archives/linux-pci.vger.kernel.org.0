Return-Path: <linux-pci+bounces-33375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC838B1A4FC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7770718A2242
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A53A26158C;
	Mon,  4 Aug 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiRQA4mT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E420A5DD;
	Mon,  4 Aug 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317997; cv=none; b=UDHkxU5bjoJdi4W36+W59KRzfJFYI28vHuFXh6Y1e1QDD6Db+1cB90MD4GoKTU2WlrZQ3sivbP5UqMwECTZFLebOQAYy8U3F+e6cnkCiiPqB5Cbb9340rdJnQXOON6V8ei7E2K69DLB8gb1WV8UvBKVxs7VGtNXW5GUMODvCGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317997; c=relaxed/simple;
	bh=lNCjlLpZFxD/PtdJOyoh2yFbwZHbOxdKdmNWlb/JcU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YoyzKz1KUGPPf5mez2U7rQ+Cx3Agv/yNkTt8SEBDdNcZ9PtSpf8F1mzX30xy4j6ZkOfrnT29ZhORuDFU6q7orej+hzf0mSGw/PLFsFcOZvI4PNH7wmz/pJVEBRztErtx9wPnuBX0tSM3yRg2RKkdF7DJ+v/3VdafLPeBudB4oJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiRQA4mT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63AFC4CEE7;
	Mon,  4 Aug 2025 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754317995;
	bh=lNCjlLpZFxD/PtdJOyoh2yFbwZHbOxdKdmNWlb/JcU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OiRQA4mTxYetcheUguLMSUMOVIRCUWGIg4aRO4fzs0kLuIkHMwGfn06i9+1+6Ul7E
	 QNhbx1KnQCx1iUHY1cLZ5EftNdpwdTJr0xyELWeaqvKT6PvHk7M5p5FgzlHzLesjGG
	 u01wEj5GhS6Ev9XZnHV6jyUl76gpHZFtAMJHZtidH4lBllPn4xck6/ato3kj4onFIF
	 cWhGu3bMJdzEpFRZFjoQJZiUqcFVyaEVkNBNcCiMRywHc27YV/q8MDtRM234jPzDJH
	 y2mPuvWHFCqlbFd2rzjxYX3ktlCiq2gtzoWLvDcQGynztvwl3c/n8NNx7LhYrlqz3f
	 0fSTdjqZQ2qBQ==
Date: Mon, 4 Aug 2025 09:33:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Hans Zhang <hans.zhang@cixtech.com>,
	Arnd Bergmann <arnd@kernel.org>, bhelgaas@google.com,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	jingoohan1@gmail.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, geert@linux-m68k.org
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Message-ID: <20250804143313.GA3624395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>

On Mon, Aug 04, 2025 at 11:06:36AM +0800, Hans Zhang wrote:
> ...

> According to the issue mentioned by Lukas and Mani. Gerd has already been
> tested on the s390. I have tested it on the RK3588 and it works fine. RK3588
> uses Synopsys' PCIe IP, that is, the DWC driver. Our company's is based on
> Cadence's PCIe 4.0 IP, and the test function is normal. All the platforms I
> tested were based on ARM.
> 
> The following is the patch based on the capability-search branch. May I ask
> everyone, do you have any more questions?
> 
> Gerd, if there's no problem, I'll add your Tested-by label.
> 
> Branch: ttps://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search

Since this series will now target v6.18, I'll watch for a complete v15
series based on v6.17-rc1, with this fix and any typo or other fixes
from pci/capability-search fully integrated.

Then that series can be tested and completely replace the current
pci/capability-search branch.

Bjorn

