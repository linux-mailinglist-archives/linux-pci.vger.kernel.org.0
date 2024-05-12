Return-Path: <linux-pci+bounces-7403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9EE8C3696
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84E5281352
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E571210E4;
	Sun, 12 May 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oxhEzKm6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oxhEzKm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66D12E75;
	Sun, 12 May 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715519269; cv=none; b=hez0dI9/Tc55L24g/nbJGKTrGQ1yMR+vy1ZMwLWC0YIwUv4sNjR6pdwiJjeOhNqOMQc7R4cnRQOwg8vkje33s3SjkHwFtj9XWEdb5hwMaZR6eg9H4xqriH5C6ZGzLsu0XFPF3erI4LvaHdDerltDBO3qw3iEBhiDNsiJnByhCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715519269; c=relaxed/simple;
	bh=sTyRzxnXF/xuRmh2VOKidfRqkilMa37ngVU/scAvl3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmFXFBmRs2YJ33y1xUEipS5mxPjI+BS05v1kkVkf+npF0loM+WEC9bMm82cII2roIcFiBXX3S/+ReqNL7MLXxp97QtX/KMThPYmm74/wFkw1STbC1XNtMiIJFCDkhooRoq8w/6ppUiChq7ZJaNhALYh0rbcJJBHHuSWd0awsypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oxhEzKm6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oxhEzKm6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67D875D72F;
	Sun, 12 May 2024 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715519264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFk2lQrJDqhAqVN6zGkwW6eqg9ViLfDkQT7/TvZ4C8Q=;
	b=oxhEzKm6qhRTZ4J/OnYQSSj0x3597Xoh4+SyGoulvzDLeb+eVkKR0oEEVIWWhbS4iOdwq+
	/QMPgyZCturYOSOvhyIVu07+UoVJRCQXkBC7YckdlqAQROuBWJUd2EJxsWZzm80Qputy8s
	KYnGzuZCA+NBB4iXJii3jMQc8YsaPB8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715519264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFk2lQrJDqhAqVN6zGkwW6eqg9ViLfDkQT7/TvZ4C8Q=;
	b=oxhEzKm6qhRTZ4J/OnYQSSj0x3597Xoh4+SyGoulvzDLeb+eVkKR0oEEVIWWhbS4iOdwq+
	/QMPgyZCturYOSOvhyIVu07+UoVJRCQXkBC7YckdlqAQROuBWJUd2EJxsWZzm80Qputy8s
	KYnGzuZCA+NBB4iXJii3jMQc8YsaPB8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0E14132C2;
	Sun, 12 May 2024 13:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KTRoMR+/QGazUAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Sun, 12 May 2024 13:07:43 +0000
Date: Sun, 12 May 2024 15:07:42 +0200
From: Michal Hocko <mhocko@suse.com>
To: Adam Manzanares <a.manzanares@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"gourry.memverge@gmail.com" <gourry.memverge@gmail.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
	"shradha.t@samsung.com" <shradha.t@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	Jim Harris <jim.harris@samsung.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <ZkC_HnL4lfrNnZkm@tiehlicka>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
 <ZjoVHhiSLm3KRW63@tiehlicka>
 <cd7de8e2-6520-4b06-92be-668aeb96bc40@nmtadam.samsung>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7de8e2-6520-4b06-92be-668aeb96bc40@nmtadam.samsung>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,intel.com,huawei.com,stgolabs.net,samsung.com,gmail.com,google.com,fujitsu.com,kernel.org,kvack.org,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]

[add Davidlohr]

On Wed 08-05-24 18:35:50, Adam Manzanares wrote:
> On Tue, May 07, 2024 at 01:48:46PM +0200, Michal Hocko wrote:
> > On Mon 06-05-24 19:27:10, Adam Manzanares wrote:
> > > Hello all,
> > > 
> > > I would like to have a discussion with the CXL development community about
> > > current outstanding issues and also invite developers interested in RAS and
> > > memory tiering to participate.
> > > 
> > > The first topic I believe we should discuss is how we can ensure as a group
> > > that we are prioritizing upstream work. On a recent upstream CXL development
> > > discussion call there was a call to review more work. I apologize for not
> > > grabbing the link, but I believe Dave Jiang is leveraging patchwork and this
> > > link should be shared with others so we can help get more reviews where needed.
> > > 
> > > The second topic I would like to discuss is how we integrate RAS features that
> > > have similar equivalents in the kernel. A CXL device can provide info about 
> > > memory media errors in a similar fashion to memory controllers that have EDAC
> > > support. Discussions have been put on the list and I would like to hear thoughts
> > > from the community about where this should go [1]. On the same topic CXL has 
> > > port level RAS features and the PCIe DW series touched on this issue  [2]
> > > 
> > > The third topic I would like to discuss is how we can get a set of common
> > > benchmarks for memory tiering evaluations. Our team has done some initial
> > > work in this space, but we want to hear more from end users about their 
> > > workloads of concern. There was a proposal related to this topic, but from what 
> > > I understand no meeting has been held [3]. 
> > > 
> > > The last topic that I believe is worth discussion is how do we come up with
> > > a baseline for testing. I am aware of 3 efforts that could be used cxl_test, 
> > > qemu, and uunit testing framework [4].
> > 
> > This seems to be quite a lot for a single time slot. I think it would
> > make sense to split that into more slots. WDYT?
> 
> +1. I think the performance implications of CXL memory and how it relates
> to existing memory management code tackling performance differentiated memory 
> would be nice to separate. I think Davidlohr would be a great candidate to 
> lead this discussion.

WDYT Davidlohr?
-- 
Michal Hocko
SUSE Labs

