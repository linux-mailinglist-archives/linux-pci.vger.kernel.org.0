Return-Path: <linux-pci+bounces-9349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96491A099
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46434282CEA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF34535B7;
	Thu, 27 Jun 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAYfdO8/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515E6D1C1
	for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474085; cv=none; b=CACTzXeSm1B7jXDfv9XVO12fq+Zq1hXJuNIfR/l4XSuWZh/1XuEwJni+o34zt09AUucFFjQ4b3yejLX3N3NTFV2krLs9pvQ5lEimlaaW1sct1anZLu7+b4yxmNwnBlaa73/VZRNLbKNTeF6aKtanHeU5Qsd/v4Gx8G+aBal+wnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474085; c=relaxed/simple;
	bh=ibOAOBns5oeEsMpjEHj0qObW3A1T5Ei34xDQRATtqRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myhRedaZJ4i1ctziXrw9I/pNHRlgeghcDUCZeBO4pTWttwuGAyJgvkVz4WmoPLTsiwuOlJBTFsN/ueo4ur5wvGk9/vKhUOdYd9K2Mvpw+jSMfb2ATfeq4bfO4ARz2tW5Sz5BOtGl5W44xM6qhQpSVpaAWz83VeWJwdCEyFRVaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAYfdO8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719474082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDFpMT/o6TA3HhPIsNw7m21U54PqATB7NjiG2R0C4Rs=;
	b=QAYfdO8/NKSand/5baSqO4Z2IqFn47R8IAGfVo6/EqaV5Z8AqrC6IRTV9N3xpf2YdaAC6S
	ozhfUoJxOKQk8dgGNbITUFGLfTHaNpRulAK+PFyPU9vfsvXemA7tKc1zVMrjKfFoAkj3Vg
	H4eCR1y18MFROxPCPCSby0yF8AElkqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-FVEh-JgYMFm5PWYi11pDUQ-1; Thu, 27 Jun 2024 03:41:21 -0400
X-MC-Unique: FVEh-JgYMFm5PWYi11pDUQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-424a775ee7fso13239265e9.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 00:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474080; x=1720078880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDFpMT/o6TA3HhPIsNw7m21U54PqATB7NjiG2R0C4Rs=;
        b=F/WwiuEy3Qo2yDAmrvtm84ZziW8hJ8GQ0K6spVsjW+glnRvSnPcRQzCjVeoLwXrB+i
         9Q+3nT1kq0aIkJBv1pC6h9VYPhyo/JQDvi/0a06VfMhaEVoLMPtVgSr/IJZ0eFmpMbQ7
         edrVky3VJ9TGB0ZM9v7TJWomKqsO3j41plxFxqPuPUKJxQE/p2TsnEUe1ft8OVjqbVM0
         +5zDONGBgxVlWLIeTqDedlJlbB54PxCnQ/Opbv4x6oG3tgxl5YZXt2+TvOvX7A/HjFyG
         Lj8E1dIFGstG7a3I4e9rsF5OWNs20QqlyDZcbqglaH9quGmqHP/BSvVLVsdwblQj8sxB
         hAUw==
X-Forwarded-Encrypted: i=1; AJvYcCXVNGP+DOQqZtBINAIaKMNq/7ygmqdEk4DuxWq3feTkh7rqrxpB9zsn+fX4ibc+6lnS2Vn7M09/JnYbYVH7EKJl2CizhlwqflyS
X-Gm-Message-State: AOJu0YzGQXeV8fizpfEa9GO2wrwtQtCnwu8prLvwiRTgPa90ufxrKWtI
	wyUrZFA0So7lKuZFriVrEbKRgNsHfjENGCOjV/trQJ9FSV4WiihcyPBiWG/B9Z66PKqA6fxZ/9t
	Ar4NnWTzJvIT7sJxjYJcoxOnbtQa9CU5hyYFqZwuLBIfM++7a+mvN3eoWjw==
X-Received: by 2002:a05:600c:491d:b0:424:fb2f:9d4b with SMTP id 5b1f17b1804b1-424fb2f9f55mr25317165e9.21.1719474080106;
        Thu, 27 Jun 2024 00:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgu93kM3Jj8fkuZn8Yhi8DU/DjUZCFv12pgsTeo8oxcZqTXJeOuwx1mlw8cglG3sJJI8/+Lw==
X-Received: by 2002:a05:600c:491d:b0:424:fb2f:9d4b with SMTP id 5b1f17b1804b1-424fb2f9f55mr25317035e9.21.1719474079749;
        Thu, 27 Jun 2024 00:41:19 -0700 (PDT)
Received: from polis (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367436999e9sm970881f8f.76.2024.06.27.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:41:19 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:41:17 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 01/10] rust: pass module name to `Module::init`
Message-ID: <Zn0XnbPKiarhyu3d@polis>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
 <ZnRUXdMaFJydAn__@cassiopeiae>
 <2024062010-change-clubhouse-b16c@gregkh>
 <ZnSeAZu3IMA4fR8P@cassiopeiae>
 <5d7b22c7-de22-4a8c-a122-624afc3d12f1@redhat.com>
 <2024062732-correct-dwindling-b53c@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062732-correct-dwindling-b53c@gregkh>

On Thu, Jun 27, 2024 at 09:33:39AM +0200, Greg KH wrote:
> On Wed, Jun 26, 2024 at 12:29:01PM +0200, Danilo Krummrich wrote:
> > Hi Greg,
> > 
> > On 6/20/24 23:24, Danilo Krummrich wrote:
> > 
> > This is a polite reminder about the below discussion.
> 
> I know, it's on my TODO list, but I'm currently traveling for a
> conference and will not have time until next week to even consider
> looking at this...

Thanks, Greg, for letting me know. Let's continue this discussion next week
then.

I may send replies on all other mails of this series in order to not leave them
unreplied for too long, but as mentioned, let's get this thread discussed first
once you're able to get back to it.

Have a good trip!

- Danilo

> 
> greg k-h
> 


