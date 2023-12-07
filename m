Return-Path: <linux-pci+bounces-613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE225808916
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7892B28173A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A2405DD;
	Thu,  7 Dec 2023 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGDYoQUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1761405CD;
	Thu,  7 Dec 2023 13:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC5BC433C8;
	Thu,  7 Dec 2023 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701955450;
	bh=Jox1QVTW8FXBAFs6KYjS5LP35vS3J8LsKIserpsx4M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGDYoQUazfRrRuCGF4JdheCnrSUcHxAIAbG6QHlxeYxdA9W1ASLJ7tmX/W0IndNBP
	 FzxogXB9Ae/rUfISxZEtYCtZ4HUei+hSYS3rK41aQ5sQmFzArfEQuH06HOV21MfZ+m
	 dGY2Qwat3aSBQi3zaerNoRjURTPiEDsr2bKRSiiUzfKP34SJPriCH/UNJoPRvpUhhO
	 /2zRt2YM9VrE8hJaOnMNQ1d+BlOOVel4X+NJgZABowrAjCZvH6s7sHRazn6hCvIIAo
	 zJC+M2aJjfn0EA5EjH+gs7Ox0beesWs7tZ8dZ6lmceyc4KTBmsMvcljuOdNBPQgvjl
	 hmiUksYrzbmvQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rBENA-0000PW-0p;
	Thu, 07 Dec 2023 14:25:00 +0100
Date: Thu, 7 Dec 2023 14:25:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@leemhuis.info
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <ZXHHrCDKKQbGIxli@hovoldconsulting.com>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>

Hi PCI maintainers,

On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:
> The pci_enable_link_state() helper is currently only called from
> pci_walk_bus(), something which can lead to a deadlock as both helpers
> take a pci_bus_sem read lock.
> 
> Add a new locked helper which can be called with the read lock held and
> fix up the two current users (the second is new in 6.7-rc1).
> 
> Note that there are no users left of the original unlocked variant after
> this series, but I decided to leave it in place for now (e.g. to mirror
> the corresponding helpers to disable link states).
> 
> Included are also a couple of related cleanups.

> Johan Hovold (6):
>   PCI/ASPM: Add locked helper for enabling link state
>   PCI: vmd: Fix deadlock when enabling ASPM
>   PCI: qcom: Fix deadlock when enabling ASPM
>   PCI: qcom: Clean up ASPM comment
>   PCI/ASPM: Clean up disable link state parameter
>   PCI/ASPM: Add lockdep assert to link state helper

Could we get this merged for 6.7-rc5? Even if the risk of a deadlock is
not that great, this bug prevents using lockdep on Qualcomm platforms so
that more locking issues can potentially make their way into the kernel.

And for Qualcomm platforms, this is a regression in 6.7-rc1.

Johan


#regzbot introduced: 9f4f3dfad8cf

