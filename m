Return-Path: <linux-pci+bounces-22822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD50A4D50C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344F01886B88
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B731FBCA3;
	Tue,  4 Mar 2025 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="U+O6BEn/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400C1FAC59
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073984; cv=none; b=h5nlyuonELBX12xdmrTqZySiuxwCnouUBasaxv4gHKGb0VtZgJp7VHg9VbyDWxYshZng4qOxTGQsgAhXjewWV9cAC9235ULbBYA4kH0cqOqMcK1asnAqT1bjMD/Dy4N2Ym9WhHlgFpULVKmE18KnVAq1VSLdu2b4n4ol1TDKVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073984; c=relaxed/simple;
	bh=CPnzM1fw74lR2iJtYGUJoxG2I//OQLR4COigFE65VMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOcPBfOFVFl/ok19mdXIshgDJ7qkqaMI51UKSP+7Fb2haLMBXg9x3CaV/AIBFrk7Y5AODasoAd7QYIxq0IiRL+XM3zoK+PalatiBBvr+9gXPA8ItoyZB2h6GUs40cDvwlrVca66gUnAqDw0H47qaaphlrKmQB9xkXTe8c5hugpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=U+O6BEn/; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso2046538241.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1741073980; x=1741678780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPnzM1fw74lR2iJtYGUJoxG2I//OQLR4COigFE65VMM=;
        b=U+O6BEn/WqQwLh4b5qjanKK6ULHW72iRRSe/bXTKMtwbFUpgaEZXbyqGB9AiBdo2hQ
         NIVh+/GUz0AjOFDatDluewSBLAFfB4eFna0fLVHukFxY9FVjfjQ3TKnJLNsphy6fKBD4
         MSGCGmibUBGgFC8oaSNgXOxU4EipBK4q0HiuWAn8pi2+XgSUXBzZm+i0cthcJ75X648f
         p8lmfhKSs+i+aS7R84J9QxPmtdfsUnh9pdYDkrtYWvehg0X66K+qU3Bb7yD7GKkxEsuf
         KtQEOrU1d3RL8b+abIPNF97yNkauYepRH6LJUR7syUcIFeT0hkQIsAm639lBZ9WGbRTN
         t4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741073980; x=1741678780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPnzM1fw74lR2iJtYGUJoxG2I//OQLR4COigFE65VMM=;
        b=w5DLVLMXMfKi+OzL9wgeAis7wMUI11zO052quT3y0yPs1gA3jLPSu11BCqq4l76jH8
         Mt3Ix18ih3nlStwO5+qmgHvS3BWM1ekMBCEyiHJ427qK4k/ITKsofI9I3Ws4ULvpGZCc
         omHj8LearPMuGbAFU1OkUv/LTzq8qKeDH/97QgeOwvowjk5WLdLVtihgvmCX4EVWOyfK
         2VC0S3nQnGG3DCVwNkvC3lUI2NYcnLjsbQgaHMza3wvGycvrAVFf0cExjxWbC7FSJ6BI
         yu3oCC+p5gUpEisC0SnIxuVa/E76kpNVxtWZEX1smPpX9OEPssA9rMa39841x0ubah+o
         X0pw==
X-Forwarded-Encrypted: i=1; AJvYcCVguRAEfwh4DTn5Et+HwOzzxrESgktVKnbIhUwVQnRuWmu/F+e9cUD+pQWbHBCRma2+xTqnvBJOvnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFEWD5ZQ1Y6X9D1FDbAhXpeIfq5eSNZaLJMbxBEHyHWN5rHik
	28rArrPpQCNa1GUW/ri3y81lBzytFofhXOwp8REDrdB6UZtbAXXlvfDi6cHUpLH62ceLeQxIQaW
	3bySmT82vD8pAcaYhPeTBkjckFd2JEIQaq6cpLg==
X-Gm-Gg: ASbGncvZ0GPPi3AMXIX1rFxIOpu11WOdIoc/h8MMqQxXlAebvu0JPQ1ViNrRuWbyWED
	V/Yw5bKHoTTFMB3h2G5+ZWKkaq6qBI4A6DDtSKSaCBKfAYQNyk87p6QdC0cFgmtKrMa9eGKf3aL
	/Oq60mUjs1L1dVn6CBJh+QVgup
X-Google-Smtp-Source: AGHT+IHBTquF9MMdpA9ujTlISPqC+SGfvhVpdyIpNp2XJLqCK3NGLsT+uSlBNoyMtDFz+YtnQ61PW04FxbJj1JrvxVM=
X-Received: by 2002:a05:6102:568a:b0:4ba:95f1:cc83 with SMTP id
 ada2fe7eead31-4c044ed8255mr8739901137.16.1741073980287; Mon, 03 Mar 2025
 23:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <Z8WTON2K77Q567Kg@gmail.com> <CAJDH93vwqiiNgiUQrw0kqDkHvaUNUcrOfHJW7PGezDHSOb-5Hg@mail.gmail.com>
 <20250303184208.GB1520489@yaz-khff2.amd.com>
In-Reply-To: <20250303184208.GB1520489@yaz-khff2.amd.com>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Tue, 4 Mar 2025 08:39:29 +0100
X-Gm-Features: AQ5f1JpHqszI2Fm3lvlQuFDw_o2qX63ihfzLeXdQyT7L_4E9WZBCEpsmQxne4Q8
Message-ID: <CAJDH93u+9KLBVSrFnQm3==9E4VaVohavq+FZT+UqWdRs9FHn-g@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Yazen,

>
> Ros,
> Is/was there a reason why you didn't have the MCFG/MMCONFIG options
> enabled in your kernel?
>
> Was this a side effect of trying to build a minimal kernel or similar?
>
> Thanks,
> Yazen
>
> P.S. Sorry for the late reply. My mailbox is missing Ros's reply to me.

I inherited a kernel config used here from a previous custom,
V1000-based solution. Most likely originally
it came from the x86_64_defconfig. Maybe MMCONFIG wasn't enabled by
default at that time.
We never had problems with this because our BIOS keeps the IO ECS
enabled (that's against the spec recommendation).
The kernel default for PCI_MMCONFIG is 'y' now, so it's unlikely that
people will run into this issue unless
they explicitly disable it.

Regards,
Rostyslav

