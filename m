Return-Path: <linux-pci+bounces-5310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209A588F942
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 08:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ACA1F2B927
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7186A4F8BB;
	Thu, 28 Mar 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcyWY31+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93754729;
	Thu, 28 Mar 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612536; cv=none; b=pvmxOqC33ev1wOey1NGg8PnkqilaZSEWC/MvUugJ3usrWu9ei3C5SMuzNnPngOEEyuK6P8KXQZzg3ptzCd80IGFovBGR6wLnZ3v7Qe8KJID1WEVk+kdAHKHed9v2GwwAUhlF6lcsFwIZMukDqKjDGDh3ZDZjIfQN/cuEMUsMQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612536; c=relaxed/simple;
	bh=qtwxnMr7h0StCKaCcZw5U9g1eJHIlZTOcNS8LKETAP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTxCHgPb/AIUDLMtsf45Fo+rS7MRWNUhDlv8sVDemf5gHFtal3Pc5FTcFLVqqTM15nqZJn4RNo2hQH3USndKWEkiob5svCWu3TCOS4pm8ckoRKygmUQUZ1nP8HSF+FZRdbDGt7lfdyQR2ABYlhlMRCHZ84ldUEhQngvUQNeI/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcyWY31+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FFFC433F1;
	Thu, 28 Mar 2024 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711612535;
	bh=qtwxnMr7h0StCKaCcZw5U9g1eJHIlZTOcNS8LKETAP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcyWY31+GrMBvGrVGqFz8Ek4ORULThUO5C0m5XvK6nOk3tPcEftwNr+Go5N5dCZ77
	 r103gqrmxD47TN4mLoy3jakKXJPW5q8btiMw/kcwGKm0wgx+gcclnqbWMe+465fSA4
	 oX8spooTokgRDeAl5q3n0HEn+1V73J8ZuDMTt5WGcFkQft19pUybu2xZhqvxxrXcbc
	 CJB7EvfYYJOfBsyUsBv6x2OH85xk2+v5WMa8GjRK6bEqDMuHm0nVG+Yvrh72bSNdrm
	 P01TzUajNFKfAA1hmACtGGfSbetkZ6XDllz2ox7ZEhot/htS0CtpH/YIwvqsfD+BpJ
	 FOYgkEtJw2KMg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rpkbw-000000002Ez-23ac;
	Thu, 28 Mar 2024 08:55:45 +0100
Date: Thu, 28 Mar 2024 08:55:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: Use the correct sleep function in
 wait_for_link
Message-ID: <ZgUigCJ1Cq4Mz8sO@hovoldconsulting.com>
References: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>

On Wed, Mar 27, 2024 at 07:24:49PM +0100, Konrad Dybcio wrote:
> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Tested on Qualcomm SC8280XP CRD
> ---
> Changes in v2:
> - Rename the define
> - Sleep for 90ms (the lower boundary) instead of 100
> - Link to v1: https://lore.kernel.org/r/20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

