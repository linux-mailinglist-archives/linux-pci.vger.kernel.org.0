Return-Path: <linux-pci+bounces-33423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6ADB1B3E7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B7017D610
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787265D8F0;
	Tue,  5 Aug 2025 13:00:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74ED17996;
	Tue,  5 Aug 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398815; cv=none; b=L/RxXtQ35lQlYa54SPhqdjoigtVTRSSuMRxsjA7gr4U62QTtKlQVMscOCLciNffrryESLwz9zjvUZFu3OZmYgO/xcpVx1/RV/Wg2hhfu4JB4TMt9UOsRSXLOAE8Q++EnBvL2kh0j0DXORxYXCRMxkgAm8Fl7HrLwyvh/8vSwuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398815; c=relaxed/simple;
	bh=4t7dMcqzc7zDlbYdbuJAk8tlv9zQyDoso6MSnjmvM50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdlaTrk9DCw8tUM8zrs/4/SRZHSOqbC/1EYW7j+BYZ1c66sUYMhx5DnMszoA6YaAqTDiHVJpo7UKGWZCNHCb9sKov/ioWXNB8BMr+YsPxP1EYqqHd7Cp0BJGuo52WI7nLUi4fZ1knxVjXikoD6HrAW7wekIn4Zq4HIEIsqwsIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso7587848a12.3;
        Tue, 05 Aug 2025 06:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398812; x=1755003612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzQHx1i5Fs/JOgRu+gEHkLfTlj9ZTI1ibV6XEx4O938=;
        b=JUsTIk7LiRZfCbPteZKgD13Bx88wsb/6aaBGdpECOA11fFVTAEXvWFaa9mmEjwoqua
         VUAS/r5FFWrqc9Cy4VdcFQ9xKe5yUIXNt56kqMMJjIzKQDY4J07fwIKalVtHPac/MKrX
         +/fIlCzXoGdtnYSWRv9o2erF9YODUE3AOwQspOS5G15FTUZTHpYsVF3442oBT8YQ+KUS
         f+WEcf3sU8c0AX21CVlZbfFs77tom7GTzB/szbTy/4Feg9wyvaDfvdt99zvsOvf+7bc7
         D1FW+OV1Erg+p7hvUmblgBCT4OktQfnOA3TMlz9eRAiPYMuZlZVoYhSVYSJzFoB2MYP4
         YrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCgcvL5VOmL+Lq0sXH3cv9fMgFIq0iamPy2BDLkJWWkl/o40zgMqn6phl91T2GQYHepwFnsYhysKhj@vger.kernel.org, AJvYcCW+hjNKoa+zChQB5GBQ28LG6lb45BULULlf7LCut3PQ1oXEswZCq0rcWkaJrz0CJG7VOAi2efM/QZ+n@vger.kernel.org, AJvYcCWf4neT7Wh71m/7ilqF/YwstPxXBtd4d1whDDsU18psOilGwVVRnByvix33RLIxxVx/3cjeGLHXl5+PKluK@vger.kernel.org, AJvYcCWsltZkemN8/vG86hEj3dkrcLQ3GIgsH8OxXv2R07HUpzOqAPU3JQiNJPGgBosAYBKkEuADEW4wHJiQUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrM1KFLXiUP3OfLYQ7l0yI5FobOeJ2tvJ8fgYDTstkRFzKDnO
	IxJI2nlm5fVgDVoWOT+11zqZuJn6KywZWYKwdn6mXFjcW/z2GBMT03Mi
X-Gm-Gg: ASbGncuWcljrjn0P6YdrsguMVELhzOOFKQ5JRVzdFHtdpC+AD8JBbQNqJ5bTm0MxOZT
	LNZ2QeU17bItx9aTnnudgenXUlr9tJKdeI/696omhLcNkpawLkNjnXrGOOl24TbZPCBNEVXw08P
	1DRSxuax5qDs33wraQtbacaGimm88YKXTGmnrl/Ru+DgS0BQFPu9IWqH7uW66u9ydNfqht17nnb
	R0GKRrRenACyMJqLYSQLPkLrEfLhDbiAVQpb2A4G1YzvY434CJ3Ar9F/an1RqgwC9pYOp4S1j6N
	UvTvQO7Xg7Hkd4J1K/wFrb9c39GU3eHo73BVEqq9zzLyASWm0n46Sg9RHEuXELdFDuIzYme0feN
	lMUFupVtnKmnS
X-Google-Smtp-Source: AGHT+IGjZSNpW7mJUj3kJ0f8IpMzBnPj+YUjP2KOPDwITdV1e7i/FDQIvzJwDgp/H8IFr3t8Mztalg==
X-Received: by 2002:a05:6402:4402:b0:615:b0e2:124b with SMTP id 4fb4d7f45d1cf-615e715bd27mr13276935a12.24.1754398811018;
        Tue, 05 Aug 2025 06:00:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2a448sm8429117a12.20.2025.08.05.06.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:00:10 -0700 (PDT)
Date: Tue, 5 Aug 2025 06:00:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com
Subject: Re: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <j4ac55vpiemdjdbfzoktoqv763fhpv6q2agmgaeggvahfj5kuy@v7l5lrrdwkjj>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
 <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>
 <f3yl424iqiyctgz4j36hzjrhkgae3a2h5smhalm2qbmq3nrpzd@oeuprthscfez>
 <0c045f1b-44d0-430c-9e8a-58b65dd84453@intel.com>
 <buhwuankenpnvmio6jeoxverixoyfpn2eh62ix7vzxw7xvlxcv@rpibcrufr2yg>
 <842d675e-4c22-4f13-b40b-c4b5208e4223@intel.com>
 <ipdhflmgqrlq2vor657fiwex66jqw2do747uvu3tvrcsvtvdjj@lg5zrcua2dgn>
 <529fbbc1-90fe-467b-9bd2-d1a18bb38670@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529fbbc1-90fe-467b-9bd2-d1a18bb38670@intel.com>

On Mon, Aug 04, 2025 at 10:41:05AM -0700, Dave Hansen wrote:
> On 8/4/25 10:12, Breno Leitao wrote:
> ...
> > +- These errros are divided by are, which includes CPU, Memory, PCI, CXL and
> > +  others.
> 
> There's a double typo in there I think:
> 
> 	errros => errors
> and
> 	are,=>area,
> 
> > --- a/include/linux/vmcore_info.h
> > +++ b/include/linux/vmcore_info.h
> > @@ -77,4 +77,20 @@ extern u32 *vmcoreinfo_note;
> >  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> >  			  void *data, size_t data_len);
> >  void final_note(Elf_Word *buf);
> > +
> > +enum hwerr_error_type {
> > +	HWERR_RECOV_CPU,
> > +	HWERR_RECOV_MEMORY,
> > +	HWERR_RECOV_PCI,
> > +	HWERR_RECOV_CXL,
> > +	HWERR_RECOV_OTHERS,
> > +	HWERR_RECOV_MAX,
> > +};
> That enum needs to go into an abi header.

Agree. I came up with something like the change below. Is it the right
thing to mark the enum as stable ABI?

Thanks
--breno

diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..e71518caacdfc 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <uapi/linux/vmcore.h>

 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
@@ -77,4 +78,11 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
                          void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+#ifdef CONFIG_VMCORE_INFO
+void hwerr_log_error_type(enum hwerr_error_type src);
+#else
+static inline void hwerr_log_error_type(enum hwerr_error_type src) {};
+#endif
+
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 3e9da91866ffd..2ba89fafa518a 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -15,4 +15,13 @@ struct vmcoredd_header {
        __u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
 };

+enum hwerr_error_type {
+       HWERR_RECOV_CPU,
+       HWERR_RECOV_MEMORY,
+       HWERR_RECOV_PCI,
+       HWERR_RECOV_CXL,
+       HWERR_RECOV_OTHERS,
+       HWERR_RECOV_MAX,
+};
+
 #endif /* _UAPI_VMCORE_H */

