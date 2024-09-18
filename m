Return-Path: <linux-pci+bounces-13282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C476D97BDB5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774241F22881
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82918B464;
	Wed, 18 Sep 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsnpBR22"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774518A6CD
	for <linux-pci@vger.kernel.org>; Wed, 18 Sep 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668558; cv=none; b=QqC3u2JLjKSAEAHCYS96QdHh6eav/3+9UX0ZGe2bTHVjSnTsfTIwSCQs++s1+daOvxNybt6LfPZqcMMhYipjE7mKPaYi3EuPZcgDcLxphreNehiRkRk7hq0BKxdh1Om20fUdnZyBK4u7qtIQ97dtr1ICLjW37S/QBsr1NztC7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668558; c=relaxed/simple;
	bh=YGRziINFkpIAAe940nT9N/w9hQru6i7OPbgN53+z57M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OWkV7XJ/IsWLky4hDyh/wwMxOIejMlpSvizZb7fVm6A+3X+VzEud8+e3epo08y1Q9QNkakk0wNI+w64S4OtmcniR1zpnS7BkXgY68AhZhjBBiF+fm1QO0QzQeXolzPijbBiZfX4eYVlsujTSkOX7c+51UXRlpilIO8UUIaHEFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsnpBR22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F00C4CEC2;
	Wed, 18 Sep 2024 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668557;
	bh=YGRziINFkpIAAe940nT9N/w9hQru6i7OPbgN53+z57M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UsnpBR22wWsEmrDQr5VfrnHPSPrL+fjJkpFh7Ap8Zj8ygcZapY8ZrOB5DBtT5Tcm5
	 btkEbNv3w+23DJbsxflS/EfdMIEU+85JU+Sk1D6zHYGz0jM/X8BQy1ucbHpYhzbJSj
	 yPfNMEcVuzj7hUuIGifwbp5ktUjVzJwNur+EUZUOExasXu86Lnjhg7ZEdqBXhgS98v
	 5qRqcOLHiPb95mSVN+knIuiohdIus/x+bpzAbNXyXnwUwyKdmL+L1KUjIYNi4QHriG
	 no/LD47DylGp7yjYdNl8w9mTgNVzpBTYaD4oJO6WJz8MQAKLa6Z+ZgTLFjjsT9lUIq
	 y3Qu00zVytbtA==
Date: Wed, 18 Sep 2024 09:09:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Erin_Tsao@wistron.com
Cc: linux-pci@vger.kernel.org, mj@ucw.cz
Subject: Re: Issue about PCI physical slot fetch incorrect number
Message-ID: <20240918140915.GA844172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2154e86ab240dcba530b6620100139@wistron.com>

On Fri, Sep 06, 2024 at 02:04:28AM +0000, Erin_Tsao@wistron.com wrote:
> ...

> I will send both dmesg and slot file under path /sys/bus/pci from
> team1 and team2 to you. Please find attachment for more details,
> really appreciate your help and assistance.

Evidently these don't match the lspci information you collected at
https://lore.kernel.org/r/dcd9ff2b16c44efca61189850fb0fe02@wistron.com

It's too complicated to try to put this together without a consistent
set of info.  Can you collect dmesg, lspci, and /sys/.../Slots info
that all match, please?

And point out the device that you think has the wrong slot name?

Bjorn

