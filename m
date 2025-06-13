Return-Path: <linux-pci+bounces-29727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E75AD8ED0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272FA3A1412
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE42E92D7;
	Fri, 13 Jun 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlxRmIjY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87550230269;
	Fri, 13 Jun 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823016; cv=none; b=Wr1j7k/RqLcbuGAkBVS3Z2NE2IwxUg5PyARKdaa862DVYSdvBql5SH2YhQ+7faCSfsattgVaxy8OtDxIBoSgie/XDwqafjZsHGqPiTvbJ2PTiogNWwM6MRM3y0g6QxLkcDFKXccIh8MA9eHrbOlDm5C0wPqMsdFNJcUgTBgJlAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823016; c=relaxed/simple;
	bh=pqqmjyCXZZ0bEvnRtKy6568CVn9/zn32/fe0b6yqKC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2iS4Ggy3RY5+bt7cXuthQ2UWHHKHqEEP2OAuyy8cN4msONVNkFD5tYlIKqiahpC3ztE+veTLI0PGIIPwpxmqBkiYyqrs+HO8d8OsNsgQkejY74qJu0TODFCMay6o2BgqkRNrykkrFjkaX4v++6mlTWnJ18Q3UlpUU6GhIfhCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlxRmIjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBAC4CEE3;
	Fri, 13 Jun 2025 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749823014;
	bh=pqqmjyCXZZ0bEvnRtKy6568CVn9/zn32/fe0b6yqKC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlxRmIjYsxLlWlVIWgNP7RRNrSkRqTKfFh/RLjujROKF6mKVxyQsz+XuWmJvrz6ww
	 /7D1xAe3+yACbp2doBMAMgBgcJfwyVFHeqn8W9glY8HfjGzDIjNBzACI0YRE0wjP9C
	 INZM/a6uriaYJZolYujPy9DtsB8eFHnNcVQKkuYZXKfWgZA1YMarj02FZ5KpuciU0l
	 dpRqIyS5oZIl7neYdJhyjByzJSmbR7oztkGtEtOmuTeFlonuKTBDzGhgeSwrUrxohv
	 UmVNVEVRr0mcR1GF8XkRRsdUkmL50myUrUTBG5cWLed6pXiFMQ6Cqwjy/kPISwd3fz
	 8IxM9cEEqc3mQ==
Date: Fri, 13 Jun 2025 19:26:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: grwhyte@linux.microsoft.com, linux-pci@vger.kernel.org, 
	shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <g6azpscddqx4kqnpoy3lrfsczfjnn2hev2q5qzuwdi62wmipr2@rhzi3av3n4ab>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
 <ccclacbxzdarqy27wlwqqcsogbrodwwslt7t5sp64xvqpa3wsl@xs5cllh7a6ft>
 <aEwrfy63cvBLr5yc@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEwrfy63cvBLr5yc@wunner.de>

On Fri, Jun 13, 2025 at 03:45:35PM +0200, Lukas Wunner wrote:
> On Fri, Jun 13, 2025 at 05:12:48PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 11, 2025 at 12:05:50AM +0000, grwhyte@linux.microsoft.com wrote:
> > > Add a new flr_delay member of the pci_dev struct to allow customization of
> > > the delay after FLR for devices that do not support immediate readiness
> > > or readiness time reporting. The main scenario this addresses is VF
> > > removal and rescan during runtime repairs and driver updates, which,
> > > if fixed to 100ms, introduces significant delays across multiple VFs.
> > > These delays are unnecessary for devices that complete the FLR well
> > > within this timeframe.
> > > 
> > 
> > I don't think it is acceptable to *reduce* the standard delay just
> > because your device completes it more quickly. Proper way to reduce
> > the timing would be to support FRS as you said, but we cannot have
> > arbitrary delays for random devices.
> 
> To be fair, we already have that for certain devices:
> 
> The quirk delay_250ms_after_flr() is referenced by three different
> Vendor ID / Device ID combos and *lengthens* the delay after FLR.
> 

This quirk is fine as it works around an issue in the device. But this patch is
not fixing/working around an issue in the device, but rather optimizing the
delay for performance, which is not what quirks are used for AFAIK.

> It's probably difficult to justify rejecting custom delays for
> certain MANA devices, even though we allowed them for three other
> devices.
> 

If the MANA devices require extended delay, then a quirk indeed makes sense.
But it is the other way around.

> The proposed patch introduces a generic solution which avoids
> further cluttering up pci_dev_reset_methods[] with extra entries,
> so I think it's an approach worth considering.
> 
> There are a bunch of nits in the proposed patches, such as "pci"
> not being capitalized, but the general approach seems fine to me.
> 

I honestly don't know if there is any other way to handle this. So I think it is
upto Bjorn to take a call.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

