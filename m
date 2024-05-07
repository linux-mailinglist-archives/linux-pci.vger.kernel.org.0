Return-Path: <linux-pci+bounces-7203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE38BF2E3
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E9B2173B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EB85267;
	Tue,  7 May 2024 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="G2Xwn9e5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4137F7DD;
	Tue,  7 May 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124273; cv=none; b=hrcc3/yl20Fe8DPOo8lDF6ZMry9XaWRb8O1zZRbkjBOmLV9yquRBr0rqz8UpCv1MQja5U8FXSATHH75cDhlscH/19w2NJpddT3hOe7SziaB+xoNaf8zSIWXV4YxcYlrMn8VOmIHkxbpmdP0MPvPGNlUVWwsIXbkKvEvuat1IEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124273; c=relaxed/simple;
	bh=H6KMTWdVDxQIyEf07ZKFzrVuOX4SfsTYkNf3h6+ARd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAVeq+YjSL5/K5rmS8v8WIcIlpnWIRwReMa4j5EyaAAzAAK7HZU59Ej8SM+LwPX2P/Wb0lh8nqFS2ElAxQLjpbXMlz626DbiNZISG5t4V5IiouzP0oybbbErMkfotsQW6n3nTQR1K8yoTNx2iKe15N/SPiPcIaDrOn5uLYJDMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=G2Xwn9e5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=p0AxcTMBVF/ISPD4Iea70JxnyOcInTkNgaCzUI7wch8=; b=G2Xwn9e5bK5RHgWT
	Z1u5K9K8u5GNQ2X5Q/m2n2He1aBHlFxRP35bNjAIDRQnOXx8m/ac004PKt1ZcPTTlmPFzM/RXb/gj
	4s68Cscp72+a5Zv/o0MGeqVfd8b4Xf4Hu1HwaOt6213PCxxKpa3oefXOHWkSjgHXJrDNQFUkpjBio
	fFIos3+0Hnhi6waRDHxFR28FokAvVuk9XaCqX32JGE8oKaCk+GfX2ksAdJn0kQjkrYm60tcnxB1SM
	jEpZdcxsep4+K4ukI58FLm7YzXx1tSDzD8aVJ4SuBqjzoPPlWpEMWK68Yi+PxE1OMNpk4GCLeAEIn
	RtlqUS3NArqUhGaF6Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s4UAb-005HwO-1n;
	Tue, 07 May 2024 23:24:25 +0000
Date: Tue, 7 May 2024 23:24:25 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	bhelgaas@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: ce4100: Remove unused struct 'sim_reg_op'
Message-ID: <Zjq4KWSh63P6Y_Zg@gallifrey>
References: <ZjjsiO33y08dJLPX@gallifrey>
 <20240506152304.GA1699729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506152304.GA1699729@bhelgaas>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 23:24:02 up 126 days,  2:13,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bjorn Helgaas (helgaas@kernel.org) wrote:
> On Mon, May 06, 2024 at 02:43:20PM +0000, Dr. David Alan Gilbert wrote:
> > * Ilpo Järvinen (ilpo.jarvinen@linux.intel.com) wrote:
> > > On Mon, 6 May 2024, linux@treblig.org wrote:
> > > 
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > This doesn't look like it was ever used.
> > > 
> > > Don't start with "This" but spell what you're talking about out so it 
> > > can be read and understood without shortlog in Subject (or looking into 
> > > the code change).
> > 
> > I'm of course happy to rework that if it helps you, although
> > I thought the subject line was sufficient.
> 
> It's a minor point, to be sure.  The way I think about this is "an
> essay title is not part of the essay itself," so the essay (commit
> log) should make sense all by itself.

OK, modified v2 sent.

Dave

> Bjorn
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

