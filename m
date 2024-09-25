Return-Path: <linux-pci+bounces-13500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379B985482
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A67286F91
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60F157E78;
	Wed, 25 Sep 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCd0kQSH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A8157492;
	Wed, 25 Sep 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250611; cv=none; b=KvxmfgqKblMrXVo6Wfjnf/nR2E+NsKNn8wMVif9aCvhAOoZW7FNoooY+AL4rNUpb4kQArYEekXauqAjIiJmsL66Sl1lOHm8MLCRssWwHE6TKPMgq+7t/KKq4F4156ez434SxwG3tlk2XtpaJp0MleCAG9D7EUwbnrRmoY8ETJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250611; c=relaxed/simple;
	bh=jpwCPw9gO66yBXZYDqQ9z6hyrzpWpbRkEarKWVXKXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISPENZmNRAHxt35zCIgbnJw4S7hz2Z5Mecmm/ZSBB1rer/uKQpJLa+uMxjbwH6e7iuLa4yrkXUausPOwnlOg5+V7PMagL1SlA9Y+c/0t3lf2iZm1tJ/L9NVMUUJPW4ASjqYL10Ry33iz+OFH7dZwuEi8o4S3G/qnSdn+LXvaojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCd0kQSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9FDC4CEC6;
	Wed, 25 Sep 2024 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250610;
	bh=jpwCPw9gO66yBXZYDqQ9z6hyrzpWpbRkEarKWVXKXSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCd0kQSHfT/NK8Yc6CwRmfutmQESaE7UFlSTa3Se47Uz6Bh+yc0DBQ+LYx9fym8Tg
	 xXjjq4xWJGgArkHMGywBkOav7eW/pzkVriKUDtR4JASw/VvabZmIbViT+Zzws3kp6e
	 pRFtn6tJdsSEPMZXfU+2KRdibFffIRa9zMFUDySFySjqwrIeh625j86j30zn6PGzmU
	 dHiK/sLnIleh4/lH4+c/7O65/u0BtNt5LoD1qNZzEkPyqPYOUblJGeorkwYokdtwXf
	 1rB/SyA5JqUAj+iZR3FGFrhza3qCoUyxNM8/mo8YWGtbJVkbf4DQLwFQg8Qce0XMqT
	 Aab1KNASbH6KQ==
Date: Wed, 25 Sep 2024 09:50:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com, 
	lpieralisi@kernel.org, frank.li@nxp.com, robh+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com, 
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, 
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Message-ID: <vtrxj3r4wy6htxyl44rzjyao4zso6z2idexkvxrh3cg4wazcdc@gffmfu22jiyh>
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
 <1727245477-15961-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727245477-15961-2-git-send-email-hongxing.zhu@nxp.com>

On Wed, Sep 25, 2024 at 02:24:29PM +0800, Richard Zhu wrote:
> Previous reference clock of i.MX95 is on when system boot to kernel. But
> boot firmware change the behavor, it is off when boot. So it needs be turn
> on when it is used. Also it needs be turn off/on when suspend and resume.

That's an old platform... How come that you changed bootloader just now?
Like 7 or 8 years after?

For the future: you should document all clock inputs, not only ones
needed for given bootloader...

> 
> Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and keep
> the same restriction with other compatible string.

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about  if you added new
patches to the patchset.
</form letter>

and I was wondering why I cannot find this and previous thread in my
inbox... So please stop developing on two year old kernels (and before
you say "I do not", well, then fix way how you use tools).


> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 

You missed to update ep binding.

Best regards,
Krzysztof


