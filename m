Return-Path: <linux-pci+bounces-7193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083B8BEBE8
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFDE1F257AF
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077B16D30F;
	Tue,  7 May 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B0Kxz5lu"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6816D33C;
	Tue,  7 May 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107864; cv=none; b=Tpyzi+4HLU6R4AFlbAJjTZ93BiToAAVabYAMIogkVVUt+BJu97inXxk0F+9G+SiGW6jFnJAIb5apdF/EQA4EV0AIjnImhpb5m8LAUm+E8SY9QSv42EMSF2dr+7XJPoprLJMqX1LOXoEN5nNb/pHmfs4SnYQyp8aX/2IMhjNjK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107864; c=relaxed/simple;
	bh=ZwX2Rn50wq4SlmLyEfoqfN58ifJPiOPy5eQX4TCy5Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+q7LGof6i24UqfeM5vgS9o84GRP4sNgrDES88R1VdtbUS29k5su2EzJxZrHBhh+qxcv8/63WwBdA8jJV8WCD8/Zle3weNMUruDpCNBEe5v4B6N+zNKlYurhgd9iqx6u7FvSdT6dC31sYRbX6GPkYsZp9Qodd/iAFLBmom9Vhd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B0Kxz5lu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c7dDW50rDrXhq4SPVgt6MlbL8l9sqdQ0MjPeV/butIg=; b=B0Kxz5lu9jST40KSMnjcnC2idI
	CyKD/iJCN7Oxx+Z+ibpRIevp1XLk7cCBcds2RjiZpauu9inkkhAwsxJLpFtHXmsMUV79u58vX+3Eo
	qV9VNvLhSUH4LLy8W0fzGvgvGXW7kQ0/UEpepmReQXZ1Z1cuqO7rx8fcgm8YPUkSh5dsZiu4bq9Ru
	nITKGqEHxQ4lk2c8aK/yaxWfE5e4vM/sJMgb6qJ3Bf2SAYOC5xoH8B7b1x8/MbbL/QAQvYpGdjRHt
	8Ij3/OHGQr+7Y6mBSJ2gQJV+N41IpAZcIZ/SvG1mOmBf1Cb5zl21ovoNd/q9Y8MpffsDLvM07Rjom
	Cqn04GAg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Ptu-0000000CRRN-3fGU;
	Tue, 07 May 2024 18:50:54 +0000
Date: Tue, 7 May 2024 11:50:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
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
	Jim Harris <jim.harris@samsung.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <Zjp4DtkCFGOiFA6X@bombadil.infradead.org>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
 <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, May 06, 2024 at 04:47:37PM -0700, Dan Williams wrote:
> For testing I think it is an "all of the above plus hardware testing if
> possible" situation. My hope is to get to a point where CXL patchwork
> lights up "S/W/F" columns with backend tests similar to NETDEV
> patchwork:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/
> 
> There are some initial discussions about how to do this likely we can
> grab some folks to discuss more.
> 
> I think Paul and Song would be useful to have for this discussion.

I think everyone and their aunt wants this to happen for their subsystem,
so a separate session to hear about how to get there would be nice.

  Luis

