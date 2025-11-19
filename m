Return-Path: <linux-pci+bounces-41631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B7C6F1C1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C03812EA53
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492DF363C5A;
	Wed, 19 Nov 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiwsSHVB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574C366575;
	Wed, 19 Nov 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560471; cv=none; b=WFw5dQUAwTSsjfsPmvwdogIx+l2aBKHEdZ9Ki+y2kLc9FyTTC65ZWq9XP63cL4LUWSwwtQpPoO0YyIZ/yC+7hHVpYHsAWS/zB7T0bRoCZCJr5q5W2MuzlfV8xZrv8bYViAFPHqw9qrEi9YPC3GUo5uMhWYWIEB+ndIyfBjT3ajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560471; c=relaxed/simple;
	bh=H2MmjTun/d2cwMOlmdoW2i7WyqB09cABdEW/N90tSjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vheI8Tz9DnmedoyLf6OmuZxhy1fZeGHrRGlEoLjdeQuR4J6rn4VNzbx/nN2/4tfvPizToI/nR71nbpyLsa9a6MbV2yI+P9yTIje36ttbNSlSWHkTZXgSIBVJaDR6D2AGsWKTBhl57MmEulzHpiq1I9DeLHYVOr5XwABhG81HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiwsSHVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC790C2BC86;
	Wed, 19 Nov 2025 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560470;
	bh=H2MmjTun/d2cwMOlmdoW2i7WyqB09cABdEW/N90tSjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiwsSHVBC8qiiXtRWrusuo5cDlObMGrhdRWLjmLPRgS4nIF0Ah28evTGM27AXSHTF
	 04qeDfXp4+4oodk7nmggYhcHB9dKxFmRPFi7elkpqBQbTsSec8RvcwKeKV8efzfDnE
	 ogXEpEcK9QZVDNmB/KgT4GjzDtLdSDUmqGMM6e1OhwI8nRyBdxGIx5VGLizR+t+lLi
	 L+C/Zjb6VmeyUwFMMM4PyGlHqxJCFxYAPA2//qkd0QM8NMiNKGaRqwg7pSrfdiYuf9
	 TsZFno8dCh1P2jHQwkfL/wic7WkP1WzmZuok3IGPlak5KTijO5CRCk4mCDWCL8QTdf
	 gIEmTteUmlZFw==
Date: Wed, 19 Nov 2025 19:24:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 9/9] power: sequencing: pcie-m2: Add support for PCIe M.2
 Key E connectors
Message-ID: <igtegc4wgi3xiolpbilr3jw7c4xlyrj2d4bqb4b4m2yxcxutjh@4evsl2w6taud>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-9-97413d6bf824@oss.qualcomm.com>
 <CAMRc=MeyeyuNVP6CWcxNp8XSCT+P9ZNmgSj6Hktrv8ZYNN5kMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeyeyuNVP6CWcxNp8XSCT+P9ZNmgSj6Hktrv8ZYNN5kMg@mail.gmail.com>

On Wed, Nov 19, 2025 at 02:28:00PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 12, 2025 at 3:45 PM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > Add support for handling the power sequence of the PCIe M.2 Key E
> > connectors. These connectors are used to attach the Wireless Connectivity
> > devices to the host machine including combinations of WiFi, BT, NFC using
> > interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.
> >
> > Currently, this driver supports only the PCIe interface for WiFi and UART
> > interface for BT. The driver also only supports driving the 3.3v/1.8v power
> > supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
> > connectors are not currently supported.
> >
> > For supporting Bluetooth over the non-discoverable UART interface, the
> > driver currently creates the serdev interface after enumerating the PCIe
> > interface. This is mandatory since the device ID is only known after the
> > PCIe enumeration and the ID is used for creating the serdev device.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >
> > +static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
> > +{
> > +       struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +       gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
> 
> Since this is new code and gpiod_set_value_cansleep() now returns an
> integer, can you do
> 

Ack

>   return gpiod_set_value_cansleep()?
> 
> Same elsewhere.
> 
> >
> > +static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
> > +                             void *data)
> > +{
> > +       struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
> > +       struct pci_dev *pdev = to_pci_dev(data);
> > +       struct device_node *remote;
> > +       struct serdev_controller *serdev_ctrl;
> > +       struct serdev_device *serdev;
> > +       struct device *dev = ctx->dev;
> > +       int ret;
> > +
> > +       /*
> > +        * Check whether the PCI device is associated with this M.2 connector or
> > +        * not, by comparing the OF node of the PCI device parent and the Port 0
> > +        * (PCIe) remote node parent OF node.
> > +        */
> > +       remote = of_graph_get_remote_node(dev_of_node(ctx->dev), 0, -1);
> > +       if (!remote || (remote != pdev->dev.parent->of_node)) {
> > +               of_node_put(remote);
> 
> You could really use some __free(device_node) here. It would simplify
> the code below quite a bit and make sure you don't miss anything.
> 

Ack. I'm still trying to get used to the scope based cleanup :)

> > +               return NOTIFY_DONE;
> > +       }
> > +       of_node_put(remote);
> > +
> > +       switch (action) {
> > +       case BUS_NOTIFY_ADD_DEVICE:
> > +               /* Create serdev device for WCN7850 */
> > +               if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> > +                       remote = of_graph_get_remote_node(dev_of_node(ctx->dev), 1, -1);
> > +                       if (!remote) {
> > +                               of_node_put(remote);
> > +                               return NOTIFY_DONE;
> > +                       }
> > +
> > +                       serdev_ctrl = of_find_serdev_controller_by_node(remote);
> > +                       of_node_put(remote);
> > +                       if (!serdev_ctrl)
> > +                               return NOTIFY_DONE;
> > +
> > +                       serdev = serdev_device_alloc(serdev_ctrl);
> > +                       if (!serdev)
> > +                               return NOTIFY_DONE;
> > +
> > +                       ret = serdev_device_add(serdev, "WCN7850");
> > +                       if (ret) {
> > +                               dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
> > +                               serdev_device_put(serdev);
> > +                               return NOTIFY_DONE;
> > +                       }
> > +               }
> > +               break;
> > +       }
> > +
> > +       return NOTIFY_DONE;
> > +}
> > +
> > +static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port, const char *node)
> > +{
> > +       struct device_node *remote;
> 
> Same here.
> 
> > +
> > +       remote = of_graph_get_remote_node(dev_of_node(dev), port, -1);
> > +       if (remote && of_node_name_eq(remote, node)) {
> > +               of_node_put(remote);
> > +               return true;
> > +       }
> > +
> > +       of_node_put(remote);
> > +
> > +       return false;
> > +}
> > +
> > +/*
> > + * If the connector exposes a non-discoverable bus like UART, the respective
> > + * protocol device needs to be created manually with the help of the notifier
> > + * of the discoverable bus like PCIe.
> > + */
> 
> I really like this idea BTW!
> 
> > +static void pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, struct device *dev)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        * Register a PCI notifier for Key E connector that has PCIe as Port 0
> > +        * interface and Serial as Port 1 interface.
> > +        */
> > +       if (pwrseq_pcie_m2_check_remote_node(dev, 1, "serial")) {
> > +               if (pwrseq_pcie_m2_check_remote_node(dev, 0, "pcie")) {
> > +                       ctx->dev = dev;
> > +                       ctx->nb.notifier_call = pwrseq_m2_pcie_notify;
> > +                       ret = (bus_register_notifier(&pci_bus_type, &ctx->nb));
> > +                       if (ret) {
> > +                               dev_err_probe(dev, ret, "Failed to register notifier for serdev\n");
> 
> If this is optional and we don't handle the error, should we really
> print it as one? I'd say a dev_dbg() would suffice unless the failure
> here impacts the driver's behavior (which it does, so maybe the
> notifier should not be optional?).
> 

Fair enough. I was on double mind tbh. But it makes sense to return failure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

