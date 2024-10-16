Return-Path: <linux-pci+bounces-14599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D999FE13
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4211F22A3B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC213AF2;
	Wed, 16 Oct 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG4bHGBa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49659EAD8;
	Wed, 16 Oct 2024 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041174; cv=none; b=sRFvo31pXj5ZGFnvnO/I3PAO24Jx+B/dMgsJaLGU4/yI3BI+a/2cH2IK6hoo+HCZOtN9QLoA9SJP56k0gxjBwSgiIvRth/V7WqzsujYRC8b6C/utiT+PcsT5oozk0r8ujiE8fpYCVCaOvWoh6LbhtHoz5mEO7R0ncl/QvurR8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041174; c=relaxed/simple;
	bh=VxWTJtL4UhcHUgiO8c9vRLgmVY3RWfHNeBKpSIE1xXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJEJR9jJI+h3qyrP6ij5pI9Hjviaq3FOptqi2A6Nk0Zf/kimobV5eK3CfxYiTEkIyXhzodnwkX0KDfAyIdO50Fh+R6NHignVx//CQWZ/7tJomtnh/eqh2fOtPZfMVUzmtgnzAO1joeGl6+u/cwV6HPPG5tdVsar4B+C9xzGVvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG4bHGBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9836EC4CEC6;
	Wed, 16 Oct 2024 01:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729041173;
	bh=VxWTJtL4UhcHUgiO8c9vRLgmVY3RWfHNeBKpSIE1xXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pG4bHGBa+pDf/vRO0j2iEMVaXQI0mfI5zAk3nEPv7xO0wrtOTPTcgkr7/9U0blrqN
	 FPZbKQ/kXqr7X5Guu5LDQq84HAXilY2+QdioUscPUvrCMjGcMN4UW4OjLGvJOwxhUH
	 c4XjtSN5So/DjQ7OZtMJ+24wKINeiF/aGb9AAypo2xonhI6rV9f05r9Xdn9f0aEXXQ
	 63DXSkxlwyWVENBdxXOsWZRDlBOlpWt+nw10H12hzUyQUCUd5YqsLhq0ss6gCh7Izo
	 Mxx0B9pj3rToHV3hrh/oi6oXHEZiE1ErnOszaVdFufhwWYQ0oZL5aIGNVgxofKp2bH
	 /qwrKz9RM30mg==
Message-ID: <8a83918f-6885-4766-9648-de88a7a99f07@kernel.org>
Date: Wed, 16 Oct 2024 10:12:50 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] genirq/msi: Add cleanup guard define for
 msi_lock_descs()/msi_unlock_descs()
To: Frank Li <Frank.Li@nxp.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, maz@kernel.org,
 tglx@linutronix.de, jdmason@kudzu.us
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-1-cedc89a16c1a@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241015-ep-msi-v3-1-cedc89a16c1a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 7:07 AM, Frank Li wrote:
> Add a cleanup DEFINE_GUARD macro for msi_lock_descs() and
> msi_unlock_descs() to simplify lock and unlock operations in error path.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/linux/msi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index b10093c4d00ea..0b6cb7f303887 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -228,6 +228,8 @@ int msi_setup_device_data(struct device *dev);
>  void msi_lock_descs(struct device *dev);
>  void msi_unlock_descs(struct device *dev);
>  
> +DEFINE_GUARD(msi_descs, struct device *, msi_lock_descs(_T), msi_unlock_descs(_T))
> +

This belongs with patch 3 since it is first used there.

>  struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
>  				       enum msi_desc_filter filter);

-- 
Damien Le Moal
Western Digital Research

