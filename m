Return-Path: <linux-pci+bounces-7120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4958BD087
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792B2280E97
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD01534FC;
	Mon,  6 May 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XJ36DjW9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843F1534F9;
	Mon,  6 May 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006607; cv=none; b=AzhHf36VILARjSN50VWQMxZiQXJ77B4XSK0tGMXGu6/QKxzqCS0rmvlm6NYtHF+5MR7BjCLkcotqyIBbipZku2NC721LF4J+9Qu5QHiE4jHfW9c3Fbx23py7By6YGxM1ABrcppaZscFhWDhuf0IeCJf0xv1TEAYh4U9hC5YRo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006607; c=relaxed/simple;
	bh=1PHydZMCG6eb+35vdAr+laWpupGyGqL/HZ0CYrrHWig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7fmsSeH5hMz/3dJL1Fi++U61lts240aTYDOEsMCC+ftRapixE9waZ4WiERXHHT8y98rnL4Wmgaf5n0KYhMzeeWvAqO0K0jqCEixuooWV5fmzh2NOSSeHWzqI/GqtbABPGzDO/jW9mIeOA5CS8NZd1AVR/sPzEYLkjlGkaG8cN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XJ36DjW9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=oIh2GEZu/cERMqozSXMHDf8vR7BHYa8ZZujCki8gVbk=; b=XJ36DjW9q95criDy
	PfvX7l5rO3BlxBL/UnezZUjXQoMvl0iUjBorXo7yyJn+2PxjgoU+SU/LrV6HhJJQ0iGzNdUjMfNkn
	FXO0KvFZsw3uVhZ0VmXb0cq5ReGzpugUeMv/wWiaPSfo/DIlyxkf9uQNnxsTePMF0bSUb0SnexneR
	jNHxQzrokoh36UZBsbGd25bPCw7MpxU+oxswApvZ+JKE4HfCcP+I1VBAtj/6vxCT/lOzJle0C8YSO
	OyOiYg/zcELM5C8lnX8U5w2ySdtqvcluY2doDzCeVnkhz32OKTYoRSInSxmCmGrBdui3xT6ZalwiD
	gsyLaJrrBEMMd92Kcg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s3zYm-004wdj-16;
	Mon, 06 May 2024 14:43:20 +0000
Date: Mon, 6 May 2024 14:43:20 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: ce4100: Remove unused struct 'sim_reg_op'
Message-ID: <ZjjsiO33y08dJLPX@gallifrey>
References: <20240506004647.770666-1-linux@treblig.org>
 <948a3829-96da-2708-60f8-f25546683436@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <948a3829-96da-2708-60f8-f25546683436@linux.intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 14:42:20 up 124 days, 17:32,  1 user,  load average: 0.06, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ilpo Järvinen (ilpo.jarvinen@linux.intel.com) wrote:
> On Mon, 6 May 2024, linux@treblig.org wrote:
> 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > This doesn't look like it was ever used.
> 
> Don't start with "This" but spell what you're talking about out so it 
> can be read and understood without shortlog in Subject (or looking into 
> the code change).

I'm of course happy to rework that if it helps you, although
I thought the subject line was sufficient.

Dave

> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  arch/x86/pci/ce4100.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
> > index 87313701f069e..f5dbd25651e0f 100644
> > --- a/arch/x86/pci/ce4100.c
> > +++ b/arch/x86/pci/ce4100.c
> > @@ -35,12 +35,6 @@ struct sim_dev_reg {
> >  	struct sim_reg sim_reg;
> >  };
> >  
> > -struct sim_reg_op {
> > -	void (*init)(struct sim_dev_reg *reg);
> > -	void (*read)(struct sim_dev_reg *reg, u32 value);
> > -	void (*write)(struct sim_dev_reg *reg, u32 value);
> > -};
> > -
> >  #define MB (1024 * 1024)
> >  #define KB (1024)
> >  #define SIZE_TO_MASK(size) (~(size - 1))
> > 
> 
> -- 
>  i.
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

