Return-Path: <linux-pci+bounces-4945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FC880F18
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4851C21A99
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB03BB4B;
	Wed, 20 Mar 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOGHfPBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38C3A1DD;
	Wed, 20 Mar 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928352; cv=none; b=c2x2rROwZxRQagYkHx7T7jsHnKPUbdI9LAY6Pkr9G0blIC4jGE/G3BWmRCCgbxP+7Mq8jJml5BQmGRRvGK16wLeBxW5xHCxT8GVcIU0yYKV3tte60F5fuJ4sAJtJxgl0c/F9oobxyiFwo80EOmjqYcdPv1YcbzLRUcLiYrz0amQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928352; c=relaxed/simple;
	bh=xL/Cti2wD9PvualWZlfHsEhTv0Hvo2bjVwZkw7Orp2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsVXH6qf+3ESvTzsd1CN5HitWgGcZaTVe3JSQrCcrAUAUwTSILGYsGfYL6zBTZvudSxekhIAI1EVmvIkvjYORs8ap4NiC0ea0EGjYPG3Oe+0tk85SNydyQDpuJQwuktNJ6/rV4sKCsJqKNiXct3UjO9UktGA0HqESMlECsyzCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOGHfPBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B5CC433C7;
	Wed, 20 Mar 2024 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710928350;
	bh=xL/Cti2wD9PvualWZlfHsEhTv0Hvo2bjVwZkw7Orp2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOGHfPBbGfB2A9VwZ6/lkVr2qzrakEJSnm2UX4WKWqVr+YtCAzq9NVQeLEGnZOrpE
	 9eLNt1FMoX/EFATPeRyzOcrqx5bBOH30SmYb05Odi/Ze2NOOEk61+pdnnPamFXjg45
	 y/pKmHT11MiSDQp8MEO2btjKDS7+kJv8e4X4EkemumRyvA3uTEzXEqioSXWrHJ7mim
	 ovOnHxhaaAjNtFHVyn4doyeCcqClkFvBbgLC0T5F9ZcI3HwZjtrbIQhUjkIZqCpnLU
	 nzG1xvRx5lTqhf82FEJIGJGC/ZyYSF4+uZ3icMIv6Sn+eTo0iix7A64EmGYAySmr1Q
	 ia+HiodvPjw3w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmsce-000000004Kr-3pt5;
	Wed, 20 Mar 2024 10:52:37 +0100
Date: Wed, 20 Mar 2024 10:52:36 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
Message-ID: <Zfqx5IP__IV_hjoT@hovoldconsulting.com>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
 <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
 <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>
 <Zfqb8jPK50vlqu5Q@hovoldconsulting.com>
 <baf9c1bd-84ef-4ecb-b229-51a83fe82c3f@linaro.org>
 <ZfqhCKoEL4XGRs7T@hovoldconsulting.com>
 <cc5d4fc1-14e7-4a73-80bf-6375e44162a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc5d4fc1-14e7-4a73-80bf-6375e44162a3@linaro.org>

On Wed, Mar 20, 2024 at 10:16:16AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2024 09:40, Johan Hovold wrote:

> > At the time there was still hope that there may be an rc8, and the patch
> > in question had been used by a large number of X13s users for several
> > weeks, which is a lot more testing than the average Qualcomm patch
> > receives, whether it's in linux-next or not.
> 
> OK, it does solve some parts of our discussion but does not solve my
> earlier comment: Fixes should be separate series. Certain folks have
> quite strict requirement on this. Try sending a fix with non-fix
> (depending on fix somehow like here) to Mark Brown. He has even template
> for such case...

That's not a general rule at all.

> > And patch 5 depends on the earlier patches in the series so it belongs
> > in the series, which was also initially posted long before the merge
> > window.
> 
> The dependency is might not be good enough reason to combine fixes and
> non-fixes into one series. Dependency should be explained (in 5th
> patch), but it's maintainer's judgement and job to handle this.

FFS, I'm posting a series adding a new feature, which depends on first
addressing a few related bugs. I post everything together so that it can
be evaluated and tested together. That's perfectly fine, and not that
different from how we post driver and dts changes in one series to
facilitate review. Some maintainers don't like that either, then we deal
with that.

Johan

