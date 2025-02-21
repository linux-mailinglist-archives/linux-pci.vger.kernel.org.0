Return-Path: <linux-pci+bounces-21947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A66A3E9D4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572C13B146A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7044207F;
	Fri, 21 Feb 2025 01:21:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2638F9C;
	Fri, 21 Feb 2025 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100866; cv=none; b=B3Vv2EZjYyIgvTeug8Hec4JKen2JbtqFYaTwu99X5VT0PKHFU7dxfb36emI/yf/q8gFowsrZGb7snbxlCvg8WOKF74wZud41fAwjd0/sTUDSxxQ5UBsUbuzccb2tg+aTlGCfpIEgBHpi5QuZGrgdiF2W90ZkU9FvZsgw4xpXB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100866; c=relaxed/simple;
	bh=uMU4QkBj5T3NZfNtddNFb9YdKAxvOZuYbcleTZQsDIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhYRPAUUYwd1wgDV6BgEFZsoNMv+/Ng71INRyYjOe5egC2vK8MochntXajZrul1wiooY1RPSWGwS+Pgnja/nO/L2USzH1sgqc8aegmDlwOTTV3wFP9kkIThdz0iRkbrzOL9Mitt0m9JS6cDpGU9aH8zrfAOxxS3emZ7GPNwnBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so3234248a91.1;
        Thu, 20 Feb 2025 17:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100864; x=1740705664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5omKhRHXJSFMXsGqutjW+6ZFtB5jxt0r9R70Rd8TBI=;
        b=trOOTG254ZrtbL408Gwl6ws3XQN+rziHeuBNlxmdaPJ+SXzgQx47tlYsUMAaIelGAD
         Y9kGGH8uFEq4wXjTIgTqalPIzOJGd542dXA1e3BEPhU193Tl0C6XfqDrfiEePI8Y/DsJ
         +WdS9ayTBhRAv1eaqcN1LI5mkVKmi/PbumpYl82JfoRhKoXrwWQ+05mOB3cMHKW/hFE9
         7KNVE7TYoW+jJ8XCDRM90RQ+KyvksfeCpw7bNwZJvbZC/drbgABdU9LLVUxHrDGutwFc
         /n/crdamLgb+xNbCtkTR0O3K26Gk1SmkE4RDMOm+uACLp+H+Bl8832Ty7N8gYXESGGB/
         hJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUySFJ24S46Gr7LAZQg/5NXJi1ZFGwl4B19cZFKUap1d/VZMexsKeLh1h3h1xm26D6atnJZKB2FAd9v@vger.kernel.org, AJvYcCXdtQ54asvAJYGrBLB0qOj44adwrDVDfJeXyvdz6FbSDn4aacPtVJxIjOhAV3vdcOYVtxX4hIbdEULiUXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTUs6vC8DadpfTa221qrH7JmSx477d1eH4IV3ogH52VltPm5n
	aKV8qaji4qZMAbgZu4c/yGi+4XUBoPgomw1uyJOwYKa9vJJQlCHe
X-Gm-Gg: ASbGncsUEaFqlrm4ZU/Puk7b2WTRPWTGATRNqkPc+KA9ZtaG1ZVxxrWn6ZTk7yRw14+
	LDiCp58xfi1jfgqBf2UF81AVcTNv+7tojatMsP/5lQluhRQ5uLNgfNTXY7c7hsUPETYGEwUNKGM
	xv61Jlh4/BJd+iDQzzSIwPw8hYEMX0/DJjiIJYpysAHCWjDlQOHrvlCf13OBg+dFDUR0aFWyDTZ
	ELGvivtIKh+VgTL62X4IpHqwmBPShss5kRDlGyEStgVxNxMmMNEuQ36qskrDD8hYXObC2NhC2Cs
	ogYLJmarc0yg1xTxkjZ8JZyvvG8UgDWv0xn0affzQEuOU2BAUg==
X-Google-Smtp-Source: AGHT+IE4oqaFxXOMl1MCiZwVIYCYZ5jRriXYcCkDbDq02yKTmRusal0IGsWIpAzfFBX0vyGtx/8pgw==
X-Received: by 2002:a17:90b:1806:b0:2fa:ba3:5451 with SMTP id 98e67ed59e1d1-2fce87468f3mr1530851a91.35.1740100864281;
        Thu, 20 Feb 2025 17:21:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-addfbb144b1sm10017635a12.15.2025.02.20.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:21:03 -0800 (PST)
Date: Fri, 21 Feb 2025 10:21:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: helgaas@kernel.org, bhelgaas@google.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Update Resizable BAR Capability Register fields
Message-ID: <20250221012101.GF2510987@rocinante>
References: <20250219183424.GA226683@bhelgaas>
 <20250220012546.318577-1-daizhiyuan@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220012546.318577-1-daizhiyuan@phytium.com.cn>

Hello,

> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
> to read the additional Capability bits from the Control register.
> 
> If 8EB support is required, callers will need to be updated to handle u64 instead of u32.
> For now, support is limited to 128TB, and support for sizes greater than 128TB can be
> deferred to a later time.

I think this would be a v4?

If the reviews still stand, then we can correct the subject line while
applying the patch.  No need to send another e-mail.

	Krzysztof

