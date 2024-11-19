Return-Path: <linux-pci+bounces-17076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74079D2800
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51E4B2855A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675571C728E;
	Tue, 19 Nov 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTUk0neu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FB1CB9EE
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025824; cv=none; b=GxpwU5lsj2WHObMcwlIE47gKtCMtGN9w8LBmJLXMDP86UWHiWWpXV1HQOyZIQY1bhOit08Gi4vFhXbTWlwzFIy79A+WW8dSL45UeGD9n/0QSxcnrHbwYjZumxZs6sd6ywEMCOKAazLjUyIo/Xwd13uRlwJnzufMIV8ZkZUYSUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025824; c=relaxed/simple;
	bh=RmPAo7QS3UiDMbJ53pgtG/w7wwCDnoMhswxkA1FqMVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sklWe+Ma0Y+FLLs1obuTSGHn9aYD1a5UVYzW2BtdFf9A9IFdcu3r+oKUIRR0Bg/jh8qXXsPq26hoVxyONgkZpRY3afnh1p5g5bwJh7rqPPprliWnoegj5hqIL04664iRCmVLwr0nrovYYYV2FoT8wTDpbRC6HTeVau8HzTSfauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oTUk0neu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ee79e82361so22997157b3.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 06:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732025821; x=1732630621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XKMqAgYEzbNDIRrzggNA5eRe3/NvZL5fXf1Td+mwuE=;
        b=oTUk0neuqWoT2IdQb5ryFsZyA6IDd4bmaQnwaB6OrDSwAJX9s9eXUGXO95K7pT/Deg
         XNfl1sdX3QIvMpALoEibUoqA+dEc3szEN2IjP7lTRFRAScbIz0J+3L7NVv+MJaIUKxeu
         R3C1Ujgm1tNJlXk4ujWZLXAAQ2e3gRJNTbF4Y/g5/0agz5u7cOCujvuUg2D24drjPHya
         g3Bs65BJBtxHm9eJ59BxC/ebO2S4Uc/mhv93y40wvKAQEdP1yTwU74fohN1ZdCTFYYSv
         slpqHWOLZU93q91lvaaEsZgOglj1b9tnl0kveGaKPdE0pZ37MTseBCi4fvJ4gXzO704I
         XYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732025821; x=1732630621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XKMqAgYEzbNDIRrzggNA5eRe3/NvZL5fXf1Td+mwuE=;
        b=vctOhTQfWKpqxPSUrRPwnlxm8+M1rG8Z3VKSRw2WM0RGLGAScwFWLsvtECbjl8ag66
         Lha9iLVS8eyNbH4v2j0Bdl4mMNg5WP0uGKjE7Eo7gg5fP1t2M502TfaH+QhX+zcp3a75
         ohGofdBOtK783+Q0WKPpJJwkMSM6i1GrfGzrehGvnzWiBShlezyLeNEFxi/rbgE57A4V
         wEgbvbsO5ohqKUqIARC1FKoOJNab5/wulgn0+qq0pn3dMIxDY/tBwRLfJ5sDFW/jXLDx
         OojEdmrVZhuwAedtVSEvMpX4ar7GC7kJ9Lqi2gMb0pEe4Sbj+PMshU2VXDTyTO5Pi5la
         4KGA==
X-Forwarded-Encrypted: i=1; AJvYcCXg18hJIiamsMN57NZaCTjWsr/AxbcTF70EplqrqQ+Uv68a/22Dsnn91zILjxX8fwokbumxi5R/HFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gvc5GfPwsw0nxLDGL1hg5vAIl007gXG8FPb5dZaYQy9pqk/X
	D+LKodvbQAcA9zMrvDXh+3mNyh6zOL4ZxJVvpZSYBQ8+/Xsl3/gA94rxqJCPywamVyCI7iQul2G
	pSERDWY01PqmpYDwCmBAKt6ok09eUBf1KLHYd3Q==
X-Google-Smtp-Source: AGHT+IFZFJZFRUUYER5LxqrA496CMZ+3nijoCo4bedrZR+e4ALBvS9IERwylFma5hU8/uazbzE9OGRMn11uiQs65omk=
X-Received: by 2002:a05:690c:38d:b0:6e5:adf8:b0a8 with SMTP id
 00721157ae682-6eeaa350a03mr25669917b3.6.1732025821556; Tue, 19 Nov 2024
 06:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-219513-41252@https.bugzilla.kernel.org/> <20241119140434.GA2260828@bhelgaas>
In-Reply-To: <20241119140434.GA2260828@bhelgaas>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 19 Nov 2024 15:16:50 +0100
Message-ID: <CACMJSesxsADzGQyzi13QDGh-VwEO+mgyyGmSNEyyBiL6QRAWZw@mail.gmail.com>
Subject: Re: [Bug 219513] New: PCIe drivers do not bind
To: dullfire@yahoo.com
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 15:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Nov 19, 2024 at 12:55:36PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219513
> >
> >           Hardware: Sparc64
> >           Priority: P3
> >           Reporter: dullfire@yahoo.com
> >         Regression: No
> >
> > Created attachment 307241
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=307241&action=edit
> > debug info (some shell commands to check the PCIe devices and drivers)
> >
> > In linux-next (next-20241118), since
> > commit 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed
> > before the PCI client drivers")
> > PCIe drivers no longer bind (at least on the tested SPARCv9 system).
> >
> > It appears a "supplier" devlink is created, however it is are dormant. see
> > attached "bug-info.txt"
>
> Thanks for the report.  It sounds like you bisected this to
> 03cfe0e05650?  Can you attach a complete dmesg log to the bugzilla?
>
> This commit is queued for v6.13, and the merge window is now open, so
> if it's a regression, we need to resolve it or drop it ASAP.

Dullfire: is the DTS for this platform publicly available? If not, can
you at least post the PCI host controller and all its children nodes
here?

Bart

