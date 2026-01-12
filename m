Return-Path: <linux-pci+bounces-44473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E996D10FDE
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 927C730092B7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7A833986B;
	Mon, 12 Jan 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urpafOyH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAE3382E8;
	Mon, 12 Jan 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204535; cv=none; b=Q9Enqa4567qnfN2QH91DlMFHHiFm89YR4RDH6VweDbavb1iHcCnTtwTWCdHDOPOk5BBB9GNhDZw0wMEblWxz0RsUIP7XJzUGA2I5lnqDgdxV3F8c3q9dkpsVTsmA2cNWyYF4BRi1U2A814qcHBKkmjtEVq464NdPiRHpb1wUrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204535; c=relaxed/simple;
	bh=4CSOdo9eYhE5PJT7HC+kQNABtdEv9KppJNeo2lA16Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCq/UP9lAYpEB8oQat7qGCBI2uPOjYHCYYZUMkycF+8mzEAcZf5Si6iayhhhHETiYxLUxcVyAsRzfgj1dCUVczNbJg1jXniSIV3HoL8rP4gDgf6k/ytRue8/THAS79P+DEO+cmsIYynTUu+5JONhFhCm2jYARX0NBLPjcjgoE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urpafOyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED628C116D0;
	Mon, 12 Jan 2026 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768204535;
	bh=4CSOdo9eYhE5PJT7HC+kQNABtdEv9KppJNeo2lA16Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urpafOyHO/le+6imDzmzeWwPRk7lXh4ZaIv/v56i00WXjTJ45kPKUUBkZQm7+YZU/
	 Ygfjjd7byCEFtH+VlheKanHxyQrywGkMJysK3CD/EvnVISIiFYUWh/nZyoGtUin0T+
	 ID4+9KpJlgaph+jeX+gYZALDAzd7Cnt/+/+fUTzg0F9pHto/gLevLlgyKzVFsvxJIN
	 HvO9OYm69hDZgBAViHyNubURSwAF5gHEiUbJTpMKHQUV5tl+Xn4fDs+D4ppA3+irmy
	 aFjpNqtJUlyWoLvOHlUeRMrYFN0LGLkvYNGqNdLUq2jP9/Dx5d59QAgpdWFVp3MAY8
	 1uE0VZR74ydJQ==
Date: Mon, 12 Jan 2026 13:25:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 02/14] serdev: Add an API to find the serdev
 controller associated with the devicetree node
Message-ID: <xbzcmhuebjlhsn7zumudeel7dbcmrslxcrxde23rgxrmvoy73h@aj6yxcpuzh46>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-2-4faee7d0d5ae@oss.qualcomm.com>
 <aWSnyc8Eiq56ckXB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWSnyc8Eiq56ckXB@smile.fi.intel.com>

On Mon, Jan 12, 2026 at 09:50:33AM +0200, Andy Shevchenko wrote:
> On Sat, Jan 10, 2026 at 12:26:20PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > Add of_find_serdev_controller_by_node() API to find the serdev controller
> > device associated with the devicetree node.
> 
> Why OF-centric code? No, please do it fwnode-based.
> 

No issues for me. But the existing APIs in serdev are OF based. If uniformity is
not needed, I can change it to a fwnode based API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

