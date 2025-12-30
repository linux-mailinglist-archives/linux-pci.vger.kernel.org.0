Return-Path: <linux-pci+bounces-43827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8ECE8F0F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 08:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B7130133AB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5832FDC25;
	Tue, 30 Dec 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grGfBoqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179020C488;
	Tue, 30 Dec 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081416; cv=none; b=t4w8sHFZxzCnG05E6oqF52aGUgC/Vauq8LUQooinEYiX7i8nDtf2UObsO1v8oPOIlQyPzzrzNxMKRB1ENg5XhsFd+TNmL8OAVt83rMErJSL++mSWDhSn1pe5i8nnY7VgygizLrjS34J/fAxlMN1LMFYvHoba0/JSSozJR5DRVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081416; c=relaxed/simple;
	bh=JQyJb0YO5UFCqTEMft7JYBt0dtj33bVTcB90Vzhv7nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbdU1FESE/xrX76rICUkSGJVRwpFNHq33ZUubkLTMaL5UCzD1qzFApBulnjrItULxcD92xn6BQUKtUxT2tDn0l6ZpZzbd0FIoW9H/JaViuhQNkbYN0UTNUPf7LJQ5jxzOfKh6uGjVYPu1xv6ntymAbSHO4YqmOCAmf7ObPdxkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grGfBoqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE61C4CEFB;
	Tue, 30 Dec 2025 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767081415;
	bh=JQyJb0YO5UFCqTEMft7JYBt0dtj33bVTcB90Vzhv7nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grGfBoqYLdMenwlVJlFoKeI96hBqPO466UsO0CBp1nQU4ar+5Lb4RTl5XsuwVBHeQ
	 KYgpF/mm0VjqL+ciQgRRDgQnygsxEf3B1uDOumDxzVpqGXxioNxx4f5Ki+bVStaVU3
	 kFwjQE/iU08dumlwXS1zY1fMG/Zg8e79EdU0Dz+Lk6azo44IBIaewupl4SXcp6aaNI
	 F2ywmbVKxPrWn7+hBg2MuKMyDffJRYu48BjEDYAQ08NhGvqXIcLkvS+R9TYLWIs5jN
	 D5Vl3zyTWrNWEd0ngDID4dFoMWESa+pzcuyZBwcYy54IliVq1XyxrgW15vMyXRF3j1
	 EQLF5DT3UzL1Q==
Date: Tue, 30 Dec 2025 13:26:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2 02/10] serdev: Add serdev device based driver match
 support
Message-ID: <fwzmob6ez7c6xbakcd4rq2icp7mdwgdvimss3zybb4ivdds3uo@mwguaz7rekjc>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
 <20251125-pci-m2-e-v2-2-32826de07cc5@oss.qualcomm.com>
 <CAMRc=Mc-WebsQZ3jt2xirioNMticiWj9PJ3fsPTXGCeJ1iTLRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc-WebsQZ3jt2xirioNMticiWj9PJ3fsPTXGCeJ1iTLRg@mail.gmail.com>

On Thu, Nov 27, 2025 at 06:32:04AM -0800, Bartosz Golaszewski wrote:
> On Tue, 25 Nov 2025 15:45:06 +0100, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > Add support to match serdev devices with serdev drivers based on the serdev
> > ID table defined in serdev_device_driver::id_table.
> >
> > The matching function, serdev_driver_match_device() uses the serdev device
> > name to match against the entries in serdev_device_driver::id_table.
> >
> > If there is no serdev id_table for the driver, then serdev_device_match()
> > will fallback to ACPI and DT based matching.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/tty/serdev/core.c         | 23 ++++++++++++++++++++++-
> >  include/linux/mod_devicetable.h   |  7 +++++++
> >  include/linux/serdev.h            |  4 ++++
> >  scripts/mod/devicetable-offsets.c |  3 +++
> >  4 files changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index b33e708cb245..2b5582cd5063 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -85,12 +85,33 @@ static const struct device_type serdev_ctrl_type = {
> >  	.release	= serdev_ctrl_release,
> >  };
> >
> > +static int serdev_driver_match_device(struct device *dev, const struct device_driver *drv)
> > +{
> > +	const struct serdev_device_driver *serdev_drv = to_serdev_device_driver(drv);
> > +	struct serdev_device *serdev = to_serdev_device(dev);
> > +	const struct serdev_device_id *id;
> > +
> > +	if (!serdev_drv->id_table)
> > +		return 0;
> > +
> > +	for (id = serdev_drv->id_table; id->name[0]; id++) {
> > +		if (!strcmp(dev_name(dev), id->name)) {
> > +			serdev->id = id;
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> I don't know if Rob agrees with me but I would very much prefer to see
> software-node-based approach instead of an ID table matching.
> 
> Could you in the pwrseq driver, create a software node for the serdev device
> you allocate, set its "compatible" to "qcom,wcn7850-bt" and match against it
> here?
> 
> This has several benefits: if you ever need to pass more properties to the
> serdev devices, you already have a medium for that and you can also leave
> serdev_device_add() alone. You're comparing the entire name here - what if
> someone sets device's ID to some value and the name will be "WCN7850.2"?
> 
> You could also drop the serdev_id field from struct serdev_device. For matching
> you could even reuse the of_device_id from the device driver.
> 

I tried this approach and I really liked it since it gets rid of the yet-another
id_table for serdev (which I didn't like it btw). But there is one concern
though. We need a generic 'device_get_match_data' implementation for swnode.
While trying to implement it, I stumbled upon this patch [1] which does the same
for other usecase, but there was a disagreement on whether swnode should be used
for driver matching or not. For my usecase, I find it very useful and
reasonable, but Dmitry Torokhov believes otherwise.

Maybe I'll include this patch in the next version, CC Dmitry and see where it
goes.

> Which also makes me think that maybe we should finally think about a generic,
> fwnode-based device driver matching in the driver model...
> 

Yes, that would be useful too and will allow me to get rid of the custom
matching logic in serdev core.

- Mani

[1] https://lore.kernel.org/all/20240427203650.582989-1-sui.jingfeng@linux.dev

-- 
மணிவண்ணன் சதாசிவம்

