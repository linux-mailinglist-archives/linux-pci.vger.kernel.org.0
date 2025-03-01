Return-Path: <linux-pci+bounces-22689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1BA4A70D
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 01:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB03AA8A6
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 00:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDDA926;
	Sat,  1 Mar 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z8vaSmji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D6101DE
	for <linux-pci@vger.kernel.org>; Sat,  1 Mar 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789435; cv=none; b=FrcZZnHfTzn8sEAUk83IbdSH0iHZAHjN/M4qAODM3POLGnJZaVaoEZLf5Hq9Zxv3xZKp/EiSMN8XsRKbE7sd9YrDxx7eAzanV1+issmrCC546eir5suw7sag3qtzBTPhtnNrA92tBsiEw60CLEHUNyiitdi5RDd89KS4qcUVcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789435; c=relaxed/simple;
	bh=KWp+JkEQ384C2ZZM2vnmvijKALezyZ2yoZO4XWGrnII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNF+nkkJx0bg7mlSZNgZ8cGrRwlJFanu0g8rHMJiJ4AvBNElC6F7TbG2yGJKcBuv5I6UJaQfIPIWq6aC9pgdlqF/NwSxvqnfygUCATBCM8h4HDWZSFR9myiWBZK+mH4J6RV4Y8QqkpIL+eUDYm7Uj5DjAeXkKX8gc262x2EzIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z8vaSmji; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0a4b030f2so348832685a.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740789432; x=1741394232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Td3ECwr3BYX3Fk7gFnUV4jIGzq67kra6+CNEYMgu4U=;
        b=Z8vaSmjiEs+nPorZdfUrAjkI1nEevckyK9Dh0B6Eq0ipato35eeCQa5LdGx3pwfRj0
         oHw5Z/HV64Z6ebo2cDFx2aJiu+12an0VTAwKlta62BwuP1Xt/rXOogyne1kCkwFon4fD
         OdyRkws1GJPN8HkEAc4rUylqjiKZts2fNC/Pnc9Aa6PUvYEWOcR8YxOg5nZ+roDZFuVg
         HkkWbUSMKmhusUHsKo1fLm3AGkT8mgStDoqea3zdc8aM0Nuj29X9MTfH0lHAjFLCE0Hx
         6uAKoPwQJoAjVepzI4fhcsqRsXYRTZDS6wZ8haCsLuYDzxWUe1ufMnTZlLPqmQ2LmJzD
         /l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789432; x=1741394232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Td3ECwr3BYX3Fk7gFnUV4jIGzq67kra6+CNEYMgu4U=;
        b=aZAFBZcsrU3ZP9KCUp5FwibcL5tJbmCuBSu3lms0tQUpuvd0gJVzCwHwqT23s9gL8P
         HFeLojmZ3nrlLXPeq7xpHMu7VBwKfGWD3aMCYy9cuVix0C0+VoTKTm/TLZ2VodHDWkb3
         Z4tKBTHhnTOWmNmEriTmbklSS0BoC3Tq3LQQMzbxY+K6MI5P0ZPT4z0VzOm+LbdGX7OM
         jN0V7oQ0nXTp+bcu/VmemcSnUnIm4/Fbz4BTt7vsg0zK+azogc1eawy4WmMnmrKDARFS
         QUK7IkxKpGrXsmdj3aYQ+1F454ZFC/2RlG5zq+e9PanDbKRuI5qCOfeKSGIQpAkEST7L
         dl0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1zUMwHTcIhWkpjTOpy/MY/5jvfweKoSYmr+7aYDmbS2sXjMqgFznm8Ww+uNadbCQzn76HXRiKzwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NLVvaj0j4Go65uCCRBjrsrBm4IIF7sF3mlSnU6ii+N3k6lwF
	PzzovIK1V29ZMaql/ImUy99la/YkeTSW7dPFGx+pyd/0Q+01WPXgarVFSkSGCK0=
X-Gm-Gg: ASbGncsVIg8wbZjyRKwz/cZaJL21iu2MMz0OBfkc8euwvEw8z9LNwYv+i7DaelqHoIz
	T1MYw3VpcIV6KKjRIMZcqUqibI3QL4RG3Jm3tDuu7Ly63DtGWlcEyRM82+cnWI2PGXIZ9m9pXTo
	ayF8j2aEZ38LuiH8nX99mlzbW/f0djJlCvOh6NXwRV7lBIxznk8IeZ2lMz8ggiFLcrI9RBm822V
	9ItIAUZ/OVBmw43t6DB/byoMjlXjd1VU5keQuFWrmpqDPpCOmi0femALvamTOyPSL0vmTbmaK1e
	ojbuh981ifv7Pu9JldAdcwasXf6ceJzVHsnqXbmO5s8Wbqaw5ebEC5ZCeU3gBHIVL5D0ebHafuW
	Koj4lRrWPcnTO+i4uqA==
X-Google-Smtp-Source: AGHT+IFOn/ksSHuws3wokBJvJa6/sj/LoYkAsoS+wBwh3GzDwSM7WHVrzGwS02MkZWU6Ex8ojjGm5Q==
X-Received: by 2002:a05:620a:4051:b0:7c0:9ac5:7f9e with SMTP id af79cd13be357-7c39c6691eamr774480385a.50.1740789432305;
        Fri, 28 Feb 2025 16:37:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dac6d3sm310478485a.97.2025.02.28.16.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:37:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAqt-00000000VRk-15Wo;
	Fri, 28 Feb 2025 20:37:11 -0400
Date: Fri, 28 Feb 2025 20:37:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250301003711.GR5011@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>

On Thu, Feb 27, 2025 at 11:59:18AM +0800, Xu Yilun wrote:
> On Wed, Feb 26, 2025 at 09:12:02AM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> > 
> > > E.g. I don't think VFIO driver would expect its MMIO access suddenly
> > > failed without knowing what happened.
> > 
> > What do people expect to happen here anyhow? Do you still intend to
> > mmap any of the MMIO into the hypervisor? No, right? It is all locked
> 
> Not expecting mmap the MMIO, but I switched to another way. VFIO doesn't
> disallow mmap until bind, and if there is mmap on bind, bind failed.
> That's my understanding of your comments.

That seems reasonable

> Another concern is about dma-buf importer (e.g. KVM) mapping the MMIO.
> Recall we are working on the VFIO dma-buf solution, on bind/unbind the
> MMIO accessibility is being changed and importers should be notified to
> remove their mapping beforehand, and rebuild later if possible.
> An immediate requirement for Intel TDX is, KVM should remove secure EPT
> mapping for MMIO before unbind.

dmabuf can do that..

> > > The implementation is basically no difference from:
> > > 
> > > +       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > > +                                              IOMMUFD_OBJ_VDEVICE),
> > > 
> > > The real concern is the device owner, VFIO, should initiate the bind.
> > 
> > There is a big different, the above has correct locking, the other
> > does not :)
> 
> Could you elaborate more on that? Any locking problem if we implement
> bind/unbind outside iommufd. Thanks in advance.

You will be unable to access any information iommufd has in the viommu
and vdevice objects. So you will not be able to pass a viommu ID or
vBDF to the secure world unless you enter through an iommufd path, and
use iommufd_get_object() to obtain the required locks.
 
I don't know what the API signatures are for all three platforms to
tell if this is a problem or not.

Jason

