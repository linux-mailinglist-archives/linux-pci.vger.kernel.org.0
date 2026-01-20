Return-Path: <linux-pci+bounces-45286-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFv+I5uxb2nMKgAAu9opvQ
	(envelope-from <linux-pci+bounces-45286-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:47:23 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24F47E91
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50C80824D7A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150242981C;
	Tue, 20 Jan 2026 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6zSmUBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372B466B50
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925516; cv=pass; b=smIQlANE0KrL2fV5gwFqJbKZHYICy/+qDodbBW9YkdJR7BgjstKuMfLyWT+AfHx/sSe3Vt++zly4WT/1oDeuO93k/aYo6g6mp+NEvCT8bL3jmTPl3LNxkWRvuHV2pX8pouohD0oaNoTjOX25rQ4+SZ+gby354DD44xE0XN/dXWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925516; c=relaxed/simple;
	bh=O1jzOusIB3PPgFNUk1IyhqGT9JHdCnGfwYziQOVYaHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVbFfPyPPHl6yv3fls7rbsre5RoK7P3oYz/HYsNZeCACRILKqgNogju7dbLM+ecFH8xMAPoX+0RwUJYkz59gcabEF3pYlBYrwXeeGwTz4T/+drtnx2MPbzVJO34xtSIEC+u6l1bzn6Q1y9K/LJUi/9udJP7ZzjtFqPstPzCG4BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6zSmUBv; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6c1ec0dd6so380921eec.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 08:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768925514; cv=none;
        d=google.com; s=arc-20240605;
        b=FY06AmjI1WfHh9p+aBR3axG74df+vsLbrZs8LNGjlcNX+DRzS0XRutC6mi8T7do1G7
         k6nNNueEJiB9i/eC8RyiJ7odDQA3weOIfRMKjBhy7f4EIIv7EkanAhA4JB/KcTyuszwO
         tArB+aEeNZbnphfGqRMrE0Hv8AZOLA0YIiBOLjwXECU4jATVYCgejdRKUqHBMuJsm83T
         JWfN2VC5xFmIkOKs+sIZUevMn4vIzGu8hYjNBsyjTATnA1YFh+u5cdyodTYcHUJp1EaF
         UiRHkeZ7TvynCX97TONizlFLyhAIo66xi3XWQfLJ8anz+/6QFPpk1OBGmAHaT+ZZgIBp
         PbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O1jzOusIB3PPgFNUk1IyhqGT9JHdCnGfwYziQOVYaHU=;
        fh=04UKnQUDAJJdtCGfZK5W3OCjuqFTNbAW+49wSUozMQA=;
        b=h9KrKAVsZmSccX7aD7ZA2EZUoCm3HgEbNd4Viq5fG9HVVssb9+5TgHN9fLIRhO1lTR
         xqBevNbYldVeflWyEcPWBFayNTnCbhgyLWyvzh5LnTJsuV5N8xu7hGjsL45u7ofh4GFV
         0lH6ktphzR0SVJw3splj16/qWCZHtKCtgNpJNqdEYrE1I8Jlzu4IJnX6acBBeMhXcqfW
         t9rnVwT+albevbehbWstp8d2aSgO5z2diXy8tryPseHmrxOFAp1qsNTtAe8VbAl+goDC
         AScGGbHvSqBiG4hatVY4Xx7WUVcFufnsWzLyOPLYL6GLLl4gfwsAvci62P03d63LSl79
         ECFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925514; x=1769530314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1jzOusIB3PPgFNUk1IyhqGT9JHdCnGfwYziQOVYaHU=;
        b=L6zSmUBvw9C0t656TBuaQjgqlxpLRYBUYY3MyMbTAbp1sU5eriK2FBnJubqEK2MPrJ
         N4R/NWEKp2XxQSOCtAhW1U1fHNquhcwcSLq0Hr8WKmmtLBlZ8bzpm4BAI2LLElY318+8
         iZaxyFaV6238K4+iZkNumy25GRO/iTq9KVXn3p2t3llOX2iRGtb+aIyYLC/pf7fkBrw5
         6wG6oIyQzJnru8jlMClLKjL++tAGzeGNg9e840I0zMzlvgCCIR/GFBDT7XvjcBqwW1I0
         cRkszYpjU+omTc7NHPQYDmkLm5IbtnY5C2XMcGsdefHipBYWiQJZWbi0clDRM/G6xRbZ
         DOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925514; x=1769530314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1jzOusIB3PPgFNUk1IyhqGT9JHdCnGfwYziQOVYaHU=;
        b=GslkKQg9IYAa605Xh43MQOUwGf0Z6ceEqIYjfqWoE9dsey6gWlYXTDNwGd5+io/gV5
         Ie+DEMoibIa40kCVEsJEH6B5q7rUco8gEQMDv9Ne9HSaFkG1T+FrnkLf+K5uvEX2bJK8
         0Djg9h/R1tCL4arGgQuU85z2lDzbJFRnEJVTj4pu54v8CMv1m+JxmmRB+czy8ujZg8dP
         8e5+nVXOgl5Fbj/OUWGM/IyZwuT0XDvWrsf/PKMmWWgkXrMOA0QpjOl8d6bv6Nzh08Fu
         zY8QvDEmrtxKat/toZ+mMg6NsX1zZDCWOGO7o0BdLmm5iN0dq0iR1FyA3uo1gFN0FH/X
         2eiw==
X-Forwarded-Encrypted: i=1; AJvYcCWhQFc/gqS4KUEmBmNOA3cpW7O+M05H9aBrfKXhTFSecbqfqcCsXJDR51bcGkmUyEsan83I7B55BLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBI9NEfqfPP/9keaGsd0OGCzkXkJSWZAJzsqJ8ziauK9SFXal7
	VkbdpPi+GI2Zx4BK+4WIDusuJxJLQFOlbyJBbj3e2drf8O3OV38i1Y35dLnz8GEkENc8gvCWDkU
	8HxLZKxJn5Bui1eH1B8RoE0SvjdTh+M8=
X-Gm-Gg: AZuq6aJicwPjFsac6hc/aUX1jGTOnkm/ZaWGIc3ApBLcrcd0993OUgzQHbUE6B2jMPr
	tqOfuXwC2UP6do/HEmkjT8D1OWBI8ZLLRw8gzbCYORcf4Cm8YP2wo5rctVtzz87iQI3auYd9A8g
	A/ExiNw9ZTm6nskD3zTknW+fvcEZr2o2nnPFevMiX+wCKPV8Uud1Gmi64GTA475AhmsOhQsMJpE
	54EBrpsSnOY2uZYVh4Ly630za8d9CjwDGrzZGY3F0Gy8nsvXXjr2/YYJOCJt6Ew9tjLH4NWGRPi
	3a6+p0gxIuFH8+GaG4B78CSVXIRGYM3ku/ctSPzDoG2JKXBKYFP/sBxC+GGKbgFlpTshS7yZa/X
	WcEHiDJ9V0RFGY+kv/mctV+4=
X-Received: by 2002:a05:7301:3f19:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b6b380ec55mr6080484eec.0.1768925512626; Tue, 20 Jan 2026
 08:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119202250.870588-1-zhiw@nvidia.com> <20260119202250.870588-2-zhiw@nvidia.com>
In-Reply-To: <20260119202250.870588-2-zhiw@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Jan 2026 17:11:38 +0100
X-Gm-Features: AZwV_QggfPIWsDWcZumvkaBtyp05_PTGQ6lAyDvY0iGxNwqiMAiNarRoaWfcXUQ
Message-ID: <CANiq72kL9xwT-wdyGNpekmnXioUhwLjcayE_pkmKEEw+RDCyrg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: devres: style for imports
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org, 
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45286-lists,linux-pci=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,posteo.de,nvidia.com,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pci@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nvidia.com:email,garyguo.net:email]
X-Rspamd-Queue-Id: 8B24F47E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 9:23=E2=80=AFPM Zhi Wang <zhiw@nvidia.com> wrote:
>
> Convert all imports in the devres to use "kernel vertical" style.
>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

This looks fine, thanks!

(Not sure why the Cc:s are explicit here but, by the way, perhaps you
may want to use the `.mailmap` if you have some automation so that you
use e.g. my ojeda@kernel.org one instead).

Cheers,
Miguel

