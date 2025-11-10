Return-Path: <linux-pci+bounces-40698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB438C46597
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2CC1883531
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4C16CD33;
	Mon, 10 Nov 2025 11:45:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008B191
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775129; cv=none; b=uPjyAPdwPdr/NHFR+9F5LGYvpQ5dH0N6ZgiYoGGRwPCLYmPjzVPjSrKYv0UvB9Vyej3wLRWfAAA+ZmHorkhxtoKl77W6R3Po61Ls1cNyFwDOeWlWVY8lEvAaFktNSHLiKP2psgM+UdvW8d+tGIvmak7G17/r0fzYx9Omc2YvvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775129; c=relaxed/simple;
	bh=mO+M3OsZ99LF3rLkInL/l5A71FoJ9EbfBycGqzjIcy8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0ZqggGvyvcFSm1kYCdx6h0qmC1zVXv2R2I/Zj4mW3oS4oqRQCd3LbYC6OBvD96MuyrcZYS2kR+sWEiJ5PTF4ISuY0cGKs910rymHP4aWZe76KpW1/Odmm7w4rMwOfECloX3gpE/JQsay27Rjoo9epJK/qVD2Fpt7cvRG6kAOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4nsC5DyxzHnGf6;
	Mon, 10 Nov 2025 19:45:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C4D2C14038F;
	Mon, 10 Nov 2025 19:45:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 11:45:18 +0000
Date: Mon, 10 Nov 2025 11:45:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <xin@zytor.com>, <chao.gao@intel.com>
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Message-ID: <20251110114517.00000280@huawei.com>
In-Reply-To: <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-21-dan.j.williams@intel.com>
	<20251030112055.00001fcb@huawei.com>
	<69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
	<aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 6 Nov 2025 13:18:41 +0800
Xu Yilun <yilun.xu@linux.intel.com> wrote:

> On Mon, Nov 03, 2025 at 03:34:15PM -0800, dan.j.williams@intel.com wrote:
> > Jonathan Cameron wrote:  
> > > On Fri, 19 Sep 2025 07:22:29 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > 
> > > > Add basic skeleton for connect()/disconnect() handlers. The major steps
> > > > are SPDM setup first and then IDE selective stream setup.
> > > > 
> > > > No detailed TDX Connect implementation.
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > Feels like use of __free() in here is inappropriate to me.
> > >   
> > > > ---
> > > >  drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
> > > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > > > index f5a869443b15..0d052a1acf62 100644
> > > > --- a/drivers/virt/coco/tdx-host/tdx-host.c
> > > > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> > > > @@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
> > > >  	return ret;  
> > >   
> > > > +
> > > > +static void __tdx_link_disconnect(struct tdx_link *tlink)
> > > > +{
> > > > +	tdx_ide_stream_teardown(tlink);
> > > > +	tdx_spdm_session_teardown(tlink);
> > > > +}
> > > > +
> > > > +DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
> > > > +
> > > >  static int tdx_link_connect(struct pci_dev *pdev)
> > > >  {
> > > > -	return -ENXIO;
> > > > +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> > > > +	int ret;
> > > > +
> > > > +	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;  
> > > I'm not a fan on an ownership pass like this just for purposes of cleaning up.  
> > 
> > Yeah this needs a rethink. The session and the stream are independent
> > resources. It can be a composite object that encapsulates both
> > resources, but not tlink directly.
> > 
> > ...chalk this up to RFC expediency.
> >   
> > > I'd be a bit happier if you could make it
> > > 	struct tdx_link *tlink __free(__tdx_link_disconnect) = to_tdx_link(pdev->dsm);
> > > 
> > > but I still don't really like it.  I think I'd just not use __free and stick
> > > to traditional cleanup in via a goto.   
> > 
> > I would not go that far, but certainly I can see that being preferable
> > than reusing the existing base 'struct tdx_link *' as the cleanup
> > variable.  
> 
> The latest implementation internally is as follows. tlink_spdm &
> tlink_ide represent independent resources though they point to the same
> instance. I'm already comfortable about this code:
> 
> static int tdx_link_connect(struct pci_dev *pdev)
> {
> 	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> 
> 	struct tdx_link *tlink_spdm __free(tdx_spdm_session_teardown) =
> 		tdx_spdm_session_setup(tlink);
> 	if (IS_ERR(tlink_spdm)) {
> 		pci_err(pdev, "fail to setup spdm session\n");
> 		return PTR_ERR(tlink_spdm);
> 	}
> 
> 	struct tdx_link *tlink_ide __free(tdx_ide_stream_teardown) =
> 		tdx_ide_stream_setup(tlink);
> 	if (IS_ERR(tlink_ide)) {
> 		pci_err(pdev, "fail to setup ide stream\n");
> 		return PTR_ERR(tlink_ide);
> 	}
> 
> 	retain_and_null_ptr(tlink_spdm);
> 	retain_and_null_ptr(tlink_ide);
> 
> 	return 0;
> }
Nice. That looks good to me.

J


