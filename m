Return-Path: <linux-pci+bounces-357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA91801335
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC0B281720
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D534C21A0E;
	Fri,  1 Dec 2023 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddI24IQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF2D63
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701457003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knBMShKmFlUoH2r+m1jr6Ik+IHyXp9YX9Nzcxs2hiqc=;
	b=ddI24IQJeZXmLka7MOcyU5PFjzIEfapnFllumudlnlbukzH5QJvQrRKJW8mU0TGuOvm6i5
	rPibpdQNhhaqgYgAs1mnxwH5JHHpd8638amOFjPnyxv/GpZ8PmxLmnoAYKzwhAdUNHVe33
	SimmXQl4TNhWee4M4LidaYUf1OtBNUY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-pWpGNjzGMiuUIHVs8kTv0g-1; Fri, 01 Dec 2023 13:56:42 -0500
X-MC-Unique: pWpGNjzGMiuUIHVs8kTv0g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3333260b3c6so135114f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Dec 2023 10:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457000; x=1702061800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knBMShKmFlUoH2r+m1jr6Ik+IHyXp9YX9Nzcxs2hiqc=;
        b=wtg5bM6TM17FzZR0ta/XbUGh3Y4au1tsQ4zJN720KzJ0DDeU/4Ln2rcPwzcirPUyGI
         GOUX/l6KlyKAMeT2jtCWkWuJkQK68tY/Empx2UjS7EOC3cSXZ/mFZIe1oRpUps5uFlqK
         lo31rj+kLHKB3OyZCYttVd4Qv0dRxgBs5djOHLoCpj/pSDy1tQIZ/7QUEncMPqxE0YUQ
         WfjZ6P098ofUAg2FRXqR6ZyKiJAAQnkiwVIThml4OxCbgsKl7ND2tLnmm4w+ewwRCkNZ
         QazTjxOp1s7Kau9Ar0VZCD2J06TvchNspX4DE4sa+XGaBGyNQQlnsBTXHLaO6EkesyNE
         cSMA==
X-Gm-Message-State: AOJu0YxCFrWOEYRv5Eej3Gy9awKnHyoR36M4bgZRAhqkHUVuRH+mPseu
	GZh1RwyXpYELR2Rud6TtMmSdgxL63s/2uzgkLZl5yTd4tqOwTyuxcsiAxgPoiHWfe4/TUthDz8k
	P4cezo0yx5ZVtZCbS13dK
X-Received: by 2002:a5d:6c6c:0:b0:333:30ff:1f69 with SMTP id r12-20020a5d6c6c000000b0033330ff1f69mr2267064wrz.2.1701456999968;
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYgHWBQ7ogcvjbLFWn2No+e3cu9LEahop+KqhFPcJLWwUOIMB6Bc+JurOdJinf9T84hx/+XQ==
X-Received: by 2002:a5d:6c6c:0:b0:333:30ff:1f69 with SMTP id r12-20020a5d6c6c000000b0033330ff1f69mr2267048wrz.2.1701456999652;
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003296b488961sm4857046wru.31.2023.12.01.10.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
Message-ID: <4bf46893a583551c71bdfbf91df9ccc4b51556b1.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
From: Philipp Stanner <pstanner@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, Neil Brown <neilb@suse.de>,
 Niklas Schnelle <schnelle@linux.ibm.com>, John Sanpe <sanpeqf@gmail.com>, 
 Kent Overstreet <kent.overstreet@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, David Gow
 <davidgow@google.com>, Yury Norov <yury.norov@gmail.com>, "wuqiang.matt"
 <wuqiang.matt@bytedance.com>, Jason Baron <jbaron@akamai.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Danilo
 Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Linux-Arch
	 <linux-arch@vger.kernel.org>
Date: Fri, 01 Dec 2023 19:56:36 +0100
In-Reply-To: <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
	 <20231201121622.16343-2-pstanner@redhat.com>
	 <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 15:43 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> >=20
> > -#ifdef CONFIG_PCI
> > =C2=A0/**
>=20
> You should not remove the #ifdef here, it probably results in
> a build failure when CONFIG_GENERIC_PCI_IOMAP is set and
> GENERIC_PCI is not.

CONFIG_PCI you mean.
Yes, that results in a build failure. That's what the Intel bots have
reminded me of subtly before, which is why I:

>=20
> Alternatively you could use Kconfig or Makefile logic to
> prevent the file from being built without CONFIG_PCI.

did exactly that in this very patch:

@@ -14,6 +14,7 @@ ifdef CONFIG_PCI             <------------
 obj-$(CONFIG_PROC_FS)		+=3D proc.o
 obj-$(CONFIG_SYSFS)		+=3D slot.o
 obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o     <-----------
 endif


P.

>=20
> =C2=A0=C2=A0 Arnd
>=20


