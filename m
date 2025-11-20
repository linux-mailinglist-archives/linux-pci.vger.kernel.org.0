Return-Path: <linux-pci+bounces-41793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E6C74AB0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C906C2AC87
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F8348463;
	Thu, 20 Nov 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nlop4bDN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC233FE39
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650373; cv=none; b=Z+O5ZmMuV4T6IbeibexU5/GcgMc0FknUAkRw0qqCrTx7B12Pg0HhXsD29syX2R3fCQ0MLUczBsgMVv2H0meEjkrqHpFrhPxhpkPmIiGYuWawApHAge20eXgjlCmElaO4urVGx/g5/sIf9jCAzH2XJkdUu7nLX6b2QHS7w8c7zAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650373; c=relaxed/simple;
	bh=fJNbQYu7PoiJLsEPpjUYNqAPI6k2geFEJacIKnsv5a4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UkdubQzG2VaGuHvXpLgtalU49Xncz4ibTWyjrA7C/9tPCswuwEGMTWwTG/HgGRIyHNkJlbhw94uKyWsn4ZU0c3NhE6By5rnvITrVKSeJ0dUIdaNYEBQvntXoll+uGDStPb9tnpl0sFNyVv3mRhKNvEoS/FjQgGoTxvwrYmIJ8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nlop4bDN; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-435a16798feso7420145ab.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650367; x=1764255167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=Nlop4bDNIOkjuo0pMhzaqc0ODrEsmRo7XtLqwhp00uyFASxw+sbIvvfDKg63/0WNIr
         Irgw7i1L5c7f3KspyZuRfY76O51HffIuodvQy5ZIcDN4No7WwIxUOGZ9dpes/M6K+nsd
         SNLzENdMcdkRpJUmuFjuM9BMlGaR61DPmsUMatu7aVJzbpi7Z/RO6GbliOgOscpBha8S
         DnzFtV5phPRpPEJgf98WlMFKyzL6CdLykV3ZnkTgBAq3ZRb9M24771+6fglXYKmcEHuj
         JwzMwrRMP1iOEu/PZF6XSo/nxjqLzdvmfaif9TGvKGR4YXIy2m1LIpokuAZvSHGS7C+s
         olCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650367; x=1764255167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=Gj7EEYdK+XTRYqiH04AsQ09k6hNIh/fGf8JTstRu2Dv8HmF9CWlnvh+rPFnKd8/85J
         yFRmN8rmsaKDBdkGaeOiwWHWz2mrFU6ECO7RrH/rBFCgIJLLGx1v1oaepse7wdM/ZIJi
         q3vi5P7t4YjunMs8Md0cochKjzmCNwKQ3gVEr8dgErm4LwRpfIvv8/Vm7Y/Z3xCxhm1w
         O6IkHQ7bWERVJZZM7J9kaGSWBAy8oKfk7qEJC79uype2K4Q6dcvlB37knmgpC0L/vjpB
         p42JOPICvctZoyNmCGpwqJJaU84MssMo9DqAYQl5Ylwt6awofUb2bx2uqBnVYBVgMNXQ
         UqMA==
X-Forwarded-Encrypted: i=1; AJvYcCWVWL45eLuq/V6ZH8mq4Bra+Zf6cykdLPqQRuOgA6RhJhjgzbC5QIDL0jYr6RcXqWX5hpLadehN2qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhzd99IbRaw3+k14A58UNJ8D49o0pQgKhbMDUMc3QiYFLbYyDb
	FivDpIJai48cK59y+UZQbEUoWIn6neAtqOxkuK2qUlP73P06J/HG9hNLDSQFPcphFtc=
X-Gm-Gg: ASbGncuvpQOcPhOFV0SITAriii6ZyC/iWOib5r2/F2otG8775EqCA7XCe+nzUo44Ryj
	J3Xvklf/D3pOgnArd1Fl1zA31h22A/24F7/jPfr/s9mUYm/v8sS8WkN7QOztyCzYTnuvWyAfDy5
	D7xBY61vxYItLAMHTYkA9lfphEvfM1F1kfGwiqfFz8r0mL+Xgm/lqD1l/VR/ZRAuXuYds4/Cx27
	2QWcXvUsNmo+KEuLO6GM7ZNXLqlF2Ctn0imKSBG1kvxH1U8cQj2WAOYsiTs/JkKhEQ6YAm3c2bk
	GeqXNxYX9baPA8lz1OKwO07i/i40zWkVOrnP8vAJO23AVhZg+abRS/kmvLU+blEUUqgdl39sfFI
	jcopN3ZIdvqXr02vEGm2LbqhAoUN7ZvhbWqbKUDTdoqV7zyHu+jk+NDJ7yZJxGnYoFpjid5i4zv
	U0cg==
X-Google-Smtp-Source: AGHT+IEmRlVKCe07qbgo1t2w3uFpBKsqx62crTftDC+8sZ0oUBIrcGL53VTRakva//fmnWvcfQrQww==
X-Received: by 2002:a05:6e02:1c01:b0:433:1d5a:5157 with SMTP id e9e14a558f8ab-435aa88e822mr21434775ab.6.1763650367018;
        Thu, 20 Nov 2025 06:52:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm1008611173.33.2025.11.20.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew@lunn.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 John Allen <john.allen@amd.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Mika Westerberg <westeri@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim <namhyung@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, nic_swsd@realtek.com, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Olivia Mackall <olivia@selenic.com>, Paolo Abeni <pabeni@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, x86@kernel.org, 
 Yury Norov <yury.norov@gmail.com>, amd-gfx@lists.freedesktop.org, 
 bpf@vger.kernel.org, cgroups@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, 
 kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-mm@kvack.org, 
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, David Hildenbrand <david@kernel.org>
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Subject: Re: (subset) [PATCH 00/44] Change a lot of min_t() that might mask
 high bits
Message-Id: <176365036384.566630.2992984118137417732.b4-ty@kernel.dk>
Date: Thu, 20 Nov 2025 07:52:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 19 Nov 2025 22:40:56 +0000, david.laight.linux@gmail.com wrote:
> It in not uncommon for code to use min_t(uint, a, b) when one of a or b
> is 64bit and can have a value that is larger than 2^32;
> This is particularly prevelant with:
> 	uint_var = min_t(uint, uint_var, uint64_expression);
> 
> Casts to u8 and u16 are very likely to discard significant bits.
> 
> [...]

Applied, thanks!

[12/44] block: use min() instead of min_t()
        commit: 9420e720ad192c53c8d2803c5a2313b2d586adbd

Best regards,
-- 
Jens Axboe




