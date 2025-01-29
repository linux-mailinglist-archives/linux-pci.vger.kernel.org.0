Return-Path: <linux-pci+bounces-20519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E9A21915
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DBB3A34C4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7A193409;
	Wed, 29 Jan 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbeITJ5A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E12942A;
	Wed, 29 Jan 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139493; cv=none; b=udqrYV+MljSaPuR0pQEBWJeYBEFFKTBPnTtSXdJKhU6XjPX4jGGJAOgYybn1t7G5bNSog6BjBSgkYUhexSe6POetZVxWbjftVFnVzAaa+tSwdK638buwW1hAhYjGRz4yirjtgeDPvrtp7NKWlnXCfG3cXlX1lmSmbUj2h0HB6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139493; c=relaxed/simple;
	bh=1i9xeWHCdj2kFFNXh4FS09VY47+eopjPE5WbdC/+VuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEchgdy9hQ8qjXBWcCYjjtE8dqG5wtdlLLrRLYIhXzTedBTMEBIuV0aXcDbMZtj56s1gTR8HSVD7Xm8JifMpirqOk/+Z47IOr6zFu1l76SdS2ASdmuTPHvL990JilYAxFjMRZBmpKgHb/EWu8f3SglZjE2JjSvM6grIOqhhsc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbeITJ5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117EEC4CED3;
	Wed, 29 Jan 2025 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738139493;
	bh=1i9xeWHCdj2kFFNXh4FS09VY47+eopjPE5WbdC/+VuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbeITJ5A3aFsCDiJ0YtA+smR7T8RShy499XoMdRrgT7eC9F6bytcoa5S6jRtw1Yh3
	 IKD3nnm2LY4CWJiQCJaxnbZ5pgyWesIyiFJZsPxyRH0PBIu7HUn6yWrDkPSGd/3pqs
	 2mNE9dfZrmtS/n1y+HxUP6jF0sTOSGXtT9DfBtoAVCsQxhFBsJoOG7q1uoCg5TfCK8
	 T/aHULTB9UJXQ0fo4mLsoi5nJUV3bP9l9TZSDeQQ4x75EIKdyKwcuCU+wO1ev2dDwk
	 XWWQXz+oVCwsndzleIktZKAqfS+jGi5nmFjcMFBOGU9kZ3ZHarTTl5NuHrxlj4Ucqk
	 L7lZKlMC2Df3Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1td3U1-000000004nP-0heR;
	Wed, 29 Jan 2025 09:31:37 +0100
Date: Wed, 29 Jan 2025 09:31:37 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
Message-ID: <Z5nnaU5VnDK9yNTW@hovoldconsulting.com>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12619233.O9o76ZdvQC@rjwysocki.net>

On Tue, Jan 28, 2025 at 08:24:41PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> resume phase") overlooked the case in which the parent of a device with
> DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
> suspended before a transition into a system-wide sleep state.  In that
> case, if the child is resumed during the subsequent transition from
> that state into the working state, its runtime PM status will be set to
> RPM_ACTIVE, but the runtime PM status of the parent will not be updated
> accordingly, even though the parent will be resumed too, because of the
> dev_pm_skip_suspend() check in device_resume_noirq().
> 
> Address this problem by tracking the need to set the runtime PM status
> to RPM_ACTIVE during system-wide resume transitions for devices with
> DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.
> 
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for tracking this down Mani, and thanks Rafael for the quick fix.

As expected this makes the warning go away also in my setup, and the
patch itself looks correct to me:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

