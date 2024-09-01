Return-Path: <linux-pci+bounces-12574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C7967B69
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 19:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B5D1C21536
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340126AE8;
	Sun,  1 Sep 2024 17:13:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975713CF7E
	for <linux-pci@vger.kernel.org>; Sun,  1 Sep 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210822; cv=none; b=ErZ+h8H/2GDIwckUlTYq5/+uG6SWsEDIBr/tCcpw8tACQA+bbWvhMrNE6K6wPTcGr/QVM7YqpnAs4nnnSk/3W+kGavjMtXLqSXEUi9B0/tcyLmi27ZiaNe29K9j/QQ7SaMcHt83j4YLodevsOW2LzFnvkHePzdC1P+yoHIhqbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210822; c=relaxed/simple;
	bh=aI0f2fAz/6TYD3DDIEYA9bvKgHyznDDUrkGxLohYyD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZihUZWaqRX7jJysfi5acbWk8p8KPoEnIwWQvNAUGSkyvAqV39PMh5R12JOq1O7sOCyJp4Kpz5EKLkCLkUU/lhZHc4L9/Adp2tcpH36Kmr2ytuFzv2GLp9tuHlq/C9NKAT+HHujtO0VOtewH+SRvLFHdz++h/S1rIAxPXwUxvm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70f6cb5518aso1350301a34.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Sep 2024 10:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725210819; x=1725815619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udZCDLpkLoysDsv8bzL4lK0pqWLZ/ZgFZZAPSS0ubQs=;
        b=jyIfVBYNpQIzC8QEVtBQoCfCGk/x7XDt7/lWQAEqz/UjSTQGMdiENVVyhbdIAchcxp
         szrR+4HTzfvzEVrovpYKPm8mkRPAUgwCl5kOkowcD006X1gweNC+o/ZDXQ66h52EQElh
         CbwOSafyxpiHETtz28t+H1CN5TPteyMbcl8gdk+iBX1vHdVCCcCC/ARalYXzhfJwMngS
         OfdGuNk9uDNXqC5briNN4ayvjGSUStwRibcTki0n6qWpZHEZ+wGAXn/qNZUor9u3PvnK
         ysd9gN/WHsP0AkX9bXpOfp+UZyIm8TURKqyqeHKiKxOyDE0ZXe1w9q87c8dIAXzvs+98
         h1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV+2cb7ArwyG8E6Rim5X+qNDdP6IONHy5TMfeoqHHVKJLAopJ+uBO0YVngpcJMeRZ+LN1vyY4wcLm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAUZ0NQ3HzoVeWKCZMfHO2Z3VMhnnCUqvTyMFOrYXPBJjILOL
	A08YQ+zPaVkM1oVfkdvn9KZaMckoQE3Uq6TAtg65/9T6VBk7glRL
X-Google-Smtp-Source: AGHT+IH6SnD1D60UTyCrfPYsX5I9NZbCcC5qUTlZK9Z4wjafpupTzHc9/5gx8wX88w8OASdcbJyRnw==
X-Received: by 2002:a05:6359:4ca4:b0:1ad:1119:6f03 with SMTP id e5c5f4694b2df-1b7f1b1aebbmr663644555d.21.1725210819628;
        Sun, 01 Sep 2024 10:13:39 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e557720bsm5538392b3a.26.2024.09.01.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:13:39 -0700 (PDT)
Date: Mon, 2 Sep 2024 02:13:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH -next v2] PCI/AER: Use PCI_DEVID() macro to simplify the
 code
Message-ID: <20240901171337.GJ235729@rocinante>
References: <20240829022435.4145181-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829022435.4145181-1-ruanjinjie@huawei.com>

Hello,

> The macro PCI_DEVID() can be used instead of compose it manually.

Applied to aer, thank you!

[1/1] PCI/AER: Use PCI_DEVID() macro in aer_inject()
      https://git.kernel.org/pci/pci/c/3ee1a6b5d78f

	Krzysztof

