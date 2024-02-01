Return-Path: <linux-pci+bounces-2966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7838463FE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 00:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7971C2637D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4451D681;
	Thu,  1 Feb 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR4Ay76M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938C46549
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828407; cv=none; b=bgFleXmNVqP06xiw8WTH4nlKYiQvFmUat6DwKazddV1tz2btxoE4ehJHOeSzox9yV/Au6wYCKEfSQ6fU0BomvxsCDlQhuxXr63+jqiQ+U4oOjDfM0cHuaprr8tjTTkwkuKP6viYXbu32TQcXJxULLBZ9nATCItsz1z3rQCGWQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828407; c=relaxed/simple;
	bh=e//JU8GR1O9RUGQC1aNpI5GbsyJFHe/R48DU18nr27g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WV8Ld5HZtVoL88EAPTsINsC1JgJWydi342tu67Y4Oi1BYrMCtrXZj88FmrMZAV6QWioOlHBj4K4d7evpaiFhtTy4/TL+ixiKLulBNTOLmBv9oTSo7UxyfvgfbFcDdV79nQIFIg2NCpYbl40rmIZX/JIs/2P6shAWNCUY6hQWBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR4Ay76M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBE1C433C7;
	Thu,  1 Feb 2024 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706828406;
	bh=e//JU8GR1O9RUGQC1aNpI5GbsyJFHe/R48DU18nr27g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YR4Ay76MvSMwR3EXk1qBPlo949Q4Jkkx5woj53NvepY+WViSDg2CKz53hmzGcsPuS
	 vx4Xw3bERKk+DLyvK9wc+EKMtwpfJ/EEeRO1r9hnsaMEdsPFeOcYxQG4POzyyj1+Tw
	 cGQa2V64EDG4EjJjG8TQynJpdYszk64oVF8W+GKyr85WWurh2Lesp2C4faQ5BB5r52
	 Torp2P12NFYcyYIs92RX3EnUc6p3q2IziAbK+yO79VAU3se+NRxbjuGzPQj1Y6elWr
	 36t2YJNb3z+XveS0uTC7kD7IEkDgWWCeYXQWbl/y/6jJQZtkmuTpsdZ0DsiWnzSPQP
	 Lf7AocVeGqJWA==
Date: Thu, 1 Feb 2024 17:00:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240201230004.GA654608@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8177ce67d001063c601d55c4171a247a6da737.camel@linux.intel.com>

On Thu, Feb 01, 2024 at 11:38:47AM -0700, Nirmal Patel wrote:
> Gentle ping. 

Thanks for the ping, I was waiting for you, so we were deadlocked ;)

