Return-Path: <linux-pci+bounces-25245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A099A7A994
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D601118990D5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3B253B52;
	Thu,  3 Apr 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl54rLa+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58075253B4F;
	Thu,  3 Apr 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705357; cv=none; b=BZVmvkyJU6XooCW1AybB3r5YQE7IGAfxxEasxg7G6yLLlokVOUIC2vN/T0cgdZ/kMYc2MKiYOtt+EwNWZdXZXyQ43WVMMtPiOTCGBobLD/0CK1M9t6YphAnJlySGTKdyd0yposRv8gKrOnG/di8xa/iAOjhYA0QW3IzowZhe144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705357; c=relaxed/simple;
	bh=5mbL52N0goQdYU4Zj846yxwg2l69rBb2xtHi9EfKTCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhjRDRou89qI8gVrMDz82geZcUftC8/A+cgMDLskgQw4qiDPJ0lGCSzipYu5mju6oveB0tk0Cr/1uCTZRyk1r22A4ijCbtyA2WZhmcqTAKEl6rFiN+9+kd8RHLkpI37EN3hi3j5iVHan8l30vnEZtlJ4FmQBHUIXtCYUxrDfK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl54rLa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB60C4CEEB;
	Thu,  3 Apr 2025 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743705356;
	bh=5mbL52N0goQdYU4Zj846yxwg2l69rBb2xtHi9EfKTCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gl54rLa+NLkBiwY1LOi11jhjccJnPZ+kMm8lyzRBXKYAzyuTGjRt3yWbc06DbVlIU
	 mBgFtmLF+0IeiRCMzkM3kthYJB9CWKPywJdpPyiMYYWHWUgi8nXrWtEC9yWmVCW8fA
	 g2n5ZUoCsL+GnURwI106z95UaX6+jNg4nSzy7sR7WgdQJ+S+8vWcg/cp3jvi1fIP/M
	 IkoMYFg0+V2GANFTzzCrSvSMrxKDz27WJ9KGn55sPcSfSy8eb+jt1s0WlFJCIhr+5f
	 Mjihjcf0OaY2eBvhXYWC1w1zv0kFTKhFtxtf/iRcmLVxYYBEbmGSNQK7WlxZddUOi/
	 PWrJqRXmxkO+A==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so637990b6e.3;
        Thu, 03 Apr 2025 11:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYpebwsiu6qPBINZe6bk3tEmuYB6g0jnRIIi3s0LplbTZZ7wR1RFb2s7BqGI4VTzJlmlyPvAjRm35y@vger.kernel.org, AJvYcCW6s7nc3q5yIFsS/3WkZv0fnMAR37EaFphH2iJeLqbM+Y+CDuzGWeScnFmkmaBw8Q7qAjqFob3iwLKMs0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06cwnk0VX+v5GxnmhkFg91+FhzkWgbabxg9aQIK5GXwMn77Zu
	ol7bzdskaqpF4kXWp63obZ27ljo0sLkhou3BzTWHDIj9khFTZy9+E8Go8bQLUBh4SccWxlN4nCS
	YVjcUsz8wZTHP5eZxoRgSFkVueVE=
X-Google-Smtp-Source: AGHT+IH3bR/+nQLml4F6SSNwULwxeL06S1TAo9+R8D/bN+Nw80qGyi4Xz67D+3zjMF/KFuhnpXmHlkIwmQXn+095pJA=
X-Received: by 2002:a05:6870:498a:b0:2c2:5c2b:3ae5 with SMTP id
 586e51a60fabf-2cc9e5151d7mr304229fac.3.1743705356085; Thu, 03 Apr 2025
 11:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403074425.1181053-1-raag.jadav@intel.com>
In-Reply-To: <20250403074425.1181053-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 20:35:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtUHbYPk-dFRwEZMnPv0gQG8+J+bwf8bahUskcDkw9HA@mail.gmail.com>
X-Gm-Features: AQ5f1JpEKGzULge8D50zh4FtKryRbeuMeUaQnhfHjNr9UO16hDw67V7-YqSjal4
Message-ID: <CAJZ5v0gtUHbYPk-dFRwEZMnPv0gQG8+J+bwf8bahUskcDkw9HA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI/AER: Avoid power state transition during system suspend
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, lukas.wunner@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:45=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> If an error is triggered while system suspend is in progress, any bus
> level power state transition will result in unpredictable error handling.
> Mark skip_bus_pm flag as true to avoid this.

This needs to be synchronized with the skip_bus_pm clearing in pci_pm_suspe=
nd().

Also, skip_bus_pm is only used in the _noirq phases, so if a driver
calls pci_set_power_state() from its ->suspend() callback, this change
won't help.

I think that you're aware of it, but the changelog should mention this
limitation.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>
> Ideally we'd want to defer recovery until system resume, but this is
> good enough to prevent device suspend.
>
> More discussion at [1].
> [1] https://lore.kernel.org/r/Z-38rPeN_j7YGiEl@black.fi.intel.com
>
>  drivers/pci/pcie/aer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..5acf4efc2df3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1108,6 +1108,12 @@ static void pci_aer_handle_error(struct pci_dev *d=
ev, struct aer_err_info *info)
>
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info=
 *info)
>  {
> +       /*
> +        * Avoid any power state transition if an error is triggered duri=
ng
> +        * system suspend.
> +        */
> +       dev->skip_bus_pm =3D true;
> +
>         cxl_rch_handle_error(dev, info);
>         pci_aer_handle_error(dev, info);
>         pci_dev_put(dev);
> --

