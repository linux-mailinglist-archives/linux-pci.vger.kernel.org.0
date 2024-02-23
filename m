Return-Path: <linux-pci+bounces-3941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0248615CC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A208B1F21896
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCF81ADA;
	Fri, 23 Feb 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnS/XN8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96781AD6;
	Fri, 23 Feb 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702227; cv=none; b=hL+iNrPUIMjZx9JSv19KQ7ACpO6hmBG91H0eWYFBYJmWoZo43qO3wLEs8mLqXO7evNMBiFGFTOWtEyYRR/X+ZhlPqvoftIKRrdmbjzOF/zNZv+eqKzazQJHuP8/AhJJqIqf67w2HUiK/I+Ol1rYB+T7RF6zFS8MztmnnU7cKuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702227; c=relaxed/simple;
	bh=DQYurWyg86Ez3DiK6ASHbaf1yW5T2RgDHOvtFuM+oe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF/RWtTgxOC6o8k8is2IM4sgAOYwK/3WvGmyYTz3O3akoEYGlbIYITFqmJTzXnRPGlWOLGBGKaZRML2EpJU/8VVF8MfoDzEOEUx2ryMnZ0ZGISVM/gKdVEU9l0NAIXXwz3R9mAHZmMeY/zd6rPeeouQOEdcA66YXwM03S0kWXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnS/XN8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E798C433F1;
	Fri, 23 Feb 2024 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708702226;
	bh=DQYurWyg86Ez3DiK6ASHbaf1yW5T2RgDHOvtFuM+oe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnS/XN8kuf8T6OCr0ym6LQJ3WEwwTv7W0VpsFFzqr9jsxwttxnEZVsA3VMbPAMWtb
	 20fThoKTj0shSrCiKPJcbfkXu/affILl0Es3ViG+k169rmLFEnkGHEXPO+pqbWgPnB
	 1QwOpNNf3QwWxFITeN0l+XELXQQSEsR5e15anYpXP7ixvDVLI4KJe+m0jLl5FEUVQx
	 9JIup85ncMaQfLNoM+bL8OdtRomIbFrZkCmSIsTchANhgP2uBh+GPa0TIprsBOBysE
	 AlzqKpl683E6VheQ71DQb4640s3Rzy3J+473qpOdd2xResbAu0q2IJv9wy1JDpjKXI
	 IsaAN8iHNinlg==
Date: Fri, 23 Feb 2024 16:30:18 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, cassel@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v11 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <Zdi6CqmNjKfSWCXj@lpieralisi>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
 <170870177640.190909.13423263048571416476.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170870177640.190909.13423263048571416476.b4-ty@kernel.org>

On Fri, Feb 23, 2024 at 04:23:24PM +0100, Lorenzo Pieralisi wrote:
> On Tue, 20 Feb 2024 11:19:10 -0500, Frank Li wrote:
> > first 6 patches use drvdata: flags to simplify some switch-case code.
> > Improve maintaince and easy to read code.
> > 
> > Then add imx95 basic pci host function.
> > 
> > follow two patch do endpoint code clean up.
> > Then add imx95 basic endpont function.
> > 
> > [...]
> 
> Applied to enumeration, thanks!

Sorry, scripting messed it up, it is the controller/imx branch.

Thanks,
Lorenzo

