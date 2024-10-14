Return-Path: <linux-pci+bounces-14431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027599C3FD
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D5E1C22293
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6514B972;
	Mon, 14 Oct 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnESRwg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE51A270;
	Mon, 14 Oct 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895696; cv=none; b=S04RvMpCN1jpMSudVyUTF5OTPH1V0JMlJTPtyaWTn9Js/lG0PaqZwxRMUofBuvyayFsRw1b/9oyV11fc2Kqw9vkrAb8Y5fQSI0afn1Be+dPO6n5CJejyTr9iPICbgSswHC1KSq1lOL+MJK/J+/FkgURdsRB/dxphsha7j6QDAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895696; c=relaxed/simple;
	bh=XUlH7SBebbNpINAE+wx39Vw/oLjGTMOCSxxpABkV8L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd+P24TWZ/z0MyAXbZccLot7vBdohLjN1Jki8bYq/pSy+iwZa2yFvQhr6liylVl39eHGplBP8Yu890+7Do/mpXhihwzgxkgNHMDV6lbIuw6aygz5NKyt79rC8ogI5xn7bxCxS90BzPelOUBMTDw8UsBbVbM2OR+bl1A/9OI58Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnESRwg+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so29846075e9.1;
        Mon, 14 Oct 2024 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728895693; x=1729500493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPs81oFcWH+51u7WuJEjyNlpMlepy7CsftIdGzaBCYE=;
        b=AnESRwg+tsl6Y0iwtUqD/9S6JjuvVrJ4KDp9cAhBdwNmhwMMNwE8OjcsDcMEPJZsfA
         TIDISzj1ahVnQna+Ga5nZVXo35avJvLHQDn7+aN0Un61pC1jZ7UcpYRtkCdteizTs8hG
         yl8qChvg+3gbY+nLunOHHSENTHqycrY9wlQPER8oC6Nej5oK1wkdj7D0rqTlzPo9i2w9
         En3hkvKJ4XDe40oihtFC5fs4sncxALhyUL4LJAglHsKkqKkGHHznHAbJVVUJBFJRFtSy
         ooASuDJ902J4U0gvleVOGOp2166RZ8iSkcjoRg0PT/sNlMcpZdag6tBM+yIv1ZEqHgVG
         5hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895693; x=1729500493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPs81oFcWH+51u7WuJEjyNlpMlepy7CsftIdGzaBCYE=;
        b=igaXWVS+o3vv5FrFmtlS2HTlBsZ+cWAOlOPAGEvbgVaDg32SpOQs/o9T/5HbMhtrD2
         OSmpCu17aJj2nItQx1E19Xq3M4ZAxcklerjm8C9KseFeUnV88VALqXDblIEUmpABA85M
         URv5jZCF6gysNWGbLRaTCrpAdM4PSOwgtv2uF+Qm98vSs9LH9rODftWt76Pmup2cnI9h
         2RkZxXekWttD562GpO12jHfVrFQcCvlPoCI8Lp5zDo3fEtnhBzUXRkoPPK2SzNIvQOLT
         h1axPt/gsQQ/D9UGWjYOQDQn6fhAdA5JYdEB8Ki9/h/hWtJH0SB0pBsfNsh8te9sZTXJ
         62tA==
X-Forwarded-Encrypted: i=1; AJvYcCVC08//rElH73vFqvLkAw88WFc/Xb5WcQko2MYYMmv4Ukto6oOce5XjQHcGm2FcWqqXsgKBT9aSpTL5pPw=@vger.kernel.org, AJvYcCWnvm6WS963ZmslEQQEdauehPt3kzrf3uXE/0k8MO4NtofOdoy3W8m24zDuKwU/1b2MD++0HhVC7/GX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrw6KEPm8JNwq56qCc44rvfPVBxbJJyf/QTLVfw0AjRAlLh68A
	67t7TJ2467oe21YY3gucPG6UsjUUFUVQj8QIYVv5hQrSHQO4y9Ii
X-Google-Smtp-Source: AGHT+IGlBLalOk4/ecKUuRu4nTec1HLQ/slf1/Edv4CqJxEq3RkHgt8/qX/nMWuy9553izNMXfOzrw==
X-Received: by 2002:a05:600c:3b19:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-4311deba4bbmr89399895e9.6.1728895693147;
        Mon, 14 Oct 2024 01:48:13 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:fd1:3993:f12c:5deb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7bddsm114580875e9.8.2024.10.14.01.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:48:12 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:48:11 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <ZwzayxXuJWc1uhab@eichest-laptop>
References: <20241009131659.29616-1-eichest@gmail.com>
 <20241012041315.vtmixcxbqwb63kno@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012041315.vtmixcxbqwb63kno@thinkpad>

Hi Mani,

Thanks a lot for the comments.

On Sat, Oct 12, 2024 at 09:43:15AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > The suspend/resume support is broken on the i.MX6QDL platform. This
> 
> You mean the 'system suspend/resume'?
> 
> > patch resets the link upon resuming to recover functionality. It shares
> > most of the sequences with other i.MX devices but does not touch the
> > critical registers, which might break PCIe. This patch addresses the
> > same issue as the following downstream commit:
> > https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> > In comparison this patch will also reset the device if possible. Without
> > this patch suspend/resume will not work if a PCIe device is connected.
> > The kernel will hang on resume and print an error:
> > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 
> Looks like the device is turned off during suspend.

Yes, I don't have a deep understanding about PCIe to be honest. However,
my understanding is that the PCIe devices will always try to suspend and
there is no way from the PCIe host controller to prevent this. Or am I
wrong? Currently suspend is not implemented for the i.MX6Dual/Quad
variant in the pci-imx6 driver and the device will still be turned off
by the PCI subsystem. On the other side I don't think it will fix
anything if I can prevent suspend for the devices because the
communication will still fail after resume.

> 
> > 8<--- cut here ---
> > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> > v1 -> v2: Share most code with other i.MX platforms and set suspend
> > 	  support flag for i.MX6QDL. Version 1 can be found here:
> > 	  https://lore.kernel.org/all/20240819090428.17349-1-eichest@gmail.com/
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 44 +++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 808d1f1054173..f33bef0aa1071 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1238,8 +1238,23 @@ static int imx_pcie_suspend_noirq(struct device *dev)
> >  
> >  	imx_pcie_msi_save_restore(imx_pcie, true);
> >  	imx_pcie_pm_turnoff(imx_pcie);
> > -	imx_pcie_stop_link(imx_pcie->pci);
> > -	imx_pcie_host_exit(pp);
> > +	/*
> > +	 * Do not turn off the PCIe controller because of ERR003756, ERR004490, ERR005188,
> > +	 * they all document issues with LLTSSM and the PCIe controller which
> 
> LTSSM
> 
> But LTSSM is for the PCIe link state, not sure how it impacts controller state.
> Can you share the link to those erratums?

The erratas are all from this document:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Only the i.MX 6Dual/6Quad variant is affected but not the newer Plus
variants.

> 
> > +	 * does not come out of reset properly. Therefore, try to keep the controller enabled
> > +	 * and only reset the link. However, the reference clock still needs to be turned off,
> 
> You are resetting the *device* below, not the link.

Thanks, I will fix this comment.

> > +	 * else the controller will freeze on resume.
> > +	 */
> 
> Please use 80 columns for comments. Exception is for the code.

Thanks, I will fix this.

> > +	if (imx_pcie->drvdata->variant == IMX6Q) {
> > +		/* Reset the PCIe device */
> > +		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> > +
> > +		if (imx_pcie->drvdata->enable_ref_clk)
> > +			imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> > +	} else {
> > +		imx_pcie_stop_link(imx_pcie->pci);
> > +		imx_pcie_host_exit(pp);
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -1253,6 +1268,28 @@ static int imx_pcie_resume_noirq(struct device *dev)
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
> >  
> > +	/*
> > +	 * Even though the i.MX6Q does not support proper suspend/resume, we
> > +	 * need to reset the link after resume or the memory mapped PCIe I/O
> > +	 * space will be inaccessible. This will cause the system to freeze.
> > +	 */

Thanks, I will fix this.

> 
> > +	if (imx_pcie->drvdata->variant == IMX6Q) {
> > +		if (imx_pcie->drvdata->enable_ref_clk)
> > +			imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> > +
> > +		imx_pcie_deassert_core_reset(imx_pcie);
> 
> There is no corresponding imx_pcie_assert_core_reset() in suspend.

Thanks, I will try to fix this similar to what they do in the host_init.

> > +
> > +		/*
> > +		 * Setup the root complex again and enable msi. Without this PCIe will
> > +		 * not work in msi mode and drivers will crash if they try to access
> > +		 * the device memory area
> > +		 */
> 
> This indicates that the controller state is not preserved. I think we need a bit
> more understanding on what is going on during system suspend on this platform.

Yes I fully agree, but unfortunately I don't really know how to fix it
properly. I just tried to fix the driver by searching for an absolute
minimum that is required to make suspend/resume work when a PCIe device
is connected. As an alternative the downstream patch would do something
similar but I thought also resetting the device would be a better
solution (to stay closer to what the other variants do):
https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
I just now saw that I didn't mention ERR005723 at all, sorry for that.
If this would be a more acceptable solution I would do some more tests
with this patch in our setup.

Regards,
Stefan

