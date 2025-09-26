Return-Path: <linux-pci+bounces-37098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B82BA408C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ADA4C22C9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D32F7AD8;
	Fri, 26 Sep 2025 14:06:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558119E83C;
	Fri, 26 Sep 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895584; cv=none; b=i1wtaWi9zGrKHHOWKSw+bCe00vomjlrOW0cCkk6RZC6bQYKUO4SZ6x7wMvIt4nn6+aSt+/1WuRVnvOhy3sgVzjdn4cv6JRmyoirs9zSdIiE5w9w1nk80IapwJGagn6PBMVXjGyDdyxkMSb5/koLXj/Lca8pv3+HcL6XHZYukipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895584; c=relaxed/simple;
	bh=nanZszz1JglngHCKknFjMrK0HjwD/8Fh7QHdgVjsl8M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyzxYvMti06NMuHnwYuRi9u2kar5O5w4MB1ZKK3LaQC9N8udp/w5dNgp93TaIWaU3D2pfDzu5cz+JDuUYN9jPjRS95UX5/y6gmrds3miTMuhKXBSn0jiMYpgCXdq0uxyInY/4b7cf7+Pb52ReKn0iL1Rs2sWjxOkGpxBajaL33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cYC4f6zlXz6L53p;
	Fri, 26 Sep 2025 22:04:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EDB3C1402ED;
	Fri, 26 Sep 2025 22:06:17 +0800 (CST)
Received: from localhost (10.47.75.77) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 15:06:17 +0100
Date: Fri, 26 Sep 2025 15:06:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Zhang Qilong
	<zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Dan
 Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/3] PCI/sysfs: Use runtime PM class macro for
 auto-cleanup
Message-ID: <20250926150613.000073a4@huawei.com>
In-Reply-To: <20250922185036.GA1983521@bhelgaas>
References: <1950293.tdWV9SEqCh@rafael.j.wysocki>
	<20250922185036.GA1983521@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 22 Sep 2025 13:50:36 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Sep 22, 2025 at 05:31:53PM +0200, Rafael J. Wysocki wrote:
> > From: Takashi Iwai <tiwai@suse.de>
> > 
> > Use the newly introduced class macro to simplify the code.
> > 
> > Also, add the proper error handling for the PM runtime get errors.
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de
> > [ rjw: Adjusted the subject and the name of the class ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>  
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Being half asleep I went and  replied to v1 when v2 and indeed this v3
were already out. Sorry about that.

Anyhow question is why not ACQUIRE() and ACQUIRE_ERR()?

original discussion on how those came about rather that direct use of
class that you have here was I think here:
https://lore.kernel.org/all/20250509104028.GL4439@noisy.programming.kicks-ass.net/

Though note, we didn't end up with the parallel universe that is talking about.

+CC Dan,

Jonathan

> 
> > ---
> > 
> > v2 -> v3: No changes
> > 
> > v1 -> v2:
> >    * Adjust the name of the class to handle the disabled runtime PM case
> >      transparently (like the original code).
> > 
> > ---
> >  drivers/pci/pci-sysfs.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
> >  		return count;
> >  	}
> >  
> > -	pm_runtime_get_sync(dev);
> > -	struct device *pmdev __free(pm_runtime_put) = dev;
> > +	CLASS(pm_runtime_get_active, pmdev)(dev);
> > +	if (IS_ERR(pmdev))
> > +		return -ENXIO;
> >  
> >  	if (sysfs_streq(buf, "default")) {
> >  		pci_init_reset_methods(pdev);
> > 
> > 
> >   
> 


