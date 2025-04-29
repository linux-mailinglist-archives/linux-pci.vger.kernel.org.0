Return-Path: <linux-pci+bounces-26999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33BAA0BB5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193974603EA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32873524F;
	Tue, 29 Apr 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GvXzxD8o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3202C17AB
	for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929800; cv=none; b=d93guF/KBIRn0eq9QckhmQzMuUnZXWuoPyHhTthvWV9iBBznhcSbqy4ps8KBg0IsSl+IWg0a3Pm4wa7Yn8A8IoJHOCzGTBSsANc6A7kj0TyyaTSooaJ5wp0Q2Gl6kcWYNEw/AHrceZe7KPs8PdMoBzyKcAB4bmlG+E5yt+fqfZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929800; c=relaxed/simple;
	bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnT9U9qUvdj/4YjoXIcoYke0AdsHnTtt+7CRXeuo2q4M2uq/1b7OpCCGClTQmQdwJWRY+xNWKm24mj26itgiYMjdim93gmcCL1lR5VpCbDQbt581qdCuxMzSTwy4zBk9YsSecPQvHocUd+h4zhtOWtX2bqBL9dP5g69Uapa/p3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GvXzxD8o; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so82356006d6.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2025 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745929797; x=1746534597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
        b=GvXzxD8oRwhhVzjNbV2jdHw0mz5JxM4ox2OE7i20JCyA2Y7XIoL7gYEEaqUmPEJKqg
         saoJXZI/Zcju6zbadTmNxI0neJ6pk9r8w6WYYmK1BTH4cfV0ExZFFBou0AP43PPZHmcC
         UFyALwg3A/XpUVS70ArqD3y/VAaOvYhYv8yJ47X6Vs4RanvbpdOYJt+RJcl9fhOvemjn
         AVqGfwM8C3RR7Q4GkSugy/vZ3CsqoHC/vaIyAdecNDl38PKY7b8lSlcicxyYjJhoH4dg
         +bu54vsxwVl+8KxE8KXDA6EnZSzd54Yn6U96gZFjg3WoXzT8S0qqTThFRnC2SJ5Bs5qI
         /tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745929797; x=1746534597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
        b=hiGqLFtpkCUCcPdvevPyeMyhUjudnz1gQdZ1hlnPzDndxOFj6iBgn+ZNMaQpPPKptv
         mV6Cr8YijlgyA0ViqhvylR49oi/WS5dCc9ao7T2cDK8CeAa1+XAEFHSz9f6DgWRXOzdr
         dkYBlQMEsslowb76RYxUXqboPlRMxiYcvd7hhKf8pHbg7Yx4AT/2Xi0edt0XZX09tU5t
         fwNyasWRTlmGZksAWX9uAZXMA4oQY5MqhLjje5iT1W+sdckNzurGamBaN9uJRn1Y2lwb
         hSOl/uzK2DGH30Q2702/J0g10CIQ/11ZayyVgxU0xObftJ8yu5IMPTTI+jy65dR5NXgn
         MMRw==
X-Forwarded-Encrypted: i=1; AJvYcCVMkd6df/UuLX1eh4KF3Sgv/mAU7tKNKePQjPSQMWZwD3cJcFLomXpaak4LX1T9M1F9QmG1fXLCxXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufZ15GotH134a5tI7dyWZxwpFFyUR5yBpUrJWsJfhDyRiZF9u
	XVOF/A5DShUbU5ajurbubNulax0YPXD0w9LlZiCL9wEtoknjTzGFsJXBGjzETgM=
X-Gm-Gg: ASbGncsyZe2nXYYUNMxVtJFlxcGBieWsiO6kncUvong3gzdQdJQuGXEaW0yivepTugM
	Ce6IqnWLOSnlD2h4dCWma/nhpT1HSZ77lm/ExkNMKkyv26Z1HwE8uklozfyIYYu0foOer/+ss9f
	mb/NyzVUdxsR52akv2Jd7TAgjamLj9MDoS/+2KKCobVSg7LfzU4pwLMoT1vyNYh3VYg+mWpO/dk
	O2Ta5zyuQtKrmLIP7jmEirA6lHf6ejs008HjOeIcTqq/6YBHQJKV9j3doTxX+e1KINUHL0T3qxP
	RzAV7eBDfMTEl3EsYqa2E93PUkPlR7lvLA1DwjcxsHgZhHjWdvfwcdWGqvlaxls/wpx2G8ZMqxS
	fqqEmt3ckM78ZVuclP2Q=
X-Google-Smtp-Source: AGHT+IEgx9EB53XUdGV7vC29k/JxBvqJ89luumOzPRGbpdqAFnmUSowtG6tg8X/s0U1VWu7lyHl1sQ==
X-Received: by 2002:a05:6214:d6d:b0:6f2:d45c:4a1d with SMTP id 6a1803df08f44-6f4d1f9d772mr228245476d6.38.1745929797482;
        Tue, 29 Apr 2025 05:29:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae68csm71890226d6.97.2025.04.29.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:29:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9k60-0000000A4cD-1RSJ;
	Tue, 29 Apr 2025 09:29:56 -0300
Date: Tue, 29 Apr 2025 09:29:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250429122956.GB2260621@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
 <20250424120143.GX1213339@ziepe.ca>
 <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>

On Mon, Apr 28, 2025 at 12:11:40PM -0700, jane.chu@oracle.com wrote:

> 6.15-rc3 is orders of magnitude better.
> Agreed that device-dax's using folio are likely the heros. I've yet to check
> the code and bisect, maybe pin_user_page_fast() adds folios to page_list[]
> instead of 4K pages?

It does not.

I think a bisection would be interesting information

Jason

