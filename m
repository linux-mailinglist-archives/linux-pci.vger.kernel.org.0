Return-Path: <linux-pci+bounces-15277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC079AFBF9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FBA2820FC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C31C07E4;
	Fri, 25 Oct 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rg2wjwSJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CE1B6D00
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843487; cv=none; b=pnCwdeds8bb9gYnlcmrm6ITcuSl92ohjxYaIsaKym1dFMv7p7/IikrJKlR2hJPL0hSbP5vbiB1h9Va63vifyBmyNPVS2xI/fF4LHL0EEjWNJak0N6vLPdB8hRwkbyaTPSh4+18gJ7SKJ6fQY0Ziemzj3cE8G+/E52/Y7oKP3Mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843487; c=relaxed/simple;
	bh=RlNTXHWaff+zW/Ig27eNg95TDnIhVzTtyEJbpUp0Ybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P47Yf5EBqE5Wgbz1R1L0dqKDV3RGxrNnUf9q1TiJYTqdNB10OPxx4RGg7H6qNr2/UL4NiFTYvFNfq97BCvHbk2iopfI4LCYST1nTOGQC/qOjM6Xn4SvzqhLHQsSUI76lGxL9A6YxDqvbyFpHCuslUrkZbkhJmlHJCs9R7++/1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rg2wjwSJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdbe608b3so13749895ad.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729843484; x=1730448284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ToZJO2X6kblaBnpE+g9acjvZjb4BRJvfnxVqud+oi4=;
        b=Rg2wjwSJfIguaBgYijKlgz/Y1ce1SLy7dOFVwvdtwMagmKx2UUtgevxmou9VV/CkVp
         Nh9sXNuKkJSxklAuOIr6piLxbuMYM5LaxPbNqrE6vDZb2AxEYLr2b4frg9oa6Go8TaE+
         oT854RGVkhU9dPZMfES4XqhV0liefLokpnNAXuT7aNWhOEoD7/8AHqIXjRMaX2V4RuNV
         eCya5/Nlw2x9LNHE8We7IUsKCAFZFOOsjlOolSfdu+inNA0KcP3vqwQUj4HFkz0Jel3Z
         eUYJ9p9rBiajRk/l7mP+edD2FQR7EFt7s8AHbsREhGz7/Vt8WYj6Sno1sPB2ATVEKSiW
         WBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843484; x=1730448284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ToZJO2X6kblaBnpE+g9acjvZjb4BRJvfnxVqud+oi4=;
        b=t0imFGm5x9dQvC2n2e57EO/gOnSfJnou7VSdpRNDygoWy7uF/q+dQNoEZhjoN8ZQwA
         lzCha4WSMNuynBGplQeUIzPUerb56Q74mHH+RxIynebv2SjGKLTnWmjTB2DF6GZj4o9E
         tTFZkTy1f8bdlR3nBVBITbD0Rb0x7Ml4iTUvSxISOdBeESxaNQE0pYq7THNrjM5d+q4t
         3Ik03v5yMABd8P/IR2vf/3czJ5pDSNbftSW0AzX1j39D2YZEtUFv/8YRfrwaMZWVgdWQ
         WF7caTcMbSXO71VEOs1z1cvfLBr5Ba6PqTZ2wf7I2UpSNBb/qSSH2WUUbF7t9Vyys3KN
         eyWg==
X-Forwarded-Encrypted: i=1; AJvYcCWqj3LaYVrbe2u6javJYFdEfnQr4zQ3kPWacbq7Try9mnP+NApBjANv5uZBgh1syLRsXaoP6qY1+oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccPLSM3DZBSv3H26wW2RuQy+m6eY1apzDpAwQjKyHh0Sn9kai
	Ad9tuBU5tc7DieYIgdbjmsQWM1HduNS3eVy+M0rxGUr5yJOjxdK+CEp/ZRlyPQ==
X-Google-Smtp-Source: AGHT+IE3xVfBlAkAWoonLR8AHuCAQ391OAv5h0lkzeSWdIeRnLYGcfA4Wu9ZqlOLiWnAQjSychPilw==
X-Received: by 2002:a17:903:244e:b0:20b:6624:70b2 with SMTP id d9443c01a7336-20fa9e13cf2mr124552065ad.19.1729843484373;
        Fri, 25 Oct 2024 01:04:44 -0700 (PDT)
Received: from thinkpad ([120.56.205.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc088565sm4990395ad.306.2024.10.25.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:04:43 -0700 (PDT)
Date: Fri, 25 Oct 2024 13:34:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
Message-ID: <20241025074827.fdkgyz3k767dgdqv@thinkpad>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
 <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org>
 <CACMJSesmyfS4wj=ys16FmqpAoojuChY1OHSC750bjtM23y5baA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACMJSesmyfS4wj=ys16FmqpAoojuChY1OHSC750bjtM23y5baA@mail.gmail.com>

On Wed, Oct 23, 2024 at 12:23:57PM +0200, Bartosz Golaszewski wrote:
> On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > This makes the pci_bus_add_device() API easier to maintain. Also add more
> > comments to the helper to describe how the devices are created.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/bus.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 41 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 351af581904f..c4cae1775c9e 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -321,6 +321,46 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
> >
> >  void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
> >
> > +/*
> > + * Create pwrctl devices (if required) for the PCI devices to handle the power
> > + * state.
> > + */
> > +static void pci_pwrctl_create_devices(struct pci_dev *dev)
> > +{
> > +       struct device_node *np = dev_of_node(&dev->dev);
> > +       struct device *parent = &dev->dev;
> > +       struct platform_device *pdev;
> > +
> > +       /*
> > +        * First ensure that we are starting from a PCI bridge and it has a
> > +        * corresponding devicetree node.
> > +        */
> > +       if (np && pci_is_bridge(dev)) {
> > +               /*
> > +                * Now look for the child PCI device nodes and create pwrctl
> > +                * devices for them. The pwrctl device drivers will manage the
> > +                * power state of the devices.
> > +                */
> > +               for_each_child_of_node_scoped(np, child) {
> > +                       /*
> > +                        * First check whether the pwrctl device really needs to
> > +                        * be created or not. This is decided based on at least
> > +                        * one of the power supplies being defined in the
> > +                        * devicetree node of the device.
> > +                        */
> > +                       if (!of_pci_is_supply_present(child)) {
> > +                               pci_dbg(dev, "skipping OF node: %s\n", child->name);
> > +                               return;
> > +                       }
> > +
> > +                       /* Now create the pwrctl device */
> > +                       pdev = of_platform_device_create(child, NULL, parent);
> > +                       if (!pdev)
> > +                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> > +               }
> > +       }
> > +}
> > +
> >  /**
> >   * pci_bus_add_device - start driver for a single device
> >   * @dev: device to add
> > @@ -345,24 +385,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >         pci_proc_attach_device(dev);
> >         pci_bridge_d3_update(dev);
> >
> > -       if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
> > -               for_each_child_of_node_scoped(dn, child) {
> > -                       /*
> > -                        * First check whether the pwrctl device needs to be
> > -                        * created or not. This is decided based on at least
> > -                        * one of the power supplies being defined in the
> > -                        * devicetree node of the device.
> > -                        */
> > -                       if (!of_pci_is_supply_present(child)) {
> > -                               pci_dbg(dev, "skipping OF node: %s\n", child->name);
> > -                               continue;
> > -                       }
> > -
> > -                       pdev = of_platform_device_create(child, NULL, &dev->dev);
> > -                       if (!pdev)
> > -                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> > -               }
> > -       }
> > +       pci_pwrctl_create_devices(dev);
> >
> >         /*
> >          * Create a device link between the PCI device and pwrctl device (if
> >
> > --
> > 2.25.1
> >
> >
> 
> Would it be possible to move this into drivers/pwrctl/ and provide a
> header stub for when PCI_PWRCTL is disabled in Kconfig?
> 

Unfortunately, no. Because the pwrctl drivers are modular and PCI core is
built-in. So if we use the pwrctl APIs in PCI core, then it will require pwrctl
to always be built-in, which we do not want.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

