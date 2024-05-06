Return-Path: <linux-pci+bounces-7123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6F8BD17C
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C201C1C218E7
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344E153584;
	Mon,  6 May 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm/48ljp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02513DDC1;
	Mon,  6 May 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008986; cv=none; b=dZq5vgIQpmg80KKVU/qkSHLl9EJDYKvgURouDLnLr0THcwEHVy41TRsi/96x/E9MoxUOsrqfoEWqp2OeBjqH2yhCD0jZuUh7QVQcfTiqNSW3jR4Q6BjoGstLO7Dn78qQfAJEvYDbKzIRFv6XxOd0S2+0BHAUega/DVZC/w4PHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008986; c=relaxed/simple;
	bh=hzEBDhZ3iEk83QRqKPdffB1FKf0qTi/Yii10dU5ygm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pwkQpPB8XmM9qf1qb99StGPHw+gHWCGN3fEQDTRFNZdzTPiWlAy27oAMdnNswCrPSJI/4q2MtFjM8OL6kLXrLMlVVbj+zE/HPpCD4fGh2Z8tK/zw94/akLvsiQunxiWdUnMFNm4UQIedLFIptncIQ/XVuXR+Fh7PM2Ue1abVTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm/48ljp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FB9C116B1;
	Mon,  6 May 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715008986;
	bh=hzEBDhZ3iEk83QRqKPdffB1FKf0qTi/Yii10dU5ygm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nm/48ljpS1NGxxtyzx0dJdPMmjCc38BE0mw27+TMiUqfpsaADQF+Vou/LqboYm7uc
	 MHjw5/S61dAdh/K+8Uu51ZsGIT7NYOP5ggOwhkEi9/U5QpIyw3oU9nC/O81NFPWeBF
	 yuzDELeg437VWOtnddFOeHycNR3BL9A0IMxp21VifKzsEoAQrDMx5vcXM6627JkQzF
	 Wtto6z18VxTo8Lv5VhJhPT/RMdglZJ8tWJowj+86tRo/oVrnXYZNjHEx5CdBQVDyz8
	 uOPV61cioV6xh9+nDmFrsPHcYL5kWmCY0pZi4r64M52K1ySzpS+SmJToupSYhD39Io
	 sHdoRUQ0mRj6A==
Date: Mon, 6 May 2024 10:23:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	bhelgaas@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: ce4100: Remove unused struct 'sim_reg_op'
Message-ID: <20240506152304.GA1699729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjjsiO33y08dJLPX@gallifrey>

On Mon, May 06, 2024 at 02:43:20PM +0000, Dr. David Alan Gilbert wrote:
> * Ilpo Järvinen (ilpo.jarvinen@linux.intel.com) wrote:
> > On Mon, 6 May 2024, linux@treblig.org wrote:
> > 
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > This doesn't look like it was ever used.
> > 
> > Don't start with "This" but spell what you're talking about out so it 
> > can be read and understood without shortlog in Subject (or looking into 
> > the code change).
> 
> I'm of course happy to rework that if it helps you, although
> I thought the subject line was sufficient.

It's a minor point, to be sure.  The way I think about this is "an
essay title is not part of the essay itself," so the essay (commit
log) should make sense all by itself.

Bjorn

