Return-Path: <linux-pci+bounces-1575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C6820B3F
	for <lists+linux-pci@lfdr.de>; Sun, 31 Dec 2023 12:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2DB2125F
	for <lists+linux-pci@lfdr.de>; Sun, 31 Dec 2023 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CDF2912;
	Sun, 31 Dec 2023 11:16:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F633CE;
	Sun, 31 Dec 2023 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35fb39c9dcaso39163945ab.2;
        Sun, 31 Dec 2023 03:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704021380; x=1704626180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lby5rzLuabhsbP8Jvy/Jxkwv1FaYTFRWsxYr40y8cBM=;
        b=I/VR5k681BuszbbHoQkyvByfVPEYeghrk7kWIyQ2KH32elXcXiavoR6G/3q91V6MPL
         1fHGZF5TVOXZbLgXBdrl0BNcGFfMrXx+ltmAk2JR/dP7iyg5P5zYTmrVlReYZJJcxnUe
         XizEYy0Mzg+5J/Cqgt4kY45Sp5aLEaRJiCbKOKsI7OTowdMw514RYLqin5oe7HLTJS5d
         7cJfnavdZOCJUHMSPX/xUdhpOMgeuHovJah8C5Lysvaem8LKd8ir9oj3nZb4q7/CqEmo
         XVHRem7PDEzNxNFqsX5M/x7AzuTSKLRshkLB8kAS46Oi1IXMgtyHWS6IPPo4ocmX+aH8
         lpew==
X-Gm-Message-State: AOJu0Yyf05MLxvYbyEmV/Q686rDhilZtaQl3jl/k+VmAnNdl13BF4RrN
	/9Z3W3WjIJb7zEkHd5vUkyWtUWZZE81o2A==
X-Google-Smtp-Source: AGHT+IHNe2Yk/kyYZcA0hr+an6Cb/SbSTMnfL3Fq04lSLlY0ar+woBP7tWiAaZCZrwVCvZ5+EFFtfA==
X-Received: by 2002:a05:6e02:1947:b0:35f:c91d:927f with SMTP id x7-20020a056e02194700b0035fc91d927fmr27745336ilu.62.1704021380213;
        Sun, 31 Dec 2023 03:16:20 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001d08e08003esm18563298plg.174.2023.12.31.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 03:16:19 -0800 (PST)
Date: Sun, 31 Dec 2023 20:16:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20231231111618.GB3813474@rocinante>
References: <47a30441242c4d5f0e00555cbddd7783350ff1b2.1702966523.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a30441242c4d5f0e00555cbddd7783350ff1b2.1702966523.git.christophe.jaillet@wanadoo.fr>

Hello,

> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.

Applied to remove-old-api, thank you!

[1/1] misc: pci_endpoint_test: Remove usage of the deprecated ida_simple_*() API
      https://git.kernel.org/pci/pci/c/130f335630b6

	Krzysztof

