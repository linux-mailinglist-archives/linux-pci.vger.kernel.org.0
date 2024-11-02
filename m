Return-Path: <linux-pci+bounces-15828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A99B9F3F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A5DB20E5A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B08146D55;
	Sat,  2 Nov 2024 11:18:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072BA930
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730546280; cv=none; b=imkvRrX8/ALYoSeeQFXPgz+Vf0rSM3EFsDI9lJk4gR6LlDHfmwz9YO/znfGPJi31f3/48hX1YEhMgQerPmHKAK/977BrCK01XL7CM+6TaPk9bfHqFXq/SUn/gm95Q8ZvCbw0WClHuSLEh081VlrUza4A6ZByFvHw9JoKaIC05ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730546280; c=relaxed/simple;
	bh=DHWA/6/2bB/IbAeLytz8NAz+CitW0d9cz1D43PT4RmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L04Cup4lvdL4CYZb7nBAqEv4NXBtksbt6pyLGh7puSc4bJ2s1WwlXrlTt8rU1sgDOp6AA9lYkNGO7tK61b2c4QR+gzXKxxvVfER9HXG0mN5jAP+fAixQYVEqBE/sQOBc7IpdNwdsANE5c4Rckzz3swQLoBK/uguL4WS66rxXowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce65c8e13so30928235ad.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 04:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730546278; x=1731151078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj38cZ9DR25TtBKwa0Dcnl2IatuLosA+YIf+pRL+mNU=;
        b=eqni9U/J4hgx60H5f8XA1XZOdVC/lN92CoR32LLEndug7dclFkVQC+97c2IOlWOJeh
         RVCXQ6IKdzJiuzh4DdarbLbkEZ0EqO5NUlcxs1RL+N8SSyARUl/HDEUuBIvYJZxJj+HK
         umvFH+cNGzitxBVglR9L6ZXTJ6UDfHx8LwIHQ442E3wacBjPgL/8O7FcKZbfJeUx91C8
         c5BMgalq/xNzOobUUplDpcD8MCUGAnQHQaW2y9j6dR4UstLL6uIC+eSjgeQaGg/HbAH/
         X57p88nHtaLbsxk13cY0JTSo0QsTey9aUjHG/tmHBaFlFvCxrh7dff+4lh3lZ3FjqM7Y
         d0ig==
X-Forwarded-Encrypted: i=1; AJvYcCURBv90QMPrBVRlk0h21c5kg0LHNFh7RTLSM2QRVSEXzgj0lUEnogj5nh1yVzVBwpJIPT9+b56343s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42x3nWXJ1iCKjO6jIcO1BUtI9mT9MdumLrlbxWepQNugz1EpZ
	XvviYJTm1aqYK0+QkF+JYwdHeJZlYDaLajjwmZSfoNpPla1RLeDi
X-Google-Smtp-Source: AGHT+IEPyqyksbS/80VWyCQYHJqXt6RzUcs5OyIAOpuVZCYnYBqfES1Q5kGTdT/IjdjK22lQdEOVtA==
X-Received: by 2002:a17:903:41cc:b0:20c:e5b5:608a with SMTP id d9443c01a7336-21103aaa903mr137108745ad.5.1730546278133;
        Sat, 02 Nov 2024 04:17:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac966sm4113359a91.17.2024.11.02.04.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:17:57 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:17:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: test: Synchronously cancel command
 handler work
Message-ID: <20241102111755.GA2260768@rocinante>
References: <20241017010648.189889-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017010648.189889-1-dlemoal@kernel.org>

Hello,

> Use cancel_delayed_work_sync() in pci_epf_test_epc_deinit() to ensure
> that the command handler is really stopped before proceeding with DMA
> and BAR cleanup.
> 
> The same change is also done in pci_epf_test_link_down() to ensure that
> the link down handling completes with the command handler fully stopped.

Applied to endpoint, thank you!

[1/1] PCI: endpoint: test: Synchronously cancel command handler work
      https://git.kernel.org/pci/pci/c/7a48655d2bf2

	Krzysztof

