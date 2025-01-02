Return-Path: <linux-pci+bounces-19177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B09FFE9E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E73A171E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC01B4153;
	Thu,  2 Jan 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu0AFRfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292E18FC89
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843122; cv=none; b=siueWn0XAjVWkAooVlbgdw5b1/IEgDtaX9r8t4Siyj1X8lpC8uuJ946N4zoytFMm/5k5hwF2r+YriX0xsd0UrG+iwfdX7I+Em6ieLa9kNSxGHdrUEdNXWxj7QPKFehmKMRaTzzr0gCmwl+NOFq+GohycAd3xD8euV3MqNcJJwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843122; c=relaxed/simple;
	bh=0zqlzsWDfKuygTxYYeINXmJlDOd9Qwxl5HLYWpdOS6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPIxCOaRl00SiL6bHs+45SFrU9QpakJ89X1QCU5lYGHv4JmbgpWt4mxa6UfK1WyTdr1BiU9SETrgm7MK6wLguCyEHujEeWQ8xtCPJ71A0TTSrgAyb+CMrIu8juLTsWbZA2ubPSG3eiwZTsX1ouMKJ7EpkQuwOSDZxrC8FQ2ws3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu0AFRfA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735843118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OD5aQ3XEGYN1xZMewWq+sHuf8pkwQMdrxxCJiuCySGI=;
	b=Pu0AFRfAW6Jva/hmMh90QKwxLUzd69WnrG7ozjLHplJfPAR6wfuqpk1YkNy1AyB630gZ/J
	/4tdPqs8l6J9F0xT7qrE9/9Twn0Z+vcHIO8hHXgKoJtMsU0RkDad9AZViPac7Dq5r/KGI7
	HDGObIMXpQgDoZWVvlRRFjwfoePkVmA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-oQ9J8di4M6KvJ0lOgM36yw-1; Thu, 02 Jan 2025 13:38:37 -0500
X-MC-Unique: oQ9J8di4M6KvJ0lOgM36yw-1
X-Mimecast-MFC-AGG-ID: oQ9J8di4M6KvJ0lOgM36yw
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71e570d4076so3120466a34.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 10:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735843116; x=1736447916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD5aQ3XEGYN1xZMewWq+sHuf8pkwQMdrxxCJiuCySGI=;
        b=ET3o+R71pp3/thldfsN0NJb9GhHgNN1sQO22ESLjCAuk3Gpgo66zw4oRFu6qz2M5hK
         EzQkIhIOqi+3oxVe5omZz5WmeeuR6IfOnl55OoWOIuj2DLN2VjVq1u5Qvfun8tLAPKME
         KWMyRU6B+JiuUyHnRhphMlIRTiz4Lyjw5CRkqCuvseNk6K8OKwMkZB8Oc9anhL7X5oy6
         xq2BO4jv71by6/mGqyS2mobIDGyR3VK1x54O+MtGHq4dF9uqMIOYZ2DCYPCc62mF5JF+
         QHUtjjXLsYYp1/uVrZ0dpYhuP5tyRyc5OI8oM9hAW5G08dPhhrXnk4Q7cTWfFtdzSeJt
         Ln+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeSqVWyA+c+KuM2yWZCeIofnRGijWbA85oE3DeHZ+wTQuPfWhVgEV8VfD3SMO902o4xBA53XMP2us=@vger.kernel.org
X-Gm-Message-State: AOJu0YySksZZuVvVJ0pqYWpZlX4/JNU5zi1vo+Sz0U3nMXwrrfXotMY+
	vTKfyqE8Tjn+6a84QrLFIWdjbj1Qc1NQxOOUm2rGd2ujpXTrImbajfrTvarV0WXGkgY0XYuGEi6
	UF0UkOpBrgeh1CaqvrB7d4z4zIHNeEwfUty9P5NGp80zNgtOkO3okA0y6Bg==
X-Gm-Gg: ASbGnct+YCTWvARldhAYrxFf5r5506OtCsYa5D/OQ8d3RindymdvPwEc4HQelHXczSc
	KWEmi12em7w5NmtllUp1u4B6nVbI9Qso8TijR4nTKudU+XT5p3dMIAZh3IyJjMBml9y0t3Leb5X
	bqXQbMq+y/v0C9yXrhULtDlSn+Pf0pB2oMFnuzUxT1oruCkbuU+lqcOiQ63cuLfHlQO9M2QpgR2
	oY3IXytBK3iC2aDLgNLtS8SsWLMRL2sl8ihFBcup44IVvHmBEABZFXmFtii
X-Received: by 2002:a4a:cb02:0:b0:5f2:b6ac:280d with SMTP id 006d021491bc7-5f62e643b13mr7039412eaf.0.1735843116543;
        Thu, 02 Jan 2025 10:38:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVDaXie8HBCSJH+P8ZzXC79A6opQUQfeLWQ3fdt9DAlI2AjF12plGBMJM6bxgHF/9XerH7zA==
X-Received: by 2002:a4a:cb02:0:b0:5f2:b6ac:280d with SMTP id 006d021491bc7-5f62e643b13mr7039403eaf.0.1735843116205;
        Thu, 02 Jan 2025 10:38:36 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db60d746sm7317340eaf.22.2025.01.02.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:38:35 -0800 (PST)
Date: Thu, 2 Jan 2025 11:38:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Precific <precification@posteo.de>, Athul Krishna
 <athul.krishna.kr@protonmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219619] New: vfio-pci: screen
 graphics artifacts after 6.12 kernel upgrade]
Message-ID: <20250102113832.4d5c101a.alex.williamson@redhat.com>
In-Reply-To: <20250102100402.33fa8435.alex.williamson@redhat.com>
References: <20241222223604.GA3735586@bhelgaas>
	<Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>
	<Z2mW2k8GfP7S0c5M@x1n>
	<16ea1922-c9ce-4d73-b9b6-8365ca3fcf32@posteo.de>
	<20241230182737.154cd33a.alex.williamson@redhat.com>
	<bba03a61-9504-40d0-9b2c-115b4f70e8ca@posteo.de>
	<20241231090733.5cc5504a.alex.williamson@redhat.com>
	<Z3bBOxFaCyizcxmx@x1n>
	<20250102100402.33fa8435.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 10:04:02 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 2 Jan 2025 11:39:23 -0500
> Peter Xu <peterx@redhat.com> wrote:
> > OTOH, a pure question here is whether we should check pfn+pgoff instead of
> > pgoff alone.  I have no idea how firmware would allocate BAR resources,
> > especially on start address alignments.  I assume that needs to be somehow
> > relevant to the max size of the bar, probably the start address should
> > always be aligned to that max bar size?  If so, there should have no
> > functional difference checking either pfn+pgoff or pgoff.  It could be a
> > matter of readability in that case, saying that the limitation is about pfn
> > (of pgtable) rather than directly relevant to the offset of the bar.  
> 
> Yes, I'm working on the proper patch now that we have a root cause and
> I'm changing this to test alignment of pfn+pgoff.  The PCI BARs
> themselves are required to have natural alignment, but the vma mapping
> the BAR could be at an offset from the base of the BAR, which is
> accounted for in our local vma_to_pfn() function.  So I agree that
> pfn+pgoff is the more complete fix, which I'll post soon, and hope that
> Precific can re-verify the fix.  Thanks,

The proposed fix is now posted here:

https://lore.kernel.org/all/20250102183416.1841878-1-alex.williamson@redhat.com

Please reply there with Tested-by and Reviewed-by as available.  Thanks,

Alex


