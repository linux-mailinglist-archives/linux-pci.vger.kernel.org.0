Return-Path: <linux-pci+bounces-9941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884A92A62A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67BE1F21E46
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72543143C4D;
	Mon,  8 Jul 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPmLNWrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAC143C45;
	Mon,  8 Jul 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454001; cv=none; b=IbA2Q8c7ut1V5C40se08bvv1FAKl2eqepfZUbjv44mUhxVOt15c6cfNcXD/Vcdvs9ifO10HFx17DY5r33ri8KXTST3zI51QldhzI/3lvglWfjbYqwbBa2OGxcR19g8Gcs8BSSciqMZUga59bTIAHLAkoDZ/1/lw/xIFCUJrt0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454001; c=relaxed/simple;
	bh=0dT9DFcn0Y3bJSFpiEG8lTelzSISjIxepScHvkGxYNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrDIDTmKHUdKufmJZt+sKXj2jWH8suUkfyDkRa7K0pqjFk0HVElOskbAk6DAr3fW2aCRC7O6R936up6ln7U6YxOCShow3wNuVk9hk5bzhF3eGn0OGL6Zhy5MnAs4egYcm7saMTJqImSXYAQI38TYtBFlp92H33PI2EdM9NomHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPmLNWrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E3DC116B1;
	Mon,  8 Jul 2024 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454001;
	bh=0dT9DFcn0Y3bJSFpiEG8lTelzSISjIxepScHvkGxYNQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RPmLNWrkd14zClJcNi7XWX+RCWDX77i56aON0A9j6qkblIh7vmKzZZEKCcyl41/iZ
	 f7LV3eu5tHAog52MkPDgIfH30vvXnRWhPtJFW2HI33XmX7dOnC6IU4bW5/DXSUSSaw
	 cEVWbD44pf6ZG7hxjshzuOBka+1HfyYUJQkJb0dCUV6b9WQEcAJGs1/SZQr73m9fdu
	 7QCt63j7nl1owRlw/26DoZ9INp1xO3x6loSb30i/pMZYnhV+0BYewLN9+Dwi2C7S19
	 vm/AG2thUXfGmsABLYCXuxXVnwfG6ww5bShhJLcHuCKQC2gHJHhrO0/HugazetABrw
	 SFymg5idKOr3g==
Message-ID: <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
Date: Mon, 8 Jul 2024 10:53:18 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>,
 caleb.connolly@linaro.org, bhelgaas@google.com, amit.pundir@linaro.org,
 neil.armstrong@linaro.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Praveenkumar Patil <PraveenKumar.Patil@amd.com>
References: <20240707183829.41519-1-spasswolf@web.de>
 <Zoriz1XDMiGX_Gr5@wunner.de> <20240708003730.GA586698@rocinante>
 <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante>
 <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
 <20240708154401.GD5745@thinkpad>
 <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
 <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/2024 10:49, Bartosz Golaszewski wrote:

> 
> If you have CONFIG_OF enabled then of_platform_populate() will go the
> normal path and actually try to populate sub-nodes of the host bridge
> node. If there are no OF nodes (not a device-tree system) then it will
> fail.
> 
> Bart

So how about keep both patches then?

