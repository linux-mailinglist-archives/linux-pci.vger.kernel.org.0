Return-Path: <linux-pci+bounces-33736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36BB209F1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240E2188C65A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829622D3A64;
	Mon, 11 Aug 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7lzNilg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D42222DD
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918336; cv=none; b=JIsKAmixU+L5dPLUQb6qVUAXfnSLRT/NWoYrYhszfK/P094Ar3kEhP8gDTNxE2kNknbzGgCK9ZUQybBy0OQJVV9H6m3EcOss0v1j42hldDIOFqBJ/TCKWARhOwTqIbpwNFhQ6Ge1SXOPvBSrisn8SsV+3PDXkXWx+AE7yVzpNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918336; c=relaxed/simple;
	bh=YurnktU6uLK/QMMiHdEUOXfRLMdcVqtaWTbxLFOUN3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo8QGx1ald0TV2zIcCE2oyA4XSkonHI7BlVg2EobJO/0+z3+ZrPjtufz9Ca2BM8j+9XHPh84xvT6l7uO3eTPqrrnBMwUdt0XOHcw0BYVYtQtxy60IaSZdaNmydplZ1i+5YvnGTY8timxf642t7ZVXUflmn4sAkcqXnBtde/QR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7lzNilg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754918333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eybU9c2mDvdB/SAMfEZIKdU5KhZDaZNeqdGbPmyFJI4=;
	b=g7lzNilgFrI0d8WRceAfcO0Nex41uzEy9utQHQhI3VK/izYZKR4oqc1Vn/bLMoZk1Gus2Y
	JS8oSqs+6bKum9TKifrPGig+BFvjGyLqgmS6kZfLM8EX3boqw3/v7it/2U/DILtSa9k694
	1gLsTa8qlpSf8yT1DfSf0pM6ijA4f28=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-l5x060c7OpOwLNUxTQ9DaA-1; Mon,
 11 Aug 2025 09:18:49 -0400
X-MC-Unique: l5x060c7OpOwLNUxTQ9DaA-1
X-Mimecast-MFC-AGG-ID: l5x060c7OpOwLNUxTQ9DaA_1754918327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACC2E18002B1;
	Mon, 11 Aug 2025 13:18:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A47A419560AD;
	Mon, 11 Aug 2025 13:18:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 155C21800091; Mon, 11 Aug 2025 15:18:43 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:18:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Message-ID: <mckkt3aiggiqogigbms4kcysaaqw5toieot5vvfw55smti4acr@mbwb2oe6jp7g>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-6-dan.j.williams@intel.com>
 <20250729161643.000023e7@huawei.com>
 <6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
 <20250806121625.00001556@huawei.com>
 <68939feeef7d9_55f09100c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68939feeef7d9_55f09100c7@dwillia2-xfh.jf.intel.com.notmuch>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Aug 06, 2025 at 11:33:18AM -0700, dan.j.williams@intel.com wrote:
> Jonathan Cameron wrote:
> > 
> > +CC Gerd, of off chance we can use a Redhat PCI device ID for kernel
> > emulation similar to those they let Qemu use.
> > 
> [..]
> > > > Emulating something real?  If not maybe we should get an ID from another space
> > > > (or reserve this one ;)  
> > > 
> > > I am happy to switch to something else, but no, I do not have time to
> > > chase this through PCI SIG. I do not expect this id to cause conflicts,
> > > but no guarantees.
> > 
> > Nothing to do with the SIG - you definitely don't want to try talking them
> > into giving a Vendor ID for the kernel.  That's an Intel ID so you need to find
> > the owner of whatever tracker Intel uses for these.
> 
> About the same level of difficulty...
> 
> > Or maybe we can ask for one of the Redhat ones (maintained by Gerd).

Well, they are meant for virtual devices emulated by qemu (and the
registry is docs/specs/pci-ids.rst in the qemu repo).

We made exceptions to that rule before (linux/samples/vfio-mdev/mdpy.c
got one for example).  So feel free to try sending a patch with an
update to qemu-devel.  There should be a /good/ explanation why you want
go that route, and "I'm to lazy to get one from my employer" is not what
I'd consider "good".  Also it's qemu release freeze and vacation season
right now, so don't expect this process to be fast.

take care,
  Gerd


