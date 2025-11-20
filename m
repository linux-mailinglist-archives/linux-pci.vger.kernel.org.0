Return-Path: <linux-pci+bounces-41814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD7C75851
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D56C4E16C6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAD36C0DE;
	Thu, 20 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK/ZXygo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE12874F5;
	Thu, 20 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657688; cv=none; b=nQkNr8b/SeBmWR9nNJs/4q+MLjh8bLlMWsdYtP1MOOZzVEYWrG5v/rTIUxJ8WmfkT5/u65cPVb003gG6GmpBlvKsZjLBROEjgrXWqRaVLY9MJEzGPRycbqSyh0gSMofFAzZJXKL2BCixFN6+TT/EvONsz24XnqyG12y48XMLMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657688; c=relaxed/simple;
	bh=7RlJgO0bn3IQUwfaWF5A5gBBgoG4DUcrllB7yObH7KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjN7Hqoe+pMesYYl59SHEntNwfZYOVitWNTMLuvlKYzaWUgyMe/ktib/t1TNEKXLG4CWBh1H5dBZ8MSwXzT6jJvtfd7YlH1w+UKoAZJfenNfWuZJUfHy2zNd0zWa8LrmMZrbwGZXgYjmEbvlIayEHHaY0dQBOygiVmfFnaa6N2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK/ZXygo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51418C4CEF1;
	Thu, 20 Nov 2025 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657687;
	bh=7RlJgO0bn3IQUwfaWF5A5gBBgoG4DUcrllB7yObH7KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oK/ZXygo0+HJVRL1dGc2x1xDyykr2qJuxy9hlNMyPRPzGG+8NMayKfzWmw+R6Bks7
	 zyojuibYxSUmBoBY9wjhfb43NO9giDXA7vx8gBMfjr/8LQIaYvRMvZ6ACsHiMbgzjq
	 NJDFuGV9RKFcdQSEb1JDDEnFUjd6YM3rGWae0hwPLnbeyaa9wGYyYQLhF03Umc4WFb
	 PW2ADyTK72HpLutxMVJhk+HkKz5au0EeujP3qdGrmz/HHsPtUrYEgxIe5LPgjDlp6q
	 S1ZWqQPLybPUdcut5h8hQjJWD3waRP3UuCTKe4LWXvgHNEg+YNEh8YNZwLZ8v4xnk7
	 S8RktxhAFysUw==
Date: Thu, 20 Nov 2025 22:24:24 +0530
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
Message-ID: <blqs5xugab5kumljzrt26dvyhnun2pmpeu4y727xoz3vrponrt@bbxqnl55zhky>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-6-97413d6bf824@oss.qualcomm.com>
 <CAL_JsqKBcXH0EWguto3EFY2cJ5p=8VUZczMHz1u5fNFocv-AmA@mail.gmail.com>
 <cjtnoqjr3v5o64caa6unllb2e2csyvybr6vnzwuqqrl453bgz7@drqmfkfbn5xg>
 <CAL_JsqLoD5GiiGgWTEa6-g8VwyuPTko-ewe5CKPBWMgHDnKaHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLoD5GiiGgWTEa6-g8VwyuPTko-ewe5CKPBWMgHDnKaHg@mail.gmail.com>

On Thu, Nov 20, 2025 at 10:22:16AM -0600, Rob Herring wrote:
> On Wed, Nov 19, 2025 at 7:33 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Nov 18, 2025 at 07:03:51AM -0600, Rob Herring wrote:
> > > On Wed, Nov 12, 2025 at 8:45 AM Manivannan Sadhasivam via B4 Relay
> > > <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> > > >
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > >
> > > > If an external connector like M.2 is connected to the serdev controller
> > > > in DT, then the serdev devices will be created dynamically by the connector
> > > > driver. So skip registering devices from DT node as there will be no
> > > > statically defined devices.
> > >
> > > You could still have statically defined devices. You are just choosing
> > > to probe them later from the connector driver.
> > >
> >
> > The point of coming up with the M.2 binding is to avoid hardcoding the devices
> > in DT. So static devices are ruled out IMO.
> 
> Until you have any one of the reasons we have PCIe devices described
> even when in a standard slot. Take your pick. An ethernet adapter that
> omits an EEPROM for the MAC address.
> 

Hmm, I didn't envision the need to have static and dynamic devices at the same
time. So you are suggesting to first look for the static devices and then look
for graph port at the end?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

