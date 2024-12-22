Return-Path: <linux-pci+bounces-18940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A80D9FA834
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AAE165734
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFE1854;
	Sun, 22 Dec 2024 20:55:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A91714D7
	for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734900925; cv=none; b=Yiq2QD6ruclvCXfEgItM93SfC7TNDITR3/7EcBtfXziuqvlOvkY35EQvECIulpmnk1vJXEOeMbQQjmNx5pZ8teaqjJUU/A5MYL6qNRcooOH+Ot5PS4t0vHSdenx4wacge1CUzXCBFGWCFybFliOEp3VZ9QpKtOIfM8F37asJOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734900925; c=relaxed/simple;
	bh=q/HL+aRLmjoVpWxUbaiBlMQhG2ifq1CYrTLPQGmwyYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzDI0T0HMlQkC+45yCdLI9zyFO0ULN+TEk/0O1OfSw/n38grRgXa0jkp4DBpzFqsKks3uusojWycgNwFZq/cXOzkNGAnsklDG3jaOiYbWGzFR3oB9NcGuLjiVvyysb9go955NaJ53vhQBPkKVkKXYbpGTQlG0dhi1k3Tn3nxoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e729562fso2870299b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 12:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734900923; x=1735505723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd4LIPj07iWVDyhVOO5nuYP+uF7WVMgZrgjvFa6gt/c=;
        b=OHxkEEDXrOcmmb6iiLZMe2varod88M8/X9rPBiiG4D0Z1WVX6pjO1U1SllqVaf1+sd
         kbDudsUh5FHQ5ZPH5AtwnlsuZW61IO3FNHsktcEOUT8r3UAxWYe8ywToQfdjYUlRFbR7
         lCDQFBJvBTqAzp+HOI4xGr2LbDTvGDqcTbVobgUPKnyg2aO7pdYbCsC40Vd3MphdxE5n
         m8uvkNQoQk/86/tgrH8PV92b56uJBhhZOVXH9keOr0jFBvZV/fkOV/si9YDgfkZZhKFV
         xCm/xAhc3vePytFqMKaYopy4312V01UhFD8T8uNV0+gAd0NXbTnPNKGInYPofE95esVL
         lUSA==
X-Forwarded-Encrypted: i=1; AJvYcCWTwpYsGFoU1n5N6VLQ35Iwv2Aa9XrZZ5FuTfIAqIeXK8fCHiQL45HLVDLx7aWycKKmIzDQTBVEpUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoc9ov6QibprBazXbHN+cwUmyhq15MfVTYiCUDlOQNAIGotGyH
	1UB8aiIXgUkQ8pAQ7ziJvi1LA1+A47NqakaJfj0xEeB4sM7lyguW
X-Gm-Gg: ASbGncsLjIS7ghcnZHmJRVdJqpJ1ipi0whH7qLvGlmiqM2W5qJ8lKjHnKtElWA2Lv87
	g5S56W15mKaJRwuSVhu+JevsO7hBBtNkUkfaGEDEvA2+NCxVwZ452G1wp6+pkFiWDrwnlr0sPUD
	y0yCCn3g3D5mO+PQqB1769K+h2ii4s4hqMpWbCZCsmrkTjSeVxgvHplS2Tw63kuSykveywm6FR1
	z3qOszD2lDhUcks0tfD2HgMgJYbGj3WF5z+waYXNoB7aHle42jX60Zch1xZ4NOFz7xtB7l1y1ZF
	IzArwyBFSfUshnU=
X-Google-Smtp-Source: AGHT+IFk4OgzbIZg8PgUQTDhs6/0WCL6sZuIUUNx8MhvAl80d0+fhJoXbYtHShfEjmuPDQiJuDqF5w==
X-Received: by 2002:a05:6a00:240f:b0:728:e40d:c5fc with SMTP id d2e1a72fcca58-72abdeb6267mr11503576b3a.22.1734900921519;
        Sun, 22 Dec 2024 12:55:21 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba99sm6476872b3a.92.2024.12.22.12.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 12:55:20 -0800 (PST)
Date: Mon, 23 Dec 2024 05:55:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Add consecutive BAR test
Message-ID: <20241222205519.GA3111282@rocinante>
References: <20241116032045.2574168-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116032045.2574168-2-cassel@kernel.org>

Hello,

> Add a more advanced BAR test that writes all BARs in one go, and then reads
> them back and verifies that the value matches the BAR number bitwise OR:ed
> with offset, this allows us to verify:
> -The BAR number was what we intended to read.
> -The offset was what we intended to read.
> 
> This allows us to detect potential address translation issues on the EP.
> 
> Reading back the BAR directly after writing will not allow us to detect the
> case where inbound address translation on the endpoint incorrectly causes
> multiple BARs to be redirected to the same memory region (within the EP).

Applied to misc, thank you!

[01/01] misc: pci_endpoint_test: Add consecutive BAR test
        https://git.kernel.org/pci/pci/c/fe986f9ef0b9

	Krzysztof

