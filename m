Return-Path: <linux-pci+bounces-7162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A9D8BE160
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8095B290CD
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3E152DEA;
	Tue,  7 May 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HDje+WBA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HDje+WBA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23763150995;
	Tue,  7 May 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082531; cv=none; b=AGi7p28P7lRmpGsRrP2RLmAlHhwfMVJAQLu1Ktn64uUchOqBc7CuQ+N60mjOeDz57m59DtTW4TvRPPOOdYcqoj37rC/drmSdCeFkmnI+VEJ0RXW/zk2hWgfGpOamcuxR7aJl3zn10rBOeMGEhSPm6kUfimkr20v0UUqds+nzmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082531; c=relaxed/simple;
	bh=up5hp9emyS2c8JEPt9FJIuloQ1kofrcTiij5qfny1nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG/6UwUrSSKON/OsqjKuPMET1SkwBASk9KHv+XtB7RlZYm9YlnfMNxj1D3G1ekxIWiLAPDWYoIp51Zsr9b+t4mNPVxrkMHvbhEwSCtfTkqk+CmFibsKUpzsPb8J/S8ZmnP0y/gP2dZZ3M9/+lYp72vHfHjJu2gVTYQVn6Vv3jTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HDje+WBA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HDje+WBA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E2D52091A;
	Tue,  7 May 2024 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715082527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQuAY9ohhmInSThPMJ1QNyWppnFR1uXYDi4xt6VDBaM=;
	b=HDje+WBAMblSXBygDUCEg3bL6VVHzXqGPyg8AG2recz+t0z6Q+2JP5/TmrDqqgEoSjavBm
	MJ4Gvf84/NXyxFffUhls7gQQ24eiNNv40jiGHjNUstcIiDDINRyfFJq8xPpwerdKXxiyb0
	MVzC7fc+rbwxaSsA4PIKbT6+FXlxr4w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715082527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQuAY9ohhmInSThPMJ1QNyWppnFR1uXYDi4xt6VDBaM=;
	b=HDje+WBAMblSXBygDUCEg3bL6VVHzXqGPyg8AG2recz+t0z6Q+2JP5/TmrDqqgEoSjavBm
	MJ4Gvf84/NXyxFffUhls7gQQ24eiNNv40jiGHjNUstcIiDDINRyfFJq8xPpwerdKXxiyb0
	MVzC7fc+rbwxaSsA4PIKbT6+FXlxr4w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E3413A2D;
	Tue,  7 May 2024 11:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xDo2Bx8VOmYdBAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 07 May 2024 11:48:47 +0000
Date: Tue, 7 May 2024 13:48:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Adam Manzanares <a.manzanares@samsung.com>
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
Message-ID: <ZjoVHhiSLm3KRW63@tiehlicka>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,intel.com,huawei.com,stgolabs.net,samsung.com,gmail.com,google.com,fujitsu.com,kernel.org,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 06-05-24 19:27:10, Adam Manzanares wrote:
> Hello all,
> 
> I would like to have a discussion with the CXL development community about
> current outstanding issues and also invite developers interested in RAS and
> memory tiering to participate.
> 
> The first topic I believe we should discuss is how we can ensure as a group
> that we are prioritizing upstream work. On a recent upstream CXL development
> discussion call there was a call to review more work. I apologize for not
> grabbing the link, but I believe Dave Jiang is leveraging patchwork and this
> link should be shared with others so we can help get more reviews where needed.
> 
> The second topic I would like to discuss is how we integrate RAS features that
> have similar equivalents in the kernel. A CXL device can provide info about 
> memory media errors in a similar fashion to memory controllers that have EDAC
> support. Discussions have been put on the list and I would like to hear thoughts
> from the community about where this should go [1]. On the same topic CXL has 
> port level RAS features and the PCIe DW series touched on this issue  [2]
> 
> The third topic I would like to discuss is how we can get a set of common
> benchmarks for memory tiering evaluations. Our team has done some initial
> work in this space, but we want to hear more from end users about their 
> workloads of concern. There was a proposal related to this topic, but from what 
> I understand no meeting has been held [3]. 
> 
> The last topic that I believe is worth discussion is how do we come up with
> a baseline for testing. I am aware of 3 efforts that could be used cxl_test, 
> qemu, and uunit testing framework [4].

This seems to be quite a lot for a single time slot. I think it would
make sense to split that into more slots. WDYT?
-- 
Michal Hocko
SUSE Labs

