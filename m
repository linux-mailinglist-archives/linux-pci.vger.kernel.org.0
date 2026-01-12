Return-Path: <linux-pci+bounces-44528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCFD1424C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4552230BCA8E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515BC366DC6;
	Mon, 12 Jan 2026 16:42:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BBA2E265A;
	Mon, 12 Jan 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236133; cv=none; b=H9q+y51QMndzKRQRIjuXSVTIaHdryxwVapwrF2mwa/flKIggkfYYRT50zVM15/piBOBmUABSdLKzFfhmlkQRmIENB49TOkZNdc2LpS8+4b5P2OT41LyJLqa1pGy+1zwU8ERUcwc/TpQL8QyfTBt+/rXnjFac5JhkYaDDH5/hVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236133; c=relaxed/simple;
	bh=p+zhbcd+Ejgo7BjYXu0FBHtSgAxS8QssHtymENbdr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne4AcgnaFmV0yF/V9UOVJLaxtg4+1et3Fl6HUmv2y7/S30n+R07z6iDJLv9CMMG936TtPO6/IHY/8twHkGF3XG/B7WC7XIqWCHH8j6/Y3MX5PENm31Y5EIAaAMjdiF7Lpblt4U0emcg7k2tA/v24QB4YuL7WpWko9np0hzHjLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63631C116D0;
	Mon, 12 Jan 2026 16:42:01 +0000 (UTC)
Date: Mon, 12 Jan 2026 22:11:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
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
Message-ID: <6xnoqml2iwipcfm2byrswm7xmhehzbjbdgeets7qpyiez6le6z@vrtcqoaaqwgx>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
 <20260112-miniature-quiet-gorilla-263fed@lemur>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112-miniature-quiet-gorilla-263fed@lemur>

On Mon, Jan 12, 2026 at 08:37:02AM -0500, Konstantin Ryabitsev wrote:
> On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > > I really do not want to see this patch without very good justification
> > > (note, there were at least two attempts in the past to add this stuff
> > >  and no-one was merged, have you studied those cases?).
> > > 
> > 
> > Yes I did. I didn't put the above justification in the cover letter, as it was
> > already overwhelmed with too much information regarding the connector node.
> > Maybe I should've added it in the comments section of this patch. But I didn't
> > know how to do that with b4.
> 
> You can just amend the commit directly and put comments under "---". They
> will be preserved when email is sent, but won't be applied when the maintainer
> pulls the series.
> 

Ah, thanks for the info!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

