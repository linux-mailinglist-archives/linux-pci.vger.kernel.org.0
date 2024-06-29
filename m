Return-Path: <linux-pci+bounces-9453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFC91CEF3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DA31F21813
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9E885938;
	Sat, 29 Jun 2024 20:06:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D094224CE;
	Sat, 29 Jun 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719691613; cv=none; b=bv6wA6m/ZQWDzsF8+i7fVAVQ95dTUAXrgSugR3vGd9sw4kc8Jhzd+KlJJEYfa8MIXSzDuu5Cheg/ffAtSs6RNEI9P+0Ze5LuGTo3itLEUtlFoPP0LivSlojyjdQQi9aRDsOjxh71UnT4d7x78aBGGnn+i0+5SSsicamwcB/H33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719691613; c=relaxed/simple;
	bh=ZPuL5Z/V1gwfGwM/tqdYq4Hp+G95QBXpIZdd+2BpHHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAtTgIYupFDiFGam+c/D4VO1ueN7ePwzl8yz18B/Qiz4zKwsFaQDoyqigNqcsMUXppK/1bRLaDbad7LQDWxoC/OA1kTyxjZpqAPZA7hTDCpJWqAGF0JMwSB8KcsEAmLrBCmG7CUdrDSb7YyfWug6QzBLKM8kBt4/cnH6f95aRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9cd92b146so10936245ad.3;
        Sat, 29 Jun 2024 13:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719691612; x=1720296412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCdxB1HFRxFuOXeiccRoOgkY9b4f8oK2frgKYhhY8Y=;
        b=Q6Ea7epgomtyZJmjIEEjIjS99akd5mQhHKyf/WDZ2st5L/Vg7lF4ZOo503l1NtmPti
         qf5vMPQDeP9gn8IrneByjwiCekqrf+kCtpzso/0HyvBpGrcpmOlDMDlmKhZmSF2o1Rjd
         u4+BfO0aEK4sLbtmgydXAAOoCLN0/qh0AVjWown7duTTdjmVNdTZOntoWfWyYNwnNsBg
         h44aP1PvtxxvEgbHzBTN64iT4P6P6ifbiN032/29OPrtm5oa0oxEMPG19F+JD65Rnnr4
         EOmw0aWqUyvA++/u7nTGvH4iRw6wbBOPO51LKYY3lAhiH24027DpYQ+NVD0iaGSq35ME
         xVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf7KPDuQpA9H08EHq3waxWT9TkjZN5YQI+Kx8t6V3vV2jbhD4Mg8HnCjf0D5wcpOHnHuonTxxh/sHrFf5XOwu43Sd5rcmZ0DYRCdhQY1LQHvvdVk25rBp3y7IaNnYQFrcV9Y9+AiaVTshh+S8=
X-Gm-Message-State: AOJu0Yy4QoGK3TTFfIRBqiuNzlsKypd+LyYIIUHhVxWci9Z5YmVckqV3
	vOvODrm3N1gMS7fgyCZ1dOsfuJdDsgSWx354vw0/7hiTuuLF+IFx
X-Google-Smtp-Source: AGHT+IGO1CKjHuaYlmJqJxWfbnp3aJMhTL4CKmwZNiixM2DreiYq74K0OJIM64qf3hDBOtWSq6bfuA==
X-Received: by 2002:a17:902:e5c2:b0:1f8:393e:8b88 with SMTP id d9443c01a7336-1fadbd08dc4mr12783535ad.67.1719691611749;
        Sat, 29 Jun 2024 13:06:51 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e365asm36783965ad.86.2024.06.29.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 13:06:51 -0700 (PDT)
Date: Sun, 30 Jun 2024 05:06:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Message-ID: <20240629200650.GD2249818@rocinante>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>

Hello,

[...]
> About the firmware binary, please refer to the following patch
> descirption:
>   PCI: rcar-gen4: Add support for r8a779g0

This quite a sad state of affairs, and usually would I oppose including
drivers that rely on closed proprietary firmware blobs to operate.  That
said, Renesas is not really setting any precedent here, so we will live
with this.

Shimoda-san, if you can, please pass the feedback to your bosses that this
decision to keep the firmware closed is rather unfortunate.

	Krzysztof

