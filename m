Return-Path: <linux-pci+bounces-4971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5F885950
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 13:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE811C21BFA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962C983CAA;
	Thu, 21 Mar 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcv/FGot"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284C75802
	for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025056; cv=none; b=jLLnsvAcUGpM/IyBvbkvMoGHA3bUaqrXbvCSsmX+HoSMcOVFMb/XGKcbqZMe/lVl0SFdmPIFCrWnHu0pjDIGSieoYbBgR9gI/sDfCtjFiBbKK0g3n6I0P9rD4QHIy4Y3Y91utl4a9Rj6/UKNiUu7NQiD7K2ovNrVkNHLcALwTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025056; c=relaxed/simple;
	bh=bjzWdNG1xYuEWEwWQwdm5lpe3NmXwkn0rKZi45tf5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mrDnDnQCrEr8HGSp10FZwed8eX3veN/zkUbpMWkw4h3FmYIot06F4LlrD+U7MzS6YBHbWa7NnWFqpBfQ9CvoHIikHmLJlC5UKpnk0ljCJxiauUHFOGei37/pK1ws98foQTB1U4Q+ADpfYCFb65p9Hw3hyRPbx0v3QSsAdVi1uN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcv/FGot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21DDC433C7;
	Thu, 21 Mar 2024 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711025056;
	bh=bjzWdNG1xYuEWEwWQwdm5lpe3NmXwkn0rKZi45tf5lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dcv/FGotFVbWd2+AfFyws/L1Pn/xBrE5vExvVSXWEK91qXzj6ZjUuOTZSigk7laiW
	 4Rr3P5IIj2/RAtxNCOc41gt5lu2TvC/Pp6MCXKNwg1gtdFzUvFguT9a8Cq96SJlmzR
	 RLUqdNahy1umHihRIRbBNt9xZ92cdONdQamcMtU2L9hMtTEC2z2LJQymW9okb9TyEM
	 sKq7LDVL4KXyShLRlPeUJ05Uga52VYsjyq2VGKcmrCBeDL34SwQ8jBrE0iDcGI+lIh
	 vOKJPoSmJSh1dsDVrWC//7yB6NCwHQjuhD8g7g0Lcn7beWqOHaP6lddG3cB7xHJ9Ls
	 +s7VHQi38yA+w==
Date: Thu, 21 Mar 2024 07:44:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Changhui Zhong <czhong@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [bug report] WARNING: CPU: 0 PID: 226 at drivers/pci/pci.c:2236
 pci_disable_device+0xf4/0x100
Message-ID: <20240321124414.GA1315974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGVVp+WPJZO50=-egr+67x9uePf3y4LS-85iCT_aEtSf=LASZw@mail.gmail.com>

On Thu, Mar 21, 2024 at 06:11:46PM +0800, Changhui Zhong wrote:
> On Wed, Mar 20, 2024 at 10:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Mar 20, 2024 at 10:16:06AM +0800, Changhui Zhong wrote:
> > > On Wed, Mar 20, 2024 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Mar 19, 2024 at 03:34:56PM +0800, Changhui Zhong wrote:
> > > > > repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > branch: master
> > > > > commit HEAD:b3603fcb79b1036acae10602bffc4855a4b9af80
> > > >
> > > > Where's the rest of this?  I don't see "WARNING: CPU: 0 PID: 226 at
> > > > drivers/pci/pci.c:2236" in the snippet below.  Please include or post
> > > > the complete dmesg log.
> > > >
> > > > Is this reproducible?  If so, how?  And is it a regression?
> > >
> > > it reproduceible，I can trigger it every time on my server，but I'm not
> > > sure if it is a regression，
> >
> > Great, it's always easier if it's easily reproducible.  Can you please
> > try an older kernel, e.g., v6.8?
> 
> I tested v6.8 and v6.7 both triggered this issue,
> and not trigger this issue on v6.6

Bisecting between v6.6 and v6.7 might be the quickest way to find it,
but it's a fair bit of work on your end.

How do you trigger the problem?

It looks like you're capturing console output, and most of the kernel
messages don't appear on the console.  The kernel messages (dmesg) I'm
interested in should be captured somewhere like /var/log/dmesg or
similar (I don't know the exact filename for Red Hat).

Bjorn

