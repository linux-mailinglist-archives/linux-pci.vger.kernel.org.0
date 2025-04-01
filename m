Return-Path: <linux-pci+bounces-25091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944DA781D5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC60B3A65FE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209641CD21C;
	Tue,  1 Apr 2025 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0LJ792N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7A13AC1
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530566; cv=none; b=muilFVuhX4HDOnzaYmIFsW9M4hfWGIErR+3ZGup6MTWPPpxtLQPbpni5bUpnoo7EoFRKWo/u8hvOC+Zm9d55pgNpaeY0DMM8/sLHAtas23X2wWA/VNmnqcK4GeWbJxTzn9LkSq4xbd05EftXcRjVomggXnqS5zl/eUpiTwv+ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530566; c=relaxed/simple;
	bh=s3N6qE6QkuXmt3qrKOMhyIIYci85AqKVajlDcd42C5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KLajeCcc30nwd4IAMXAPkKN9NB39uZLvZT4f+Iz8aDTjSvDsZ6fa7w9/Rhv0qPI/zgo9EfNxAfdJRuTHELafB0dqLjEuSi310+LMi4mgCEe42ykrnhyhRte2F65KEIupJd+4Aco2l3TuYuH1R6RUruFIn+GJ6pGtcbiIu+uKMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0LJ792N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34788C4CEE4;
	Tue,  1 Apr 2025 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743530565;
	bh=s3N6qE6QkuXmt3qrKOMhyIIYci85AqKVajlDcd42C5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W0LJ792NaXf1EM8FJ6olirdFxQROzauADBTEp8CZ3YQknYwrcBhnR26I+xV+LKspG
	 r5oUB2FBVF3TO14HrbB97qeaUP6jpVQutT6ePfLAavq1OhPr36yf2RGFkC1A+i6+h7
	 Lvx1IGakydjMgrlbvhZ+VbRrXhOxfi3kJy4e95tzURHMKIYLXebC4uBVHz7RId2UE4
	 IyOYFqMGZYhmqLP5teU8tIRnTwA2v06Y6tcmNLaJPi6YerlnYpPhNzSVerOQQJwRhz
	 cd9qfe6DpI0sQ7J2yCu2uOHSbJZ/kO8atQS/bAw7sAg/XpaN2Duh39VQjR0VLAL1Ne
	 1RL0XxbXhfRcg==
Date: Tue, 1 Apr 2025 13:02:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250401180243.GA1675646@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMC_AXUDqeJbT3gh48JRL7OiutVqQyf0go_cGcR_xsTfqw+Qsw@mail.gmail.com>

On Mon, Mar 31, 2025 at 05:30:50PM -0700, Jon Pan-Doh wrote:
> On Mon, Mar 31, 2025 at 11:48 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > I found the __ratelimit() return values a little confusing (1 == print
> > the message, 0 == don't print), so this is appealing because it's less
> > confusing by itself.
> >
> > But I think we should name this "aer_ratelimit()" and return the
> > result of __ratelimit() without inverting it so it works the same way
> > as __ratelimit() and similar wrappers like ata_ratelimit(),
> > net_ratelimit(), drbd_ratelimit().
> 
> Ack. Caught between readability and consistency :).
> 
> > On Thu, Mar 20, 2025 at 06:58:04PM -0700, Jon Pan-Doh wrote:
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
> > >
> > >  struct aer_err_info {
> > >       struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> > > +     bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];
> 
> s/ratelimited/ratelimit here as well? Should it store aer_ratelimit()
> or !aer_ratelimit()?

I'm in favor of avoiding negation when possible, so I would name it
"ratelimit" with the semantic of "1 == print", even though that seems
a little backwards to me.  But I think it will make sense to people
who read ratelimiting in other areas.

