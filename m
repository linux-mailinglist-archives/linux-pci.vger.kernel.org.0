Return-Path: <linux-pci+bounces-43847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10129CE9B03
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 13:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 120F7302BAB0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F82D322F;
	Tue, 30 Dec 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqEPNGvX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3528DB56;
	Tue, 30 Dec 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098119; cv=none; b=WVrn2/lUztimlgSvXDH1kERT5ey6av5Iz1uobR9tHhlXzBreGwrolurmUqirlcEZtNZIK7cOQF0lFizgxZCAM5IsMNxE+HVWyH5l7QeDp/ghh4f5G4Q1agHEyuuK4bFagG+55/NuLeHu20l8q5M6FftcvLnPL8E7xbQukodfEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098119; c=relaxed/simple;
	bh=IMTtGa00hiMAZDyKtUOm5okz3mMBbEzmmQKhcL9wMpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixYauq2K56U+pIOtXtoTZwYup3NKygWUXdjD+Ab3BOaSgfrk48alufOT7mtGWN2BdvguTHa3DJT4cloryaQvw8J9aebaCQ/mfNn1T0FTjm4+l7uMB02JOd5vjJoJ5Y2Pq3DZF7y9lmBDDZ9IOJzL1whpo6iWRFaX0SoC3C1thRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqEPNGvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE99C4CEFB;
	Tue, 30 Dec 2025 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767098118;
	bh=IMTtGa00hiMAZDyKtUOm5okz3mMBbEzmmQKhcL9wMpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqEPNGvX82mGk39l4bKwlQvcWffBXtt1zJ/rcP+18T0Zq3OvHVh2Jf51qOSXD1m96
	 4u2zxqTBC8PsM6kGMmg5vc4FVEqQnDk3ZiX+16kdTvr9sYyRLyo7ActnpjtC89Pnig
	 A//U7A3z5UFN6iGlpxknvZpMcgZRRKN5tCxr1wLfEPxL+tOfFGN5EzGJeGM0q7puab
	 1fJO/xbER7GSPPrU7ZQeZ0Im5PmCOchWCpwXi+rRuIe5LOl/RkvWvZqDLQIF1bVSIv
	 mQzPtTZNvyoJ4SIgNEyJlLI3THSuv+8daNYsnWE2jI/D+1RECqftz+/9OsCb5T+srv
	 kojw1yARkQejg==
Date: Tue, 30 Dec 2025 13:35:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 0/7] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <aVPHAH5rnWVWvnBr@ryzen>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
 <aVO3_32KT6HfOUAZ@ryzen>
 <hgowokljpte5upekanfovxzfgrciviuoyhbnye6eeo7ifpywyr@krbusbak4wkf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hgowokljpte5upekanfovxzfgrciviuoyhbnye6eeo7ifpywyr@krbusbak4wkf>

On Tue, Dec 30, 2025 at 06:03:21PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 30, 2025 at 12:31:11PM +0100, Niklas Cassel wrote:
> 
> If I happen to send the blocking wait patches this cycle itself (should be
> atmost 2 patches), those patches could be squashed with this series itself. So
> I don't see it as a big churn.

Sounds good to me.


Kind regards,
Niklas

