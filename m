Return-Path: <linux-pci+bounces-22949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF08AA4F7B6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033F516F300
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A831EA7C3;
	Wed,  5 Mar 2025 07:14:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157433993;
	Wed,  5 Mar 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158874; cv=none; b=EIZLVTExBNrvWxV7VYGD4c4LkJzMj8b7NjFIWNF5heS4DXKD8yRWvEoDoG0Iz3Kv6MejEUFa5onPFjJZdtvncNofW0fsdtEjsDyMxBFrYa8GyVjBqfk4EUR73KgD6DWF33LSEHfBYZgRMCnP4wTXhS8MFmkz+XXXixFY3iYNBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158874; c=relaxed/simple;
	bh=SQ6LjtibRZusomOEhTDVhNlZ3tr9i+EtD6bCbW9qTTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYVxgDIffxAdougAydyXQY3r5f4laAdraE8TzqQvlFgBEDLyMSeEPVuCnLZ4W96hYaiCijS6iC3mTytfZ9m0BzR7VoS8K0IP4u6rL3KaeMEr7fNK8wb8CfKcRRMOW8bNtgyxog4F5WdyVRjbEIxvTZXehFmcGvsb2us9njCvwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223480ea43aso161232335ad.1;
        Tue, 04 Mar 2025 23:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741158872; x=1741763672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHSxE97Z/19fRfnaBRW98qLuvS9sZYnITb+wBOsP0To=;
        b=KFDC3jXc0ImnhTXl50dLh33qUO1uDLDf1uwGpkeBRjRdwE8s4Pb6VS9GMemlr3UXk/
         fE0BnZmAwj7s0KtpNK+/qMV2BcYRY7/Owyfzp4LMcRV6+L1Ec5CxFAwRKScPZZ1btQDF
         FOAGBZenAd/l4hDiHQ9X/sEs1hoCPbmsD5IGFNnXQjc+tWhBPQTtvd+QoknLA4c6RPpB
         mKOQdmTg7fU6YIRqUTrf/HZ/ROnR0zNtS8msXzAJxmdXYkmqT/VjiHxkt7kuDsjxg00d
         t96JaHh7XDfyS0LF/UhwhfEmFcsS+BpBd2l5kYb48WMX1Pb6UEVfR/8nFwiNMIvV6LXx
         BFgw==
X-Forwarded-Encrypted: i=1; AJvYcCWIZ510Ye2KUs3F1Hv68n4N5Kc6/6XQj8MNOlcJkXWKmXda5CCqzktSMUejk4Mcdy4S/IbK5nVz2146ZuQ=@vger.kernel.org, AJvYcCWnauXSLRG+2U66zHjjqwGO+OajJQQ1ruOuU6VLDmuCGy3B/tJX81AXuZcjaXNTzWGcD+LSvVuTR3Gq@vger.kernel.org
X-Gm-Message-State: AOJu0YxULqoGM1HXHTZDHYlqjacsakT7ox26ZpBjOP1Us4bSI8QWrUcz
	Ik0iSebMJ9MSQAL1B0cHo9SDCWHC8UALSWbaFsgWc50Nx9smGusa
X-Gm-Gg: ASbGncvw210nhwSjm7zQ7zB6c82Sq1enPner8Q5LF1782I+hxce9zWNzu7rquQJtshT
	FGmckhNsjPKDQBtwYfYadOJDmXf4JiCRxJJ6pFpk8lbYvZXdToe+ouMaKhU/dD3D7lN8/SZZgfD
	K0uTnuKBh5bPMU2z085OfPDGGWBp/ZvqmC0uo1YIxTNmZSGzom7B+qXQc4KJj6fqT8ZFSCYwtAk
	JuopN/BgMNJRZunfUy9qBEKMvfIP0iGyjEdi138fbLXU0Y5F8yul0EcVQm3mIvHzrtlYb/y/xek
	goUrT2koOTlPNXJPQK4CBBU1YFgH6fKPXs47SC32brGFQyv35yT4CrTDCjtENATssc7ma+Mwg+C
	HhdQ=
X-Google-Smtp-Source: AGHT+IFjwJnf4pYdKy9H+Sj318w3civ3R8+DUQqlTLpVZsAp4jFdqVYT+jVun/KKKaDFmZwvXFvu6A==
X-Received: by 2002:a05:6a00:b81:b0:730:8a5b:6e61 with SMTP id d2e1a72fcca58-73682b4b1dbmr3263549b3a.2.1741158872158;
        Tue, 04 Mar 2025 23:14:32 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7363b7d81b3sm7894587b3a.53.2025.03.04.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:14:31 -0800 (PST)
Date: Wed, 5 Mar 2025 16:14:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: phasta@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: Re: [PATCH] PCI: Check BAR index for validity
Message-ID: <20250305071430.GA847772@rocinante>
References: <20250304143112.104190-2-phasta@kernel.org>
 <d667d29337c49ebebb82d69b12bd48cad66ce595.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d667d29337c49ebebb82d69b12bd48cad66ce595.camel@mailbox.org>

Hello,

[...]
> Shall I send a v2 or do you want to rebase, Bjorn?

If the changes are relatively small, then you can send a patch top be
applied atop the existing branch.  I will squash things as needed.

Otherwise, a v2.

> sry bout that.

No worries.  Things happen.  We can fix everything. :)

	Krzysztof

