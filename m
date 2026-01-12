Return-Path: <linux-pci+bounces-44501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019BD12D9E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 14:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2BC3016CF8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395073596FC;
	Mon, 12 Jan 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYy0IXRw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F92DBF78;
	Mon, 12 Jan 2026 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225024; cv=none; b=QaDdO4i3s/eM26SCuwlDlK683Qu7HXgF20O8aPtPOPyr4Rx9KqcbVr7cRiEQUc43cahFqjuLTG399lvFFQr+o6zxpKZ6IjN3ev02ytckBeT1QvgjvqgljhI3Vw/zSh/Efx2+LLciNxT2oUVdkd9iWzem5tjB1O+P2Jvurb32bbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225024; c=relaxed/simple;
	bh=bzYUe9Krw1KHbB/obzxKLRvZYPhkA90KZUSBQi3hf2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW1sus33ynA3Ie+o7qBBo9rUVvZufwZIr7tblnVFD81LTDZ89JZQEKsxGS6suTQCuzKn9I9smlM+jRmr2AXfcGXGXfolDQPIb5zwn2EWsqabniyhOsAT1GLfaBnSSVOkItXbn5KAUjUapdgp0QJo49hjB2ERyLEkO/HAdYJiK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYy0IXRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6079BC16AAE;
	Mon, 12 Jan 2026 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768225023;
	bh=bzYUe9Krw1KHbB/obzxKLRvZYPhkA90KZUSBQi3hf2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYy0IXRwxYRa6+Eb+mt0hD4IbxIA8k971nzVORZJz0zmrD/N8l/oqWJpUakCf6wyk
	 4cDPflH+DuT8pXO12YmlZzAw/osbsYT5dykv2XNR3OTbA6ujOqz4XfvvS39ltm0Gz8
	 LXG+ptmkdPUMV/1tppmmnwZXLEAlxkNvWXT1rWf8=
Date: Mon, 12 Jan 2026 08:37:02 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, manivannan.sadhasivam@oss.qualcomm.com, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <20260112-miniature-quiet-gorilla-263fed@lemur>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>

On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > I really do not want to see this patch without very good justification
> > (note, there were at least two attempts in the past to add this stuff
> >  and no-one was merged, have you studied those cases?).
> > 
> 
> Yes I did. I didn't put the above justification in the cover letter, as it was
> already overwhelmed with too much information regarding the connector node.
> Maybe I should've added it in the comments section of this patch. But I didn't
> know how to do that with b4.

You can just amend the commit directly and put comments under "---". They
will be preserved when email is sent, but won't be applied when the maintainer
pulls the series.

-K

