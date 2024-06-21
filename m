Return-Path: <linux-pci+bounces-9083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCB912CA9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B40B21568
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA4168483;
	Fri, 21 Jun 2024 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp5qZIa6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFDB1514C1;
	Fri, 21 Jun 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992302; cv=none; b=pQHsyXmIvamG9glqTl+GJ7vGQC26c8Uteq6/aZS41lFIwpd+4b5UYsT3HPSz0tRKjiMHK5flsk3CnSBeC2eUGolVwGa8X92sU+rj3nhb6iMc6/gN72Npa3eZilKJKhd/HkzNMP3skxZY4WAYDZWEp+ejL35XI66HQIuncYqEYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992302; c=relaxed/simple;
	bh=5FA0PHgGT1Ni8hsFhtjGXWNPUyoxyBny5Xgs7qU/nNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uNGR1nTLjinqRb0Qptracf9SP1qquIErOrw6uj3hD1VLMvTDw65Q8KU+JN+gN2qnQkbL8DApi3eUW0atcJb46DSoxoQEv/OKEuSFLclB59fjokH83Cpl8GpE9lS8CvT0rExsnsc+NS31siNL74hXzH3YFewIo7v/NZJvmsZrSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp5qZIa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8F6C2BBFC;
	Fri, 21 Jun 2024 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718992302;
	bh=5FA0PHgGT1Ni8hsFhtjGXWNPUyoxyBny5Xgs7qU/nNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qp5qZIa6zS9YWjKPVc74FtqGF9bVl/gLyxpAYeSDFT/N7nTww+JZa0BH0LU1HRiBv
	 zb+5OqETVcf/jxy7Jx51EieTIqReHPrAGobkRuH4TYUFt1tZt+bcDi4gu1HzMIAygu
	 ZZ1U8i+obUElaypu5fUyEEFC7pxXRtWMWC8sFMQKERrPth/q6tJ4Rt4G9b/hutR6Wp
	 KXtQQ/YLGgKKdPe4gLGlGknRgVdqDcywOQLWz6q0u03Htws/KADVEJjKlIFK9d0tb3
	 LV/9UgnW43LI+Af6QV+jXPC/qk5yOSxWHXALd5dq7nHSTzJ8VryQwtPaObM7NP6RIn
	 pbQRTTtSeRU6Q==
Date: Fri, 21 Jun 2024 12:51:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 3/4] PCI: mediatek-gen3: rely on reset_bulk APIs for phy
 reset lines
Message-ID: <20240621175138.GA1395691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ab615a56759a4832833211257d83f56bf64303.1718980864.git.lorenzo@kernel.org>

On Fri, Jun 21, 2024 at 04:48:49PM +0200, Lorenzo Bianconi wrote:
> Use reset_bulk APIs to manage phy reset lines. This is a preliminary
> patch in order to add Airoha EN7581 pcie support.

If you have occasion to revise this:

  s/rely/Rely/ in subject
  s/phy/PHY/ in subject and commit log
  s/pcie/PCIe/ in commit log

> @@ -912,7 +927,13 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	 * The controller may have been left out of reset by the bootloader
>  	 * so make sure that we get a clean start by asserting resets here.
>  	 */
> -	reset_control_assert(pcie->phy_reset);
> +	reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> +				    pcie->phy_resets);
> +	usleep_range(5000, 10000);
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
> +				  pcie->phy_resets);
> +	msleep(100);

Where did these usleep and msleep numbers come from?  They should use
a #define that we can connect back to a spec.

These delays should also be mentioned in the commit log because it
appears unrelated to the conversion to the reset_bulk API.  Actually,
it would be even better if they were in a separate patch, since it
looks like a logically separate change.

>  	reset_control_assert(pcie->mac_reset);
>  	usleep_range(10, 20);

Unrelated to this patch, but it would be nice to have an explanation
of this existing delay, too.

Bjorn

