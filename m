Return-Path: <linux-pci+bounces-36750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D99B9524B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AB24820B4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44353203A0;
	Tue, 23 Sep 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7xolvTO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3C320394;
	Tue, 23 Sep 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618475; cv=none; b=EXxS3IOVEEwALIUBJWf44K01/0wMuvmR/4TKs8Rl35TEHHRyabTjuxG4bXp05c+nE/i6RZ2KC5cTRPmTgInmrKlfl53uQ3QzWO5zTtBeEllnJahXmme6/8Q8F2YB/oLLjL34ygWIXw6QNMYpsuV4H1ie9OkrxHOBKMVBNJuUtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618475; c=relaxed/simple;
	bh=YTaf33Yn1aN3Byqi5MfTrO7CQtFjPyXYYrb2D3agh+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu2SvZ+VmS4cSUsogi2v9eiUIq01ZC2ZPIZVfWpPGjn9r2uNzgg9l66ZvPIom2v2W0YMhpF8B66rWj+UfyDkC4axZbFh0qCRPq42zEGrJ2oY+7N10xqElRlGFhST732ZWG/n0HYxnEKjtBoI3dt1I0hJ8+tWarzIOxuxyxiXepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7xolvTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7480C4CEF7;
	Tue, 23 Sep 2025 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758618475;
	bh=YTaf33Yn1aN3Byqi5MfTrO7CQtFjPyXYYrb2D3agh+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7xolvTOByhDzBfdCH01j+f71GY30ZjKq16ZmDuIJBx3aLT6M6N6vEVATJhWJDGi9
	 I1RIl0PVu7gAmpUKPEuJOrx3pdMRbAc0wgoJWbPi2weP+7hr6Us7na7up4jY2UZ/Pk
	 Punp8E/Py20bhFC5mYKjYQVVLuJywCfF7nKQT06uXkUSWm6I6EzLapugQCbdsAGZIe
	 yfAhN8svXk6PC+0hjBrP5QpkvTZm6nkxIThSBhCWdZArWxxjY3RqLUkwL/IdFazv1d
	 e/xp1V9XLfMY2OIUkDt3o8VdUyq7uF5Ucs7+6D43/zucn/posdGiOpfmt/2vdWX4Ts
	 mYk6LfUuRT9mA==
Date: Tue, 23 Sep 2025 11:07:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/33] PCI: Protect against concurrent change of
 housekeeping cpumask
Message-ID: <aNJjZ9ouRSkkyyxU@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-3-frederic@kernel.org>
 <458c5db8-0c31-4c02-9c41-b7eca851d04a@redhat.com>
 <aMwQcVZeTwuk2Q8A@localhost.localdomain>
 <f1545ac2-9a4e-49e9-b918-205f617ec900@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1545ac2-9a4e-49e9-b918-205f617ec900@redhat.com>

Le Mon, Sep 22, 2025 at 05:51:39PM -0400, Waiman Long a écrit :
> On 9/18/25 10:00 AM, Frederic Weisbecker wrote:
> > No the point is that I need to keep the target selection
> > (housekeeping_cpumask() read) and the work queue within the same
> > RCU critical section so that things are synchronized that way:
> > 
> >      CPU 0                                          CPU 1
> >      -----                                          -----
> >      rcu_read_lock()                                housekeeping_update()
> >      cpu = cpumask_any(housekeeping_cpumask(...))       housekeeping_cpumask &= ~val
> >      queue_work_on(cpu, pci_probe_wq, work)             synchronize_rcu()
> >      rcu_read_unlock()                                  flush_workqueue(pci_probe_wq)
> >      flush_work(work)
> > And I can't include the whole work_on_cpu() within rcu_read_lock() because
> > flush_work() may sleep.
> 
> Right, you are trying to avoid flush_work() within rcu_read_lock() critical
> section. It makes it easier to review if you mention that in the commit log.

Good point!

> 
> > 
> > Also now that you mention it, I need to create that pci_probe_wq and flush it :-)
> 
> OK, another wq :-)

Yeah I know :-s

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

