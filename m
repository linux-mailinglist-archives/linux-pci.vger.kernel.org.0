Return-Path: <linux-pci+bounces-11603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A417494F6E3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4192873A4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F818F2CB;
	Mon, 12 Aug 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MMZsu1Da"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327718EFC5
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488360; cv=none; b=Ht4rNw0ORxduAJOOEeFC21qXWPb8RWz28GS2rTqey6N1sX0s9XVP46WbU/wbXeHkkInksyCdTIPmPyr87wCcstO51bZmyM9BYNJz64sffmgdWDTj8kCU1h8mgTNquAp6tsZooRX2VXVwKGcft9H0ouphbC0wUdRGO8OeNU4/8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488360; c=relaxed/simple;
	bh=FlJeUeETxp2FXGyr2GWev4hf6sZx/3ANmPmJGGVMNOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nslvCyLWs35z4dRP43V3lAWxDLXS0D+T/btaz/JbMkHNkCFhVQ+79cPas5PJGWPVTT67XY3BjeRdeVME4CJIemRmDg3dR5B5Z5iAx2L6rekhkeCFgZrqK3X1r/8Rvz3SVVF8myd9bFjdVg0BmS4oLDsgei0IcbdRgsuoiFkutvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MMZsu1Da; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-268a9645e72so3351104fac.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723488358; x=1724093158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlJeUeETxp2FXGyr2GWev4hf6sZx/3ANmPmJGGVMNOM=;
        b=MMZsu1DaNz9IEO7vHVWVTlIglXU5NhcWP0UdWzyIBEMcTI61ZKl61IBYlWWOop+W2+
         arPgfgHUdOu4kQz1pCH7+3Eyfy/dCC9C1AvVdfKifUt7NKlRgXrINKt4bfTISRfk0Md7
         2s3G/Ryh4r8MOeQauxsBjOWwH9+WVYbv8/98Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488358; x=1724093158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlJeUeETxp2FXGyr2GWev4hf6sZx/3ANmPmJGGVMNOM=;
        b=ilSrogb0hw1Yb+/ZiUkhTZ5rZKFKxGIoQ1q8xUnWJPv4nXaArv6EXf7+jXdxgMe50/
         ZxUxlgzhA1fx0SrlyrHTVRSyFWY7wimmpKnd2uKFo0PcCigZz3jC0rzxmef4diVRSgrX
         1VWDKmPDVtPCs7JYPs0uDbc5/eXpNxPSgVxcCeoNMeR1EGuyA3mVEu3uLw3uX0Z5+w3F
         Rj6NJveowRBEMXcS0GVLoVoIA65YTX5xOVddqNyYz8AUJ6Tu69fe1h0bpQJTkCda1Yxa
         /gY5Ye5JT2SfeG5aZg2UiBeWx68Q0bxl/2qon+W9gBL3+QOkEAfyU5P3Sz48/n8TGVnp
         dz0A==
X-Forwarded-Encrypted: i=1; AJvYcCXOjI9vDJfI4FsvJecSHTEpWbqKFK2r9wWVR8HXEkQzQzxG6BD44BWkFaeWDmJUnmuVBPnifl5CLLmyOkgVXwIxk5D065TxJj5p
X-Gm-Message-State: AOJu0YxjCgR0Cn0EeTVKbZjO2Ee6bO3uGzuoUtBpVmEqRqXTxsPQM8/F
	OWqYWianz9/pNm3heIzXYlHFRFMH6Mh1ZvtBZNDh0HUoVInE5F4lynGPYzRaVXbkJr1O2lKo246
	5/M9gsZs6Jn2DMNTse+PhVW67ZxxpdC/L/DKf
X-Google-Smtp-Source: AGHT+IH30s8urnd9D4vusdb6oKwp0HXj/UnYiPnQHXC9OHfS2VY28kyI7YDJnpNmod6p2kMXZIJDF0yMvKKrEoNk7XY=
X-Received: by 2002:a05:6870:831d:b0:260:eb3a:1bc with SMTP id
 586e51a60fabf-26fcb8cad9emr1220729fac.41.1723488358507; Mon, 12 Aug 2024
 11:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>
In-Reply-To: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 12 Aug 2024 14:45:47 -0400
Message-ID: <CA+Y6NJFx21B9Up14VCW_w_gzv4TGDYL3BsNc_4FOym5GvcY8ew@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev, 
	Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional note - I have access to a variety of computers, with lspci
information accessible via a database.

Testing I've done so far:
- So far, this version of the patch has been tested on computers with
two different discrete Thunderbolt Intel JHL controllers (JHL6540 and
JHL7540).
- I have been using an external Thunderbolt dock with JHL7540 to
verify that external docks are still recognized as untrusted and
removable.
- An earlier iteration of this patch (before I refactored it) was
tested on computers with JHL6250, JHL6340, JHL6540, JHL7540.

Is there any additional testing that would be ideal for this ticket?
Which configurations/types of devices would you want to see tested?

Thank you!

