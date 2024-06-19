Return-Path: <linux-pci+bounces-8952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874B90E404
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A051F214C9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC37442E;
	Wed, 19 Jun 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3u4qcIt+"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57946139;
	Wed, 19 Jun 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780876; cv=none; b=rgWHKN2bz0RqqmCIPPfzpQii7PxYpNeJb/b4tNWD6PV1o/WJ3DCqy1c331cgpuYNYU0SYsN9RZG0z8/UtKMUmzncpS63zkfACRJcehqpYnePUnmSfclR6DNvKanU4nfdKf1+gyBr4cAMQZq9UQT+50zag7sVZHE+g8QErov/QsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780876; c=relaxed/simple;
	bh=Ct7KvPtTFdYsgUGp7gRvuzhTQI1YOAeOSuW3qmzAIWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMzfwKfg5Aymlp9J/tIssedHYB4Nj9M3Rz71FXe/zYLcVTivpRmVtxytybIq8oZyywXiGXKhTQbeMfBaI51NSnN74VlXtHWo2IblpiAMnxZqPsW8vsrATZ0oYjXgsYZtMljRPJ/wl59iQayPXKDe1pBkkq+WUgyXBCLCyTeCCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3u4qcIt+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YYWyyacnBbefsfYbd1v/MxFdVPLfKcrl6epFLCWHzXs=; b=3u4qcIt+FNSHDbH93XFvYScy0Q
	OLAI90UP8gu+rfzQvgO3eVDmQgH7+gqyd0K4R8447zVMPHXaC6hFHmdEyiL4GvDssP/nTtsuje9BY
	FdZOoRJeyHWtvKKkH6UbnBmkSM/RlOd6BUexz3AEy71WtgAr/AACmQsKRM1hJl52vAOKvR+q6kBsc
	MxxIjI9+4qZZMALGXg9Dd15qmbQMp69WcIClPB91A8BM7qkwNnul0bAAKenu/rtUE2eGGiafnn9xt
	U3hHNhhQ8azYyZqo9nrTPxjyAzXc/Fuq2tWlml5LSbI4XglvWm8m3/eTPAAjAUMoQOFmuZ+BxB/zS
	gqejEQ7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJpQ8-000000008dv-22EN;
	Wed, 19 Jun 2024 07:07:52 +0000
Date: Wed, 19 Jun 2024 00:07:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <ZnKDyJDrCuFMn0Nw@infradead.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> 3. Wait until the HW supports the modern spec:
> This depends on the chip vendor.

This is the only sensible option.  It's not like modern virtio devices
are a brand new thing.


