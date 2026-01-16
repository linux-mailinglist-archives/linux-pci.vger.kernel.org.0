Return-Path: <linux-pci+bounces-45065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B35D336DD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1097305FC56
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0447C344039;
	Fri, 16 Jan 2026 16:16:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BD2EA156;
	Fri, 16 Jan 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580175; cv=none; b=lLJuQtQH5+JLogYV2xCyxr67KsiN28Jr0WKni6tICYenXu64dklz8knKNyIjrENV1A5oI5HcLff+d+lL+L2zygXMwTzKE8fm4l/6cFzr94dj+WjOVyEZfb3OXozlq8iwAoCVHLo+rC6esZHmeEVtqSTUci0qsp0vlwM0oHMdLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580175; c=relaxed/simple;
	bh=Jh70AL4tJM2AQ34G5j3CocRsJ00uPwSiXV+hX1Q4kyY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wlsn+hStL/yWP7kZgT6yy6f4o1s6pDswoEiGZD/Lm2iYQPiYGsydzyQetXZxHnUPStx2PXTDBANpYFx8gOWJAQ5BzdC5/mQ5KwrkG3BEWJmi+vs+DnDfC2IBmwVWrRDANa+YzTpjd+RYPXNcjvue4YyOhctdfYbxi0JibQUBsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dt4hd6qKHzHnGd4;
	Sat, 17 Jan 2026 00:15:45 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D67740563;
	Sat, 17 Jan 2026 00:16:10 +0800 (CST)
Received: from localhost (10.126.168.43) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Jan
 2026 16:16:08 +0000
Date: Fri, 16 Jan 2026 16:16:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Message-ID: <20260116161607.00005588@huawei.com>
In-Reply-To: <20260116150119.00003bbd@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-20-terry.bowman@amd.com>
	<20260115144605.00000666@huawei.com>
	<6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
	<20260116150119.00003bbd@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)


> 	rc = check_no_existing_dport(port, dport_dev);
> 	if (rc)
> 		return ERR_PTR(rc);
> 
> then can rename new_dport to dport for this patch.
> Or don't bother hiding it and just use dport variable for both. 
> 
> 
> >  	int rc;
> >  
> > @@ -1615,29 +1649,47 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
> >  		return ERR_PTR(-EBUSY);
> >  	}
> >  
> > -	struct cxl_dport *new_dport __free(del_cxl_dport) =
> > -		devm_cxl_add_dport_by_dev(port, dport_dev);
> > -	if (IS_ERR(new_dport))
> > -		return new_dport;
> > -
> > -	cxl_switch_parse_cdat(new_dport);
> > +	/*
> > +	 * With the first dport arrival it is now safe to start looking at
> > +	 * component registers. Be careful to not strand resources if dport
> > +	 * creation ultimately fails.
> > +	 */
> > +	struct cxl_port *port_group __free(cxl_port_release_group) =
> > +		cxl_port_open_group(port);  
> 
> So this is relies on everything being registered against port->dev, whereas
> for root ports this then gets handed off to port->uport_dev.
> That's a bit obscure - hence request for some patch description text
> on who owns what resources + when.
> 
> > +	if (IS_ERR(port_group))
> > +		return ERR_CAST(port_group);
> >  
> > -	if (ida_is_empty(&port->decoder_ida)) {
> > +	if (port->nr_dports == 0) {
> >  		rc = devm_cxl_switch_port_decoders_setup(port);
> >  		if (rc)
> >  			return ERR_PTR(rc);
I'm not totally sure I have an appropriate base for messing with this but
with just this patch on top of cxl/for-7.0/cxl-init I'm getting problems
with the reorder here as the devm_cxl_switch_port fails to map HDM decoders.
On a simple single switch couple of devices test.

I'm probably suffering Friday afternoon syndrome (and naughty testing just
a middle patch in a series)

My 'guess' is that it's because we no longer add the port first.
I couldn't spot any other patch messing with related logic earlier in Terry's series
(and wanted to keep what I was messing with for trying alternative fixes to a minimum)

Any thoughts on what I'm missing?

Jonathan


> > -		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
> > -			new_dport->port_id, dev_name(dport_dev));
> > -		return no_free_ptr(new_dport);
> > +		/*
> > +		 * Note, when nr_dports returns to zero the port is unregistered
> > +		 * and triggers cleanup. I.e. no need for open-coded release
> > +		 * action on dport removal. See cxl_detach_ep() for that logic.
> > +		 */
> >  	}
> >  
> > +	new_dport = cxl_add_dport_by_dev(port, dport_dev);
> > +	if (IS_ERR(new_dport))
> > +		return new_dport;
> > +
> > +	rc = cxl_dport_autoremove(new_dport);
> > +	if (rc)
> > +		return ERR_PTR(rc);
> > +
> > +	cxl_switch_parse_cdat(new_dport);
> > +
> > +	/* group tracking no longer needed, dport successfully added */
> > +	cxl_port_remove_group(no_free_ptr(port_group));  


