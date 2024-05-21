Return-Path: <linux-pci+bounces-7721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F638CB0BA
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E3A1F23890
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F407EF02;
	Tue, 21 May 2024 14:50:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AC762E0;
	Tue, 21 May 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303007; cv=none; b=q6DlGYAxerBE+cDdCTAWNzOk3qqw7QZtVhcAMSzo4Z+wI2sYSdq2P0aP+GhDaMX4bT0VIOgzbdaXN8W/hRlVvKqmcoGOnxqlfLsYmaWWEH+1I6Lk/T9dA4JKzZcOIcDaO1/xP/jDz9WUHq4oN4Gv2gzj0C8OzJzywELq4Dh18D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303007; c=relaxed/simple;
	bh=pebubPRPXXfyFCR8L7jtLdsUm4lQUmAXpv6njO/hTno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9pc6b1jjKhh9qU3YfPTCB06O4mcHk/ahpg7XL5LjGjo9xEadijKuR7atklEAR2ddnn3TWwoo6g+ecT9+TmjPDzrpose1bQOhywAVc8dxHnDxlEi4pUyqSh50luYXaIGDmHMDqYSYPTm/AVJdmf62PRpRWBwtBlAFcsLdtynv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecd9a81966so1819115ad.0;
        Tue, 21 May 2024 07:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303006; x=1716907806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwzjLH40P8V9E/pVlXPrZq55s5peR2Op7oBzdA+LPLM=;
        b=bFKIQhh9Blu3TXGfUt9PmCzf/dn4x2nNzF2u2SLZqMER6xXB6Dg55xmCUR+ezlnP0C
         3IleKloWBMW1EvbgZ/vk3xFwEfA/z+26ab/5GP3EKz7cv9xKhd6PtnRhb6N22cyEBCNP
         EVYSb/8z/s3krblL54nVSHnH9L24xu0maPyngqcg2ndG0kSCk9YBztHfhH/+oWpyy7bu
         CW300XjtB3UJSebyfWHoTXVu6t2BczOACimUxfkdLz6WJMba6J67RpcnOoTTJdfCWBYO
         N9c7YoE+dt+tbASwRfBodT8Cr2SUI5V/S51jg7QjZr3WWudiYspfoi2y4Jm/WBQI9i+B
         dqEw==
X-Forwarded-Encrypted: i=1; AJvYcCWNJRugNOTGS1XwT8jNxzUuuCeaD+wwVlB24bnBjX+uvRYWk0x/QUshZ60wtKMy5D6kG0vOH6Fz06jLP0i+6U0dhGXhHdojgreublpWaOQFQnwtrH7xA+azDSmiNJ08XXM0G1lIjM8W
X-Gm-Message-State: AOJu0Yy7akPTyi9fx18kOmykoKQ6h1+qX6UTotxgqd4INlvI1MDCbDB3
	V+VwoSRyi+FpgyiA3SPwDBXL2DGfNEZHK6/dzAE5uoY683ZOG9YO
X-Google-Smtp-Source: AGHT+IFqkbX9fcM93qNGYYELn9oB3kXdWgI0rAcxzTUvgY0Z1FuwpiabK9+9x9fAXjhm7RJagNFfkw==
X-Received: by 2002:a17:902:f78a:b0:1f3:14c:c2c5 with SMTP id d9443c01a7336-1f3014cc5cfmr75332335ad.31.1716303005705;
        Tue, 21 May 2024 07:50:05 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2f9878c3fsm45998555ad.30.2024.05.21.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:50:05 -0700 (PDT)
Date: Tue, 21 May 2024 23:50:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	bhelgaas@google.com, mani@kernel.org, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240521145003.GA241395@rocinante>
References: <20240521141431.GA25673@bhelgaas>
 <b7a5e9c2-d2b3-4c99-8628-f48581f5d1ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a5e9c2-d2b3-4c99-8628-f48581f5d1ad@kernel.org>

Hello,

[...]
> It would be great if going forward, a more timely processing & applying
> of reviewed patches happened. Thank you.

Agreed. I will see about improving this going forward. Sorry for troubles!

	Krzysztof

