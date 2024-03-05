Return-Path: <linux-pci+bounces-4508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E90871977
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B33282599
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4A5025C;
	Tue,  5 Mar 2024 09:21:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27550A69;
	Tue,  5 Mar 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630505; cv=none; b=XuHn7VvYK9wvqeIWxbRsEFpYU1bk/f5met5b6XLkNbiiZ9IFQwZIm7zgzmaRkSF8qWTZTBcp2Ct1aMuarGer4oG3Fn0oBtCQiIY0eRNq9E2Ohd1iDUx21Qg5I5f0WqTsNqwF6HcvCR9ljfXUQFCtirgAcN1LwHd902wqxoorCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630505; c=relaxed/simple;
	bh=goZz1J7IgK9l4iO06JAHMIsU18UR4FOYBXKcpYKVz/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LRk6ULayo9kY4LxIXjBjMoglnXeyMFMks2k2Jd5b2V3UIhbVXrmXSnFpsxVk0I8Mh3xVuZmxbFVuuttXr8kK0zeYkrL7zZd4bD6NJfpDRg/TSRMdOBpYD0VtG79DzyJetM8zx+Hh9lThcWHUk6U06apR6WLhF7QYHu7VP+/Gh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D748930000D0B;
	Tue,  5 Mar 2024 10:21:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C910B2E204; Tue,  5 Mar 2024 10:21:39 +0100 (CET)
Date: Tue, 5 Mar 2024 10:21:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, Smita.KoralahalliChannabasappa@amd.com,
	ilpo.jarvinen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
Message-ID: <20240305092139.GA28325@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3eea050-53f9-4e4f-9694-06560a406db8@linux.intel.com>
 <f9fd8861-6bbb-469d-b0cb-2edc8598ecca@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 05, 2024 at 10:09:20AM +0800, Ethan Zhao wrote:
> On 3/4/2024 7:58 PM, Lukas Wunner wrote:
> > On Mon, Mar 04, 2024 at 04:08:19AM -0500, Ethan Zhao wrote:
> > > -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> > > +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
> > >   {
> > > +	if (!dpc_is_surprise_removal(pdev))
> > > +		return false;
> > 
> > This change of moving dpc_is_surprise_removal() into
> > dpc_handle_surprise_removal() seems unrelated to the problem at hand.
> > 
> > Please drop it if it's unnecessary to fix the issue.
> 
> To only export one function dpc_is_surprise_removal()... or I have to
> export them both.
> Seems I should keep them intact or refactor them in separated patch ?

Please keep them intact and make both public.  (You're not "exporting"
the functions, there are no modular users.)

However, I doubt whether you need to respin this patch at all:


> Reproduced on "Hardware name: Intel Corporation ArcherCity/ArcherCity,
>  BIOS EGSDCRB1.86B.0107.D20.2310211929 10/21/2023"

Eagle Stream BIOS, isn't that an Intel-provided BIOS?

Sathya's comments sound like the BIOS is misbehaving.  If so,
then the first thing to do is ask the BIOS team to fix the issue.
We do not want to pollute the kernel with workarounds for BIOS bugs
that can be fixed in the field through a BIOS update.

Thanks,

Lukas

