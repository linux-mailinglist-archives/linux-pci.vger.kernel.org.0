Return-Path: <linux-pci+bounces-7620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E38C85B4
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CB5281AAB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F43D56D;
	Fri, 17 May 2024 11:30:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D372BCFD;
	Fri, 17 May 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945421; cv=none; b=k5Pnt9YNoqTfqukakzFzynsFMdnR6mykPCBtUgUjWgYG+GTKIk7WrNF5jPJRj/ucRtPK7CrMeSbskyYm2k3h6suJ506fASCqhZg9r0JD+dLEl1WshLPsRnrPu0JNMaahVbYkB/mYvZR8RRIK4JU1/tNp419+ZEhoZmHd3Uo8XOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945421; c=relaxed/simple;
	bh=hgD7P3NPcJzxcyLKb5MeFxVWU5a0pAGAKxZjByGEGwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slAoYbtpx6QLuSJ2DOCy+Yyuz9FQ13wlWXR4RMOsx8W4Mm+ElB64+QPrd5eD0hEk507DUoV0+flqMv/Vd363Tt2exDiY0RB//M/tpurJoqVVRVLtqfXYDlDlfHMQ/Y+8HQsqwnmY5OOKMdPWTUW8clBX753pqoMAPKPKiqo8NWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1edc696df2bso6538275ad.0;
        Fri, 17 May 2024 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945420; x=1716550220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MRDtJq/uSAsVxT3qr4CIzIUWaDppJLdTVyDpSwphtY=;
        b=woXJyQRVmOaxB7ZnB8KFkSfwDlhL9CHoQ1JhY4y+NoeDE9tsuho69Fj9dGbuplpnvL
         cECbLuRmrAk/Ocm1oHe8s/e6mVITAJUI1up3zugsmUO2CdzZQ6LfR0Wj51yK/ToIthQ3
         ZxYF4YaXGnyUHOJsOgtXG1hg9XOZwIwv0M8Da6Gzc8maFxn6dvb9Kd4WRPX2lRZl+HIW
         sNZycmcva/sJ6pxgF2KAYyJdh38WrFaP5zZq+gFOWwJSFxhe55gVf9c8qbqZZxxywAF7
         hXl6iVDp86w7TnX3IPBI939p/OlprPXLncstgAndjoPtRNX0kv9wrgR6TKEPkGQ+l7au
         2Ftw==
X-Forwarded-Encrypted: i=1; AJvYcCVRhJjdLM5G0czKNmiqS8svZ0LxZcbPYpjdFlE8M+u+NbGq8iawMDC2r3MxvPZNiDWVe1f7pwEtMxMUBsIWZqVw8yyemYXs8Vp0DEsZTAiQa9dUbiUGv77RSfC0FRk5INms0V72S1ThDa66kiLK4rs6oa1wBzsxDzeIOlrJEpmTV29dbf4=
X-Gm-Message-State: AOJu0YxQZ6ycAPspeP4rQ9Em8u86zQoSphWFf4Sj0uEDcJGeqGeEGi1X
	shLJEGVqewK+QSiy5ZA+0clgpsc9l5aT9XFNct6p3DJ5eTQW7jPq
X-Google-Smtp-Source: AGHT+IEA0gWBg7zyDaXoLuQ29vrrxnEmVKxElz8b/OvhgVokq8oejRq9TgZh1qF+ROc1QmjX+oXU+g==
X-Received: by 2002:a17:902:ef87:b0:1e2:3e1e:3d9 with SMTP id d9443c01a7336-1ef44059b97mr209472175ad.63.1715945419661;
        Fri, 17 May 2024 04:30:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3565sm154240705ad.30.2024.05.17.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:30:18 -0700 (PDT)
Date: Fri, 17 May 2024 20:30:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: tegra194: Fix probe path for Endpoint mode
Message-ID: <20240517113016.GA202520@rocinante>
References: <20240401150116.298069-1-vidyas@nvidia.com>
 <20240408093053.3948634-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408093053.3948634-1-vidyas@nvidia.com>

Hello,

> Tegra194 PCIe probe path is taking failure path in success case for
> Endpoint mode. Return success from the switch case instead of going
> into the failure path.

Applied to controller/tegra194, thank you!

[1/1] PCI: tegra194: Fix probe path for Endpoint mode
      https://git.kernel.org/pci/pci/c/19326006a21d

	Krzysztof

