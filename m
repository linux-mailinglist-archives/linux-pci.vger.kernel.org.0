Return-Path: <linux-pci+bounces-22642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C328AA4997F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 13:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C231B173413
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46926B0A1;
	Fri, 28 Feb 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jCSe15VE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39826B086
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746279; cv=none; b=WG4I1So7EcCOF2Zb8oeT6Gjncu339PO6C2cq4XL5VAhvCBbHstIXl+jBZnjnmOrxOsJXtI4QlM2NM3KXE9dgXJbIu/jTP2r70jmfbWe+tSXE483Z48VJY+TWE7LP3DZIJNs6L/W2qYnMgGx9inLNTEmQtvrT5V1VhSGlfuEvPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746279; c=relaxed/simple;
	bh=ZovQPRZql6TndyyqkCCimphTD1Q1x0s3eMlmjBD41KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag5IwQbH279NPMJFptov+fbDhXn8m+a8AuSxMpRWTBiGVyOV6Po2TKmtY6h/EeUNhs8u1wxTcU+5sKt1Fr9We4V/duuvqfKC2omLwEcS7V8S/jF3FyAcwfZer5Jyb0iV3BWj4TOjxx3Adq203lY0MlospSm8XMrRU5kyG7G4Pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jCSe15VE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso2668860a12.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740746276; x=1741351076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lUi7TDWm5DZEk1+vj+Gomi1jwfuwvI4mo++EyAzIHw=;
        b=jCSe15VEq6MpB2/5OEFWZEksT8aS05H5/FHZcLj+fBTS5ZhaPv3TT9cmqzfyOo6U9L
         zeTw9iB03daeev5OHvYVQA10ZUhqidDCIJ5O6sa4+iD6QpKVehEbKKv7zAsEhV5/JQFj
         DtIcCVy9lBWW/+hLKPz2ZrO3gNyfZ8EhdUMZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746276; x=1741351076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lUi7TDWm5DZEk1+vj+Gomi1jwfuwvI4mo++EyAzIHw=;
        b=dnbalg+HOtBwAh7q4MSr3wFZ3o/UpcJ7UtPAISoP+E5O567/APpsGwRCKZ6dc0M2bs
         XMtShJJyrwn1j+oYWabCoqDtkvVngCEIc+Pmo9qTRbLrxF5v55XBGDu9tl4ahWmXu/li
         tQbfFoACEMGMI6lnB8iCGFXoqx5x2UI+a77jsReAkHiAcZ7ypHsIQJ4V3yuRUvSJjotz
         HolV4SGQfM2mS5W8+WBtBBGlDINKBnaoFmtce0yA5cxfplPhgNzZJMqjIuFJCqyJMaGy
         S5Vm5dpDSDZSY0B1X9cK3AgOizz/t/4q17m6N7Kfr5OL8CedB8mZffWfl6m4BSSPJ9IC
         MWUw==
X-Forwarded-Encrypted: i=1; AJvYcCXjybfcuCyI4Bh3aQvnwhHHNYwPn7YTWZVMkjUzAxRpl3vNDP6mnWa1xs19DYb0aShqR8deluo+eYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkydnP27ykKpG03fohJtoQ+i4GTFrg0qH4NQCppMLwRhehVJvu
	4GpQdbSdnDPrEKokxzzxGiUxaGn3xIvGgBRNQy+5CUSvNrHVoOOaSIPRVQUuq0/9phIs9HyVHPM
	M
X-Gm-Gg: ASbGnctKWnQdTYd2msaKFGlDiYSsNnYnN64epn4+Pa6MaQuGbab3FqCgthlEK0lEkta
	ld0VE4hcirrmVCoGY0upXdIZT2vOqlj7xqBdft2wj5JIwCzGFLXJNKAdQxZ6SDwRsSmL34q3ekl
	On+VaMpC4kEH2QahRfAn98dOir+EfnxvNtrJ0i8UxXt4FsqVYOFFOBshhTawTxkPdfER2mUOvEG
	5hfn8Jip7FCBo6Z9RG/9NRPpNHUP22+m9HGPepKVzoj887VfAQFnYkPhVfF+vDsyTf6w9tq+ErQ
	Mht0HVC10wz/vjyXp7CiYVhukD8zfzs=
X-Google-Smtp-Source: AGHT+IFXqFX+dmK6Tf53q9lL5WTgrMJLcEbkciCEYtLtRd65bqdRe2AXfvwUSIAwNgfqJo2GPKXk9Q==
X-Received: by 2002:a05:6402:268a:b0:5e4:a438:a50c with SMTP id 4fb4d7f45d1cf-5e4d6b69085mr2364147a12.20.1740746276267;
        Fri, 28 Feb 2025 04:37:56 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa13sm2419563a12.7.2025.02.28.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:37:55 -0800 (PST)
Date: Fri, 28 Feb 2025 13:37:54 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] xen: Add support for XenServer 6.1 platform device
Message-ID: <Z8GuItUuhbF1UZ9V@macbook.local>
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
 <20250227145016.25350-1-frediano.ziglio@cloud.com>
 <a14c6897-075c-4b2c-8906-75eb96d5c430@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a14c6897-075c-4b2c-8906-75eb96d5c430@citrix.com>

On Thu, Feb 27, 2025 at 03:41:54PM +0000, Andrew Cooper wrote:
> On 27/02/2025 2:50 pm, Frediano Ziglio wrote:
> > On XenServer on Windows machine a platform device with ID 2 instead of
> > 1 is used.
> >
> > This device is mainly identical to device 1 but due to some Windows
> > update behaviour it was decided to use a device with a different ID.
> >
> > This causes compatibility issues with Linux which expects, if Xen
> > is detected, to find a Xen platform device (5853:0001) otherwise code
> > will crash due to some missing initialization (specifically grant
> > tables). Specifically from dmesg
> >
> >     RIP: 0010:gnttab_expand+0x29/0x210
> >     Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89 fd
> >           41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49 02
> >           <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff ff
> >           44 39
> >     RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086

I think the back trace might be more helpful here rather than the raw
code?

Not sure if it helps, but there's a document in upstream Xen
repository that lists the IDs:

https://xenbits.xen.org/docs/unstable/man/xen-pci-device-reservations.7.html

It would be good to record the information you have gathered about the
different devices somewhere.  Maybe xen-pci-device-reservations would
be a good place to list the intended usage of those device IDs, as
right now it just lists the allocated ranges, but no information about
what's the purpose of each device.

> >     ...
> >
> > The device 2 is presented by Xapi adding device specification to
> > Qemu command line.
> >
> > Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
> 
> I'm split about this.  It's just papering over the bugs that exist
> elsewhere in the Xen initialisation code.
> 
> But, if we're going to take this approach, then 0xc000 needs adding too,
> which is the other device ID you might find when trying to boot Linux in
> a VM configured using a Windows template.

Won't adding 0xc000 cause issues?  As then the xenpci driver will bind
to two devices on the same system (either 0001 or 0002, and
additionally c000).  As it's my understanding that the device with ID
c000 will be present in conjunction with either a device with ID 0001
or 0002.

Thanks, Roger.

