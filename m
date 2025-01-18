Return-Path: <linux-pci+bounces-20093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE3A15AFC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 02:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DC7188C164
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C319BBA;
	Sat, 18 Jan 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIQ8+8Q2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD4757F3
	for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165587; cv=none; b=HdrAEs5ULNdl/hDHI+OC+JE/nNGz3aPGNwZRzrrBaMenvkLwyuVEAaxjZ91zpdSfBXeT/H/939UwhxeJkebI4K2ClNGZ22a9sDUP+HEq8K5fq4vIk+1Gi0/NFONUbsLUEJiIqFum6HlUqd0ew5a0tmWlQCnm9yINiVb1tTRuYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165587; c=relaxed/simple;
	bh=dd88W5zHOkUoM3OtDaS2ZZ8joJEJiqf6rdCPp7n1vmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiqRK8UjPQWIr2XL7o9DQWW5OjMrShZ2AlwnYwii9Y0xciWzqLDH4yc5PZuvegk98XZX8XEH8Cu6VyIgQgVf/IaDU747yxZEjHid70rtWkjL/ue4gAQjkhn+kO0VjeiBGHVtsBWaAO3kXwUQVdyv/U/AUWPdIp5hHfokJloa+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIQ8+8Q2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaef00ab172so415947566b.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 17:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737165584; x=1737770384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUD8gJGPWjBWuj5IOlWmIA1jOVTPVbfIN5Ktr4rJ0Lc=;
        b=dIQ8+8Q2CxP2yEq5eThGVu4wrdkPbEs3b1gLXdBRf3ilWSTTssow5g87fk7y6mb51s
         NAiW9jIH4LqBfgXjRAifc/Gwo6muMWn4/BxvoVyBzAjNp9HOa+9CFE+58xED+rZqKQuk
         nJX2YE2QnWU7d47A5j/hElQW5gnTQxQ2IEhUjdm5LkDZX1lxmvh+ZqLho+tI8BVeQy4o
         Z5Lj4tIQH//+7wb3jfIEdEQrRBVBk/SbrwoYBgYWNrl79LRI3dgXGlJbeeZ9XKl73fcE
         zcSAZyAcP+v1zigS7Ap1F56yFlvi00UOHeQHnoDiLLYpfuIqiaFxZPIVSbkql/b5nHbo
         wO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165584; x=1737770384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUD8gJGPWjBWuj5IOlWmIA1jOVTPVbfIN5Ktr4rJ0Lc=;
        b=MBis+YrzuYyn33keFVlnq4v66nT6mQXj+7qxiM4716qWq6jPDjH87E6r/kq0Zi6T8z
         tuX3wv9taRQBrsgIdYQon9j69H+SxXP+weySGVg2QVmgrU+2cZqQ5/obH7YFnU9tOv3S
         kbGyi25QLxmPPp1tnshQUqm9Zc37AtfYvT5lZso1DMUrfjcsugl6TDxQhefXYFDHJJyJ
         Sq/0QtsdXL0D5AkvU71gS4KZ1O/HmCqspmnXyD+LzIFnJ4REtG8M6o8lNTHEFKxcVEQj
         IUgg/16tbAzbGCsuq8Y/HuXo91W3RpGR1pH+JVSA9kS7nu44wFTcM3IpiqIRCcYu0w6q
         PAaw==
X-Gm-Message-State: AOJu0YzVaHPBJ/EQQ5qF01FRiB6gpb16LUHfU2qXeyHpnpvvY+tgfGAU
	Ig8I81ps9R3vWL5Pwrn8RDqd3zfK0j0H0/jvNlYtp+6rlQpRJ08vOHdbPlrnA+CSCRd/DkHOMH6
	yYINqh08pazNyEKRX41E2q8RLQL20bQjsKrYY
X-Gm-Gg: ASbGnctM/Jhkiw6Dn+56LHoP/Vz0W8Q+nhJRdXwFOJRXjpDgfXoYq2SNRAziWiQsRy4
	VMO6OeOiIZ0KPEAkNQa5CIDxv9fCfpbU0OXc1yp5FqJk/BhAoV4InjNq4NT2+F9+WQY+UYYF1+v
	/j4siArA==
X-Google-Smtp-Source: AGHT+IEYu2doSbygphhSxkxeszU1svCHjup8aa1swjIu/56w/PUA050EVThXKNjUHqQXanHM76I/8ocqra1I8BVpXEU=
X-Received: by 2002:a50:d6ce:0:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5db7db07819mr8678870a12.20.1737165584121; Fri, 17 Jan 2025
 17:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-4-pandoh@google.com>
 <b04d2fc4-6b64-4d44-9af1-31e05918e196@oracle.com>
In-Reply-To: <b04d2fc4-6b64-4d44-9af1-31e05918e196@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 17 Jan 2025 17:59:33 -0800
X-Gm-Features: AbW1kva-ljnUZsPe3lJdwUGIvJDK7bCJKNHuiGoklPaAFTBNOT1DKN-XJmjrmNE
Message-ID: <CAMC_AXUKSSYjRr39E-DehvpfH=b2eYksVwPVZ9BXSNMSU5bUrw@mail.gmail.com>
Subject: Re: [PATCH 3/8] PCI/AER: Rename struct aer_stats to aer_info
To: Karolina Stolarek <karolina.stolarek@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:12=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> On 15/01/2025 08:42, Jon Pan-Doh wrote:
> > Update name to reflect the broader definition of structs/variables that
> > are stored (e.g. ratelimits).
>
> I understand the intention behind this change, but I'm not fully
> convinced if we should mix AER error attributes with the tools to
> control error reporting/generation (ratelimits). I'd argue that
> "aer_info" name still doesn't express what the structure does.
>
> aer_stats sits in pci_dev, so I can see why you decided to use it; it's
> one of the few available places where we could keep a stateful ratelimit.
>
> How about creating a struct to keep all the ratelimits in one place and
> embedding that in the pci_dev?

In a previous version, I had a separate struct aer_ratelimits in
pci_dev (similar to your patch[1]):

@@ -346,7 +346,7 @@ struct pci_dev {
        u8              hdr_type;       /* PCI header type (`multi'
flag masked out) */
 #ifdef CONFIG_PCIEAER
        u16             aer_cap;        /* AER capability offset */
        struct aer_stats *aer_stats;    /* AER stats for this device */
+      struct aer_ratelimits *aer_ratelimits;      /* AER ratelimits
for this device */

However, in an internal review, Bjorn said:
> I don't think we need to burn two pointers here since we always populate =
both at the
> same time. Perhaps combine the stats and ratelimits into a single "struct=
 aer_info" or
> similar.

It seems like the preference is to minimize additional memory in
pci_dev. Any suggestions for a more appropriate name than "aer_info"?

Otherwise, is this a good enough justification to maintain two pointers Bjo=
rn?

Thanks,
Jon

[1] https://lore.kernel.org/linux-pci/68ef082c855b4e1d094dcfc9a861f43488b64=
922.1736341506.git.karolina.stolarek@oracle.com/#Z31include:linux:pci.h

