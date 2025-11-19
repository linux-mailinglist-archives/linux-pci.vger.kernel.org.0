Return-Path: <linux-pci+bounces-41623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C4C6F028
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA7A7387D86
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CF35F8CA;
	Wed, 19 Nov 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo6UkyRg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AC1F94A;
	Wed, 19 Nov 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559398; cv=none; b=JzIMlmdPZe7Dc3NI5z5aJ6V3t/UZINJpMfGIe6uqKkHv6MY8Xmk4zQ3gRY4inDt9SCMd5kWb/Npf74IwEwEpalWLzFpMtP4N/SP+HZUhzrwlFTToHJeC0CJyZPuw0LpdGyvUW6MCmbScy2hervmKWeLUSP7MivFxnSmLGEiHgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559398; c=relaxed/simple;
	bh=b4C1zi6pPGP3ojQqok735+h12MiBEDngE+oY7+3CFSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF3lObWnkZtAf33hV2M+B5i+/AbVa/LkPaZLPFxpfKbGOgnGFJ+65St3CaDK0axQe1gGZQZ81h0lj7xfw49vVrBDC8y4i3ZV6ElnJSAg5FvUBN8T+kDBz1G3W43oTwwvDMoN6E8Lw28/YA8USYtf5XLL74z9s+HmjZnK6h11dYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo6UkyRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22433C2BCC4;
	Wed, 19 Nov 2025 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559397;
	bh=b4C1zi6pPGP3ojQqok735+h12MiBEDngE+oY7+3CFSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo6UkyRgc0Zk2iPBMqAqLRLAXbaw0YpbdMj6flIYDdvUYMHqk9Vy5rK0Ld4F48ejH
	 +fHrpi1PzLlxkpAhxk9K9vjdnbrqT37MghMDLLAuA3cKauq0ZxCn/xOHgXaVLTulUv
	 gVMm2rG9Pu3uvTqao2u2WZWdxkqMj3Do8vJIDPoDWXQL1pfgI5OhTDtfWTBfMn0QUn
	 IGv5J947K2ac5hwdCyUOH7CG6CMvS4OI22KGhQUTB34FWqvuhSAzvG3dNsCX89QFaa
	 /rJq1CJHklHndrvU7v57l9odNuAoP/dxKhS6jph6/oWv1YrLZhFk2eiC9/ABohEkRc
	 2fsd60dFEuDGA==
Date: Wed, 19 Nov 2025 19:06:17 +0530
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
Subject: Re: [PATCH 8/9] Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2
 card
Message-ID: <ncylcv227tpe574pj3yxpbsqx2rdmzf55zejschws56h6herdt@pck2vnhpmehq>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-8-97413d6bf824@oss.qualcomm.com>
 <CAMRc=MdRw+spjN0ySJ7We_GJ8GaDU2Nb4unaxcnr2ZLjLOeSrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdRw+spjN0ySJ7We_GJ8GaDU2Nb4unaxcnr2ZLjLOeSrA@mail.gmail.com>

On Tue, Nov 18, 2025 at 03:29:49PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 12, 2025 at 3:45 PM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > The WCN7850 PCIe M.2 card connected to the UART controller exposes the
> > 'WCN7850' serdev device and is controlled using the pwrseq framework.
> >
> > Hence, add support for it in the driver. It reuses the existing
> > 'qca_soc_data_wcn7850' driver data.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 4cff4d9be3132561ee9bae4ddf2c8ac0bc13ecd7..09bfb3bba93698f496947775bf6b31f2f20279f1 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/acpi.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwrseq/consumer.h>
> > @@ -2344,6 +2345,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >
> >         qcadev->serdev_hu.serdev = serdev;
> >         data = device_get_match_data(&serdev->dev);
> > +       if (!data && serdev->id)
> > +               data = (const struct qca_device_data *) serdev->id->driver_data;
> > +
> >         serdev_device_set_drvdata(serdev, qcadev);
> >         device_property_read_string_array(&serdev->dev, "firmware-name",
> >                                          qcadev->firmware_name, ARRAY_SIZE(qcadev->firmware_name));
> > @@ -2384,6 +2388,15 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >         case QCA_WCN6855:
> >         case QCA_WCN7850:
> >         case QCA_WCN6750:
> > +               if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> > +                       qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
> > +                                                                  "uart");
> > +                       if (IS_ERR(qcadev->bt_power->pwrseq))
> > +                               qcadev->bt_power->pwrseq = NULL;
> > +                       else
> > +                               break;
> > +               }
> 
> Did you by any chance copy this logic from commit: db0ff7e15923
> ("driver: bluetooth: hci_qca:fix unable to load the BT driver")? This
> commit is wrong and it flew under my radar during the summer and I
> never got around to fixing it. It doesn't take into account probe
> deferral.
> 

Ah, yes. I think there is no point in continuing if devm_pwrseq_get() errors
out.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

