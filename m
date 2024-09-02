Return-Path: <linux-pci+bounces-12626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D6968CD6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 19:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B963CB220AE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAF1A2644;
	Mon,  2 Sep 2024 17:28:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FD183CBB
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298104; cv=none; b=MrfYiRKPVyO8drBfZFmNiSIRA+j4+tW2TppskmvNIYg58vV2xdZyEWu+ii8reJXXYzwpDarolta4siWjshp3PS3GOD6/jroMePV6LenhiDvcc5CziS6HDYSrLXGECggkY5NBX/HUNJzl1BIt1D/PI7MJr68i9eYC4c/rzZ8Qckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298104; c=relaxed/simple;
	bh=LNKpjAT9Gv0eJYWkLvsXPQSWe1AaxSC0PptmmV3rw6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvRCVuJ7lzFB5NCWoxFZC/v7fVWODIho1aIOnjuj7lOBMbVtBn95g2dKjApt9jfPBi5sMuiQEAdq8g8wWwTRrZwOV1ZpWVM6s6qUwq5vi+WlUXPAPD12QqD1XM4SweshoGH1ARricj21peX77K8a23J1C5916e7XJs0kHIGD9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so2805000a12.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 10:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298103; x=1725902903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWqWhs6usCxuz7E4T8BhULRvd210SVaUJekXNRRzRws=;
        b=WYfga4Cxha0pYQQxh925hzN+WYK+ZnvC73AKVeVOQIKIUIVEyDbCRWaY+Vs/5ORk+k
         opWIcAxM7qyRLQhssPikjfWeoLqbRD/b1x1Gv7M7MVqK2T/6hfkfP2bs4UQG//WYDMN2
         GqAbfkqCe3sf0QCnIiqsmlPchYekLoMtD7136s+IwZCR++EjRlbthWnuzUKf3P9pMspE
         0VprsFaGYxmzjFYb/H1V3Htqg0WUYBkYj7Ba4GQCDJ+Hp9o0OxdltZuh4kJG58kQj1D2
         J1E6YFSQgadfwo+xAColXsWk7qS+/zbmklrujtqFs1hGQlI06M4KaWGnagOqK/CCdkaP
         MpCQ==
X-Gm-Message-State: AOJu0YwNMl9zDNRpXkhYihLbXZwLJMJGBvz3sKOoOaoo5OPHVkCiBIuk
	+nEBthjDHxl8l+vgmlG+OxZSBJf5Wszn9YwJLFDJsxMihScq5DPbbpVRmxssQ0M=
X-Google-Smtp-Source: AGHT+IHtUaNd/pBQ9TsbphZ5p7Y5rgp4bKTZuOpAgmncyxPFKiwpbRJ+3Ke1zf2QQmiHaVkDn9EUcQ==
X-Received: by 2002:a05:6a20:b40a:b0:1ce:f77a:67d4 with SMTP id adf61e73a8af0-1cef77a69e6mr506945637.6.1725298102579;
        Mon, 02 Sep 2024 10:28:22 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576c9bsm7092384b3a.24.2024.09.02.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:28:22 -0700 (PDT)
Date: Tue, 3 Sep 2024 02:28:20 +0900
From: 'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH v1] Export PBEC Data register into sysfs
Message-ID: <20240902172820.GB1912681@rocinante>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
 <20240710110519.GA3949574@rocinante>
 <OSAPR01MB718231921A414BE66FDFA555BAA22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB71825F612653E9893662C789BA962@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSAPR01MB71825F612653E9893662C789BA962@OSAPR01MB7182.jpnprd01.prod.outlook.com>

Kobayashi-san,

[...]
> Please let me know if there is anything I should do to get this feature merged.
> I'd appreciate it if you could take a look when you have a chance. 
> I'm happy to answer any questions you might have.

To get your change merged, what you need to do, would be to:

  - Address review comments from me and from Bjorn
  - Send a new patch that is not an RFC one

Once you send a new version, we need to allow others a little bit of time
to review your patch.

Meanwhile, let us know if there is anything else you would need help with.

	Krzysztof

