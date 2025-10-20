Return-Path: <linux-pci+bounces-38829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A446FBF4156
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742E118C50E5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205DF2F8BC8;
	Mon, 20 Oct 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKJDhg31"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCB2459F7
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004561; cv=none; b=pbQI57eHsTvBZYBj9hv4ZJOo9iMxhd9Jilr1RzmQFPqEcAx7pTvfC2EE+wdKB1hXb54l55wnQ21pLJF8btqhSCcIdPzf6X9/OLYsLiFuTmvk+DvzSKfH2SBI6fjaY/AbETgO+KR+fptHZrccnkipKIpjDe8qfI2zmIUKM+UfWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004561; c=relaxed/simple;
	bh=mcUKfYrdQSpgEynl2UwsrQ2Hve4TuJQzk8+mUSe+wHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6OHJdlEN8s3jvQh55TE5Lvykw1dELGZuM7BThseN697RiAqbnieNguQnKAbxs/3SG4ek1ictYzluejDXlPHGbng2F1QXQBm9aL02vMqVu+BAWvNStycVBTj/VECA30CUFYAqOxe3ZAoPDG4OXH5ZFv7cSWp0niI7QmYHnDrd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKJDhg31; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so97575ad.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761004559; x=1761609359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u0nnZ8bRb5CyQ3D4M/BOIhfpk20sndQZa2pgDITOBD8=;
        b=wKJDhg31+uMG8tNCOQ6dOFikOV8xNjjHTlI0dheKwrNLRKSZyfyIwpHDwsvlHsAgCP
         Vic2x+oWGa9lJpAhMELz3u46qNSngEypjDZ8WfPCe3geqdgnLPYHuO7kwVCnQSwpOTMN
         46c8HkTYok5k8qTzt9sOUIhyfqAdN74wbZsgl9DVbO5BeD1CTSb9osW84mGcO76iTlX9
         toldUfnk5kGkqgXsA09dN5Bc81m9f1lPeywv/2lUSeK7tJN7kH5MJo5pmkIwypdkpqHs
         /G4itnMUYSxFrSvkRJw+VOWpKUpg/5lqDPg47V2r4xwbuioQVXgV86GQUK25w9+m3fZB
         mtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004559; x=1761609359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0nnZ8bRb5CyQ3D4M/BOIhfpk20sndQZa2pgDITOBD8=;
        b=EInLN8FoEKn4qin3O3tKZqbQBbCCIma/eV4mtAYG8e+5TKYo8rOT8ijzHsEJPgPtCV
         BPDuEZqJFkV4ssu+kl1UpDYzfiATGkyGR9iVwRWqlD0PH+s1wXaujskh1HbNPXhbwgs8
         5iGqMFr5RLiMqSnsmuvIpnvd+elGqh7pTl52zUrnFUs4952Jf/vUyYyPXAJRX3X/OkLn
         Cwj6fi0MG/DFfY6zaJxZ+4lLN3rO7PgtoK1qd2GA7eVA2u9yRWJk+brob3qySbhf+KWz
         CX8LLMILsglTjEN4bMatLclQYSkPDpMxTIDRpCIFiGau5lAev94mV/wqc7wkQV+2eyuy
         9A0A==
X-Forwarded-Encrypted: i=1; AJvYcCUMrN1IveE8ZdQtVjBGY4pqHHhmjYw6Z5wTCeni9YI9msQ/WN56hFJUOt4dUTriD2HAx7qPTLVgEmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXVITtHJLhIo7t98JALwfyWCcKuka8fmWxF/0b6JWhBoU7vjr
	fSJkKIqBCEcT/8M0Ig72AF5q397Fn/ok3z/mKNUx+hwjFzef02tpuuDaX8pUH3kESg==
X-Gm-Gg: ASbGncu2pQktdmIGF0q/0aZps54BxuxB7ZSpySLHXfxuySZ4SR0EuKEO9Vjg2iNgfBy
	FFNpvGHoINllCB2OWShke4a/bIp1l08xe+aGt3v9mxRH6kTSQr35AkyjsgnQA+JWRLkjnDVY69b
	MiquHTFvvmQ6EzK5+Ivpo3+uLIao6ohPxSnMU2+AhLpKvf7nZ9PuouBCD4XNVyLbI+bHCBtJmME
	yEFAQnRkRNST3NH9+T03i/1KxYSGWAVSzBjgZyjhC0UA9F8QhyS9nr4rTByxjULiUcRlxuM1kdS
	XkhrfPrkiMGlxSZR+cBSJEfop2CsyAItv5nuvEkHSGPw6TNsHqeIsKjxGRDReHwWJUkhiFK4pSe
	KuUEJEKeIK1cJCsEhQiR/I7SotVZT6LwWfZpC6NV/eGyM3Fzcw8iyuZYskuwv6YO8Ej4sOVm3Qd
	odTKMeYodE8PkqOqPwTkvDrNfUFnQ+5ReKSfKepQGKCyMP
X-Google-Smtp-Source: AGHT+IG32aKEvMqQdCicoH1rwzi9rTqB/3kzHLOxoWRLdvRJmMsuPKuV9j72408kyB6QWaxlgj5D/A==
X-Received: by 2002:a17:902:e547:b0:25b:ce96:7109 with SMTP id d9443c01a7336-292de616a3bmr863795ad.3.1761004558570;
        Mon, 20 Oct 2025 16:55:58 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8090csm9243673a91.18.2025.10.20.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:55:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:55:53 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in
 VFIO selftests
Message-ID: <20251020235553.GD648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-19-vipinsh@google.com>
 <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>

On 2025-10-20 13:50:45, David Matlack wrote:
> On Fri, Oct 17, 2025 at 5:07 PM Vipin Sharma <vipinsh@google.com> wrote:
> 
> > +TEST_GEN_ALL_PROGS := $(TEST_GEN_PROGS)
> > +TEST_GEN_ALL_PROGS += $(TEST_GEN_PROGS_EXTENDED)
> 
> The TEST_GEN_PROGS_EXTENDED support should go in the commit that first
> needs them, or in their own commit.

Yeah, this can be extracted out from this commit.

