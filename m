Return-Path: <linux-pci+bounces-7904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2278D1F23
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67A11F23E67
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5072E16FF37;
	Tue, 28 May 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpXjW2f6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547B16FF29;
	Tue, 28 May 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907495; cv=none; b=piFwm2t3aFmmBzs0jJnc0UMdB4za5zghqmVnOgYvED/23GYyqgBLhP/lvfAg1i02xdEzXyiwb44/DfwRaAVZ6zi1QcBHeH71k3RHCah4I/0DldhMtJs05VyNjYEDN29pEwRQI3RVuNsRprGHoiIu5GdMt8LCT7qZcvTZmTnq/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907495; c=relaxed/simple;
	bh=xz9zyOhxwPt23pC4R+fAaMjY+WkFIWZvwEu3x6HQAd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MPaB377Z2qmhJ0Uwx2aPcYqc5ERMVr4Mo76SxgUDiGzdsR7pvuGKFB0EhnzxoE+K7REqz/ktGdWRw8XLMGEagWR94G2D4X2PpZRlzFYELM3b91uf4CYAcQWXOY5iaQZ/dvMinsUC8R4ZUWscgwdAY0VCNgJpRR68IQcSYaXotmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpXjW2f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A83C3277B;
	Tue, 28 May 2024 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716907494;
	bh=xz9zyOhxwPt23pC4R+fAaMjY+WkFIWZvwEu3x6HQAd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tpXjW2f6XIJr97K/aqkxgijyffbkW9G3McH9pnUKL31wopaNmGN2SA+Jii9fnDUpz
	 A3if4V7fIbBYbdm0VezQumKP43CNVK3yStMMcmxavKh2KU3/94oln3FZVFt2hvCvQS
	 iGbNDBnmR9bRatBC6nWVxJesb/69h/2tIyWcwKtIBj0Oe+5uhe/PZ+NUGBb1r4m3nI
	 01TMgnux04XOawJ7ihMoo/nrUdbVqIv0Rp+9E35m1j+iQahbWNteN5uFtpfjRC5UU+
	 YaHlj/7hKE9cVfSVbMWbb4QIz93vZi70Ru9IhcJakavpelCfoIGvAwCZLsfgQPEK7X
	 4qR2DDKkhxIpQ==
Date: Tue, 28 May 2024 09:44:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/3] Make pci/endpoint branch build
Message-ID: <20240528144452.GA307495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528130035.1472871-5-cassel@kernel.org>

On Tue, May 28, 2024 at 03:00:36PM +0200, Niklas Cassel wrote:
> The pci/next branch has currently not merged the latest pci/endpoint
> branch.
> 
> Perhaps this delay in creating a new pci/next branch is because the
> pci/endpoint branch currently fails to build.

The topic branches have things queued on them for build testing, but
they haven't been merged to pci/next yet.  It's standard practice that
we don't add v6.11 content to -next until v6.10-rc1 is tagged:
https://lore.kernel.org/linux-next/20240523111023.7ade2aa4@canb.auug.org.au/

v6.10-rc1 was tagged 5/26, and 5/27 was a US holiday.  The topic
branches will be merged to pci/next today.

Bjorn

