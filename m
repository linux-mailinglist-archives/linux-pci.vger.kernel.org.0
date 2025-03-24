Return-Path: <linux-pci+bounces-24541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDAA6DF43
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196AA1886305
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C6261578;
	Mon, 24 Mar 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPv7bNe4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330E2E3387;
	Mon, 24 Mar 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832520; cv=none; b=cyHnQTr+kJVxqZmFp0OAAXkowX94dTBp/MIsmAHumUIP0nxJkfixdSuslK4vBHT1h1m/qast7NBWeTfvxnTMbiVnEfZgXETLWdfHDHeUWZlJqz1bGM7Zu6YUCzsqbGdJILw0mQzpPbqo3HdNYF29dMjmPrjHLkb6i2sAqPBko0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832520; c=relaxed/simple;
	bh=uFHH2lwI0Hjlf+4iID1Ge3PrHz8y0Zaq/bXqOrfZV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tw9GtD/P3sm3lrbWd2FR7sqDqPPeNR7iSuBbyVKQPvXUut/ZhNwRcGtoD9YvBpP7hnVsY0kfldMcCGNahbmDqXDoQCIYd2iTV5VOU2JGGm0tcar2zwjttb/NSkumCx6PscMvY7vd0TptZn3EcDKG/1PyamRB241eDfBcK80Y1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPv7bNe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18451C4CEE9;
	Mon, 24 Mar 2025 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742832520;
	bh=uFHH2lwI0Hjlf+4iID1Ge3PrHz8y0Zaq/bXqOrfZV/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SPv7bNe4C8BXr7Vq4e/JJp/viQqxELXHZxSNVQ2q7khTuXOcRWNmGMkI3pnhq6MZJ
	 kBLQTsIEZFUMee42P/Z9B+Gkqg3uGolwRdjXNCUbtc+3t4rw/Oinl4LAEhZ+gjLXiD
	 av5FN1dcCfv25f5ZOXhX/FnFAqjcO8Vwi0pi/r9SU6QL1Eh4bg/yMJc6vax794fGVi
	 zG0OWuPDUyi+/2PBpldR+YWIfYGDYUTLLdcmKhwRNacr3yv43GZ5/F1+SzYTNnucxT
	 6EWjt7HTlGnfQwWehbE2RdMnPHA1WTelBkxjzghp2DEQR+LWWpdH5elPzsdZBfA8JE
	 4UEdweCfuMokA==
Date: Mon, 24 Mar 2025 11:08:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie-xilinx: Support reset GPIO and wait for link-up
 status
Message-ID: <20250324160838.GA1251294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7637a0-8b8f-4aa7-be46-1e7b8ac07a45@topic.nl>

On Mon, Mar 24, 2025 at 04:46:55PM +0100, Mike Looijmans wrote:
> On 24-03-2025 08:49, Manivannan Sadhasivam wrote:
> > On Fri, Mar 14, 2025 at 03:59:02PM +0100, Mike Looijmans wrote:
> > > Support providing the PERST reset signal through a devicetree binding.

Use "PERST#" to include the polarity and match the spec usage.

> > > As the PCIe spec mentions about 120 ms time to establish a link, we'll
> > > allow up to 200ms before giving up.
> > > 
> > This should be a separate change/patch.
> 
> Indeed, this is a separate issue, I'll split it in two parts.

And please include a specific spec reference, e.g., "PCIe r6.0, sec
x.y.z".

