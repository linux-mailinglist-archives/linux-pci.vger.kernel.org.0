Return-Path: <linux-pci+bounces-5959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759289E0D7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D72843BA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A892153BC0;
	Tue,  9 Apr 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mek84Bln"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D3153812;
	Tue,  9 Apr 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681627; cv=none; b=BO5dUaBCGRPVBAsCQI4Q8bABL3L4ztsBoRbRdL9JLE3IesTWW6StHxfptGz1XzKm3YKvdzTTI4v81zpDhjySekJb2dTR935Eu1WAokxl1dNrNVxdHf+5CWSbXWwpEE+ZI7JZ72BwXnK1uzGkFRh20QQUs6xJAYXRQlOysiGbL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681627; c=relaxed/simple;
	bh=chBehg2sa8SKvwmTQThZQ1pEhDP/14nilZbP4YPlD8Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QfXVHKaWQLOByuB48VlxcUZlRaZWj1epLHPxzV9FCHoGW9YrKnrmPKVv/HVfoIupWkQIfY5UK8SpZBbTMACeii5+XnDzFzcHFzWw4EfpQ4fgfumD9rHrCz1d3kEgA/zMsKHn/XwOri3GHMTyGf4Uj1/NZAiduVmfrePDPo0Y3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mek84Bln; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343f62d8124so2931460f8f.2;
        Tue, 09 Apr 2024 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712681624; x=1713286424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCbSwn51aiw9IOk2Ez9n8ivUwG4FGzDBwdsdDwRE5oc=;
        b=Mek84BlnYgh4WGeQ0sQvse0DmtVxkRfqv5tQ0ZGhw1KYP3WkXgcy6hF1TE9WY+kQ1E
         VWg1oc8Eldv5grTBkkRZDWZbojk+/OXOZx62NwnYu9qQdgx3rV3wqrlmC/g/5O0G5kII
         8xCCw6UomyPCjPeSY/LYCOU9EuWGwno4oXCzmro1ADcYKphZxx42nnIlHgVkMlkvXlhB
         pPvun1/WzAQeAXpq7PmzhcoAXUvpC1pYAYeAlCKm7mM0OVIr/FhHzEh0QcIJe+9iEfvY
         wreG9EH1wp1GHzvoS4uX2ZArrD9rLpxGXOZVwZB+7Z96VKHhO6LPhukeh+4JjsXYLVO5
         mJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681624; x=1713286424;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCbSwn51aiw9IOk2Ez9n8ivUwG4FGzDBwdsdDwRE5oc=;
        b=Ee5MOZ3snO/xtpa4axrVh6/ecnUgNwBr3zhJuIYnnhf7DiWgHQlT/Pjr94QMOdmM96
         FkMaRsYCsR25qjvtxof2BlB8l+X59qktLMzOJyEXrhYpQZrRxbxKFszeIMlCNVWOuU5b
         lpXgQqkXiHAJ/aZ0rKhR4elt8VSQ3MTgCkbIR0sQRdzyRnfVOut+K/8/WtoPouKfxm8J
         w3wjNM9YGfS/QmVAPx3/W5AO7pI4EiX0hKmiTfC+dvlqbJJBT06V/OH5Hr3r+1icqtOP
         EOQ+WDctNa8aBRURhFaWx+HePkRcdloQlyHy3YEvWk8d2qtlNGtH2fc31l0PekAo5+vN
         14Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW+1sRaao93k0yMjnrdijJLwJFW4tkTnbgDPHiEeh9jKesFr1tprztWO1G0LFIbEVBgxCqmvd2fSEnMYrmxBUEqP5//eCsj1u2ljQcUA02r+Nb1iCl3oajf9cUMirDBgXat
X-Gm-Message-State: AOJu0YwKim+xsTa0zNaFkTOTTHkpqKyVtzSpongSwjk8M3Fh36nkR5nD
	HYzmVnxOSkzXJ9COOOda5TUtV3P9yRVHrSIa48BuHCsq4WeX7ubY
X-Google-Smtp-Source: AGHT+IEeC1TbvkWyIeC+ivHrPX8H3AjFOZvhcNxCu1qvzz05na4aEpv3lB4IcfSw7SF9Cr1OJtSCIg==
X-Received: by 2002:a5d:4ecb:0:b0:343:b942:317f with SMTP id s11-20020a5d4ecb000000b00343b942317fmr206887wrv.22.1712681623941;
        Tue, 09 Apr 2024 09:53:43 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b00343e085fb89sm11845664wrr.2.2024.04.09.09.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 09:53:43 -0700 (PDT)
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
 Christoph Hellwig <hch@lst.de>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e5c565f2-a552-cd40-17dd-bdc1fe39f20b@gmail.com>
Date: Tue, 9 Apr 2024 17:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/04/2024 15:24, Alexander Duyck wrote:
> Why not? Just because we are not commercially selling it doesn't mean
> we couldn't look at other solutions such as QEMU. If we were to
> provide a github repo with an emulation of the NIC would that be
> enough to satisfy the "commercial" requirement?
> 
> The fact is I already have an implementation, but I would probably
> need to clean up a few things as the current setup requires 3 QEMU
> instances to emulate the full setup with host, firmware, and BMC. It
> wouldn't be as performant as the actual hardware but it is more than
> enough for us to test code with. If we need to look at publishing
> something like that to github in order to address the lack of user
> availability I could start looking at getting the approvals for that.
Personally I think that this would vitiate any legitimate objections
 anyone could have to this driver.  The emulation would be a functional
 spec for the device, and (assuming it's open source, including the
 firmware) would provide a basis for anyone attempting to build their
 own hardware to the same interface.  As long as clones aren't
 prevented by some kind of patent encumbrance or whatever, this would
 be more 'open' than many of the devices users _can_ get their hands on
 today.
The way this suggestion/offer/proposal got dismissed and ignored in
 favour of spurious arguments about DMABUF speaks volumes.

-e

