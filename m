Return-Path: <linux-pci+bounces-21324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF72A33348
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC4E3A7226
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D720011F;
	Wed, 12 Feb 2025 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VCrLCPw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1A1FF1D6
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402440; cv=none; b=kpsgU5LXM97W8bOidhQqFAjAiFEJw55Uy2JQaUIM5sWXmo9mQR9TcHhyTZSIphtub+q5iD/1j1FFRw5VgXYcLgvV5Cveu/P9iEeFjB3L1cRCWKm90w0eJYcFio3/BrU1A2l29XBPfX/F31pv9hek2kvBd4p3OUbR9I9FJUBUoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402440; c=relaxed/simple;
	bh=oi5JgBjWK5UERSgWaGEKIoATNNGA8GyMR72xCpVio8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWopXSDFULYf+hdWv6aX37yQ+1QsW6+t3v56sWBGFeys8QCkYv51/k0tO1Qs3HWPSQUTqsKbbhyCI8DKxI5iclOAa59b0eex56BUrE3YnfrvfBoHYvc/C7H4ccj8NMnhIW1KANwBRwVS9z1sbRlPQtXj5ctDJy39W4aV2W6IZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2VCrLCPw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so345097a12.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402437; x=1740007237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi5JgBjWK5UERSgWaGEKIoATNNGA8GyMR72xCpVio8U=;
        b=2VCrLCPw2ucycQ3WeCRcQIzRsbd248jR0ZsUJ7Ja62QUPYDUCw/c73QfK131d+au8y
         ni8HmtDHMd7udmiXp6PNP+XwY20nwK7xbIC72xIgAb9rrqduuOsGkywf87snyQV/zrr8
         IQ5K9rRjfMqhlAcoLttE5zwMg+ggZFviImTNY3QWHaFPvOza7ccEKk4iuW5B2rAype8M
         xlHcco/WbbDqwAx91pQGMVQNSJHut3Y3CgKNKUlJv4tyHM0kgTo4IMgj/BLG2yLIQV79
         epS12q/bqZ/Sd6/bs77K+WrgUu80tweRh3ZZpKdNJFj/pb2rTNGCnemCkh8CsjE3HRAR
         ++mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402437; x=1740007237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi5JgBjWK5UERSgWaGEKIoATNNGA8GyMR72xCpVio8U=;
        b=KEU50qEPKx7xRkGp3TMZnCL23HvTs9wiPpO0tlQJgj9BGqoJMUU/QLIxdYRntqhTRg
         ZXf0Ft2/CgsxtRJpMcUGr3qWJFVjrQqSNIG3RQZUDVxcq8vC4RaNzWZQhbFI4OWmcqki
         lY2hI+MaZKy3K1HwPoO/vurwXPm0Bb+eONxeSNFwW5/QHw+4p4BlxsL5AhNdsCP0liAt
         DUtP19VG36ZemD0NIIeOlF7hPaE1a1SgD+iqlBIEj2nscAlgPStdASkSt9J3VTSnFuWB
         ZgtKg9iftkDeGf34hdoYPePmeRa11l6ZzJr6bsY3gtFUkwr2NlwxMTmMHNMB0IUvJejm
         EIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEJKvbL9bIXpaBPNHizl7AhbKdPFnU8/j1GmU1P7jyrbvINMX3arxz8N1PN9GF6JmO0SRxOZXyWXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbbl3a3PCnhZXw8j03OcpawBCsCuBb9ndf0UFrhzEkTdF1OBf
	iCjXLbtvExXJOOONV6ngwt5Mjim5aDQ7dLlu8MevfkFP6Sy5drFxxv6VZ4H9AC/TopDNTrufFq8
	/tf7NDt1X0Jwnj/ZrpTXPFNICZPCZOcMX1NeG
X-Gm-Gg: ASbGncsOwb9/eS5zZ03TD0dDETFMMhr3une+7pVe90hz1b7B5aCmD+OtrkFYBEtWf+h
	ZfrNtQVpdxR6LmNzL38GayTDl4FPesoE/XeGfo5a8AsGcVTYjikl6Z6V06ly7EU2v+7cYmDQrzi
	0h+1tNn9Xk+4z1tDNYSm76Hb9fMFM=
X-Google-Smtp-Source: AGHT+IFP8Lq/1eRBsXzHktF0upklpH50TJ06qqHI9CqmaF3QBGIayYMdHPipyhR7uRAamIlTw8W+L8GO1w9cAI3kqKw=
X-Received: by 2002:a17:907:3f1c:b0:ab7:1816:e8a with SMTP id
 a640c23a62f3a-aba5018d61dmr115738266b.36.1739402436865; Wed, 12 Feb 2025
 15:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-2-pandoh@google.com>
 <f9ccc68c-216d-4cb5-9e0d-d2b49854f06c@oracle.com> <CAMC_AXU2TtkO0cn3Yh4CVpaQC-D6eWo-yZmPKkLZJcAhnFA7iA@mail.gmail.com>
 <cc9f5b49-ca6f-4c65-9cae-b273fe9fb1c4@oracle.com>
In-Reply-To: <cc9f5b49-ca6f-4c65-9cae-b273fe9fb1c4@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:20:25 -0800
X-Gm-Features: AWEUYZnMJKbOiytc_6FDH-DQ-jiL6J_MQIvVaNn1ZEGahA2_2f_50qeJledXtVw
Message-ID: <CAMC_AXXhtP=1GGx2gMvqJ7Qz+Fp5zA3poXwzZ2R7ZOZp+UYWPA@mail.gmail.com>
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:26=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> As for the commit message, I'd drop the before-after dmesg messages and
> explain that the information presented by aer_print_port_info() can be
> easily inferred from the actual error messages. I had to read the code
> to remind myself what information is duplicated.

Any objection to doing both (i.e. dmesg + explicitly call out fields)?
An ex. of duplicated log was requested in an earlier version (internal
review).

Thanks,
Jon

