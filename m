Return-Path: <linux-pci+bounces-38386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF5BE502D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AE51A67F0C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B6225760;
	Thu, 16 Oct 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PSaeOqi9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v9WTW5Q0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mgOc4fWp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LqSD4NVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCC223DD1
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638399; cv=none; b=MRt3k9ddfOD0+LRJeIURdN5bzi3Cnbpxs3WFw1jCsTx4VShX3t/PE/D82SsISDas0+Nb4NyPrspQgXdOZ3VVWqMJbjKJ2w3oXItMMSbZ/uUbne9CD46D0XBh8NxWATXBB34tGqhrmsOSDou3PqrJsj3L4D+NUfW6bOXVC9EbyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638399; c=relaxed/simple;
	bh=5vo4Zfhwr+S7XtbJbcIq277w8DiqH8TsgSNcOlGyI4c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X85hLgB+bApKhPrSSf07kIFKYarUvBbjNq4ZxG5oWGU9+z3MaloCad8A9uUga5hZfmnJdQQRk5Ys/R6gUIydY1gl+9zz7ur9LtHzcqN61rM4Qb7DGyiK7tbtIx3kQnCyg320ohf4PtLBCktj56k556yx6Okh6tJC2aIP/8wE+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PSaeOqi9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v9WTW5Q0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mgOc4fWp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LqSD4NVW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0051821DB7;
	Thu, 16 Oct 2025 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760638396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXt0HYhwDbekzTJKQtnkmPdsKEmx8+QLoAWrJr+AuHw=;
	b=PSaeOqi97XxN25N8+xX5ofD3mqXKKqyLYdL4FfCv8SgXpDPP96vCtB7wMCLkufqtBe4kGh
	/qwAg4skhRvFajo0JdMWIftzj42pQ8ko9xC71E1O54wbr3BIK/6HfY3j7cjEHPrFhxa3CU
	Mqa0yH9iQxPujYbEGKbDB36DhPCG7LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760638396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXt0HYhwDbekzTJKQtnkmPdsKEmx8+QLoAWrJr+AuHw=;
	b=v9WTW5Q0+Ab+4BU0T0sorM6CZ59obHujUD7l3r21bLS5mfhHRiu8uMOoClyAZSeHn6jqDc
	wAf62b/+k28rp0Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760638395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXt0HYhwDbekzTJKQtnkmPdsKEmx8+QLoAWrJr+AuHw=;
	b=mgOc4fWpD3otk8/UDDfvjUWrmrPV4EAfCLbWNeiGLCLLTY4EnURnH+T3Mam4q3bLMzD4rB
	iNL9nzbLeFB+5vwCYhe0lMnGJRDlugZJsrn9Cm5GxiXMivfmQAFp/WW18qW1xlXedOlkY5
	mKVyNSeOKVXOJ3tmVog4wCO664Pds6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760638395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXt0HYhwDbekzTJKQtnkmPdsKEmx8+QLoAWrJr+AuHw=;
	b=LqSD4NVWcSWEIoiLiJqe+AvCxCPXW9tNEFWkjtSl2gmsnbLbT4uYsFfUC5E9kahkG296XR
	QxjuBljFFXM7hSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 827051340C;
	Thu, 16 Oct 2025 18:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0XYVHro18Wg9WwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Oct 2025 18:13:14 +0000
Date: Thu, 16 Oct 2025 20:13:14 +0200
Message-ID: <875xce7m11.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Dhruva Gole <d-gole@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL() macro
In-Reply-To: <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
References: <3925484.kQq0lBPeGt@rafael.j.wysocki>
	<3324926.5fSG56mABF@rafael.j.wysocki>
	<20251016133854.00003669@huawei.com>
	<CAJZ5v0iOgbkJbdRzgrBUaaYL+S_8BZD7XuXdK5vs2gMG3ug1KA@mail.gmail.com>
	<87ikge7v01.wl-tiwai@suse.de>
	<cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 16 Oct 2025 18:46:56 +0200,
David Lechner wrote:
> 
> On 10/16/25 9:59 AM, Takashi Iwai wrote:
> > On Thu, 16 Oct 2025 15:46:08 +0200,
> > Rafael J. Wysocki wrote:
> >>
> >> On Thu, Oct 16, 2025 at 2:39 PM Jonathan Cameron
> >> <jonathan.cameron@huawei.com> wrote:
> >>>
> >>> On Wed, 15 Oct 2025 16:02:02 +0200
> >>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >>>
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> There appears to be an emerging pattern in which guard
> >>>> pm_runtime_active_try is used for resuming the given device and
> >>>> incrementing its runtime PM usage counter if the resume has been
> >>>> successful, that is followed by an ACQUIRE_ERR() check on the guard
> >>>> variable and if that triggers, a specific error code is returned, for
> >>>> example:
> >>>>
> >>>>       ACQUIRE(pm_runtime_active_try, pm)(dev);
> >>>>       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> >>>>               return -ENXIO
> >>>>
> >>>> Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing the
> >>>> above sequence of statements that can be used to avoid code duplication
> >>>> wherever that sequence would be used.
> >>>>
> >>>> Use this macro right away in the PCI sysfs code where the above pattern
> >>>> is already present.
> >>>>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> ---
> >>>>
> >>>> Admittedly, the new macro is slightly on the edge, but it really helps
> >>>> reduce code duplication, so here it goes.
> >>>
> >>> Fully agree with the 'on the edge'.
> >>>
> >>> This looks somewhat like the some of the earlier attempts to come up with
> >>> a general solution before ACQUIRE().  Linus was fairly clear on his opinion of
> >>> a proposal that looked a bit similar to this
> >>> cond_guard(mutex_intr, return -EINTR, &mutex);
> >>>
> >>> https://lore.kernel.org/all/CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com/
> >>>
> >>> +CC a few people who might have better memories of where things went than I do.
> >>>
> >>> The solution you have here has the benefit of clarity that all it can do is
> >>> return the error code.
> >>
> >> Well, I could call the macro PM_RUNTIME_ACQUIRE_OR_RETURN_ERROR(), but
> >> FAIL is just shorter. :-)
> >>
> >> Seriously though, the odd syntax bothers me, but it has come from
> >> looking at the multiple pieces of code that otherwise would have
> >> repeated exactly the same code pattern including the guard name in two
> >> places and the pm variable that has no role beyond guarding.
> > 
> > While I see the benefit of simplification, IMO, embedding a code
> > flow control inside the macro argument makes it really harder to
> > follow.
> > 
> > Is the problem about the messy ACQUIRE_ERR() invocation?  If so, it
> > could be replaced with something shorter (and without extra type),
> > e.g. replace 
> > 	ret = ACQUIRE_ERR(pm_runtime_active_try, &pm);
> > with
> > 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > 
> > Since all runtime PM guard usage is to the same object, we can have a
> > common macro.
> > 
> > Also, in the past, I thought of a macro like below that stores the
> > error code in the given variable ret:
> > 
> > #define __guard_cond_ret(_name, _var, _ret, _args)	\
> > 	CLASS(_name, _var)(_args);			\
> > 	(_ret) = __guard_err(_name)(&_var)
> > #define guard_cond_ret(_name, _ret, _args) \
> > 	__guard_cond_ret(_name, __UNIQUE_ID(guard), _ret, _args)
> > 
> > ... so that it'd work for runtime PM like:
> > 
> > 	int ret;
> > 
> > 	guard_cond_ret(pm_runtime_active, ret)(dev);
> > 	if (ret)
> > 		return ret;
> > 	
> > Of course, a clear drawback is that the assignment of ret isn't
> > obvious, but the code flow isn't skewed much in this way.
> > 
> > 
> > thanks,
> > 
> > Takashi
> 
> FWIW, a while back, I suggested something like this where ret was
> a parameter rather than a return value [1]. Linus did not seem to
> be a fan (said it was "disgusting syntax").
> 
> [1]: https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com/

Yeah, I myself also find it suboptimal, hence it wasn't really
proposed...  It's a limit of macro, unfortunately.


thanks,

Takashi

