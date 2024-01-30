Return-Path: <linux-pci+bounces-2817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2942842AC3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306201C21046
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A42364AC;
	Tue, 30 Jan 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0oezNouq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E41292DB
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635335; cv=none; b=TKxocu2w15YMlt/yAuYepsSYVtEAZkxVDG5W1LVX7XLsOmmIT1k9kiZG/G5dCLkFUQ292/dENYBfh5EUpGpVRpRbGUI9cuTL+kheBYQsXdm8m8yNBtysFnSj0BFwuNR7jjTViquBjUGkXX2IS/EX9kika6bMyvQAEX6+HTDqnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635335; c=relaxed/simple;
	bh=0IsgiQ7Zt+YuGCo/7lyACXSm9Ay95p7xxxCUnEnNmWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGzxnt07ObOd8vdCnzcvwUoIqoHAzp4kUT5oYTr9Wjv64B64Wci6FYtkyDWp87BX15fnIs6ZvgFAq4+gLMw2arC1vnYSuyrn5Xda3w7uMoIt0Dn7b7ppKyzi9dOEyvtd1de+v9uLTJSQOhGH9/MqLq3mGuVOWCTlvu2hKGcSqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0oezNouq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so7036a12.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706635334; x=1707240134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IsgiQ7Zt+YuGCo/7lyACXSm9Ay95p7xxxCUnEnNmWI=;
        b=0oezNouqdAaNRvW1G3fY91gPSNLYsAwWVEOn+atadwbyrEDJSom7ufxuWyug/ykeaE
         k+v+3o25z+57BuJHnGkn8T8OcA6XUxF+JWbzTPq+bzuiM2A9bOP0aq5PRuAO6K6o2vT3
         hHrUSvALT0IsZYeJ1Safmz/nqUG1YKkN829UK5ksLrGntviYA34I9pjftL/wosnuCPB3
         I5jX/hkKwT8E7wwWkI9UtO5ZUCH+7yziPLwpe7oMI0rS0FmKUQ8cqsOn+QgrSKS5JDa6
         joipSun6JxTqs3ktOgFLFP+qsZpPs88OQZ3WFc3pwLCEF7VtvDqrYntQ20RmfjHiLbSw
         GP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635334; x=1707240134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IsgiQ7Zt+YuGCo/7lyACXSm9Ay95p7xxxCUnEnNmWI=;
        b=GMJJhch1UfhluPOwK6BHWzHzIio7Gqrc7hqkZooCkX18se/h5iintOQgWZtS7boJfv
         fZTEmWvSFX8mID5z9qGbUcfseomht/fkU+Drk5hqng/Nji7Lufbq6q/Hz05hDeVM9T9d
         pxnAs704G20S/4r4XK9CxCNP9LYnn3GxryqN5Z6XHLerD+4nKfxtiHjsNDQ3rMcDMQ1P
         7LyH39ohCEQFOWTEl2Zh2gxLscfEqCbitdhOf43eDRc5LdTMCkZvm/qLYBHKytMj+cNY
         XdqQwd2H0zzmL/7vBtmJmMhX+uOJK8iLBpBQU1mB8EujHzzmrNIU23DwLRQ81ytxnAKo
         mmdw==
X-Gm-Message-State: AOJu0YznP6LArGUFY3z2ASluXn8avF3oi3uemEec/yKfUabrRBhJ1Obt
	kWYbeaW7j7683ZvctBrgVaeWQ0DY5v8jGVGcBl/cUQyQDsPvjbRzc4uIR3DzeA==
X-Google-Smtp-Source: AGHT+IFM36TXzwwfZ4E0G0pTypDMaayBeXTP1OQlciQ/p2PDDUIUUXq27ogILHs0kltgknmPgWNLRQ==
X-Received: by 2002:a05:6a20:ce4d:b0:19c:6620:483c with SMTP id id13-20020a056a20ce4d00b0019c6620483cmr1703597pzb.23.1706635333745;
        Tue, 30 Jan 2024 09:22:13 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id t5-20020a62d145000000b006dde36aaae7sm8419740pfl.64.2024.01.30.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:22:13 -0800 (PST)
Date: Tue, 30 Jan 2024 22:52:05 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: Sajid Dalvi <sdalvi@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	William McVicker <willmcvicker@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZbkwPVyqL8x4yeIy@google.com>
References: <20240111042103.392939-1-ajayagarwal@google.com>
 <b1ef4ad8-99c4-46ba-90fd-d57bd17163b9@arm.com>
 <CAEbtx1=hoDTtpkavk7gp5tmcvdYj6euAuDsQYRPW=EDeVsbUqg@mail.gmail.com>
 <5ef31b1c-3069-4da7-8124-44efba0ad718@arm.com>
 <ZaoPmgeVfXeseTfN@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaoPmgeVfXeseTfN@google.com>

Hi Robin, Sergey
A friendly ping for your review.

