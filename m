Return-Path: <linux-pci+bounces-908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C7811ED7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C9DB21105
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E01168269;
	Wed, 13 Dec 2023 19:27:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CBB0;
	Wed, 13 Dec 2023 11:27:02 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28abca51775so1467053a91.1;
        Wed, 13 Dec 2023 11:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495622; x=1703100422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWVW0olGcSxCBdJ2tMtPIREhrLezlbroagvUoCyknJo=;
        b=oWrCZS60H+zZMK6XgMok6XWpCcARVCjMpj7VrGqtyGQ8J5x1PyJMUM4JPEaXm6UETc
         waax4AC5FZ8t1DMjkrSsPe3H/RnWn3r/SFeddBL/9kToSjTewEEPmDBZq+k4MMKbOtBO
         pKweCSgmFtv7gsdsokLuNCRRfGjn/xKS69QJ1zIP7DizDQhTIJdB1rFgXZMQHDr7vnhk
         JGV74Td3YItqDG43HwH2Q4uHcJC7Q5P/1lf2MxDT7RMAa1pnjb9G5Sp1BfVhO+rLCK8C
         tlQEdGvV1RSxAbzmTlCxKrCqNNQNKEe+iNGGU9MGt6/pWdy5sqleEhamiucv2LY++p2A
         yD5A==
X-Gm-Message-State: AOJu0YwLP88USvVLfaheXYj3nPGvyJK0h0Jf4Tj+vC5uDZTtMJlPaay+
	ubn0J/edIV6EVsMxg3ETE5w=
X-Google-Smtp-Source: AGHT+IGBz9BJO+fNFXblCB6zsBxw0/nmGzPc1Td742lMyz/VKcdOyC4cGNWerXKPUrqX9Z3/E/jB2A==
X-Received: by 2002:a17:90a:fe8f:b0:28a:e30d:3043 with SMTP id co15-20020a17090afe8f00b0028ae30d3043mr640572pjb.56.1702495621720;
        Wed, 13 Dec 2023 11:27:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0028b005dadb3sm275238pje.26.2023.12.13.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:27:00 -0800 (PST)
Date: Thu, 14 Dec 2023 04:26:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <20231213192659.GA1123825@rocinante>
References: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>

Hello,

> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.

Applied to controller/vmd, thank you!

[1/1] PCI: vmd: Remove usage of the deprecated ida_simple_xx() API
      https://git.kernel.org/pci/pci/c/991801bc4722

	Krzysztof

