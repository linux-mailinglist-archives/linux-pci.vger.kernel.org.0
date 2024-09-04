Return-Path: <linux-pci+bounces-12762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28596C234
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8427A1F23FC0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C01DA615;
	Wed,  4 Sep 2024 15:25:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AC1DEFCC;
	Wed,  4 Sep 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463535; cv=none; b=Upr5oFC+oSb6q+AuuaLW27yyc/f8skzlU/EUfQyK/3WrD4z/f8bgyt7b6fTVKxjLAtwQWXhCEwIRUldoFF45FdtmLsSdk9bmo49Qv0bURaaFMvh+Ayzrs1nB9XV6epo3nGJzlCCM1AC1VshOSwZIpGajVTmQ38OkpLPaa/IEQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463535; c=relaxed/simple;
	bh=XGH/eLBc7olTkWXHdsHW7Kepx++I0ec6zH/0X2Rw7sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS4SMFFlTTrfLxdxhi8pq/lko0K037kUww8Q4XhsOZC+QlIh5VVsX6T/hhYKcGDMGtYZ/aSdogQfOXf7xiZlqTzinBGv7TaKFDQ5wFwJIZfnd825lXU//XmAiyAibxuljkS7a1dhJ5q1r7sA5aZMkLIDZaAm85TPH3uR5Wpq1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4647044a91.2;
        Wed, 04 Sep 2024 08:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463534; x=1726068334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txID2s1g37xsxM5b5bZgCtDeI3wV1mgaApdKPx0yK6Y=;
        b=ovwr/fCSnBObW922Oa3i+kHAnYxCYAKT0x/cPSX6V5p0NiVK/AfP4KdI4tA6iiEEXE
         iFMBFL8ur3T/pTca4SN5Qb1Q2J0+X/OpCiOZVCieFTSdO6wWXvuqBLsuqaCPFu1braSq
         7WOgC5bvd6YMiW69j1FGCH4d+8RyYqySBFXpLSlUnW6vYRCK6XMODmy3tAkhvVY2DtEh
         Oj7dbB4fcPKAK6ylZBwt+6wHTCf9wfV1HalZsJjTxUD3BHWhr9vGvXTN/dovTc6EgCAa
         aHGn8/p6JMkmWCmfcIgElVngeZGIzwiDyLfRm4qmXVyy8Yz8F6ENdUsgOGxkFyWbLXwv
         yATg==
X-Forwarded-Encrypted: i=1; AJvYcCUffaVSy36pJEhw1ix7Cl4TQFD54Aq0qdeXtcIgRu8OI/oVLQ/T11SxxU8fzHyUeVpeM8fMHXZTMSXY@vger.kernel.org, AJvYcCVPQFuVjVKnYfWbZesp/0zP9VXIOdkxO3zhp6r6dQiyX8dNpvjiIozEfXMsmfegqu0Unjd+BixsgaeV@vger.kernel.org, AJvYcCVqxJ9cU8XneF9bhYARhXJJzSsuMC1Vr1+7OiNzpYBn31qdIjf0Nu2EVDlPlKsxQQlC/riqlzXqeBgHxJGu@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkwbuxX+0Q1bbUmrNrhyI7wufXZEyZWohiMW/XPAoIYI1MXfD
	eqUyB+ZdD1okQL9tR5r9zOBBK1aPCIUbZEB+pQmyxHhmvsDCpUsD
X-Google-Smtp-Source: AGHT+IHw0hofGVtH4TjSvkgorZ9H6QF6o3uhgCCImEOuL2P+2meixTFKzJ693AeTANvidpoa4gqxNw==
X-Received: by 2002:a17:90a:a386:b0:2da:8c08:6a29 with SMTP id 98e67ed59e1d1-2da8c086a45mr2697969a91.8.1725463533911;
        Wed, 04 Sep 2024 08:25:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8283f6d9csm12264932a91.0.2024.09.04.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:25:33 -0700 (PDT)
Date: Thu, 5 Sep 2024 00:25:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, joyce.ooi@intel.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240904152531.GF3032973@rocinante>
References: <20240702162652.1349121-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702162652.1349121-1-matthew.gerlach@linux.intel.com>

Hello,

> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML. Update the entries in the interrupt-map field to have
> the correct number of address cells for the interrupt parent.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: altera: Convert to YAML
      https://git.kernel.org/pci/pci/c/b08929e1ec2f

	Krzysztof

