Return-Path: <linux-pci+bounces-10059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401A492D018
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA21C286744
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F318FA35;
	Wed, 10 Jul 2024 11:06:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AB18FA32
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609599; cv=none; b=hvFnNotbZS5Ln23cqzY2nOdUyBnpeOp3swRV+wx/HoJmL6h4qeFiN/+3hfGifwPsw/Pho/Idleq71uWDpwQkieLGhC3bhsF8yT8h0EhHOpnSspy7RQFyXc6cjS5d8/akNWzhUDl2zgzzu9IcgKP+ruh59iDUVeIEKa53dKCBvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609599; c=relaxed/simple;
	bh=O0B54Ow4RQg9+9G3R8bz6t9UwhVXROPZewbadbnauIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb9qeumYQB7DMYzGv6u+Jpjk+5dT9X7WrXVI+WVhIpuG6JHmiUmNRbCa3Kb46eKNvxf8PTLUr5X2kD3YQGXu7wtsW3jrBidbThbTr/jNT6QOj1e0bCFTDdbVMGj5ofvX9yE7yfNTT6DiXF/ex2TarjoYmDx6qjvA2gaboHDCr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so3551028b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 04:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720609597; x=1721214397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNfiJtPajNHcsf9m/KOkXkPn29kCrRAMS4ZaAmUAzRw=;
        b=Pos17qz8MY5g1wMK1UwwpqcYsjdwotIigOqo6he2SCQ5PbD8wgvoGl63F/s1gWR9Dw
         qFMIbpWtfCsYJqfnpZGk0euSDX7ljQEt5jq8aiix28it8eyobRhUUrhserqSHIgKt3iV
         oziF9f80JWJ2ol7g2YpE2SR2chHctAE/F1Ac15o/BUwY6+WlQj/Z7dxN8x2jl8Ly1nkp
         4Le4d5rV5TC1qbxOjaeD3lPNqevWW4jLeanycNbrb99bBw48BL+R5KU80UjTnkploZXp
         ytYGm2sWuhMD4aa8slu8KfjBs4A3XHzB3mWxhNIhcLuK8Wq9oGym/ibf3DVquhUh819n
         kLQw==
X-Gm-Message-State: AOJu0YyNNXAFnxozBs+MwtT1lahzU+91eD8v/v79oUtGyrP36x4ZMM/K
	HUEF4cJ8XIyTF7eAhpHIy2/HTaIOya2uHjC6e4go6YOal6d8oTl/
X-Google-Smtp-Source: AGHT+IGGfJFr/8MkRFf+9m29aytayyJeJm+CtBciNWbbqS/FaunQdNQM3bu2R3LQhhMilHVqK334fQ==
X-Received: by 2002:a05:6a21:78a7:b0:1c3:2e46:77d5 with SMTP id adf61e73a8af0-1c32e467c55mr2240025637.30.1720609597191;
        Wed, 10 Jul 2024 04:06:37 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aab0787sm11636469a91.55.2024.07.10.04.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:06:36 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:06:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH v1] Export PBEC Data register into sysfs
Message-ID: <20240710110635.GB3949574@rocinante>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB718249EE43F62F46A9793280BAA42@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSAPR01MB718249EE43F62F46A9793280BAA42@OSAPR01MB7182.jpnprd01.prod.outlook.com>

Hello,

[...]
> Could you please take a look at the patch when you have time?
> Thank you for your time and consideration.

Kobayashi-san, thank you for chasing after this, and sorry for the delay.

I left some comments.  Have a look.

	Krzysztof

