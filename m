Return-Path: <linux-pci+bounces-24210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6BA6A153
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A34D188773E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8C20D519;
	Thu, 20 Mar 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrJmp3tQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2ED209F4E
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459273; cv=none; b=OI4foPzxWOOFeCIczMtKobMMBRGZUjbURR+dZMMfWuAXNKFc5Lx7F/zLGTRFFHb3MQiPGTAyyFRCxTZY6OHfB9SueYSyzlRHRap2hO+svwQ5M1ms63ZxUury28ddXHzUvHV7IwE0ITzLGhcUTbKZP9xPlLlOEyTwPUAzt0aQ1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459273; c=relaxed/simple;
	bh=9rIvV0sXrfv9GdBS6C7KFSj8B5CqIE2gKqIaOvxWM6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgcizadsQZzId8jndPLPMQxxP9/6EU+ZOVhkr24eEfcPCEq/oJ2DTA+WrrgYEv6eRJuDeT9MjT6dLnC3ZK9Yjw2ivWc5YMdL1Xl/GQEDZZ89Z+9PTxYFRjdC5uf61soDNRHBpi6QQJgWCuGN4J/oyGZ47z7uw9Et04OE/oV29qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrJmp3tQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso773000a12.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459270; x=1743064070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rIvV0sXrfv9GdBS6C7KFSj8B5CqIE2gKqIaOvxWM6o=;
        b=TrJmp3tQfNThaSrH35Of5affSVd6gHvTRYZL9GiHx42L6CaAOY0MReQGd5xYiZliS9
         ePsI/pODd7ngxpEXC0cxdfV6R3i1UC7Ji6N52yt/o+8nOze6EJIrZteD8np8tWXlGdh8
         8p31J6dZ19/1pRhuoWhrJwxwdpePWKY4CpnMR76qHyjgx9TIh6UbCGozx08CIuHloiU8
         BCF2HNk5BvqRSwMoMUfz+WMgrUZxlIhpkIK5aGxzm9tCEDDZwOTeA9yO/gK7YTHpn9pH
         DRScd3PGNG6/bvzVVTmr4hajFdp+lK5xwbZOIdngvXfuxI5XDyFRxrsg9dGTwvfKZ4NJ
         FFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459270; x=1743064070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rIvV0sXrfv9GdBS6C7KFSj8B5CqIE2gKqIaOvxWM6o=;
        b=dYBUhRKgubLwRaBMexzOEAY7QSJM/vxPCtDJLbuM2liFJS53vq1n239xHMEriTRpD2
         YnEHuDs2kEM/4a+5IQZo+P4a9hsvjv2KhJcuzU2sWEpO4QH3y9XAdLBHn/2qnrm543XN
         aFUWQGpqJnyNhyZ4vKitVk0tetjb5ZcFUYE53cwj7wX2SuhqQ+B11nCC3JOqJupx1ISV
         OtTUqBSfz0CbnPCy8JdPpZ3dkyL/PuGZx4Hkxv2oACFYvJDv6DLf4uuJ3VTnZSrUEaj+
         tG3VXr2jBS4WOuHNIFu00mviFJkYXjloLJ+dadxK4OqPoupBBXc+evSWnMJFETErIY4y
         owOw==
X-Forwarded-Encrypted: i=1; AJvYcCWUjGNlpQ5vQVo/tp/JoVjenjUX1xsgUPWbIXWnbCo7/4tEl9J/ci4eE4uP/gpd+vqLynus1QR0k28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FaPJYCvJKazzM3vT3dEm4+xlbzZMQwlo/WkQH4jQDSdcctLQ
	vikgA90ij2P4idnpZhSwP8FLC73KZvigug5gjmnaEvbt5/WOB/KvURFWftnLHzJRSy3SwWz1Qn+
	1x9zbfe711peQcZhuO5tFmyxlFAQcODZQG0J/
X-Gm-Gg: ASbGncvZiCqazIENgCeMFRkgdgR7rYHciUaSC9lAa62MCOOzR3+PvwVAulRb/De5EYY
	Sll/KomdUQ0czagliqShQlBGnC7EcsQxI+AveTm4/pf1vcsF+CDObvLIqvnPxDVdOjXPNKrAb+s
	D6PMqtNaKiNEbv4q4eh1O3Ims=
X-Google-Smtp-Source: AGHT+IGRhE3GHs72yB2OexF2NN7y3Gizc6SR9amLNdyD1zJDWSRgAXDerFvOPUcI0M0lOsymJi8v9lYuHeytplZAi1o=
X-Received: by 2002:a05:6402:278d:b0:5eb:4e69:2578 with SMTP id
 4fb4d7f45d1cf-5eb80d19437mr6215296a12.13.1742459270187; Thu, 20 Mar 2025
 01:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-3-pandoh@google.com>
 <79f4ddd5-af44-4fc9-9f04-4e79f66db21e@linux.intel.com>
In-Reply-To: <79f4ddd5-af44-4fc9-9f04-4e79f66db21e@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 01:27:38 -0700
X-Gm-Features: AQ5f1JoFh6H1uZb6FBakZGdKEBIVXF9PNk5z1qWOy9S_JHkFXg-lht2lEn8QXNI
Message-ID: <CAMC_AXX11GcfbOyp4HXaA_9MmzfKPyPFtA470-aCdMqC7zanVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:39=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Since the original patch from Ilpo is not yet merged, may be it
> worth considering add this change part of the same patch.

Which patch are you referring to?

Thanks,
Jon

