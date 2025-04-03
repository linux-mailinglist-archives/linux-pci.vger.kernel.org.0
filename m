Return-Path: <linux-pci+bounces-25234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39406A7A2A4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064B51664CC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6D1C861F;
	Thu,  3 Apr 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilK/OMNw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E181519A7;
	Thu,  3 Apr 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682564; cv=none; b=RIbZDQk5vLAu94kweq4fxabRsavuWm7xWpIsQc4LmK1izIGZl/Cb29GvDxoPYZELwXu9EyBTI5yKRiWXuC3lnVPcv8UnbVokrJdlQXaUboxzBZgrupMrz3L+AMPUn3FL/7eiFslyxf+uW0HFHHVXImK4DEBCyj1cw/h1rM76j1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682564; c=relaxed/simple;
	bh=BfsuHIkQOn+t5ea9pEtC10uYV5VcdqlyisbK1g6IxPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUUKzNlipP73J+l9iTq8e5cX0ZqQi4IlVuK+9Zq7iD3Jhk4uGsz83R85rr+vJkDeRwosx94yLPi23bySCve26EAyWOrezrXoiPN9My2uHx7vCia0hIwCZn74ua6fVIOgvIjdCk6ZQ1E9k17vagKJ9K7TYen90DNWYt/M6xXicFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilK/OMNw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227b650504fso7965915ad.0;
        Thu, 03 Apr 2025 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743682562; x=1744287362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEq00/hkCJ6pJcCFQSkcNbWxF96iAwQsWcvrCaZX5hs=;
        b=ilK/OMNwyLnUyFB3/Bx+wbQi8A0dcSJ6IlVOWaZtdLlwmRPMMSrugY7vFo9wr+zEqt
         AV1s4UnwiZQWzAdfl6txdLbVw5A1EYTBTaSY6zCMLxiFe+QFToOdPnEdKcC1MUMDx+4J
         e2lTJtWsHb9I6rNtoyE+IqO2sO1YJiJt3msAc9RdoA71WHKvBQ8sl1RFi6KALP5w6vmM
         8tW6yS+BuWasXrX61/DJtcYmAubPWIEDCV5JPXybo4iUdjNf+zRr5o/eHQambSksXRPz
         19rwhXTJSizUuj2Tq8urSAiwtmsGkCGTdbYStmteE+2yC+u4gNC/UVFFWBY7lA5dMqNP
         syDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682562; x=1744287362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEq00/hkCJ6pJcCFQSkcNbWxF96iAwQsWcvrCaZX5hs=;
        b=UkvvH8LoTisEok1m0ejAtdGZAm9ue3gyYKj+7o4XnFw0qjnjQll/Xj4ott3dEPS9na
         /jNpTYKS5B70achE6DIhhdVopJ4nk8Ekq4nqogiimTE/SncjeWOOw3uawN3y1RgJYSpE
         QTA/kPnGOkUSPx6SABG0b4cN2NYuJO0OTvZ+l40/rvmYh74AlLuC78yizE7FQJcO5M8A
         +b2/922d4oyv3fpQPRHUD7l9BwFfJ9OXlW3Vy7pzC+rDBR7SM2nd6/Yoq0gL/MWUEeKS
         FfWGCbpp67HPtbl23lsQPtGM+hwQ2lby9+988dZ3WyUAMq+/lJLByBHjLjDWPpbZPXds
         i25A==
X-Forwarded-Encrypted: i=1; AJvYcCUeNcua6dPAvk8n692furxd5Y13M8xazmfOQpkc2pzP9YXSnPakiiMaMFArHmbrEXzfAV9nc9cNl1Cg@vger.kernel.org, AJvYcCW8m4xJZmu4Zdr7no3uRjLawDjqpId8KA2ri0ZoN4ArY+1KkGXi1m/DhrjpGtaGKDPJ1eYgoN68Icp0JT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6KrPeOyVQNqUQLmlMmSA1T4P3zuF0FSOl56jh7tJ+hRMYflO
	RFqFPoRbQXazt0S2ZB9/AdmyCd7AIA8R4XXSvxaC2+HiKYagr6mz
X-Gm-Gg: ASbGnctHScTLpVmEJjPB0X+2uaWY+QHecOjWjd5UX4qvuTxjUBc7Qm6uxT/RXayLAtR
	TVLeUWA9EdjJI2dHZZ9/ie15XXLk36kDehq/UZXJvC/KkjdYuecQkinDWN+fRUIew7pyuaOcsub
	FQsb0MxnT7BrZHnq8svnNP82uL1ca02V3V0VhYnhv6Uoz1m34RNxrVnnZLMbMpuloJRhjvoZQ1O
	Lx5yGxbqUBL+vgDRFIE9gPD+Sof1BFa7qVjadDW04ARsTao/K3ZkCjU+ymS46VQJDgZXYfZbnjO
	OotajuK5s0DZHwdAkHZw1Bc2YHtg5DhKgBLthDoKhzDNKBm4vxs4QQre8g==
X-Google-Smtp-Source: AGHT+IE8TQ2CkjdWRykcK18PBt0Nb6zozfADT+9c8nhqxCjyqv/foO4kP8r/o0vLYNme2mK7+YJdBw==
X-Received: by 2002:a17:903:18c:b0:21f:768:cced with SMTP id d9443c01a7336-22977d7d5d9mr24742365ad.8.1743682562558;
        Thu, 03 Apr 2025 05:16:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c385csm12791485ad.81.2025.04.03.05.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:16:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 3 Apr 2025 05:16:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH 1/1] PCI: Restore assigned resources fully after release
Message-ID: <c295d86d-fb5a-4379-b998-719f39dbb209@roeck-us.net>
References: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>

On Thu, Apr 03, 2025 at 12:31:37PM +0300, Ilpo Järvinen wrote:
> PCI resource fitting code in __assign_resources_sorted() runs in
> multiple steps. A resource that was successfully assigned may have to
> be released before the next step attempts assignment again. The
> assign+release cycle is destructive to a start-aligned struct resource
> (bridge window or IOV resource) because the start field is overwritten
> with the real address when the resource got assigned.
> 
> Properly restore the resource after releasing it. The start, end, and
> flags fields must be stored into the related struct pci_dev_resource in
> order to be able to restore the resource to its original state.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

