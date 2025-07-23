Return-Path: <linux-pci+bounces-32825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAA8B0F72C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3F07AF05F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A448B213E74;
	Wed, 23 Jul 2025 15:37:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A720D50B;
	Wed, 23 Jul 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285020; cv=none; b=pFUT0JUamqa1K7fMaQeWXh8L9wpXqE93XtunKn2bmzmOCSfwKevB1jSct1dW1hsEJJDe8VV7lQ8GeUeVM97pNS9iG4yzm+SJzOU940CLtME8F7KVbBdbBmrYXCKGzbpmllekKWkiFPXZI56qSMpbi2JU4q+KpQgCBTuuqicEBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285020; c=relaxed/simple;
	bh=+ER8pn1/f3NYVV2anIhl2ZioKi8MBMvlAz4WwMCtweQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWMtNVJGNRRJFYW5U66XXhmNimSWJE+WPewaL5v1ZHfndRwBLeEIc/e0Ri8D5+1bzy5NMCyFTrMzwYXzDvvhnChlPBBN/1NCBtzu0lSJa8PHso/aflEEZpkXMMDGdTNh6+ov8ECc4+hsTY7LAhmotE7Uy17meaQ8cTBdfaS1/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aec46b50f33so1174531766b.3;
        Wed, 23 Jul 2025 08:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753285017; x=1753889817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxQ3M1WeHEo+nA3pDBj1z9ZXTmnmq5hk8Qm0uzS3eUY=;
        b=Ozrnwa1vkp0LKJjKq6pve2eIvGiF5teWbKwL3WmdDGyCQTDj98BgrBmQSn8xs00nx8
         bbc926ifOFvvW8SRFVDnRrXSeRU3f2iE08zCL+1Iju52rVFA6B2ej3EHatuo0IBUyg32
         nAr3tcWqXnow5zjLt64IYpEBrC2oQ3TkAOCfNntJdKwEJw7iA+91hVKrC0LKsJvNT+lS
         1B9q6ZYpjqOCa7A7IXEySmPVr6ad2SHy7jmE/5OIkStRuZ4F3ZjQKFFP4d7uGIgrsvqS
         mE6FhIXjU5Obqd0xBNic104aPoPaak4e2R0dqR3CZItaAtlNMTPrkGQJQBaT5A5lCNiW
         IlLg==
X-Forwarded-Encrypted: i=1; AJvYcCVCfJ+4SS3V/hGkwYGjbJgwz275E49fUIdEJY0hsvoxW+c7Weu3EZhxxtls/L9NIrpFZtH91N7WLyT0zcYf@vger.kernel.org, AJvYcCVRx7Uae9JKCX55HTXHvK64+PatjzOumE+/bO50UrrCLvMM6/kaelhc9+neX1C1VD/qP1NmQUi5GSK/SQ==@vger.kernel.org, AJvYcCVqnojmmdbte0DiIoRn940RmIozt/hbUzJbKkeA88wJDyjkFuzHaybYVnPKXvHY4It6shBtiZ5poFkS@vger.kernel.org, AJvYcCWFLMf41UFnYzMGmxyXfWQZ6/ybQIcFL2MDOQZwVooY1NzxAZRwnuetidnkc9OEKRD9NKKaF1iVVUV8SSM=@vger.kernel.org, AJvYcCXEH5mUFUpmPQDMm1g70PF7C2g/WJtWT0ppDyVT0NA/qfqEc1+XgoisLuXViLBsLvbSb1VSuBXj4/UA@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBBiAfQfRQtFgTUPWiPyeTkY+CrEXlhUG0tVHWNyTXNUJy9I2
	UnPLJTAtKNeXNLvQSvEU6XjIX735NnKlWVdUDOmX056hw7QKQkJaKg7gI4pxx9XD
X-Gm-Gg: ASbGncuqKcZ/HbXI3r2GnKrwzCh1XMW33L1kf8RTHHdIbjS76OoGGXLr2eXHY54El1k
	GQ3tZPzkDLgYtkUFoqERJTrnx++aH4o3nXoVtEM6JaAPQmQjxjmq+DTYNFBZYXCah3wbbjqjhME
	9LF/91FJ307v6mCutxApjEhrfyE/04MlKirAxnI2Aqh/PNnzgIi3iUFDE0b4P7BZ1v6CEOB5Wz0
	yUzGJqvHnImuBEF1+9IAS2b3hzt+D7a050PoXq2Gru5ACnt4NZTwvbHGQeS2vMABYIXeeBI11pm
	5J7q6LWm9CXzS8DH4BG39gqxiSihEgqvmhZsJnRlrYN7mctBZX5Q1pPaCSysAieqgizUaOz9P4E
	68J1Zb8JWcwDOag==
X-Google-Smtp-Source: AGHT+IETRaOgydL5D9alhTF8zO82hzgDecgDyn/Edc5pZ0K0bOUQXLbkxv/O/N+5sE2Ilhir+6nemA==
X-Received: by 2002:a17:907:74a:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-af2f6c0c6a1mr324567566b.22.1753285016210;
        Wed, 23 Jul 2025 08:36:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7bc99sm1068454266b.109.2025.07.23.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:36:55 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:36:52 -0700
From: Breno Leitao <leitao@debian.org>
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <cdlrppnrheyq7z3gmwmwsmktpmoiwq7g5hxa67rcx4iem5i6ge@jksa5o5use4w>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <202507232209.GrgpSr47-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507232209.GrgpSr47-lkp@intel.com>

On Wed, Jul 23, 2025 at 10:28:29PM +0800, kernel test robot wrote:
> Hi Breno,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 97987520025658f30bb787a99ffbd9bbff9ffc9d]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/vmcoreinfo-Track-and-log-recoverable-hardware-errors/20250723-005950
> base:   97987520025658f30bb787a99ffbd9bbff9ffc9d
> patch link:    https://lore.kernel.org/r/20250722-vmcore_hw_error-v3-1-ff0683fc1f17%40debian.org
> patch subject: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
> config: x86_64-buildonly-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250723/202507232209.GrgpSr47-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507232209.GrgpSr47-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507232209.GrgpSr47-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: do_machine_check+0x5cc: call to hwerr_log_error_type() leaves .noinstr.text section

Oh, it seems a real issue.

Basically there are two approaches, from what I understand:

	1) mark do_machine_check() as noinstr

	2) Move hwerr_log_error_type() earlier inside the
	instrumentation_begin() area.

Probably option 1 might be more flexible, given that
hwerr_log_error_type() doesn't seem a function that anyone wants to
instrument?!

