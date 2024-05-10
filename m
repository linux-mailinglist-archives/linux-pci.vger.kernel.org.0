Return-Path: <linux-pci+bounces-7365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584908C2817
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF7F28163D
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC317165E;
	Fri, 10 May 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3Fg7Cp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B806171658
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355865; cv=none; b=m7iLUC34zlQA3B39TGr3okXkAYwLnHuYusfphXNyu0KHubfFyjijb6t+EaKJAZCYScD9hbfV4pWYLoC2b/hk3H1+sXts+jKkxzqhEH/FZcR0KtIXYeq6GM41qDhRJG9h3bgEt5w9Wbb+JDejIm1zMoKeFKWS1rIJ83rzKe5mBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355865; c=relaxed/simple;
	bh=PSbCck90XzR29/LcPaIDYs4i+apiq99iORTmH6bbfXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRL85RLBqDL9M8UTCVIfkv6KJm8+qrdkCYc8YR7wCYFtfM5VZyArAfFWpHuEGZMrm5TWtcWl2seee6DHPUk5sr9z7ijSI6Uvpw6i/Fz1zx+DLFJm/QdyubNUU1dm0CszkgoyrtS3kg+AiZ1yzWlbdRFcuudJAb3BAFPkytt0LJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U3Fg7Cp3; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47f2f9f2ac8so729603137.2
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715355863; x=1715960663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWpeN9v4LQPHTvNkYUfPGosFaeM74t16OD1N/lIzMnI=;
        b=U3Fg7Cp3tizK/cFVxa1OK70Y9i4pbogfLzzi5/jbq6rzgj1kFe8AB86kfBpA9l8Ppb
         keBDwI/mxu+pzFSeegcmDKeMeQ9xsIPjZrJ2Rs9U28lwCBwRmmkwjXdJofDzKqXZB96G
         UCICInTzwHvA8Gb55meNU+5E2cdtBoioIup1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355863; x=1715960663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWpeN9v4LQPHTvNkYUfPGosFaeM74t16OD1N/lIzMnI=;
        b=Vb4DfdjeN435ZIZDRJapM3RtOvVYY8wvE7QStZEZtiwG5mgHFgzHxwryQlIk9+6vSO
         daffDCLwa/T2mUUmiLLFeta2++DqAuNFHR+dqUu8X/eIHvrUobOwQcGA1blQwlrNR4tO
         Gu/ltIy8C8u4PcxwtjIYlR4tak0RS4I32bY/5LLrSzlhUByuJnKSl89Y3bPZoO088lVA
         UiEq6fZHCvm1MIxI5W5Z2uFfuQXMo7RQy0xA1GyNWEHZUjkfwL9fB3dZTVcHSf9yK0DU
         W2PRM7kYwZEq18bHULSKSwBesWpI73YKCqaep/rQwYjP6sAoDczBtlGEEiVa4mmgM6/x
         dOyA==
X-Forwarded-Encrypted: i=1; AJvYcCXUkim9eICPQKh1JwxHRbNqjgZgBO9+jvvrVnuL0OIhVXXCVasHp0QtwVqr7vKe6+r1DwA2frAGIFR4b253yZUIutmDktKs9bTT
X-Gm-Message-State: AOJu0YzvkcHztLutr3ZhI2cecw4vhvfujTVHRfNtWa3PDPZUdMTWKjLK
	qheDMxAD/O21l06OL1pe0IkLUM3AFKlOg45hbBWHVjQXr9YgocW9gX2w3D0U7bocmVRvXWENLSn
	eJMpc1qtcHZhVIIkSaDVFAD8fwbloQBA1INJh
X-Google-Smtp-Source: AGHT+IHIRkQDh6WbpwsnpPK0f2E4zk9nbL9fTthvlONSIHmEejGLzQVUv1amXe+iXYRJDNvBaOujXUQa+qBW0+AVN0o=
X-Received: by 2002:a05:6102:1610:b0:47f:1ad0:2b12 with SMTP id
 ada2fe7eead31-48077e4426emr3624858137.22.1715355863240; Fri, 10 May 2024
 08:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419044945.GR112498@black.fi.intel.com> <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com> <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com> <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de> <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
In-Reply-To: <20240510052616.GC4162345@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 10 May 2024 11:44:12 -0400
Message-ID: <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Thank you Lukas and Mika!
This is very useful and helpful!
I am setting up two alternative builds with both of your suggested
approaches and will test on devices once I get back into the office,
hopefully around next week.

> +       /*
> +        * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +        * before Alder Lake do not have the above device property so we
> +        * use their PCI IDs instead. All these are tunneled. This list
> +        * is not expected to grow.
> +        */
> +       if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +               switch (pdev->device) {
> +               /* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +               case 0x8a1d:
> +               case 0x8a1f:
> +               case 0x8a21:
> +               case 0x8a23:
> +               /* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +               case 0x9a23:
> +               case 0x9a25:
> +               case 0x9a27:
> +               case 0x9a29:
> +               /* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +               case 0x9a2b:
> +               case 0x9a2d:
> +               case 0x9a2f:
> +               case 0x9a31:
> +                       return true;
> +               }
> +       }
> +

Something I noticed is that the list of root ports you have there does
not include [8086:02b4] or [8086:9db4], the  Comet Lake and
Whiskey/Cannon Point root ports that I saw on the laptops I tested on.
Those laptops do not have the usb4-host-interface property. This makes
me think that the patch won't work as is.

Then I queried for up all the root ports on all of our devices that
are confirmed to be affected by this bug. Here they are as a
reference:
Cannon Point (6 devices in our lab with different combos of these root ports)
9db8 #1
9dbc #5
9dbe: #7
9dbf #8
9db0 #9
9db4 #13

Comet Lake (7 devices in our lab with different combos of these root ports)
02b8 #1
02bc #5
02b0 #9
06b0 #9 (one device had this variation of #9)
02b4 #13

Tiger Lake (1 device in our lab)
a0bf #8 (the root port's device id is different from all the ones on your list)

After first trying your fix as-is, I can vary the list to add all
these root port devices to see if that has an effect. It seems like
this list might have to be longer than it currently is though.

