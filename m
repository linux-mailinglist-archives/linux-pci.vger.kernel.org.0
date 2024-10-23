Return-Path: <linux-pci+bounces-15114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45589AC7D4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7061E2877EF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FC1A0721;
	Wed, 23 Oct 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS3PYSVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128F1A0AF0
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679051; cv=none; b=AUdWhXhIy9NtQAqOFb/kSOgkATe3XpNrjAcqqHmrUTi4hvGZZZFtbXKbtO+w15EbJlxuejhFVqR7StKJs/Y/ZSfPqDB4w7TVpN3H4oZRGqt7SFLjmHSdsyHlCC9FmzA4AEkWnVX2z1wpuprYTCS7ucO3ophZwG2TkQLVCW4eA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679051; c=relaxed/simple;
	bh=TjiTlPfISM8VKrOVCsz48i125V/FB1aOlc1HLJaHSYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYIWRQGPPgYGEkyZk1i684HO5SgRWqPXpNJnn/WS7CeXXS9xl0UwGZbrFmwv214bwwxzIgZPjDK0afuzkcSZYlKb+ME5jyToIFbiJ04cKj2wju6sbhGfO/00IxNyj4Gdg5jBMsbmoGsYbgeAuXFEdf0d2HzMHjorfwv81KVDLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iS3PYSVV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3881042dcso59309537b3.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 03:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729679049; x=1730283849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FeEmQ2K237udnXqKdoHb2MCk0omcaTpa4VHynOY1FGI=;
        b=iS3PYSVVjEq+6Lfj4FVbc318Bu55t0+DTdYLyqmukVxRsrIjUfDRds7TciidGnr+Ss
         2t5DqtVTpEN9Y4JXxTKFTrQdI6ocMrx7PORHNBmdCukzMl5Fk7KIQp28ggbaK9fHHLbw
         Y1SUkxiACSJH7Vvo7cL0qaBD0bMEXZehZoJrE0lDKs53F9kblscNcVaVdqJ221h7SQIX
         ClGG3RgU/GJluqmhXZhZ6J7LV+0JFTgw1gBOAeVe0QAlERqAXZRaakV9yLXPkwJIfXxK
         nIsi/r2D52VJzpsM7de8HJaK+5uRavXnaD5VXYY9aLzogp5UNLsX0pPt7sBP8Fthmgp1
         WlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679049; x=1730283849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeEmQ2K237udnXqKdoHb2MCk0omcaTpa4VHynOY1FGI=;
        b=WR/xzxnXlTmIDfTcsCVlhs7Vh+5uvGVYiAq4rdh8SYLFM5atxsE1azSDUK8w9e1IQO
         4cVMKuVa83NK0EMRx/fPdAtjy/VSPV2qcUWpyEZcEGRZZ14KuOWjJjMbBTcYm34LumoJ
         Ha42f9Pbk9YmTkPzv1+1aP5Ict5hunw9RigbwPT4lfEC0f/l45wdVmBZvGq5ZbmDldP3
         KpgGekglK5hIZX/sNqWVBJQLNAIC1sXU0fOTHfAbq1FfGc08JK6HapLki57b1x2PkJIw
         mb0fxbNqLsCpO2TZS5ke912fZwFS0YstEjmEUxTnwnr+AHarenh4x+1+jHwz38Tc+Q+R
         Mw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC9EbBvP8TeBz1WTZm9cFi8LTWTG/qbbSjgc6WS0pGuCl/DzqrWnZmBQH9cTKVH6vlBwZ57rTLxYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgs0Pr5IlkbJBkdQ/qYSCt1irQjH5+p9oBCoAAx2Zy8OALO9OV
	wJAkedBcrFQJmNj8LUtwnTtw1gnblN9yoLJu6LPmc8IO+C3NfeK6x03cq/eGNjbXvA08YMkPgP9
	qCIVcsM/LxNFbQvx2KoLSO0nnmyg5NeEKLsQ6nw==
X-Google-Smtp-Source: AGHT+IGhf1yC7pWbHzT6DujoVjgz3E+axOwFuFJCrQlg4LOtDNk5n/BtaR/BP1bo3yfChmnpq/mlL6wIWTKz/UjJuvY=
X-Received: by 2002:a05:690c:907:b0:6e3:153a:ff62 with SMTP id
 00721157ae682-6e7f0e7eb36mr21717207b3.23.1729679048670; Wed, 23 Oct 2024
 03:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org> <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 12:23:57 +0200
Message-ID: <CACMJSesmyfS4wj=ys16FmqpAoojuChY1OHSC750bjtM23y5baA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> This makes the pci_bus_add_device() API easier to maintain. Also add more
> comments to the helper to describe how the devices are created.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 351af581904f..c4cae1775c9e 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -321,6 +321,46 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
>
>  void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>
> +/*
> + * Create pwrctl devices (if required) for the PCI devices to handle the power
> + * state.
> + */
> +static void pci_pwrctl_create_devices(struct pci_dev *dev)
> +{
> +       struct device_node *np = dev_of_node(&dev->dev);
> +       struct device *parent = &dev->dev;
> +       struct platform_device *pdev;
> +
> +       /*
> +        * First ensure that we are starting from a PCI bridge and it has a
> +        * corresponding devicetree node.
> +        */
> +       if (np && pci_is_bridge(dev)) {
> +               /*
> +                * Now look for the child PCI device nodes and create pwrctl
> +                * devices for them. The pwrctl device drivers will manage the
> +                * power state of the devices.
> +                */
> +               for_each_child_of_node_scoped(np, child) {
> +                       /*
> +                        * First check whether the pwrctl device really needs to
> +                        * be created or not. This is decided based on at least
> +                        * one of the power supplies being defined in the
> +                        * devicetree node of the device.
> +                        */
> +                       if (!of_pci_is_supply_present(child)) {
> +                               pci_dbg(dev, "skipping OF node: %s\n", child->name);
> +                               return;
> +                       }
> +
> +                       /* Now create the pwrctl device */
> +                       pdev = of_platform_device_create(child, NULL, parent);
> +                       if (!pdev)
> +                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> +               }
> +       }
> +}
> +
>  /**
>   * pci_bus_add_device - start driver for a single device
>   * @dev: device to add
> @@ -345,24 +385,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_proc_attach_device(dev);
>         pci_bridge_d3_update(dev);
>
> -       if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
> -               for_each_child_of_node_scoped(dn, child) {
> -                       /*
> -                        * First check whether the pwrctl device needs to be
> -                        * created or not. This is decided based on at least
> -                        * one of the power supplies being defined in the
> -                        * devicetree node of the device.
> -                        */
> -                       if (!of_pci_is_supply_present(child)) {
> -                               pci_dbg(dev, "skipping OF node: %s\n", child->name);
> -                               continue;
> -                       }
> -
> -                       pdev = of_platform_device_create(child, NULL, &dev->dev);
> -                       if (!pdev)
> -                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> -               }
> -       }
> +       pci_pwrctl_create_devices(dev);
>
>         /*
>          * Create a device link between the PCI device and pwrctl device (if
>
> --
> 2.25.1
>
>

Would it be possible to move this into drivers/pwrctl/ and provide a
header stub for when PCI_PWRCTL is disabled in Kconfig?

Bart

