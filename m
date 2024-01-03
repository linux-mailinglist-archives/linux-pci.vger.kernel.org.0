Return-Path: <linux-pci+bounces-1618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C28229E3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB571C23176
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297918043;
	Wed,  3 Jan 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXBIwOQP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5A18C07
	for <linux-pci@vger.kernel.org>; Wed,  3 Jan 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704272651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kimaz79paVloj/e6SryFhzLQ5bfwrfwnGX6HNnH18gM=;
	b=eXBIwOQP8Rmuoyang2YSyr5cFn8LrKkDaw8XKAHCF4RTTFNfYdPMs4eN9tXBlM68Cjtw68
	ili09p45mUaf9/E5IZzWaVBsMhUEBQTm6A22/L5lC3XTO/k0m1lIcnrfMSCPgTtrnRMnYp
	TSmVxnES+IN/b0q6eNcfjf5dWQbl6v8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-wAul_2OmNvePs9KItGsgeQ-1; Wed, 03 Jan 2024 04:04:09 -0500
X-MC-Unique: wAul_2OmNvePs9KItGsgeQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-556971b0353so478450a12.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Jan 2024 01:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704272648; x=1704877448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kimaz79paVloj/e6SryFhzLQ5bfwrfwnGX6HNnH18gM=;
        b=Zu98OZl/ZeelKeHpmQ61YWHqtWgv66LCzNX1vDhXgCJ7kjGQhpc55ry/TCPS02G3t6
         OGaXKAiMz2A6nzkPdf6Qz8wTbpFM/AXTNYxJ6Vm5dTd0oM0MQwqNRNzT0jhi2v/p9Q30
         A1yJPFMkvoiX7Zv4/7Uo/kxE+ullfbdIo3vL03+9XymnM5ulM1bCK1lZxWBXk69QRZjg
         Zir4iZEibFP6RVrUOkYdEAHXNf94kTThQJ17/Hv5b2UHTksmcw8sYxa4FsXOePFvLTDh
         qwlRPr71DS+b75vctO6Wf6M04VUc29mPsTWtSNuavyDLYR48fAQtPk6b6Wt/twYlOjHk
         Zc5g==
X-Gm-Message-State: AOJu0YwGYuG7W7AiJ201jN+Q9Sglz25UgGmqdzvF+Nn3mIBuGRw+jfzJ
	NOLtSuST3KjK9LGi+6WNhH4wjTQf5vustbBDr4lrwXSvX746cPrPY0YJVCr54jQp/PyqQdT6Sm3
	GiEQ8nT7beEFm25tW/ywifYQKBQYO
X-Received: by 2002:a50:cd56:0:b0:553:7f36:b90c with SMTP id d22-20020a50cd56000000b005537f36b90cmr11355402edj.1.1704272648342;
        Wed, 03 Jan 2024 01:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnzXW1T/PtiyMEePFAeIfjoDdcIOAwrLU81pstOcxV+Ri0wVlPHV3elGdnjF9boBnTgsZDvA==
X-Received: by 2002:a50:cd56:0:b0:553:7f36:b90c with SMTP id d22-20020a50cd56000000b005537f36b90cmr11355396edj.1.1704272648000;
        Wed, 03 Jan 2024 01:04:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id ck15-20020a0564021c0f00b00555f908b2e4sm5623610edb.40.2024.01.03.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:04:07 -0800 (PST)
Date: Wed, 3 Jan 2024 10:04:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20240103100406.0c5ff818@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZYPYIpO36YE8V8hQ@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
	<20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
	<ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
	<ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
	<20231215143638.032028eb@imammedo.users.ipa.redhat.com>
	<ZXziuPCKNBLhbssO@marvin.atrad.com.au>
	<ZYPYIpO36YE8V8hQ@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 16:46:02 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Sat, Dec 16, 2023 at 10:05:22AM +1030, Jonathan Woithe wrote:
> > On Fri, Dec 15, 2023 at 02:36:38PM +0100, Igor Mammedov wrote:  
> > > On Fri, 15 Dec 2023 21:57:43 +1030
> > > Jonathan Woithe <jwoithe@just42.net> wrote:  
> > > > As mentioned, testing another kernel can only happen next Thursday.  If
> > > > you would like other tests done let me know and I'll do them at the same
> > > > time.  I have remote access to the machine, so it's possible to retrieve
> > > > information from it at any time.  
> > > 
> > > lets wait till you can get logs with dyndbg='...' (I've asked for earlier)
> > > and one more test with "pci=realloc" on kernel CLI to see if that helps.  
> > 
> > Okay.  
> 
> I added the "dyndbg=" option to the 5.15.139 kernel command line and booted. 
> The resulting dmesg output has been attached to bugzilla 218268.
> 
> I also tested 5.15.139 with the "pci=realloc" kernel parameter.  This was
> sufficient to allow the system to boot without a GPU initialisation failure.
> The dmesg output from this boot has also been attached to bugzilla 218268.
> 
> I used kernel.org's 5.15.139 for these tests because I already had it
> compiled and was a little short of time.  If you'd like me to repeat the
> tests with a different kernel let me know which one and I'll see what I can
> do.  The Christmas break may delay this somewhat.

Thanks for collecting tables and debug logs,
I'll get back to you if more debug info or testing would be needed.

> Regards
>   jonathan
> 


