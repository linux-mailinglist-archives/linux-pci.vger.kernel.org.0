Return-Path: <linux-pci+bounces-38823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C9BF3F30
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B42318C612F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3F24DD00;
	Mon, 20 Oct 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHoCQRDC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF82EFD98
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000004; cv=none; b=PPl1G2eFEWeIrh4Q1ozA8gEJ8RU+RmAvdTU44hE0Q1BTCWZYfFC0vNtxZeEH/veS5v45eqT3OgkPgf9NZ/cphQ6mX/Rr6TbVo+iKjdlHR8EI6sEtYpTHvgw2EBTbSpSTgmDAMrhBZexwvwSTWBLcRmSzhJ6Wys4QrPy4hU/KI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000004; c=relaxed/simple;
	bh=Tgo1ln9Y6VE+gmfHVXivughYL6jpYIM3N6Z1Efok2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaGI0BsUd+sl/s5HTjniS/0zzmnbqmXRYfkzVQMNIKqCWCbr98FjqkCSAkhBlpdWD8tMajuIEe0WZdGzWq0qO3jkg3K4BosPGgdc0xbigoz/JgiayyeEEYRlemnEl7+n+NzoNx7We0IbjHQGdWLLQBQd72MFfR0i0XiTNk1hEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHoCQRDC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290da96b37fso46505ad.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761000003; x=1761604803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqANdouNpfXe1TpRYeq8OtUbMCXC+xuGaNpt4ay/34I=;
        b=kHoCQRDCLAqY+/x0NIU6c3OeceXwFh8uwuWbvIggH0Zz4XqRyglBIM0JiG0JAG8S49
         /fX4XT6jB/t9V46/BMVXE0O4vjuefOUJAGgoYk/fh/dgATD0etjtAq/PkL9BqqP9Iz9+
         tENviSWhG15OZzlWEyLobHukGWpovdXWTIfIPIIUW9NEW46RWKX+8MF4c8vJkvtHieO2
         cO/ESgKvyRynBmu3Yh79rWorIVUxRZhEnYcgy5C/jdrfn3ajv9gc4d+hUBUTvBJqPeRb
         bwD8saoLyE7Xwb6UpmR5yt39lxS66WE0N7gKLMJ0ireDzuh0lWoTRfHZ4YYTF/ZeVVlA
         +82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000003; x=1761604803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqANdouNpfXe1TpRYeq8OtUbMCXC+xuGaNpt4ay/34I=;
        b=izq2yDJX9iIqJ41F/wzSJmkKdA2B3OXe0QqeBei+FAIezuBEH+WPaBJQWTQAn6by6X
         CDi3y6d7jue2oNZ2inm+Qx88MicE3FWsaV1S/cTaGV0xG27IcNIBifHYmkBGSbak82yZ
         E6SbJxl1DmiPKxKYKKqJ5GIqueVNjl6FtFxhHM4DgeGaZEq3Cad3JExS+CTOeWYdwlOI
         nJEQYnrFe11cV7RLuyMBn7OPErW67JyW+15tfviZ6dFa3IyMFZXfIQwzct13JsmCjZmE
         CFgRgvlSVzybFulE5JDMvXiJPSYL7Am1HqQRlMFIM9hHnF4r7s9HQUsLVA8cqeH20dRF
         eVVw==
X-Forwarded-Encrypted: i=1; AJvYcCVkaJluRIo4jntfkmY7ZLlSt21OfUVlKqzccDXi5yAnY9sOYVcAKgSdrIfA3MX9h+WmXxm7hzK8gIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sw8aedykNAm3tHvUrgznkXfPuKZKoG4jz6lB438XiUaC2HQW
	g9p1tgI8cfScoVfeA93YdmOpZ8CJY98gQUEqpfI/LK8t132ORSowbobiOm3cyWRHFA==
X-Gm-Gg: ASbGncsWCokUJ2jU7A6pmKwxnQVciIBw0nihXBYB2iYX+lQKh0sPDP8j3jEuP3zUzmf
	Oegzj//QbvVph3lspK9y56iIds0L+JyoE4VCYo6ONoXzEnjdy0LP4BpqAhyvLuVsprq9CmkZvUr
	7DxCqvkAwCj62d8cS+VqshKjIx6AjrrZPkUQ+yVnp01AHY1LD2XdrHFXUVKRrSDH2xIxB1bOfmb
	vsbXG7hRfy3fioMJo4Qh3vwxjc5DnmtK7+HxJjTq2Q1EQaOcSI00lV9d5jfLDMHziYx7QWZmtDU
	a7ISSdJSWzZZWw15GsRShzMDGYGxgffduT4bk0wY70Ch9Awem6wnqBdhhEfL1J0C4tlmARojGsF
	CUO/hnLMO22N8yURqXKEP+l7JnM9ifWn02YLzlk5XKwpoXnbFPhpwQ2V+Ef4551I1y1sPmL0kCE
	F2xpZFhVKZFiCqtWESkJ+bETXFpOpVNbF9ojyW
X-Google-Smtp-Source: AGHT+IEcqTlHp/Qpfza19a+3ciBdyb/icBOnAmIupjsmC3a9l9OFGVEdaUxANAVMTmKc4io99zwLcw==
X-Received: by 2002:a17:903:8c7:b0:291:6488:5af5 with SMTP id d9443c01a7336-292de2e477emr479535ad.1.1761000002470;
        Mon, 20 Oct 2025 15:40:02 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm90693775ad.92.2025.10.20.15.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:40:01 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:39:57 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 12/21] vfio/pci: Skip clearing bus master on live
 update restored device
Message-ID: <20251020223957.GA610352.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-13-vipinsh@google.com>
 <aPapy8nuqO3EETQB@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPapy8nuqO3EETQB@google.com>

On 2025-10-20 21:29:47, David Matlack wrote:
> On 2025-10-17 05:07 PM, Vipin Sharma wrote:
> 
> > @@ -167,6 +173,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
> >  	 */
> >  	filep->f_mapping = device->inode->i_mapping;
> >  	*file = filep;
> > +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> > +	guard(mutex)(&device->dev_set->lock);
> > +	vdev->liveupdate_restore = ser;
> 
> FYI, this causes a build failure for me:
> 
> drivers/vfio/pci/vfio_pci_liveupdate.c:381:3: error: cannot jump from this goto statement to its label
>   381 |                 goto err_get_registration;
>       |                 ^
> drivers/vfio/pci/vfio_pci_liveupdate.c:394:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
>   394 |         guard(mutex)(&device->dev_set->lock);
>       |         ^
> 
> It seems you cannot jump past a guard(). Replacing the guard with
> lock/unlock fixes it, and so does putting the guard into its own inner
> statement.

I didn't get this error in my builds. I used:

  make -j$(nproc) bzImage

After your email, I tried with clang, using:

  LLVM=1 make -j$(nproc) bzImage

This one indeed fails with the error you mentioned. Thanks for catching
it. I wonder why gcc not complaining about it? May be I need to pass
some options to enable this build error on gcc.

