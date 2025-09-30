Return-Path: <linux-pci+bounces-37286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAEBAE156
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F352C167299
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB42248B9;
	Tue, 30 Sep 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fHdwp1td"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE491D5CD4
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250829; cv=none; b=EXEZKSxxX5Gf6eQhwRBZcml6V/jAtRkaG2sjKPPPpVEeVv0wk++8DPFxCx3HY9ERN+UiSw0Mu3WaACjJFeCmZfX6Y3HpN/GYJyAUTTehfRQnTWU/ru4q56v+5VNxPRVPTIBKoHRrifkjeC23Ft91klfWRPetE1sogBAlUvhOmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250829; c=relaxed/simple;
	bh=PIv7RFfSTozm/dDIBeJE04QFG2UZssNmNHzyWXHohSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qExnRExbZ6/nFfLmXzcjClH0ziuCiJO8OciJtmuZbtoflRGQ7bwNZtMHIu0W4EXfomFO9C3BABYX+9GZB2S6B1mKN9nxz7BmDk8XmAodZgraQ9+yUHYi/eQt/Q+n8NseOOnYtvj5whbGFWJxL3yD28fnfIpAG/31HP8ZWA7qLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fHdwp1td; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f715fb494so603904b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759250827; x=1759855627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GqVI3f7/f45xPRtJOYeU9gdPBWqgMrF39I3JaE1PqsE=;
        b=fHdwp1tdSN7xOcV5NWT9DF5HJVu06k1QHOOqASR1QGAWoF/2Lxf9chaDpNKIKFGoID
         vp4Nmm+tgQOi5aL3SXHpDrr5FH9hXjH9PoFBrb5C3VHfTHduehaTGhFzPNDNHLjiS+gE
         kpN5YOM/IEF5rF3DtVfZ2OMbpKJnfQ5NgBJqSRqjae9mGCYbrTuzn+iL7/FzgsQU4mEm
         s5Pi2O9vcd6y3FWZIheLEC5BlIoJJ6FiygOb8WPfYtJ88OOd+X2vQCdhm8cnPlHJUOO0
         TkM5hO0oq3jQyVlOdgCNrGH1CTbWJuoKvD0ymfIqbzg0F+5ljzP4d+Fm1ngYCUNuf1dx
         ewkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250827; x=1759855627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqVI3f7/f45xPRtJOYeU9gdPBWqgMrF39I3JaE1PqsE=;
        b=T8G/09+5wySvRxp6WDLZ0VdABn6orOX0ou3zkvtLZNVEH947fHDAk4Z2UJWQ51qdAd
         HecUPMLQ+iDTvgHY9lzKOoE/S7s/9nTKi/5RU/6uwkNRtqN6o51k0/s2j+Ovkc6/Ks5i
         SuYxCK2miuAQPZLz/AdmlBKSV4EHIEFLP1s8XQmlbPR2kTKweMicCwUGhQ8Ie8szWavb
         gm+psVIGVNbHSWYzY1QO4ps/oE6l1hKDf55yWd4VAgebsqj9/3efxf/vsgHggo64jhzn
         QHuPrdIoXv1G1D62+GDINQvNYmyrZkr3a/wJapo8EDhVZ0NAKusYtEcRQvahBlOBdf08
         YGXg==
X-Forwarded-Encrypted: i=1; AJvYcCXahIbjGxj7tIKZZ6mIsJAvw1Sv9WGovlyjVgKy4DFDrHTHKe6sl+Ts8n4cMz4Mgi/XPc/fMTj41nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTw6NnxzUiwtb6agYtFA0TimedywbXDTwDLNJeFU5ryAP5zPk8
	57oVdh6RWUgsQc+4LaTTt+jVIg3q2ZrpT8LbJ4Gnp3k3R7Xfadf09rv/UICNztlSRFw=
X-Gm-Gg: ASbGncuGBY9Owhg8Sal6BcFsRZBZBTQMy7qHfwj6TREvX8i71DkIfJAciEbJrQ0pe0S
	PE0aOBSo/KEplnQ06orJt1aLOLxCd4gqklC3nwU6k7CsGM+pLOrXt9hS+PPNEWPCj9iNmaeROUr
	rvPfP2YGPLJ5xiy907mtDL62juZTKzbyPIK+gNyM0QFXR8kd5NFSsGNigJ8ywG6rERhR3y18BGd
	aNOGDvTbC77HFU6+CBxHQlg1V8ewLBamSOEe4/KaikGgWCf5dNML8u6MmuNp7M5nimfRFFwJlGk
	yFkZRv8b7lZ+lQsVgsQiNymVrs0ZSzBGFkwjVAA7kjTlfqlnyZ31+NCnKq+zl1frEvCIEmLyUQn
	OdIGLgkYu+HHXZfQoROJd
X-Google-Smtp-Source: AGHT+IGQSu3ffsuqUa+qF+xnbneyESGryD5+aGw+HqUs0M4NTCy2RAdn4DCrSliUq3lOzNi9jGQkkQ==
X-Received: by 2002:a05:6808:30a9:b0:43f:7e9f:3897 with SMTP id 5614622812f47-43fa41f73f7mr154561b6e.27.1759250826885;
        Tue, 30 Sep 2025 09:47:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f511321d2sm2776610b6e.11.2025.09.30.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:47:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dVJ-0000000Cbqh-06rf;
	Tue, 30 Sep 2025 13:47:05 -0300
Date: Tue, 30 Sep 2025 13:47:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <20250930164705.GR2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
 <20250929174627.GI2695987@ziepe.ca>
 <CAF8kJuN2-Y7YZkY5PrerK=AdTUfsaX0140-yJJSTnNORucYfqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuN2-Y7YZkY5PrerK=AdTUfsaX0140-yJJSTnNORucYfqQ@mail.gmail.com>

On Mon, Sep 29, 2025 at 07:13:51PM -0700, Chris Li wrote:
> On Mon, Sep 29, 2025 at 10:47 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
> > >  static int pci_liveupdate_prepare(void *arg, u64 *data)
> > >  {
> > > +     LIST_HEAD(requested_devices);
> > > +
> > >       pr_info("prepare data[%llx]\n", *data);
> > > +
> > > +     pci_lock_rescan_remove();
> > > +     down_write(&pci_bus_sem);
> > > +
> > > +     build_liveupdate_devices(&requested_devices);
> > > +     cleanup_liveupdate_devices(&requested_devices);
> > > +
> > > +     up_write(&pci_bus_sem);
> > > +     pci_unlock_rescan_remove();
> > >       return 0;
> > >  }
> >
> > This doesn't seem conceptually right, PCI should not be preserving
> > everything. Only devices and their related hierarchy that are opted
> > into live update by iommufd should be preserved.
> 
> Can you elaborate? This is not preserving everything, for repserveding
> bus master, only the device and the parent PCI bridge are added to the
> requested_devies list. That is done in the
> build_liveupdate_devices(), the device is added to the listhead pass
> into the function. So it matches the "their related hierarchy" part.
> Can you explain what unnecessary device was preserved in this?

I expected an exported function to request a pci device be preserved
and to populate a tracking list linked to a luo session when that
function is called.

This flags and then search over all the buses seems, IDK, strange and
should probably be justified.

Jason

