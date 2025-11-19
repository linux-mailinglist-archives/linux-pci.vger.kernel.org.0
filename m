Return-Path: <linux-pci+bounces-41621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79931C6EF7D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E230734A536
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E4E351FDE;
	Wed, 19 Nov 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvlaXzzG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33C3321D3;
	Wed, 19 Nov 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559193; cv=none; b=pExTnHefjdcjcrCfqtnhVpG/KCWgNQtimvoD8akBuD2vsZ2ZAcoAjXadWx4Cg80kFLSaYGmx9rLY10IVphMjZohFKgyKkpp8q/1ZZURzIJ4YyjHje2OQ2iCxTEPL/klnqHuzX4uMDI+QzINjSaML4rwEt9U48PPQrEdgxUcOXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559193; c=relaxed/simple;
	bh=f1P6e9kOSNo5kgD6H+jb/IDvPun4CBhw4KJz2s61Gxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuWlhiNWjQFE5kpvtp5drciEAoQwDK4M3lx1Qg5E3MB4eFu5gsnvFC4/NzrFrRyBt3BXcH6fE4gc4e6pR8vmYsrqPpKvTVMV1//g85RED0I2OBTWDX105oTlUG/6fdLmpVSMos9QWclHqvKilZKV1VLwEuAnuwy1QVPqLqb891E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvlaXzzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DA8C2BCB4;
	Wed, 19 Nov 2025 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559192;
	bh=f1P6e9kOSNo5kgD6H+jb/IDvPun4CBhw4KJz2s61Gxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvlaXzzGdP6rk3wHmBBL3xa4KEINI9YEfxOcs02Rtrl2F8kPCDYHaq1QyRNNQlrPR
	 a5/gafe1AtCF4fDOPXsn3AX9dnTwNKa80UXh9sxyBn0fEbETObFQLuO+b3xeMNlbyB
	 5RroXOKyTQex6JxlQah75JRkGqLBaiJNuangAUeg0y8knRqHfDFvmxKTyHtybOrcVa
	 olpoiI2lCUGUKVihaqGy69QHSRT+9Xb5pMttxIiNh0yjVhM+1Z+f8IKQ/olSAE30WW
	 f7g+BjjcHF8UvlK3zNAQjFOZl1HdUUZZFAglXWVlql6KZSwdReCMnch5lFnuhXKHTx
	 OV9nBGsgUXglA==
Date: Wed, 19 Nov 2025 19:02:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 6/9] serdev: Skip registering serdev devices from DT is
 external connector is used
Message-ID: <cjtnoqjr3v5o64caa6unllb2e2csyvybr6vnzwuqqrl453bgz7@drqmfkfbn5xg>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-6-97413d6bf824@oss.qualcomm.com>
 <CAL_JsqKBcXH0EWguto3EFY2cJ5p=8VUZczMHz1u5fNFocv-AmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKBcXH0EWguto3EFY2cJ5p=8VUZczMHz1u5fNFocv-AmA@mail.gmail.com>

On Tue, Nov 18, 2025 at 07:03:51AM -0600, Rob Herring wrote:
> On Wed, Nov 12, 2025 at 8:45 AM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > If an external connector like M.2 is connected to the serdev controller
> > in DT, then the serdev devices will be created dynamically by the connector
> > driver. So skip registering devices from DT node as there will be no
> > statically defined devices.
> 
> You could still have statically defined devices. You are just choosing
> to probe them later from the connector driver.
> 

The point of coming up with the M.2 binding is to avoid hardcoding the devices
in DT. So static devices are ruled out IMO.

> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/tty/serdev/core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 8c2a40a537d93f4b9353a2f128cdf51b521929b1..1378587d386356ca4415fa455b2ee722b5e44d3e 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/of_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > @@ -560,6 +561,15 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
> >         int err;
> >         bool found = false;
> >
> > +       /*
> > +        * When the serdev controller is connected to an external connector like
> > +        * M.2 in DT, then the serdev devices will be created dynamically by the
> > +        * connector driver. So skip looking for devices in DT node as there will
> > +        * be no statically defined devices.
> > +        */
> > +       if (of_graph_is_present(ctrl->dev.of_node))
> > +               return 0;
> 
> Where's the schema that allows graph nodes?
> 

Err... I missed updating it. Will do it in v2.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

