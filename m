Return-Path: <linux-pci+bounces-24548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10CA6E02C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A5616E167
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074A2641EC;
	Mon, 24 Mar 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cND0NoAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCB2641E7;
	Mon, 24 Mar 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834968; cv=none; b=RelIuqTALSrbprwzIsaHFH5cxiSlEaDt/b5VGEQbbFFj8kDBkz1Q6D4gVhg+I7ovrDCzbcgM7Rfqyej1X2ErPPlU6AA0fylGvikYqJdOAMk0cAVh+UDMNwSS1eGmfr2wOv2iBsTPQGyK2+jPkbX6pj5DWD6HJToIVfttFI15wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834968; c=relaxed/simple;
	bh=6Mwb1qD+CguuWVLptcwKTAjQQ8Ri9yrju+Fcusg5Azo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IaRcduNOIuNuowr1TyzP8YH+paK6mw6O7bzpWCWpKpGj5rIyzmrAhfWLJWa0nYTGfeaDkUSn2Ot6Yd9HgjwExRwWOrITRUy0eUwk6MwJKD0m+l0EKQHUB+hhaLuesxDpVhq0hYtDyK8kgk/qC6yL/jEGtwuy1PjyT3g9fopI0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cND0NoAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D014AC4CEDD;
	Mon, 24 Mar 2025 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834968;
	bh=6Mwb1qD+CguuWVLptcwKTAjQQ8Ri9yrju+Fcusg5Azo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cND0NoATGotPtRmqTfuvZttDfEYNyhXPBBSZgvIczpo1sAd0zGd6LKlrzJtyDq5hO
	 D2xHeRwC885//sAr1OLslTbI/b02ZjD0KpBCpBa0lqem2RCQJ4FUqWJwfVwJGGnrcD
	 VlaYgXn8gpjuBcd5oxhCi/igpOLNAgr/s0/Ue2kErAQUEzQ6xT50aKGaqgjtN/er+l
	 CWyaZG6FP+eBkntehQp+TgMOW0Um0SUcquv0EoX+O5/Ety0oiy9Uaok3zf2Swn3hhV
	 pDM7QvFgI3KccjVMZLwhwJSlGCsY3WCHCbJ00tVFkUw3puK4u/jhxX8/tkAepGhtyR
	 0FlI4F36gxsUw==
Date: Mon, 24 Mar 2025 11:49:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/6] Enhancements for PCIe Cadence Controllers
Message-ID: <20250324164926.GA1252416@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C205166209F012D4F3A81A2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Mon, Mar 24, 2025 at 09:08:09AM +0000, Manikandan Karunakaran Pillai wrote:
> Enhances the exiting Cadence PCIe controller drivers to support second
> generation PCIe controller also referred as HPA(High Performance
> Architecture) controllers.
> 
> Comments from the earlier patch submission on the same enhancements are
> taken into consideration. The previous submitted patch links is
> https://patchwork.kernel.org/project/linux-pci/patch/
> CH2PPF4D26F8E1CB68755477DCA7AA9C6EBA2EE2@CH2PPF4D26F8E1C.namprd07.prod.outlook.com/

Thanks for splitting this into several patches.

Thanks also for the pointer to the previous version.  It would be
easier to follow if you could include the lore URL, e.g.,

  https://lore.kernel.org/r/CH2PPF4D26F8E1CB68755477DCA7AA9C6EBA2EE2@CH2PPF4D26F8E1C.namprd07.prod.outlook.com/

because lore is more widely used and more stable than patchwork.  It's
helpful if you can also include a little changelog of what changed
since the previous version.

When you post the next version of this (no hurry, since the merge
window is open and nothing new will be merged until v6.15-rc1), can
you please send the individual patches as responses to the cover
letter?  That keeps the whole series together and makes it easy for b4
to download the entire series at once.  "git format-patch" and "git
send-email" will do that for you automatically.

Bjorn

