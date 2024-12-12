Return-Path: <linux-pci+bounces-18219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C29EE055
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EED216739D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA0154BEE;
	Thu, 12 Dec 2024 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PndvLKtD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F325949C
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989164; cv=none; b=UJG2knwNI6d3qq4pDI4nmSfkEN4+G4o+MH76Vu6AnKrhiXRYah9aZUqWxkEAjwUEt1GfqpXqKzkSdI38J4goMwIxBdEUq25PUD0nw+MuBGedGqs/9w1v74Uulev0O96wlTONPD+UD0tK07x8uw50v1MB0I8r5NHeqyVbpvKUmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989164; c=relaxed/simple;
	bh=5hYl/Xu1OA36+p/FnNeDP1k7XfWgUi+CZGQAOH0bNMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcFwjR7bBmJQVrhDjO37ln3d0CPz27jU7Cf3vJ9gkmswzMuUDHxZCjXELwVMDtk2HCZ16iouKn5I35Os8XdGjD2nssitlm+d4LPuOa3eUU5T31VfTY18bvyvG0uX9Sf0l+7mz3ofdr5UuuD6jDJDXR3F6R1wc+1Ci+wR3s77+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PndvLKtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0052BC4CECE;
	Thu, 12 Dec 2024 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989163;
	bh=5hYl/Xu1OA36+p/FnNeDP1k7XfWgUi+CZGQAOH0bNMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PndvLKtDKKLajr1UThXYQPW8d2e8aNp+Km1v5+lsPHcSv/WBr+IGXl0RUXrvS5+wY
	 k54aajjCdmnJ+TGgebancIjC4Eb/Yo3u13lVd1EYoY+GtTcs7JhpYGBesfiNoJ6eMP
	 M0T85pCsUPeQqDdP7eCsSJvNGQd/is/dz30jF3s6UXoZKjhiC8MXOhd/5fRApy2P7b
	 A9v68g8Wu0zbpom2KUgwll5fKh75oXVQrGfCcxdrSlVcZlqas2VnUrbO16YkPN3J8s
	 wnbUUU+jImu4pvxsohyZ0sPC29gXvrqs5PJQKM+58Wpv5rXLtiOlqRMQhZtNAumOep
	 cKOT1QI+ZYHHQ==
Message-ID: <3ca32224-2978-4590-9fb7-152ede734fc1@kernel.org>
Date: Thu, 12 Dec 2024 16:39:20 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
 <20241212060648.GB5266@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241212060648.GB5266@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 15:06, Christoph Hellwig wrote:
> FYI, this looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks. The kernel test robot signaled a build failure that I need to fix (not a
big deal) and I have some typo in the documentation too that need fixing.
I will post v4 with these fixes.

> 
> But I've closely worked with Damaien on this, so a look from someone
> who is not too close to the work would be useful as well.
> 


-- 
Damien Le Moal
Western Digital Research

