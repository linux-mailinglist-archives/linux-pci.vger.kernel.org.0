Return-Path: <linux-pci+bounces-2880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B260843D76
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A7929093F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337174E10;
	Wed, 31 Jan 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+o10Gyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608B69D39;
	Wed, 31 Jan 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698669; cv=none; b=cYZtg1HBJIUZMn8mTsfWx8n9t8JEmdrXgLlt6XegLxkRii9o61AqOwQp3T0rBjH16CP1AlGz9LVZ71xuwfQCaCMZxhieDt/KnJaaGBPMjYBdwjYl5O6HkuBA4Tkbvq4lJWUpTdkr0rdKV+nnPwIcvA3FMcp2G2Skb9O0A5BIhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698669; c=relaxed/simple;
	bh=lLdNASUUSAW/vwijOg8ZDB4AJvgTlx50ujLdt2AbEhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ2mqqMYauAkq62N6iW5YEFQVGWrJwYUsnk+PiugDfZLIbpPKIoksHVomzXFb0f/WUav3Wp6XqsUGKUFj4l2KcK1L2gDw/KbUkqaF91FEHAwoTZ/36DRpbPRNCfIcPEOeR2e2VrtTP8gkRWIAxmoYjehMJqixF20AV7fqgdklMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+o10Gyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51711C433C7;
	Wed, 31 Jan 2024 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698669;
	bh=lLdNASUUSAW/vwijOg8ZDB4AJvgTlx50ujLdt2AbEhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+o10GyqrwYwZNT9xLVn33bySqifWeG82B4UwnkdI0pnDfIacopHS4hSqWHWmVZMa
	 fgKl0FLfKmQXgm8xw4gwdksIHpopiRkdWgIR74e/eZNwA/va4WK2AIpZLm84IwHchc
	 +vwAS2SDH0XKYDsNl8K8hymY85L0hua3PTayDkEoVLFSltzJrkHF3xpkK1TBrGfdyi
	 lrL+6vCHtdSISI/0GuqAYQM51yivnV0rL3xPzUrYzRr28yICl2nZm0/Opt6QcHJdsJ
	 XcF+rGBpzyvXBrdQzaZ+3DbWIEk9GLncBGEsWD6GYivhfh0FTzaWwPQy1Mo9uc8N/w
	 1sPm4L+DGrwjg==
Date: Wed, 31 Jan 2024 11:57:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <Zbonprq/1SircQon@x1-carbon>
References: <20240130095933.14158-1-jhp@endlessos.org>
 <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>

On Wed, Jan 31, 2024 at 04:56:27PM +0800, Jian-Hong Pan wrote:
> Mika Westerberg <mika.westerberg@linux.intel.com> 於 2024年1月30日 週二 下午6:13寫道：
> >
> > Hi,
> >
> > On Tue, Jan 30, 2024 at 05:59:33PM +0800, Jian-Hong Pan wrote:
> > > Some systems, like ASUS B1400CEAE equipped with the SATA controller
> > > [8086:a0d3] can use LPM policy to save power, especially for s2idle.
> > >
> > > However, the same controller may be failed on other platforms. So,
> > > commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
> > > controller") drops LPM policy for [8086:a0d3]. But, this blocks going
> > > to deeper CPU Package C-state when s2idle with enabled Intel VMD.
> >
> > Tiger Lake really should support this with no issues (as are the
> > generations after it). I suggest trying to figure out what was the root
> > cause of the original problem that triggered the revert, if possible at
> > all, perhaps it is is something not related to LPM and that would allow
> > us to enable this unconditionally on all Tiger Lake.
> >
> > I'm pretty sure the platform where this was reported suffers the same
> > s2idle issue you are seeing without this patch.
> 
> Simply applying LPM policy to [8086:a0d3] sounds like a good idea!
> 
> I installed an SATA storage into ASUS B1400CEAE and tested with
> enabled & disabled VMD again. Both the NVMe and SATA storage work with
> applying LPM policy to [8086:a0d3], which means that it does not hit
> the issue mentioned in the commit (ata: ahci: Revert "ata: ahci: Add
> Tiger Lake UP{3,4} AHCI controller").

We would like to enable LPM for Tiger Lake again, but last time we tried
to do so, we got a bunch of reports:
https://bugzilla.kernel.org/show_bug.cgi?id=217114
https://bbs.archlinux.org/viewtopic.php?id=283906

Where people complained that their SATA drive dissappeared as a result.


The bug reports were reported on the following hardware:
ASUS Vivobook 15 X513EAN
Lenovo L3-15ITL6 IdeaPad
Acer A515-56-32DK
Acer A514
HP Pavilion 14-dv0589na

Usually, when a single vendor manages to mess something up in their
platform firmware, and we deal with that by adding a quirk for that
specific vendor.

But here it is four different vendors... This kind of suggests that
there could be a some more fundamental LPM related issue at play here.


Yes, we are fully aware that on some other platforms, not having
LPM enabled stops those platforms from entering the lowest CPU power
states. So right now we are doomed if we do enable LPM, doomed if we
don't.

However, having some systems drawing more power than needed is better
than some other systems not detecting their SATA drives at all.

Unfortunately, we don't have any of these laptops that has a Tiger Lake
AHCI controller (with a disappearing drive), so until someone who does
debugs this, I think we are stuck at status quo.


Kind regards,
Niklas

