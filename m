Return-Path: <linux-pci+bounces-23105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA1A56654
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A511889E88
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC335215197;
	Fri,  7 Mar 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ae6YAPrM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C22153EB
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345819; cv=none; b=dm9BcJqfmKUTGxHPt9lWHbGfVs1zz8V+3bbQ88gM4GEm27l3ntEYFnD0LdnAieQN4qiEO8CIZwMFZOac9+4KEcRLpHI72aPKM1whO2Ju3OSCU1VIgfCExrNLFNx5Z+irjM3YbNxShHf9rEPaQOEqJTWocSmBQd0HhDJ8NrV5QN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345819; c=relaxed/simple;
	bh=d2MEh8Jh+sJWWjRLdg59jw1bgJmx86hWzBeVKjd2YO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrdPtrY4ZGh8lHtG7COhvPFss39l++NF5EerAmcRTnc+2pf+/ARAM40oScCkW9P73xgbjlEAWWtk4Uf9O1h+m9Ju5agI3OmAqPjNE7Q2Hi69DMiwAmR+9iadqDCMmVEbg2lVVYkle+j8R9XdeK9rK/ibb8qaU0Iip81VfPPvAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ae6YAPrM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-474ef1149f3so27760521cf.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741345816; x=1741950616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHr1KpFfXSqL1PqPZUG6V8Apd+kiN02j12xcU8Owebg=;
        b=Ae6YAPrMuLi9LWpsJIZ/rqWZs7loy/L0K5NsIfu9n/mqEW+FTX0u1qYkNzz1/x0dWp
         iOtpVNyhR2R0iG7s5JOV0MOAdy6A1wztvTAGOXd5diAmlOjkr0OjCEqwhZyGpv06yhDT
         rtKj2iaV9fVDaRLpme7WaEBkOVKas1YVN/A9n0D8aQ59FgzG32JH/YZFcdaq/6mLekwE
         c6PO3kxHPKsBP+QGCJRBe5IhOWUGxyTuyrTEpEiY8YerRdVAQymRMrKtJoYYUlMtYUA9
         F/qQpZ750M8gHhTREwjhZxjq48UFrA0BCWXRLNNl4nnQO/DXtIRVMqCOa3bMm/AsnACR
         ZXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345816; x=1741950616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHr1KpFfXSqL1PqPZUG6V8Apd+kiN02j12xcU8Owebg=;
        b=XOje/xqLAjk6n7NmcprmifjbNteZlZZgxXA6oj5CZt3JCjbKJZ0NtOkRcAzwgEyCoX
         qHXHyo/O933zwC37n/ZrrHcU70E12MR1fsjEw3K8lK3DAFaHk0ozp7K7ZSrpsnDNo/OH
         XU8zu+eR+agxtKijxuNJGeDX/G+vB2kODax56TrQ1EbLNMnFe9arHDBJae5TJ2U+uinV
         6NxJlDWoBV5ZQ4Jz8vjcPS0zOyLWqwE250I8wrL9x/+D3wT1er/GquT49IBH5MSvtCQV
         lyWq7/eN9mnHE0baMWnSjtCYQEKQUincSwE46LKM80jdw0dbhgxbKvjTNrFuqa1rWY6C
         ZdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJfQnXhg52GMKvAs6RI6vid937iKlNsINks0FGVwl01n0eLt0p0GClMXmqFOXniVxjeJdmnKG+PmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSqKr4oK+xNt2wNTVYamcD8H2ihpKjrTGkRahgrFBgH2b72fP
	hN0hJDk1rN+tNAUFftHqKn8Wno89W+cY6ASGFzbfhmW3Kmd3/RSx5EgovhHgAqz7Ld1yp09IrnB
	4JUxJJ/OFjdeV8NOn+zVJOqELW3GQDOGhZ5lI
X-Gm-Gg: ASbGncurCnT+lzPiYefEOkxL1fIPHrcT5wFPiLU2x/GK/+/tB+cy30I26e03yIzfZDJ
	99z/0dD59t2VyLY7UUjfycZDo1/9zVbpc7+O46qeQLjbFwm2YFNqhWqeV1VVBpjHhspx8LE2Yug
	5oPBnwbVhiszmm/DJQhr7YkcZVrbU=
X-Google-Smtp-Source: AGHT+IEgpufSVIYWu9ptMZXcZ8RbC4eH1yONPubegQqu44X+/PPJVNW/1MU7iUfIx9f047aEMSRmO+Ra2Ggfj6OcU3s=
X-Received: by 2002:ac8:5ace:0:b0:471:f508:98fd with SMTP id
 d75a77b69052e-475bb7c0efemr48644151cf.5.1741345815892; Fri, 07 Mar 2025
 03:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx> <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx> <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx>
In-Reply-To: <878qpi61sk.ffs@tglx>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Fri, 7 Mar 2025 19:10:03 +0800
X-Gm-Features: AQ5f1JpOkTTuJQzIWIldXpRegpU_ts_0H10GrZ23kADPDj9XxDJy8OmywIFM4zA
Message-ID: <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant <achant@google.com>, 
	Brian Norris <briannorris@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Mark Cheng <markcheng@google.com>, Ben Cheng <bccheng@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for your detailed explanation and feedback, I am a bit confused about the
#4 you mentioned here ->

>     4) Affinity of the demultiplex interrupt

Are you saying there is a chance to queue this demultiplexing IRQ event
to the current running CPU ?
would it fall into the first if clause ?

>       if (desc->target_cpu == smp_processor_id()) {
>            handle_irq_desc(desc);

And that's really an approach worth to try, I will work on it.

Thanks

