Return-Path: <linux-pci+bounces-44480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF69D112DC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8935B3004CFD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658933E35A;
	Mon, 12 Jan 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5CuCvyh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861A1B81A1;
	Mon, 12 Jan 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206009; cv=none; b=W0ocR5O2/L0lTQsYAC0Afew06CW8fRl1aPpvWJphM15JQXOsZ7eBvgCcA6NalaCGZHAK7i8My4T4TMFaCZtNqXl3KmilgFELNT22aaqLAFN3jVwIE/d8/MukkPksHEMd09LNkBgCj6jK7Tia/t+pK8pM1kh245DTMNvuwBrjsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206009; c=relaxed/simple;
	bh=ObX+40NwErgZLVy8CTMLW715TtcaqkDgsLRG8Rr9aJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZiWTnVq2WPvOORnXotkNHzcQuUJjbnk5jAcF8+YaAZtafaffBOwHcMMjig6XuRGzOLRqoA3sBiKMD+OZTjkhsueCC+z3fdNFK6zm9EuhBv7I9UzBjcm1ziD2Dcdkclff1xq5qI+vJRs3RPlSyoGTJ9gOrdhOAhGzOHod5+jpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5CuCvyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F3FC116D0;
	Mon, 12 Jan 2026 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768206009;
	bh=ObX+40NwErgZLVy8CTMLW715TtcaqkDgsLRG8Rr9aJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5CuCvyhm2riEqGGgzes8RZtIEOU75MGImNDFuozGz2Jz+F9dTzS6vcg4adqbEq+D
	 Y0uG7NkQ21KMaqfUq/O/1CtMAjnIq2FXP2BBG9svamx10MWrLpOCdL0M4lQnG8uoVv
	 HbTXahN4reNjYfBZ+ypD7Hlo+AcK9Z8w8ZumZZ2M3AQcBRK8btY5aLdRK4Ef9HcyYz
	 8DMfamTVtgpnY7KmQs+odq13vph91FQIlRd2faJxFw/IY3ZEBn+GRQvREvv0puBp4R
	 1GE2AmwyQkkCT2UEryiQ2PwetHQLQrqU4Mzn8EO0L+0N83mwtebBFJrjqoHfK0yKgc
	 9viWCGiBFSXcw==
Date: Mon, 12 Jan 2026 13:49:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWSpFk9z0zpyKjr6@smile.fi.intel.com>

+ Dmitry Torokhov (who was against this patch previously)

On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > Because the software node backend of the fwnode API framework lacks an
> > implementation for the .device_get_match_data function callback.
> 
> Maybe this is done on purpose. Have you thought about this aspect?
> 

IMO, software nodes were introduced to add sub-properties to the existing
firmware nodes, but it has usecase/potential to go beyond that. More below.

> > This makes it difficult to use(and/or test) a few drivers that originates
> > from DT world on the non-DT platform.
> 
> How difficult? DSA implementation went to the way of taking DT overlay
> approach. Why that one can't be applied here?
> 

Sometimes you do not have any DT node at all. For example, in this series, the
M.2 pwrseq driver creates the serdev software device for the M.2 BT card to
match it with the existing OF based BT driver (for non-M2 device). From the
driver's point of view, a BT device attached to the M.2 slot and over custom
connectors are both the same. Only difference is that, in the case of custom
connectors, the bluetooth DT node will have the BT device described and in the
case of M.2, the device won't get described, but just the connector [1]. But for
the driver to identify the device (since it cannot enumerate it), either it has
to rely on DT/ACPI or some other means.

In the previous version of this series [2], I used the serdev ID based on the
product name for creating the serdev device and added a new id_table for serdev
driver to match with the device [3]. This almost duplicated the existing OF
match logic. Then Bartosz suggested to use swnode approach [4], to get rid of
the custom serdev ID based matching. When I prototyped, it mostly worked well,
except that swnode needed to have its own .device_get_match_data(), match() and
uevent/modalias functions. And if the swnode reused the existing DT compatible
string, it can work with the existing BT driver without modifications. And this
approach can also be extended to devices instantiated from the board specific
drivers.

[1] https://lore.kernel.org/all/20260110-pci-m2-e-v3-10-4faee7d0d5ae@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com/
[3] https://lore.kernel.org/all/20251125-pci-m2-e-v2-2-32826de07cc5@oss.qualcomm.com/
[4] https://lore.kernel.org/all/CAMRc=Mc-WebsQZ3jt2xirioNMticiWj9PJ3fsPTXGCeJ1iTLRg@mail.gmail.com/

> > Implement the .device_get_match_data fwnode callback, which helps to keep
> > the three backends of the fwnode API aligned as much as possible. This is
> > also a fundamental step to make a few drivers OF-independent truely
> > possible.
> > 
> > Device drivers or platform setup codes are expected to provide a software
> > node string property, named as "compatible". At this moment, the value of
> > this string property is being used to match against the compatible entries
> > in the of_device_id table. It can be extended in the future though.
> 
> I really do not want to see this patch without very good justification
> (note, there were at least two attempts in the past to add this stuff
>  and no-one was merged, have you studied those cases?).
> 

Yes I did. I didn't put the above justification in the cover letter, as it was
already overwhelmed with too much information regarding the connector node.
Maybe I should've added it in the comments section of this patch. But I didn't
know how to do that with b4.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

