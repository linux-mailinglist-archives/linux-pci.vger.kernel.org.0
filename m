Return-Path: <linux-pci+bounces-1728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6847825E43
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 06:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DD284260
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7515A8;
	Sat,  6 Jan 2024 05:03:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC91FAA
	for <linux-pci@vger.kernel.org>; Sat,  6 Jan 2024 05:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7fdde8b54so11264939f.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Jan 2024 21:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704517430; x=1705122230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KdBULEAMakZFG/ZFdoGEm3uHxazCJ1vKCP8DxwNjQM=;
        b=POum1q3uDNkz0t5UW0LC/0B7+BvPOYyNlWIMj2kpT3ia4t1HXdpVslpc4957JdN69M
         c5vZPeqgxe1IJ1WqhR3ZqbI+ruqYfoicE5bP+w/U+8+IObLlMWvJjcGcB0VUWJGUxirD
         pCAwA58DRde540yCB4ijbFlfwDftOSwKZHe7Y276bptS/QalTwzF+Sny4TvUtNrZNUfK
         Y8Pqsy2L0a4i28J/DTkP/OZcEZ//avsyvqNNwAV0/XDiI85KkbNHJ31QnMnNYcy7akw/
         Goo1x4sgfcvBrJKrKWlPyPJLEo/6tJ6KVf5+3Rwe2NCEMP6T2aHH/klhiSgrayed9WNP
         VDhw==
X-Gm-Message-State: AOJu0YyxN1NtUYRStVg0bQi1KSO5rtMKkRjJCPG/eAq1MWWtjsmP4qio
	jF7bWPwKerMbXXqzuhCZd3s=
X-Google-Smtp-Source: AGHT+IGQrq8IInb7oJHfadJzynuQfVBluI8XpfNPiYgz+hWf4TehAKMsnGub2hYSEEVRjn2DMTw3NA==
X-Received: by 2002:a05:6e02:1489:b0:360:8033:e948 with SMTP id n9-20020a056e02148900b003608033e948mr378552ilk.10.1704517430009;
        Fri, 05 Jan 2024 21:03:50 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902e9d400b001d3f056bd65sm2208985plk.191.2024.01.05.21.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:03:49 -0800 (PST)
Date: Sat, 6 Jan 2024 14:03:48 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <nks@flawful.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use a unique test pattern for
 each BAR
Message-ID: <20240106050348.GB1227754@rocinante>
References: <20231215105952.1531683-1-nks@flawful.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215105952.1531683-1-nks@flawful.org>

Hello,

> Use a unique test pattern for each BAR in. This makes it easier to
> detect/debug address translation issues, since a developer can dump
> the backing memory on the EP side, using e.g. devmem, to verify that
> the address translation for each BAR is actually correct.

Applied to misc, thank you!

[1/1] misc: pci_endpoint_test: Use a unique test pattern for each BAR
      https://git.kernel.org/pci/pci/c/516f366434e1

	Krzysztof

