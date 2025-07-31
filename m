Return-Path: <linux-pci+bounces-33256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D1B1762D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 20:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A51F4E403E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E11C5F06;
	Thu, 31 Jul 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C+2f7/WV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0E2522BA
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987536; cv=none; b=orzbqSTDnHXJvVupumBp9UBdqrHZ+BtZRXippwpFANUMeKtRA34XTecULop+6F34E7OHLKb3JL5/v73vlHIMBy0a4XMt6bYPtjSp2bF/pgTI7lc1HKIQLICGpUrFfeVvsyfkg78pLGOFSaOEvpaU0RttEVuzYyEsZzv+bcWf+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987536; c=relaxed/simple;
	bh=3M3R7EJrFDhwkCVwc6/8EJmGfdEDBNCXRwUt8aeK4BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNuN2b7Ouyj84VwKKM49U/y72gyO7c0vwjAjJ7GlLg6yTuPEVUoXoSBxW2I0VBGKP8eFJB80GrPlW8j5Oc5B3LcJnTITqrUYQIFQ9b19YnCjY33qqkQWdGNSiUpkdllJ4JrBeRQzkIUiWFBQnLX3Vs3XlqnIbUZ4j+LE73MloXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C+2f7/WV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so84758a12.3
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753987532; x=1754592332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PzncSLckPmbRbvc5UgW2DQUgu4BP5imhDPkvKTb7j2E=;
        b=C+2f7/WVyid+93ayQhbsMDiJ6BOAcrhelBg99ta1us3Djvsm/4dkNCNvnXWiDrDp6L
         qRsFUxSFBrhhDw7gH7ppb8OlLyU0INiktJKNXsp5veNdREjihp56YqE60EwqD6ZPnER5
         XcFC//xY23VbTiQ9cSHIhPntmkpKpRV4I0Ai4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987532; x=1754592332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzncSLckPmbRbvc5UgW2DQUgu4BP5imhDPkvKTb7j2E=;
        b=aAnKy/ItOz/SBfriiboAlSSHAQk1jajSpd9yZYakTjOwLPJqUuuZc+KPvBAbBE8v+4
         SarJ7WXlC3PXvP4nmCUPfYotCtmt7gwjN8XYuHCVNRxjz/EWaLPmctgBDKFZ81m/FRb8
         4SLmdQTslKDwusCU5ql4456D4tXCZlHNQhSh1z8iRorc71DiA+9ZaD0VjLtCwf3rBcaq
         vEX23j/hGiBMAHwXLhmcc/Fv8gy9Rv73kPTYQIRoBD0tAs38mYUfNInaYJZiy/pZEgd+
         kKyOxQCpc3ETZpTP0nG/REPOiappWJG0V4BnefactEtiWJe8ZuHU7E9pAUp1Ie+bjB4J
         KfKQ==
X-Gm-Message-State: AOJu0YwtvlgLi5ivHZ46N6eEm9MjBUCZvR7MtVUk4KCw03DpTtFfFieJ
	UbnRSEwoEuxw9pStUIRwx62nQw9K0vcyRb1UZ/5QdkL0+WOtf4r9C9jTqsmc25dLjPVWfljWMLX
	BUF0Sf44=
X-Gm-Gg: ASbGncsOI2/PMdLxqr0B9Lhc+IPHimbSBKlni4gdGR8mbcpKRdDGZ41rsSOdpYhSyzU
	S1L7JrQxe2F5zAuTdGDRfFTReKaCnllZTSQrn8aZDMuYF3mOYXsA63ICbA1q80yHkRuQ7G5j8nR
	pKjPkxb2bY8o8hkDwlsmb+VbNCEk+7wXiqhE/c+xsOFa9doHrMV30b170PAMJ/pYjYOlsna+3W4
	+akWPYmr3wzHWfSKX3K/ml+YBRQWW81SGJ7u23ztWsp+UVO1GuwDwZbPrD3rHy350PZQIq59zLJ
	8tzmbOb0LQvyowG1SGa5TdmNnFKAMiKCX8XSbkEO44ljX2Eg6OJALjaADwFDjnAdrltLpoJebFc
	zBaZ7Sv5tXiZTDpYIL5vSGM/PkNCCf3I0Yz/iXmt25isgpSbFdX9qAUr8lfXzXAHVtY+IC00s
X-Google-Smtp-Source: AGHT+IGnNH+dk2FIl3GjAAZikCC1mzgvc5rgZJy/AvMfuvCBxx71hqSGT4KIDKwKAQmUNJStV6Lt0Q==
X-Received: by 2002:a05:6402:3546:b0:607:28c9:c3c9 with SMTP id 4fb4d7f45d1cf-61586ec8a93mr8139811a12.6.1753987532053;
        Thu, 31 Jul 2025 11:45:32 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aee5sm26182a12.3.2025.07.31.11.45.30
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:45:30 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so89653a12.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 11:45:30 -0700 (PDT)
X-Received: by 2002:a17:907:60d3:b0:af8:fb0a:45b4 with SMTP id
 a640c23a62f3a-af8fd6b2174mr998226166b.18.1753987530275; Thu, 31 Jul 2025
 11:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729201441.GA3322910@bhelgaas> <20250731181132.GA3423684@bhelgaas>
In-Reply-To: <20250731181132.GA3423684@bhelgaas>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Jul 2025 11:45:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_zZwg3k1QnWbttz+qFTxwAO5aGAut3Z21cC_0nK8LeA@mail.gmail.com>
X-Gm-Features: Ac12FXwhANou0M4tFKH6KhOnLhPbVU-YB5JXS0xrsgoWuoPmLJf_2ap-oCGxMxc
Message-ID: <CAHk-=wh_zZwg3k1QnWbttz+qFTxwAO5aGAut3Z21cC_0nK8LeA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v6.17
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Gerd Bayer <gbayer@linux.ibm.com>, Hans Zhang <18255117159@163.com>, 
	Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 11:11, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Gerd discovered a regression here on big endian systems.  If you have
> already merged this, we'll fix it with another pull request.  If you
> can still ignore this, I'll send a replacement.

It was literally in my next batch of pulls and was lined up to be
merged, but I have dropped it from my queue and will wait for the
replacement.

              Linus

