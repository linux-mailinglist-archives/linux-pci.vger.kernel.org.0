Return-Path: <linux-pci+bounces-12879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086396EAE7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4224285155
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4C13E3EF;
	Fri,  6 Sep 2024 06:45:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691132C8E;
	Fri,  6 Sep 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605137; cv=none; b=fT0A0xbu5qRE8XW8XwzMA2ouAKyFYE4HQBtfvoW4DwKatQMDP8NZ1UvOOAr9sIgyCROQPX51Rwqpuqrr6NHSEZgId7qIT593zJLMYIxjcuDNut2OgH0Ovqq5pCC9WZe60ksWuJWKfSTN8PPX85zX3IKz2vZvHLbC11zuRHLdKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605137; c=relaxed/simple;
	bh=uYjOGa3VtGMRrhghkKk2iPbeHSLdyHnO9YTPtcNX96g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+JwIBAD4EfDjctbfCU219LaHJWGgPIOLWAc7bO+8ct/EGJQkAQI6GNpZvOix26N/3YYA2SnlbUM3nxIpggkpI7iV3Q84IdEyTcE10wcO/O+aGQMuo4a2JCbAhTxMwL9GY39X8Q8GS7wgEjrhQVlB+ML95SE1LOL606M8b7Vu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df121f7088so1131192b6e.2;
        Thu, 05 Sep 2024 23:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605122; x=1726209922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T85lsqg22tVtMmtXn3JYYmM/q9PNsgafh749qOHSM4=;
        b=BgjymSMvEjCs7QDuw66mvgVIr9e4wwjK0IN9WfIttq1l5USRECvggQb4g3oRlDGHDo
         fDD258uXyA8BGveviZhR6TPlPxow8p8ckq1x+IYM3O0d9YF5Wp2jlGebU+2ZzdlAFSxy
         hqf9pFD4kVB9cMcN089m/yf+0e66l1rO/hgRC33BfQJxs2k4t2DKe93DrIOF0O3UPctK
         a6o2CiBuygVkPr2itbQeafO4KfF3f5iV1SqgTTxmTxicwGAQh3KI4mLAGdH//leiqjCo
         XIebHjxIirwrTTeNa2FC+SiLdxsfpqbRi5yBHmDIO6RBaykEXiXTxKuv1//M+kotLoLl
         2XGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm+hAb5a4bVOfMCBJtdsrx/Leq+DbqaRpJBx/DVEVGdOL/r5YsbTk8hqb/yJdLogm7bXVw4r1uTiZjpB2m@vger.kernel.org, AJvYcCWHmEXgp04/zCa/6+9UMtOyJQjaLy6ptuIjyJpfQxznmUD7sEMhsAki66frnkxz00ByxtFZo59Cy+1+@vger.kernel.org, AJvYcCX0zsghh/5wBV0/axfevLM42gjVvlSyiyCXjzyQfZyESY/LHRQHN5TW3o7JGZY1gyD7UlLqCL8Jli6NKLx1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8EySr6QAy5gaOFBoepQALBlI75pwSWr7c/LLFxaM1rQj4KoD
	P1jRsnRUHlML4e/7d5Kkhcni54o4WH442WZ1kygkuzUx59YWwV2bjnj8viC03vs=
X-Google-Smtp-Source: AGHT+IFNkKQb3Z8RcOSTqku7m1PX+2hNBRQaN7GSD9zVi7VDsJEB42s1cVtz6dMANyxBgwovd7aRyA==
X-Received: by 2002:a05:6808:2022:b0:3e0:1222:b1b8 with SMTP id 5614622812f47-3e02a031e36mr2394426b6e.38.1725605121941;
        Thu, 05 Sep 2024 23:45:21 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbda7b5csm4331241a12.70.2024.09.05.23.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:45:21 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:45:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
Cc: bhelgaas@google.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: Add ACS quirk for Qualcomm SA8775P
Message-ID: <20240906064519.GD679795@rocinante>
References: <20240906052228.1829485-1-quic_skananth@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906052228.1829485-1-quic_skananth@quicinc.com>

Hello,

> The Qualcomm SA8775P root ports don't advertise an ACS capability, but they
> do provide ACS-like features to disable peer transactions and validate bus
> numbers in requests.
> 
> Add an ACS quirk for the SA8775P.

Applied to quirks, thank you!

[1/1] PCI: Add ACS quirk for Qualcomm SA8775P
      https://git.kernel.org/pci/pci/c/026f84d3fa62

	Krzysztof

